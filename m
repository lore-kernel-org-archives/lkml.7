Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43339C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 19:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 169692070C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 19:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436667AbfIFTON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 15:14:13 -0400
Received: from shelob.surriel.com ([96.67.55.147]:38176 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406262AbfIFTOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 15:14:09 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1i6Jey-0003p8-9S; Fri, 06 Sep 2019 15:12:40 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, pjt@google.com, dietmar.eggemann@arm.com,
        peterz@infradead.org, mingo@redhat.com, morten.rasmussen@arm.com,
        tglx@linutronix.de, mgorman@techsingularity.net,
        vincent.guittot@linaro.org, Rik van Riel <riel@surriel.com>
Subject: [PATCH 03/15] sched,fair: redefine runnable_load_avg as the sum of task_h_load
Date:   Fri,  6 Sep 2019 15:12:25 -0400
Message-Id: <20190906191237.27006-4-riel@surriel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190906191237.27006-1-riel@surriel.com>
References: <20190906191237.27006-1-riel@surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The runnable_load magic is used to quickly propagate information about
runnable tasks up the hierarchy of runqueues. The runnable_load_avg is
mostly used for the load balancing code, which only examines the value at
the root cfs_rq.

Redefine the root cfs_rq runnable_load_avg to be the sum of task_h_loads
of the runnable tasks. This works because the hierarchical runnable_load of
a task is already equal to the task_se_h_load today. This provides enough
information to the load balancer.

The runnable_load_avg of the cgroup cfs_rqs does not appear to be
used for anything, so don't bother calculating those.

This removes one of the things that the code currently traverses the
cgroup hierarchy for, and getting rid of it brings us one step closer
to a flat runqueue for the CPU controller.

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 include/linux/sched.h |   3 +-
 kernel/sched/core.c   |   2 -
 kernel/sched/debug.c  |   1 +
 kernel/sched/fair.c   | 125 +++++++++++++-----------------------------
 kernel/sched/pelt.c   |  64 ++++++---------------
 kernel/sched/sched.h  |   6 --
 6 files changed, 56 insertions(+), 145 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 11837410690f..f5bb6948e40c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -391,7 +391,6 @@ struct util_est {
 struct sched_avg {
 	u64				last_update_time;
 	u64				load_sum;
-	u64				runnable_load_sum;
 	u32				util_sum;
 	u32				period_contrib;
 	unsigned long			load_avg;
@@ -439,7 +438,6 @@ struct sched_statistics {
 struct sched_entity {
 	/* For load-balancing: */
 	struct load_weight		load;
-	unsigned long			runnable_weight;
 	struct rb_node			run_node;
 	struct list_head		group_node;
 	unsigned int			on_rq;
@@ -455,6 +453,7 @@ struct sched_entity {
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	int				depth;
+	unsigned long			enqueued_h_load;
 	struct sched_entity		*parent;
 	/* rq on which this entity is (to be) queued: */
 	struct cfs_rq			*cfs_rq;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 874c427742a9..fbd96900f715 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -744,7 +744,6 @@ static void set_load_weight(struct task_struct *p, bool update_load)
 	if (task_has_idle_policy(p)) {
 		load->weight = scale_load(WEIGHT_IDLEPRIO);
 		load->inv_weight = WMULT_IDLEPRIO;
-		p->se.runnable_weight = load->weight;
 		return;
 	}
 
@@ -757,7 +756,6 @@ static void set_load_weight(struct task_struct *p, bool update_load)
 	} else {
 		load->weight = scale_load(sched_prio_to_weight[prio]);
 		load->inv_weight = sched_prio_to_wmult[prio];
-		p->se.runnable_weight = load->weight;
 	}
 }
 
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index f6beaca97a09..cefc1b171c0b 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -962,6 +962,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 	P(se.avg.load_avg);
 	P(se.avg.runnable_load_avg);
 	P(se.avg.util_avg);
+	P(se.enqueued_h_load);
 	P(se.avg.last_update_time);
 	P(se.avg.util_est.ewma);
 	P(se.avg.util_est.enqueued);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 812f7947aab2..b87c857cbdff 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -723,9 +723,7 @@ void init_entity_runnable_average(struct sched_entity *se)
 	 * nothing has been attached to the task group yet.
 	 */
 	if (entity_is_task(se))
-		sa->runnable_load_avg = sa->load_avg = scale_load_down(se->load.weight);
-
-	se->runnable_weight = se->load.weight;
+		sa->load_avg = scale_load_down(se->load.weight);
 
 	/* when this task enqueue'ed, it will contribute to its cfs_rq's load_avg */
 }
@@ -2766,20 +2764,39 @@ account_entity_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 static inline void
 enqueue_runnable_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	cfs_rq->runnable_weight += se->runnable_weight;
+	if (entity_is_task(se)) {
+		struct cfs_rq *root_cfs_rq = &cfs_rq->rq->cfs;
+		se->enqueued_h_load = task_se_h_load(se);
 
-	cfs_rq->avg.runnable_load_avg += se->avg.runnable_load_avg;
-	cfs_rq->avg.runnable_load_sum += se_runnable(se) * se->avg.runnable_load_sum;
+		root_cfs_rq->avg.runnable_load_avg += se->enqueued_h_load;
+	}
 }
 
 static inline void
 dequeue_runnable_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	cfs_rq->runnable_weight -= se->runnable_weight;
+	if (entity_is_task(se)) {
+		struct cfs_rq *root_cfs_rq = &cfs_rq->rq->cfs;
+		sub_positive(&root_cfs_rq->avg.runnable_load_avg,
+					se->enqueued_h_load);
+	}
+}
+
+static inline void
+update_runnable_load_avg(struct sched_entity *se)
+{
+	struct cfs_rq *root_cfs_rq = &cfs_rq_of(se)->rq->cfs;
+	long new_h_load, delta;
 
-	sub_positive(&cfs_rq->avg.runnable_load_avg, se->avg.runnable_load_avg);
-	sub_positive(&cfs_rq->avg.runnable_load_sum,
-		     se_runnable(se) * se->avg.runnable_load_sum);
+	SCHED_WARN_ON(!entity_is_task(se));
+
+	if (!se->on_rq)
+		return;
+
+	new_h_load = task_se_h_load(se);
+	delta = new_h_load - se->enqueued_h_load;
+	root_cfs_rq->avg.runnable_load_avg += delta;
+	se->enqueued_h_load = new_h_load;
 }
 
 static inline void
@@ -2807,7 +2824,7 @@ dequeue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) { }
 #endif
 
 static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
