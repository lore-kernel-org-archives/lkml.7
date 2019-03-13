Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE95EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA182087C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfCMQ4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 12:56:01 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48139 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfCMQz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 12:55:57 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1h47AX-00020b-O9; Wed, 13 Mar 2019 17:55:53 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/2] sched: Distangle worker accounting from rq lock
Date:   Wed, 13 Mar 2019 17:55:48 +0100
Message-Id: <20190313165548.19713-3-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190313165548.19713-1-bigeasy@linutronix.de>
References: <20190313165548.19713-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The worker accounting for CPU bound workers is plugged into the core
scheduler code and the wakeup code. This is not a hard requirement and
can be avoided by keeping track of the state in the workqueue code
itself.

Keep track of the sleeping state in the worker itself and call the
notifier before entering the core scheduler. There might be false
positives when the task is woken between that call and actually
scheduling, but that's not really different from scheduling and being
woken immediately after switching away. When nr_running is updated when
the task is retunrning from schedule() then it is later compared when it
is done from ttwu().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Link: http://lkml.kernel.org/r/20110622174919.135236139@linutronix.de
Link: http://lkml.kernel.org/r/ad2b29b5715f970bffc1a7026cabd6ff0b24076a.1532952814.git.bristot@redhat.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[bigeasy: preempt_disable() around wq_worker_sleeping() by Daniel Bristot de
          Oliveira]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/sched/core.c         | 88 +++++++++----------------------------
 kernel/workqueue.c          | 54 ++++++++++-------------
 kernel/workqueue_internal.h |  5 ++-
 3 files changed, 48 insertions(+), 99 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d8d76a65cfdd5..82fb09672902d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1655,10 +1655,6 @@ static inline void ttwu_activate(struct rq *rq, struct task_struct *p, int en_fl
 {
 	activate_task(rq, p, en_flags);
 	p->on_rq = TASK_ON_RQ_QUEUED;
-
-	/* If a worker is waking up, notify the workqueue: */
-	if (p->flags & PF_WQ_WORKER)
-		wq_worker_waking_up(p, cpu_of(rq));
 }
 
 /*
@@ -2076,56 +2072,6 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	return success;
 }
 
-/**
- * try_to_wake_up_local - try to wake up a local task with rq lock held
- * @p: the thread to be awakened
- * @rf: request-queue flags for pinning
- *
- * Put @p on the run-queue if it's not already there. The caller must
- * ensure that this_rq() is locked, @p is bound to this_rq() and not
- * the current task.
- */
-static void try_to_wake_up_local(struct task_struct *p, struct rq_flags *rf)
-{
-	struct rq *rq = task_rq(p);
-
-	if (WARN_ON_ONCE(rq != this_rq()) ||
-	    WARN_ON_ONCE(p == current))
-		return;
-
-	lockdep_assert_held(&rq->lock);
-
-	if (!raw_spin_trylock(&p->pi_lock)) {
-		/*
-		 * This is OK, because current is on_cpu, which avoids it being
-		 * picked for load-balance and preemption/IRQs are still
-		 * disabled avoiding further scheduler activity on it and we've
-		 * not yet picked a replacement task.
-		 */
-		rq_unlock(rq, rf);
-		raw_spin_lock(&p->pi_lock);
-		rq_relock(rq, rf);
-	}
-
-	if (!(p->state & TASK_NORMAL))
-		goto out;
-
-	trace_sched_waking(p);
-
-	if (!task_on_rq_queued(p)) {
-		if (p->in_iowait) {
-			delayacct_blkio_end(p);
-			atomic_dec(&rq->nr_iowait);
-		}
-		ttwu_activate(rq, p, ENQUEUE_WAKEUP | ENQUEUE_NOCLOCK);
-	}
-
-	ttwu_do_wakeup(rq, p, 0, rf);
-	ttwu_stat(p, smp_processor_id(), 0);
-out:
-	raw_spin_unlock(&p->pi_lock);
-}
-
 /**
  * wake_up_process - Wake up a specific process
  * @p: The process to be woken up.
@@ -3439,19 +3385,6 @@ static void __sched notrace __schedule(bool preempt)
 				atomic_inc(&rq->nr_iowait);
 				delayacct_blkio_start();
 			}
-
-			/*
-			 * If a worker went to sleep, notify and ask workqueue
-			 * whether it wants to wake up a task to maintain
-			 * concurrency.
-			 */
-			if (prev->flags & PF_WQ_WORKER) {
-				struct task_struct *to_wakeup;
-
-				to_wakeup = wq_worker_sleeping(prev);
-				if (to_wakeup)
-					try_to_wake_up_local(to_wakeup, &rf);
-			}
 		}
 		switch_count = &prev->nvcsw;
 	}
