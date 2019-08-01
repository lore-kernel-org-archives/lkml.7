Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047C8C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 23:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC396206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 23:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390387AbfHAXJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 19:09:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60038 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390351AbfHAXJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 19:09:01 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71N7Bj0040048;
        Thu, 1 Aug 2019 19:08:14 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u475rvh49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 19:08:14 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x71N8Dem043022;
        Thu, 1 Aug 2019 19:08:13 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u475rvh3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 19:08:13 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x71N51xa001981;
        Thu, 1 Aug 2019 23:08:12 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma03wdc.us.ibm.com with ESMTP id 2u0e85w6nk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 23:08:12 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x71N8Bod18678162
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Aug 2019 23:08:11 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C066B2065;
        Thu,  1 Aug 2019 23:08:11 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 277C9B206A;
        Thu,  1 Aug 2019 23:08:11 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Aug 2019 23:08:11 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 4872416C9A51; Thu,  1 Aug 2019 16:08:12 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 10/18] rcu/nocb: Use rcu_segcblist for no-CBs CPUs
Date:   Thu,  1 Aug 2019 16:08:02 -0700
Message-Id: <20190801230810.21570-10-paulmck@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801230744.GA19115@linux.ibm.com>
References: <20190801230744.GA19115@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=15 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010244
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the RCU callbacks for no-CBs CPUs are queued on a series of
ad-hoc linked lists, which means that these callbacks cannot benefit
from "drive-by" grace periods, thus suffering needless delays prior
to invocation.  In addition, the no-CBs grace-period kthreads first
wait for callbacks to appear and later wait for a new grace period,
which means that callbacks appearing during a grace-period wait can
be delayed.  These delays increase memory footprint, and could even
result in an out-of-memory condition.

This commit therefore enqueues RCU callbacks from no-CBs CPUs on the
rcu_segcblist structure that is already used by non-no-CBs CPUs.  It also
restructures the no-CBs grace-period kthread to be checking for incoming
callbacks while waiting for grace periods.  Also, instead of waiting
for a new grace period, it waits for the closest grace period that will
cause some of the callbacks to be safe to invoke.  All of these changes
reduce callback latency and thus the number of outstanding callbacks,
in turn reducing the probability of an out-of-memory condition.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 include/trace/events/rcu.h |   1 -
 kernel/rcu/rcu_segcblist.c |  12 +
 kernel/rcu/rcu_segcblist.h |   1 +
 kernel/rcu/tree.c          | 116 +++++----
 kernel/rcu/tree.h          |  14 +-
 kernel/rcu/tree_plugin.h   | 510 ++++++++++++++-----------------------
 6 files changed, 270 insertions(+), 384 deletions(-)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 313324d1b135..694bd040cf51 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -100,7 +100,6 @@ TRACE_EVENT_RCU(rcu_grace_period,
  * "Startedroot": Requested a nocb grace period based on root-node data.
  * "NoGPkthread": The RCU grace-period kthread has not yet started.
  * "StartWait": Start waiting for the requested grace period.
- * "ResumeWait": Resume waiting after signal.
  * "EndWait": Complete wait.
  * "Cleanup": Clean up rcu_node structure after previous GP.
  * "CleanupMore": Clean up, and another GP is needed.
diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 9ac28f175627..92968b856593 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -127,6 +127,18 @@ struct rcu_head *rcu_segcblist_first_pend_cb(struct rcu_segcblist *rsclp)
 	return NULL;
 }
 
+/*
+ * Return false if there are no CBs awaiting grace periods, otherwise,
+ * return true and store the nearest waited-upon grace period into *lp.
+ */
+bool rcu_segcblist_nextgp(struct rcu_segcblist *rsclp, unsigned long *lp)
+{
+	if (!rcu_segcblist_pend_cbs(rsclp))
+		return false;
+	*lp = rsclp->gp_seq[RCU_WAIT_TAIL];
+	return true;
+}
+
 /*
  * Enqueue the specified callback onto the specified rcu_segcblist
  * structure, updating accounting as needed.  Note that the ->len
diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index ed3fcece39a9..db38f0a512c4 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -89,6 +89,7 @@ bool rcu_segcblist_ready_cbs(struct rcu_segcblist *rsclp);
 bool rcu_segcblist_pend_cbs(struct rcu_segcblist *rsclp);
 struct rcu_head *rcu_segcblist_first_cb(struct rcu_segcblist *rsclp);
 struct rcu_head *rcu_segcblist_first_pend_cb(struct rcu_segcblist *rsclp);
+bool rcu_segcblist_nextgp(struct rcu_segcblist *rsclp, unsigned long *lp);
 void rcu_segcblist_enqueue(struct rcu_segcblist *rsclp,
 			   struct rcu_head *rhp, bool lazy);
 bool rcu_segcblist_entrain(struct rcu_segcblist *rsclp,
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 2917ce379b23..054418d2d960 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1343,8 +1343,10 @@ static bool rcu_advance_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
  */
 static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 {
-	bool ret;
+	bool ret = false;
 	bool need_gp;
+	const bool offloaded = IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
+			       rcu_segcblist_is_offloaded(&rdp->cblist);
 
 	raw_lockdep_assert_held_rcu_node(rnp);
 
@@ -1354,10 +1356,12 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 	/* Handle the ends of any preceding grace periods first. */
 	if (rcu_seq_completed_gp(rdp->gp_seq, rnp->gp_seq) ||
 	    unlikely(READ_ONCE(rdp->gpwrap))) {
-		ret = rcu_advance_cbs(rnp, rdp); /* Advance callbacks. */
+		if (!offloaded)
+			ret = rcu_advance_cbs(rnp, rdp); /* Advance CBs. */
 		trace_rcu_grace_period(rcu_state.name, rdp->gp_seq, TPS("cpuend"));
 	} else {
-		ret = rcu_accelerate_cbs(rnp, rdp); /* Recent callbacks. */
+		if (!offloaded)
+			ret = rcu_accelerate_cbs(rnp, rdp); /* Recent CBs. */
 	}
 
 	/* Now handle the beginnings of any new-to-this-CPU grace periods. */
@@ -1658,6 +1662,7 @@ static void rcu_gp_cleanup(void)
 	unsigned long gp_duration;
 	bool needgp = false;
 	unsigned long new_gp_seq;
+	bool offloaded;
 	struct rcu_data *rdp;
 	struct rcu_node *rnp = rcu_get_root();
 	struct swait_queue_head *sq;
@@ -1723,7 +1728,9 @@ static void rcu_gp_cleanup(void)
 		needgp = true;
 	}
 	/* Advance CBs to reduce false positives below. */
