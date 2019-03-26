Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030AFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A6782087E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733085AbfCZXWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 19:22:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41562 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732923AbfCZXWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 19:22:37 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QNIc1l047425
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 19:22:33 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rfst61273-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 19:22:33 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Mar 2019 23:22:32 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Mar 2019 23:22:27 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2QNMQUc17301622
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 23:22:26 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E4D41B2066;
        Tue, 26 Mar 2019 23:22:25 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E8AAB2064;
        Tue, 26 Mar 2019 23:22:25 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Mar 2019 23:22:25 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id BE02E16C60F8; Tue, 26 Mar 2019 16:22:26 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 03/11] rcu: Move RCU CPU stall-warning code out of tree.c
Date:   Tue, 26 Mar 2019 16:22:17 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190326232208.GA20384@linux.ibm.com>
References: <20190326232208.GA20384@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19032623-0072-0000-0000-00000410BB50
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010820; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000282; SDB=6.01180136; UDB=6.00617574; IPR=6.00960851;
 MB=3.00026169; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-26 23:22:31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032623-0073-0000-0000-00004B9D5B96
Message-Id: <20190326232225.21332-3-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-26_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=15 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903260157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit completes the process of consolidating the code for RCU CPU
stall warnings for normal grace periods by moving the remaining such
code from kernel/rcu/tree.c to kernel/rcu/tree_stall.h.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/tree.c       | 291 ---------------------------------------
 kernel/rcu/tree.h       |  10 +-
 kernel/rcu/tree_stall.h | 292 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 299 insertions(+), 294 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 424d50ccf9e6..001dd05f6e38 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -102,8 +102,6 @@ int rcu_num_lvls __read_mostly = RCU_NUM_LVLS;
 /* Number of rcu_nodes at specified level. */
 int num_rcu_lvl[] = NUM_RCU_LVL_INIT;
 int rcu_num_nodes __read_mostly = NUM_RCU_NODES; /* Total # rcu_nodes in use. */
-/* panic() on RCU Stall sysctl. */
-int sysctl_panic_on_rcu_stall __read_mostly;
 /* Commandeer a sysrq key to dump RCU's tree. */
 static bool sysrq_rcu;
 module_param(sysrq_rcu, bool, 0444);
@@ -1167,295 +1165,6 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 	return 0;
 }
 
