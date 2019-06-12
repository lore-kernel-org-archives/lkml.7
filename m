Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF295C31E47
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA5720896
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbfFLTcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 15:32:52 -0400
Received: from shelob.surriel.com ([96.67.55.147]:50534 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388159AbfFLTcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 15:32:50 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hb8z2-0001BN-3j; Wed, 12 Jun 2019 15:32:32 -0400
From:   Rik van Riel <riel@surriel.com>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, kernel-team@fb.com,
        morten.rasmussen@arm.com, tglx@linutronix.de,
        dietmar.eggeman@arm.com, mgorman@techsingularity.com,
        vincent.guittot@linaro.org, Rik van Riel <riel@surriel.com>
Subject: [PATCH 8/8] sched,fair: flatten hierarchical runqueues
Date:   Wed, 12 Jun 2019 15:32:27 -0400
Message-Id: <20190612193227.993-9-riel@surriel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190612193227.993-1-riel@surriel.com>
References: <20190612193227.993-1-riel@surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flatten the hierarchical runqueues into just the per CPU rq.cfs runqueue.

Iteration of the sched_entity hierarchy is rate limited to once per jiffy
per sched_entity, which is a smaller change than it seems, because load
average adjustments were already rate limited to once per jiffy before this
patch series.

This patch breaks CONFIG_CFS_BANDWIDTH. The plan for that is to park tasks
from throttled cgroups onto their cgroup runqueues, and slowly (using the
GENTLE_FAIR_SLEEPERS) wake them back up, in vruntime order, once the cgroup
gets unthrottled, to prevent thundering herd issues.

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 include/linux/sched.h |   2 +
 kernel/sched/fair.c   | 478 +++++++++++++++++-------------------------
 kernel/sched/pelt.c   |   6 +-
 kernel/sched/pelt.h   |   2 +-
 kernel/sched/sched.h  |   2 +-
 5 files changed, 194 insertions(+), 296 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index f5bb6948e40c..05ed40b304dc 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -454,6 +454,8 @@ struct sched_entity {
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	int				depth;
 	unsigned long			enqueued_h_load;
+	unsigned long			enqueued_h_weight;
+	struct load_weight		h_load;
 	struct sched_entity		*parent;
 	/* rq on which this entity is (to be) queued: */
 	struct cfs_rq			*cfs_rq;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c2baf3c8a879..29bdfbd4dc2e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -242,6 +242,9 @@ static u64 __calc_delta(u64 delta_exec, unsigned long weight, struct load_weight
 
 
 const struct sched_class fair_sched_class;
+static unsigned long task_se_h_weight(struct sched_entity *se);
+static unsigned long task_se_h_load(struct sched_entity *se);
+static unsigned long task_h_load(struct task_struct *p);
 
 /**************************************************************
  * CFS operations on generic schedulable entities:
@@ -395,7 +398,6 @@ static inline void assert_list_leaf_cfs_rq(struct rq *rq)
 	list_for_each_entry_safe(cfs_rq, pos, &rq->leaf_cfs_rq_list,	\
 				 leaf_cfs_rq_list)
 
-/* Do the two (enqueued) entities belong to the same group ? */
 static inline struct cfs_rq *
 is_same_group(struct sched_entity *se, struct sched_entity *pse)
 {
@@ -410,6 +412,11 @@ static inline struct sched_entity *parent_entity(struct sched_entity *se)
 	return se->parent;
 }
 
+static inline bool task_se_in_cgroup(struct sched_entity *se)
+{
+	return parent_entity(se);
+}
+
 static void
 find_matching_se(struct sched_entity **se, struct sched_entity **pse)
 {
@@ -442,6 +449,19 @@ find_matching_se(struct sched_entity **se, struct sched_entity **pse)
 	}
 }
 
+/* Add the cgroup cfs_rqs to the list, for update_blocked_averages */
+static void enqueue_entity_cfs_rqs(struct sched_entity *se)
+{
+	SCHED_WARN_ON(!entity_is_task(se));
+
+	for_each_sched_entity(se) {
+		struct cfs_rq *cfs_rq = group_cfs_rq_of_parent(se);
+
+		if (list_add_leaf_cfs_rq(cfs_rq))
+			break;
+	}
+}
+
 #else	/* !CONFIG_FAIR_GROUP_SCHED */
 
 static inline struct task_struct *task_of(struct sched_entity *se)
@@ -492,6 +512,11 @@ static inline struct sched_entity *parent_entity(struct sched_entity *se)
 	return NULL;
 }
 
+static inline bool task_se_in_cgroup(struct sched_entity *se)
+{
+	return false;
+}
+
 static inline void
 find_matching_se(struct sched_entity **se, struct sched_entity **pse)
 {
@@ -664,8 +689,14 @@ int sched_proc_update_handler(struct ctl_table *table, int write,
  */
 static inline u64 calc_delta_fair(u64 delta, struct sched_entity *se)
 {
-	if (unlikely(se->load.weight != NICE_0_LOAD))
+	if (task_se_in_cgroup(se)) {
+		unsigned long h_load = task_se_h_load(se);
+		if (h_load != se->h_load.weight)
+			update_load_set(&se->h_load, h_load);
+		delta = __calc_delta(delta, NICE_0_LOAD, &se->h_load);
+	} else if (unlikely(se->load.weight != NICE_0_LOAD)) {
 		delta = __calc_delta(delta, NICE_0_LOAD, &se->load);
+	}
 
 	return delta;
 }
@@ -679,22 +710,16 @@ static inline u64 calc_delta_fair(u64 delta, struct sched_entity *se)
 static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	u64 slice = sysctl_sched_latency;
+	struct load_weight *load = &cfs_rq->load;
+	struct load_weight lw;
 
-	for_each_sched_entity(se) {
-		struct load_weight *load;
-		struct load_weight lw;
+	if (unlikely(!se->on_rq)) {
+		lw = cfs_rq->load;
 
-		cfs_rq = cfs_rq_of(se);
-		load = &cfs_rq->load;
-
-		if (unlikely(!se->on_rq)) {
-			lw = cfs_rq->load;
-
-			update_load_add(&lw, se->load.weight);
-			load = &lw;
-		}
-		slice = __calc_delta(slice, se->load.weight, load);
+		update_load_add(&lw, task_se_h_load(se));
+		load = &lw;
 	}
+	slice = __calc_delta(slice, task_se_h_load(se), load);
 
 	/*
 	 * To avoid cache thrashing, run at least sysctl_sched_min_granularity.
@@ -719,8 +744,6 @@ static u64 sched_vslice(struct cfs_rq *cfs_rq, struct sched_entity *se)
 #ifdef CONFIG_SMP
 
 static int select_idle_sibling(struct task_struct *p, int prev_cpu, int cpu);
-static unsigned long task_se_h_load(struct sched_entity *se);
-static unsigned long task_h_load(struct task_struct *p);
 static unsigned long capacity_of(int cpu);
 
 /* Give new sched_entity start runnable values to heavy its load in infant time */
@@ -2697,16 +2720,28 @@ static inline void update_scan_period(struct task_struct *p, int new_cpu)
 static void
 account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	update_load_add(&cfs_rq->load, se->load.weight);
-	if (!parent_entity(se))
+	struct rq *rq;
+
+	if (task_se_in_cgroup(se)) {
+		struct cfs_rq *cgroup_rq = group_cfs_rq_of_parent(se);
+		unsigned long h_weight;
+
+		update_load_add(&cgroup_rq->load, se->load.weight);
+		cgroup_rq->nr_running++;
+
+		/* Add the hierarchical weight to the CPU rq */
+		h_weight = task_se_h_weight(se);
+		se->enqueued_h_weight = h_weight;
+		update_load_add(&rq_of(cfs_rq)->load, h_weight);
+	} else {
+		update_load_add(&cfs_rq->load, se->load.weight);
 		update_load_add(&rq_of(cfs_rq)->load, se->load.weight);
+	}
 #ifdef CONFIG_SMP
-	if (entity_is_task(se)) {
-		struct rq *rq = rq_of(cfs_rq);
+	rq = rq_of(cfs_rq);
 
-		account_numa_enqueue(rq, task_of(se));
-		list_add(&se->group_node, &rq->cfs_tasks);
-	}
+	account_numa_enqueue(rq, task_of(se));
+	list_add(&se->group_node, &rq->cfs_tasks);
 #endif
 	cfs_rq->nr_running++;
 }
@@ -2714,14 +2749,20 @@ account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 static void
 account_entity_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	update_load_sub(&cfs_rq->load, se->load.weight);
-	if (!parent_entity(se))
+	if (task_se_in_cgroup(se)) {
+		struct cfs_rq *cgroup_rq = group_cfs_rq_of_parent(se);
+
+		update_load_sub(&cgroup_rq->load, se->load.weight);
+		cgroup_rq->nr_running--;
+
+		update_load_sub(&rq_of(cfs_rq)->load, se->enqueued_h_weight);
+	} else {
+		update_load_sub(&cfs_rq->load, se->load.weight);
 		update_load_sub(&rq_of(cfs_rq)->load, se->load.weight);
-#ifdef CONFIG_SMP
-	if (entity_is_task(se)) {
-		account_numa_dequeue(rq_of(cfs_rq), task_of(se));
-		list_del_init(&se->group_node);
 	}
+#ifdef CONFIG_SMP
+	account_numa_dequeue(rq_of(cfs_rq), task_of(se));
+	list_del_init(&se->group_node);
 #endif
 	cfs_rq->nr_running--;
 }
@@ -2816,6 +2857,9 @@ update_runnable_load_avg(struct sched_entity *se)
 static inline void
 enqueue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
+	if (task_se_in_cgroup(se))
+		cfs_rq = group_cfs_rq_of_parent(se);
+
 	cfs_rq->avg.load_avg += se->avg.load_avg;
 	cfs_rq->avg.load_sum += se_weight(se) * se->avg.load_sum;
 }
@@ -2823,6 +2867,9 @@ enqueue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
 static inline void
 dequeue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
+	if (task_se_in_cgroup(se))
+		cfs_rq = group_cfs_rq_of_parent(se);
+
 	sub_positive(&cfs_rq->avg.load_avg, se->avg.load_avg);
 	sub_positive(&cfs_rq->avg.load_sum, se_weight(se) * se->avg.load_sum);
 }
@@ -3449,7 +3496,9 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 	cfs_rq->avg.util_avg += se->avg.util_avg;
 	cfs_rq->avg.util_sum += se->avg.util_sum;
 
-	add_tg_cfs_propagate(cfs_rq, se->avg.load_sum);
+	if (task_se_in_cgroup(se))
+		add_tg_cfs_propagate(group_cfs_rq_of_parent(se),
+						se->avg.load_sum);
 
 	cfs_rq_util_change(cfs_rq, flags);
 }
