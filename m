Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91EAC28CC2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 15:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC62325747
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 15:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbfE3PSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 11:18:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49590 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727679AbfE3PR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 11:17:56 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UFHoZD060154
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 11:17:54 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2stg3bvmcr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 11:17:51 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 30 May 2019 16:17:18 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 May 2019 16:17:13 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4UFHCap8060982
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 15:17:12 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8860AB207D;
        Thu, 30 May 2019 15:17:12 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 661CFB206E;
        Thu, 30 May 2019 15:17:12 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 30 May 2019 15:17:12 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id E6FB816C2D27; Thu, 30 May 2019 08:17:13 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 18/21] torture: Add --trust-make to suppress "make clean"
Date:   Thu, 30 May 2019 08:17:09 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190530151650.GA422@linux.ibm.com>
References: <20190530151650.GA422@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19053015-0064-0000-0000-000003E70FAD
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011185; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01210791; UDB=6.00636161; IPR=6.00991825;
 MB=3.00027120; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-30 15:17:17
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19053015-0065-0000-0000-00003DABA814
Message-Id: <20190530151712.1612-18-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=15 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=975 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905300108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current rcutorture scripts unconditionally do "make clean", which is
a good way of getting the needed testing done despite any imperfections in
Makefile dependency tracking.  However, this can be a bit irritating when
repeatedly running a single scenario after small changes, for example,
when debugging a problem that affects only a single scenario.  This commit
therefore adds a --trust-make argument that suppresses the "make clean".

Even when using ccache, this speeds up kernel builds by up to almost an
order of magnitude on my laptop.

Reported-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/testing/selftests/rcutorture/bin/configinit.sh  | 5 ++++-
 tools/testing/selftests/rcutorture/bin/kvm.sh         | 6 ++++++
 tools/testing/selftests/rcutorture/bin/parse-build.sh | 2 +-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/configinit.sh b/tools/testing/selftests/rcutorture/bin/configinit.sh
index bbeae6f67c36..93e80a42249a 100755
--- a/tools/testing/selftests/rcutorture/bin/configinit.sh
+++ b/tools/testing/selftests/rcutorture/bin/configinit.sh
@@ -28,7 +28,10 @@ sed -e 's/^\(CONFIG[0-9A-Z_]*\)=.*$/grep -v "^# \1" |/' < $c > $T/u.sh
 sed -e 's/^\(CONFIG[0-9A-Z_]*=\).*$/grep -v \1 |/' < $c >> $T/u.sh
 grep '^grep' < $T/u.sh > $T/upd.sh
 echo "cat - $c" >> $T/upd.sh
-make clean > $resdir/Make.clean 2>&1
+if test -z "$TORTURE_TRUST_MAKE"
+then
+	make clean > $resdir/Make.clean 2>&1
+fi
 make $TORTURE_DEFCONFIG > $resdir/Make.defconfig.out 2>&1
 mv .config .config.sav
 sh $T/upd.sh < .config.sav > .config
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index ea6289a335f2..72518580df23 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -33,6 +33,7 @@ TORTURE_KMAKE_ARG=""
 TORTURE_QEMU_MEM=512
 TORTURE_SHUTDOWN_GRACE=180
 TORTURE_SUITE=rcu
+TORTURE_TRUST_MAKE=""
 resdir=""
 configs=""
 cpus=0
@@ -63,6 +64,7 @@ usage () {
 	echo "       --qemu-cmd qemu-system-..."
 	echo "       --results absolute-pathname"
 	echo "       --torture rcu"
+	echo "       --trust-make"
 	exit 1
 }
 
@@ -175,6 +177,9 @@ do
 			jitter=0
 		fi
 		;;
+	--trust-make)
+		TORTURE_TRUST_MAKE="y"
+		;;
 	*)
 		echo Unknown argument $1
 		usage
@@ -300,6 +305,7 @@ TORTURE_QEMU_MAC="$TORTURE_QEMU_MAC"; export TORTURE_QEMU_MAC
 TORTURE_QEMU_MEM="$TORTURE_QEMU_MEM"; export TORTURE_QEMU_MEM
 TORTURE_SHUTDOWN_GRACE="$TORTURE_SHUTDOWN_GRACE"; export TORTURE_SHUTDOWN_GRACE
 TORTURE_SUITE="$TORTURE_SUITE"; export TORTURE_SUITE
+TORTURE_TRUST_MAKE="$TORTURE_TRUST_MAKE"; export TORTURE_TRUST_MAKE
 if ! test -e $resdir
 then
 	mkdir -p "$resdir" || :
diff --git a/tools/testing/selftests/rcutorture/bin/parse-build.sh b/tools/testing/selftests/rcutorture/bin/parse-build.sh
index 0701b3bf6ade..09155c15ea65 100755
--- a/tools/testing/selftests/rcutorture/bin/parse-build.sh
+++ b/tools/testing/selftests/rcutorture/bin/parse-build.sh
@@ -21,7 +21,7 @@ mkdir $T
 
 . functions.sh
 
-if grep -q CC < $F
+if grep -q CC < $F || test -n "$TORTURE_TRUST_MAKE"
 then
 	:
 else
-- 
2.17.1