-	if (!rcu_accelerate_cbs(rnp, rdp) && needgp) {
+	offloaded = IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
+		    rcu_segcblist_is_offloaded(&rdp->cblist);
+	if ((offloaded || !rcu_accelerate_cbs(rnp, rdp)) && needgp) {
 		WRITE_ONCE(rcu_state.gp_flags, RCU_GP_FLAG_INIT);
 		rcu_state.gp_req_activity = jiffies;
 		trace_rcu_grace_period(rcu_state.name,
@@ -1917,7 +1924,9 @@ rcu_report_qs_rdp(int cpu, struct rcu_data *rdp)
 {
 	unsigned long flags;
 	unsigned long mask;
-	bool needwake;
+	bool needwake = false;
+	const bool offloaded = IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
+			       rcu_segcblist_is_offloaded(&rdp->cblist);
 	struct rcu_node *rnp;
 
 	rnp = rdp->mynode;
@@ -1944,7 +1953,8 @@ rcu_report_qs_rdp(int cpu, struct rcu_data *rdp)
 		 * This GP can't end until cpu checks in, so all of our
 		 * callbacks can be processed during the next GP.
 		 */
-		needwake = rcu_accelerate_cbs(rnp, rdp);
+		if (!offloaded)
+			needwake = rcu_accelerate_cbs(rnp, rdp);
 
 		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
 		/* ^^^ Released rnp->lock */
@@ -2082,7 +2092,6 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	struct rcu_cblist rcl = RCU_CBLIST_INITIALIZER(rcl);
 	long bl, count;
 
-	WARN_ON_ONCE(rdp->cblist.offloaded);
 	/* If no callbacks are ready, just return. */
 	if (!rcu_segcblist_ready_cbs(&rdp->cblist)) {
 		trace_rcu_batch_start(rcu_state.name,
@@ -2101,13 +2110,14 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	 * callback counts, as rcu_barrier() needs to be conservative.
 	 */
 	local_irq_save(flags);
+	rcu_nocb_lock(rdp);
 	WARN_ON_ONCE(cpu_is_offline(smp_processor_id()));
 	bl = rdp->blimit;
 	trace_rcu_batch_start(rcu_state.name,
 			      rcu_segcblist_n_lazy_cbs(&rdp->cblist),
 			      rcu_segcblist_n_cbs(&rdp->cblist), bl);
 	rcu_segcblist_extract_done_cbs(&rdp->cblist, &rcl);
-	local_irq_restore(flags);
+	rcu_nocb_unlock_irqrestore(rdp, flags);
 
 	/* Invoke callbacks. */
 	rhp = rcu_cblist_dequeue(&rcl);
@@ -2120,12 +2130,22 @@ static void rcu_do_batch(struct rcu_data *rdp)
 		 * Note: The rcl structure counts down from zero.
 		 */
 		if (-rcl.len >= bl &&
+		    !rcu_segcblist_is_offloaded(&rdp->cblist) &&
 		    (need_resched() ||
 		     (!is_idle_task(current) && !rcu_is_callbacks_kthread())))
 			break;
+		if (rcu_segcblist_is_offloaded(&rdp->cblist)) {
+			WARN_ON_ONCE(in_serving_softirq());
+			local_bh_enable();
+			lockdep_assert_irqs_enabled();
+			cond_resched_tasks_rcu_qs();
+			lockdep_assert_irqs_enabled();
+			local_bh_disable();
+		}
 	}
 
 	local_irq_save(flags);
+	rcu_nocb_lock(rdp);
 	count = -rcl.len;
 	trace_rcu_batch_end(rcu_state.name, count, !!rcl.head, need_resched(),
 			    is_idle_task(current), rcu_is_callbacks_kthread());
@@ -2153,10 +2173,11 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	 */
 	WARN_ON_ONCE(rcu_segcblist_empty(&rdp->cblist) != (count == 0));
 
-	local_irq_restore(flags);
+	rcu_nocb_unlock_irqrestore(rdp, flags);
 
 	/* Re-invoke RCU core processing if there are callbacks remaining. */
-	if (rcu_segcblist_ready_cbs(&rdp->cblist))
+	if (!rcu_segcblist_is_offloaded(&rdp->cblist) &&
+	    rcu_segcblist_ready_cbs(&rdp->cblist))
 		invoke_rcu_core();
 }
 
@@ -2312,7 +2333,8 @@ static __latent_entropy void rcu_core(void)
 	rcu_check_gp_start_stall(rnp, rdp, rcu_jiffies_till_stall_check());
 
 	/* If there are callbacks ready, invoke them. */
-	if (rcu_segcblist_ready_cbs(&rdp->cblist) &&
+	if (!rcu_segcblist_is_offloaded(&rdp->cblist) &&
+	    rcu_segcblist_ready_cbs(&rdp->cblist) &&
 	    likely(READ_ONCE(rcu_scheduler_fully_active)))
 		rcu_do_batch(rdp);
 
@@ -2492,10 +2514,11 @@ static void rcu_leak_callback(struct rcu_head *rhp)
  * is expected to specify a CPU.
  */
 static void
-__call_rcu(struct rcu_head *head, rcu_callback_t func, int cpu, bool lazy)
+__call_rcu(struct rcu_head *head, rcu_callback_t func, bool lazy)
 {
 	unsigned long flags;
 	struct rcu_data *rdp;
+	bool was_alldone;
 
 	/* Misaligned rcu_head! */
 	WARN_ON_ONCE((unsigned long)head & (sizeof(void *) - 1));
@@ -2517,29 +2540,17 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func, int cpu, bool lazy)
 	rdp = this_cpu_ptr(&rcu_data);
 
 	/* Add the callback to our list. */
-	if (unlikely(!rcu_segcblist_is_enabled(&rdp->cblist)) ||
-	    rcu_segcblist_is_offloaded(&rdp->cblist) || cpu != -1) {
-		int offline;
-
-		if (cpu != -1)
-			rdp = per_cpu_ptr(&rcu_data, cpu);
-		if (likely(rdp->mynode)) {
-			/* Post-boot, so this should be for a no-CBs CPU. */
-			offline = !__call_rcu_nocb(rdp, head, lazy, flags);
-			WARN_ON_ONCE(offline);
-			/* Offline CPU, _call_rcu() illegal, leak callback.  */
-			local_irq_restore(flags);
-			return;
-		}
-		/*
-		 * Very early boot, before rcu_init().  Initialize if needed
-		 * and then drop through to queue the callback.
-		 */
-		WARN_ON_ONCE(cpu != -1);
+	if (unlikely(!rcu_segcblist_is_enabled(&rdp->cblist))) {
+		// This can trigger due to call_rcu() from offline CPU:
+		WARN_ON_ONCE(rcu_scheduler_active != RCU_SCHEDULER_INACTIVE);
 		WARN_ON_ONCE(!rcu_is_watching());
+		// Very early boot, before rcu_init().  Initialize if needed
+		// and then drop through to queue the callback.
 		if (rcu_segcblist_empty(&rdp->cblist))
 			rcu_segcblist_init(&rdp->cblist);
 	}
+	rcu_nocb_lock(rdp);
+	was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
 	rcu_segcblist_enqueue(&rdp->cblist, head, lazy);
 	if (__is_kfree_rcu_offset((unsigned long)func))
 		trace_rcu_kfree_callback(rcu_state.name, head,
@@ -2552,8 +2563,13 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func, int cpu, bool lazy)
 				   rcu_segcblist_n_cbs(&rdp->cblist));
 
 	/* Go handle any RCU core processing required. */
-	__call_rcu_core(rdp, head, flags);
-	local_irq_restore(flags);
+	if (IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
+	    unlikely(rcu_segcblist_is_offloaded(&rdp->cblist))) {
+		__call_rcu_nocb_wake(rdp, was_alldone, flags); /* unlocks */
+	} else {
+		__call_rcu_core(rdp, head, flags);
+		local_irq_restore(flags);
+	}
 }
 
 /**
@@ -2593,7 +2609,7 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func, int cpu, bool lazy)
  */
 void call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
-	__call_rcu(head, func, -1, 0);
+	__call_rcu(head, func, 0);
 }
 EXPORT_SYMBOL_GPL(call_rcu);
 
@@ -2606,7 +2622,7 @@ EXPORT_SYMBOL_GPL(call_rcu);
  */
 void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
-	__call_rcu(head, func, -1, 1);
+	__call_rcu(head, func, 1);
 }
 EXPORT_SYMBOL_GPL(kfree_call_rcu);
 
@@ -2806,6 +2822,7 @@ static void rcu_barrier_func(void *unused)
 	rcu_barrier_trace(TPS("IRQ"), -1, rcu_state.barrier_sequence);
 	rdp->barrier_head.func = rcu_barrier_callback;
 	debug_rcu_head_queue(&rdp->barrier_head);
+	rcu_nocb_lock(rdp);
 	if (rcu_segcblist_entrain(&rdp->cblist, &rdp->barrier_head, 0)) {
 		atomic_inc(&rcu_state.barrier_cpu_count);
 	} else {
@@ -2813,6 +2830,7 @@ static void rcu_barrier_func(void *unused)
 		rcu_barrier_trace(TPS("IRQNQ"), -1,
 				   rcu_state.barrier_sequence);
 	}
+	rcu_nocb_unlock(rdp);
 }
 
 /**
@@ -2867,19 +2885,7 @@ void rcu_barrier(void)
 		if (!cpu_online(cpu) &&
 		    !rcu_segcblist_is_offloaded(&rdp->cblist))
 			continue;
-		if (rcu_segcblist_is_offloaded(&rdp->cblist)) {
-			if (!rcu_nocb_cpu_needs_barrier(cpu)) {
-				rcu_barrier_trace(TPS("OfflineNoCB"), cpu,
-						   rcu_state.barrier_sequence);
-			} else {
-				rcu_barrier_trace(TPS("OnlineNoCB"), cpu,
-						   rcu_state.barrier_sequence);
-				smp_mb__before_atomic();
-				atomic_inc(&rcu_state.barrier_cpu_count);
-				__call_rcu(&rdp->barrier_head,
-					   rcu_barrier_callback, cpu, 0);
-			}
-		} else if (rcu_segcblist_n_cbs(&rdp->cblist)) {
+		if (rcu_segcblist_n_cbs(&rdp->cblist)) {
 			rcu_barrier_trace(TPS("OnlineQ"), cpu,
 					   rcu_state.barrier_sequence);
 			smp_call_function_single(cpu, rcu_barrier_func, NULL, 1);
@@ -3169,10 +3175,7 @@ void rcutree_migrate_callbacks(int cpu)
 	local_irq_save(flags);
 	my_rdp = this_cpu_ptr(&rcu_data);
 	my_rnp = my_rdp->mynode;
-	if (rcu_nocb_adopt_orphan_cbs(my_rdp, rdp, flags)) {
-		local_irq_restore(flags);
-		return;
-	}
+	rcu_nocb_lock(my_rdp); /* irqs already disabled. */
 	raw_spin_lock_rcu_node(my_rnp); /* irqs already disabled. */
 	/* Leverage recent GPs and set GP for new callbacks. */
 	needwake = rcu_advance_cbs(my_rnp, rdp) ||
@@ -3180,9 +3183,16 @@ void rcutree_migrate_callbacks(int cpu)
 	rcu_segcblist_merge(&my_rdp->cblist, &rdp->cblist);
 	WARN_ON_ONCE(rcu_segcblist_empty(&my_rdp->cblist) !=
 		     !rcu_segcblist_n_cbs(&my_rdp->cblist));
-	raw_spin_unlock_irqrestore_rcu_node(my_rnp, flags);
+	if (rcu_segcblist_is_offloaded(&my_rdp->cblist)) {
+		raw_spin_unlock_rcu_node(my_rnp); /* irqs remain disabled. */
+		__call_rcu_nocb_wake(my_rdp, true, flags);
+	} else {
+		rcu_nocb_unlock(my_rdp); /* irqs remain disabled. */
+		raw_spin_unlock_irqrestore_rcu_node(my_rnp, flags);
+	}
 	if (needwake)
 		rcu_gp_kthread_wake();
+	lockdep_assert_irqs_enabled();
 	WARN_ONCE(rcu_segcblist_n_cbs(&rdp->cblist) != 0 ||
 		  !rcu_segcblist_empty(&rdp->cblist),
 		  "rcu_cleanup_dead_cpu: Callbacks on offline CPU %d: qlen=%lu, 1stCB=%p\n",
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 8d9cfcac6757..529eec2aa74d 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -211,7 +211,9 @@ struct rcu_data {
 					/* CBs waiting for GP. */
 	struct rcu_head **nocb_gp_tail;
 	bool nocb_gp_sleep;		/* Is the nocb GP thread asleep? */
+	bool nocb_gp_forced;		/* Forced nocb GP thread wakeup? */
 	struct swait_queue_head nocb_gp_wq; /* For nocb kthreads to sleep on. */
+	bool nocb_cb_sleep;		/* Is the nocb CB thread asleep? */
 	struct task_struct *nocb_cb_kthread;
 	struct rcu_data *nocb_next_cb_rdp;
 					/* Next rcu_data in wakeup chain. */
@@ -421,20 +423,20 @@ static bool rcu_preempt_has_tasks(struct rcu_node *rnp);
 static bool rcu_preempt_need_deferred_qs(struct task_struct *t);
 static void rcu_preempt_deferred_qs(struct task_struct *t);
 static void zero_cpu_stall_ticks(struct rcu_data *rdp);
-static bool rcu_nocb_cpu_needs_barrier(int cpu);
 static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp);
 static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq);
 static void rcu_init_one_nocb(struct rcu_node *rnp);
-static bool __call_rcu_nocb(struct rcu_data *rdp, struct rcu_head *rhp,
-			    bool lazy, unsigned long flags);
-static bool rcu_nocb_adopt_orphan_cbs(struct rcu_data *my_rdp,
-				      struct rcu_data *rdp,
-				      unsigned long flags);
+static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_empty,
+				 unsigned long flags);
 static int rcu_nocb_need_deferred_wakeup(struct rcu_data *rdp);
 static void do_nocb_deferred_wakeup(struct rcu_data *rdp);
 static void rcu_boot_init_nocb_percpu_data(struct rcu_data *rdp);
 static void rcu_spawn_cpu_nocb_kthread(int cpu);
 static void __init rcu_spawn_nocb_kthreads(void);
