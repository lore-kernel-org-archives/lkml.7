Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4C3C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 15:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC88225CC6
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 15:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbfE3PTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 11:19:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44388 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726694AbfE3PTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 11:19:34 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UFIFu6040926;
        Thu, 30 May 2019 11:18:48 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2stgu3tmyw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 May 2019 11:18:46 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x4UFIP2x042125;
        Thu, 30 May 2019 11:18:25 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2stgu3tkv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 May 2019 11:18:25 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x4UDFQ3B006878;
        Thu, 30 May 2019 13:17:27 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma01dal.us.ibm.com with ESMTP id 2spwb96tkq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 May 2019 13:17:27 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4UFHCtj31981758
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 15:17:12 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87741B2066;
        Thu, 30 May 2019 15:17:12 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 64362B2068;
        Thu, 30 May 2019 15:17:12 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 30 May 2019 15:17:12 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id DDF1B16C5DC5; Thu, 30 May 2019 08:17:13 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 16/21] torture: Run kernel build in source directory
Date:   Thu, 30 May 2019 08:17:07 -0700
Message-Id: <20190530151712.1612-16-paulmck@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190530151650.GA422@linux.ibm.com>
References: <20190530151650.GA422@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=15 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905300108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For historical reasons, rcutorture places its build products in a
tools/testing/selftests/rcutorture/b1 directory using the O= kbuild
command-line argument.  However, doing this requires that the source
directory be pristine: Not just "make clean" pristine, but instead "make
mrproper" (or, equivalently, "make distclean") pristine.  Therefore,
rcutorture executes a "make mrproper" before each build.  Unfortunately,
"make mrproper" has the side effect of removing pretty much everything,
including tags files and cscope databases, which can be inconvenient
to people whose workflow centers around a single source tree.

This commit therefore makes rcutorture do the build directly in the
source directory, removing the need for "make mrproper".  This works
because all needed build products are moved to their proper place in the
"res" directory immediately after the build completes, so that multiple
rcutorture kernels can still run concurrently.

Reported-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 .../selftests/rcutorture/bin/configinit.sh    | 36 +++++--------------
 .../selftests/rcutorture/bin/kvm-build.sh     |  9 +++--
 .../rcutorture/bin/kvm-test-1-run.sh          | 21 +++++------
 tools/testing/selftests/rcutorture/bin/kvm.sh |  3 +-
 4 files changed, 22 insertions(+), 47 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/configinit.sh b/tools/testing/selftests/rcutorture/bin/configinit.sh
index 40359486b3a8..bbeae6f67c36 100755
--- a/tools/testing/selftests/rcutorture/bin/configinit.sh
+++ b/tools/testing/selftests/rcutorture/bin/configinit.sh
@@ -1,7 +1,7 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0+
 #
-# Usage: configinit.sh config-spec-file build-output-dir results-dir
+# Usage: configinit.sh config-spec-file results-dir
 #
 # Create a .config file from the spec file.  Run from the kernel source tree.
 # Exits with 0 if all went well, with 1 if all went well but the config
@@ -11,10 +11,6 @@
 # desired settings, for example, "CONFIG_NO_HZ=y".  For best results,
 # this should be a full pathname.
 #
-# The second argument is a optional path to a build output directory,
-# for example, "O=/tmp/foo".  If this argument is omitted, the .config
-# file will be generated directly in the current directory.
-#
 # Copyright (C) IBM Corporation, 2013
 #
 # Authors: Paul E. McKenney <paulmck@linux.ibm.com>
@@ -26,34 +22,20 @@ mkdir $T
 # Capture config spec file.
 
 c=$1
-buildloc=$2
-resdir=$3
-builddir=
-if echo $buildloc | grep -q '^O='
-then
-	builddir=`echo $buildloc | sed -e 's/^O=//'`
-	if test ! -d $builddir
-	then
-		mkdir $builddir
-	fi
-else
-	echo Bad build directory: \"$buildloc\"
-	exit 2
-fi
+resdir=$2
 
 sed -e 's/^\(CONFIG[0-9A-Z_]*\)=.*$/grep -v "^# \1" |/' < $c > $T/u.sh
 sed -e 's/^\(CONFIG[0-9A-Z_]*=\).*$/grep -v \1 |/' < $c >> $T/u.sh
 grep '^grep' < $T/u.sh > $T/upd.sh
 echo "cat - $c" >> $T/upd.sh
-make mrproper
-make $buildloc distclean > $resdir/Make.distclean 2>&1
-make $buildloc $TORTURE_DEFCONFIG > $resdir/Make.defconfig.out 2>&1
-mv $builddir/.config $builddir/.config.sav
-sh $T/upd.sh < $builddir/.config.sav > $builddir/.config
-cp $builddir/.config $builddir/.config.new
-yes '' | make $buildloc oldconfig > $resdir/Make.oldconfig.out 2> $resdir/Make.oldconfig.err
+make clean > $resdir/Make.clean 2>&1
+make $TORTURE_DEFCONFIG > $resdir/Make.defconfig.out 2>&1
+mv .config .config.sav
+sh $T/upd.sh < .config.sav > .config
+cp .config .config.new
+yes '' | make oldconfig > $resdir/Make.oldconfig.out 2> $resdir/Make.oldconfig.err
 
 # verify new config matches specification.
