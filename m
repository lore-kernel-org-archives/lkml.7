Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88031C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CD382087C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfCMQz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 12:55:58 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48136 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfCMQz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 12:55:56 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1h47AW-00020b-8W; Wed, 13 Mar 2019 17:55:52 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/2] workqueue: Use normal rcu
Date:   Wed, 13 Mar 2019 17:55:47 +0100
Message-Id: <20190313165548.19713-2-bigeasy@linutronix.de>
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

There is no need for sched_rcu. The undocumented reason why sched_rcu
is used is to avoid a few explicit rcu_read_lock()/unlock() pairs by
the fact that sched_rcu reader side critical sections are also protected
by preempt or irq disabled regions.

Replace rcu_read_lock_sched with rcu_read_lock and acquire the RCU lock
where it is not yet explicit acquired. Replace local_irq_disable() with
rcu_read_lock(). Update asserts.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[bigeasy: mangle changelog a little]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/workqueue.c | 93 +++++++++++++++++++++++++---------------------
 1 file changed, 51 insertions(+), 42 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index fc5d23d752a57..9d22030ae7f44 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -127,16 +127,16 @@ enum {
  *
  * PL: wq_pool_mutex protected.
  *
- * PR: wq_pool_mutex protected for writes.  Sched-RCU protected for reads.
+ * PR: wq_pool_mutex protected for writes.  RCU protected for reads.
  *
  * PW: wq_pool_mutex and wq->mutex protected for writes.  Either for reads.
  *
  * PWR: wq_pool_mutex and wq->mutex protected for writes.  Either or
- *      sched-RCU for reads.
+ *      RCU for reads.
  *
  * WQ: wq->mutex protected.
  *
- * WR: wq->mutex protected for writes.  Sched-RCU protected for reads.
+ * WR: wq->mutex protected for writes.  RCU protected for reads.
  *
  * MD: wq_mayday_lock protected.
  */
@@ -183,7 +183,7 @@ struct worker_pool {
 	atomic_t		nr_running ____cacheline_aligned_in_smp;
 
 	/*
-	 * Destruction of pool is sched-RCU protected to allow dereferences
+	 * Destruction of pool is RCU protected to allow dereferences
 	 * from get_work_pool().
 	 */
 	struct rcu_head		rcu;
@@ -212,7 +212,7 @@ struct pool_workqueue {
 	/*
 	 * Release of unbound pwq is punted to system_wq.  See put_pwq()
 	 * and pwq_unbound_release_workfn() for details.  pool_workqueue
-	 * itself is also sched-RCU protected so that the first pwq can be
+	 * itself is also RCU protected so that the first pwq can be
 	 * determined without grabbing wq->mutex.
 	 */
 	struct work_struct	unbound_release_work;
@@ -264,8 +264,8 @@ struct workqueue_struct {
 	char			name[WQ_NAME_LEN]; /* I: workqueue name */
 
 	/*
-	 * Destruction of workqueue_struct is sched-RCU protected to allow
-	 * walking the workqueues list without grabbing wq_pool_mutex.
+	 * Destruction of workqueue_struct is RCU protected to allow walking
+	 * the workqueues list without grabbing wq_pool_mutex.
 	 * This is used to dump all workqueues from sysrq.
 	 */
 	struct rcu_head		rcu;
@@ -357,20 +357,20 @@ static void workqueue_sysfs_unregister(struct workqueue_struct *wq);
 #include <trace/events/workqueue.h>
 
 #define assert_rcu_or_pool_mutex()					\
-	RCU_LOCKDEP_WARN(!rcu_read_lock_sched_held() &&			\
+	RCU_LOCKDEP_WARN(!rcu_read_lock_held() &&			\
 			 !lockdep_is_held(&wq_pool_mutex),		\
-			 "sched RCU or wq_pool_mutex should be held")
+			 "RCU or wq_pool_mutex should be held")
 
 #define assert_rcu_or_wq_mutex(wq)					\
-	RCU_LOCKDEP_WARN(!rcu_read_lock_sched_held() &&			\
+	RCU_LOCKDEP_WARN(!rcu_read_lock_held() &&			\
 			 !lockdep_is_held(&wq->mutex),			\
-			 "sched RCU or wq->mutex should be held")
+			 "RCU or wq->mutex should be held")
 
 #define assert_rcu_or_wq_mutex_or_pool_mutex(wq)			\
-	RCU_LOCKDEP_WARN(!rcu_read_lock_sched_held() &&			\
+	RCU_LOCKDEP_WARN(!rcu_read_lock_held() &&			\
 			 !lockdep_is_held(&wq->mutex) &&		\
 			 !lockdep_is_held(&wq_pool_mutex),		\
-			 "sched RCU, wq->mutex or wq_pool_mutex should be held")
+			 "RCU, wq->mutex or wq_pool_mutex should be held")
 
 #define for_each_cpu_worker_pool(pool, cpu)				\
 	for ((pool) = &per_cpu(cpu_worker_pools, cpu)[0];		\
@@ -382,7 +382,7 @@ static void workqueue_sysfs_unregister(struct workqueue_struct *wq);
  * @pool: iteration cursor
  * @pi: integer used for iteration
  *
- * This must be called either with wq_pool_mutex held or sched RCU read
+ * This must be called either with wq_pool_mutex held or RCU read
  * locked.  If the pool needs to be used beyond the locking in effect, the
  * caller is responsible for guaranteeing that the pool stays online.
  *
@@ -414,7 +414,7 @@ static void workqueue_sysfs_unregister(struct workqueue_struct *wq);
  * @pwq: iteration cursor
  * @wq: the target workqueue
  *
- * This must be called either with wq->mutex held or sched RCU read locked.
+ * This must be called either with wq->mutex held or RCU read locked.
  * If the pwq needs to be used beyond the locking in effect, the caller is
  * responsible for guaranteeing that the pwq stays online.
  *
@@ -550,7 +550,7 @@ static int worker_pool_assign_id(struct worker_pool *pool)
  * @wq: the target workqueue
  * @node: the node ID
  *
- * This must be called with any of wq_pool_mutex, wq->mutex or sched RCU
+ * This must be called with any of wq_pool_mutex, wq->mutex or RCU
  * read locked.
  * If the pwq needs to be used beyond the locking in effect, the caller is
  * responsible for guaranteeing that the pwq stays online.
@@ -694,8 +694,8 @@ static struct pool_workqueue *get_work_pwq(struct work_struct *work)
  * @work: the work item of interest
  *
  * Pools are created and destroyed under wq_pool_mutex, and allows read
- * access under sched-RCU read lock.  As such, this function should be
- * called under wq_pool_mutex or with preemption disabled.
+ * access under RCU read lock.  As such, this function should be
+ * called under wq_pool_mutex or inside of a rcu_read_lock() region.
  *
  * All fields of the returned pool are accessible as long as the above
  * mentioned locking is in effect.  If the returned pool needs to be used
@@ -1120,7 +1120,7 @@ static void put_pwq_unlocked(struct pool_workqueue *pwq)
 {
 	if (pwq) {
 		/*
-		 * As both pwqs and pools are sched-RCU protected, the
+		 * As both pwqs and pools are RCU protected, the
 		 * following lock operations are safe.
 		 */
 		spin_lock_irq(&pwq->pool->lock);
@@ -1248,6 +1248,7 @@ static int try_to_grab_pending(struct work_struct *work, bool is_dwork,
 	if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work)))
 		return 0;
 
+	rcu_read_lock();
 	/*
 	 * The queueing is in progress, or it is already queued. Try to
 	 * steal it from ->worklist without clearing WORK_STRUCT_PENDING.
@@ -1286,10 +1287,12 @@ static int try_to_grab_pending(struct work_struct *work, bool is_dwork,
 		set_work_pool_and_keep_pending(work, pool->id);
 
 		spin_unlock(&pool->lock);
+		rcu_read_unlock();
 		return 1;
 	}
 	spin_unlock(&pool->lock);
 fail:
+	rcu_read_unlock();
 	local_irq_restore(*flags);
 	if (work_is_canceling(work))
 		return -ENOENT;
@@ -1403,6 +1406,7 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 	if (unlikely(wq->flags & __WQ_DRAINING) &&
 	    WARN_ON_ONCE(!is_chained_work(wq)))
 		return;
+	rcu_read_lock();
 retry:
 	if (req_cpu == WORK_CPU_UNBOUND)
 		cpu = wq_select_unbound_cpu(raw_smp_processor_id());
@@ -1459,10 +1463,8 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 	/* pwq determined, queue */
 	trace_workqueue_queue_work(req_cpu, pwq, work);
 
-	if (WARN_ON(!list_empty(&work->entry))) {
-		spin_unlock(&pwq->pool->lock);
-		return;
-	}
+	if (WARN_ON(!list_empty(&work->entry)))
+		goto out;
 
 	pwq->nr_in_flight[pwq->work_color]++;
 	work_flags = work_color_to_flags(pwq->work_color);
@@ -1480,7 +1482,9 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 
 	insert_work(pwq, work, worklist, work_flags);
 
+out:
 	spin_unlock(&pwq->pool->lock);
+	rcu_read_unlock();
 }
 
 /**
@@ -2878,14 +2882,14 @@ static bool start_flush_work(struct work_struct *work, struct wq_barrier *barr,
 
 	might_sleep();
 
-	local_irq_disable();
+	rcu_read_lock();
 	pool = get_work_pool(work);
 	if (!pool) {
-		local_irq_enable();
+		rcu_read_unlock();
 		return false;
 	}
 
-	spin_lock(&pool->lock);
+	spin_lock_irq(&pool->lock);
 	/* see the comment in try_to_grab_pending() with the same code */
 	pwq = get_work_pwq(work);
 	if (pwq) {
@@ -2917,10 +2921,11 @@ static bool start_flush_work(struct work_struct *work, struct wq_barrier *barr,
 		lock_map_acquire(&pwq->wq->lockdep_map);
 		lock_map_release(&pwq->wq->lockdep_map);
 	}
-
+	rcu_read_unlock();
 	return true;
 already_gone:
 	spin_unlock_irq(&pool->lock);
+	rcu_read_unlock();
 	return false;
 }
 
@@ -3364,7 +3369,7 @@ static void rcu_free_pool(struct rcu_head *rcu)
  * put_unbound_pool - put a worker_pool
  * @pool: worker_pool to put
  *
- * Put @pool.  If its refcnt reaches zero, it gets destroyed in sched-RCU
+ * Put @pool.  If its refcnt reaches zero, it gets destroyed in RCU
  * safe manner.  get_unbound_pool() calls this function on its failure path
  * and this function should be able to release pools which went through,
  * successfully or not, init_worker_pool().
@@ -3418,7 +3423,7 @@ static void put_unbound_pool(struct worker_pool *pool)
 	del_timer_sync(&pool->idle_timer);
 	del_timer_sync(&pool->mayday_timer);
 
-	/* sched-RCU protected to allow dereferences from get_work_pool() */
+	/* RCU protected to allow dereferences from get_work_pool() */
 	call_rcu(&pool->rcu, rcu_free_pool);
 }
 
@@ -4328,7 +4333,8 @@ bool workqueue_congested(int cpu, struct workqueue_struct *wq)
 	struct pool_workqueue *pwq;
 	bool ret;
 
-	rcu_read_lock_sched();
+	rcu_read_lock();
+	preempt_disable();
 
 	if (cpu == WORK_CPU_UNBOUND)
 		cpu = smp_processor_id();
@@ -4339,7 +4345,8 @@ bool workqueue_congested(int cpu, struct workqueue_struct *wq)
 		pwq = unbound_pwq_by_node(wq, cpu_to_node(cpu));
 
 	ret = !list_empty(&pwq->delayed_works);
-	rcu_read_unlock_sched();
+	preempt_enable();
+	rcu_read_unlock();
 
 	return ret;
 }
@@ -4365,15 +4372,15 @@ unsigned int work_busy(struct work_struct *work)
 	if (work_pending(work))
 		ret |= WORK_BUSY_PENDING;
 
-	local_irq_save(flags);
+	rcu_read_lock();
 	pool = get_work_pool(work);
 	if (pool) {
-		spin_lock(&pool->lock);
+		spin_lock_irqsave(&pool->lock, flags);
 		if (find_worker_executing_work(pool, work))
 			ret |= WORK_BUSY_RUNNING;
-		spin_unlock(&pool->lock);
+		spin_unlock_irqrestore(&pool->lock, flags);
 	}
-	local_irq_restore(flags);
+	rcu_read_unlock();
 
 	return ret;
 }
@@ -4557,7 +4564,7 @@ void show_workqueue_state(void)
 	unsigned long flags;
 	int pi;
 
-	rcu_read_lock_sched();
+	rcu_read_lock();
 
 	pr_info("Showing busy workqueues and worker pools:\n");
 
@@ -4622,7 +4629,7 @@ void show_workqueue_state(void)
 		touch_nmi_watchdog();
 	}
 
