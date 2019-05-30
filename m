Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD98C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 15:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B07925C15
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 15:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfE3PAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 11:00:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41176 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725934AbfE3PAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 11:00:25 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UEppt7105229
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 11:00:24 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2stgu3sw0x-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 11:00:22 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 30 May 2019 16:00:21 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 May 2019 16:00:16 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4UF0Fet41484658
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 15:00:15 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31EDFB2088;
        Thu, 30 May 2019 15:00:15 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1BAA8B2087;
        Thu, 30 May 2019 15:00:15 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 30 May 2019 15:00:15 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id DAFDB16C5D85; Thu, 30 May 2019 08:00:16 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 4/9] rcu: Set a maximum limit for back-to-back callback invocation
Date:   Thu, 30 May 2019 08:00:10 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190530145942.GA30318@linux.ibm.com>
References: <20190530145942.GA30318@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19053015-0060-0000-0000-00000349F6A6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011185; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01210785; UDB=6.00636158; IPR=6.00991820;
 MB=3.00027120; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-30 15:00:20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19053015-0061-0000-0000-0000498DF85E
Message-Id: <20190530150015.30995-4-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905300106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, if a CPU has more than 10,000 callbacks pending, it will
increase rdp->blimit to LONG_MAX.  If you are lucky, LONG_MAX is only
about two billion, but this is still a bit too many callbacks to invoke
back-to-back while otherwise ignoring the world.

This commit therefore sets a maximum limit of DEFAULT_MAX_RCU_BLIMIT,
which is set to 10,000, for rdp->blimit.

Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/tree.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 980ca3ca643f..f888a76673da 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -380,7 +380,8 @@ static int rcu_is_cpu_rrupt_from_idle(void)
 	       __this_cpu_read(rcu_data.dynticks_nmi_nesting) <= 1;
 }
 
-#define DEFAULT_RCU_BLIMIT 10     /* Maximum callbacks per rcu_do_batch. */
+#define DEFAULT_RCU_BLIMIT 10     /* Maximum callbacks per rcu_do_batch ... */
+#define DEFAULT_MAX_RCU_BLIMIT 10000 /* ... even during callback flood. */
 static long blimit = DEFAULT_RCU_BLIMIT;
 #define DEFAULT_RCU_QHIMARK 10000 /* If this many pending, ignore blimit. */
 static long qhimark = DEFAULT_RCU_QHIMARK;
@@ -2113,7 +2114,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 
 	/* Reinstate batch limit if we have worked down the excess. */
 	count = rcu_segcblist_n_cbs(&rdp->cblist);
-	if (rdp->blimit == LONG_MAX && count <= qlowmark)
+	if (rdp->blimit >= DEFAULT_MAX_RCU_BLIMIT && count <= qlowmark)
 		rdp->blimit = blimit;
 
 	/* Reset ->qlen_last_fqs_check trigger if enough CBs have drained. */
@@ -2354,7 +2355,7 @@ static void __call_rcu_core(struct rcu_data *rdp, struct rcu_head *head,
 			rcu_accelerate_cbs_unlocked(rdp->mynode, rdp);
 		} else {
 			/* Give the grace period a kick. */
-			rdp->blimit = LONG_MAX;
+			rdp->blimit = DEFAULT_MAX_RCU_BLIMIT;
 			if (rcu_state.n_force_qs == rdp->n_force_qs_snap &&
 			    rcu_segcblist_first_pend_cb(&rdp->cblist) != head)
 				rcu_force_quiescent_state();
-- 
2.17.1

