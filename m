Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E99C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D0420811
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732324AbfCZXlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 19:41:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59808 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733042AbfCZXlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 19:41:44 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QNf6c0015101
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 19:41:43 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rfwyar0k6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 19:41:43 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Mar 2019 23:41:42 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Mar 2019 23:41:37 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2QNfabU10944582
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 23:41:36 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 109A5B2067;
        Tue, 26 Mar 2019 23:41:36 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1B07B2074;
        Tue, 26 Mar 2019 23:41:35 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Mar 2019 23:41:35 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id BDA7416C6142; Tue, 26 Mar 2019 16:41:35 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 16/21] tools/memory-model: Split runlitmus.sh out of checklitmus.sh
Date:   Tue, 26 Mar 2019 16:41:28 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190326234114.GA23843@linux.ibm.com>
References: <20190326234114.GA23843@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19032623-0052-0000-0000-000003A18933
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010820; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000282; SDB=6.01180142; UDB=6.00617578; IPR=6.00960858;
 MB=3.00026170; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-26 23:41:40
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032623-0053-0000-0000-00006048E407
Message-Id: <20190326234133.24962-16-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-26_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903260159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit prepares for adding --hw capability to github litmus-test
scripts by splitting runlitmus.sh (which simply runs the verification)
out of checklitmus.sh (which also judges the results).

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/checklitmus.sh | 57 ++-----------------
 tools/memory-model/scripts/runlitmus.sh   | 69 +++++++++++++++++++++++
 2 files changed, 73 insertions(+), 53 deletions(-)
 create mode 100755 tools/memory-model/scripts/runlitmus.sh

diff --git a/tools/memory-model/scripts/checklitmus.sh b/tools/memory-model/scripts/checklitmus.sh
index 1922a5af2c17..31a120d68a79 100755
--- a/tools/memory-model/scripts/checklitmus.sh
+++ b/tools/memory-model/scripts/checklitmus.sh
@@ -1,15 +1,8 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0+
 #
-# Run a herd7 test and invokes judgelitmus.sh to check the result against
-# a "Result:" comment within the litmus test.  It also outputs verification
-# results to a file whose name is that of the specified litmus test, but
-# with ".out" appended.
-#
-# If the --hw argument is specified, this script translates the .litmus
-# C-language file to the specified type of assembly and verifies that.
-# But in this case, litmus tests using complex synchronization (such as
-# locking, RCU, and SRCU) are cheerfully ignored.
+# Invokes runlitmus.sh and judgelitmus.sh on its arguments to run the
+# specified litmus test and pass judgment on the results.
 #
 # Usage:
 #	checklitmus.sh file.litmus
@@ -22,47 +15,5 @@
 #
 # Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
 
