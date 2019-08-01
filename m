Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253C3C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E08082084C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390155AbfHAWvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 18:51:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34732 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390130AbfHAWvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 18:51:12 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71MmZuH146005;
        Thu, 1 Aug 2019 18:50:31 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u475rv2ad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 18:50:31 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x71MnYD5001700;
        Thu, 1 Aug 2019 18:50:30 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u475rv29v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 18:50:30 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x71MnsFT001364;
        Thu, 1 Aug 2019 22:50:29 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma05wdc.us.ibm.com with ESMTP id 2u0e85w6t6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 22:50:29 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x71MoSE140042900
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Aug 2019 22:50:28 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91650B207F;
        Thu,  1 Aug 2019 22:50:28 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 61501B2075;
        Thu,  1 Aug 2019 22:50:28 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Aug 2019 22:50:28 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id BA1FE16C9A51; Thu,  1 Aug 2019 15:50:29 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 03/11] rcu/nocb: Provide separate no-CBs grace-period kthreads
Date:   Thu,  1 Aug 2019 15:50:20 -0700
Message-Id: <20190801225028.18225-3-paulmck@linux.ibm.com>
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

Currently, there is one no-CBs rcuo kthread per CPU, and these kthreads
are divided into groups.  The first rcuo kthread to come online in a
given group is that group's leader, and the leader both waits for grace
periods and invokes its CPU's callbacks.  The non-leader rcuo kthreads
only invoke callbacks.

This works well in the real-time/embedded environments for which it was
intended because such environments tend not to generate all that many
callbacks.  However, given huge floods of callbacks, it is possible for
the leader kthread to be stuck invoking callbacks while its followers
wait helplessly while their callbacks pile up.  This is a good recipe
for an OOM, and rcutorture's new callback-flood capability does generate
such OOMs.

One strategy would be to wait until such OOMs start happening in
production, but similar OOMs have in fact happened starting in 2018.
It would therefore be wise to take a more proactive approach.

This commit therefore features per-CPU rcuo kthreads that do nothing
but invoke callbacks.  Instead of having one of these kthreads act as
leader, each group has a separate rcog kthread that handles grace periods
for its group.  Because these rcuog kthreads do not invoke callbacks,
callback floods on one CPU no longer block callbacks from reaching the
rcuc callback-invocation kthreads on other CPUs.

This change does introduce additional kthreads, however:

1.	The number of additional kthreads is about the square root of
	the number of CPUs, so that a 4096-CPU system would have only
	about 64 additional kthreads.  Note that recent changes
	decreased the number of rcuo kthreads by a factor of two
	(CONFIG_PREEMPT=n) or even three (CONFIG_PREEMPT=y), so
	this still represents a significant improvement on most systems.

2.	The leading "rcuo" of the rcuog kthreads should allow existing
	scripting to affinity these additional kthreads as needed, the
	same as for the rcuop and rcuos kthreads.  (There are no longer
	any rcuob kthreads.)

3.	A state-machine approach was considered and rejected.  Although
	this would allow the rcuo kthreads to continue their dual
	leader/follower roles, it complicates callback invocation
	and makes it more difficult to consolidate rcuo callback
	invocation with existing softirq callback invocation.