-			    unsigned long weight, unsigned long runnable)
+			    unsigned long weight)
 {
 	if (se->on_rq) {
 		/* commit outstanding execution time */
@@ -2818,7 +2835,6 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 	}
 	dequeue_load_avg(cfs_rq, se);
 
-	se->runnable_weight = runnable;
 	update_load_set(&se->load, weight);
 
 #ifdef CONFIG_SMP
@@ -2826,8 +2842,6 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 		u32 divider = LOAD_AVG_MAX - 1024 + se->avg.period_contrib;
 
 		se->avg.load_avg = div_u64(se_weight(se) * se->avg.load_sum, divider);
-		se->avg.runnable_load_avg =
-			div_u64(se_runnable(se) * se->avg.runnable_load_sum, divider);
 	} while (0);
 #endif
 
@@ -2845,7 +2859,7 @@ void reweight_task(struct task_struct *p, int prio)
 	struct load_weight *load = &se->load;
 	unsigned long weight = scale_load(sched_prio_to_weight[prio]);
 
-	reweight_entity(cfs_rq, se, weight, weight);
+	reweight_entity(cfs_rq, se, weight);
 	load->inv_weight = sched_prio_to_wmult[prio];
 }
 
@@ -2958,49 +2972,6 @@ static long calc_group_shares(struct cfs_rq *cfs_rq)
 	return clamp_t(long, shares, MIN_SHARES, tg_shares);
 }
 
-/*
- * This calculates the effective runnable weight for a group entity based on
- * the group entity weight calculated above.
- *
- * Because of the above approximation (2), our group entity weight is
- * an load_avg based ratio (3). This means that it includes blocked load and
- * does not represent the runnable weight.
- *
- * Approximate the group entity's runnable weight per ratio from the group
- * runqueue:
- *
- *					     grq->avg.runnable_load_avg
- *   ge->runnable_weight = ge->load.weight * -------------------------- (7)
- *						 grq->avg.load_avg
- *
- * However, analogous to above, since the avg numbers are slow, this leads to
- * transients in the from-idle case. Instead we use:
- *
- *   ge->runnable_weight = ge->load.weight *
- *
- *		max(grq->avg.runnable_load_avg, grq->runnable_weight)
- *		-----------------------------------------------------	(8)
- *		      max(grq->avg.load_avg, grq->load.weight)
- *
- * Where these max() serve both to use the 'instant' values to fix the slow
- * from-idle and avoid the /0 on to-idle, similar to (6).
- */
-static long calc_group_runnable(struct cfs_rq *cfs_rq, long shares)
-{
-	long runnable, load_avg;
-
-	load_avg = max(cfs_rq->avg.load_avg,
-		       scale_load_down(cfs_rq->load.weight));
-
-	runnable = max(cfs_rq->avg.runnable_load_avg,
-		       scale_load_down(cfs_rq->runnable_weight));
-
-	runnable *= shares;
-	if (load_avg)
-		runnable /= load_avg;
-
-	return clamp_t(long, runnable, MIN_SHARES, shares);
-}
 #endif /* CONFIG_SMP */
 
 static inline int throttled_hierarchy(struct cfs_rq *cfs_rq);
