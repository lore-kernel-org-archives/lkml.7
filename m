Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6BAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E4E12075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732362AbfCZXmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 19:42:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59684 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733002AbfCZXln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 19:41:43 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QNfBSd015201
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 19:41:42 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rfwyar0jk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 19:41:42 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Mar 2019 23:41:40 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Mar 2019 23:41:35 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2QNfYYr24444984
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 23:41:35 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DBBF1B206C;
        Tue, 26 Mar 2019 23:41:34 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD7AAB206A;
        Tue, 26 Mar 2019 23:41:34 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Mar 2019 23:41:34 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 9A1AE16C611D; Tue, 26 Mar 2019 16:41:35 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 10/21] tools/memory-model: Update parseargs.sh for hardware verification
Date:   Tue, 26 Mar 2019 16:41:22 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190326234114.GA23843@linux.ibm.com>
References: <20190326234114.GA23843@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19032623-0060-0000-0000-000003227578
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010820; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000282; SDB=6.01180142; UDB=6.00617577; IPR=6.00960858;
 MB=3.00026170; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-26 23:41:39
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032623-0061-0000-0000-000048BCDA67
Message-Id: <20190326234133.24962-10-paulmck@linux.ibm.com>
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

This commit adds a --hw argument to parseargs.sh to specify the CPU
family for a hardware verification.  For example, "--hw AArch64" will
specify that a C-language litmus test is to be translated to ARMv8 and
the result verified.  This will set the LKMM_HW_MAP_FILE environment
variable accordingly.  If there is no --hw argument, this environment
variable will be set to the empty string.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/parseargs.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/memory-model/scripts/parseargs.sh b/tools/memory-model/scripts/parseargs.sh
index 40f52080fdbd..0dd087a8410e 100755
--- a/tools/memory-model/scripts/parseargs.sh
+++ b/tools/memory-model/scripts/parseargs.sh
@@ -27,6 +27,7 @@ initparam () {
 
 initparam LKMM_DESTDIR "."
 initparam LKMM_HERD_OPTIONS "-conf linux-kernel.cfg"
+initparam LKMM_HW_MAP_FILE ""
 initparam LKMM_JOBS `getconf _NPROCESSORS_ONLN`
 initparam LKMM_PROCS "3"
 initparam LKMM_TIMEOUT "1m"
@@ -37,10 +38,11 @@ usagehelp () {
 	echo "Usage $scriptname [ arguments ]"
 	echo "      --destdir path (place for .litmus.out, default by .litmus)"
 	echo "      --herdopts -conf linux-kernel.cfg ..."
+	echo "      --hw AArch64"
 	echo "      --jobs N (number of jobs, default one per CPU)"
 	echo "      --procs N (litmus tests with at most this many processes)"
 	echo "      --timeout N (herd7 timeout (e.g., 10s, 1m, 2hr, 1d, '')"
-	echo "Defaults: --destdir '$LKMM_DESTDIR_DEF' --herdopts '$LKMM_HERD_OPTIONS_DEF' --jobs '$LKMM_JOBS_DEF' --procs '$LKMM_PROCS_DEF' --timeout '$LKMM_TIMEOUT_DEF'"
+	echo "Defaults: --destdir '$LKMM_DESTDIR_DEF' --herdopts '$LKMM_HERD_OPTIONS_DEF' --hw '$LKMM_HW_MAP_FILE' --jobs '$LKMM_JOBS_DEF' --procs '$LKMM_PROCS_DEF' --timeout '$LKMM_TIMEOUT_DEF'"
 	exit 1
 }
 
@@ -95,6 +97,11 @@ do
 		LKMM_HERD_OPTIONS="$2"
 		shift
 		;;
+	--hw)
+		checkarg --hw "(.map file architecture name)" "$#" "$2" '^[A-Za-z0-9_-]\+' '^--'
+		LKMM_HW_MAP_FILE="$2"
+		shift
+		;;
 	-j[1-9]*)
 		njobs="`echo $1 | sed -e 's/^-j//'`"
 		trailchars="`echo $njobs | sed -e 's/[0-9]\+\(.*\)$/\1/'`"
-- 
2.17.1