-litmus=$1
-if test -f "$litmus" -a -r "$litmus"
-then
-	:
-else
-	echo ' --- ' error: \"$litmus\" is not a readable file
-	exit 255
-fi
-
-if test -z "$LKMM_HW_MAP_FILE"
-then
-	# LKMM run
-	herdoptions=${LKMM_HERD_OPTIONS--conf linux-kernel.cfg}
-	echo Herd options: $herdoptions > $LKMM_DESTDIR/$litmus.out
-	/usr/bin/time $LKMM_TIMEOUT_CMD herd7 $herdoptions $litmus >> $LKMM_DESTDIR/$litmus.out 2>&1
-else
-	# Hardware run
-
-	T=/tmp/checklitmushw.sh.$$
-	trap 'rm -rf $T' 0 2
-	mkdir $T
-
-	# Generate filenames
-	catfile="`echo $LKMM_HW_MAP_FILE | tr '[A-Z]' '[a-z]'`.cat"
-	mapfile="Linux2${LKMM_HW_MAP_FILE}.map"
-	themefile="$T/${LKMM_HW_MAP_FILE}.theme"
-	herdoptions="-model $LKMM_HW_CAT_FILE"
-	hwlitmus=`echo $litmus | sed -e 's/\.litmus$/.'${LKMM_HW_MAP_FILE}'.litmus/'`
-	hwlitmusfile=`echo $hwlitmus | sed -e 's,^.*/,,'`
-
-	# Don't run on litmus tests with complex synchronization
-	if ! scripts/simpletest.sh $litmus
-	then
-		echo ' --- ' error: \"$litmus\" contains locking, RCU, or SRCU
-		exit 254
-	fi
-
-	# Generate the assembly code and run herd on it.
-	gen_theme7 -n 10 -map $mapfile -call Linux.call > $themefile
-	jingle7 -theme $themefile $litmus > $T/$hwlitmusfile 2> $T/$hwlitmusfile.jingle7.out
-	/usr/bin/time $LKMM_TIMEOUT_CMD herd7 -model $catfile $T/$hwlitmusfile > $LKMM_DESTDIR/$hwlitmus.out 2>&1
-fi
-
-scripts/judgelitmus.sh $litmus
+scripts/runlitmus.sh $1
+scripts/judgelitmus.sh $1
diff --git a/tools/memory-model/scripts/runlitmus.sh b/tools/memory-model/scripts/runlitmus.sh
new file mode 100755
index 000000000000..0ae46ab08cbd
--- /dev/null
+++ b/tools/memory-model/scripts/runlitmus.sh
@@ -0,0 +1,69 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Without the -hw argument, runs a herd7 test and outputs verification
+# results to a file whose name is that of the specified litmus test,
+# but with ".out" appended.
+#
+# If the --hw argument is specified, this script translates the .litmus
+# C-language file to the specified type of assembly and verifies that.
+# But in this case, litmus tests using complex synchronization (such as
+# locking, RCU, and SRCU) are cheerfully ignored.
+#
+# Either way, return the status of the herd command.
+#
+# Usage:
+#	runlitmus.sh file.litmus
+#
+# Run this in the directory containing the memory model, specifying the
+# pathname of the litmus test to check.  The caller is expected to have
+# properly set up the LKMM environment variables.
+#
+# Copyright IBM Corporation, 2019
+#
+# Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
+
+litmus=$1
+if test -f "$litmus" -a -r "$litmus"
+then
+	:
+else
+	echo ' --- ' error: \"$litmus\" is not a readable file
+	exit 255
+fi
+
+if test -z "$LKMM_HW_MAP_FILE"
+then
+	# LKMM run
+	herdoptions=${LKMM_HERD_OPTIONS--conf linux-kernel.cfg}
+	echo Herd options: $herdoptions > $LKMM_DESTDIR/$litmus.out
+	/usr/bin/time $LKMM_TIMEOUT_CMD herd7 $herdoptions $litmus >> $LKMM_DESTDIR/$litmus.out 2>&1
+else
+	# Hardware run
+
+	T=/tmp/checklitmushw.sh.$$
+	trap 'rm -rf $T' 0 2
+	mkdir $T
+
+	# Generate filenames
+	catfile="`echo $LKMM_HW_MAP_FILE | tr '[A-Z]' '[a-z]'`.cat"
+	mapfile="Linux2${LKMM_HW_MAP_FILE}.map"
+	themefile="$T/${LKMM_HW_MAP_FILE}.theme"
+	herdoptions="-model $LKMM_HW_CAT_FILE"
+	hwlitmus=`echo $litmus | sed -e 's/\.litmus$/.'${LKMM_HW_MAP_FILE}'.litmus/'`
+	hwlitmusfile=`echo $hwlitmus | sed -e 's,^.*/,,'`
+
+	# Don't run on litmus tests with complex synchronization
+	if ! scripts/simpletest.sh $litmus
+	then
+		echo ' --- ' error: \"$litmus\" contains locking, RCU, or SRCU
+		exit 254
+	fi
+
+	# Generate the assembly code and run herd on it.
+	gen_theme7 -n 10 -map $mapfile -call Linux.call > $themefile
+	jingle7 -theme $themefile $litmus > $T/$hwlitmusfile 2> $T/$hwlitmusfile.jingle7.out
+	/usr/bin/time $LKMM_TIMEOUT_CMD herd7 -model $catfile $T/$hwlitmusfile > $LKMM_DESTDIR/$hwlitmus.out 2>&1
+fi
+
+exit $?
-- 
2.17.1