-configcheck.sh $builddir/.config $c
+configcheck.sh .config $c
 
 exit 0
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-build.sh b/tools/testing/selftests/rcutorture/bin/kvm-build.sh
index c27a0bbb9c02..18d6518504ee 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-build.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-build.sh
@@ -3,7 +3,7 @@
 #
 # Build a kvm-ready Linux kernel from the tree in the current directory.
 #
-# Usage: kvm-build.sh config-template build-dir resdir
+# Usage: kvm-build.sh config-template resdir
 #
 # Copyright (C) IBM Corporation, 2011
 #
@@ -15,8 +15,7 @@ then
 	echo "kvm-build.sh :$config_template: Not a readable file"
 	exit 1
 fi
-builddir=${2}
-resdir=${3}
+resdir=${2}
 
 T=${TMPDIR-/tmp}/test-linux.sh.$$
 trap 'rm -rf $T' 0
@@ -29,14 +28,14 @@ CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_CONSOLE=y
 ___EOF___
 
-configinit.sh $T/config O=$builddir $resdir
+configinit.sh $T/config $resdir
 retval=$?
 if test $retval -gt 1
 then
 	exit 2
 fi
 ncpus=`cpus2use.sh`
-make O=$builddir -j$ncpus $TORTURE_KMAKE_ARG > $resdir/Make.out 2>&1
+make -j$ncpus $TORTURE_KMAKE_ARG > $resdir/Make.out 2>&1
 retval=$?
 if test $retval -ne 0 || grep "rcu[^/]*": < $resdir/Make.out | egrep -q "Stop|Error|error:|warning:" || egrep -q "Stop|Error|error:" < $resdir/Make.out
 then
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index 003511494fd9..27b7b5693ede 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -36,11 +36,6 @@ config_template=${1}
 config_dir=`echo $config_template | sed -e 's,/[^/]*$,,'`
 title=`echo $config_template | sed -e 's/^.*\///'`
 builddir=${2}
-if test -z "$builddir" -o ! -d "$builddir" -o ! -w "$builddir"
-then
-	echo "kvm-test-1-run.sh :$builddir: Not a writable directory, cannot build into it"
-	exit 1
-fi
 resdir=${3}
 if test -z "$resdir" -o ! -d "$resdir" -o ! -w "$resdir"
 then
@@ -85,18 +80,18 @@ then
 	ln -s $base_resdir/.config $resdir  # for kvm-recheck.sh
 	# Arch-independent indicator
 	touch $resdir/builtkernel
-elif kvm-build.sh $T/Kc2 $builddir $resdir
+elif kvm-build.sh $T/Kc2 $resdir
 then
 	# Had to build a kernel for this test.
-	QEMU="`identify_qemu $builddir/vmlinux`"
+	QEMU="`identify_qemu vmlinux`"
 	BOOT_IMAGE="`identify_boot_image $QEMU`"
-	cp $builddir/vmlinux $resdir
-	cp $builddir/.config $resdir
-	cp $builddir/Module.symvers $resdir > /dev/null || :
-	cp $builddir/System.map $resdir > /dev/null || :
+	cp vmlinux $resdir
+	cp .config $resdir
+	cp Module.symvers $resdir > /dev/null || :
+	cp System.map $resdir > /dev/null || :
 	if test -n "$BOOT_IMAGE"
 	then
-		cp $builddir/$BOOT_IMAGE $resdir
+		cp $BOOT_IMAGE $resdir
 		KERNEL=$resdir/${BOOT_IMAGE##*/}
 		# Arch-independent indicator
 		touch $resdir/builtkernel
@@ -107,7 +102,7 @@ then
 	parse-build.sh $resdir/Make.out $title
 else
 	# Build failed.
-	cp $builddir/.config $resdir || :
+	cp .config $resdir || :
 	echo Build failed, not running KVM, see $resdir.
 	if test -f $builddir.wait
 	then
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 3b4868906794..8c43eb43409b 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -342,7 +342,7 @@ function dump(first, pastlast, batchnum)
 	print "needqemurun="
 	jn=1
 	for (j = first; j < pastlast; j++) {
-		builddir=KVM "/b1"
+		builddir=KVM "/b" j - first + 1
 		cpusr[jn] = cpus[j];
 		if (cfrep[cf[j]] == "") {
 			cfr[jn] = cf[j];
@@ -358,7 +358,6 @@ function dump(first, pastlast, batchnum)
 		print "echo ", cfr[jn], cpusr[jn] ovf ": Starting build. `date` | tee -a " rd "log";
 		print "rm -f " builddir ".*";
 		print "touch " builddir ".wait";
-		print "mkdir " builddir " > /dev/null 2>&1 || :";
 		print "mkdir " rd cfr[jn] " || :";
 		print "kvm-test-1-run.sh " CONFIGDIR cf[j], builddir, rd cfr[jn], dur " \"" TORTURE_QEMU_ARG "\" \"" TORTURE_BOOTARGS "\" > " rd cfr[jn]  "/kvm-test-1-run.sh.out 2>&1 &"
 		print "echo ", cfr[jn], cpusr[jn] ovf ": Waiting for build to complete. `date` | tee -a " rd "log";
-- 
2.17.1