@@ -3511,6 +3444,20 @@ static inline void sched_submit_work(struct task_struct *tsk)
 {
 	if (!tsk->state || tsk_is_pi_blocked(tsk))
 		return;
+
+	/*
+	 * If a worker went to sleep, notify and ask workqueue whether
+	 * it wants to wake up a task to maintain concurrency.
+	 * As this function is called inside the schedule() context,
+	 * we disable preemption to avoid it calling schedule() again
+	 * in the possible wakeup of a kworker.
+	 */
+	if (tsk->flags & PF_WQ_WORKER) {
+		preempt_disable();
+		wq_worker_sleeping(tsk);
+		preempt_enable_no_resched();
+	}
+
 	/*
 	 * If we are going to sleep and we have plugged IO queued,
 	 * make sure to submit it to avoid deadlocks.
@@ -3519,6 +3466,12 @@ static inline void sched_submit_work(struct task_struct *tsk)
 		blk_schedule_flush_plug(tsk);
 }
 
+static void sched_update_worker(struct task_struct *tsk)
+{
+	if (tsk->flags & PF_WQ_WORKER)
+		wq_worker_running(tsk);
+}
+
 asmlinkage __visible void __sched schedule(void)
 {
 	struct task_struct *tsk = current;
@@ -3529,6 +3482,7 @@ asmlinkage __visible void __sched schedule(void)
 		__schedule(false);
 		sched_preempt_enable_no_resched();
 	} while (need_resched());
+	sched_update_worker(tsk);
 }
 EXPORT_SYMBOL(schedule);
 
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 9d22030ae7f44..e785fdd7dc537 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -839,43 +839,32 @@ static void wake_up_worker(struct worker_pool *pool)
 }
 
 /**
- * wq_worker_waking_up - a worker is waking up
+ * wq_worker_running - a worker is running again
  * @task: task waking up
- * @cpu: CPU @task is waking up to
  *
- * This function is called during try_to_wake_up() when a worker is
- * being awoken.
- *
- * CONTEXT:
- * spin_lock_irq(rq->lock)
+ * This function is called when a worker returns from schedule()
  */
-void wq_worker_waking_up(struct task_struct *task, int cpu)
+void wq_worker_running(struct task_struct *task)
 {
 	struct worker *worker = kthread_data(task);
 
-	if (!(worker->flags & WORKER_NOT_RUNNING)) {
-		WARN_ON_ONCE(worker->pool->cpu != cpu);
+	if (!worker->sleeping)
+		return;
+	if (!(worker->flags & WORKER_NOT_RUNNING))
 		atomic_inc(&worker->pool->nr_running);
-	}
+	worker->sleeping = 0;
 }
 
 /**
  * wq_worker_sleeping - a worker is going to sleep
  * @task: task going to sleep
  *
- * This function is called during schedule() when a busy worker is
- * going to sleep.  Worker on the same cpu can be woken up by
- * returning pointer to its task.
- *
- * CONTEXT:
- * spin_lock_irq(rq->lock)
- *
- * Return:
- * Worker task on @cpu to wake up, %NULL if none.
+ * This function is called from schedule() when a busy worker is
+ * going to sleep.
  */
-struct task_struct *wq_worker_sleeping(struct task_struct *task)
+void wq_worker_sleeping(struct task_struct *task)
 {
-	struct worker *worker = kthread_data(task), *to_wakeup = NULL;
+	struct worker *next, *worker = kthread_data(task);
 	struct worker_pool *pool;
 
 	/*
@@ -884,13 +873,15 @@ struct task_struct *wq_worker_sleeping(struct task_struct *task)
 	 * checking NOT_RUNNING.
 	 */
 	if (worker->flags & WORKER_NOT_RUNNING)
-		return NULL;
+		return;
 
 	pool = worker->pool;
 
-	/* this can only happen on the local cpu */
-	if (WARN_ON_ONCE(pool->cpu != raw_smp_processor_id()))
-		return NULL;
+	if (WARN_ON_ONCE(worker->sleeping))
+		return;
+
+	worker->sleeping = 1;
+	spin_lock_irq(&pool->lock);
 
 	/*
 	 * The counterpart of the following dec_and_test, implied mb,
@@ -904,9 +895,12 @@ struct task_struct *wq_worker_sleeping(struct task_struct *task)
 	 * lock is safe.
 	 */
 	if (atomic_dec_and_test(&pool->nr_running) &&
-	    !list_empty(&pool->worklist))
-		to_wakeup = first_idle_worker(pool);
-	return to_wakeup ? to_wakeup->task : NULL;
+	    !list_empty(&pool->worklist)) {
+		next = first_idle_worker(pool);
+		if (next)
+			wake_up_process(next->task);
+	}
+	spin_unlock_irq(&pool->lock);
 }
 
 /**
@@ -4793,7 +4787,7 @@ static void rebind_workers(struct worker_pool *pool)
 		 *
 		 * WRITE_ONCE() is necessary because @worker->flags may be
 		 * tested without holding any lock in
-		 * wq_worker_waking_up().  Without it, NOT_RUNNING test may
+		 * wq_worker_running().  Without it, NOT_RUNNING test may
 		 * fail incorrectly leading to premature concurrency
 		 * management operations.
 		 */
diff --git a/kernel/workqueue_internal.h b/kernel/workqueue_internal.h
index cb68b03ca89aa..498de0e909a43 100644
--- a/kernel/workqueue_internal.h
+++ b/kernel/workqueue_internal.h
@@ -44,6 +44,7 @@ struct worker {
 	unsigned long		last_active;	/* L: last active timestamp */
 	unsigned int		flags;		/* X: flags */
 	int			id;		/* I: worker id */
+	int			sleeping;	/* None */
 
 	/*
 	 * Opaque string set with work_set_desc().  Printed out with task
@@ -72,8 +73,8 @@ static inline struct worker *current_wq_worker(void)
  * Scheduler hooks for concurrency managed workqueue.  Only to be used from
  * sched/ and workqueue.c.
  */
-void wq_worker_waking_up(struct task_struct *task, int cpu);
-struct task_struct *wq_worker_sleeping(struct task_struct *task);
+void wq_worker_running(struct task_struct *task);
+void wq_worker_sleeping(struct task_struct *task);
 work_func_t wq_worker_last_func(struct task_struct *task);
 
 #endif /* _KERNEL_WORKQUEUE_INTERNAL_H */
-- 
2.20.1

