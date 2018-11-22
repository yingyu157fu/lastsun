#!/bin/bash
DATE=$(date +%F%X)
USER_FILE=user.txt
function passwd(){
a=({0..9} {a..z})
for i in {0..9}
	do
		num=$[$RANDOM%36]
		echo -ne "${a[$num]}"
	done
}



if [ -s $USER_FILE ];then
	mv $USER_FILE ${USER_FILE}-${DATE}.bak
	echo "$USER_FILE is exist,make bak name ${USER_FILE}-${DATE}.bak"
fi
echo -e "USER\tPassword"
echo "------------------"
for USER in user{1..10};do
	if ! id $USER &> /dev/null;then
		PASS=`passwd`
		useradd $USER
		echo $PASS |passwd --stdin $USER &> /dev/null
		echo -e "$USER\t$PASS" >> $USER_FILE
		echo "$USER user create successful."
	else
		echo "$USER is exist!"
	fi
done