@@ -3468,7 +3517,9 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 	sub_positive(&cfs_rq->avg.util_avg, se->avg.util_avg);
 	sub_positive(&cfs_rq->avg.util_sum, se->avg.util_sum);
 
-	add_tg_cfs_propagate(cfs_rq, -se->avg.load_sum);
+	if (task_se_in_cgroup(se))
+		add_tg_cfs_propagate(group_cfs_rq_of_parent(se),
+						-se->avg.load_sum);
 
 	cfs_rq_util_change(cfs_rq, 0);
 }
@@ -3479,11 +3530,13 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 #define UPDATE_TG	0x1
 #define SKIP_AGE_LOAD	0x2
 #define DO_ATTACH	0x4
+#define SE_IS_CURRENT	0x8
 
 /* Update task and its cfs_rq load average */
 static inline bool update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
 	u64 now = cfs_rq_clock_pelt(cfs_rq);
+	bool curr = flags & SE_IS_CURRENT;
 	int decayed, updated = 0;
 
 	/*
@@ -3491,7 +3544,7 @@ static inline bool update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 	 * track group sched_entity load average for task_h_load calc in migration
 	 */
 	if (se->avg.last_update_time && !(flags & SKIP_AGE_LOAD))
-		updated = __update_load_avg_se(now, cfs_rq, se);
+		updated = __update_load_avg_se(now, cfs_rq, se, curr, curr);
 
 	decayed  = update_cfs_rq_load_avg(now, cfs_rq);
 	decayed |= propagate_entity_load_avg(se);