-static void record_gp_stall_check_time(void)
-{
-	unsigned long j = jiffies;
-	unsigned long j1;
-
-	rcu_state.gp_start = j;
-	j1 = rcu_jiffies_till_stall_check();
-	/* Record ->gp_start before ->jiffies_stall. */
-	smp_store_release(&rcu_state.jiffies_stall, j + j1); /* ^^^ */
-	rcu_state.jiffies_resched = j + j1 / 2;
-	rcu_state.n_force_qs_gpstart = READ_ONCE(rcu_state.n_force_qs);
-}
-
-/*
- * Complain about starvation of grace-period kthread.
- */
-static void rcu_check_gp_kthread_starvation(void)
-{
-	struct task_struct *gpk = rcu_state.gp_kthread;
-	unsigned long j;
-
-	j = jiffies - READ_ONCE(rcu_state.gp_activity);
-	if (j > 2 * HZ) {
-		pr_err("%s kthread starved for %ld jiffies! g%ld f%#x %s(%d) ->state=%#lx ->cpu=%d\n",
-		       rcu_state.name, j,
-		       (long)rcu_seq_current(&rcu_state.gp_seq),
-		       READ_ONCE(rcu_state.gp_flags),
-		       gp_state_getname(rcu_state.gp_state), rcu_state.gp_state,
-		       gpk ? gpk->state : ~0, gpk ? task_cpu(gpk) : -1);
-		if (gpk) {
-			pr_err("RCU grace-period kthread stack dump:\n");
-			sched_show_task(gpk);
-			wake_up_process(gpk);
-		}
-	}
-}
-
-/*
- * Dump stacks of all tasks running on stalled CPUs.  First try using
- * NMIs, but fall back to manual remote stack tracing on architectures
- * that don't support NMI-based stack dumps.  The NMI-triggered stack
- * traces are more accurate because they are printed by the target CPU.
- */
-static void rcu_dump_cpu_stacks(void)
-{
-	int cpu;
-	unsigned long flags;
-	struct rcu_node *rnp;
-
-	rcu_for_each_leaf_node(rnp) {
-		raw_spin_lock_irqsave_rcu_node(rnp, flags);
-		for_each_leaf_node_possible_cpu(rnp, cpu)
-			if (rnp->qsmask & leaf_node_cpu_bit(rnp, cpu))
-				if (!trigger_single_cpu_backtrace(cpu))
-					dump_cpu_task(cpu);
-		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
-	}
-}
-
-/*
- * If too much time has passed in the current grace period, and if
- * so configured, go kick the relevant kthreads.
- */
-static void rcu_stall_kick_kthreads(void)
-{
-	unsigned long j;
-
-	if (!rcu_kick_kthreads)
-		return;
-	j = READ_ONCE(rcu_state.jiffies_kick_kthreads);
-	if (time_after(jiffies, j) && rcu_state.gp_kthread &&
-	    (rcu_gp_in_progress() || READ_ONCE(rcu_state.gp_flags))) {
-		WARN_ONCE(1, "Kicking %s grace-period kthread\n",
-			  rcu_state.name);
-		rcu_ftrace_dump(DUMP_ALL);
-		wake_up_process(rcu_state.gp_kthread);
-		WRITE_ONCE(rcu_state.jiffies_kick_kthreads, j + HZ);
-	}
-}
-
-static void panic_on_rcu_stall(void)
-{
-	if (sysctl_panic_on_rcu_stall)
-		panic("RCU Stall\n");
-}
-
-static void print_other_cpu_stall(unsigned long gp_seq)
-{
-	int cpu;
-	unsigned long flags;
-	unsigned long gpa;
-	unsigned long j;
-	int ndetected = 0;
-	struct rcu_node *rnp = rcu_get_root();
-	long totqlen = 0;
-
-	/* Kick and suppress, if so configured. */
-	rcu_stall_kick_kthreads();
-	if (rcu_cpu_stall_suppress)
-		return;
-
-	/*
-	 * OK, time to rat on our buddy...
-	 * See Documentation/RCU/stallwarn.txt for info on how to debug
-	 * RCU CPU stall warnings.
-	 */
-	pr_err("INFO: %s detected stalls on CPUs/tasks:", rcu_state.name);
-	print_cpu_stall_info_begin();
-	rcu_for_each_leaf_node(rnp) {
-		raw_spin_lock_irqsave_rcu_node(rnp, flags);
-		ndetected += rcu_print_task_stall(rnp);
-		if (rnp->qsmask != 0) {
-			for_each_leaf_node_possible_cpu(rnp, cpu)
-				if (rnp->qsmask & leaf_node_cpu_bit(rnp, cpu)) {
-					print_cpu_stall_info(cpu);
-					ndetected++;
-				}
-		}
-		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
-	}
-
-	print_cpu_stall_info_end();
-	for_each_possible_cpu(cpu)
-		totqlen += rcu_get_n_cbs_cpu(cpu);
-	pr_cont("(detected by %d, t=%ld jiffies, g=%ld, q=%lu)\n",
-	       smp_processor_id(), (long)(jiffies - rcu_state.gp_start),
-	       (long)rcu_seq_current(&rcu_state.gp_seq), totqlen);
-	if (ndetected) {
-		rcu_dump_cpu_stacks();
-
-		/* Complain about tasks blocking the grace period. */
-		rcu_print_detail_task_stall();
-	} else {
-		if (rcu_seq_current(&rcu_state.gp_seq) != gp_seq) {
-			pr_err("INFO: Stall ended before state dump start\n");
-		} else {
-			j = jiffies;
-			gpa = READ_ONCE(rcu_state.gp_activity);
-			pr_err("All QSes seen, last %s kthread activity %ld (%ld-%ld), jiffies_till_next_fqs=%ld, root ->qsmask %#lx\n",
-			       rcu_state.name, j - gpa, j, gpa,
-			       READ_ONCE(jiffies_till_next_fqs),
-			       rcu_get_root()->qsmask);
-			/* In this case, the current CPU might be at fault. */
-			sched_show_task(current);
-		}
-	}
-	/* Rewrite if needed in case of slow consoles. */
-	if (ULONG_CMP_GE(jiffies, READ_ONCE(rcu_state.jiffies_stall)))
-		WRITE_ONCE(rcu_state.jiffies_stall,
-			   jiffies + 3 * rcu_jiffies_till_stall_check() + 3);
-
-	rcu_check_gp_kthread_starvation();
-
-	panic_on_rcu_stall();
-
-	rcu_force_quiescent_state();  /* Kick them all. */
-}
-
-static void print_cpu_stall(void)
-{
-	int cpu;
-	unsigned long flags;
-	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
-	struct rcu_node *rnp = rcu_get_root();
-	long totqlen = 0;
-
-	/* Kick and suppress, if so configured. */
-	rcu_stall_kick_kthreads();
-	if (rcu_cpu_stall_suppress)
-		return;
-
-	/*
-	 * OK, time to rat on ourselves...
-	 * See Documentation/RCU/stallwarn.txt for info on how to debug
-	 * RCU CPU stall warnings.
-	 */
-	pr_err("INFO: %s self-detected stall on CPU", rcu_state.name);
-	print_cpu_stall_info_begin();
-	raw_spin_lock_irqsave_rcu_node(rdp->mynode, flags);
-	print_cpu_stall_info(smp_processor_id());
-	raw_spin_unlock_irqrestore_rcu_node(rdp->mynode, flags);
-	print_cpu_stall_info_end();
-	for_each_possible_cpu(cpu)
-		totqlen += rcu_get_n_cbs_cpu(cpu);
-	pr_cont(" (t=%lu jiffies g=%ld q=%lu)\n",
-		jiffies - rcu_state.gp_start,
-		(long)rcu_seq_current(&rcu_state.gp_seq), totqlen);
-
-	rcu_check_gp_kthread_starvation();
-
-	rcu_dump_cpu_stacks();
-
-	raw_spin_lock_irqsave_rcu_node(rnp, flags);
-	/* Rewrite if needed in case of slow consoles. */
-	if (ULONG_CMP_GE(jiffies, READ_ONCE(rcu_state.jiffies_stall)))
-		WRITE_ONCE(rcu_state.jiffies_stall,
-			   jiffies + 3 * rcu_jiffies_till_stall_check() + 3);
-	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
-
-	panic_on_rcu_stall();
-
-	/*
-	 * Attempt to revive the RCU machinery by forcing a context switch.
-	 *
-	 * A context switch would normally allow the RCU state machine to make
-	 * progress and it could be we're stuck in kernel space without context
-	 * switches for an entirely unreasonable amount of time.
-	 */
-	set_tsk_need_resched(current);
-	set_preempt_need_resched();
-}
-
-static void check_cpu_stall(struct rcu_data *rdp)
-{
-	unsigned long gs1;
-	unsigned long gs2;
-	unsigned long gps;
-	unsigned long j;
-	unsigned long jn;
-	unsigned long js;
-	struct rcu_node *rnp;
-
-	if ((rcu_cpu_stall_suppress && !rcu_kick_kthreads) ||
-	    !rcu_gp_in_progress())
-		return;
-	rcu_stall_kick_kthreads();
-	j = jiffies;
-
-	/*
-	 * Lots of memory barriers to reject false positives.
-	 *
-	 * The idea is to pick up rcu_state.gp_seq, then
-	 * rcu_state.jiffies_stall, then rcu_state.gp_start, and finally
-	 * another copy of rcu_state.gp_seq.  These values are updated in
-	 * the opposite order with memory barriers (or equivalent) during
-	 * grace-period initialization and cleanup.  Now, a false positive
-	 * can occur if we get an new value of rcu_state.gp_start and a old
-	 * value of rcu_state.jiffies_stall.  But given the memory barriers,
-	 * the only way that this can happen is if one grace period ends
-	 * and another starts between these two fetches.  This is detected
-	 * by comparing the second fetch of rcu_state.gp_seq with the
-	 * previous fetch from rcu_state.gp_seq.
-	 *
-	 * Given this check, comparisons of jiffies, rcu_state.jiffies_stall,
-	 * and rcu_state.gp_start suffice to forestall false positives.
-	 */
-	gs1 = READ_ONCE(rcu_state.gp_seq);
-	smp_rmb(); /* Pick up ->gp_seq first... */
-	js = READ_ONCE(rcu_state.jiffies_stall);
-	smp_rmb(); /* ...then ->jiffies_stall before the rest... */
-	gps = READ_ONCE(rcu_state.gp_start);
-	smp_rmb(); /* ...and finally ->gp_start before ->gp_seq again. */
-	gs2 = READ_ONCE(rcu_state.gp_seq);
-	if (gs1 != gs2 ||
-	    ULONG_CMP_LT(j, js) ||
-	    ULONG_CMP_GE(gps, js))
-		return; /* No stall or GP completed since entering function. */
-	rnp = rdp->mynode;
-	jn = jiffies + 3 * rcu_jiffies_till_stall_check() + 3;
-	if (rcu_gp_in_progress() &&
-	    (READ_ONCE(rnp->qsmask) & rdp->grpmask) &&
-	    cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
-
-		/* We haven't checked in, so go dump stack. */
-		print_cpu_stall();
-
-	} else if (rcu_gp_in_progress() &&
-		   ULONG_CMP_GE(j, js + RCU_STALL_RAT_DELAY) &&
-		   cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
-
-		/* They had a few time units to dump stack, so complain. */
-		print_other_cpu_stall(gs2);
-	}
-}
-
-/**
- * rcu_cpu_stall_reset - prevent further stall warnings in current grace period
- *
- * Set the stall-warning timeout way off into the future, thus preventing
- * any RCU CPU stall-warning messages from appearing in the current set of
- * RCU grace periods.
- *
- * The caller must disable hard irqs.
- */
-void rcu_cpu_stall_reset(void)
-{
-	WRITE_ONCE(rcu_state.jiffies_stall, jiffies + ULONG_MAX / 2);
-}
-
 /* Trace-event wrapper function for trace_rcu_future_grace_period.  */
 static void trace_rcu_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
 			      unsigned long gp_seq_req, const char *s)
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index bb4f995f2d3f..3c4e26fff806 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -393,15 +393,13 @@ static const char *tp_rcu_varname __used __tracepoint_string = rcu_name;
 
 int rcu_dynticks_snap(struct rcu_data *rdp);
 