+static void rcu_nocb_lock(struct rcu_data *rdp);
+static void rcu_nocb_unlock(struct rcu_data *rdp);
+static void rcu_nocb_unlock_irqrestore(struct rcu_data *rdp,
+				       unsigned long flags);
 #ifdef CONFIG_RCU_NOCB_CPU
 static void __init rcu_organize_nocb_kthreads(void);
 #endif /* #ifdef CONFIG_RCU_NOCB_CPU */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 2d37fd3fa0d4..feffc46cccb0 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1494,6 +1494,45 @@ static int __init parse_rcu_nocb_poll(char *arg)
 }
 early_param("rcu_nocb_poll", parse_rcu_nocb_poll);
 
+/*
+ * Acquire the specified rcu_data structure's ->nocb_lock, but only
+ * if it corresponds to a no-CBs CPU.
+ */
+static void rcu_nocb_lock(struct rcu_data *rdp)
+{
+	if (rcu_segcblist_is_offloaded(&rdp->cblist)) {
+		lockdep_assert_irqs_disabled();
+		raw_spin_lock(&rdp->nocb_lock);
+	}
+}
+
+/*
+ * Release the specified rcu_data structure's ->nocb_lock, but only
+ * if it corresponds to a no-CBs CPU.
+ */
+static void rcu_nocb_unlock(struct rcu_data *rdp)
+{
+	if (rcu_segcblist_is_offloaded(&rdp->cblist)) {
+		lockdep_assert_irqs_disabled();
+		raw_spin_unlock(&rdp->nocb_lock);
+	}
+}
+
+/*
+ * Release the specified rcu_data structure's ->nocb_lock and restore
+ * interrupts, but only if it corresponds to a no-CBs CPU.
+ */
+static void rcu_nocb_unlock_irqrestore(struct rcu_data *rdp,
+				       unsigned long flags)
+{
+	if (rcu_segcblist_is_offloaded(&rdp->cblist)) {
+		lockdep_assert_irqs_disabled();
+		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
+	} else {
+		local_irq_restore(flags);
+	}
+}
+
 /*
  * Wake up any no-CBs CPUs' kthreads that were waiting on the just-ended
  * grace period.
@@ -1526,7 +1565,7 @@ bool rcu_is_nocb_cpu(int cpu)
  * Kick the GP kthread for this NOCB group.  Caller holds ->nocb_lock
  * and this function releases it.
  */
