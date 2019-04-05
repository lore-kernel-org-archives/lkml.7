Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC04EC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 19:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8701821738
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 19:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731995AbfDETWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 15:22:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33780 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731812AbfDETWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 15:22:01 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AE9C7307D851;
        Fri,  5 Apr 2019 19:22:00 +0000 (UTC)
Received: from llong.com (dhcp-17-47.bos.redhat.com [10.18.17.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 990A4620A3;
        Fri,  5 Apr 2019 19:21:59 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH-tip v2 02/12] locking/rwsem: Implement lock handoff to prevent lock starvation
Date:   Fri,  5 Apr 2019 15:21:05 -0400
Message-Id: <20190405192115.17416-3-longman@redhat.com>
In-Reply-To: <20190405192115.17416-1-longman@redhat.com>
References: <20190405192115.17416-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 05 Apr 2019 19:22:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because of writer lock stealing, it is possible that a constant
stream of incoming writers will cause a waiting writer or reader to
wait indefinitely leading to lock starvation.

The mutex code has a lock handoff mechanism to prevent lock starvation.
This patch implements a similar lock handoff mechanism to disable
lock stealing and force lock handoff to the first waiter in the queue
after at least a 5ms waiting period. The waiting period is used to
avoid discouraging lock stealing too much to affect performance.

A rwsem microbenchmark was run for 5 seconds on a 8-socket 120-core
240-thread IvyBridge-EX system with a v5.1 based kernel and 240
write_lock threads with 5us sleep critical section.

Before the patch, the min/mean/max numbers of locking operations for the
locking threads were 1/2,433/320,955. After the patch, the figures became
891/1,807/3,174. It can be seen that the rwsem became much more fair,
though there was a drop of about 26% in the mean locking operations
done which was a tradeoff of having better fairness.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lock_events_list.h |   2 +
 kernel/locking/rwsem-xadd.c       | 154 ++++++++++++++++++++++--------
 kernel/locking/rwsem.h            |  23 +++--
 3 files changed, 134 insertions(+), 45 deletions(-)

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
diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index adab6477be51..58b3a64e6f2c 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -73,6 +73,7 @@ struct rwsem_waiter {
 	struct list_head list;
 	struct task_struct *task;
 	enum rwsem_waiter_type type;
+	unsigned long timeout;
 };
 
 enum rwsem_wake_type {
@@ -81,6 +82,12 @@ enum rwsem_wake_type {
 	RWSEM_WAKE_READ_OWNED	/* Waker thread holds the read lock */
 };
 
+/*
+ * The minimum waiting time (5ms) in the wait queue before initiating the
+ * handoff protocol.
+ */
+#define RWSEM_WAIT_TIMEOUT	((HZ - 1)/200 + 1)
+
 /*
  * handle the lock release when processes blocked on it that can now run
  * - if we come here from up_xxxx(), then the RWSEM_FLAG_WAITERS bit must
@@ -131,6 +138,15 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
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
@@ -179,6 +195,12 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
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
@@ -188,15 +210,19 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
  * race conditions between checking the rwsem wait list and setting the
  * sem->count accordingly.
  */
-static inline bool rwsem_try_write_lock(long count, struct rw_semaphore *sem)
+static inline bool
+rwsem_try_write_lock(long count, struct rw_semaphore *sem, bool first)
 {
 	long new;
 
 	if (RWSEM_COUNT_LOCKED(count))
 		return false;
 
-	new = count + RWSEM_WRITER_LOCKED -
-	     (list_is_singular(&sem->wait_list) ? RWSEM_FLAG_WAITERS : 0);
+	if (!first && RWSEM_COUNT_HANDOFF(count))
+		return false;
+
+	new = (count & ~RWSEM_FLAG_HANDOFF) + RWSEM_WRITER_LOCKED -
+	      (list_is_singular(&sem->wait_list) ? RWSEM_FLAG_WAITERS : 0);
 
 	if (atomic_long_try_cmpxchg_acquire(&sem->count, &count, new)) {
 		rwsem_set_owner(sem);
@@ -214,7 +240,7 @@ static inline bool rwsem_try_write_lock_unqueued(struct rw_semaphore *sem)
 {
 	long count = atomic_long_read(&sem->count);
 
-	while (!RWSEM_COUNT_LOCKED(count)) {
+	while (!RWSEM_COUNT_LOCKED_OR_HANDOFF(count)) {
 		if (atomic_long_try_cmpxchg_acquire(&sem->count, &count,
 					count + RWSEM_WRITER_LOCKED)) {
 			rwsem_set_owner(sem);
@@ -367,6 +393,16 @@ static inline bool rwsem_has_spinner(struct rw_semaphore *sem)
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
@@ -379,16 +415,18 @@ __rwsem_down_read_failed_common(struct rw_semaphore *sem, int state)
 
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
@@ -436,7 +474,8 @@ __rwsem_down_read_failed_common(struct rw_semaphore *sem, int state)
 out_nolock:
 	list_del(&waiter.list);
 	if (list_empty(&sem->wait_list))
-		atomic_long_andnot(RWSEM_FLAG_WAITERS, &sem->count);
+		atomic_long_andnot(RWSEM_FLAG_WAITERS|RWSEM_FLAG_HANDOFF,
+				   &sem->count);
 	raw_spin_unlock_irq(&sem->wait_lock);
 	__set_current_state(TASK_RUNNING);
 	lockevent_inc(rwsem_rlock_fail);
@@ -464,7 +503,7 @@ static inline struct rw_semaphore *
 __rwsem_down_write_failed_common(struct rw_semaphore *sem, int state)
 {
 	long count;
-	bool waiting = true; /* any queued threads before us */
+	int first;	/* First one in queue (>1 if handoff set) */
 	struct rwsem_waiter waiter;
 	struct rw_semaphore *ret = sem;
 	DEFINE_WAKE_Q(wake_q);
@@ -479,56 +518,63 @@ __rwsem_down_write_failed_common(struct rw_semaphore *sem, int state)
 	 */
 	waiter.task = current;
 	waiter.type = RWSEM_WAITING_FOR_WRITE;
+	waiter.timeout = jiffies + RWSEM_WAIT_TIMEOUT;
 
 	raw_spin_lock_irq(&sem->wait_lock);
 
 	/* account for this before adding a new element to the list */
-	if (list_empty(&sem->wait_list))
-		waiting = false;
+	first = list_empty(&sem->wait_list);
 
 	list_add_tail(&waiter.list, &sem->wait_list);
 
 	/* we're now waiting on the lock */
-	if (waiting) {
+	if (!first) {
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
+		if (rwsem_try_write_lock(count, sem, first))
 			break;
+
 		raw_spin_unlock_irq(&sem->wait_lock);
 
 		/* Block until there are no active lockers. */
-		do {
+		for (;;) {
 			if (signal_pending_state(state, current))
 				goto out_nolock;
 
@@ -536,7 +582,31 @@ __rwsem_down_write_failed_common(struct rw_semaphore *sem, int state)
 			lockevent_inc(rwsem_sleep_writer);
 			set_current_state(state);
 			count = atomic_long_read(&sem->count);
-		} while (RWSEM_COUNT_LOCKED(count));
+
+			if (!first)
+				first = rwsem_waiter_is_first(sem, &waiter);
+
+			if (!RWSEM_COUNT_LOCKED(count))
+				break;
+
+			if (first && !RWSEM_COUNT_HANDOFF(count) &&
+			    time_after(jiffies, waiter.timeout)) {
+				atomic_long_or(RWSEM_FLAG_HANDOFF, &sem->count);
+				first++;
+
+				/*
+				 * Make sure the handoff bit is seen by
+				 * others before proceeding.
+				 */
+				smp_mb__after_atomic();
+				lockevent_inc(rwsem_wlock_handoff);
+				/*
+				 * Do a trylock after setting the handoff
+				 * flag to avoid missed wakeup.
+				 */
+				break;
+			}
+		}
 
 		raw_spin_lock_irq(&sem->wait_lock);
 	}
@@ -551,6 +621,12 @@ __rwsem_down_write_failed_common(struct rw_semaphore *sem, int state)
 	__set_current_state(TASK_RUNNING);
 	raw_spin_lock_irq(&sem->wait_lock);
 	list_del(&waiter.list);
+	/*
+	 * If handoff bit is set by this waiter, make sure that the clearing
+	 * of the handoff bit is seen by all before proceeding.
+	 */
+	if (unlikely(first > 1))
+		atomic_long_add_return(-RWSEM_FLAG_HANDOFF,  &sem->count);
 	if (list_empty(&sem->wait_list))
 		atomic_long_andnot(RWSEM_FLAG_WAITERS, &sem->count);
 	else
@@ -581,7 +657,7 @@ EXPORT_SYMBOL(rwsem_down_write_failed_killable);
  * - up_read/up_write has decremented the active part of count if we come here
  */
 __visible
-struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem)
+struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem, long count)
 {
 	unsigned long flags;
 	DEFINE_WAKE_Q(wake_q);
@@ -614,7 +690,9 @@ struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem)
 	smp_rmb();
 
 	/*
-	 * If a spinner is present, it is not necessary to do the wakeup.
+	 * If a spinner is present and the handoff flag isn't set, it is
+	 * not necessary to do the wakeup.
+	 *
 	 * Try to do wakeup only if the trylock succeeds to minimize
 	 * spinlock contention which may introduce too much delay in the
 	 * unlock operation.
@@ -633,7 +711,7 @@ struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem)
 	 * rwsem_has_spinner() is true, it will guarantee at least one
 	 * trylock attempt on the rwsem later on.
 	 */
-	if (rwsem_has_spinner(sem)) {
+	if (rwsem_has_spinner(sem) && !RWSEM_COUNT_HANDOFF(count)) {
 		/*
 		 * The smp_rmb() here is to make sure that the spinner
 		 * state is consulted before reading the wait_lock.
diff --git a/kernel/locking/rwsem.h b/kernel/locking/rwsem.h
index a49ebce1b4ab..2befb5ab1181 100644
--- a/kernel/locking/rwsem.h
+++ b/kernel/locking/rwsem.h
@@ -45,7 +45,8 @@
  *
  * Bit  0   - writer locked bit
  * Bit  1   - waiters present bit
- * Bits 2-7 - reserved
+ * Bit  2   - lock handoff bit
+ * Bits 3-7 - reserved
  * Bits 8-X - 24-bit (32-bit) or 56-bit reader count
  *
  * atomic_long_fetch_add() is used to obtain reader lock, whereas
@@ -53,14 +54,20 @@
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
 
 #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
 /*
@@ -167,7 +174,7 @@ extern struct rw_semaphore *rwsem_down_read_failed(struct rw_semaphore *sem);
 extern struct rw_semaphore *rwsem_down_read_failed_killable(struct rw_semaphore *sem);
 extern struct rw_semaphore *rwsem_down_write_failed(struct rw_semaphore *sem);
 extern struct rw_semaphore *rwsem_down_write_failed_killable(struct rw_semaphore *sem);
-extern struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem);
+extern struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem, long count);
 extern struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem);
 
 /*
@@ -265,7 +272,7 @@ static inline void __up_read(struct rw_semaphore *sem)
 	tmp = atomic_long_add_return_release(-RWSEM_READER_BIAS, &sem->count);
 	if (unlikely((tmp & (RWSEM_LOCK_MASK|RWSEM_FLAG_WAITERS))
 			== RWSEM_FLAG_WAITERS))
-		rwsem_wake(sem);
+		rwsem_wake(sem, tmp);
 }
 
 /*
@@ -273,11 +280,13 @@ static inline void __up_read(struct rw_semaphore *sem)
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

