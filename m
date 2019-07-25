Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F6DC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 15:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A8C82238C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 15:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="lgaes2QJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389658AbfGYP7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 11:59:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44407 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387874AbfGYP7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 11:59:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PFx2Vs1070232
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 08:59:02 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PFx2Vs1070232
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564070342;
        bh=UKexf2P9GfMFpEB6dCjNhYZhf8gBXH0/Ipb096LNfYY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=lgaes2QJAyJsCXNi9eIUTF6R4Rqc2yhgSCp2v2HMQV8ORXTzkHqMwlvKlTpW/saNn
         8C6eo8gxgcBmLdjXKxeS4Jx9t6YD/riQm2NYQaaH3ozpZ/h1bBj3TuFQwLCCa1ccpw
         MuF2b+CT3/XkhwZIbOBeFq+/dEcZSK7U42msM/alX4f/gxwFujCn1shfswvVPaUpjG
         ahy90jx+rPxRIpAvNATgXSF3Ot67p4oRd0NrJhUVHBY1YwXBu/625xnDbaGPEYuNzU
         jIVPyZm+IS5ij9EB7/2sNmIJDo6xMAplZPTEmgHcuIvGjwwziQcnukE0XlRCdNyTvK
         Vd6d3kXx1rnzQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PFx1jA1070228;
        Thu, 25 Jul 2019 08:59:01 -0700
Date:   Thu, 25 Jul 2019 08:59:01 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jann Horn <tipbot@zytor.com>
Message-ID: <tip-cb361d8cdef69990f6b4504dc1fd9a594d983c97@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, pmladek@suse.com, mingo@kernel.org,
        tglx@linutronix.de, will@kernel.org, hpa@zytor.com,
        sergey.senozhatsky@gmail.com, peterz@infradead.org,
        jannh@google.com, torvalds@linux-foundation.org
Reply-To: sergey.senozhatsky@gmail.com, peterz@infradead.org,
          jannh@google.com, torvalds@linux-foundation.org,
          linux-kernel@vger.kernel.org, pmladek@suse.com, mingo@kernel.org,
          tglx@linutronix.de, will@kernel.org, hpa@zytor.com
In-Reply-To: <20190716152047.14424-3-jannh@google.com>
References: <20190716152047.14424-3-jannh@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Use RCU accessors consistently for
 ->numa_group
Git-Commit-ID: cb361d8cdef69990f6b4504dc1fd9a594d983c97
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  cb361d8cdef69990f6b4504dc1fd9a594d983c97
Gitweb:     https://git.kernel.org/tip/cb361d8cdef69990f6b4504dc1fd9a594d983c97
Author:     Jann Horn <jannh@google.com>
AuthorDate: Tue, 16 Jul 2019 17:20:47 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 25 Jul 2019 15:37:05 +0200

sched/fair: Use RCU accessors consistently for ->numa_group

The old code used RCU annotations and accessors inconsistently for
->numa_group, which can lead to use-after-frees and NULL dereferences.

Let all accesses to ->numa_group use proper RCU helpers to prevent such
issues.

Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Fixes: 8c8a743c5087 ("sched/numa: Use {cpu, pid} to create task groups for shared faults")
Link: https://lkml.kernel.org/r/20190716152047.14424-3-jannh@google.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/sched.h |  10 ++++-
 kernel/sched/fair.c   | 120 ++++++++++++++++++++++++++++++++++----------------
 2 files changed, 90 insertions(+), 40 deletions(-)

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
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6adb0e0f5feb..bc9cfeaac8bd 100644
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
 
@@ -2362,7 +2399,8 @@ no_join:
  */
 void task_numa_free(struct task_struct *p, bool final)
 {
-	struct numa_group *grp = p->numa_group;
+	/* safe: p either is current or is being freed by current */
+	struct numa_group *grp = rcu_dereference_raw(p->numa_group);
 	unsigned long *numa_faults = p->numa_faults;
 	unsigned long flags;
 	int i;
@@ -2442,7 +2480,7 @@ void task_numa_fault(int last_cpupid, int mem_node, int pages, int flags)
 	 * actively using should be counted as local. This allows the
 	 * scan rate to slow down when a workload has settled down.
 	 */
-	ng = p->numa_group;
+	ng = deref_curr_numa_group(p);
 	if (!priv && !local && ng && ng->active_nodes > 1 &&
 				numa_is_active_node(cpu_node, ng) &&
 				numa_is_active_node(mem_node, ng))
@@ -10460,18 +10498,22 @@ void show_numa_stats(struct task_struct *p, struct seq_file *m)
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