-static void __wake_nocb_gp(struct rcu_data *rdp, bool force,
+static void wake_nocb_gp(struct rcu_data *rdp, bool force,
 			   unsigned long flags)
 	__releases(rdp->nocb_lock)
 {
@@ -1537,30 +1576,19 @@ static void __wake_nocb_gp(struct rcu_data *rdp, bool force,
 		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
 		return;
 	}
-	if (rdp_gp->nocb_gp_sleep || force) {
-		/* Prior smp_mb__after_atomic() orders against prior enqueue. */
-		WRITE_ONCE(rdp_gp->nocb_gp_sleep, false);
+	if (READ_ONCE(rdp_gp->nocb_gp_sleep) || force) {
 		del_timer(&rdp->nocb_timer);
 		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
-		smp_mb(); /* ->nocb_gp_sleep before swake_up_one(). */
-		swake_up_one(&rdp_gp->nocb_gp_wq);
+		smp_mb(); /* enqueue before ->nocb_gp_sleep. */
+		raw_spin_lock_irqsave(&rdp_gp->nocb_lock, flags);
+		WRITE_ONCE(rdp_gp->nocb_gp_sleep, false);
+		raw_spin_unlock_irqrestore(&rdp_gp->nocb_lock, flags);
+		wake_up_process(rdp_gp->nocb_gp_kthread);
 	} else {
 		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
 	}
 }
 
-/*
- * Kick the GP kthread for this NOCB group, but caller has not
- * acquired locks.
- */
-static void wake_nocb_gp(struct rcu_data *rdp, bool force)
-{
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
-	__wake_nocb_gp(rdp, force, flags);
-}
-
 /*
  * Arrange to wake the GP kthread for this NOCB group at some future
  * time when it is safe to do so.
@@ -1568,295 +1596,148 @@ static void wake_nocb_gp(struct rcu_data *rdp, bool force)
 static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
 			       const char *reason)
 {
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
 	if (rdp->nocb_defer_wakeup == RCU_NOCB_WAKE_NOT)
 		mod_timer(&rdp->nocb_timer, jiffies + 1);
 	WRITE_ONCE(rdp->nocb_defer_wakeup, waketype);
 	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, reason);
-	raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
-}
-
-/* Does rcu_barrier need to queue an RCU callback on the specified CPU?  */
-static bool rcu_nocb_cpu_needs_barrier(int cpu)
-{
-	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
-	unsigned long ret;
-#ifdef CONFIG_PROVE_RCU
-	struct rcu_head *rhp;
-#endif /* #ifdef CONFIG_PROVE_RCU */
-
-	/*
-	 * Check count of all no-CBs callbacks awaiting invocation.
-	 * There needs to be a barrier before this function is called,
-	 * but associated with a prior determination that no more
-	 * callbacks would be posted.  In the worst case, the first
-	 * barrier in rcu_barrier() suffices (but the caller cannot
-	 * necessarily rely on this, not a substitute for the caller
-	 * getting the concurrency design right!).  There must also be a
-	 * barrier between the following load and posting of a callback
-	 * (if a callback is in fact needed).  This is associated with an
-	 * atomic_inc() in the caller.
-	 */
-	ret = rcu_get_n_cbs_nocb_cpu(rdp);
-
-#ifdef CONFIG_PROVE_RCU
-	rhp = READ_ONCE(rdp->nocb_head);
-	if (!rhp)
-		rhp = READ_ONCE(rdp->nocb_gp_head);
-	if (!rhp)
-		rhp = READ_ONCE(rdp->nocb_cb_head);
-
-	/* Having no rcuo kthread but CBs after scheduler starts is bad! */
-	if (!READ_ONCE(rdp->nocb_cb_kthread) && rhp &&
-	    rcu_scheduler_fully_active) {
-		/* RCU callback enqueued before CPU first came online??? */
-		pr_err("RCU: Never-onlined no-CBs CPU %d has CB %p\n",
-		       cpu, rhp->func);
-		WARN_ON_ONCE(1);
-	}
-#endif /* #ifdef CONFIG_PROVE_RCU */
-
-	return !!ret;
 }
 
 /*
- * Enqueue the specified string of rcu_head structures onto the specified
- * CPU's no-CBs lists.  The CPU is specified by rdp, the head of the
- * string by rhp, and the tail of the string by rhtp.  The non-lazy/lazy
- * counts are supplied by rhcount and rhcount_lazy.
+ * Awaken the no-CBs grace-period kthead if needed, either due to it
+ * legitimately being asleep or due to overload conditions.
  *
  * If warranted, also wake up the kthread servicing this CPUs queues.
  */
-static void __call_rcu_nocb_enqueue(struct rcu_data *rdp,
-				    struct rcu_head *rhp,
-				    struct rcu_head **rhtp,
-				    int rhcount, int rhcount_lazy,
-				    unsigned long flags)
+static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
+				 unsigned long flags)
+				 __releases(rdp->nocb_lock)
 {
 	int len;
-	struct rcu_head **old_rhpp;
 	struct task_struct *t;
 
-	/* Enqueue the callback on the nocb list and update counts. */
-	atomic_long_add(rhcount, &rdp->nocb_q_count);
-	/* rcu_barrier() relies on ->nocb_q_count add before xchg. */
-	old_rhpp = xchg(&rdp->nocb_tail, rhtp);
-	WRITE_ONCE(*old_rhpp, rhp);
-	atomic_long_add(rhcount_lazy, &rdp->nocb_q_count_lazy);
-	smp_mb__after_atomic(); /* Store *old_rhpp before _wake test. */
-
-	/* If we are not being polled and there is a kthread, awaken it ... */
+	// If we are being polled or there is no kthread, just leave.
 	t = READ_ONCE(rdp->nocb_gp_kthread);
 	if (rcu_nocb_poll || !t) {
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 				    TPS("WakeNotPoll"));
+		rcu_nocb_unlock_irqrestore(rdp, flags);
 		return;
 	}
-	len = rcu_get_n_cbs_nocb_cpu(rdp);
-	if (old_rhpp == &rdp->nocb_head) {
+	// Need to actually to a wakeup.
+	len = rcu_segcblist_n_cbs(&rdp->cblist);
+	if (was_alldone) {
 		if (!irqs_disabled_flags(flags)) {
 			/* ... if queue was empty ... */
-			wake_nocb_gp(rdp, false);
+			wake_nocb_gp(rdp, false, flags);
 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 					    TPS("WakeEmpty"));
 		} else {
 			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE,
 					   TPS("WakeEmptyIsDeferred"));
+			rcu_nocb_unlock_irqrestore(rdp, flags);
 		}
 		rdp->qlen_last_fqs_check = 0;
 	} else if (len > rdp->qlen_last_fqs_check + qhimark) {
 		/* ... or if many callbacks queued. */
 		if (!irqs_disabled_flags(flags)) {
-			wake_nocb_gp(rdp, true);
+			wake_nocb_gp(rdp, true, flags);
 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 					    TPS("WakeOvf"));
 		} else {
 			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE_FORCE,
 					   TPS("WakeOvfIsDeferred"));
