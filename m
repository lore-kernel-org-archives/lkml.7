Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D09C43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 15:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF9A206A3
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 15:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbfD1P6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 11:58:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50594 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726984AbfD1P6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 11:58:46 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BCDB5308FF0E;
        Sun, 28 Apr 2019 15:58:45 +0000 (UTC)
Received: from llong.com (ovpn-120-22.rdu2.redhat.com [10.10.120.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D440C63BAB;
        Sun, 28 Apr 2019 15:58:39 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH-tip v6 08/20] locking/rwsem: Implement lock handoff to prevent lock starvation
Date:   Sun, 28 Apr 2019 11:57:43 -0400
Message-Id: <20190428155755.14267-9-longman@redhat.com>
In-Reply-To: <20190428155755.14267-1-longman@redhat.com>
References: <20190428155755.14267-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Sun, 28 Apr 2019 15:58:45 +0000 (UTC)
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
 kernel/locking/rwsem.c            | 221 ++++++++++++++++++++++--------
 2 files changed, 169 insertions(+), 54 deletions(-)

diff --git a/kernel/locking/lock_events_list.h b/kernel/locking/lock_events_list.h
index 11187a1d40b8..634b47fd8b5e 100644
--- a/kernel/locking/lock_events_list.h
+++ b/kernel/locking/lock_events_list.h
@@ -61,5 +61,7 @@ LOCK_EVENT(rwsem_opt_fail)	/* # of failed opt-spinnings		*/
 LOCK_EVENT(rwsem_rlock)		/* # of read locks acquired		*/
 LOCK_EVENT(rwsem_rlock_fast)	/* # of fast read locks acquired	*/
 LOCK_EVENT(rwsem_rlock_fail)	/* # of failed read lock acquisitions	*/
+LOCK_EVENT(rwsem_rlock_handoff)	/* # of read lock handoffs		*/
 LOCK_EVENT(rwsem_wlock)		/* # of write locks acquired		*/
 LOCK_EVENT(rwsem_wlock_fail)	/* # of failed write lock acquisitions	*/
+LOCK_EVENT(rwsem_wlock_handoff)	/* # of write lock handoffs		*/
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 979770be9529..36e69b773d36 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -10,8 +10,9 @@
  * Optimistic spinning by Tim Chen <tim.c.chen@intel.com>
  * and Davidlohr Bueso <davidlohr@hp.com>. Based on mutexes.
  *
- * Rwsem count bit fields re-definition and rwsem rearchitecture
- * by Waiman Long <longman@redhat.com>.
+ * Rwsem count bit fields re-definition and rwsem rearchitecture by
+ * Waiman Long <longman@redhat.com> and
+ * Peter Zijlstra <peterz@infradead.org>.
  */
 
 #include <linux/types.h>
@@ -74,20 +75,33 @@
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
 
 /*
  * All writes to owner are protected by WRITE_ONCE() to make sure that
@@ -216,7 +230,10 @@ struct rwsem_waiter {
 	struct list_head list;
 	struct task_struct *task;
 	enum rwsem_waiter_type type;
+	unsigned long timeout;
 };
+#define rwsem_first_waiter(sem) \
+	list_first_entry(&sem->wait_list, struct rwsem_waiter, list)
 
 enum rwsem_wake_type {
 	RWSEM_WAKE_ANY,		/* Wake whatever's at head of wait list */
@@ -224,6 +241,19 @@ enum rwsem_wake_type {
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
+ * time to at least 4ms or 1 jiffy (if it is higher than 4ms) in the wait
+ * queue before initiating the handoff protocol.
+ */
+#define RWSEM_WAIT_TIMEOUT	DIV_ROUND_UP(HZ, 250)
+
 /*
  * handle the lock release when processes blocked on it that can now run
  * - if we come here from up_xxxx(), then the RWSEM_FLAG_WAITERS bit must
@@ -244,11 +274,13 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 	long oldcount, woken = 0, adjustment = 0;
 	struct list_head wlist;
 
+	lockdep_assert_held(&sem->wait_lock);
+
 	/*
 	 * Take a peek at the queue head waiter such that we can determine
 	 * the wakeup(s) to perform.
 	 */
-	waiter = list_first_entry(&sem->wait_list, struct rwsem_waiter, list);
+	waiter = rwsem_first_waiter(sem);
 
 	if (waiter->type == RWSEM_WAITING_FOR_WRITE) {
 		if (wake_type == RWSEM_WAKE_ANY) {
@@ -275,7 +307,18 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 		adjustment = RWSEM_READER_BIAS;
 		oldcount = atomic_long_fetch_add(adjustment, &sem->count);
 		if (unlikely(oldcount & RWSEM_WRITER_MASK)) {
-			atomic_long_sub(adjustment, &sem->count);
+			/*
+			 * When we've been waiting "too" long (for writers
+			 * to give up the lock), request a * HANDOFF to
+			 * force the issue.
+			 */
+			if (!(oldcount & RWSEM_FLAG_HANDOFF) &&
+			    time_after(jiffies, waiter->timeout)) {
+				adjustment -= RWSEM_FLAG_HANDOFF;
+				lockevent_inc(rwsem_rlock_handoff);
+			}
+
+			atomic_long_add(-adjustment, &sem->count);
 			return;
 		}
 		/*
@@ -318,6 +361,13 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 		adjustment -= RWSEM_FLAG_WAITERS;
 	}
 
+	/*
+	 * When we've woken a reader, we no longer need to force writers
+	 * to give up the lock and we can clear HANDOFF.
+	 */
+	if (woken && (atomic_long_read(&sem->count) & RWSEM_FLAG_HANDOFF))
+		adjustment -= RWSEM_FLAG_HANDOFF;
+
 	if (adjustment)
 		atomic_long_add(adjustment, &sem->count);
 
@@ -347,23 +397,44 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
  * This function must be called with the sem->wait_lock held to prevent
  * race conditions between checking the rwsem wait list and setting the
  * sem->count accordingly.
+ *
+ * If wstate is WRITER_HANDOFF, it will make sure that either the handoff
+ * bit is set or the lock is acquired with handoff bit cleared.
  */
-static inline bool rwsem_try_write_lock(long count, struct rw_semaphore *sem)
+static inline bool rwsem_try_write_lock(long count, struct rw_semaphore *sem,
+					enum writer_wait_state wstate)
 {
 	long new;
 
-	if (count & RWSEM_LOCK_MASK)
-		return false;
+	lockdep_assert_held(&sem->wait_lock);
+	do {
+		bool has_handoff = !!(count & RWSEM_FLAG_HANDOFF);
 
-	new = count + RWSEM_WRITER_LOCKED -
-	     (list_is_singular(&sem->wait_list) ? RWSEM_FLAG_WAITERS : 0);
+		if (has_handoff && wstate == WRITER_NOT_FIRST)
+			return false;
 
-	if (atomic_long_try_cmpxchg_acquire(&sem->count, &count, new)) {
-		rwsem_set_owner(sem);
-		return true;
-	}
+		if (count & RWSEM_LOCK_MASK) {
+			if (has_handoff || (wstate != WRITER_HANDOFF))
+				return false;
+			new = count | RWSEM_FLAG_HANDOFF;
+		} else {
+			new = (count | RWSEM_WRITER_LOCKED) &
+				~RWSEM_FLAG_HANDOFF;
 
-	return false;
+			if (list_is_singular(&sem->wait_list))
+				new &= ~RWSEM_FLAG_WAITERS;
+		}
+	} while (!atomic_long_try_cmpxchg_acquire(&sem->count, &count, new));
+
+	/*
+	 * We have either acquired the lock with handoff bit cleared or
+	 * set the handoff bit.
+	 */
+	if (new & RWSEM_FLAG_HANDOFF)
+		return false;
+
+	rwsem_set_owner(sem);
+	return true;
 }
 
 #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
@@ -374,9 +445,9 @@ static inline bool rwsem_try_write_lock_unqueued(struct rw_semaphore *sem)
 {
 	long count = atomic_long_read(&sem->count);
 
-	while (!(count & RWSEM_LOCK_MASK)) {
+	while (!(count & (RWSEM_LOCK_MASK|RWSEM_FLAG_HANDOFF))) {
 		if (atomic_long_try_cmpxchg_acquire(&sem->count, &count,
-					count + RWSEM_WRITER_LOCKED)) {
+					count | RWSEM_WRITER_LOCKED)) {
 			rwsem_set_owner(sem);
 			lockevent_inc(rwsem_opt_wlock);
 			return true;
@@ -457,6 +528,11 @@ static noinline enum owner_state rwsem_spin_on_owner(struct rw_semaphore *sem)
 
 	rcu_read_lock();
 	for (;;) {
+		if (atomic_long_read(&sem->count) & RWSEM_FLAG_HANDOFF) {
+			state = OWNER_NONSPINNABLE;
+			break;
+		}
+
 		tmp = READ_ONCE(sem->owner);
 		if (tmp != owner) {
 			state = rwsem_owner_state((unsigned long)tmp);
@@ -554,16 +630,18 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state)
 
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
@@ -610,8 +688,10 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state)
 	return sem;
 out_nolock:
 	list_del(&waiter.list);
-	if (list_empty(&sem->wait_list))
-		atomic_long_andnot(RWSEM_FLAG_WAITERS, &sem->count);
+	if (list_empty(&sem->wait_list)) {
+		atomic_long_andnot(RWSEM_FLAG_WAITERS|RWSEM_FLAG_HANDOFF,
+				   &sem->count);
+	}
 	raw_spin_unlock_irq(&sem->wait_lock);
 	__set_current_state(TASK_RUNNING);
 	lockevent_inc(rwsem_rlock_fail);
@@ -625,7 +705,7 @@ static struct rw_semaphore *
 rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 {
 	long count;
-	bool waiting = true; /* any queued threads before us */
+	enum writer_wait_state wstate;
 	struct rwsem_waiter waiter;
 	struct rw_semaphore *ret = sem;
 	DEFINE_WAKE_Q(wake_q);
@@ -640,66 +720,95 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
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
-			__rwsem_mark_wake(sem, RWSEM_WAKE_READERS, &wake_q);
-			/*
-			 * The wakeup is normally called _after_ the wait_lock
-			 * is released, but given that we are proactively waking
-			 * readers we can deal with the wake_q overhead as it is
-			 * similar to releasing and taking the wait_lock again
-			 * for attempting rwsem_try_write_lock().
-			 */
-			wake_up_q(&wake_q);
+		if (count & RWSEM_WRITER_MASK)
+			goto wait;
 
-			/*
-			 * Reinitialize wake_q after use.
-			 */
-			wake_q_init(&wake_q);
-		}
+		__rwsem_mark_wake(sem, (count & RWSEM_READER_MASK)
+					? RWSEM_WAKE_READERS
+					: RWSEM_WAKE_ANY, &wake_q);
 
+		/*
+		 * The wakeup is normally called _after_ the wait_lock
+		 * is released, but given that we are proactively waking
+		 * readers we can deal with the wake_q overhead as it is
+		 * similar to releasing and taking the wait_lock again
+		 * for attempting rwsem_try_write_lock().
+		 */
+		wake_up_q(&wake_q);
+
+		/* We need wake_q again below, reinitialize */
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
 
 			schedule();
 			lockevent_inc(rwsem_sleep_writer);
 			set_current_state(state);
+			/*
+			 * If HANDOFF bit is set, unconditionally do
+			 * a trylock.
+			 */
+			if (wstate == WRITER_HANDOFF)
+				break;
+
+			if ((wstate == WRITER_NOT_FIRST) &&
+			    (rwsem_first_waiter(sem) == &waiter))
+				wstate = WRITER_FIRST;
+
 			count = atomic_long_read(&sem->count);
-		} while (count & RWSEM_LOCK_MASK);
+			if (!(count & RWSEM_LOCK_MASK))
+				break;
+
+			/*
+			 * The setting of the handoff bit is deferred
+			 * until rwsem_try_write_lock() is called.
+			 */
+			if ((wstate == WRITER_FIRST) && (rt_task(current) ||
+			    time_after(jiffies, waiter.timeout))) {
+				wstate = WRITER_HANDOFF;
+				lockevent_inc(rwsem_wlock_handoff);
+				break;
+			}
+		}
 
 		raw_spin_lock_irq(&sem->wait_lock);
+		count = atomic_long_read(&sem->count);
 	}
 	__set_current_state(TASK_RUNNING);
 	list_del(&waiter.list);
@@ -712,6 +821,10 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 	__set_current_state(TASK_RUNNING);
 	raw_spin_lock_irq(&sem->wait_lock);
 	list_del(&waiter.list);
+
+	if (unlikely(wstate == WRITER_HANDOFF))
+		atomic_long_add(-RWSEM_FLAG_HANDOFF,  &sem->count);
+
 	if (list_empty(&sem->wait_list))
 		atomic_long_andnot(RWSEM_FLAG_WAITERS, &sem->count);
 	else
@@ -727,7 +840,7 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
  * handle waking up a waiter on the semaphore
  * - up_read/up_write has decremented the active part of count if we come here
  */
-static struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem)
+static struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem, long count)
 {
 	unsigned long flags;
 	DEFINE_WAKE_Q(wake_q);
@@ -860,7 +973,7 @@ inline void __up_read(struct rw_semaphore *sem)
 	tmp = atomic_long_add_return_release(-RWSEM_READER_BIAS, &sem->count);
 	if (unlikely((tmp & (RWSEM_LOCK_MASK|RWSEM_FLAG_WAITERS)) ==
 		      RWSEM_FLAG_WAITERS))
-		rwsem_wake(sem);
+		rwsem_wake(sem, tmp);
 }
 
 /*
@@ -874,7 +987,7 @@ static inline void __up_write(struct rw_semaphore *sem)
 	rwsem_clear_owner(sem);
 	tmp = atomic_long_fetch_add_release(-RWSEM_WRITER_LOCKED, &sem->count);
 	if (unlikely(tmp & RWSEM_FLAG_WAITERS))
-		rwsem_wake(sem);
+		rwsem_wake(sem, tmp);
 }
 
 /*
-- 
2.18.1

