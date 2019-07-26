Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99718C76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 16:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EDBE218EA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 16:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aNBDuw0P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbfGZQUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 12:20:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52126 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728553AbfGZQU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 12:20:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=O7A5d/em5FkEGHseGCgsmtgjboa5yxZdBBZ+Ha2b1dI=; b=aNBDuw0PPuaYKAAKBYPvFgqgX9
        xXHmsnBreQRk3SkolA5D989oGtTyR+HxiOFXDDO5IXIc7lZWzUlL2r0apy/FPnXqndC9M79biIlVj
        jLumQ/+r/BbdDZPWeqJ6eDrkJwgS08N6vsgFp3Qh11sb+Nz6vECe9yEge32onSOWzAiIZVCvRg+Vn
        A8dSYdP6PR9ZsxZOYDxK8rkQiwRZFZ48DyaILKAkjm+1+5Jpd7wbI3XJwDRnVpaWjIRm5W4jaEftB
        Z9yZqxMfhrLdQfj+q8N0Xgpa7nfJrAoLWo1cwfxH/1jqgV8W122WFgY5GlGM5/pbmtj/JnG6WjxQB
        wVy9lIhw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hr2wz-0006vo-A1; Fri, 26 Jul 2019 16:20:09 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5053A20229751; Fri, 26 Jul 2019 18:20:05 +0200 (CEST)
Message-Id: <20190726161357.638193058@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 26 Jul 2019 16:54:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, juri.lelli@redhat.com
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        luca.abeni@santannapisa.it, bristot@redhat.com,
        balsini@android.com, dvyukov@google.com, tglx@linutronix.de,
        vpillai@digitalocean.com, rostedt@goodmis.org, peterz@infradead.org
Subject: [RFC][PATCH 05/13] sched: Add task_struct pointer to sched_class::set_curr_task
References: <20190726145409.947503076@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation of further separating pick_next_task() and
set_curr_task() we have to pass the actual task into it, while there,
rename the thing to better pair with put_prev_task().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c      |   12 ++++++------
 kernel/sched/deadline.c  |    7 +------
 kernel/sched/fair.c      |   17 ++++++++++++++---
 kernel/sched/idle.c      |   27 +++++++++++++++------------
 kernel/sched/rt.c        |    7 +------
 kernel/sched/sched.h     |    8 +++++---
 kernel/sched/stop_task.c |   17 +++++++----------
 7 files changed, 49 insertions(+), 46 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1494,7 +1494,7 @@ void do_set_cpus_allowed(struct task_str
 	if (queued)
 		enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
 	if (running)
-		set_curr_task(rq, p);
+		set_next_task(rq, p);
 }
 
 /*
@@ -4273,7 +4273,7 @@ void rt_mutex_setprio(struct task_struct
 	if (queued)
 		enqueue_task(rq, p, queue_flag);
 	if (running)
-		set_curr_task(rq, p);
+		set_next_task(rq, p);
 
 	check_class_changed(rq, p, prev_class, oldprio);
 out_unlock:
@@ -4340,7 +4340,7 @@ void set_user_nice(struct task_struct *p
 			resched_curr(rq);
 	}
 	if (running)
-		set_curr_task(rq, p);
+		set_next_task(rq, p);
 out_unlock:
 	task_rq_unlock(rq, p, &rf);
 }
@@ -4783,7 +4783,7 @@ static int __sched_setscheduler(struct t
 		enqueue_task(rq, p, queue_flags);
 	}
 	if (running)
-		set_curr_task(rq, p);
+		set_next_task(rq, p);
 
 	check_class_changed(rq, p, prev_class, oldprio);
 
@@ -5972,7 +5972,7 @@ void sched_setnuma(struct task_struct *p
 	if (queued)
 		enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
 	if (running)
-		set_curr_task(rq, p);
+		set_next_task(rq, p);
 	task_rq_unlock(rq, p, &rf);
 }
 #endif /* CONFIG_NUMA_BALANCING */
@@ -6853,7 +6853,7 @@ void sched_move_task(struct task_struct
 	if (queued)
 		enqueue_task(rq, tsk, queue_flags);
 	if (running)
-		set_curr_task(rq, tsk);
+		set_next_task(rq, tsk);
 
 	task_rq_unlock(rq, tsk, &rf);
 }
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1812,11 +1812,6 @@ static void task_fork_dl(struct task_str
 	 */
 }
 
