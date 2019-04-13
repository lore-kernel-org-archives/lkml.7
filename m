Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88941C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 17:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EE51218AF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 17:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfDMRX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 13:23:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40504 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727544AbfDMRXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 13:23:52 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 58FFFF263A;
        Sat, 13 Apr 2019 17:23:52 +0000 (UTC)
Received: from llong.com (ovpn-120-133.rdu2.redhat.com [10.10.120.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 28AF95D9C6;
        Sat, 13 Apr 2019 17:23:51 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v4 07/16] locking/rwsem: Implement lock handoff to prevent lock starvation
Date:   Sat, 13 Apr 2019 13:22:50 -0400
Message-Id: <20190413172259.2740-8-longman@redhat.com>
In-Reply-To: <20190413172259.2740-1-longman@redhat.com>
References: <20190413172259.2740-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Sat, 13 Apr 2019 17:23:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because of writer lock stealing, it is possible that a constant
stream of incoming writers will cause a waiting writer or reader to
wait indefinitely leading to lock starvation.

This patch implements a lock handoff mechanism to disable lock stealing
and force lock handoff to the first waiter or waiters (for readers)
in the queue after at least a 4ms waiting period unless it is a RT
writer task which doesn't need to wait. The waiting period is used to
avoid discouraging lock stealing too much to affect performance.

The setting and clearing of the handoff bit is serialized by the
wait_lock. So racing is not possible.

A rwsem microbenchmark was run for 5 seconds on a 2-socket 40-core
80-thread Skylake system with a v5.1 based kernel and 240 write_lock
threads with 5us sleep critical section.

Before the patch, the min/mean/max numbers of locking operations for
the locking threads were 1/7,792/173,696. After the patch, the figures
became 5,842/6,542/7,458.  It can be seen that the rwsem became much
more fair, though there was a drop of about 16% in the mean locking
operations done which was a tradeoff of having better fairness.

Making the waiter set the handoff bit right after the first wakeup can
impact performance especially with a mixed reader/writer workload. With
the same microbenchmark with short critical section and equal number of
reader and writer threads (40/40), the reader/writer locking operation
counts with the current patch were:

  40 readers, Iterations Min/Mean/Max = 1,793/1,794/1,796
  40 writers, Iterations Min/Mean/Max = 1,793/34,956/86,081

By making waiter set handoff bit immediately after wakeup:

  40 readers, Iterations Min/Mean/Max = 43/44/46
  40 writers, Iterations Min/Mean/Max = 43/1,263/3,191

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lock_events_list.h |   2 +
 kernel/locking/rwsem.c            | 205 +++++++++++++++++++++++-------
 2 files changed, 164 insertions(+), 43 deletions(-)

diff --git a/kernel/locking/lock_events_list.h b/kernel/locking/lock_events_list.h
index ad7668cfc9da..29e5c52197fa 100644
--- a/kernel/locking/lock_events_list.h
+++ b/kernel/locking/lock_events_list.h
@@ -61,7 +61,9 @@ LOCK_EVENT(rwsem_opt_fail)	/* # of failed opt-spinnings		*/
 LOCK_EVENT(rwsem_rlock)		/* # of read locks acquired		*/
 LOCK_EVENT(rwsem_rlock_fast)	/* # of fast read locks acquired	*/
 LOCK_EVENT(rwsem_rlock_fail)	/* # of failed read lock acquisitions	*/
+LOCK_EVENT(rwsem_rlock_handoff)	/* # of read lock handoffs		*/
 LOCK_EVENT(rwsem_rtrylock)	/* # of read trylock calls		*/
 LOCK_EVENT(rwsem_wlock)		/* # of write locks acquired		*/
 LOCK_EVENT(rwsem_wlock_fail)	/* # of failed write lock acquisitions	*/
+LOCK_EVENT(rwsem_wlock_handoff)	/* # of write lock handoffs		*/
 LOCK_EVENT(rwsem_wtrylock)	/* # of write trylock calls		*/
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index c1a089ab19fd..aaab546a890d 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -74,22 +74,38 @@
  *
  * Bit  0   - writer locked bit
  * Bit  1   - waiters present bit
- * Bits 2-7 - reserved
+ * Bit  2   - lock handoff bit
+ * Bits 3-7 - reserved
  * Bits 8-X - 24-bit (32-bit) or 56-bit reader count
  *
  * atomic_long_fetch_add() is used to obtain reader lock, whereas
  * atomic_long_cmpxchg() will be used to obtain writer lock.
+ *
+ * There are three places where the lock handoff bit may be set or cleared.
+ * 1) __rwsem_mark_wake() for readers.
+ * 2) rwsem_try_write_lock() for writers.
+ * 3) Error path of __rwsem_down_write_failed_common().
+ *
+ * For all the above cases, wait_lock will be held. A writer must also
+ * be the first one in the wait_list to be eligible for setting the handoff
+ * bit. So concurrent setting/clearing of handoff bit is not possible.
  */
 #define RWSEM_WRITER_LOCKED	(1UL << 0)
 #define RWSEM_FLAG_WAITERS	(1UL << 1)