The introduction of rcuog kthreads should thus be acceptable.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/tree.h        |   6 +-
 kernel/rcu/tree_plugin.h | 115 +++++++++++++++++++--------------------
 2 files changed, 61 insertions(+), 60 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 32b3348d3a4d..dc3c53cb9608 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -200,8 +200,8 @@ struct rcu_data {
 	atomic_long_t nocb_q_count_lazy; /*  invocation (all stages). */
 	struct rcu_head *nocb_cb_head;	/* CBs ready to invoke. */
 	struct rcu_head **nocb_cb_tail;
-	struct swait_queue_head nocb_wq; /* For nocb kthreads to sleep on. */
-	struct task_struct *nocb_cb_kthread;
+	struct swait_queue_head nocb_cb_wq; /* For nocb kthreads to sleep on. */
+	struct task_struct *nocb_gp_kthread;
 	raw_spinlock_t nocb_lock;	/* Guard following pair of fields. */
 	int nocb_defer_wakeup;		/* Defer wakeup of nocb_kthread. */
 	struct timer_list nocb_timer;	/* Enforce finite deferral. */
@@ -211,6 +211,8 @@ struct rcu_data {
 					/* CBs waiting for GP. */
 	struct rcu_head **nocb_gp_tail;
 	bool nocb_gp_sleep;		/* Is the nocb GP thread asleep? */
+	struct swait_queue_head nocb_gp_wq; /* For nocb kthreads to sleep on. */
+	struct task_struct *nocb_cb_kthread;
 	struct rcu_data *nocb_next_cb_rdp;
 					/* Next rcu_data in wakeup chain. */
 
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 5a72700c3a32..c3b6493313ab 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1531,7 +1531,7 @@ static void __wake_nocb_leader(struct rcu_data *rdp, bool force,
 	struct rcu_data *rdp_leader = rdp->nocb_gp_rdp;
 
 	lockdep_assert_held(&rdp->nocb_lock);
-	if (!READ_ONCE(rdp_leader->nocb_cb_kthread)) {
+	if (!READ_ONCE(rdp_leader->nocb_gp_kthread)) {
 		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
 		return;
 	}
@@ -1541,7 +1541,7 @@ static void __wake_nocb_leader(struct rcu_data *rdp, bool force,
 		del_timer(&rdp->nocb_timer);
 		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
 		smp_mb(); /* ->nocb_gp_sleep before swake_up_one(). */
-		swake_up_one(&rdp_leader->nocb_wq);
+		swake_up_one(&rdp_leader->nocb_gp_wq);
 	} else {
 		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
 	}
@@ -1646,7 +1646,7 @@ static void __call_rcu_nocb_enqueue(struct rcu_data *rdp,
 	smp_mb__after_atomic(); /* Store *old_rhpp before _wake test. */
 
 	/* If we are not being polled and there is a kthread, awaken it ... */
-	t = READ_ONCE(rdp->nocb_cb_kthread);
+	t = READ_ONCE(rdp->nocb_gp_kthread);
 	if (rcu_nocb_poll || !t) {
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 				    TPS("WakeNotPoll"));
@@ -1786,7 +1786,7 @@ static void rcu_nocb_wait_gp(struct rcu_data *rdp)
  * No-CBs GP kthreads come here to wait for additional callbacks to show up.
  * This function does not return until callbacks appear.
  */
-static void nocb_leader_wait(struct rcu_data *my_rdp)
+static void nocb_gp_wait(struct rcu_data *my_rdp)
 {
 	bool firsttime = true;
 	unsigned long flags;
@@ -1794,12 +1794,10 @@ static void nocb_leader_wait(struct rcu_data *my_rdp)
 	struct rcu_data *rdp;
 	struct rcu_head **tail;
 
-wait_again:
-
 	/* Wait for callbacks to appear. */
 	if (!rcu_nocb_poll) {
 		trace_rcu_nocb_wake(rcu_state.name, my_rdp->cpu, TPS("Sleep"));
-		swait_event_interruptible_exclusive(my_rdp->nocb_wq,
+		swait_event_interruptible_exclusive(my_rdp->nocb_gp_wq,
 				!READ_ONCE(my_rdp->nocb_gp_sleep));
 		raw_spin_lock_irqsave(&my_rdp->nocb_lock, flags);
 		my_rdp->nocb_gp_sleep = true;
@@ -1838,7 +1836,7 @@ static void nocb_leader_wait(struct rcu_data *my_rdp)
 			trace_rcu_nocb_wake(rcu_state.name, my_rdp->cpu,
 					    TPS("WokeEmpty"));
 		}
-		goto wait_again;
+		return;
 	}
 
 	/* Wait for one grace period. */
@@ -1862,34 +1860,47 @@ static void nocb_leader_wait(struct rcu_data *my_rdp)
 		rdp->nocb_cb_tail = rdp->nocb_gp_tail;
 		*tail = rdp->nocb_gp_head;
 		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
-		if (rdp != my_rdp && tail == &rdp->nocb_cb_head) {
+		if (tail == &rdp->nocb_cb_head) {
 			/* List was empty, so wake up the kthread.  */
-			swake_up_one(&rdp->nocb_wq);
+			swake_up_one(&rdp->nocb_cb_wq);
 		}
 	}
+}
 
-	/* If we (the GP kthreads) don't have CBs, go wait some more. */
-	if (!my_rdp->nocb_cb_head)
-		goto wait_again;
+/*
+ * No-CBs grace-period-wait kthread.  There is one of these per group
+ * of CPUs, but only once at least one CPU in that group has come online
+ * at least once since boot.  This kthread checks for newly posted
+ * callbacks from any of the CPUs it is responsible for, waits for a
+ * grace period, then awakens all of the rcu_nocb_cb_kthread() instances
+ * that then have callback-invocation work to do.
+ */
+static int rcu_nocb_gp_kthread(void *arg)
+{
+	struct rcu_data *rdp = arg;
+
+	for (;;)
+		nocb_gp_wait(rdp);
+	return 0;
 }
 
 /*
  * No-CBs CB kthreads come here to wait for additional callbacks to show up.
- * This function does not return until callbacks appear.
+ * This function returns true ("keep waiting") until callbacks appear and
+ * then false ("stop waiting") when callbacks finally do appear.
  */
-static void nocb_follower_wait(struct rcu_data *rdp)
+static bool nocb_follower_wait(struct rcu_data *rdp)
 {
-	for (;;) {
-		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("FollowerSleep"));
-		swait_event_interruptible_exclusive(rdp->nocb_wq,
-					 READ_ONCE(rdp->nocb_cb_head));
-		if (smp_load_acquire(&rdp->nocb_cb_head)) {
-			/* ^^^ Ensure CB invocation follows _head test. */
-			return;
-		}
-		WARN_ON(signal_pending(current));
-		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WokeEmpty"));
+	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("FollowerSleep"));
+	swait_event_interruptible_exclusive(rdp->nocb_cb_wq,
+				 READ_ONCE(rdp->nocb_cb_head));
+	if (smp_load_acquire(&rdp->nocb_cb_head)) { /* VVV */
+		/* ^^^ Ensure CB invocation follows _head test. */
+		return false;
 	}
+	WARN_ON(signal_pending(current));
+	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WokeEmpty"));
+	return true;
 }
 
 /*
@@ -1899,7 +1910,7 @@ static void nocb_follower_wait(struct rcu_data *rdp)
  * have to do quite so many wakeups (as in they only need to wake the
  * no-CBs GP kthreads, not the CB kthreads).
  */
-static int rcu_nocb_kthread(void *arg)
+static int rcu_nocb_cb_kthread(void *arg)
 {
 	int c, cl;
 	unsigned long flags;
@@ -1911,10 +1922,8 @@ static int rcu_nocb_kthread(void *arg)
 	/* Each pass through this loop invokes one batch of callbacks */
 	for (;;) {
 		/* Wait for callbacks. */
-		if (rdp->nocb_gp_rdp == rdp)
-			nocb_leader_wait(rdp);
-		else
-			nocb_follower_wait(rdp);
+		while (nocb_follower_wait(rdp))
+			continue;
 
 		/* Pull the ready-to-invoke callbacks onto local list. */
 		raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
@@ -2048,7 +2057,8 @@ void __init rcu_init_nohz(void)
 static void __init rcu_boot_init_nocb_percpu_data(struct rcu_data *rdp)
 {
 	rdp->nocb_tail = &rdp->nocb_head;
-	init_swait_queue_head(&rdp->nocb_wq);
+	init_swait_queue_head(&rdp->nocb_cb_wq);
+	init_swait_queue_head(&rdp->nocb_gp_wq);
 	rdp->nocb_cb_tail = &rdp->nocb_cb_head;
 	raw_spin_lock_init(&rdp->nocb_lock);
 	timer_setup(&rdp->nocb_timer, do_nocb_deferred_wakeup_timer, 0);
@@ -2056,50 +2066,39 @@ static void __init rcu_boot_init_nocb_percpu_data(struct rcu_data *rdp)
 
 /*
  * If the specified CPU is a no-CBs CPU that does not already have its
- * rcuo kthread, spawn it.  If the CPUs are brought online out of order,
- * this can require re-organizing the GP-CB relationships.
+ * rcuo CB kthread, spawn it.  Additionally, if the rcuo GP kthread
+ * for this CPU's group has not yet been created, spawn it as well.
  */
 static void rcu_spawn_one_nocb_kthread(int cpu)
 {
-	struct rcu_data *rdp;
-	struct rcu_data *rdp_last;
-	struct rcu_data *rdp_old_leader;
-	struct rcu_data *rdp_spawn = per_cpu_ptr(&rcu_data, cpu);
+	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+	struct rcu_data *rdp_gp;
 	struct task_struct *t;
 
 	/*
 	 * If this isn't a no-CBs CPU or if it already has an rcuo kthread,
 	 * then nothing to do.
 	 */
-	if (!rcu_is_nocb_cpu(cpu) || rdp_spawn->nocb_cb_kthread)
+	if (!rcu_is_nocb_cpu(cpu) || rdp->nocb_cb_kthread)
 		return;
 
 	/* If we didn't spawn the GP kthread first, reorganize! */
-	rdp_old_leader = rdp_spawn->nocb_gp_rdp;
-	if (rdp_old_leader != rdp_spawn && !rdp_old_leader->nocb_cb_kthread) {
-		rdp_last = NULL;
-		rdp = rdp_old_leader;
-		do {
-			rdp->nocb_gp_rdp = rdp_spawn;
-			if (rdp_last && rdp != rdp_spawn)
-				rdp_last->nocb_next_cb_rdp = rdp;
-			if (rdp == rdp_spawn) {
-				rdp = rdp->nocb_next_cb_rdp;
-			} else {
-				rdp_last = rdp;
-				rdp = rdp->nocb_next_cb_rdp;
-				rdp_last->nocb_next_cb_rdp = NULL;
-			}
-		} while (rdp);
-		rdp_spawn->nocb_next_cb_rdp = rdp_old_leader;
+	rdp_gp = rdp->nocb_gp_rdp;
+	if (!rdp_gp->nocb_gp_kthread) {
+		t = kthread_run(rcu_nocb_gp_kthread, rdp_gp,
+				"rcuog/%d", rdp_gp->cpu);
+		if (WARN_ONCE(IS_ERR(t), "%s: Could not start rcuo GP kthread, OOM is now expected behavior\n", __func__))
+			return;
+		WRITE_ONCE(rdp_gp->nocb_gp_kthread, t);
 	}
 
 	/* Spawn the kthread for this CPU. */
-	t = kthread_run(rcu_nocb_kthread, rdp_spawn,
+	t = kthread_run(rcu_nocb_cb_kthread, rdp,
 			"rcuo%c/%d", rcu_state.abbr, cpu);
-	if (WARN_ONCE(IS_ERR(t), "%s: Could not start rcuo kthread, OOM is now expected behavior\n", __func__))
+	if (WARN_ONCE(IS_ERR(t), "%s: Could not start rcuo CB kthread, OOM is now expected behavior\n", __func__))
 		return;
-	WRITE_ONCE(rdp_spawn->nocb_cb_kthread, t);
+	WRITE_ONCE(rdp->nocb_cb_kthread, t);
+	WRITE_ONCE(rdp->nocb_gp_kthread, rdp_gp->nocb_gp_kthread);
 }
 
 /*
-- 
2.17.1