-/* Forward declarations for rcutree_plugin.h */
+/* Forward declarations for tree_plugin.h */
 static void rcu_bootup_announce(void);
 static void rcu_qs(void);
 static int rcu_preempt_blocked_readers_cgp(struct rcu_node *rnp);
 #ifdef CONFIG_HOTPLUG_CPU
 static bool rcu_preempt_has_tasks(struct rcu_node *rnp);
 #endif /* #ifdef CONFIG_HOTPLUG_CPU */
-static void rcu_print_detail_task_stall(void);
-static int rcu_print_task_stall(struct rcu_node *rnp);
 static int rcu_print_task_exp_stall(struct rcu_node *rnp);
 static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp);
 static void rcu_flavor_sched_clock_irq(int user);
@@ -445,3 +443,9 @@ static void rcu_bind_gp_kthread(void);
 static bool rcu_nohz_full_cpu(void);
 static void rcu_dynticks_task_enter(void);
 static void rcu_dynticks_task_exit(void);
+
+/* Forward declarations for tree_stall.h */
+static void rcu_print_detail_task_stall(void);
+static int rcu_print_task_stall(struct rcu_node *rnp);
+static void record_gp_stall_check_time(void);
+static void check_cpu_stall(struct rcu_data *rdp);
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 6f5f94944f49..e0e73f493363 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -8,6 +8,9 @@
  */
 
 