+#define RWSEM_FLAG_HANDOFF	(1UL << 2)
+
 #define RWSEM_READER_SHIFT	8
 #define RWSEM_READER_BIAS	(1UL << RWSEM_READER_SHIFT)
 #define RWSEM_READER_MASK	(~(RWSEM_READER_BIAS - 1))
 #define RWSEM_WRITER_MASK	RWSEM_WRITER_LOCKED
 #define RWSEM_LOCK_MASK		(RWSEM_WRITER_MASK|RWSEM_READER_MASK)
-#define RWSEM_READ_FAILED_MASK	(RWSEM_WRITER_MASK|RWSEM_FLAG_WAITERS)
+#define RWSEM_READ_FAILED_MASK	(RWSEM_WRITER_MASK|RWSEM_FLAG_WAITERS|\
+				 RWSEM_FLAG_HANDOFF)
 
 #define RWSEM_COUNT_LOCKED(c)	((c) & RWSEM_LOCK_MASK)
+#define RWSEM_COUNT_HANDOFF(c)	((c) & RWSEM_FLAG_HANDOFF)
+#define RWSEM_COUNT_LOCKED_OR_HANDOFF(c)	\
+	((c) & (RWSEM_LOCK_MASK|RWSEM_FLAG_HANDOFF))
 
 /*
  * All writes to owner are protected by WRITE_ONCE() to make sure that
@@ -218,6 +234,7 @@ struct rwsem_waiter {
 	struct list_head list;
 	struct task_struct *task;
 	enum rwsem_waiter_type type;
+	unsigned long timeout;
 };
 
 enum rwsem_wake_type {
@@ -226,6 +243,18 @@ enum rwsem_wake_type {
 	RWSEM_WAKE_READ_OWNED	/* Waker thread holds the read lock */
 };
 
+enum writer_wait_state {
+	WRITER_NOT_FIRST,	/* Writer is not first in wait list */
+	WRITER_FIRST,		/* Writer is first in wait list     */
+	WRITER_HANDOFF		/* Writer is first & handoff needed */
+};
+
+/*
+ * The typical HZ value is either 250 or 1000. So set the minimum waiting
+ * time to 4ms in the wait queue before initiating the handoff protocol.
+ */
+#define RWSEM_WAIT_TIMEOUT	(HZ/250)
+
 /*
  * handle the lock release when processes blocked on it that can now run
  * - if we come here from up_xxxx(), then the RWSEM_FLAG_WAITERS bit must
@@ -245,6 +274,8 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 	struct rwsem_waiter *waiter, *tmp;
 	long oldcount, woken = 0, adjustment = 0;
 
+	lockdep_assert_held(&sem->wait_lock);
+
 	/*
 	 * Take a peek at the queue head waiter such that we can determine
 	 * the wakeup(s) to perform.
@@ -276,6 +307,15 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 		adjustment = RWSEM_READER_BIAS;
 		oldcount = atomic_long_fetch_add(adjustment, &sem->count);
 		if (unlikely(oldcount & RWSEM_WRITER_MASK)) {
+			/*
+			 * Initiate handoff to reader, if applicable.
+			 */
+			if (!(oldcount & RWSEM_FLAG_HANDOFF) &&
+			    time_after(jiffies, waiter->timeout)) {
+				adjustment -= RWSEM_FLAG_HANDOFF;
+				lockevent_inc(rwsem_rlock_handoff);
+			}
+
 			atomic_long_sub(adjustment, &sem->count);
 			return;
 		}
