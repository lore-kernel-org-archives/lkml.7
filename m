Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576CBC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 16:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E36521901
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 16:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vod2DMLR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbfGZQUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 12:20:43 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57074 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728611AbfGZQUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 12:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Q1arkRBIo5wy7Ql3MmDbGr6alY4tnjrUGpT7+7JN5w8=; b=Vod2DMLRw6myn/UD3ANSeT4qbv
        MiGdXYRQwMiGNgWA9rLdxzuf19WDrnn6oqMlRwpcLM5+iMouAbfbbGSj8uvNyoQFU5vpQGV2P/Vff
        Koa6uoi+GYUznIUPT/bUj6zNvcLW+T1kMh2a8+qsI4AB1nLBWqrow2SsjRiSQCfpP0VDlg8fm6q/a
        qcknPz47KpM/TwvU1gj5Ox73aWnFwWbUTFFrXYoLrpVRi3HYsxEHzMIVwijobXlzoc1uvllo0MPgy
        OIXQ+GXXz4vRW+zP/FsA/QmTdD0F0SvYa6Y9trIgqX+Hz4nckcvVVS5jqq2rttlMp++BzdeY5IERu
        BoKUDwCA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hr2wz-00066c-MB; Fri, 26 Jul 2019 16:20:09 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6F89720229758; Fri, 26 Jul 2019 18:20:05 +0200 (CEST)
Message-Id: <20190726161358.056107990@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 26 Jul 2019 16:54:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, juri.lelli@redhat.com
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        luca.abeni@santannapisa.it, bristot@redhat.com,
        balsini@android.com, dvyukov@google.com, tglx@linutronix.de,
        vpillai@digitalocean.com, rostedt@goodmis.org, peterz@infradead.org
Subject: [RFC][PATCH 12/13] sched/deadline: Introduce deadline servers
References: <20190726145409.947503076@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched.h   |   26 +++
 kernel/sched/core.c     |    5 
 kernel/sched/deadline.c |  327 +++++++++++++++++++++++++++++++-----------------
 kernel/sched/fair.c     |    4 
 kernel/sched/sched.h    |   29 ++++
 5 files changed, 277 insertions(+), 114 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -52,12 +52,14 @@ struct robust_list_head;
 struct root_domain;
 struct rq;
 struct sched_attr;
+struct sched_dl_entity;
 struct sched_param;
 struct seq_file;
 struct sighand_struct;
 struct signal_struct;
 struct task_delay_info;
 struct task_group;
+struct task_struct;
 
 /*
  * Task state bitmask. NOTE! These bits are also
@@ -509,6 +511,9 @@ struct sched_rt_entity {
 #endif
 } __randomize_layout;
 
+typedef bool (*dl_server_has_tasks_f)(struct sched_dl_entity *);
+typedef struct task_struct *(*dl_server_pick_f)(struct sched_dl_entity *);
+
 struct sched_dl_entity {
 	struct rb_node			rb_node;
 
@@ -561,6 +566,7 @@ struct sched_dl_entity {
 	unsigned int			dl_yielded        : 1;
 	unsigned int			dl_non_contending : 1;
 	unsigned int			dl_overrun	  : 1;
+	unsigned int			dl_server         : 1;
 
 	/*
 	 * Bandwidth enforcement timer. Each -deadline task has its
@@ -575,7 +581,20 @@ struct sched_dl_entity {
 	 * timer is needed to decrease the active utilization at the correct
 	 * time.
 	 */
-	struct hrtimer inactive_timer;
+	struct hrtimer			inactive_timer;
+
+	/*
+	 * Bits for DL-server functionality. Also see the comment near
+	 * dl_server_update().
+	 *
+	 * @rq the runqueue this server is for
+	 *
+	 * @server_has_tasks() returns true if @server_pick return a
+	 * runnable task.
+	 */
+	struct rq			*rq;
+	dl_server_has_tasks_f		server_has_tasks;
+	dl_server_pick_f		server_pick;
 };
 
 #ifdef CONFIG_UCLAMP_TASK
