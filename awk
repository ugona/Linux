AWK Command
echo “Campstone:Solutions:Inc” | awk -F”:” ‘{print $1}’     o/p: Campstone
echo “Campstone:Solutions:Inc” | awk -F”:” ‘{print $0}’     o/p: Campstone:Solutions:Inc
-----------------------------------
Create a table in salary.txt with below content
ravi 3000
sunil 5000
Rekha 2500
Abhijit 2000
------------------------------------
$ awk 'BEGIN {total=0;count=0} {total=total+$2} END {print "Total=", total}' salary.txt
    << Total= 12500
$ awk 'BEGIN {total=0} {if($1 != "sunil") {total = total + $2;}} END {print "Total= ", total}' salary.txt
    << Total=  7500

$ awk ' BEGIN {total=0} {total = total+ $2} {print $0}END {print "Total= ",total}' salary.txt
  <<  ravi 3000
      sunil 5000
      Rekha 2500
      Abhijit 2000
      Total=  12500
$ echo "Ruchi:1000 location:hyderabad" | cut -d" " -f 2
  << location:hyderabad
$ echo "Ruchi:1000 location:hyderabad" | cut -d" " -f 2-3

$ echo 'BEGIN {total=0} {if(NR == 1 || NR == 3) {total=total+$2}} END {print total}' salary

$ awk 'BEGIN {total=0} { printf ("%s,%s\n",$1,$2); total=total+$2;} END {print total}' salary.txt
    ravi,3000
    sunil,5000
    Rekha,2500
    Abhijit,2000
    12500

$ awk 'BEGIN {total=0} { printf ("%-20s %16s\n",$1,$2); total=total+$2;} END {print"Total= " total}' salary.txt
    ravi                             3000
    sunil                            5000
    Rekha                            2500
    Abhijit                          2000
    Total= 12500
$ awk 'BEGIN {total=0; printf("%-15s" "%16s\n","Name","Salary");} {printf("%-15s %16s\n",$1,$2); total=total+$2;} END {print"Total= " total}' salary.txt
    Name                     Salary
    ravi                        3000
    sunil                       5000
    Rekha                       2500
    Abhijit                     2000
    Total= 12500
$ awk 'BEGIN {total=0; printf("%-15s" "%16s\n","Name","Salary");} {printf("%-15s %16s\n",$1,$2); total=total+$2;} END {printf("%-15s" "%16s\n"), "Total",total}' salary.txt
    Name                     Salary
    ravi                        3000
    sunil                       5000
    Rekha                       2500
    Abhijit                     2000
    Total                     12500

    =======================================

    #!/bin/bash
    while read line;
    do
            b="$(echo $line | grep ":")"
            if [ "$(echo $b |awk -F ":" '{print $1}')" == "Software" ] || [ "$(echo $b | awk -F ":" '{print $1}')" == "Software " ]
            then
                    c=$(echo $b | awk -F ":" '{print $2}' | tr -d ' ').sh
            fi
            if [ "$(echo $b | awk -F ":" '{print $1}')" == "command" ]
            then
                    d=$(echo $b | cut -d ':' -f 2-)
                    echo "#!/bin/bash" > "$c"
                    echo $d >> "$c"
            fi
            if [ "$(echo $b | awk -F ":" '{print $1}')" == "verification" ]
            then
                    e=$(echo $b | awk -F ":" '{print $2}')
                    echo $e >> "$c"
            fi
    done < li_lab.txt
    echo " "
    echo "script files created successfully. Please chack and go to the next question"
    echo " "
===================================================
#!/bin/bash
touch installed_softwares.txt
echo -e "Name\tinstalled-on\t\tverified" > installed_softwares.txt
echo "--------------------------------------" >> installed_softwares.txt
list=$(ls -1 | grep -v "file\|li\|qu\|1\|2\|in\|re")
for i in $list;
do
        #echo $i
        temp=1
        while read line;
        do
                if [ $temp == 1 ]
                then
                        echo ""
                fi
                if [ $temp == 2 ]
                then
                        $line
                        if [ $? == 0 ]
                        then
                                b=$(echo "$(echo "$i" | cut -d "." -f 1 )")
                                b="$b\t$(date +%d/%m/%Y-%H:%M:%S)"
                        else
                                b=$(echo "$(echo "$i" | cut -d "." -f 1 )")
                                b="$b\t$(date +%d/%m/%Y-%H:%M:%S)"

                        fi
                fi
                if [ $temp == 3 ]
                then
                        $line 2>/dev/null
                        if [ $? == 0 ]
                        then
                                b="$b\tYes"
                                echo -e $b
                        else
                                b="$b\tFailed"
                                echo -e $b
                        fi
                        echo -e "$b" >> installed_softwares.txt
                        temp=0
                fi
                temp=$(( temp + 1 ))
        done < $i
done

=========================================================================================
#!/bin/bash
touch installed_softwares.txt
echo -e "Name\tinstalled-on\t\tverified" > installed_softwares.txt
echo "--------------------------------------" >> installed_softwares.txt
list=$(ls -1 | grep -v "file\|li\|qu\|1\|2\|in\|re")
for i in $list;
do
        #echo $i
        temp=1
        while read line;
        do

                if [ $temp == 2 ]
                then
                        $line
                        b=$(echo "$(echo "$i" | cut -d "." -f 1 )")
                        b="$b\t$(date +%d/%m/%Y-%H:%M:%S)"
                fi
                if [ $temp == 3 ]
                then
                        $line 2>/dev/null
                        if [ $? == 0 ]
                        then
                                b="$b\tYes"
                                echo -e $b
                        else
                                b="$b\tFailed"
                                echo -e $b
                        fi
                        echo -e "$b" >> installed_softwares.txt
                        temp=0
                fi
                temp=$(( temp + 1 ))
        done < $i
done
