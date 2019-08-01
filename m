Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2C3C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C665E2080C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388978AbfHAWu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 18:50:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64618 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728904AbfHAWu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 18:50:56 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71Ml9qD103267;
        Thu, 1 Aug 2019 18:50:30 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u47v12n8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 18:50:30 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x71MoTG2109041;
        Thu, 1 Aug 2019 18:50:30 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u47v12n84-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 18:50:29 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x71MoCKs003815;
        Thu, 1 Aug 2019 22:50:29 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma02wdc.us.ibm.com with ESMTP id 2u0e85w6yk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 22:50:29 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x71MoSDh49349074
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Aug 2019 22:50:28 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 83548B2076;
        Thu,  1 Aug 2019 22:50:28 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53841B2077;
        Thu,  1 Aug 2019 22:50:28 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Aug 2019 22:50:28 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id AD1EC16C9A4F; Thu,  1 Aug 2019 15:50:29 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 01/11] rcu/nocb: Rename rcu_data fields to prepare for forward-progress work
Date:   Thu,  1 Aug 2019 15:50:18 -0700
Message-Id: <20190801225028.18225-1-paulmck@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801225009.GA17155@linux.ibm.com>
References: <20190801225009.GA17155@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=15 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010240
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit simply renames rcu_data fields to prepare for leader
nocb kthreads doing only grace-period work and callback shuffling.
This will mean the addition of replacement kthreads to invoke callbacks.
The "leader" and "follower" thus become less meaningful, so the commit
changes no-CB fields with these strings to "gp" and "cb", respectively.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/tree.h        | 14 ++++----
 kernel/rcu/tree_plugin.h | 78 ++++++++++++++++++++--------------------
 2 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 7acaf3a62d39..e4e59b627c5a 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -198,10 +198,10 @@ struct rcu_data {
 	struct rcu_head **nocb_tail;
 	atomic_long_t nocb_q_count;	/* # CBs waiting for nocb */
 	atomic_long_t nocb_q_count_lazy; /*  invocation (all stages). */
-	struct rcu_head *nocb_follower_head; /* CBs ready to invoke. */
-	struct rcu_head **nocb_follower_tail;
+	struct rcu_head *nocb_cb_head;	/* CBs ready to invoke. */
+	struct rcu_head **nocb_cb_tail;
 	struct swait_queue_head nocb_wq; /* For nocb kthreads to sleep on. */
-	struct task_struct *nocb_kthread;
+	struct task_struct *nocb_cb_kthread;
 	raw_spinlock_t nocb_lock;	/* Guard following pair of fields. */
 	int nocb_defer_wakeup;		/* Defer wakeup of nocb_kthread. */
 	struct timer_list nocb_timer;	/* Enforce finite deferral. */
@@ -210,12 +210,12 @@ struct rcu_data {
 	struct rcu_head *nocb_gp_head ____cacheline_internodealigned_in_smp;
 					/* CBs waiting for GP. */
 	struct rcu_head **nocb_gp_tail;
-	bool nocb_leader_sleep;		/* Is the nocb leader thread asleep? */
-	struct rcu_data *nocb_next_follower;
-					/* Next follower in wakeup chain. */
+	bool nocb_gp_sleep;		/* Is the nocb leader thread asleep? */
+	struct rcu_data *nocb_next_cb_rdp;
+					/* Next rcu_data in wakeup chain. */
 
 	/* The following fields are used by the follower, hence new cachline. */
-	struct rcu_data *nocb_leader ____cacheline_internodealigned_in_smp;
+	struct rcu_data *nocb_gp_rdp ____cacheline_internodealigned_in_smp;
 					/* Leader CPU takes GP-end wakeups. */
 #endif /* #ifdef CONFIG_RCU_NOCB_CPU */
 
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 99e9d952827b..5ce1edd1c87f 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1528,19 +1528,19 @@ static void __wake_nocb_leader(struct rcu_data *rdp, bool force,
 			       unsigned long flags)
 	__releases(rdp->nocb_lock)
 {
-	struct rcu_data *rdp_leader = rdp->nocb_leader;
+	struct rcu_data *rdp_leader = rdp->nocb_gp_rdp;
 
 	lockdep_assert_held(&rdp->nocb_lock);
-	if (!READ_ONCE(rdp_leader->nocb_kthread)) {
+	if (!READ_ONCE(rdp_leader->nocb_cb_kthread)) {
 		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
 		return;
 	}
-	if (rdp_leader->nocb_leader_sleep || force) {
+	if (rdp_leader->nocb_gp_sleep || force) {
 		/* Prior smp_mb__after_atomic() orders against prior enqueue. */
-		WRITE_ONCE(rdp_leader->nocb_leader_sleep, false);
+		WRITE_ONCE(rdp_leader->nocb_gp_sleep, false);
 		del_timer(&rdp->nocb_timer);
 		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
-		smp_mb(); /* ->nocb_leader_sleep before swake_up_one(). */
+		smp_mb(); /* ->nocb_gp_sleep before swake_up_one(). */
 		swake_up_one(&rdp_leader->nocb_wq);
 	} else {
 		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
@@ -1604,10 +1604,10 @@ static bool rcu_nocb_cpu_needs_barrier(int cpu)
 	if (!rhp)
 		rhp = READ_ONCE(rdp->nocb_gp_head);
 	if (!rhp)
-		rhp = READ_ONCE(rdp->nocb_follower_head);
+		rhp = READ_ONCE(rdp->nocb_cb_head);
 
 	/* Having no rcuo kthread but CBs after scheduler starts is bad! */
-	if (!READ_ONCE(rdp->nocb_kthread) && rhp &&
+	if (!READ_ONCE(rdp->nocb_cb_kthread) && rhp &&
 	    rcu_scheduler_fully_active) {
 		/* RCU callback enqueued before CPU first came online??? */
 		pr_err("RCU: Never-onlined no-CBs CPU %d has CB %p\n",
@@ -1646,7 +1646,7 @@ static void __call_rcu_nocb_enqueue(struct rcu_data *rdp,
 	smp_mb__after_atomic(); /* Store *old_rhpp before _wake test. */
 
 	/* If we are not being polled and there is a kthread, awaken it ... */
-	t = READ_ONCE(rdp->nocb_kthread);
+	t = READ_ONCE(rdp->nocb_cb_kthread);
 	if (rcu_nocb_poll || !t) {
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 				    TPS("WakeNotPoll"));
@@ -1800,9 +1800,9 @@ static void nocb_leader_wait(struct rcu_data *my_rdp)
 	if (!rcu_nocb_poll) {
 		trace_rcu_nocb_wake(rcu_state.name, my_rdp->cpu, TPS("Sleep"));
 		swait_event_interruptible_exclusive(my_rdp->nocb_wq,
-				!READ_ONCE(my_rdp->nocb_leader_sleep));
+				!READ_ONCE(my_rdp->nocb_gp_sleep));
 		raw_spin_lock_irqsave(&my_rdp->nocb_lock, flags);
-		my_rdp->nocb_leader_sleep = true;
+		my_rdp->nocb_gp_sleep = true;
 		WRITE_ONCE(my_rdp->nocb_defer_wakeup, RCU_NOCB_WAKE_NOT);
 		del_timer(&my_rdp->nocb_timer);
 		raw_spin_unlock_irqrestore(&my_rdp->nocb_lock, flags);
@@ -1818,7 +1818,7 @@ static void nocb_leader_wait(struct rcu_data *my_rdp)
 	 */
 	gotcbs = false;
 	smp_mb(); /* wakeup and _sleep before ->nocb_head reads. */
-	for (rdp = my_rdp; rdp; rdp = rdp->nocb_next_follower) {
+	for (rdp = my_rdp; rdp; rdp = rdp->nocb_next_cb_rdp) {
 		rdp->nocb_gp_head = READ_ONCE(rdp->nocb_head);
 		if (!rdp->nocb_gp_head)
 			continue;  /* No CBs here, try next follower. */
@@ -1845,12 +1845,12 @@ static void nocb_leader_wait(struct rcu_data *my_rdp)
 	rcu_nocb_wait_gp(my_rdp);
 
 	/* Each pass through the following loop wakes a follower, if needed. */
-	for (rdp = my_rdp; rdp; rdp = rdp->nocb_next_follower) {
+	for (rdp = my_rdp; rdp; rdp = rdp->nocb_next_cb_rdp) {
 		if (!rcu_nocb_poll &&
 		    READ_ONCE(rdp->nocb_head) &&
-		    READ_ONCE(my_rdp->nocb_leader_sleep)) {
+		    READ_ONCE(my_rdp->nocb_gp_sleep)) {
 			raw_spin_lock_irqsave(&my_rdp->nocb_lock, flags);
-			my_rdp->nocb_leader_sleep = false;/* No need to sleep.*/
+			my_rdp->nocb_gp_sleep = false;/* No need to sleep.*/
 			raw_spin_unlock_irqrestore(&my_rdp->nocb_lock, flags);
 		}
 		if (!rdp->nocb_gp_head)
@@ -1858,18 +1858,18 @@ static void nocb_leader_wait(struct rcu_data *my_rdp)
 
 		/* Append callbacks to follower's "done" list. */
 		raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
-		tail = rdp->nocb_follower_tail;
-		rdp->nocb_follower_tail = rdp->nocb_gp_tail;
+		tail = rdp->nocb_cb_tail;
+		rdp->nocb_cb_tail = rdp->nocb_gp_tail;
 		*tail = rdp->nocb_gp_head;
 		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
-		if (rdp != my_rdp && tail == &rdp->nocb_follower_head) {
+		if (rdp != my_rdp && tail == &rdp->nocb_cb_head) {
 			/* List was empty, so wake up the follower.  */
 			swake_up_one(&rdp->nocb_wq);
 		}
 	}
 
 	/* If we (the leader) don't have CBs, go wait some more. */
-	if (!my_rdp->nocb_follower_head)
+	if (!my_rdp->nocb_cb_head)
 		goto wait_again;
 }
 
@@ -1882,8 +1882,8 @@ static void nocb_follower_wait(struct rcu_data *rdp)
 	for (;;) {
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("FollowerSleep"));
 		swait_event_interruptible_exclusive(rdp->nocb_wq,
-					 READ_ONCE(rdp->nocb_follower_head));
-		if (smp_load_acquire(&rdp->nocb_follower_head)) {
+					 READ_ONCE(rdp->nocb_cb_head));
+		if (smp_load_acquire(&rdp->nocb_cb_head)) {
 			/* ^^^ Ensure CB invocation follows _head test. */
 			return;
 		}
@@ -1910,17 +1910,17 @@ static int rcu_nocb_kthread(void *arg)
 	/* Each pass through this loop invokes one batch of callbacks */
 	for (;;) {
 		/* Wait for callbacks. */
-		if (rdp->nocb_leader == rdp)
+		if (rdp->nocb_gp_rdp == rdp)
 			nocb_leader_wait(rdp);
 		else
 			nocb_follower_wait(rdp);
 
 		/* Pull the ready-to-invoke callbacks onto local list. */
 		raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
-		list = rdp->nocb_follower_head;
-		rdp->nocb_follower_head = NULL;
-		tail = rdp->nocb_follower_tail;
-		rdp->nocb_follower_tail = &rdp->nocb_follower_head;
+		list = rdp->nocb_cb_head;
+		rdp->nocb_cb_head = NULL;
+		tail = rdp->nocb_cb_tail;
+		rdp->nocb_cb_tail = &rdp->nocb_cb_head;
 		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
 		if (WARN_ON_ONCE(!list))
 			continue;
@@ -2048,7 +2048,7 @@ static void __init rcu_boot_init_nocb_percpu_data(struct rcu_data *rdp)
 {
 	rdp->nocb_tail = &rdp->nocb_head;
 	init_swait_queue_head(&rdp->nocb_wq);
-	rdp->nocb_follower_tail = &rdp->nocb_follower_head;
+	rdp->nocb_cb_tail = &rdp->nocb_cb_head;
 	raw_spin_lock_init(&rdp->nocb_lock);
 	timer_setup(&rdp->nocb_timer, do_nocb_deferred_wakeup_timer, 0);
 }
@@ -2070,27 +2070,27 @@ static void rcu_spawn_one_nocb_kthread(int cpu)
 	 * If this isn't a no-CBs CPU or if it already has an rcuo kthread,
 	 * then nothing to do.
 	 */
-	if (!rcu_is_nocb_cpu(cpu) || rdp_spawn->nocb_kthread)
+	if (!rcu_is_nocb_cpu(cpu) || rdp_spawn->nocb_cb_kthread)
 		return;
 
 	/* If we didn't spawn the leader first, reorganize! */
-	rdp_old_leader = rdp_spawn->nocb_leader;
-	if (rdp_old_leader != rdp_spawn && !rdp_old_leader->nocb_kthread) {
+	rdp_old_leader = rdp_spawn->nocb_gp_rdp;
+	if (rdp_old_leader != rdp_spawn && !rdp_old_leader->nocb_cb_kthread) {
 		rdp_last = NULL;
 		rdp = rdp_old_leader;
 		do {
-			rdp->nocb_leader = rdp_spawn;
+			rdp->nocb_gp_rdp = rdp_spawn;
 			if (rdp_last && rdp != rdp_spawn)
-				rdp_last->nocb_next_follower = rdp;
+				rdp_last->nocb_next_cb_rdp = rdp;
 			if (rdp == rdp_spawn) {
-				rdp = rdp->nocb_next_follower;
+				rdp = rdp->nocb_next_cb_rdp;
 			} else {
 				rdp_last = rdp;
-				rdp = rdp->nocb_next_follower;
-				rdp_last->nocb_next_follower = NULL;
+				rdp = rdp->nocb_next_cb_rdp;
+				rdp_last->nocb_next_cb_rdp = NULL;
 			}
 		} while (rdp);
-		rdp_spawn->nocb_next_follower = rdp_old_leader;
+		rdp_spawn->nocb_next_cb_rdp = rdp_old_leader;
 	}
 
 	/* Spawn the kthread for this CPU. */
@@ -2098,7 +2098,7 @@ static void rcu_spawn_one_nocb_kthread(int cpu)
 			"rcuo%c/%d", rcu_state.abbr, cpu);
 	if (WARN_ONCE(IS_ERR(t), "%s: Could not start rcuo kthread, OOM is now expected behavior\n", __func__))
 		return;
-	WRITE_ONCE(rdp_spawn->nocb_kthread, t);
+	WRITE_ONCE(rdp_spawn->nocb_cb_kthread, t);
 }
 
 /*
@@ -2158,12 +2158,12 @@ static void __init rcu_organize_nocb_kthreads(void)
 		if (rdp->cpu >= nl) {
 			/* New leader, set up for followers & next leader. */
 			nl = DIV_ROUND_UP(rdp->cpu + 1, ls) * ls;
-			rdp->nocb_leader = rdp;
+			rdp->nocb_gp_rdp = rdp;
 			rdp_leader = rdp;
 		} else {
 			/* Another follower, link to previous leader. */
-			rdp->nocb_leader = rdp_leader;
-			rdp_prev->nocb_next_follower = rdp;
+			rdp->nocb_gp_rdp = rdp_leader;
+			rdp_prev->nocb_next_cb_rdp = rdp;
 		}
 		rdp_prev = rdp;
 	}
-- 
2.17.1

