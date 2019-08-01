Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C96EC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 23:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F370F206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 23:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387760AbfHAXRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 19:17:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63370 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733204AbfHAXRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 19:17:16 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71NCrQP051571;
        Thu, 1 Aug 2019 19:16:38 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u475rvr2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 19:16:38 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x71NDDVl053052;
        Thu, 1 Aug 2019 19:16:37 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u475rvr22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 19:16:37 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x71NGDxH019693;
        Thu, 1 Aug 2019 23:16:36 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma02wdc.us.ibm.com with ESMTP id 2u0e85w7et-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 23:16:36 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x71NGZmV54788430
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Aug 2019 23:16:35 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD073B2065;
        Thu,  1 Aug 2019 23:16:35 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98274B2067;
        Thu,  1 Aug 2019 23:16:35 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Aug 2019 23:16:35 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 04CBF16C9A48; Thu,  1 Aug 2019 16:16:37 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 04/10] rcu/nocb: Avoid needless wakeups of no-CBs grace-period kthread
Date:   Thu,  1 Aug 2019 16:16:29 -0700
Message-Id: <20190801231636.23115-4-paulmck@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801231619.GA22610@linux.ibm.com>
References: <20190801231619.GA22610@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=15 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010245
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the code provides an extra wakeup for the no-CBs grace-period
kthread if one of its CPUs is generating excessive numbers of callbacks.
But satisfying though it is to wake something up when things are going
south, unless the thing being awakened can actually help solve the
problem, that extra wakeup does nothing but consume additional CPU time,
which is exactly what you don't want during a call_rcu() flood.

This commit therefore avoids doing anything if the corresponding
no-CBs callback kthread is going full tilt.  Otherwise, if advancing
callbacks immediately might help and if the leaf rcu_node structure's
lock is immediately available, this commit invokes a new variant of
rcu_advance_cbs() that advances callbacks only if doing so won't require
awakening the grace-period kthread (not to be confused with any of the
no-CBs grace-period kthreads).

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/tree.c        | 15 +++++++++++++++
 kernel/rcu/tree_plugin.h | 13 +++++++++----
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index fb6b80aa34f6..a6ddfae6978d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1334,6 +1334,19 @@ static bool rcu_advance_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 	return rcu_accelerate_cbs(rnp, rdp);
 }
 
+/*
+ * Move and classify callbacks, but only if doing so won't require
+ * that the RCU grace-period kthread be awakened.
+ */
+static void __maybe_unused rcu_advance_cbs_nowake(struct rcu_node *rnp,
+						  struct rcu_data *rdp)
+{
+	raw_lockdep_assert_held_rcu_node(rnp);
+	if (!rcu_seq_state(rcu_seq_current(&rnp->gp_seq)))
+		return;
+	WARN_ON_ONCE(rcu_advance_cbs(rnp, rdp));
+}
+
 /*
  * Update CPU-local rcu_data state to record the beginnings and ends of
  * grace periods.  The caller must hold the ->lock of the leaf rcu_node
@@ -2118,6 +2131,8 @@ static void rcu_do_batch(struct rcu_data *rdp)
 			      rcu_segcblist_n_lazy_cbs(&rdp->cblist),
 			      rcu_segcblist_n_cbs(&rdp->cblist), bl);
 	rcu_segcblist_extract_done_cbs(&rdp->cblist, &rcl);
+	if (offloaded)
+		rdp->qlen_last_fqs_check = rcu_segcblist_n_cbs(&rdp->cblist);
 	rcu_nocb_unlock_irqrestore(rdp, flags);
 
 	/* Invoke callbacks. */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index fa511e306f4d..bda86098ca38 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1641,10 +1641,15 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 	} else if (len > rdp->qlen_last_fqs_check + qhimark) {
 		/* ... or if many callbacks queued. */
 		rdp->qlen_last_fqs_check = len;
-		if (!irqs_disabled_flags(flags)) {
-			wake_nocb_gp(rdp, true, flags);
-			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
-					    TPS("WakeOvf"));
+		if (!rdp->nocb_cb_sleep &&
+		    rcu_segcblist_ready_cbs(&rdp->cblist)) {
+			// Already going full tilt, so don't try to rewake.
+			rcu_nocb_unlock_irqrestore(rdp, flags);
+		} else if (rcu_segcblist_pend_cbs(&rdp->cblist) &&
+			   raw_spin_trylock_rcu_node(rdp->mynode)) {
+			rcu_advance_cbs_nowake(rdp->mynode, rdp);
+			raw_spin_unlock_rcu_node(rdp->mynode);
+			rcu_nocb_unlock_irqrestore(rdp, flags);
 		} else {
 			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE_FORCE,
 					   TPS("WakeOvfIsDeferred"));
-- 
2.17.1