@@ -3727,6 +3780,7 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
 #define UPDATE_TG	0x0
 #define SKIP_AGE_LOAD	0x0
 #define DO_ATTACH	0x0
+#define SE_IS_CURRENT	0x0
 
 static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int not_used1)
 {
@@ -3908,55 +3962,20 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 		__enqueue_entity(cfs_rq, se);
 	se->on_rq = 1;
 
-	if (cfs_rq->nr_running == 1) {
-		list_add_leaf_cfs_rq(cfs_rq);
-		check_enqueue_throttle(cfs_rq);
-	}
-}
-
-static void __clear_buddies_last(struct sched_entity *se)
-{
-	for_each_sched_entity(se) {
-		struct cfs_rq *cfs_rq = cfs_rq_of(se);
-		if (cfs_rq->last != se)
-			break;
-
-		cfs_rq->last = NULL;
-	}
-}
-
-static void __clear_buddies_next(struct sched_entity *se)
-{
-	for_each_sched_entity(se) {
-		struct cfs_rq *cfs_rq = cfs_rq_of(se);
-		if (cfs_rq->next != se)
-			break;
-
-		cfs_rq->next = NULL;
-	}
-}
-
-static void __clear_buddies_skip(struct sched_entity *se)
-{
-	for_each_sched_entity(se) {
-		struct cfs_rq *cfs_rq = cfs_rq_of(se);
-		if (cfs_rq->skip != se)
-			break;
-
-		cfs_rq->skip = NULL;
-	}
+	if (task_se_in_cgroup(se))
+		enqueue_entity_cfs_rqs(se);
 }
 
 static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	if (cfs_rq->last == se)