-	rcu_read_unlock_sched();
+	rcu_read_unlock();
 }
 
 /* used to show worker information through /proc/PID/{comm,stat,status} */
@@ -5009,16 +5016,16 @@ bool freeze_workqueues_busy(void)
 		 * nr_active is monotonically decreasing.  It's safe
 		 * to peek without lock.
 		 */
-		rcu_read_lock_sched();
+		rcu_read_lock();
 		for_each_pwq(pwq, wq) {
 			WARN_ON_ONCE(pwq->nr_active < 0);
 			if (pwq->nr_active) {
 				busy = true;
-				rcu_read_unlock_sched();
+				rcu_read_unlock();
 				goto out_unlock;
 			}
 		}
-		rcu_read_unlock_sched();
+		rcu_read_unlock();
 	}
 out_unlock:
 	mutex_unlock(&wq_pool_mutex);
@@ -5213,7 +5220,8 @@ static ssize_t wq_pool_ids_show(struct device *dev,
 	const char *delim = "";
 	int node, written = 0;
 
-	rcu_read_lock_sched();
+	get_online_cpus();
+	rcu_read_lock();
 	for_each_node(node) {
 		written += scnprintf(buf + written, PAGE_SIZE - written,
 				     "%s%d:%d", delim, node,
@@ -5221,7 +5229,8 @@ static ssize_t wq_pool_ids_show(struct device *dev,
 		delim = " ";
 	}
 	written += scnprintf(buf + written, PAGE_SIZE - written, "\n");
-	rcu_read_unlock_sched();
+	rcu_read_unlock();
+	put_online_cpus();
 
 	return written;
 }
-- 
2.20.1

