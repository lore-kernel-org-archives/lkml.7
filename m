Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA53C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69842087E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733205AbfCZXm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 19:42:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50150 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730333AbfCZXln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 19:41:43 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QNXWqD123415
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 19:41:41 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rftk1qmq7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 19:41:41 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Mar 2019 23:41:40 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Mar 2019 23:41:37 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2QNfaMu18284570
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 23:41:36 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 03B87B2065;
        Tue, 26 Mar 2019 23:41:36 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5409B2076;
        Tue, 26 Mar 2019 23:41:35 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Mar 2019 23:41:35 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id D9A2A16C623D; Tue, 26 Mar 2019 16:41:35 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 20/21] tools/memory-model: Allow herd to deduce CPU type
Date:   Tue, 26 Mar 2019 16:41:32 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190326234114.GA23843@linux.ibm.com>
References: <20190326234114.GA23843@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19032623-0060-0000-0000-000003227579
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010820; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000282; SDB=6.01180142; UDB=6.00617577; IPR=6.00960858;
 MB=3.00026170; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-26 23:41:40
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032623-0061-0000-0000-000048BCDA6C
Message-Id: <20190326234133.24962-20-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-26_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=953 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903260159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the scripts specify the CPU's .cat file to herd.  But this is
pointless because herd will select a good and sufficient .cat file from
the assembly-language litmus test itself.  This commit therefore removes
the -model argument to herd, allowing herd to figure the CPU family out
itself.

Note that the user can override herd's choice using the "--herdopts"
argument to the scripts.

Suggested-by: Luc Maranget <luc.maranget@inria.fr>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/runlitmus.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/memory-model/scripts/runlitmus.sh b/tools/memory-model/scripts/runlitmus.sh
index 71d13bb0c764..482ed7a08951 100755
--- a/tools/memory-model/scripts/runlitmus.sh
+++ b/tools/memory-model/scripts/runlitmus.sh
@@ -53,7 +53,6 @@ trap 'rm -rf $T' 0 2
 mkdir $T
 
 # Generate filenames
-catfile="`echo $LKMM_HW_MAP_FILE | tr '[A-Z]' '[a-z]'`.cat"
 mapfile="Linux2${LKMM_HW_MAP_FILE}.map"
 themefile="$T/${LKMM_HW_MAP_FILE}.theme"
 herdoptions="-model $LKMM_HW_CAT_FILE"
@@ -70,6 +69,6 @@ fi
 # Generate the assembly code and run herd on it.
 gen_theme7 -n 10 -map $mapfile -call Linux.call > $themefile
 jingle7 -theme $themefile $litmus > $LKMM_DESTDIR/$hwlitmus 2> $T/$hwlitmusfile.jingle7.out
-/usr/bin/time $LKMM_TIMEOUT_CMD herd7 -model $catfile $LKMM_DESTDIR/$hwlitmus > $LKMM_DESTDIR/$hwlitmus.out 2>&1
+/usr/bin/time $LKMM_TIMEOUT_CMD herd7 $LKMM_DESTDIR/$hwlitmus > $LKMM_DESTDIR/$hwlitmus.out 2>&1
 
 exit $?
-- 
2.17.1