-		__clear_buddies_last(se);
+		cfs_rq->last = NULL;
 
 	if (cfs_rq->next == se)
-		__clear_buddies_next(se);
+		cfs_rq->next = NULL;
 
 	if (cfs_rq->skip == se)
-		__clear_buddies_skip(se);
+		cfs_rq->skip = NULL;
 }
 
 static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq);
@@ -4065,6 +4084,7 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	/* 'current' is not kept within the tree. */
 	if (se->on_rq) {
+		struct sched_entity *ise = se;
 		/*
 		 * Any task has to be enqueued before it get to execute on
 		 * a CPU. So account for the time it spent waiting on the
@@ -4072,7 +4092,11 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 		 */
 		update_stats_wait_end(cfs_rq, se);
 		__dequeue_entity(cfs_rq, se);
-		update_load_avg(cfs_rq, se, UPDATE_TG);
+		for_each_sched_entity(ise) {
+			struct cfs_rq *group_rq = group_cfs_rq_of_parent(ise);
+			if (!update_load_avg(group_rq, ise, UPDATE_TG))
+				break;
+		}
 	}
 
 	update_stats_curr_start(cfs_rq, se);
@@ -4170,11 +4194,16 @@ static void put_prev_entity(struct cfs_rq *cfs_rq, struct sched_entity *prev)
 	check_spread(cfs_rq, prev);
 
 	if (prev->on_rq) {
+		struct sched_entity *se = prev;
 		update_stats_wait_start(cfs_rq, prev);
 		/* Put 'current' back into the tree. */
 		__enqueue_entity(cfs_rq, prev);
 		/* in !on_rq case, update occurred at dequeue */
-		update_load_avg(cfs_rq, prev, 0);
+		for_each_sched_entity(se) {
+			struct cfs_rq *group_rq = group_cfs_rq_of_parent(se);
+			if (!update_load_avg(group_rq, se, SE_IS_CURRENT))
+				break;
+		}
 	}
 	cfs_rq->curr = NULL;
 }
@@ -4190,7 +4219,7 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
 	/*
 	 * Ensure that runnable average is periodically updated.
 	 */
-	update_load_avg(cfs_rq, curr, UPDATE_TG);
+	update_load_avg(cfs_rq, curr, UPDATE_TG|SE_IS_CURRENT);
 	update_cfs_group(curr);
 
 #ifdef CONFIG_SCHED_HRTICK
@@ -4209,9 +4238,6 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
 			hrtimer_active(&rq_of(cfs_rq)->hrtick_timer))
 		return;
 #endif
-
-	if (cfs_rq->nr_running > 1)
-		check_preempt_tick(cfs_rq, curr);
 }
 
 
@@ -5086,7 +5112,7 @@ static void hrtick_start_fair(struct rq *rq, struct task_struct *p)
 
 	SCHED_WARN_ON(task_rq(p) != rq);
 