@@ -688,10 +707,13 @@ struct task_struct {
 	const struct sched_class	*sched_class;
 	struct sched_entity		se;
 	struct sched_rt_entity		rt;
+	struct sched_dl_entity		dl;
+
+	struct sched_dl_entity		*server;
+
 #ifdef CONFIG_CGROUP_SCHED
 	struct task_group		*sched_task_group;
 #endif
-	struct sched_dl_entity		dl;
 
 #ifdef CONFIG_UCLAMP_TASK
 	/* Clamp values requested for a scheduling entity */
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3756,8 +3756,11 @@ pick_next_task(struct rq *rq, struct tas
 
 	for_each_class(class) {
 		p = class->pick_next_task(rq, NULL, NULL);
-		if (p)
+		if (p) {
+			if (p->sched_class == class && p->server)
+				p->server = NULL;
 			return p;
+		}
 	}
 
 	/* The idle class should always have a runnable task: */
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -20,8 +20,14 @@
 
 struct dl_bandwidth def_dl_bandwidth;
 
+static bool dl_server(struct sched_dl_entity *dl_se)
+{
+	return dl_se->dl_server;
+}
+
 static inline struct task_struct *dl_task_of(struct sched_dl_entity *dl_se)
 {
+	BUG_ON(dl_server(dl_se));
 	return container_of(dl_se, struct task_struct, dl);
 }
 
@@ -30,14 +36,22 @@ static inline struct rq *rq_of_dl_rq(str
 	return container_of(dl_rq, struct rq, dl);
 }
 
-static inline struct dl_rq *dl_rq_of_se(struct sched_dl_entity *dl_se)
+static inline struct rq *rq_of_dl_se(struct sched_dl_entity *dl_se)
 {
-	struct task_struct *p = dl_task_of(dl_se);
-	struct rq *rq = task_rq(p);
+	struct rq *rq = dl_se->rq;
 
-	return &rq->dl;
+	if (!dl_server(dl_se))
+		rq = task_rq(dl_task_of(dl_se));
+
+	return rq;
+}
+
+static inline struct dl_rq *dl_rq_of_se(struct sched_dl_entity *dl_se)
+{
+	return &rq_of_dl_se(dl_se)->dl;
 }
 
+
 static inline int on_dl_rq(struct sched_dl_entity *dl_se)
 {
 	return !RB_EMPTY_NODE(&dl_se->rb_node);
@@ -239,8 +253,8 @@ static void __dl_clear_params(struct sch
 static void task_non_contending(struct sched_dl_entity *dl_se)
 {
 	struct hrtimer *timer = &dl_se->inactive_timer;
-	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
-	struct rq *rq = rq_of_dl_rq(dl_rq);
+	struct rq *rq = rq_of_dl_se(dl_se);
+	struct dl_rq *dl_rq = &rq->dl;
 	s64 zerolag_time;
 
 	/*
@@ -270,27 +284,32 @@ static void task_non_contending(struct s
 	 * utilization now, instead of starting a timer
 	 */
 	if ((zerolag_time < 0) || hrtimer_active(&dl_se->inactive_timer)) {
-		struct task_struct *p = dl_task_of(dl_se);
-
-		if (dl_task(p))
+		if (dl_server(dl_se)) {
 			sub_running_bw(dl_se, dl_rq);
+		} else {
+			struct task_struct *p = dl_task_of(dl_se);
 
-		if (!dl_task(p) || p->state == TASK_DEAD) {
-			struct dl_bw *dl_b = dl_bw_of(task_cpu(p));
+			if (dl_task(p))
+				sub_running_bw(dl_se, dl_rq);
 
-			if (p->state == TASK_DEAD)
-				sub_rq_bw(dl_se, &rq->dl);
-			raw_spin_lock(&dl_b->lock);
-			__dl_sub(dl_b, dl_se->dl_bw, dl_bw_cpus(task_cpu(p)));
-			__dl_clear_params(dl_se);
-			raw_spin_unlock(&dl_b->lock);
+			if (!dl_task(p) || p->state == TASK_DEAD) {
+				struct dl_bw *dl_b = dl_bw_of(task_cpu(p));
+
+				if (p->state == TASK_DEAD)
+					sub_rq_bw(dl_se, &rq->dl);
+				raw_spin_lock(&dl_b->lock);
+				__dl_sub(dl_b, dl_se->dl_bw, dl_bw_cpus(task_cpu(p)));
+				__dl_clear_params(dl_se);
+				raw_spin_unlock(&dl_b->lock);
+			}
 		}
 
 		return;
 	}
 
 	dl_se->dl_non_contending = 1;
-	get_task_struct(dl_task_of(dl_se));
+	if (!dl_server(dl_se))
+		get_task_struct(dl_task_of(dl_se));
 	hrtimer_start(timer, ns_to_ktime(zerolag_time), HRTIMER_MODE_REL);
 }
 
@@ -317,8 +336,10 @@ static void task_contending(struct sched
 		 * will not touch the rq's active utilization,
 		 * so we are still safe.
 		 */
-		if (hrtimer_try_to_cancel(&dl_se->inactive_timer) == 1)
-			put_task_struct(dl_task_of(dl_se));
+		if (hrtimer_try_to_cancel(&dl_se->inactive_timer) == 1) {
+			if (!dl_server(dl_se))
+				put_task_struct(dl_task_of(dl_se));
+		}
 	} else {
 		/*
 		 * Since "dl_non_contending" is not set, the
@@ -331,10 +352,8 @@ static void task_contending(struct sched
 	}
 }
 
-static inline int is_leftmost(struct task_struct *p, struct dl_rq *dl_rq)
+static inline int is_leftmost(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
 {
-	struct sched_dl_entity *dl_se = &p->dl;
-
 	return dl_rq->root.rb_leftmost == &dl_se->rb_node;
 }
 
@@ -428,8 +447,6 @@ static void inc_dl_migration(struct sche
 
 	if (p->nr_cpus_allowed > 1)
 		dl_rq->dl_nr_migratory++;
-
-	update_dl_migration(dl_rq);
 }
 
 static void dec_dl_migration(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
@@ -438,8 +455,6 @@ static void dec_dl_migration(struct sche
 
 	if (p->nr_cpus_allowed > 1)
 		dl_rq->dl_nr_migratory--;
-
-	update_dl_migration(dl_rq);
 }
 
 /*
@@ -607,8 +622,11 @@ static inline void deadline_queue_pull_t
 }
 #endif /* CONFIG_SMP */
 
+static void
+enqueue_dl_entity(struct sched_dl_entity *dl_se,
+		  struct sched_dl_entity *pi_se, int flags);
 static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags);
-static void __dequeue_task_dl(struct rq *rq, struct task_struct *p, int flags);
+static void dequeue_dl_entity(struct sched_dl_entity *dl_se, int flags);
 static void check_preempt_curr_dl(struct rq *rq, struct task_struct *p, int flags);
 
 /*
@@ -855,8 +873,7 @@ static inline bool dl_is_implicit(struct
 static void update_dl_entity(struct sched_dl_entity *dl_se,
 			     struct sched_dl_entity *pi_se)
 {
-	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
-	struct rq *rq = rq_of_dl_rq(dl_rq);
+	struct rq *rq = rq_of_dl_se(dl_se);
 
 	if (dl_time_before(dl_se->deadline, rq_clock(rq)) ||
 	    dl_entity_overflow(dl_se, pi_se, rq_clock(rq))) {
@@ -888,11 +905,11 @@ static inline u64 dl_next_period(struct
  * actually started or not (i.e., the replenishment instant is in
  * the future or in the past).
  */
-static int start_dl_timer(struct task_struct *p)
+static int start_dl_timer(struct sched_dl_entity *dl_se)
 {
-	struct sched_dl_entity *dl_se = &p->dl;
 	struct hrtimer *timer = &dl_se->dl_timer;
-	struct rq *rq = task_rq(p);
+	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
+	struct rq *rq = rq_of_dl_rq(dl_rq);
 	ktime_t now, act;
 	s64 delta;
 
@@ -926,13 +943,33 @@ static int start_dl_timer(struct task_st
 	 * and observe our state.
 	 */
 	if (!hrtimer_is_queued(timer)) {
-		get_task_struct(p);
+		if (!dl_server(dl_se))
+			get_task_struct(dl_task_of(dl_se));
 		hrtimer_start(timer, act, HRTIMER_MODE_ABS);
 	}
 
 	return 1;
 }
 
+static void __push_dl_task(struct rq *rq, struct rq_flags *rf)
+{
+#ifdef CONFIG_SMP
+	/*
+	 * Queueing this task back might have overloaded rq, check if we need
+	 * to kick someone away.
+	 */
+	if (has_pushable_dl_tasks(rq)) {
+		/*
+		 * Nothing relies on rq->lock after this, so its safe to drop
+		 * rq->lock.
+		 */
+		rq_unpin_lock(rq, rf);
+		push_dl_task(rq);
+		rq_repin_lock(rq, rf);
+	}
+#endif
+}
+
 /*
  * This is the bandwidth enforcement timer callback. If here, we know
  * a task is not on its dl_rq, since the fact that the timer was running
@@ -951,10 +988,34 @@ static enum hrtimer_restart dl_task_time
 	struct sched_dl_entity *dl_se = container_of(timer,
 						     struct sched_dl_entity,
 						     dl_timer);
-	struct task_struct *p = dl_task_of(dl_se);
+	struct task_struct *p;
 	struct rq_flags rf;
 	struct rq *rq;
 
+	if (dl_server(dl_se)) {
+		struct rq *rq = rq_of_dl_se(dl_se);
+		struct rq_flags rf;
+
+		rq_lock(rq, &rf);
+		if (dl_se->dl_throttled) {
+			sched_clock_tick();
+			update_rq_clock(rq);
+
+			if (dl_se->server_has_tasks(dl_se)) {
+				enqueue_dl_entity(dl_se, dl_se, ENQUEUE_REPLENISH);
+				resched_curr(rq);
+				__push_dl_task(rq, &rf);
+			} else {
+				replenish_dl_entity(dl_se, dl_se);
+			}
+
+		}
+		rq_unlock(rq, &rf);
+
+		return HRTIMER_NORESTART;
+	}
+
+	p = dl_task_of(dl_se);
 	rq = task_rq_lock(p, &rf);
 
 	/*
@@ -1025,21 +1086,7 @@ static enum hrtimer_restart dl_task_time
 	else
 		resched_curr(rq);
 
-#ifdef CONFIG_SMP
-	/*
-	 * Queueing this task back might have overloaded rq, check if we need
-	 * to kick someone away.
-	 */
-	if (has_pushable_dl_tasks(rq)) {
-		/*
-		 * Nothing relies on rq->lock after this, so its safe to drop
-		 * rq->lock.
-		 */
-		rq_unpin_lock(rq, &rf);
-		push_dl_task(rq);
-		rq_repin_lock(rq, &rf);
-	}
-#endif
+	__push_dl_task(rq, &rf);
 
 unlock:
 	task_rq_unlock(rq, p, &rf);
@@ -1081,12 +1128,11 @@ static void init_dl_task_timer(struct sc
  */
 static inline void dl_check_constrained_dl(struct sched_dl_entity *dl_se)
 {
-	struct task_struct *p = dl_task_of(dl_se);
-	struct rq *rq = rq_of_dl_rq(dl_rq_of_se(dl_se));
+	struct rq *rq = rq_of_dl_se(dl_se);
 
 	if (dl_time_before(dl_se->deadline, rq_clock(rq)) &&
 	    dl_time_before(rq_clock(rq), dl_next_period(dl_se))) {
-		if (unlikely(dl_se->dl_boosted || !start_dl_timer(p)))
+		if (unlikely(dl_se->dl_boosted || !start_dl_timer(dl_se)))
 			return;
 		dl_se->dl_throttled = 1;
 		if (dl_se->runtime > 0)
@@ -1143,29 +1189,10 @@ static u64 grub_reclaim(u64 delta, struc
 	return (delta * u_act) >> BW_SHIFT;
 }
 
-/*
- * Update the current task's runtime statistics (provided it is still
- * a -deadline task and has not been removed from the dl_rq).
- */
-static void update_curr_dl(struct rq *rq)
+static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64 delta_exec)
 {
-	struct task_struct *curr = rq->curr;
-	struct sched_dl_entity *dl_se = &curr->dl;
-	s64 delta_exec, scaled_delta_exec;
-	int cpu = cpu_of(rq);
-
-	if (!dl_task(curr) || !on_dl_rq(dl_se))
-		return;
+	s64 scaled_delta_exec;
 
-	/*
-	 * Consumed budget is computed considering the time as
-	 * observed by schedulable tasks (excluding time spent
-	 * in hardirq context, etc.). Deadlines are instead
-	 * computed using hard walltime. This seems to be the more
-	 * natural solution, but the full ramifications of this
-	 * approach need further study.
-	 */
-	delta_exec = update_curr_common(rq);
 	if (unlikely(delta_exec <= 0)) {
 		if (unlikely(dl_se->dl_yielded))
 			goto throttle;
@@ -1183,10 +1210,9 @@ static void update_curr_dl(struct rq *rq
 	 * according to current frequency and CPU maximum capacity.
 	 */
 	if (unlikely(dl_se->flags & SCHED_FLAG_RECLAIM)) {
-		scaled_delta_exec = grub_reclaim(delta_exec,
-						 rq,
-						 &curr->dl);
+		scaled_delta_exec = grub_reclaim(delta_exec, rq, dl_se);
 	} else {
+		int cpu = cpu_of(rq);
 		unsigned long scale_freq = arch_scale_freq_capacity(cpu);
 		unsigned long scale_cpu = arch_scale_cpu_capacity(cpu);
 
@@ -1205,11 +1231,18 @@ static void update_curr_dl(struct rq *rq
 		    (dl_se->flags & SCHED_FLAG_DL_OVERRUN))
 			dl_se->dl_overrun = 1;
 
-		__dequeue_task_dl(rq, curr, 0);
-		if (unlikely(dl_se->dl_boosted || !start_dl_timer(curr)))
-			enqueue_task_dl(rq, curr, ENQUEUE_REPLENISH);
+		dequeue_dl_entity(dl_se, 0);
+		if (!dl_server(dl_se))
+			dequeue_pushable_dl_task(rq, dl_task_of(dl_se));
+
+		if (unlikely(dl_se->dl_boosted || !start_dl_timer(dl_se))) {
+			if (dl_server(dl_se))
+				enqueue_dl_entity(dl_se, dl_se, ENQUEUE_REPLENISH);
+			else
+				enqueue_task_dl(rq, dl_task_of(dl_se), ENQUEUE_REPLENISH);
+		}
 
-		if (!is_leftmost(curr, &rq->dl))
+		if (!is_leftmost(dl_se, &rq->dl))
 			resched_curr(rq);
 	}
 
@@ -1239,20 +1272,81 @@ static void update_curr_dl(struct rq *rq
 	}
 }
 
+void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec)
+{
+	update_curr_dl_se(dl_se->rq, dl_se, delta_exec);
+}
+
+void dl_server_start(struct sched_dl_entity *dl_se)
+{
+	enqueue_dl_entity(dl_se, dl_se, ENQUEUE_WAKEUP);
+}
+
+void dl_server_stop(struct sched_dl_entity *dl_se)
+{
+	dequeue_dl_entity(dl_se, DEQUEUE_SLEEP);
+}
+
+void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
+		    dl_server_has_tasks_f has_tasks,
+		    dl_server_pick_f pick)
+{
+	dl_se->dl_server = 1;
+	dl_se->rq = rq;
+	dl_se->server_has_tasks = has_tasks;
+	dl_se->server_pick = pick;
+
+	setup_new_dl_entity(dl_se);
+}
+
+/*
+ * Update the current task's runtime statistics (provided it is still
+ * a -deadline task and has not been removed from the dl_rq).
+ */
+static void update_curr_dl(struct rq *rq)
+{
+	struct task_struct *curr = rq->curr;
+	struct sched_dl_entity *dl_se = &curr->dl;
+	s64 delta_exec;
+
+	if (!dl_task(curr) || !on_dl_rq(dl_se))
+		return;
+
+	/*
+	 * Consumed budget is computed considering the time as
+	 * observed by schedulable tasks (excluding time spent
+	 * in hardirq context, etc.). Deadlines are instead
+	 * computed using hard walltime. This seems to be the more
+	 * natural solution, but the full ramifications of this
+	 * approach need further study.
+	 */
+	delta_exec = update_curr_common(rq);
+	update_curr_dl_se(rq, dl_se, delta_exec);
+}
+
 static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
 {
 	struct sched_dl_entity *dl_se = container_of(timer,
 						     struct sched_dl_entity,
 						     inactive_timer);
-	struct task_struct *p = dl_task_of(dl_se);
+	struct task_struct *p = NULL;
 	struct rq_flags rf;
 	struct rq *rq;
 
-	rq = task_rq_lock(p, &rf);
+	if (!dl_server(dl_se)) {
+		p = dl_task_of(dl_se);
+		rq = task_rq_lock(p, &rf);
+	} else {
+		rq = dl_se->rq;
+		rq_lock(rq, &rf);
+	}
 
 	sched_clock_tick();
 	update_rq_clock(rq);
 
+	if (dl_server(dl_se))
+		goto no_task;
+
 	if (!dl_task(p) || p->state == TASK_DEAD) {
 		struct dl_bw *dl_b = dl_bw_of(task_cpu(p));
 
@@ -1269,14 +1363,21 @@ static enum hrtimer_restart inactive_tas
 
 		goto unlock;
 	}
+
+no_task:
 	if (dl_se->dl_non_contending == 0)
 		goto unlock;
 
 	sub_running_bw(dl_se, &rq->dl);
 	dl_se->dl_non_contending = 0;
 unlock:
-	task_rq_unlock(rq, p, &rf);
-	put_task_struct(p);
+
+	if (!dl_server(dl_se)) {
+		task_rq_unlock(rq, p, &rf);
+		put_task_struct(p);
+	} else {
+		rq_unlock(rq, &rf);
+	}
 
 	return HRTIMER_NORESTART;
 }
@@ -1334,29 +1435,28 @@ static inline void dec_dl_deadline(struc
 static inline
 void inc_dl_tasks(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
 {
-	int prio = dl_task_of(dl_se)->prio;
 	u64 deadline = dl_se->deadline;
 
-	WARN_ON(!dl_prio(prio));
 	dl_rq->dl_nr_running++;
 	add_nr_running(rq_of_dl_rq(dl_rq), 1);
 
 	inc_dl_deadline(dl_rq, deadline);
-	inc_dl_migration(dl_se, dl_rq);
+	if (!dl_server(dl_se))
+		inc_dl_migration(dl_se, dl_rq);
+	update_dl_migration(dl_rq);
 }
 
 static inline
 void dec_dl_tasks(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
 {
-	int prio = dl_task_of(dl_se)->prio;
-
-	WARN_ON(!dl_prio(prio));
 	WARN_ON(!dl_rq->dl_nr_running);
 	dl_rq->dl_nr_running--;
 	sub_nr_running(rq_of_dl_rq(dl_rq), 1);
 
 	dec_dl_deadline(dl_rq, dl_se->deadline);
-	dec_dl_migration(dl_se, dl_rq);
+	if (!dl_server(dl_se))
+		dec_dl_migration(dl_se, dl_rq);
+	update_dl_migration(dl_rq);
 }
 
 static void __enqueue_dl_entity(struct sched_dl_entity *dl_se)
@@ -1451,8 +1551,7 @@ enqueue_dl_entity(struct sched_dl_entity
 	} else if (flags & ENQUEUE_REPLENISH) {
 		replenish_dl_entity(dl_se, pi_se);
 	} else if ((flags & ENQUEUE_RESTORE) &&
-		  dl_time_before(dl_se->deadline,
-				 rq_clock(rq_of_dl_rq(dl_rq_of_se(dl_se))))) {
+		   dl_time_before(dl_se->deadline, rq_clock(rq_of_dl_se(dl_se)))) {
 		setup_new_dl_entity(dl_se);
 	}
 
@@ -1519,12 +1618,6 @@ static void enqueue_task_dl(struct rq *r
 		enqueue_pushable_dl_task(rq, p);
 }
 
-static void __dequeue_task_dl(struct rq *rq, struct task_struct *p, int flags)
-{
-	dequeue_dl_entity(&p->dl, flags);
-	dequeue_pushable_dl_task(rq, p);
-}
-
 static void dequeue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 {
 	update_curr_dl(rq);
@@ -1532,7 +1625,8 @@ static void dequeue_task_dl(struct rq *r
 	if (p->on_rq == TASK_ON_RQ_MIGRATING)
 		flags |= DEQUEUE_MIGRATING;
 
-	__dequeue_task_dl(rq, p, flags);
+	dequeue_dl_entity(&p->dl, flags);
+	dequeue_pushable_dl_task(rq, p);
 }
 
 /*
@@ -1688,12 +1782,12 @@ static void check_preempt_curr_dl(struct
 }
 
 #ifdef CONFIG_SCHED_HRTICK
-static void start_hrtick_dl(struct rq *rq, struct task_struct *p)
+static void start_hrtick_dl(struct rq *rq, struct sched_dl_entity *dl_se)
 {
-	hrtick_start(rq, p->dl.runtime);
+	hrtick_start(rq, dl_se->runtime);
 }
 #else /* !CONFIG_SCHED_HRTICK */
-static void start_hrtick_dl(struct rq *rq, struct task_struct *p)
+static void start_hrtick_dl(struct rq *rq, struct sched_dl_entity *dl_se)
 {
 }
 #endif
@@ -1705,9 +1799,6 @@ static void set_next_task_dl(struct rq *
 	/* You can't push away the running task */
 	dequeue_pushable_dl_task(rq, p);
 
-	if (hrtick_enabled(rq))
-		start_hrtick_dl(rq, p);
-
 	if (rq->curr->sched_class != &dl_sched_class)
 		update_dl_rq_load_avg(rq_clock_pelt(rq), rq, 0);
 
@@ -1737,15 +1828,29 @@ pick_next_task_dl(struct rq *rq, struct
 
 	dl_rq = &rq->dl;
 
+again:
 	if (unlikely(!dl_rq->dl_nr_running))
 		return NULL;
 
 	dl_se = pick_next_dl_entity(rq, dl_rq);
 	BUG_ON(!dl_se);
 
-	p = dl_task_of(dl_se);
+	if (dl_server(dl_se)) {
+		p = dl_se->server_pick(dl_se);
+		if (!p) {
+			// XXX should not happen, warn?!
+			dl_se->dl_yielded = 1;
+			update_curr_dl_se(rq, dl_se, 0);
+			goto again;
+		}
+		p->server = dl_se;
+	} else {
+		p = dl_task_of(dl_se);
+		set_next_task_dl(rq, p);
+	}
 
-	set_next_task_dl(rq, p);
+	if (hrtick_enabled(rq))
+		start_hrtick_dl(rq, dl_se);
 
 	return p;
 }
@@ -1790,8 +1895,8 @@ static void task_tick_dl(struct rq *rq,
 	 * be set and schedule() will start a new hrtick for the next task.
 	 */
 	if (hrtick_enabled(rq) && queued && p->dl.runtime > 0 &&
-	    is_leftmost(p, &rq->dl))
-		start_hrtick_dl(rq, p);
+	    is_leftmost(&p->dl, &rq->dl))
+		start_hrtick_dl(rq, &p->dl);
 }
 
 static void task_fork_dl(struct task_struct *p)
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -860,6 +860,8 @@ s64 update_curr_common(struct rq *rq)
 
 	account_group_exec_runtime(curr, delta_exec);
 	cgroup_account_cputime(curr, delta_exec);
+	if (curr->server)
+		dl_server_update(curr->server, delta_exec);
 
 	return delta_exec;
 }
@@ -889,6 +891,8 @@ static void update_curr(struct cfs_rq *c
 		trace_sched_stat_runtime(curtask, delta_exec, curr->vruntime);
 		cgroup_account_cputime(curtask, delta_exec);
 		account_group_exec_runtime(curtask, delta_exec);
+		if (curtask->server)
+			dl_server_update(curtask->server, delta_exec);
 	}
 
 	account_cfs_rq_runtime(cfs_rq, delta_exec);
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -316,6 +316,35 @@ extern int  dl_task_can_attach(struct ta
 extern int  dl_cpuset_cpumask_can_shrink(const struct cpumask *cur, const struct cpumask *trial);
 extern bool dl_cpu_busy(unsigned int cpu);
 
+/*
+ * SCHED_DEADLINE supports servers (nested scheduling) with the following
+ * interface:
+ *
+ *   dl_se::rq -- runqueue we belong to.
+ *
+ *   dl_se::server_has_tasks() -- used on bandwidth enforcement; we 'stop' the
+ *                                server when it runs out of tasks to run.
+ *
+ *   dl_se::server_pick() -- nested pick_next_task(); we yield the period if this
+ *                           returns NULL.
+ *
+ *   dl_server_update() -- called from update_curr_common(), propagates runtime
+ *                         to the server.
+ *
+ *   dl_server_start()
+ *   dl_server_stop()  -- start/stop the server when it has (no) tasks
+ *
+ *   dl_server_init()
+ *
+ * XXX
+ */
+extern void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec);
+extern void dl_server_start(struct sched_dl_entity *dl_se);
+extern void dl_server_stop(struct sched_dl_entity *dl_se);
+extern void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
+		    dl_server_has_tasks_f has_tasks,
+		    dl_server_pick_f pick);
+
 #ifdef CONFIG_CGROUP_SCHED
 
 #include <linux/cgroup.h>