+			rcu_nocb_unlock_irqrestore(rdp, flags);
 		}
 		rdp->qlen_last_fqs_check = LONG_MAX / 2;
 	} else {
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WakeNot"));
+		rcu_nocb_unlock_irqrestore(rdp, flags);
 	}
+	if (!irqs_disabled_flags(flags))
+		lockdep_assert_irqs_enabled();
 	return;
 }
 
 /*
- * This is a helper for __call_rcu(), which invokes this when the normal
- * callback queue is inoperable.  If this is not a no-CBs CPU, this
- * function returns failure back to __call_rcu(), which can complain
- * appropriately.
- *
- * Otherwise, this function queues the callback where the corresponding
- * "rcuo" kthread can find it.
- */
-static bool __call_rcu_nocb(struct rcu_data *rdp, struct rcu_head *rhp,
-			    bool lazy, unsigned long flags)
-{
-
-	if (!rcu_segcblist_is_offloaded(&rdp->cblist))
-		return false;
-	__call_rcu_nocb_enqueue(rdp, rhp, &rhp->next, 1, lazy, flags);
-	if (__is_kfree_rcu_offset((unsigned long)rhp->func))
-		trace_rcu_kfree_callback(rcu_state.name, rhp,
-					 (unsigned long)rhp->func,
-					 -atomic_long_read(&rdp->nocb_q_count_lazy),
-					 -rcu_get_n_cbs_nocb_cpu(rdp));
-	else
-		trace_rcu_callback(rcu_state.name, rhp,
-				   -atomic_long_read(&rdp->nocb_q_count_lazy),
-				   -rcu_get_n_cbs_nocb_cpu(rdp));
-
-	return true;
-}
-
-/*
- * Adopt orphaned callbacks on a no-CBs CPU, or return 0 if this is
- * not a no-CBs CPU.
- */
-static bool __maybe_unused rcu_nocb_adopt_orphan_cbs(struct rcu_data *my_rdp,
-						     struct rcu_data *rdp,
-						     unsigned long flags)
-{
-	lockdep_assert_irqs_disabled();
-	if (!rcu_segcblist_is_offloaded(&my_rdp->cblist))
-		return false; /* Not NOCBs CPU, caller must migrate CBs. */
-	__call_rcu_nocb_enqueue(my_rdp, rcu_segcblist_head(&rdp->cblist),
-				rcu_segcblist_tail(&rdp->cblist),
-				rcu_segcblist_n_cbs(&rdp->cblist),
-				rcu_segcblist_n_lazy_cbs(&rdp->cblist), flags);
-	rcu_segcblist_init(&rdp->cblist);
-	rcu_segcblist_disable(&rdp->cblist);
-	return true;
-}
-
-/*
- * If necessary, kick off a new grace period, and either way wait
- * for a subsequent grace period to complete.
- */
-static void rcu_nocb_wait_gp(struct rcu_data *rdp)
-{
-	unsigned long c;
-	bool d;
-	unsigned long flags;
-	bool needwake;
-	struct rcu_node *rnp = rdp->mynode;
-
-	local_irq_save(flags);
-	c = rcu_seq_snap(&rcu_state.gp_seq);
-	if (!rdp->gpwrap && ULONG_CMP_GE(rdp->gp_seq_needed, c)) {
-		local_irq_restore(flags);
-	} else {
-		raw_spin_lock_rcu_node(rnp); /* irqs already disabled. */
-		needwake = rcu_start_this_gp(rnp, rdp, c);
-		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
-		if (needwake)
-			rcu_gp_kthread_wake();
-	}
-
-	/*
-	 * Wait for the grace period.  Do so interruptibly to avoid messing
-	 * up the load average.
-	 */
-	trace_rcu_this_gp(rnp, rdp, c, TPS("StartWait"));
-	for (;;) {
-		swait_event_interruptible_exclusive(
-			rnp->nocb_gp_wq[rcu_seq_ctr(c) & 0x1],
-			(d = rcu_seq_done(&rnp->gp_seq, c)));
-		if (likely(d))
-			break;
-		WARN_ON(signal_pending(current));
-		trace_rcu_this_gp(rnp, rdp, c, TPS("ResumeWait"));
-	}
-	trace_rcu_this_gp(rnp, rdp, c, TPS("EndWait"));
-	smp_mb(); /* Ensure that CB invocation happens after GP end. */
-}
-
-/*
- * No-CBs GP kthreads come here to wait for additional callbacks to show up.
- * This function does not return until callbacks appear.
+ * No-CBs GP kthreads come here to wait for additional callbacks to show up
+ * or for grace periods to end.
  */
 static void nocb_gp_wait(struct rcu_data *my_rdp)
 {
-	bool firsttime = true;
+	int __maybe_unused cpu = my_rdp->cpu;
+	unsigned long cur_gp_seq;
 	unsigned long flags;
 	bool gotcbs;
+	bool needwait_gp = false;
+	bool needwake;
+	bool needwake_gp;
 	struct rcu_data *rdp;
-	struct rcu_head **tail;
-
-	/* Wait for callbacks to appear. */
-	if (!rcu_nocb_poll) {
-		trace_rcu_nocb_wake(rcu_state.name, my_rdp->cpu, TPS("Sleep"));
-		swait_event_interruptible_exclusive(my_rdp->nocb_gp_wq,
-				!READ_ONCE(my_rdp->nocb_gp_sleep));
-		raw_spin_lock_irqsave(&my_rdp->nocb_lock, flags);
-		my_rdp->nocb_gp_sleep = true;
-		WRITE_ONCE(my_rdp->nocb_defer_wakeup, RCU_NOCB_WAKE_NOT);
-		del_timer(&my_rdp->nocb_timer);
-		raw_spin_unlock_irqrestore(&my_rdp->nocb_lock, flags);
-	} else if (firsttime) {
-		firsttime = false; /* Don't drown trace log with "Poll"! */
-		trace_rcu_nocb_wake(rcu_state.name, my_rdp->cpu, TPS("Poll"));
-	}
+	struct rcu_node *rnp;
+	unsigned long wait_gp_seq;
 
 	/*
-	 * Each pass through the following loop checks for CBs.
-	 * We are our own first CB kthread.  Any CBs found are moved to
-	 * nocb_gp_head, where they await a grace period.
+	 * Each pass through the following loop checks for CBs and for the
+	 * nearest grace period (if any) to wait for next.  The CB kthreads
+	 * and the global grace-period kthread are awakened if needed.
 	 */
-	gotcbs = false;
-	smp_mb(); /* wakeup and _sleep before ->nocb_head reads. */
 	for (rdp = my_rdp; rdp; rdp = rdp->nocb_next_cb_rdp) {
-		rdp->nocb_gp_head = READ_ONCE(rdp->nocb_head);
-		if (!rdp->nocb_gp_head)
-			continue;  /* No CBs here, try next. */
-
-		/* Move callbacks to wait-for-GP list, which is empty. */
-		WRITE_ONCE(rdp->nocb_head, NULL);
-		rdp->nocb_gp_tail = xchg(&rdp->nocb_tail, &rdp->nocb_head);
-		gotcbs = true;
-	}
-
-	/* No callbacks?  Sleep a bit if polling, and go retry.  */
-	if (unlikely(!gotcbs)) {
-		WARN_ON(signal_pending(current));
-		if (rcu_nocb_poll) {
-			schedule_timeout_interruptible(1);
-		} else {
-			trace_rcu_nocb_wake(rcu_state.name, my_rdp->cpu,
-					    TPS("WokeEmpty"));
+		if (rcu_segcblist_empty(&rdp->cblist))
+			continue; /* No callbacks here, try next. */
+		rnp = rdp->mynode;
+		raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
+		WRITE_ONCE(my_rdp->nocb_defer_wakeup, RCU_NOCB_WAKE_NOT);
+		del_timer(&my_rdp->nocb_timer);
+		raw_spin_lock_rcu_node(rnp); /* irqs already disabled. */
+		needwake_gp = rcu_advance_cbs(rnp, rdp);
+		raw_spin_unlock_rcu_node(rnp); /* irqs remain disabled. */
+		// Need to wait on some grace period?
+		if (rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq)) {
+			if (!needwait_gp ||
+			    ULONG_CMP_LT(cur_gp_seq, wait_gp_seq))
+				wait_gp_seq = cur_gp_seq;
+			needwait_gp = true;
 		}
-		return;
-	}
-
-	/* Wait for one grace period. */
-	rcu_nocb_wait_gp(my_rdp);
-
-	/* Each pass through this loop wakes a CB kthread, if needed. */
-	for (rdp = my_rdp; rdp; rdp = rdp->nocb_next_cb_rdp) {
-		if (!rcu_nocb_poll &&
-		    READ_ONCE(rdp->nocb_head) &&
-		    READ_ONCE(my_rdp->nocb_gp_sleep)) {
-			raw_spin_lock_irqsave(&my_rdp->nocb_lock, flags);
-			my_rdp->nocb_gp_sleep = false;/* No need to sleep.*/
-			raw_spin_unlock_irqrestore(&my_rdp->nocb_lock, flags);
+		if (rcu_segcblist_ready_cbs(&rdp->cblist)) {
+			needwake = rdp->nocb_cb_sleep;
+			WRITE_ONCE(rdp->nocb_cb_sleep, false);
+			smp_mb(); /* CB invocation -after- GP end. */
+		} else {
+			needwake = false;
 		}
-		if (!rdp->nocb_gp_head)
-			continue; /* No CBs, so no need to wake kthread. */
-
-		/* Append callbacks to CB kthread's "done" list. */
-		raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
-		tail = rdp->nocb_cb_tail;
-		rdp->nocb_cb_tail = rdp->nocb_gp_tail;
-		*tail = rdp->nocb_gp_head;
 		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
-		if (tail == &rdp->nocb_cb_head) {
-			/* List was empty, so wake up the kthread.  */
+		if (needwake) {
 			swake_up_one(&rdp->nocb_cb_wq);
+			gotcbs = true;
 		}
+		if (needwake_gp)
+			rcu_gp_kthread_wake();
+	}
+
+	if (rcu_nocb_poll) {
+		/* Polling, so trace if first poll in the series. */
+		if (gotcbs)
+			trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("Poll"));
+		schedule_timeout_interruptible(1);
+	} else if (!needwait_gp) {
+		/* Wait for callbacks to appear. */
+		trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("Sleep"));
+		swait_event_interruptible_exclusive(my_rdp->nocb_gp_wq,
+				!READ_ONCE(my_rdp->nocb_gp_sleep));
+	} else {
+		rnp = my_rdp->mynode;
+		trace_rcu_this_gp(rnp, my_rdp, wait_gp_seq, TPS("StartWait"));
+		swait_event_interruptible_exclusive(
+			rnp->nocb_gp_wq[rcu_seq_ctr(wait_gp_seq) & 0x1],
+			rcu_seq_done(&rnp->gp_seq, wait_gp_seq) ||
+			!READ_ONCE(my_rdp->nocb_gp_sleep));
+		trace_rcu_this_gp(rnp, my_rdp, wait_gp_seq, TPS("EndWait"));
+	}
+	if (!rcu_nocb_poll) {
+		raw_spin_lock_irqsave(&my_rdp->nocb_lock, flags);
+		WRITE_ONCE(my_rdp->nocb_gp_sleep, true);
+		raw_spin_unlock_irqrestore(&my_rdp->nocb_lock, flags);
 	}
+	WARN_ON(signal_pending(current));
 }
 
 /*
@@ -1871,92 +1752,69 @@ static int rcu_nocb_gp_kthread(void *arg)
 {
 	struct rcu_data *rdp = arg;
 
-	for (;;)
+	for (;;) {
 		nocb_gp_wait(rdp);
+		cond_resched_tasks_rcu_qs();
+	}
 	return 0;
 }
 
 /*
- * No-CBs CB kthreads come here to wait for additional callbacks to show up.
- * This function returns true ("keep waiting") until callbacks appear and
- * then false ("stop waiting") when callbacks finally do appear.
+ * Invoke any ready callbacks from the corresponding no-CBs CPU,
+ * then, if there are no more, wait for more to appear.
  */