@@ -324,6 +364,12 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 		adjustment -= RWSEM_FLAG_WAITERS;
 	}
 
+	/*
+	 * Clear the handoff flag
+	 */
+	if (woken && RWSEM_COUNT_HANDOFF(atomic_long_read(&sem->count)))
+		adjustment -= RWSEM_FLAG_HANDOFF;
+
 	if (adjustment)
 		atomic_long_add(adjustment, &sem->count);
 }
@@ -332,22 +378,42 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
  * This function must be called with the sem->wait_lock held to prevent
  * race conditions between checking the rwsem wait list and setting the
  * sem->count accordingly.
+ *
+ * If wstate is WRITER_HANDOFF, it will make sure that either the handoff
+ * bit is set or the lock is acquired.
  */
-static inline bool rwsem_try_write_lock(long count, struct rw_semaphore *sem)
+static inline bool rwsem_try_write_lock(long count, struct rw_semaphore *sem,
+					enum writer_wait_state wstate)
 {
 	long new;
 
-	if (RWSEM_COUNT_LOCKED(count))
+retry:
+	if (RWSEM_COUNT_LOCKED(count)) {
+		if (RWSEM_COUNT_HANDOFF(count) || (wstate != WRITER_HANDOFF))
+			return false;
+		/*
+		 * The lock may become free just before setting handoff bit.
+		 * It will be simpler if atomic_long_or_return() is available.
+		 */
+		atomic_long_or(RWSEM_FLAG_HANDOFF, &sem->count);
+		count = atomic_long_read(&sem->count);
+		goto retry;
+	}
+
+	if ((wstate == WRITER_NOT_FIRST) && RWSEM_COUNT_HANDOFF(count))
 		return false;
 
-	new = count + RWSEM_WRITER_LOCKED -
-	     (list_is_singular(&sem->wait_list) ? RWSEM_FLAG_WAITERS : 0);
+	new = (count & ~RWSEM_FLAG_HANDOFF) + RWSEM_WRITER_LOCKED -
+	      (list_is_singular(&sem->wait_list) ? RWSEM_FLAG_WAITERS : 0);
 
 	if (atomic_long_try_cmpxchg_acquire(&sem->count, &count, new)) {
 		rwsem_set_owner(sem);
 		return true;
 	}
 
+	if (unlikely((wstate == WRITER_HANDOFF) && !RWSEM_COUNT_HANDOFF(count)))
+		goto retry;
+
 	return false;
 }
 
