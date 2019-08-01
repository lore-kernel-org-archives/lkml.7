Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C21C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD186206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733013AbfHAWXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 18:23:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14578 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389452AbfHAWVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 18:21:05 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71MGudt085078
        for <linux-kernel@vger.kernel.org>; Thu, 1 Aug 2019 18:21:04 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u477yk8yh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 18:21:04 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 1 Aug 2019 23:21:03 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 1 Aug 2019 23:20:59 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x71MKwKX47972718
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Aug 2019 22:20:58 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 14F86B2073;
        Thu,  1 Aug 2019 22:20:58 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00D3AB2077;
        Thu,  1 Aug 2019 22:20:58 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Aug 2019 22:20:57 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 1520316C9A4E; Thu,  1 Aug 2019 15:20:59 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC memory-model 28/31] tools/memory-model: Make judgelitmus.sh handle scripted Result: tag
Date:   Thu,  1 Aug 2019 15:20:53 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801222026.GA11315@linux.ibm.com>
References: <20190801222026.GA11315@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19080122-0052-0000-0000-000003E77471
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011535; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01240728; UDB=6.00654291; IPR=6.01022152;
 MB=3.00028000; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-01 22:21:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080122-0053-0000-0000-000061EE6D7D
Message-Id: <20190801222056.12144-28-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=773 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010234
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The scripts that generate the litmus tests in the "auto" directory of
the https://github.com/paulmckrcu/litmus archive place the "Result:"
tag into a single-line ocaml comment, which judgelitmus.sh currently
does not recognize.  This commit therefore makes judgelitmus.sh
recognize both the multiline comment format that it currently does
and the automatically generated single-line format.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/judgelitmus.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/memory-model/scripts/judgelitmus.sh b/tools/memory-model/scripts/judgelitmus.sh
index eaa2cc7d3b36..6408c012bdf5 100755
--- a/tools/memory-model/scripts/judgelitmus.sh
+++ b/tools/memory-model/scripts/judgelitmus.sh
@@ -51,10 +51,10 @@ if grep -q '^Flag data-race$' "$LKMM_DESTDIR/$litmusout"
 then
 	datarace_modeled=1
 fi
-if grep -q '^ \* Result: ' $litmus
+if grep -q '^[( ]\* Result: ' $litmus
 then
-	outcome=`grep -m 1 '^ \* Result: ' $litmus | awk '{ print $3 }'`
-	if grep -m1 '^ \* Result: .* DATARACE' $litmus
+	outcome=`grep -m 1 '^[( ]\* Result: ' $litmus | awk '{ print $3 }'`
+	if grep -m1 '^[( ]\* Result: .* DATARACE' $litmus
 	then
 		datarace_predicted=1
 	fi
-- 
2.17.1