-static bool nocb_cb_wait(struct rcu_data *rdp)
+static void nocb_cb_wait(struct rcu_data *rdp)
 {
+	unsigned long flags;
+	bool needwake_gp = false;
+	struct rcu_node *rnp = rdp->mynode;
+
+	local_irq_save(flags);
+	rcu_momentary_dyntick_idle();
+	local_irq_restore(flags);
+	local_bh_disable();
+	rcu_do_batch(rdp);
+	local_bh_enable();
+	lockdep_assert_irqs_enabled();
+	raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
+	raw_spin_lock_rcu_node(rnp); /* irqs already disabled. */
+	needwake_gp = rcu_advance_cbs(rdp->mynode, rdp);
+	raw_spin_unlock_rcu_node(rnp); /* irqs remain disabled. */
+	if (rcu_segcblist_ready_cbs(&rdp->cblist)) {
+		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
+		if (needwake_gp)
+			rcu_gp_kthread_wake();
+		return;
+	}
+
 	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("CBSleep"));
+	WRITE_ONCE(rdp->nocb_cb_sleep, true);
+	raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
+	if (needwake_gp)
+		rcu_gp_kthread_wake();
 	swait_event_interruptible_exclusive(rdp->nocb_cb_wq,
-				 READ_ONCE(rdp->nocb_cb_head));
-	if (smp_load_acquire(&rdp->nocb_cb_head)) { /* VVV */
-		/* ^^^ Ensure CB invocation follows _head test. */
-		return false;
+				 !READ_ONCE(rdp->nocb_cb_sleep));
+	if (!smp_load_acquire(&rdp->nocb_cb_sleep)) { /* VVV */
+		/* ^^^ Ensure CB invocation follows _sleep test. */
+		return;
 	}
 	WARN_ON(signal_pending(current));
 	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WokeEmpty"));
