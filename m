Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743B7C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48CBA2084C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389753AbfHAWiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 18:38:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3014 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388221AbfHAWhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 18:37:55 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71Mb76M057729
        for <linux-kernel@vger.kernel.org>; Thu, 1 Aug 2019 18:37:54 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u488k9fr0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 18:37:54 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 1 Aug 2019 23:37:53 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 1 Aug 2019 23:37:48 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x71Mbl6b52232640
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Aug 2019 22:37:47 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D1CAB2075;
        Thu,  1 Aug 2019 22:37:47 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4DF0AB2077;
        Thu,  1 Aug 2019 22:37:47 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Aug 2019 22:37:47 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 5BBC216C9A4E; Thu,  1 Aug 2019 15:37:48 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 06/12] srcu: Avoid srcutorture security-based pointer obfuscation
Date:   Thu,  1 Aug 2019 15:37:41 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801223708.GA14862@linux.ibm.com>
References: <20190801223708.GA14862@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19080122-0060-0000-0000-0000036770D0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011535; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01240734; UDB=6.00654294; IPR=6.01022158;
 MB=3.00028000; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-01 22:37:52
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080122-0061-0000-0000-00004A62765E
Message-Id: <20190801223747.15560-6-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=994 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010238
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because pointer output is now obfuscated, and because what you really
want to know is whether or not the callback lists are empty, this commit
replaces the srcu_data structure's head callback pointer printout with
a single character that is "." is the callback list is empty or "C"
otherwise.

This is the only remaining user of rcu_segcblist_head(), so this
commit also removes this function's definition.  It also turns out that
rcu_segcblist_tail() no longer has any callers, so this commit removes
that function's definition while in the area.  They were both marked
"Interim", and their end has come.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/rcu_segcblist.h | 21 ---------------------
 kernel/rcu/srcutree.c      |  5 +++--
 2 files changed, 3 insertions(+), 23 deletions(-)

diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index 71b64648464e..822a39da0533 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -76,27 +76,6 @@ static inline bool rcu_segcblist_restempty(struct rcu_segcblist *rsclp, int seg)
 	return !*rsclp->tails[seg];
 }
 
-/*
- * Interim function to return rcu_segcblist head pointer.  Longer term, the
- * rcu_segcblist will be used more pervasively, removing the need for this
- * function.
- */
-static inline struct rcu_head *rcu_segcblist_head(struct rcu_segcblist *rsclp)
-{
-	return rsclp->head;
-}
-
-/*
- * Interim function to return rcu_segcblist head pointer.  Longer term, the
- * rcu_segcblist will be used more pervasively, removing the need for this
- * function.
- */
-static inline struct rcu_head **rcu_segcblist_tail(struct rcu_segcblist *rsclp)
-{
-	WARN_ON_ONCE(rcu_segcblist_empty(rsclp));
-	return rsclp->tails[RCU_NEXT_TAIL];
-}
-
 void rcu_segcblist_init(struct rcu_segcblist *rsclp);
 void rcu_segcblist_disable(struct rcu_segcblist *rsclp);
 bool rcu_segcblist_ready_cbs(struct rcu_segcblist *rsclp);
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index cf0e886314f2..5dffade2d7cd 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1279,8 +1279,9 @@ void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf)
 
 		c0 = l0 - u0;
 		c1 = l1 - u1;
-		pr_cont(" %d(%ld,%ld %1p)",
-			cpu, c0, c1, rcu_segcblist_head(&sdp->srcu_cblist));
+		pr_cont(" %d(%ld,%ld %c)",
+			cpu, c0, c1,
+			"C."[rcu_segcblist_empty(&sdp->srcu_cblist)]);
 		s0 += c0;
 		s1 += c1;
 	}
-- 
2.17.1