@@ -3012,25 +2983,26 @@ static inline int throttled_hierarchy(struct cfs_rq *cfs_rq);
 static void update_cfs_group(struct sched_entity *se)
 {
 	struct cfs_rq *gcfs_rq = group_cfs_rq(se);
-	long shares, runnable;
+	long shares;
 
-	if (!gcfs_rq)
+	if (!gcfs_rq) {
+		update_runnable_load_avg(se);
 		return;
+	}
 
 	if (throttled_hierarchy(gcfs_rq))
 		return;
 
 #ifndef CONFIG_SMP
-	runnable = shares = READ_ONCE(gcfs_rq->tg->shares);
+	shares = READ_ONCE(gcfs_rq->tg->shares);
 
 	if (likely(se->load.weight == shares))
 		return;
 #else
 	shares   = calc_group_shares(gcfs_rq);
-	runnable = calc_group_runnable(gcfs_rq, shares);
 #endif
 
-	reweight_entity(cfs_rq_of(se), se, shares, runnable);
+	reweight_entity(cfs_rq_of(se), se, shares);
 }
 
 #else /* CONFIG_FAIR_GROUP_SCHED */
@@ -3243,8 +3215,8 @@ static inline void
 update_tg_cfs_runnable(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq)
 {
 	long delta_avg, running_sum, runnable_sum = gcfs_rq->prop_runnable_sum;
-	unsigned long runnable_load_avg, load_avg;
-	u64 runnable_load_sum, load_sum = 0;
+	unsigned long load_avg;
+	u64 load_sum = 0;
 	s64 delta_sum;
 
 	if (!runnable_sum)
@@ -3292,19 +3264,6 @@ update_tg_cfs_runnable(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cf
 	se->avg.load_avg = load_avg;
 	add_positive(&cfs_rq->avg.load_avg, delta_avg);
 	add_positive(&cfs_rq->avg.load_sum, delta_sum);
-
-	runnable_load_sum = (s64)se_runnable(se) * runnable_sum;
-	runnable_load_avg = div_s64(runnable_load_sum, LOAD_AVG_MAX);
-	delta_sum = runnable_load_sum - se_weight(se) * se->avg.runnable_load_sum;
-	delta_avg = runnable_load_avg - se->avg.runnable_load_avg;
-
-	se->avg.runnable_load_sum = runnable_sum;
-	se->avg.runnable_load_avg = runnable_load_avg;
-
-	if (se->on_rq) {
-		add_positive(&cfs_rq->avg.runnable_load_avg, delta_avg);
-		add_positive(&cfs_rq->avg.runnable_load_sum, delta_sum);
-	}
 }
 
 static inline void add_tg_cfs_propagate(struct cfs_rq *cfs_rq, long runnable_sum)
@@ -3399,7 +3358,7 @@ static inline void add_tg_cfs_propagate(struct cfs_rq *cfs_rq, long runnable_sum
 static inline int
 update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 {
-	unsigned long removed_load = 0, removed_util = 0, removed_runnable_sum = 0;
+	unsigned long removed_load = 0, removed_util = 0;
 	struct sched_avg *sa = &cfs_rq->avg;
 	int decayed = 0;
 
@@ -3410,7 +3369,6 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 		raw_spin_lock(&cfs_rq->removed.lock);
 		swap(cfs_rq->removed.util_avg, removed_util);
 		swap(cfs_rq->removed.load_avg, removed_load);
-		swap(cfs_rq->removed.runnable_sum, removed_runnable_sum);
 		cfs_rq->removed.nr = 0;
 		raw_spin_unlock(&cfs_rq->removed.lock);
 
@@ -3422,8 +3380,6 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 		sub_positive(&sa->util_avg, r);
 		sub_positive(&sa->util_sum, r * divider);
 
-		add_tg_cfs_propagate(cfs_rq, -(long)removed_runnable_sum);
-
 		decayed = 1;
 	}
 
@@ -3477,8 +3433,6 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 			div_u64(se->avg.load_avg * se->avg.load_sum, se_weight(se));
 	}
 
-	se->avg.runnable_load_sum = se->avg.load_sum;
-
 	enqueue_load_avg(cfs_rq, se);
 	cfs_rq->avg.util_avg += se->avg.util_avg;
 	cfs_rq->avg.util_sum += se->avg.util_sum;
@@ -7735,9 +7689,6 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 	if (cfs_rq->avg.util_sum)
 		return false;
 
-	if (cfs_rq->avg.runnable_load_sum)
-		return false;
-
 	return true;
 }
 
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index befce29bd882..b3f3e8b29394 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -106,7 +106,7 @@ static u32 __accumulate_pelt_segments(u64 periods, u32 d1, u32 d3)
  */
 static __always_inline u32
 accumulate_sum(u64 delta, struct sched_avg *sa,
-	       unsigned long load, unsigned long runnable, int running)
+	       unsigned long load, int running)
 {
 	u32 contrib = (u32)delta; /* p == 0 -> delta < 1024 */
 	u64 periods;
@@ -119,8 +119,6 @@ accumulate_sum(u64 delta, struct sched_avg *sa,
 	 */
 	if (periods) {
 		sa->load_sum = decay_load(sa->load_sum, periods);
-		sa->runnable_load_sum =
-			decay_load(sa->runnable_load_sum, periods);
 		sa->util_sum = decay_load((u64)(sa->util_sum), periods);
 
 		/*
@@ -134,8 +132,6 @@ accumulate_sum(u64 delta, struct sched_avg *sa,
 
 	if (load)
 		sa->load_sum += load * contrib;
-	if (runnable)
-		sa->runnable_load_sum += runnable * contrib;
 	if (running)
 		sa->util_sum += contrib << SCHED_CAPACITY_SHIFT;
 
@@ -172,7 +168,7 @@ accumulate_sum(u64 delta, struct sched_avg *sa,
  */
 static __always_inline int
 ___update_load_sum(u64 now, struct sched_avg *sa,
-		  unsigned long load, unsigned long runnable, int running)
+		  unsigned long load, int running)
 {
 	u64 delta;
 
@@ -206,7 +202,7 @@ ___update_load_sum(u64 now, struct sched_avg *sa,
 	 * update_blocked_averages()
 	 */
 	if (!load)
-		runnable = running = 0;
+		running = 0;
 
 	/*
 	 * Now we know we crossed measurement unit boundaries. The *_avg
@@ -215,14 +211,14 @@ ___update_load_sum(u64 now, struct sched_avg *sa,
 	 * Step 1: accumulate *_sum since last_update_time. If we haven't
 	 * crossed period boundaries, finish.
 	 */
-	if (!accumulate_sum(delta, sa, load, runnable, running))
+	if (!accumulate_sum(delta, sa, load, running))
 		return 0;
 
 	return 1;
 }
 
 static __always_inline void
-___update_load_avg(struct sched_avg *sa, unsigned long load, unsigned long runnable)
+___update_load_avg(struct sched_avg *sa, unsigned long load)
 {
 	u32 divider = LOAD_AVG_MAX - 1024 + sa->period_contrib;
 
@@ -230,41 +226,25 @@ ___update_load_avg(struct sched_avg *sa, unsigned long load, unsigned long runna
 	 * Step 2: update *_avg.
 	 */
 	sa->load_avg = div_u64(load * sa->load_sum, divider);
-	sa->runnable_load_avg =	div_u64(runnable * sa->runnable_load_sum, divider);
 	WRITE_ONCE(sa->util_avg, sa->util_sum / divider);
 }
 
 /*
  * sched_entity:
  *
- *   task:
- *     se_runnable() == se_weight()
- *
- *   group: [ see update_cfs_group() ]
- *     se_weight()   = tg->weight * grq->load_avg / tg->load_avg
- *     se_runnable() = se_weight(se) * grq->runnable_load_avg / grq->load_avg
- *
  *   load_sum := runnable_sum
  *   load_avg = se_weight(se) * runnable_avg
  *
- *   runnable_load_sum := runnable_sum
- *   runnable_load_avg = se_runnable(se) * runnable_avg
- *
- * XXX collapse load_sum and runnable_load_sum
- *
  * cfq_rq:
  *
  *   load_sum = \Sum se_weight(se) * se->avg.load_sum
  *   load_avg = \Sum se->avg.load_avg
- *
- *   runnable_load_sum = \Sum se_runnable(se) * se->avg.runnable_load_sum
- *   runnable_load_avg = \Sum se->avg.runable_load_avg
  */
 
 int __update_load_avg_blocked_se(u64 now, struct sched_entity *se)
 {
-	if (___update_load_sum(now, &se->avg, 0, 0, 0)) {
-		___update_load_avg(&se->avg, se_weight(se), se_runnable(se));
+	if (___update_load_sum(now, &se->avg, 0, 0)) {
+		___update_load_avg(&se->avg, se_weight(se));
 		return 1;
 	}
 
@@ -273,10 +253,10 @@ int __update_load_avg_blocked_se(u64 now, struct sched_entity *se)
 
 int __update_load_avg_se(u64 now, struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	if (___update_load_sum(now, &se->avg, !!se->on_rq, !!se->on_rq,
+	if (___update_load_sum(now, &se->avg, !!se->on_rq,
 				cfs_rq->curr == se)) {
 
-		___update_load_avg(&se->avg, se_weight(se), se_runnable(se));
+		___update_load_avg(&se->avg, se_weight(se));
 		cfs_se_util_change(&se->avg);
 		return 1;
 	}
@@ -288,10 +268,9 @@ int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq)
 {
 	if (___update_load_sum(now, &cfs_rq->avg,
 				scale_load_down(cfs_rq->load.weight),
-				scale_load_down(cfs_rq->runnable_weight),
 				cfs_rq->curr != NULL)) {
 
-		___update_load_avg(&cfs_rq->avg, 1, 1);
+		___update_load_avg(&cfs_rq->avg, 1);
 		return 1;
 	}
 
@@ -303,20 +282,18 @@ int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq)
  *
  *   util_sum = \Sum se->avg.util_sum but se->avg.util_sum is not tracked
  *   util_sum = cpu_scale * load_sum
- *   runnable_load_sum = load_sum
  *
- *   load_avg and runnable_load_avg are not supported and meaningless.
+ *   load_avg is not supported and meaningless.
  *
  */
 
 int update_rt_rq_load_avg(u64 now, struct rq *rq, int running)
 {
 	if (___update_load_sum(now, &rq->avg_rt,
-				running,
 				running,
 				running)) {
 
-		___update_load_avg(&rq->avg_rt, 1, 1);
+		___update_load_avg(&rq->avg_rt, 1);
 		return 1;
 	}
 
@@ -328,18 +305,16 @@ int update_rt_rq_load_avg(u64 now, struct rq *rq, int running)
  *
  *   util_sum = \Sum se->avg.util_sum but se->avg.util_sum is not tracked
  *   util_sum = cpu_scale * load_sum
- *   runnable_load_sum = load_sum
  *
  */
 
 int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
 {
 	if (___update_load_sum(now, &rq->avg_dl,
-				running,
 				running,
 				running)) {
 
-		___update_load_avg(&rq->avg_dl, 1, 1);
+		___update_load_avg(&rq->avg_dl, 1);
 		return 1;
 	}
 
@@ -352,7 +327,6 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
  *
  *   util_sum = \Sum se->avg.util_sum but se->avg.util_sum is not tracked
  *   util_sum = cpu_scale * load_sum
- *   runnable_load_sum = load_sum
  *
  */
 
@@ -379,17 +353,11 @@ int update_irq_load_avg(struct rq *rq, u64 running)
 	 * We can safely remove running from rq->clock because
 	 * rq->clock += delta with delta >= running
 	 */
-	ret = ___update_load_sum(rq->clock - running, &rq->avg_irq,
-				0,
-				0,
-				0);
-	ret += ___update_load_sum(rq->clock, &rq->avg_irq,
-				1,
-				1,
-				1);
+	ret = ___update_load_sum(rq->clock - running, &rq->avg_irq, 0, 0);
+	ret += ___update_load_sum(rq->clock, &rq->avg_irq, 1, 1);
 
 	if (ret)
-		___update_load_avg(&rq->avg_irq, 1, 1);
+		___update_load_avg(&rq->avg_irq, 1);
 
 	return ret;
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b52ed1ada0be..5be14cee61f9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -487,7 +487,6 @@ struct cfs_bandwidth { };
 /* CFS-related fields in a runqueue */
 struct cfs_rq {
 	struct load_weight	load;
-	unsigned long		runnable_weight;
 	unsigned int		nr_running;
 	unsigned int		h_nr_running;
 
@@ -700,11 +699,6 @@ static inline long se_weight(struct sched_entity *se)
 	return scale_load_down(se->load.weight);
 }
 
-static inline long se_runnable(struct sched_entity *se)
-{
-	return scale_load_down(se->runnable_weight);
-}
-
 static inline bool sched_asym_prefer(int a, int b)
 {
 	return arch_asym_cpu_priority(a) > arch_asym_cpu_priority(b);
-- 
2.20.1