-	return true;
 }
 
 /*
- * Per-rcu_data kthread, but only for no-CBs CPUs.  Each kthread invokes
- * callbacks queued by the corresponding no-CBs CPU, however, there is an
- * optional GP-CB relationship so that the grace-period kthreads don't
- * have to do quite so many wakeups (as in they only need to wake the
- * no-CBs GP kthreads, not the CB kthreads).
+ * Per-rcu_data kthread, but only for no-CBs CPUs.  Repeatedly invoke
+ * nocb_cb_wait() to do the dirty work.
  */
 static int rcu_nocb_cb_kthread(void *arg)
 {
-	int c, cl;
-	unsigned long flags;
-	struct rcu_head *list;
-	struct rcu_head *next;
-	struct rcu_head **tail;
 	struct rcu_data *rdp = arg;
 
-	/* Each pass through this loop invokes one batch of callbacks */
+	// Each pass through this loop does one callback batch, and,
+	// if there are no more ready callbacks, waits for them.
 	for (;;) {
-		/* Wait for callbacks. */
-		while (nocb_cb_wait(rdp))
-			continue;
-
-		/* Pull the ready-to-invoke callbacks onto local list. */
-		raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
-		list = rdp->nocb_cb_head;
-		rdp->nocb_cb_head = NULL;
-		tail = rdp->nocb_cb_tail;
-		rdp->nocb_cb_tail = &rdp->nocb_cb_head;
-		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
-		if (WARN_ON_ONCE(!list))
-			continue;
-		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WokeNonEmpty"));
-
-		/* Each pass through the following loop invokes a callback. */
-		trace_rcu_batch_start(rcu_state.name,
-				      atomic_long_read(&rdp->nocb_q_count_lazy),
-				      rcu_get_n_cbs_nocb_cpu(rdp), -1);
-		c = cl = 0;
-		while (list) {
-			next = list->next;
-			/* Wait for enqueuing to complete, if needed. */
-			while (next == NULL && &list->next != tail) {
-				trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
-						    TPS("WaitQueue"));
-				schedule_timeout_interruptible(1);
-				trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
-						    TPS("WokeQueue"));
-				next = list->next;
-			}
-			debug_rcu_head_unqueue(list);
-			local_bh_disable();
-			if (__rcu_reclaim(rcu_state.name, list))
-				cl++;
-			c++;
-			local_bh_enable();
-			cond_resched_tasks_rcu_qs();
-			list = next;
-		}
-		trace_rcu_batch_end(rcu_state.name, c, !!list, 0, 0, 1);
-		smp_mb__before_atomic();  /* _add after CB invocation. */
-		atomic_long_add(-c, &rdp->nocb_q_count);
-		atomic_long_add(-cl, &rdp->nocb_q_count_lazy);
+		nocb_cb_wait(rdp);
+		cond_resched_tasks_rcu_qs();
 	}
 	return 0;
 }
