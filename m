Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD96FC28CC2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 15:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 916E425749
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 15:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbfE3PSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 11:18:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55470 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727696AbfE3PSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 11:18:20 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UFIFEA040895
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 11:18:19 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2stgu3tkxn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 11:18:17 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 30 May 2019 16:17:18 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 May 2019 16:17:13 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4UFHCMN24641552
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 15:17:12 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7FFD9B2078;
        Thu, 30 May 2019 15:17:12 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6437BB206C;
        Thu, 30 May 2019 15:17:12 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 30 May 2019 15:17:12 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id E306316C63E5; Thu, 30 May 2019 08:17:13 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 17/21] torture: Make --cpus override idleness calculations
Date:   Thu, 30 May 2019 08:17:08 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190530151650.GA422@linux.ibm.com>
References: <20190530151650.GA422@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19053015-0040-0000-0000-000004F68406
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011185; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01210791; UDB=6.00636161; IPR=6.00991826;
 MB=3.00027120; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-30 15:17:17
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19053015-0041-0000-0000-000009029E58
Message-Id: <20190530151712.1612-17-paulmck@linux.ibm.com>
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

Currently, rcutorture will use relatively few CPUs to build the kernel
on a busy system, which is often as it should be.  However, if the user
has used the --cpus argument to dedicate a specified number of CPUs to
this torture test, it would be good if the kernel build also made use
of them.  This commit therefore changes the cpus2use.sh script to use
--cpus when specified and to do the idleness calculations otherwise.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/testing/selftests/rcutorture/bin/cpus2use.sh | 5 +++++
 tools/testing/selftests/rcutorture/bin/kvm.sh      | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/bin/cpus2use.sh b/tools/testing/selftests/rcutorture/bin/cpus2use.sh
index ff7102212703..4e9485590c10 100755
--- a/tools/testing/selftests/rcutorture/bin/cpus2use.sh
+++ b/tools/testing/selftests/rcutorture/bin/cpus2use.sh
@@ -9,6 +9,11 @@
 #
 # Authors: Paul E. McKenney <paulmck@linux.ibm.com>
 
+if test -n "$TORTURE_ALLOTED_CPUS"
+then
+	echo $TORTURE_ALLOTED_CPUS
+	exit 0
+fi
 ncpus=`grep '^processor' /proc/cpuinfo | wc -l`
 idlecpus=`mpstat | tail -1 | \
 	awk -v ncpus=$ncpus '{ print ncpus * ($7 + $NF) / 100 }'`
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 8c43eb43409b..ea6289a335f2 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -24,6 +24,7 @@ dur=$((30*60))
 dryrun=""
 KVM="`pwd`/tools/testing/selftests/rcutorture"; export KVM
 PATH=${KVM}/bin:$PATH; export PATH
+TORTURE_ALLOTED_CPUS=""
 TORTURE_DEFCONFIG=defconfig
 TORTURE_BOOT_IMAGE=""
 TORTURE_INITRD="$KVM/initrd"; export TORTURE_INITRD
@@ -89,6 +90,7 @@ do
 	--cpus)
 		checkarg --cpus "(number)" "$#" "$2" '^[0-9]*$' '^--'
 		cpus=$2
+		TORTURE_ALLOTED_CPUS="$2"
 		shift
 		;;
 	--datestamp)
@@ -285,6 +287,7 @@ cat << ___EOF___ > $T/script
 CONFIGFRAG="$CONFIGFRAG"; export CONFIGFRAG
 KVM="$KVM"; export KVM
 PATH="$PATH"; export PATH
+TORTURE_ALLOTED_CPUS="$TORTURE_ALLOTED_CPUS"; export TORTURE_ALLOTED_CPUS
 TORTURE_BOOT_IMAGE="$TORTURE_BOOT_IMAGE"; export TORTURE_BOOT_IMAGE
 TORTURE_BUILDONLY="$TORTURE_BUILDONLY"; export TORTURE_BUILDONLY
 TORTURE_DEFCONFIG="$TORTURE_DEFCONFIG"; export TORTURE_DEFCONFIG
-- 
2.17.1