@@ -359,7 +425,7 @@ static inline bool rwsem_try_write_lock_unqueued(struct rw_semaphore *sem)
 {
 	long count = atomic_long_read(&sem->count);
 
-	while (!RWSEM_COUNT_LOCKED(count)) {
+	while (!RWSEM_COUNT_LOCKED_OR_HANDOFF(count)) {
 		if (atomic_long_try_cmpxchg_acquire(&sem->count, &count,
 					count + RWSEM_WRITER_LOCKED)) {
 			rwsem_set_owner(sem);
@@ -498,6 +564,16 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 }
 #endif
 
+/*
+ * This is safe to be called without holding the wait_lock.
+ */
+static inline bool
+rwsem_waiter_is_first(struct rw_semaphore *sem, struct rwsem_waiter *waiter)
+{
+	return list_first_entry(&sem->wait_list, struct rwsem_waiter, list)
+			== waiter;
+}
+
 /*
  * Wait for the read lock to be granted
  */
@@ -510,16 +586,18 @@ __rwsem_down_read_failed_common(struct rw_semaphore *sem, int state)
 
 	waiter.task = current;
 	waiter.type = RWSEM_WAITING_FOR_READ;
+	waiter.timeout = jiffies + RWSEM_WAIT_TIMEOUT;
 
 	raw_spin_lock_irq(&sem->wait_lock);
 	if (list_empty(&sem->wait_list)) {
 		/*
 		 * In case the wait queue is empty and the lock isn't owned
-		 * by a writer, this reader can exit the slowpath and return
-		 * immediately as its RWSEM_READER_BIAS has already been
-		 * set in the count.
+		 * by a writer or has the handoff bit set, this reader can
+		 * exit the slowpath and return immediately as its
+		 * RWSEM_READER_BIAS has already been set in the count.
 		 */
-		if (!(atomic_long_read(&sem->count) & RWSEM_WRITER_MASK)) {
+		if (!(atomic_long_read(&sem->count) &
+		     (RWSEM_WRITER_MASK | RWSEM_FLAG_HANDOFF))) {
 			raw_spin_unlock_irq(&sem->wait_lock);
 			rwsem_set_reader_owned(sem);
 			lockevent_inc(rwsem_rlock_fast);
@@ -567,7 +645,8 @@ __rwsem_down_read_failed_common(struct rw_semaphore *sem, int state)
 out_nolock:
 	list_del(&waiter.list);
 	if (list_empty(&sem->wait_list))
-		atomic_long_andnot(RWSEM_FLAG_WAITERS, &sem->count);
+		atomic_long_andnot(RWSEM_FLAG_WAITERS|RWSEM_FLAG_HANDOFF,
+				   &sem->count);
 	raw_spin_unlock_irq(&sem->wait_lock);
 	__set_current_state(TASK_RUNNING);
 	lockevent_inc(rwsem_rlock_fail);
@@ -593,7 +672,7 @@ static inline struct rw_semaphore *
 __rwsem_down_write_failed_common(struct rw_semaphore *sem, int state)
 {
 	long count;
-	bool waiting = true; /* any queued threads before us */
+	enum writer_wait_state wstate;
 	struct rwsem_waiter waiter;
 	struct rw_semaphore *ret = sem;
 	DEFINE_WAKE_Q(wake_q);
@@ -608,56 +687,63 @@ __rwsem_down_write_failed_common(struct rw_semaphore *sem, int state)
 	 */
 	waiter.task = current;
 	waiter.type = RWSEM_WAITING_FOR_WRITE;
+	waiter.timeout = jiffies + RWSEM_WAIT_TIMEOUT;
 
 	raw_spin_lock_irq(&sem->wait_lock);
 
 	/* account for this before adding a new element to the list */
-	if (list_empty(&sem->wait_list))
-		waiting = false;
+	wstate = list_empty(&sem->wait_list) ? WRITER_FIRST : WRITER_NOT_FIRST;
 
 	list_add_tail(&waiter.list, &sem->wait_list);
 
 	/* we're now waiting on the lock */
-	if (waiting) {
+	if (wstate == WRITER_NOT_FIRST) {
 		count = atomic_long_read(&sem->count);
 
 		/*
-		 * If there were already threads queued before us and there are
-		 * no active writers and some readers, the lock must be read
-		 * owned; so we try to  any read locks that were queued ahead
-		 * of us.
+		 * If there were already threads queued before us and:
+		 *  1) there are no no active locks, wake the front
+		 *     queued process(es) as the handoff bit might be set.
+		 *  2) there are no active writers and some readers, the lock
+		 *     must be read owned; so we try to wake any read lock
+		 *     waiters that were queued ahead of us.
 		 */
-		if (!(count & RWSEM_WRITER_MASK) &&
-		     (count & RWSEM_READER_MASK)) {
+		if (!RWSEM_COUNT_LOCKED(count))
+			__rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
+		else if (!(count & RWSEM_WRITER_MASK) &&
+			  (count & RWSEM_READER_MASK))
 			__rwsem_mark_wake(sem, RWSEM_WAKE_READERS, &wake_q);
-			/*
-			 * The wakeup is normally called _after_ the wait_lock
-			 * is released, but given that we are proactively waking
-			 * readers we can deal with the wake_q overhead as it is
-			 * similar to releasing and taking the wait_lock again
-			 * for attempting rwsem_try_write_lock().
-			 */
-			wake_up_q(&wake_q);
+		else
+			goto wait;
 
-			/*
-			 * Reinitialize wake_q after use.
-			 */
-			wake_q_init(&wake_q);
-		}
+		/*
+		 * The wakeup is normally called _after_ the wait_lock
+		 * is released, but given that we are proactively waking
+		 * readers we can deal with the wake_q overhead as it is
+		 * similar to releasing and taking the wait_lock again
+		 * for attempting rwsem_try_write_lock().
+		 */
+		wake_up_q(&wake_q);
 
+		/*
+		 * Reinitialize wake_q after use.
+		 */
+		wake_q_init(&wake_q);
 	} else {
 		count = atomic_long_add_return(RWSEM_FLAG_WAITERS, &sem->count);
 	}
 
+wait:
 	/* wait until we successfully acquire the lock */
 	set_current_state(state);
 	while (true) {
-		if (rwsem_try_write_lock(count, sem))
+		if (rwsem_try_write_lock(count, sem, wstate))
 			break;
+
 		raw_spin_unlock_irq(&sem->wait_lock);
 
 		/* Block until there are no active lockers. */
-		do {
+		for (;;) {
 			if (signal_pending_state(state, current))
 				goto out_nolock;
 
@@ -665,9 +751,34 @@ __rwsem_down_write_failed_common(struct rw_semaphore *sem, int state)
 			lockevent_inc(rwsem_sleep_writer);
 			set_current_state(state);
 			count = atomic_long_read(&sem->count);
-		} while (RWSEM_COUNT_LOCKED(count));
+
+			if ((wstate == WRITER_NOT_FIRST) &&
+			    rwsem_waiter_is_first(sem, &waiter))
+				wstate = WRITER_FIRST;
+
+			if (!RWSEM_COUNT_LOCKED(count))
+				break;
+
+			/*
+			 * An RT task sets the HANDOFF bit immediately.
+			 * Non-RT task will wait a while before doing so.
+			 *
+			 * The setting of the handoff bit is deferred
+			 * until rwsem_try_write_lock() is called.
+			 */
+			if ((wstate == WRITER_FIRST) && (rt_task(current) ||
+			    time_after(jiffies, waiter.timeout))) {
+				wstate = WRITER_HANDOFF;
+				lockevent_inc(rwsem_wlock_handoff);
+				/*
+				 * Break out to call rwsem_try_write_lock().
+				 */
+				break;
+			}
+		}
 
 		raw_spin_lock_irq(&sem->wait_lock);
+		count = atomic_long_read(&sem->count);
 	}
 	__set_current_state(TASK_RUNNING);
 	list_del(&waiter.list);
@@ -680,6 +791,12 @@ __rwsem_down_write_failed_common(struct rw_semaphore *sem, int state)
 	__set_current_state(TASK_RUNNING);
 	raw_spin_lock_irq(&sem->wait_lock);
 	list_del(&waiter.list);
+	/*
+	 * If handoff bit has been set by this waiter, make sure that the
+	 * clearing of it is seen by others before proceeding.
+	 */
+	if (unlikely(wstate == WRITER_HANDOFF))
+		atomic_long_add_return(-RWSEM_FLAG_HANDOFF,  &sem->count);
 	if (list_empty(&sem->wait_list))
 		atomic_long_andnot(RWSEM_FLAG_WAITERS, &sem->count);
 	else
@@ -707,7 +824,7 @@ rwsem_down_write_failed_killable(struct rw_semaphore *sem)
  * handle waking up a waiter on the semaphore
  * - up_read/up_write has decremented the active part of count if we come here
  */
-static struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem)
+static struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem, long count)
 {
 	unsigned long flags;
 	DEFINE_WAKE_Q(wake_q);
@@ -839,7 +956,7 @@ inline void __up_read(struct rw_semaphore *sem)
 	tmp = atomic_long_add_return_release(-RWSEM_READER_BIAS, &sem->count);
 	if (unlikely((tmp & (RWSEM_LOCK_MASK|RWSEM_FLAG_WAITERS))
 			== RWSEM_FLAG_WAITERS))
-		rwsem_wake(sem);
+		rwsem_wake(sem, tmp);
 }
 
 /*
@@ -847,11 +964,13 @@ inline void __up_read(struct rw_semaphore *sem)
  */
 static inline void __up_write(struct rw_semaphore *sem)
 {
+	long tmp;
+
 	DEBUG_RWSEMS_WARN_ON(sem->owner != current, sem);
 	rwsem_clear_owner(sem);
-	if (unlikely(atomic_long_fetch_add_release(-RWSEM_WRITER_LOCKED,
-			&sem->count) & RWSEM_FLAG_WAITERS))
-		rwsem_wake(sem);
+	tmp = atomic_long_fetch_add_release(-RWSEM_WRITER_LOCKED, &sem->count);
+	if (unlikely(tmp & RWSEM_FLAG_WAITERS))
+		rwsem_wake(sem, tmp);
 }
 
 /*
-- 
2.18.1