@@ -1980,7 +1838,7 @@ static void do_nocb_deferred_wakeup_common(struct rcu_data *rdp)
 	}
 	ndw = READ_ONCE(rdp->nocb_defer_wakeup);
 	WRITE_ONCE(rdp->nocb_defer_wakeup, RCU_NOCB_WAKE_NOT);
-	__wake_nocb_gp(rdp, ndw == RCU_NOCB_WAKE_FORCE, flags);
+	wake_nocb_gp(rdp, ndw == RCU_NOCB_WAKE_FORCE, flags);
 	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("DeferredWake"));
 }
 
@@ -2194,10 +2052,21 @@ static unsigned long rcu_get_n_cbs_nocb_cpu(struct rcu_data *rdp)
 
 #else /* #ifdef CONFIG_RCU_NOCB_CPU */
 
-static bool rcu_nocb_cpu_needs_barrier(int cpu)
+/* No ->nocb_lock to acquire.  */
+static void rcu_nocb_lock(struct rcu_data *rdp)
 {
-	WARN_ON_ONCE(1); /* Should be dead code. */
-	return false;
+}
+
+/* No ->nocb_lock to release.  */
+static void rcu_nocb_unlock(struct rcu_data *rdp)
+{
+}
+
+/* No ->nocb_lock to release.  */
+static void rcu_nocb_unlock_irqrestore(struct rcu_data *rdp,
+				       unsigned long flags)
+{
+	local_irq_restore(flags);
 }
 
 static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq)
@@ -2213,17 +2082,10 @@ static void rcu_init_one_nocb(struct rcu_node *rnp)
 {
 }
 
-static bool __call_rcu_nocb(struct rcu_data *rdp, struct rcu_head *rhp,
-			    bool lazy, unsigned long flags)
+static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_empty,
+				 unsigned long flags)
 {
-	return false;
-}
-
-static bool __maybe_unused rcu_nocb_adopt_orphan_cbs(struct rcu_data *my_rdp,
-						     struct rcu_data *rdp,
-						     unsigned long flags)
-{
-	return false;
+	WARN_ON_ONCE(1);  /* Should be dead code! */
 }
 
 static void __init rcu_boot_init_nocb_percpu_data(struct rcu_data *rdp)
-- 
2.17.1