-static void set_curr_task_dl(struct rq *rq)
-{
-	set_next_task_dl(rq, rq->curr);
-}
-
 #ifdef CONFIG_SMP
 
 /* Only try algorithms three times */
@@ -2404,6 +2399,7 @@ const struct sched_class dl_sched_class
 
 	.pick_next_task		= pick_next_task_dl,
 	.put_prev_task		= put_prev_task_dl,
+	.set_next_task		= set_next_task_dl,
 
 #ifdef CONFIG_SMP
 	.select_task_rq		= select_task_rq_dl,
@@ -2414,7 +2410,6 @@ const struct sched_class dl_sched_class
 	.task_woken		= task_woken_dl,
 #endif
 
-	.set_curr_task		= set_curr_task_dl,
 	.task_tick		= task_tick_dl,
 	.task_fork              = task_fork_dl,
 
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10121,9 +10121,19 @@ static void switched_to_fair(struct rq *
  * This routine is mostly called to set cfs_rq->curr field when a task
  * migrates between groups/classes.
  */
-static void set_curr_task_fair(struct rq *rq)
+static void set_next_task_fair(struct rq *rq, struct task_struct *p)
 {
-	struct sched_entity *se = &rq->curr->se;
+	struct sched_entity *se = &p->se;
+
+#ifdef CONFIG_SMP
+	if (task_on_rq_queued(p)) {
+		/*
+		 * Move the next running task to the front of the list, so our
+		 * cfs_tasks list becomes MRU one.
+		 */
+		list_move(&se->group_node, &rq->cfs_tasks);
+	}
+#endif
 
 	for_each_sched_entity(se) {
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
@@ -10394,7 +10404,9 @@ const struct sched_class fair_sched_clas
 	.check_preempt_curr	= check_preempt_wakeup,
 
 	.pick_next_task		= pick_next_task_fair,
+
 	.put_prev_task		= put_prev_task_fair,
+	.set_next_task          = set_next_task_fair,
 
 #ifdef CONFIG_SMP
 	.select_task_rq		= select_task_rq_fair,
@@ -10407,7 +10419,6 @@ const struct sched_class fair_sched_clas
 	.set_cpus_allowed	= set_cpus_allowed_common,
 #endif
 
-	.set_curr_task          = set_curr_task_fair,
 	.task_tick		= task_tick_fair,
 	.task_fork		= task_fork_fair,
 
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -374,14 +374,25 @@ static void check_preempt_curr_idle(stru
 	resched_curr(rq);
 }
 
+static void put_prev_task_idle(struct rq *rq, struct task_struct *prev)
+{
+}
+
+static void set_next_task_idle(struct rq *rq, struct task_struct *next)
+{
+	update_idle_core(rq);
+	schedstat_inc(rq->sched_goidle);
+}
+
 static struct task_struct *
 pick_next_task_idle(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
+	struct task_struct *next = rq->idle;
+
 	put_prev_task(rq, prev);
-	update_idle_core(rq);
-	schedstat_inc(rq->sched_goidle);
+	set_next_task_idle(rq, next);
 
-	return rq->idle;
+	return next;
 }
 
 /*
@@ -397,10 +408,6 @@ dequeue_task_idle(struct rq *rq, struct
 	raw_spin_lock_irq(&rq->lock);
 }
 
-static void put_prev_task_idle(struct rq *rq, struct task_struct *prev)
-{
-}
-
 /*
  * scheduler tick hitting a task of our scheduling class.
  *
@@ -413,10 +420,6 @@ static void task_tick_idle(struct rq *rq
 {
 }
 
-static void set_curr_task_idle(struct rq *rq)
-{
-}
-
 static void switched_to_idle(struct rq *rq, struct task_struct *p)
 {
 	BUG();
@@ -451,13 +454,13 @@ const struct sched_class idle_sched_clas
 
 	.pick_next_task		= pick_next_task_idle,
 	.put_prev_task		= put_prev_task_idle,
+	.set_next_task          = set_next_task_idle,
 
 #ifdef CONFIG_SMP
 	.select_task_rq		= select_task_rq_idle,
 	.set_cpus_allowed	= set_cpus_allowed_common,
 #endif
 
-	.set_curr_task          = set_curr_task_idle,
 	.task_tick		= task_tick_idle,
 
 	.get_rr_interval	= get_rr_interval_idle,
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2355,11 +2355,6 @@ static void task_tick_rt(struct rq *rq,
 	}
 }
 
-static void set_curr_task_rt(struct rq *rq)
-{
-	set_next_task_rt(rq, rq->curr);
-}
-
 static unsigned int get_rr_interval_rt(struct rq *rq, struct task_struct *task)
 {
 	/*
@@ -2381,6 +2376,7 @@ const struct sched_class rt_sched_class
 
 	.pick_next_task		= pick_next_task_rt,
 	.put_prev_task		= put_prev_task_rt,
+	.set_next_task          = set_next_task_rt,
 
 #ifdef CONFIG_SMP
 	.select_task_rq		= select_task_rq_rt,
@@ -2392,7 +2388,6 @@ const struct sched_class rt_sched_class
 	.switched_from		= switched_from_rt,
 #endif
 
-	.set_curr_task          = set_curr_task_rt,
 	.task_tick		= task_tick_rt,
 
 	.get_rr_interval	= get_rr_interval_rt,
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1711,6 +1711,7 @@ struct sched_class {
 					       struct task_struct *prev,
 					       struct rq_flags *rf);
 	void (*put_prev_task)(struct rq *rq, struct task_struct *p);
+	void (*set_next_task)(struct rq *rq, struct task_struct *p);
 
 #ifdef CONFIG_SMP
 	int  (*select_task_rq)(struct task_struct *p, int task_cpu, int sd_flag, int flags);
@@ -1725,7 +1726,6 @@ struct sched_class {
 	void (*rq_offline)(struct rq *rq);
 #endif
 
-	void (*set_curr_task)(struct rq *rq);
 	void (*task_tick)(struct rq *rq, struct task_struct *p, int queued);
 	void (*task_fork)(struct task_struct *p);
 	void (*task_dead)(struct task_struct *p);
@@ -1755,12 +1755,14 @@ struct sched_class {
 
 static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
 {
+	WARN_ON_ONCE(rq->curr != prev);
 	prev->sched_class->put_prev_task(rq, prev);
 }
 
-static inline void set_curr_task(struct rq *rq, struct task_struct *curr)
+static inline void set_next_task(struct rq *rq, struct task_struct *next)
 {
-	curr->sched_class->set_curr_task(rq);
+	WARN_ON_ONCE(rq->curr != next);
+	next->sched_class->set_next_task(rq, next);
 }
 
 #ifdef CONFIG_SMP
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -23,6 +23,11 @@ check_preempt_curr_stop(struct rq *rq, s
 	/* we're never preempted */
 }
 
+static void set_next_task_stop(struct rq *rq, struct task_struct *stop)
+{
+	stop->se.exec_start = rq_clock_task(rq);
+}
+
 static struct task_struct *
 pick_next_task_stop(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
@@ -32,8 +37,7 @@ pick_next_task_stop(struct rq *rq, struc
 		return NULL;
 
 	put_prev_task(rq, prev);
-
-	stop->se.exec_start = rq_clock_task(rq);
+	set_next_task_stop(rq, stop);
 
 	return stop;
 }
@@ -86,13 +90,6 @@ static void task_tick_stop(struct rq *rq
 {
 }
 
-static void set_curr_task_stop(struct rq *rq)
-{
-	struct task_struct *stop = rq->stop;
-
-	stop->se.exec_start = rq_clock_task(rq);
-}
-
 static void switched_to_stop(struct rq *rq, struct task_struct *p)
 {
 	BUG(); /* its impossible to change to this class */
@@ -128,13 +125,13 @@ const struct sched_class stop_sched_clas
 
 	.pick_next_task		= pick_next_task_stop,
 	.put_prev_task		= put_prev_task_stop,
+	.set_next_task          = set_next_task_stop,
 
 #ifdef CONFIG_SMP
 	.select_task_rq		= select_task_rq_stop,
 	.set_cpus_allowed	= set_cpus_allowed_common,
 #endif
 
-	.set_curr_task          = set_curr_task_stop,
 	.task_tick		= task_tick_stop,
 
 	.get_rr_interval	= get_rr_interval_stop,