+/* panic() on RCU Stall sysctl. */
+int sysctl_panic_on_rcu_stall __read_mostly;
+
 #ifdef CONFIG_PROVE_RCU
 #define RCU_STALL_DELAY_DELTA	       (5 * HZ)
 #else
@@ -156,3 +159,292 @@ static int rcu_print_task_stall(struct rcu_node *rnp)
 	return 0;
 }
 #endif /* #else #ifdef CONFIG_PREEMPT */
+
+static void record_gp_stall_check_time(void)
+{
+	unsigned long j = jiffies;
+	unsigned long j1;
+
+	rcu_state.gp_start = j;
+	j1 = rcu_jiffies_till_stall_check();
+	/* Record ->gp_start before ->jiffies_stall. */
+	smp_store_release(&rcu_state.jiffies_stall, j + j1); /* ^^^ */
+	rcu_state.jiffies_resched = j + j1 / 2;
+	rcu_state.n_force_qs_gpstart = READ_ONCE(rcu_state.n_force_qs);
+}
+
+/*
+ * Complain about starvation of grace-period kthread.
+ */
+static void rcu_check_gp_kthread_starvation(void)
+{
+	struct task_struct *gpk = rcu_state.gp_kthread;
+	unsigned long j;
+
+	j = jiffies - READ_ONCE(rcu_state.gp_activity);
+	if (j > 2 * HZ) {
+		pr_err("%s kthread starved for %ld jiffies! g%ld f%#x %s(%d) ->state=%#lx ->cpu=%d\n",
+		       rcu_state.name, j,
+		       (long)rcu_seq_current(&rcu_state.gp_seq),
+		       READ_ONCE(rcu_state.gp_flags),
+		       gp_state_getname(rcu_state.gp_state), rcu_state.gp_state,
+		       gpk ? gpk->state : ~0, gpk ? task_cpu(gpk) : -1);
+		if (gpk) {
+			pr_err("RCU grace-period kthread stack dump:\n");
+			sched_show_task(gpk);
+			wake_up_process(gpk);
+		}
+	}
+}
+
+/*
+ * Dump stacks of all tasks running on stalled CPUs.  First try using
+ * NMIs, but fall back to manual remote stack tracing on architectures
+ * that don't support NMI-based stack dumps.  The NMI-triggered stack
+ * traces are more accurate because they are printed by the target CPU.
+ */
+static void rcu_dump_cpu_stacks(void)
+{
+	int cpu;
+	unsigned long flags;
+	struct rcu_node *rnp;
+
+	rcu_for_each_leaf_node(rnp) {
+		raw_spin_lock_irqsave_rcu_node(rnp, flags);
+		for_each_leaf_node_possible_cpu(rnp, cpu)
+			if (rnp->qsmask & leaf_node_cpu_bit(rnp, cpu))
+				if (!trigger_single_cpu_backtrace(cpu))
+					dump_cpu_task(cpu);
+		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+	}
+}
+
+/*
+ * If too much time has passed in the current grace period, and if
+ * so configured, go kick the relevant kthreads.
+ */
+static void rcu_stall_kick_kthreads(void)
+{
+	unsigned long j;
+
+	if (!rcu_kick_kthreads)
+		return;
+	j = READ_ONCE(rcu_state.jiffies_kick_kthreads);
+	if (time_after(jiffies, j) && rcu_state.gp_kthread &&
+	    (rcu_gp_in_progress() || READ_ONCE(rcu_state.gp_flags))) {
+		WARN_ONCE(1, "Kicking %s grace-period kthread\n",
+			  rcu_state.name);
+		rcu_ftrace_dump(DUMP_ALL);
+		wake_up_process(rcu_state.gp_kthread);
+		WRITE_ONCE(rcu_state.jiffies_kick_kthreads, j + HZ);
+	}
+}
+
+static void panic_on_rcu_stall(void)
+{
+	if (sysctl_panic_on_rcu_stall)
+		panic("RCU Stall\n");
+}
+
+static void print_other_cpu_stall(unsigned long gp_seq)
+{
+	int cpu;
+	unsigned long flags;
+	unsigned long gpa;
+	unsigned long j;
+	int ndetected = 0;
+	struct rcu_node *rnp = rcu_get_root();
+	long totqlen = 0;
+
+	/* Kick and suppress, if so configured. */
+	rcu_stall_kick_kthreads();
+	if (rcu_cpu_stall_suppress)
+		return;
+
+	/*
+	 * OK, time to rat on our buddy...
+	 * See Documentation/RCU/stallwarn.txt for info on how to debug
+	 * RCU CPU stall warnings.
+	 */
+	pr_err("INFO: %s detected stalls on CPUs/tasks:", rcu_state.name);
+	print_cpu_stall_info_begin();
+	rcu_for_each_leaf_node(rnp) {
+		raw_spin_lock_irqsave_rcu_node(rnp, flags);
+		ndetected += rcu_print_task_stall(rnp);
+		if (rnp->qsmask != 0) {
+			for_each_leaf_node_possible_cpu(rnp, cpu)
+				if (rnp->qsmask & leaf_node_cpu_bit(rnp, cpu)) {
+					print_cpu_stall_info(cpu);
+					ndetected++;
+				}
+		}
+		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+	}
+
+	print_cpu_stall_info_end();
+	for_each_possible_cpu(cpu)
+		totqlen += rcu_get_n_cbs_cpu(cpu);
+	pr_cont("(detected by %d, t=%ld jiffies, g=%ld, q=%lu)\n",
+	       smp_processor_id(), (long)(jiffies - rcu_state.gp_start),
+	       (long)rcu_seq_current(&rcu_state.gp_seq), totqlen);
+	if (ndetected) {
+		rcu_dump_cpu_stacks();
+
+		/* Complain about tasks blocking the grace period. */
+		rcu_print_detail_task_stall();
+	} else {
+		if (rcu_seq_current(&rcu_state.gp_seq) != gp_seq) {
+			pr_err("INFO: Stall ended before state dump start\n");
+		} else {
+			j = jiffies;
+			gpa = READ_ONCE(rcu_state.gp_activity);
+			pr_err("All QSes seen, last %s kthread activity %ld (%ld-%ld), jiffies_till_next_fqs=%ld, root ->qsmask %#lx\n",
+			       rcu_state.name, j - gpa, j, gpa,
+			       READ_ONCE(jiffies_till_next_fqs),
+			       rcu_get_root()->qsmask);
+			/* In this case, the current CPU might be at fault. */
+			sched_show_task(current);
+		}
+	}
+	/* Rewrite if needed in case of slow consoles. */
+	if (ULONG_CMP_GE(jiffies, READ_ONCE(rcu_state.jiffies_stall)))
+		WRITE_ONCE(rcu_state.jiffies_stall,
+			   jiffies + 3 * rcu_jiffies_till_stall_check() + 3);
+
+	rcu_check_gp_kthread_starvation();
+
+	panic_on_rcu_stall();
+
+	rcu_force_quiescent_state();  /* Kick them all. */
+}
+
+static void print_cpu_stall(void)
+{
+	int cpu;
+	unsigned long flags;
+	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
+	struct rcu_node *rnp = rcu_get_root();
+	long totqlen = 0;
+
+	/* Kick and suppress, if so configured. */
+	rcu_stall_kick_kthreads();
+	if (rcu_cpu_stall_suppress)
+		return;
+
+	/*
+	 * OK, time to rat on ourselves...
+	 * See Documentation/RCU/stallwarn.txt for info on how to debug
+	 * RCU CPU stall warnings.
+	 */
+	pr_err("INFO: %s self-detected stall on CPU", rcu_state.name);
+	print_cpu_stall_info_begin();
+	raw_spin_lock_irqsave_rcu_node(rdp->mynode, flags);
+	print_cpu_stall_info(smp_processor_id());
+	raw_spin_unlock_irqrestore_rcu_node(rdp->mynode, flags);
+	print_cpu_stall_info_end();
+	for_each_possible_cpu(cpu)
+		totqlen += rcu_get_n_cbs_cpu(cpu);
+	pr_cont(" (t=%lu jiffies g=%ld q=%lu)\n",
+		jiffies - rcu_state.gp_start,
+		(long)rcu_seq_current(&rcu_state.gp_seq), totqlen);
+
+	rcu_check_gp_kthread_starvation();
+
+	rcu_dump_cpu_stacks();
+
+	raw_spin_lock_irqsave_rcu_node(rnp, flags);
+	/* Rewrite if needed in case of slow consoles. */
+	if (ULONG_CMP_GE(jiffies, READ_ONCE(rcu_state.jiffies_stall)))
+		WRITE_ONCE(rcu_state.jiffies_stall,
+			   jiffies + 3 * rcu_jiffies_till_stall_check() + 3);
+	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+
+	panic_on_rcu_stall();
+
+	/*
+	 * Attempt to revive the RCU machinery by forcing a context switch.
+	 *
+	 * A context switch would normally allow the RCU state machine to make
+	 * progress and it could be we're stuck in kernel space without context
+	 * switches for an entirely unreasonable amount of time.
+	 */
+	set_tsk_need_resched(current);
+	set_preempt_need_resched();
+}
+
+static void check_cpu_stall(struct rcu_data *rdp)
+{
+	unsigned long gs1;
+	unsigned long gs2;
+	unsigned long gps;
+	unsigned long j;
+	unsigned long jn;
+	unsigned long js;
+	struct rcu_node *rnp;
+
+	if ((rcu_cpu_stall_suppress && !rcu_kick_kthreads) ||
+	    !rcu_gp_in_progress())
+		return;
+	rcu_stall_kick_kthreads();
+	j = jiffies;
+
+	/*
+	 * Lots of memory barriers to reject false positives.
+	 *
+	 * The idea is to pick up rcu_state.gp_seq, then
+	 * rcu_state.jiffies_stall, then rcu_state.gp_start, and finally
+	 * another copy of rcu_state.gp_seq.  These values are updated in
+	 * the opposite order with memory barriers (or equivalent) during
+	 * grace-period initialization and cleanup.  Now, a false positive
+	 * can occur if we get an new value of rcu_state.gp_start and a old
+	 * value of rcu_state.jiffies_stall.  But given the memory barriers,
+	 * the only way that this can happen is if one grace period ends
+	 * and another starts between these two fetches.  This is detected
+	 * by comparing the second fetch of rcu_state.gp_seq with the
+	 * previous fetch from rcu_state.gp_seq.
+	 *
+	 * Given this check, comparisons of jiffies, rcu_state.jiffies_stall,
+	 * and rcu_state.gp_start suffice to forestall false positives.
+	 */
+	gs1 = READ_ONCE(rcu_state.gp_seq);
+	smp_rmb(); /* Pick up ->gp_seq first... */
+	js = READ_ONCE(rcu_state.jiffies_stall);
+	smp_rmb(); /* ...then ->jiffies_stall before the rest... */
+	gps = READ_ONCE(rcu_state.gp_start);
+	smp_rmb(); /* ...and finally ->gp_start before ->gp_seq again. */
+	gs2 = READ_ONCE(rcu_state.gp_seq);
+	if (gs1 != gs2 ||
+	    ULONG_CMP_LT(j, js) ||
+	    ULONG_CMP_GE(gps, js))
+		return; /* No stall or GP completed since entering function. */
+	rnp = rdp->mynode;
+	jn = jiffies + 3 * rcu_jiffies_till_stall_check() + 3;
+	if (rcu_gp_in_progress() &&
+	    (READ_ONCE(rnp->qsmask) & rdp->grpmask) &&
+	    cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
+
+		/* We haven't checked in, so go dump stack. */
+		print_cpu_stall();
+
+	} else if (rcu_gp_in_progress() &&
+		   ULONG_CMP_GE(j, js + RCU_STALL_RAT_DELAY) &&
+		   cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
+
+		/* They had a few time units to dump stack, so complain. */
+		print_other_cpu_stall(gs2);
+	}
+}
+
+/**
+ * rcu_cpu_stall_reset - prevent further stall warnings in current grace period
+ *
+ * Set the stall-warning timeout way off into the future, thus preventing
+ * any RCU CPU stall-warning messages from appearing in the current set of
+ * RCU grace periods.
+ *
+ * The caller must disable hard irqs.
+ */
+void rcu_cpu_stall_reset(void)
+{
+	WRITE_ONCE(rcu_state.jiffies_stall, jiffies + ULONG_MAX / 2);
+}
-- 
2.17.1