-	if (rq->cfs.h_nr_running > 1) {
+	if (rq->cfs.nr_running > 1) {
 		u64 slice = sched_slice(cfs_rq, se);
 		u64 ran = se->sum_exec_runtime - se->prev_sum_exec_runtime;
 		s64 delta = slice - ran;
@@ -5151,7 +5177,7 @@ static inline void update_overutilized_status(struct rq *rq) { }
 static void
 enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 {
-	struct cfs_rq *cfs_rq;
+	struct cfs_rq *cfs_rq = & rq->cfs;
 	struct sched_entity *se = &p->se;
 
 	/*
@@ -5160,7 +5186,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	 * Let's add the task's estimated utilization to the cfs_rq's
 	 * estimated utilization, before we update schedutil.
 	 */
-	util_est_enqueue(&rq->cfs, p);
+	util_est_enqueue(cfs_rq, p);
 
 	/*
 	 * If in_iowait is set, the code below may not trigger any cpufreq
@@ -5171,37 +5197,13 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
 
 	for_each_sched_entity(se) {
-		if (se->on_rq)
+		struct cfs_rq *group_rq = group_cfs_rq_of_parent(se);
+		if (!enqueue_entity_groups(group_rq, se, flags))
 			break;
-		cfs_rq = cfs_rq_of(se);
-		enqueue_entity_groups(cfs_rq, se, flags);
-		enqueue_entity(cfs_rq, se, flags);
-
-		/*
-		 * end evaluation on encountering a throttled cfs_rq
-		 *
-		 * note: in the case of encountering a throttled cfs_rq we will
-		 * post the final h_nr_running increment below.
-		 */
-		if (cfs_rq_throttled(cfs_rq))
-			break;
-		cfs_rq->h_nr_running++;
-
-		flags = ENQUEUE_WAKEUP;
 	}
 
-	for_each_sched_entity(se) {
-		cfs_rq = cfs_rq_of(se);
-		cfs_rq->h_nr_running++;
-
-		if (cfs_rq_throttled(cfs_rq))
-			break;
-
-		update_load_avg(cfs_rq, se, UPDATE_TG);
-		update_cfs_group(se);
-	}
+	enqueue_entity(cfs_rq, &p->se, flags);
 
-	if (!se) {
 		add_nr_running(rq, 1);
 		/*
 		 * Since new tasks are assigned an initial util_avg equal to
@@ -5220,23 +5222,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		if (flags & ENQUEUE_WAKEUP)
 			update_overutilized_status(rq);
 
-	}
-
-	if (cfs_bandwidth_used()) {
-		/*
-		 * When bandwidth control is enabled; the cfs_rq_throttled()
-		 * breaks in the above iteration can result in incomplete
-		 * leaf list maintenance, resulting in triggering the assertion
-		 * below.
-		 */
-		for_each_sched_entity(se) {
-			cfs_rq = cfs_rq_of(se);
-
-			if (list_add_leaf_cfs_rq(cfs_rq))
-				break;
-		}
-	}
-
 	assert_list_leaf_cfs_rq(rq);
 
 	hrtick_update(rq);
@@ -5251,55 +5236,21 @@ static void set_next_buddy(struct sched_entity *se);
  */
 static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 {
-	struct cfs_rq *cfs_rq;
+	struct cfs_rq *cfs_rq = &rq->cfs;
 	struct sched_entity *se = &p->se;
 	int task_sleep = flags & DEQUEUE_SLEEP;
 
 	for_each_sched_entity(se) {
-		cfs_rq = cfs_rq_of(se);
-		dequeue_entity_groups(cfs_rq, se, flags);
-		dequeue_entity(cfs_rq, se, flags);
-
-		/*
-		 * end evaluation on encountering a throttled cfs_rq
-		 *
-		 * note: in the case of encountering a throttled cfs_rq we will
-		 * post the final h_nr_running decrement below.
-		*/
-		if (cfs_rq_throttled(cfs_rq))
+		struct cfs_rq *group_rq = group_cfs_rq_of_parent(se);
+		if (!dequeue_entity_groups(group_rq, se, flags | SE_IS_CURRENT))
 			break;
-		cfs_rq->h_nr_running--;
-
-		/* Don't dequeue parent if it has other entities besides us */
-		if (cfs_rq->load.weight) {
-			/* Avoid re-evaluating load for this entity: */
-			se = parent_entity(se);
-			/*
-			 * Bias pick_next to pick a task from this cfs_rq, as
-			 * p is sleeping when it is within its sched_slice.
-			 */
-			if (task_sleep && se && !throttled_hierarchy(cfs_rq))
-				set_next_buddy(se);
-			break;
-		}
-		flags |= DEQUEUE_SLEEP;
 	}
 
-	for_each_sched_entity(se) {
-		cfs_rq = cfs_rq_of(se);
-		cfs_rq->h_nr_running--;
+	dequeue_entity(cfs_rq, &p->se, flags);
 
-		if (cfs_rq_throttled(cfs_rq))
-			break;
+	sub_nr_running(rq, 1);
 
-		update_load_avg(cfs_rq, se, UPDATE_TG);
-		update_cfs_group(se);
-	}
-
-	if (!se)
-		sub_nr_running(rq, 1);
-
-	util_est_dequeue(&rq->cfs, p, task_sleep);
+	util_est_dequeue(cfs_rq, p, task_sleep);
 	hrtick_update(rq);
 }
 
@@ -5622,7 +5573,7 @@ static unsigned long capacity_of(int cpu)
 static unsigned long cpu_avg_load_per_task(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
-	unsigned long nr_running = READ_ONCE(rq->cfs.h_nr_running);
+	unsigned long nr_running = READ_ONCE(rq->cfs.nr_running);
 	unsigned long load_avg = weighted_cpuload(rq);
 
 	if (nr_running)
@@ -6841,11 +6792,9 @@ static void set_last_buddy(struct sched_entity *se)
 	if (entity_is_task(se) && unlikely(task_has_idle_policy(task_of(se))))
 		return;
 
-	for_each_sched_entity(se) {
-		if (SCHED_WARN_ON(!se->on_rq))
-			return;
-		cfs_rq_of(se)->last = se;
-	}
+	if (SCHED_WARN_ON(!se->on_rq))
+		return;
+	cfs_rq_of(se)->last = se;
 }
 
 static void set_next_buddy(struct sched_entity *se)
@@ -6853,17 +6802,14 @@ static void set_next_buddy(struct sched_entity *se)
 	if (entity_is_task(se) && unlikely(task_has_idle_policy(task_of(se))))
 		return;
 
-	for_each_sched_entity(se) {
-		if (SCHED_WARN_ON(!se->on_rq))
-			return;
-		cfs_rq_of(se)->next = se;
-	}
+	if (SCHED_WARN_ON(!se->on_rq))
+		return;
+	cfs_rq_of(se)->next = se;
 }
 
 static void set_skip_buddy(struct sched_entity *se)
 {
-	for_each_sched_entity(se)
-		cfs_rq_of(se)->skip = se;
+	cfs_rq_of(se)->skip = se;
 }
 
 /*
@@ -6919,7 +6865,6 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 	if (unlikely(p->policy != SCHED_NORMAL) || !sched_feat(WAKEUP_PREEMPTION))
 		return;
 
-	find_matching_se(&se, &pse);
 	update_curr(cfs_rq_of(se));
 	BUG_ON(!pse);
 	if (wakeup_preempt_entity(se, pse) == 1) {
@@ -6960,100 +6905,18 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 	struct task_struct *p;
 	int new_tasks;
 
+	put_prev_task(rq, prev);
 again:
 	if (!cfs_rq->nr_running)
 		goto idle;
 
-#ifdef CONFIG_FAIR_GROUP_SCHED
-	if (prev->sched_class != &fair_sched_class)
-		goto simple;
-
-	/*
-	 * Because of the set_next_buddy() in dequeue_task_fair() it is rather
-	 * likely that a next task is from the same cgroup as the current.
-	 *
-	 * Therefore attempt to avoid putting and setting the entire cgroup
-	 * hierarchy, only change the part that actually changes.
-	 */
-
-	do {
-		struct sched_entity *curr = cfs_rq->curr;
-
-		/*
-		 * Since we got here without doing put_prev_entity() we also
-		 * have to consider cfs_rq->curr. If it is still a runnable
-		 * entity, update_curr() will update its vruntime, otherwise
-		 * forget we've ever seen it.
-		 */
-		if (curr) {
-			if (curr->on_rq)
-				update_curr(cfs_rq);
-			else
-				curr = NULL;
-
-			/*
-			 * This call to check_cfs_rq_runtime() will do the
-			 * throttle and dequeue its entity in the parent(s).
-			 * Therefore the nr_running test will indeed
-			 * be correct.
-			 */
-			if (unlikely(check_cfs_rq_runtime(cfs_rq))) {
-				cfs_rq = &rq->cfs;
-
-				if (!cfs_rq->nr_running)
-					goto idle;
-
-				goto simple;
-			}
-		}
-
-		se = pick_next_entity(cfs_rq, curr);
-		cfs_rq = group_cfs_rq(se);
-	} while (cfs_rq);
-
-	p = task_of(se);
-
-	/*
-	 * Since we haven't yet done put_prev_entity and if the selected task
-	 * is a different task than we started out with, try and touch the
-	 * least amount of cfs_rqs.
-	 */
-	if (prev != p) {
-		struct sched_entity *pse = &prev->se;
-
-		while (!(cfs_rq = is_same_group(se, pse))) {
-			int se_depth = se->depth;
-			int pse_depth = pse->depth;
-
-			if (se_depth <= pse_depth) {
-				put_prev_entity(cfs_rq_of(pse), pse);
-				pse = parent_entity(pse);
-			}
-			if (se_depth >= pse_depth) {
-				set_next_entity(cfs_rq_of(se), se);
-				se = parent_entity(se);
-			}
-		}
-
-		put_prev_entity(cfs_rq, pse);
-		set_next_entity(cfs_rq, se);
-	}
-
-	goto done;
-simple:
-#endif
-
-	put_prev_task(rq, prev);
-
-	do {
-		se = pick_next_entity(cfs_rq, NULL);
-		set_next_entity(cfs_rq, se);
-		cfs_rq = group_cfs_rq(se);
-	} while (cfs_rq);
+	se = pick_next_entity(cfs_rq, NULL);
+	if (!se)
+		goto idle;
 
+	set_next_entity(cfs_rq, se);
 	p = task_of(se);
 
-done: __maybe_unused;
 #ifdef CONFIG_SMP
 	/*
 	 * Move the next running task to the front of
@@ -7102,10 +6965,8 @@ static void put_prev_task_fair(struct rq *rq, struct task_struct *prev)
 	struct sched_entity *se = &prev->se;
 	struct cfs_rq *cfs_rq;
 
-	for_each_sched_entity(se) {
-		cfs_rq = cfs_rq_of(se);
-		put_prev_entity(cfs_rq, se);
-	}
+	cfs_rq = cfs_rq_of(se);
+	put_prev_entity(cfs_rq, se);
 }
 
 /*
@@ -7819,6 +7680,19 @@ static void update_cfs_rq_h_load(struct cfs_rq *cfs_rq)
 	}
 }
 
+static unsigned long task_se_h_weight(struct sched_entity *se)
+{
+	struct cfs_rq *cfs_rq;
+
+	if (!task_se_in_cgroup(se))
+		return se->load.weight;
+
+	cfs_rq = group_cfs_rq_of_parent(se);
+
+	/* Reduce the load.weight by the h_load of the group the task is in. */
+	return (cfs_rq->h_load * se->load.weight) >> SCHED_FIXEDPOINT_SHIFT;
+}
+
 static unsigned long task_se_h_load(struct sched_entity *se)
 {
 	struct cfs_rq *cfs_rq = group_cfs_rq_of_parent(se);
@@ -7865,6 +7739,11 @@ static unsigned long task_h_load(struct task_struct *p)
 {
 	return p->se.avg.load_avg;
 }
+
+static unsigned long task_se_h_weight(struct sched_entity *se)
+{
+	return se->load.weight;
+}
 #endif
 
 /********** Helpers for find_busiest_group ************************/
@@ -8266,7 +8145,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 
 		sgs->group_load += load;
 		sgs->group_util += cpu_util(i);
-		sgs->sum_nr_running += rq->cfs.h_nr_running;
+		sgs->sum_nr_running += rq->cfs.nr_running;
 
 		nr_running = rq->nr_running;
 		if (nr_running > 1)
@@ -8957,7 +8836,7 @@ voluntary_active_balance(struct lb_env *env)
 	 * available on dst_cpu.
 	 */
 	if ((env->idle != CPU_NOT_IDLE) &&
-	    (env->src_rq->cfs.h_nr_running == 1)) {
+	    (env->src_rq->cfs.nr_running == 1)) {
 		if ((check_cpu_capacity(env->src_rq, sd)) &&
 		    (capacity_of(env->src_cpu)*sd->imbalance_pct < capacity_of(env->dst_cpu)*100))
 			return 1;
@@ -9638,7 +9517,7 @@ static void nohz_balancer_kick(struct rq *rq)
 		 * capacity; kick the ILB to see if there's a better CPU to run
 		 * on.
 		 */
-		if (rq->cfs.h_nr_running >= 1 && check_cpu_capacity(rq, sd)) {
+		if (rq->cfs.nr_running >= 1 && check_cpu_capacity(rq, sd)) {
 			flags = NOHZ_KICK_MASK;
 			goto unlock;
 		}
@@ -10087,7 +9966,7 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
 	 * have been enqueued in the meantime. Since we're not going idle,
 	 * pretend we pulled a task.
 	 */
-	if (this_rq->cfs.h_nr_running && !pulled_task)
+	if (this_rq->cfs.nr_running && !pulled_task)
 		pulled_task = 1;
 
 	/* Move the next balance forward */
@@ -10095,7 +9974,7 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
 		this_rq->next_balance = next_balance;
 
 	/* Is there a task of a high priority class? */
-	if (this_rq->nr_running != this_rq->cfs.h_nr_running)
+	if (this_rq->nr_running != this_rq->cfs.nr_running)
 		pulled_task = -1;
 
 	if (pulled_task)
@@ -10182,6 +10061,10 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 		entity_tick(cfs_rq, se, queued);
 	}
 
+	cfs_rq = &rq->cfs;
+	if (cfs_rq->nr_running > 1)
+		check_preempt_tick(cfs_rq, &curr->se);
+
 	if (static_branch_unlikely(&sched_numa_balancing))
 		task_tick_numa(rq, curr);
 
@@ -10280,40 +10163,51 @@ static inline bool vruntime_normalized(struct task_struct *p)
  * Propagate the changes of the sched_entity across the tg tree to make it
  * visible to the root
  */
-static void propagate_entity_cfs_rq(struct sched_entity *se)
+static void propagate_entity_cfs_rq(struct sched_entity *se, bool curr)
 {
+	unsigned long flags = UPDATE_TG;
 	struct cfs_rq *cfs_rq;
 
+	if (curr)
+		flags |= SE_IS_CURRENT;
+
 	/* Start to propagate at parent */
 	se = se->parent;
 
 	for_each_sched_entity(se) {
-		cfs_rq = cfs_rq_of(se);
+		cfs_rq = group_cfs_rq_of_parent(se);
 
 		if (cfs_rq_throttled(cfs_rq))
 			break;
 
-		update_load_avg(cfs_rq, se, UPDATE_TG);
+		if (!update_load_avg(cfs_rq, se, flags))
+			break;
 	}
 }
 #else
-static void propagate_entity_cfs_rq(struct sched_entity *se) { }
+static void propagate_entity_cfs_rq(struct sched_entity *se, bool curr) { }
 #endif
 
 static void detach_entity_cfs_rq(struct sched_entity *se)
 {
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
+	struct sched_entity *ise = se;
 
 	/* Catch up with the cfs_rq and remove our load when we leave */
-	update_load_avg(cfs_rq, se, 0);
+	for_each_sched_entity(ise) {
+		struct cfs_rq *group_rq = group_cfs_rq_of_parent(ise);
+		if (!update_load_avg(group_rq, ise, 0))
+			break;
+	}
 	detach_entity_load_avg(cfs_rq, se);
 	update_tg_load_avg(cfs_rq, false);
-	propagate_entity_cfs_rq(se);
+	propagate_entity_cfs_rq(se, true);
 }
 
 static void attach_entity_cfs_rq(struct sched_entity *se)
 {
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
+	struct sched_entity *ise = se;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	/*
@@ -10324,10 +10218,15 @@ static void attach_entity_cfs_rq(struct sched_entity *se)
 #endif
 
 	/* Synchronize entity with its cfs_rq */
-	update_load_avg(cfs_rq, se, sched_feat(ATTACH_AGE_LOAD) ? 0 : SKIP_AGE_LOAD);
+	for_each_sched_entity(ise) {
+		struct cfs_rq *group_rq = group_cfs_rq_of_parent(ise);
+		int flags = sched_feat(ATTACH_AGE_LOAD) ? 0 : SKIP_AGE_LOAD;
+		if (!update_load_avg(group_rq, ise, flags))
+			break;
+	}
 	attach_entity_load_avg(cfs_rq, se, 0);
 	update_tg_load_avg(cfs_rq, false);
-	propagate_entity_cfs_rq(se);
+	propagate_entity_cfs_rq(se, false);
 }
 
 static void detach_task_cfs_rq(struct task_struct *p)
@@ -10388,14 +10287,11 @@ static void switched_to_fair(struct rq *rq, struct task_struct *p)
 static void set_curr_task_fair(struct rq *rq)
 {
 	struct sched_entity *se = &rq->curr->se;
+	struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
-	for_each_sched_entity(se) {
-		struct cfs_rq *cfs_rq = cfs_rq_of(se);
-
-		set_next_entity(cfs_rq, se);
-		/* ensure bandwidth has been allocated on our new cfs_rq */
-		account_cfs_rq_runtime(cfs_rq, 0);
-	}
+	set_next_entity(cfs_rq, se);
+	/* ensure bandwidth has been allocated on our new cfs_rq */
+	account_cfs_rq_runtime(cfs_rq, 0);
 }
 
 void init_cfs_rq(struct cfs_rq *cfs_rq)
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 32dc2791a517..45d3b4979022 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -266,10 +266,10 @@ int __update_load_avg_blocked_se(u64 now, struct sched_entity *se)
 	return 0;
 }
 
-int __update_load_avg_se(u64 now, struct cfs_rq *cfs_rq, struct sched_entity *se)
+int __update_load_avg_se(u64 now, struct cfs_rq *cfs_rq, struct sched_entity *se, bool load, bool running)
 {
-	if (___update_load_sum(now, &se->avg, !!se->on_rq,
-				cfs_rq->curr == se)) {
+	if (___update_load_sum(now, &se->avg, (!!se->on_rq || load),
+				(cfs_rq->curr == se) || running)) {
 
 		___update_load_avg(&se->avg, se_weight(se));
 		cfs_se_util_change(&se->avg);
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index 7489d5f56960..1152c4ebf314 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -2,7 +2,7 @@
 #include "sched-pelt.h"
 
 int __update_load_avg_blocked_se(u64 now, struct sched_entity *se);
-int __update_load_avg_se(u64 now, struct cfs_rq *cfs_rq, struct sched_entity *se);
+int __update_load_avg_se(u64 now, struct cfs_rq *cfs_rq, struct sched_entity *se, bool load, bool running);
 int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq);
 int update_rt_rq_load_avg(u64 now, struct rq *rq, int running);
 int update_dl_rq_load_avg(u64 now, struct rq *rq, int running);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 18494b1a9bac..67066daf7ee9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1443,7 +1443,7 @@ static inline void set_task_rq(struct task_struct *p, unsigned int cpu)
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	set_task_rq_fair(&p->se, p->se.cfs_rq, tg->cfs_rq[cpu]);
-	p->se.cfs_rq = tg->cfs_rq[cpu];
+	p->se.cfs_rq = &cpu_rq(cpu)->cfs;
 	p->se.parent = tg->se[cpu];
 #endif
 
-- 
2.20.1

