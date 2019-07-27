Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A15C761A8
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 23:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 595E5208E4
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 23:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388088AbfG0Xam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 19:30:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51229 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfG0Xak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 19:30:40 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hrW96-0002M7-TR; Sun, 28 Jul 2019 01:30:37 +0200
Date:   Sat, 27 Jul 2019 23:26:14 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] sched/urgent for 5.3-rc2 
References: <156426997427.6953.14728916479410000420.tglx@nanos.tec.linutronix.de>
Message-ID: <156426997428.6953.5838322278411587557.tglx@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest sched-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

up to:  cb361d8cdef6: sched/fair: Use RCU accessors consistently for ->numa_group

Two fixes for the fair scheduling class:

 - Prevent freeing memory which is accessible by concurrent readers

 - Make the RCU annotations for numa groups consistent

Thanks,

	tglx

------------------>
Jann Horn (2):
      sched/fair: Don't free p->numa_faults with concurrent readers
      sched/fair: Use RCU accessors consistently for ->numa_group


 fs/exec.c                            |   2 +-
 include/linux/sched.h                |  10 ++-
 include/linux/sched/numa_balancing.h |   4 +-
 kernel/fork.c                        |   2 +-
 kernel/sched/fair.c                  | 144 ++++++++++++++++++++++++-----------
 5 files changed, 114 insertions(+), 48 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index c71cbfe6826a..f7f6a140856a 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1828,7 +1828,7 @@ static int __do_execve_file(int fd, struct filename *filename,
 	membarrier_execve(current);
 	rseq_execve(current);
 	acct_update_integrals(current);
-	task_numa_free(current);
+	task_numa_free(current, false);
 	free_bprm(bprm);
 	kfree(pathbuf);
 	if (filename)
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 8dc1811487f5..9f51932bd543 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1092,7 +1092,15 @@ struct task_struct {
 	u64				last_sum_exec_runtime;
 	struct callback_head		numa_work;
 
-	struct numa_group		*numa_group;
+	/*
+	 * This pointer is only modified for current in syscall and
+	 * pagefault context (and for tasks being destroyed), so it can be read
+	 * from any of the following contexts:
+	 *  - RCU read-side critical section
+	 *  - current->numa_group from everywhere
+	 *  - task's runqueue locked, task not running
+	 */
+	struct numa_group __rcu		*numa_group;
 
 	/*
 	 * numa_faults is an array split into four regions:
diff --git a/include/linux/sched/numa_balancing.h b/include/linux/sched/numa_balancing.h
index e7dd04a84ba8..3988762efe15 100644
--- a/include/linux/sched/numa_balancing.h
+++ b/include/linux/sched/numa_balancing.h
@@ -19,7 +19,7 @@
 extern void task_numa_fault(int last_node, int node, int pages, int flags);
 extern pid_t task_numa_group_id(struct task_struct *p);
 extern void set_numabalancing_state(bool enabled);
-extern void task_numa_free(struct task_struct *p);
+extern void task_numa_free(struct task_struct *p, bool final);
 extern bool should_numa_migrate_memory(struct task_struct *p, struct page *page,
 					int src_nid, int dst_cpu);
 #else
@@ -34,7 +34,7 @@ static inline pid_t task_numa_group_id(struct task_struct *p)
 static inline void set_numabalancing_state(bool enabled)
 {
 }
-static inline void task_numa_free(struct task_struct *p)
+static inline void task_numa_free(struct task_struct *p, bool final)
 {
 }
 static inline bool should_numa_migrate_memory(struct task_struct *p,
diff --git a/kernel/fork.c b/kernel/fork.c
index d8ae0f1b4148..2852d0e76ea3 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -726,7 +726,7 @@ void __put_task_struct(struct task_struct *tsk)
 	WARN_ON(tsk == current);
 
 	cgroup_free(tsk);
-	task_numa_free(tsk);
+	task_numa_free(tsk, true);
 	security_task_free(tsk);
 	exit_creds(tsk);
 	delayacct_tsk_free(tsk);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 036be95a87e9..bc9cfeaac8bd 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1086,6 +1086,21 @@ struct numa_group {
 	unsigned long faults[0];
 };
 
+/*
+ * For functions that can be called in multiple contexts that permit reading
+ * ->numa_group (see struct task_struct for locking rules).
+ */
+static struct numa_group *deref_task_numa_group(struct task_struct *p)
+{
+	return rcu_dereference_check(p->numa_group, p == current ||
+		(lockdep_is_held(&task_rq(p)->lock) && !READ_ONCE(p->on_cpu)));
+}
+
+static struct numa_group *deref_curr_numa_group(struct task_struct *p)
+{
+	return rcu_dereference_protected(p->numa_group, p == current);
+}
+
 static inline unsigned long group_faults_priv(struct numa_group *ng);
 static inline unsigned long group_faults_shared(struct numa_group *ng);
 
@@ -1129,10 +1144,12 @@ static unsigned int task_scan_start(struct task_struct *p)
 {
 	unsigned long smin = task_scan_min(p);
 	unsigned long period = smin;
+	struct numa_group *ng;
 
 	/* Scale the maximum scan period with the amount of shared memory. */
-	if (p->numa_group) {
-		struct numa_group *ng = p->numa_group;
+	rcu_read_lock();
+	ng = rcu_dereference(p->numa_group);
+	if (ng) {
 		unsigned long shared = group_faults_shared(ng);
 		unsigned long private = group_faults_priv(ng);
 
@@ -1140,6 +1157,7 @@ static unsigned int task_scan_start(struct task_struct *p)
 		period *= shared + 1;
 		period /= private + shared + 1;
 	}
+	rcu_read_unlock();
 
 	return max(smin, period);
 }
@@ -1148,13 +1166,14 @@ static unsigned int task_scan_max(struct task_struct *p)
 {
 	unsigned long smin = task_scan_min(p);
 	unsigned long smax;
+	struct numa_group *ng;
 
 	/* Watch for min being lower than max due to floor calculations */
 	smax = sysctl_numa_balancing_scan_period_max / task_nr_scan_windows(p);
 
 	/* Scale the maximum scan period with the amount of shared memory. */
-	if (p->numa_group) {
-		struct numa_group *ng = p->numa_group;
+	ng = deref_curr_numa_group(p);
+	if (ng) {
 		unsigned long shared = group_faults_shared(ng);
 		unsigned long private = group_faults_priv(ng);
 		unsigned long period = smax;
@@ -1186,7 +1205,7 @@ void init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
 	p->numa_scan_period		= sysctl_numa_balancing_scan_delay;
 	p->numa_work.next		= &p->numa_work;
 	p->numa_faults			= NULL;
-	p->numa_group			= NULL;
+	RCU_INIT_POINTER(p->numa_group, NULL);
 	p->last_task_numa_placement	= 0;
 	p->last_sum_exec_runtime	= 0;
 
@@ -1233,7 +1252,16 @@ static void account_numa_dequeue(struct rq *rq, struct task_struct *p)
 
 pid_t task_numa_group_id(struct task_struct *p)
 {
-	return p->numa_group ? p->numa_group->gid : 0;
+	struct numa_group *ng;
+	pid_t gid = 0;
+
+	rcu_read_lock();
+	ng = rcu_dereference(p->numa_group);
+	if (ng)
+		gid = ng->gid;
+	rcu_read_unlock();
+
+	return gid;
 }
 
 /*
@@ -1258,11 +1286,13 @@ static inline unsigned long task_faults(struct task_struct *p, int nid)
 
 static inline unsigned long group_faults(struct task_struct *p, int nid)
 {
-	if (!p->numa_group)
+	struct numa_group *ng = deref_task_numa_group(p);
+
+	if (!ng)
 		return 0;
 
-	return p->numa_group->faults[task_faults_idx(NUMA_MEM, nid, 0)] +
-		p->numa_group->faults[task_faults_idx(NUMA_MEM, nid, 1)];
+	return ng->faults[task_faults_idx(NUMA_MEM, nid, 0)] +
+		ng->faults[task_faults_idx(NUMA_MEM, nid, 1)];
 }
 
 static inline unsigned long group_faults_cpu(struct numa_group *group, int nid)
@@ -1400,12 +1430,13 @@ static inline unsigned long task_weight(struct task_struct *p, int nid,
 static inline unsigned long group_weight(struct task_struct *p, int nid,
 					 int dist)
 {
+	struct numa_group *ng = deref_task_numa_group(p);
 	unsigned long faults, total_faults;
 
-	if (!p->numa_group)
+	if (!ng)
 		return 0;
 
-	total_faults = p->numa_group->total_faults;
+	total_faults = ng->total_faults;
 
 	if (!total_faults)
 		return 0;
@@ -1419,7 +1450,7 @@ static inline unsigned long group_weight(struct task_struct *p, int nid,
 bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 				int src_nid, int dst_cpu)
 {
-	struct numa_group *ng = p->numa_group;
+	struct numa_group *ng = deref_curr_numa_group(p);
 	int dst_nid = cpu_to_node(dst_cpu);
 	int last_cpupid, this_cpupid;
 
@@ -1600,13 +1631,14 @@ static bool load_too_imbalanced(long src_load, long dst_load,
 static void task_numa_compare(struct task_numa_env *env,
 			      long taskimp, long groupimp, bool maymove)
 {
+	struct numa_group *cur_ng, *p_ng = deref_curr_numa_group(env->p);
 	struct rq *dst_rq = cpu_rq(env->dst_cpu);
+	long imp = p_ng ? groupimp : taskimp;
 	struct task_struct *cur;
 	long src_load, dst_load;
-	long load;
-	long imp = env->p->numa_group ? groupimp : taskimp;
-	long moveimp = imp;
 	int dist = env->dist;
+	long moveimp = imp;
+	long load;
 
 	if (READ_ONCE(dst_rq->numa_migrate_on))
 		return;
@@ -1645,21 +1677,22 @@ static void task_numa_compare(struct task_numa_env *env,
 	 * If dst and source tasks are in the same NUMA group, or not
 	 * in any group then look only at task weights.
 	 */
-	if (cur->numa_group == env->p->numa_group) {
+	cur_ng = rcu_dereference(cur->numa_group);
+	if (cur_ng == p_ng) {
 		imp = taskimp + task_weight(cur, env->src_nid, dist) -
 		      task_weight(cur, env->dst_nid, dist);
 		/*
 		 * Add some hysteresis to prevent swapping the
 		 * tasks within a group over tiny differences.
 		 */
-		if (cur->numa_group)
+		if (cur_ng)
 			imp -= imp / 16;
 	} else {
 		/*
 		 * Compare the group weights. If a task is all by itself
 		 * (not part of a group), use the task weight instead.
 		 */
-		if (cur->numa_group && env->p->numa_group)
+		if (cur_ng && p_ng)
 			imp += group_weight(cur, env->src_nid, dist) -
 			       group_weight(cur, env->dst_nid, dist);
 		else
@@ -1757,11 +1790,12 @@ static int task_numa_migrate(struct task_struct *p)
 		.best_imp = 0,
 		.best_cpu = -1,
 	};
+	unsigned long taskweight, groupweight;
 	struct sched_domain *sd;
+	long taskimp, groupimp;
+	struct numa_group *ng;
 	struct rq *best_rq;
-	unsigned long taskweight, groupweight;
 	int nid, ret, dist;
-	long taskimp, groupimp;
 
 	/*
 	 * Pick the lowest SD_NUMA domain, as that would have the smallest
@@ -1807,7 +1841,8 @@ static int task_numa_migrate(struct task_struct *p)
 	 *   multiple NUMA nodes; in order to better consolidate the group,
 	 *   we need to check other locations.
 	 */
-	if (env.best_cpu == -1 || (p->numa_group && p->numa_group->active_nodes > 1)) {
+	ng = deref_curr_numa_group(p);
+	if (env.best_cpu == -1 || (ng && ng->active_nodes > 1)) {
 		for_each_online_node(nid) {
 			if (nid == env.src_nid || nid == p->numa_preferred_nid)
 				continue;
@@ -1840,7 +1875,7 @@ static int task_numa_migrate(struct task_struct *p)
 	 * A task that migrated to a second choice node will be better off
 	 * trying for a better one later. Do not set the preferred node here.
 	 */
-	if (p->numa_group) {
+	if (ng) {
 		if (env.best_cpu == -1)
 			nid = env.src_nid;
 		else
@@ -2135,6 +2170,7 @@ static void task_numa_placement(struct task_struct *p)
 	unsigned long total_faults;
 	u64 runtime, period;
 	spinlock_t *group_lock = NULL;
+	struct numa_group *ng;
 
 	/*
 	 * The p->mm->numa_scan_seq field gets updated without
@@ -2152,8 +2188,9 @@ static void task_numa_placement(struct task_struct *p)
 	runtime = numa_get_avg_runtime(p, &period);
 
 	/* If the task is part of a group prevent parallel updates to group stats */
-	if (p->numa_group) {
-		group_lock = &p->numa_group->lock;
+	ng = deref_curr_numa_group(p);
+	if (ng) {
+		group_lock = &ng->lock;
 		spin_lock_irq(group_lock);
 	}
 
@@ -2194,7 +2231,7 @@ static void task_numa_placement(struct task_struct *p)
 			p->numa_faults[cpu_idx] += f_diff;
 			faults += p->numa_faults[mem_idx];
 			p->total_numa_faults += diff;
-			if (p->numa_group) {
+			if (ng) {
 				/*
 				 * safe because we can only change our own group
 				 *
@@ -2202,14 +2239,14 @@ static void task_numa_placement(struct task_struct *p)
 				 * nid and priv in a specific region because it
 				 * is at the beginning of the numa_faults array.
 				 */
-				p->numa_group->faults[mem_idx] += diff;
-				p->numa_group->faults_cpu[mem_idx] += f_diff;
-				p->numa_group->total_faults += diff;
-				group_faults += p->numa_group->faults[mem_idx];
+				ng->faults[mem_idx] += diff;
+				ng->faults_cpu[mem_idx] += f_diff;
+				ng->total_faults += diff;
+				group_faults += ng->faults[mem_idx];
 			}
 		}
 
-		if (!p->numa_group) {
+		if (!ng) {
 			if (faults > max_faults) {
 				max_faults = faults;
 				max_nid = nid;
@@ -2220,8 +2257,8 @@ static void task_numa_placement(struct task_struct *p)
 		}
 	}
 
-	if (p->numa_group) {
-		numa_group_count_active_nodes(p->numa_group);
+	if (ng) {
+		numa_group_count_active_nodes(ng);
 		spin_unlock_irq(group_lock);
 		max_nid = preferred_group_nid(p, max_nid);
 	}
@@ -2255,7 +2292,7 @@ static void task_numa_group(struct task_struct *p, int cpupid, int flags,
 	int cpu = cpupid_to_cpu(cpupid);
 	int i;
 
-	if (unlikely(!p->numa_group)) {
+	if (unlikely(!deref_curr_numa_group(p))) {
 		unsigned int size = sizeof(struct numa_group) +
 				    4*nr_node_ids*sizeof(unsigned long);
 
@@ -2291,7 +2328,7 @@ static void task_numa_group(struct task_struct *p, int cpupid, int flags,
 	if (!grp)
 		goto no_join;
 
-	my_grp = p->numa_group;
+	my_grp = deref_curr_numa_group(p);
 	if (grp == my_grp)
 		goto no_join;
 
@@ -2353,13 +2390,24 @@ static void task_numa_group(struct task_struct *p, int cpupid, int flags,
 	return;
 }
 
-void task_numa_free(struct task_struct *p)
+/*
+ * Get rid of NUMA staticstics associated with a task (either current or dead).
+ * If @final is set, the task is dead and has reached refcount zero, so we can
+ * safely free all relevant data structures. Otherwise, there might be
+ * concurrent reads from places like load balancing and procfs, and we should
+ * reset the data back to default state without freeing ->numa_faults.
+ */
+void task_numa_free(struct task_struct *p, bool final)
 {
-	struct numa_group *grp = p->numa_group;
-	void *numa_faults = p->numa_faults;
+	/* safe: p either is current or is being freed by current */
+	struct numa_group *grp = rcu_dereference_raw(p->numa_group);
+	unsigned long *numa_faults = p->numa_faults;
 	unsigned long flags;
 	int i;
 
+	if (!numa_faults)
+		return;
+
 	if (grp) {
 		spin_lock_irqsave(&grp->lock, flags);
 		for (i = 0; i < NR_NUMA_HINT_FAULT_STATS * nr_node_ids; i++)
@@ -2372,8 +2420,14 @@ void task_numa_free(struct task_struct *p)
 		put_numa_group(grp);
 	}
 
-	p->numa_faults = NULL;
-	kfree(numa_faults);
+	if (final) {
+		p->numa_faults = NULL;
+		kfree(numa_faults);
+	} else {
+		p->total_numa_faults = 0;
+		for (i = 0; i < NR_NUMA_HINT_FAULT_STATS * nr_node_ids; i++)
+			numa_faults[i] = 0;
+	}
 }
 
 /*
@@ -2426,7 +2480,7 @@ void task_numa_fault(int last_cpupid, int mem_node, int pages, int flags)
 	 * actively using should be counted as local. This allows the
 	 * scan rate to slow down when a workload has settled down.
 	 */
-	ng = p->numa_group;
+	ng = deref_curr_numa_group(p);
 	if (!priv && !local && ng && ng->active_nodes > 1 &&
 				numa_is_active_node(cpu_node, ng) &&
 				numa_is_active_node(mem_node, ng))
@@ -10444,18 +10498,22 @@ void show_numa_stats(struct task_struct *p, struct seq_file *m)
 {
 	int node;
 	unsigned long tsf = 0, tpf = 0, gsf = 0, gpf = 0;
+	struct numa_group *ng;
 
+	rcu_read_lock();
+	ng = rcu_dereference(p->numa_group);
 	for_each_online_node(node) {
 		if (p->numa_faults) {
 			tsf = p->numa_faults[task_faults_idx(NUMA_MEM, node, 0)];
 			tpf = p->numa_faults[task_faults_idx(NUMA_MEM, node, 1)];
 		}
-		if (p->numa_group) {
-			gsf = p->numa_group->faults[task_faults_idx(NUMA_MEM, node, 0)],
-			gpf = p->numa_group->faults[task_faults_idx(NUMA_MEM, node, 1)];
+		if (ng) {
+			gsf = ng->faults[task_faults_idx(NUMA_MEM, node, 0)],
+			gpf = ng->faults[task_faults_idx(NUMA_MEM, node, 1)];
 		}
 		print_numa_stats(m, node, tsf, tpf, gsf, gpf);
 	}
+	rcu_read_unlock();
 }
 #endif /* CONFIG_NUMA_BALANCING */
 #endif /* CONFIG_SCHED_DEBUG */

