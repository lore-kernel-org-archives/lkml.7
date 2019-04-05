Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B16FC282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 19:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2502421738
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 19:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731832AbfDETWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 15:22:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59562 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731183AbfDETWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 15:22:00 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 78C46307B976;
        Fri,  5 Apr 2019 19:21:59 +0000 (UTC)
Received: from llong.com (dhcp-17-47.bos.redhat.com [10.18.17.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 68FBD60BCE;
        Fri,  5 Apr 2019 19:21:58 +0000 (UTC)
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
Subject: [PATCH-tip v2 01/12] locking/rwsem: Implement a new locking scheme
Date:   Fri,  5 Apr 2019 15:21:04 -0400
Message-Id: <20190405192115.17416-2-longman@redhat.com>
In-Reply-To: <20190405192115.17416-1-longman@redhat.com>
References: <20190405192115.17416-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 05 Apr 2019 19:21:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current way of using various reader, writer and waiting biases
in the rwsem code are confusing and hard to understand. I have to
reread the rwsem count guide in the rwsem-xadd.c file from time to
time to remind myself how this whole thing works. It also makes the
rwsem code harder to be optimized.

To make rwsem more sane, a new locking scheme similar to the one in
qrwlock is now being used.  The atomic long count has the following
bit definitions:

  Bit  0   - writer locked bit
  Bit  1   - waiters present bit
  Bits 2-7 - reserved for future extension
  Bits 8-X - reader count (24/56 bits)

The cmpxchg instruction is now used to acquire the write lock. The read
lock is still acquired with xadd instruction, so there is no change here.
This scheme will allow up to 16M/64P active readers which should be
more than enough. We can always use some more reserved bits if necessary.

With that change, we can deterministically know if a rwsem has been
write-locked. Looking at the count alone, however, one cannot determine
for certain if a rwsem is owned by readers or not as the readers that
set the reader count bits may be in the process of backing out. So we
still need the reader-owned bit in the owner field to be sure.

With a locking microbenchmark running on 5.1 based kernel, the total
locking rates (in kops/s) of the benchmark on a 8-socket 120-core
IvyBridge-EX system before and after the patch were as follows:

                  Before Patch      After Patch
   # of Threads  wlock    rlock    wlock    rlock
   ------------  -----    -----    -----    -----
        1        30,659   31,341   31,055   31,283
        2         8,909   16,457    9,884   17,659
        4         9,028   15,823    8,933   20,233
        8         8,410   14,212    7,230   17,140
       16         8,217   25,240    7,479   24,607

The locking rates of the benchmark on a Power8 system were as follows:

                  Before Patch      After Patch
   # of Threads  wlock    rlock    wlock    rlock
   ------------  -----    -----    -----    -----
        1        12,963   13,647   13,275   13,601
        2         7,570   11,569    7,902   10,829
        4         5,232    5,516    5,466    5,435
        8         5,233    3,386    5,467    3,168

The locking rates of the benchmark on a 2-socket ARM64 system were
as follows:

                  Before Patch      After Patch
   # of Threads  wlock    rlock    wlock    rlock
   ------------  -----    -----    -----    -----
        1        21,495   21,046   21,524   21,074
        2         5,293   10,502    5,333   10,504
        4         5,325   11,463    5,358   11,631
        8         5,391   11,712    5,470   11,680

The performance are roughly the same before and after the patch. There
are run-to-run variations in performance. Runs with higher variances
usually have higher throughput.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem-xadd.c | 147 ++++++++++++------------------------
 kernel/locking/rwsem.h      |  74 +++++++++---------
 2 files changed, 86 insertions(+), 135 deletions(-)

diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index 6b3ee9948bf1..adab6477be51 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -9,6 +9,8 @@
  *
  * Optimistic spinning by Tim Chen <tim.c.chen@intel.com>
  * and Davidlohr Bueso <davidlohr@hp.com>. Based on mutexes.
+ *
+ * Rwsem count bit fields re-definition by Waiman Long <longman@redhat.com>.
  */
 #include <linux/rwsem.h>
 #include <linux/init.h>
@@ -22,52 +24,20 @@
 #include "rwsem.h"
 
 /*
- * Guide to the rw_semaphore's count field for common values.
- * (32-bit case illustrated, similar for 64-bit)
- *
- * 0x0000000X	(1) X readers active or attempting lock, no writer waiting
- *		    X = #active_readers + #readers attempting to lock
- *		    (X*ACTIVE_BIAS)
- *
- * 0x00000000	rwsem is unlocked, and no one is waiting for the lock or
- *		attempting to read lock or write lock.
- *
- * 0xffff000X	(1) X readers active or attempting lock, with waiters for lock
- *		    X = #active readers + # readers attempting lock
- *		    (X*ACTIVE_BIAS + WAITING_BIAS)
- *		(2) 1 writer attempting lock, no waiters for lock
- *		    X-1 = #active readers + #readers attempting lock
- *		    ((X-1)*ACTIVE_BIAS + ACTIVE_WRITE_BIAS)
- *		(3) 1 writer active, no waiters for lock
- *		    X-1 = #active readers + #readers attempting lock
- *		    ((X-1)*ACTIVE_BIAS + ACTIVE_WRITE_BIAS)
- *
- * 0xffff0001	(1) 1 reader active or attempting lock, waiters for lock
- *		    (WAITING_BIAS + ACTIVE_BIAS)
- *		(2) 1 writer active or attempting lock, no waiters for lock
- *		    (ACTIVE_WRITE_BIAS)
+ * Guide to the rw_semaphore's count field.
  *
- * 0xffff0000	(1) There are writers or readers queued but none active
- *		    or in the process of attempting lock.
- *		    (WAITING_BIAS)
- *		Note: writer can attempt to steal lock for this count by adding
- *		ACTIVE_WRITE_BIAS in cmpxchg and checking the old count
+ * When the RWSEM_WRITER_LOCKED bit in count is set, the lock is owned
+ * by a writer.
  *
- * 0xfffe0001	(1) 1 writer active, or attempting lock. Waiters on queue.
- *		    (ACTIVE_WRITE_BIAS + WAITING_BIAS)
- *
- * Note: Readers attempt to lock by adding ACTIVE_BIAS in down_read and checking
- *	 the count becomes more than 0 for successful lock acquisition,
- *	 i.e. the case where there are only readers or nobody has lock.
- *	 (1st and 2nd case above).
- *
- *	 Writers attempt to lock by adding ACTIVE_WRITE_BIAS in down_write and
- *	 checking the count becomes ACTIVE_WRITE_BIAS for successful lock
- *	 acquisition (i.e. nobody else has lock or attempts lock).  If
- *	 unsuccessful, in rwsem_down_write_failed, we'll check to see if there
- *	 are only waiters but none active (5th case above), and attempt to
- *	 steal the lock.
+ * The lock is owned by readers when
+ * (1) the RWSEM_WRITER_LOCKED isn't set in count,
+ * (2) some of the reader bits are set in count, and
+ * (3) the owner field has RWSEM_READ_OWNED bit set.
  *
+ * Having some reader bits set is not enough to guarantee a readers owned
+ * lock as the readers may be in the process of backing out from the count
+ * and a writer has just released the lock. So another writer may steal
+ * the lock immediately after that.
  */
 
 /*
@@ -113,9 +83,8 @@ enum rwsem_wake_type {
 
 /*
  * handle the lock release when processes blocked on it that can now run
- * - if we come here from up_xxxx(), then:
- *   - the 'active part' of count (&0x0000ffff) reached 0 (but may have changed)
- *   - the 'waiting part' of count (&0xffff0000) is -ve (and will still be so)
+ * - if we come here from up_xxxx(), then the RWSEM_FLAG_WAITERS bit must
+ *   have been set.
  * - there must be someone on the queue
  * - the wait_lock must be held by the caller
  * - tasks are marked for wakeup, the caller must later invoke wake_up_q()
@@ -159,22 +128,11 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 	 * so we can bail out early if a writer stole the lock.
 	 */
 	if (wake_type != RWSEM_WAKE_READ_OWNED) {
-		adjustment = RWSEM_ACTIVE_READ_BIAS;
- try_reader_grant:
+		adjustment = RWSEM_READER_BIAS;
 		oldcount = atomic_long_fetch_add(adjustment, &sem->count);
-		if (unlikely(oldcount < RWSEM_WAITING_BIAS)) {
-			/*
-			 * If the count is still less than RWSEM_WAITING_BIAS
-			 * after removing the adjustment, it is assumed that
-			 * a writer has stolen the lock. We have to undo our
-			 * reader grant.
-			 */
-			if (atomic_long_add_return(-adjustment, &sem->count) <
-			    RWSEM_WAITING_BIAS)
-				return;
-
-			/* Last active locker left. Retry waking readers. */
-			goto try_reader_grant;
+		if (unlikely(oldcount & RWSEM_WRITER_MASK)) {
+			atomic_long_sub(adjustment, &sem->count);
+			return;
 		}
 		/*
 		 * Set it to reader-owned to give spinners an early
@@ -214,11 +172,11 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 		wake_q_add_safe(wake_q, tsk);
 	}
 
-	adjustment = woken * RWSEM_ACTIVE_READ_BIAS - adjustment;
+	adjustment = woken * RWSEM_READER_BIAS - adjustment;
 	lockevent_cond_inc(rwsem_wake_reader, woken);
 	if (list_empty(&sem->wait_list)) {
 		/* hit end of list above */
-		adjustment -= RWSEM_WAITING_BIAS;
+		adjustment -= RWSEM_FLAG_WAITERS;
 	}
 
 	if (adjustment)
@@ -232,22 +190,15 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
  */
 static inline bool rwsem_try_write_lock(long count, struct rw_semaphore *sem)
 {
-	/*
-	 * Avoid trying to acquire write lock if count isn't RWSEM_WAITING_BIAS.
-	 */
-	if (count != RWSEM_WAITING_BIAS)
+	long new;
+
+	if (RWSEM_COUNT_LOCKED(count))
 		return false;
 
-	/*
-	 * Acquire the lock by trying to set it to ACTIVE_WRITE_BIAS. If there
-	 * are other tasks on the wait list, we need to add on WAITING_BIAS.
-	 */
-	count = list_is_singular(&sem->wait_list) ?
-			RWSEM_ACTIVE_WRITE_BIAS :
-			RWSEM_ACTIVE_WRITE_BIAS + RWSEM_WAITING_BIAS;
+	new = count + RWSEM_WRITER_LOCKED -
+	     (list_is_singular(&sem->wait_list) ? RWSEM_FLAG_WAITERS : 0);
 
-	if (atomic_long_cmpxchg_acquire(&sem->count, RWSEM_WAITING_BIAS, count)
-							== RWSEM_WAITING_BIAS) {
+	if (atomic_long_try_cmpxchg_acquire(&sem->count, &count, new)) {
 		rwsem_set_owner(sem);
 		return true;
 	}
@@ -263,9 +214,9 @@ static inline bool rwsem_try_write_lock_unqueued(struct rw_semaphore *sem)
 {
 	long count = atomic_long_read(&sem->count);
 
-	while (!count || count == RWSEM_WAITING_BIAS) {
+	while (!RWSEM_COUNT_LOCKED(count)) {
 		if (atomic_long_try_cmpxchg_acquire(&sem->count, &count,
-					count + RWSEM_ACTIVE_WRITE_BIAS)) {
+					count + RWSEM_WRITER_LOCKED)) {
 			rwsem_set_owner(sem);
 			lockevent_inc(rwsem_opt_wlock);
 			return true;
@@ -422,7 +373,7 @@ static inline bool rwsem_has_spinner(struct rw_semaphore *sem)
 static inline struct rw_semaphore __sched *
 __rwsem_down_read_failed_common(struct rw_semaphore *sem, int state)
 {
-	long count, adjustment = -RWSEM_ACTIVE_READ_BIAS;
+	long count, adjustment = -RWSEM_READER_BIAS;
 	struct rwsem_waiter waiter;
 	DEFINE_WAKE_Q(wake_q);
 
@@ -434,16 +385,16 @@ __rwsem_down_read_failed_common(struct rw_semaphore *sem, int state)
 		/*
 		 * In case the wait queue is empty and the lock isn't owned
 		 * by a writer, this reader can exit the slowpath and return
-		 * immediately as its RWSEM_ACTIVE_READ_BIAS has already
-		 * been set in the count.
+		 * immediately as its RWSEM_READER_BIAS has already been
+		 * set in the count.
 		 */
-		if (atomic_long_read(&sem->count) >= 0) {
+		if (!(atomic_long_read(&sem->count) & RWSEM_WRITER_MASK)) {
 			raw_spin_unlock_irq(&sem->wait_lock);
 			rwsem_set_reader_owned(sem);
 			lockevent_inc(rwsem_rlock_fast);
 			return sem;
 		}
-		adjustment += RWSEM_WAITING_BIAS;
+		adjustment += RWSEM_FLAG_WAITERS;
 	}
 	list_add_tail(&waiter.list, &sem->wait_list);
 
@@ -456,9 +407,8 @@ __rwsem_down_read_failed_common(struct rw_semaphore *sem, int state)
 	 * If there are no writers and we are first in the queue,
 	 * wake our own waiter to join the existing active readers !
 	 */
-	if (count == RWSEM_WAITING_BIAS ||
-	    (count > RWSEM_WAITING_BIAS &&
-	     adjustment != -RWSEM_ACTIVE_READ_BIAS))
+	if (!RWSEM_COUNT_LOCKED(count) ||
+	   (!(count & RWSEM_WRITER_MASK) && (adjustment & RWSEM_FLAG_WAITERS)))
 		__rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
 
 	raw_spin_unlock_irq(&sem->wait_lock);
@@ -486,7 +436,7 @@ __rwsem_down_read_failed_common(struct rw_semaphore *sem, int state)
 out_nolock:
 	list_del(&waiter.list);
 	if (list_empty(&sem->wait_list))
-		atomic_long_add(-RWSEM_WAITING_BIAS, &sem->count);
+		atomic_long_andnot(RWSEM_FLAG_WAITERS, &sem->count);
 	raw_spin_unlock_irq(&sem->wait_lock);
 	__set_current_state(TASK_RUNNING);
 	lockevent_inc(rwsem_rlock_fail);
@@ -519,9 +469,6 @@ __rwsem_down_write_failed_common(struct rw_semaphore *sem, int state)
 	struct rw_semaphore *ret = sem;
 	DEFINE_WAKE_Q(wake_q);
 
-	/* undo write bias from down_write operation, stop active locking */
-	count = atomic_long_sub_return(RWSEM_ACTIVE_WRITE_BIAS, &sem->count);
-
 	/* do optimistic spinning and steal lock if possible */
 	if (rwsem_optimistic_spin(sem))
 		return sem;
@@ -541,16 +488,18 @@ __rwsem_down_write_failed_common(struct rw_semaphore *sem, int state)
 
 	list_add_tail(&waiter.list, &sem->wait_list);
 
-	/* we're now waiting on the lock, but no longer actively locking */
+	/* we're now waiting on the lock */
 	if (waiting) {
 		count = atomic_long_read(&sem->count);
 
 		/*
 		 * If there were already threads queued before us and there are
-		 * no active writers, the lock must be read owned; so we try to
-		 * wake any read locks that were queued ahead of us.
+		 * no active writers and some readers, the lock must be read
+		 * owned; so we try to  any read locks that were queued ahead
+		 * of us.
 		 */
-		if (count > RWSEM_WAITING_BIAS) {
+		if (!(count & RWSEM_WRITER_MASK) &&
+		     (count & RWSEM_READER_MASK)) {
 			__rwsem_mark_wake(sem, RWSEM_WAKE_READERS, &wake_q);
 			/*
 			 * The wakeup is normally called _after_ the wait_lock
@@ -567,8 +516,9 @@ __rwsem_down_write_failed_common(struct rw_semaphore *sem, int state)
 			wake_q_init(&wake_q);
 		}
 
-	} else
-		count = atomic_long_add_return(RWSEM_WAITING_BIAS, &sem->count);
+	} else {
+		count = atomic_long_add_return(RWSEM_FLAG_WAITERS, &sem->count);
+	}
 
 	/* wait until we successfully acquire the lock */
 	set_current_state(state);
@@ -585,7 +535,8 @@ __rwsem_down_write_failed_common(struct rw_semaphore *sem, int state)
 			schedule();
 			lockevent_inc(rwsem_sleep_writer);
 			set_current_state(state);
-		} while ((count = atomic_long_read(&sem->count)) & RWSEM_ACTIVE_MASK);
+			count = atomic_long_read(&sem->count);
+		} while (RWSEM_COUNT_LOCKED(count));
 
 		raw_spin_lock_irq(&sem->wait_lock);
 	}
@@ -601,7 +552,7 @@ __rwsem_down_write_failed_common(struct rw_semaphore *sem, int state)
 	raw_spin_lock_irq(&sem->wait_lock);
 	list_del(&waiter.list);
 	if (list_empty(&sem->wait_list))
-		atomic_long_add(-RWSEM_WAITING_BIAS, &sem->count);
+		atomic_long_andnot(RWSEM_FLAG_WAITERS, &sem->count);
 	else
 		__rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
 	raw_spin_unlock_irq(&sem->wait_lock);
diff --git a/kernel/locking/rwsem.h b/kernel/locking/rwsem.h
index 37db17890e36..a49ebce1b4ab 100644
--- a/kernel/locking/rwsem.h
+++ b/kernel/locking/rwsem.h
@@ -41,24 +41,26 @@
 #endif
 
 /*
- * R/W semaphores originally for PPC using the stuff in lib/rwsem.c.
- * Adapted largely from include/asm-i386/rwsem.h
- * by Paul Mackerras <paulus@samba.org>.
+ * The definition of the atomic counter in the semaphore:
+ *
+ * Bit  0   - writer locked bit
+ * Bit  1   - waiters present bit
+ * Bits 2-7 - reserved
+ * Bits 8-X - 24-bit (32-bit) or 56-bit reader count
+ *
+ * atomic_long_fetch_add() is used to obtain reader lock, whereas
+ * atomic_long_cmpxchg() will be used to obtain writer lock.
  */
+#define RWSEM_WRITER_LOCKED	(1UL << 0)
+#define RWSEM_FLAG_WAITERS	(1UL << 1)
+#define RWSEM_READER_SHIFT	8
+#define RWSEM_READER_BIAS	(1UL << RWSEM_READER_SHIFT)
+#define RWSEM_READER_MASK	(~(RWSEM_READER_BIAS - 1))
+#define RWSEM_WRITER_MASK	RWSEM_WRITER_LOCKED
+#define RWSEM_LOCK_MASK		(RWSEM_WRITER_MASK|RWSEM_READER_MASK)
+#define RWSEM_READ_FAILED_MASK	(RWSEM_WRITER_MASK|RWSEM_FLAG_WAITERS)
 
-/*
- * the semaphore definition
- */
-#ifdef CONFIG_64BIT
-# define RWSEM_ACTIVE_MASK		0xffffffffL
-#else
-# define RWSEM_ACTIVE_MASK		0x0000ffffL
-#endif
-
-#define RWSEM_ACTIVE_BIAS		0x00000001L
-#define RWSEM_WAITING_BIAS		(-RWSEM_ACTIVE_MASK-1)
-#define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
-#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
+#define RWSEM_COUNT_LOCKED(c)	((c) & RWSEM_LOCK_MASK)
 
 #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
 /*
@@ -173,7 +175,8 @@ extern struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem);
  */
 static inline void __down_read(struct rw_semaphore *sem)
 {
-	if (unlikely(atomic_long_inc_return_acquire(&sem->count) <= 0)) {
+	if (unlikely(atomic_long_fetch_add_acquire(RWSEM_READER_BIAS,
+			&sem->count) & RWSEM_READ_FAILED_MASK)) {
 		rwsem_down_read_failed(sem);
 		DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner &
 					RWSEM_READER_OWNED), sem);
@@ -184,7 +187,8 @@ static inline void __down_read(struct rw_semaphore *sem)
 
 static inline int __down_read_killable(struct rw_semaphore *sem)
 {
-	if (unlikely(atomic_long_inc_return_acquire(&sem->count) <= 0)) {
+	if (unlikely(atomic_long_fetch_add_acquire(RWSEM_READER_BIAS,
+			&sem->count) & RWSEM_READ_FAILED_MASK)) {
 		if (IS_ERR(rwsem_down_read_failed_killable(sem)))
 			return -EINTR;
 		DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner &
@@ -205,11 +209,11 @@ static inline int __down_read_trylock(struct rw_semaphore *sem)
 	lockevent_inc(rwsem_rtrylock);
 	do {
 		if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
-					tmp + RWSEM_ACTIVE_READ_BIAS)) {
+					tmp + RWSEM_READER_BIAS)) {
 			rwsem_set_reader_owned(sem);
 			return 1;
 		}
-	} while (tmp >= 0);
+	} while (!(tmp & RWSEM_READ_FAILED_MASK));
 	return 0;
 }
 
@@ -218,22 +222,16 @@ static inline int __down_read_trylock(struct rw_semaphore *sem)
  */
 static inline void __down_write(struct rw_semaphore *sem)
 {
-	long tmp;
-
-	tmp = atomic_long_add_return_acquire(RWSEM_ACTIVE_WRITE_BIAS,
-					     &sem->count);
-	if (unlikely(tmp != RWSEM_ACTIVE_WRITE_BIAS))
+	if (unlikely(atomic_long_cmpxchg_acquire(&sem->count, 0,
+						 RWSEM_WRITER_LOCKED)))
 		rwsem_down_write_failed(sem);
 	rwsem_set_owner(sem);
 }
 
 static inline int __down_write_killable(struct rw_semaphore *sem)
 {
-	long tmp;
-
-	tmp = atomic_long_add_return_acquire(RWSEM_ACTIVE_WRITE_BIAS,
-					     &sem->count);
-	if (unlikely(tmp != RWSEM_ACTIVE_WRITE_BIAS))
+	if (unlikely(atomic_long_cmpxchg_acquire(&sem->count, 0,
+						 RWSEM_WRITER_LOCKED)))
 		if (IS_ERR(rwsem_down_write_failed_killable(sem)))
 			return -EINTR;
 	rwsem_set_owner(sem);
@@ -246,7 +244,7 @@ static inline int __down_write_trylock(struct rw_semaphore *sem)
 
 	lockevent_inc(rwsem_wtrylock);
 	tmp = atomic_long_cmpxchg_acquire(&sem->count, RWSEM_UNLOCKED_VALUE,
-		      RWSEM_ACTIVE_WRITE_BIAS);
+					  RWSEM_WRITER_LOCKED);
 	if (tmp == RWSEM_UNLOCKED_VALUE) {
 		rwsem_set_owner(sem);
 		return true;
@@ -264,8 +262,9 @@ static inline void __up_read(struct rw_semaphore *sem)
 	DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner & RWSEM_READER_OWNED),
 				sem);
 	rwsem_clear_reader_owned(sem);
-	tmp = atomic_long_dec_return_release(&sem->count);
-	if (unlikely(tmp < -1 && (tmp & RWSEM_ACTIVE_MASK) == 0))
+	tmp = atomic_long_add_return_release(-RWSEM_READER_BIAS, &sem->count);
+	if (unlikely((tmp & (RWSEM_LOCK_MASK|RWSEM_FLAG_WAITERS))
+			== RWSEM_FLAG_WAITERS))
 		rwsem_wake(sem);
 }
 
@@ -276,8 +275,8 @@ static inline void __up_write(struct rw_semaphore *sem)
 {
 	DEBUG_RWSEMS_WARN_ON(sem->owner != current, sem);
 	rwsem_clear_owner(sem);
-	if (unlikely(atomic_long_sub_return_release(RWSEM_ACTIVE_WRITE_BIAS,
-						    &sem->count) < 0))
+	if (unlikely(atomic_long_fetch_add_release(-RWSEM_WRITER_LOCKED,
+			&sem->count) & RWSEM_FLAG_WAITERS))
 		rwsem_wake(sem);
 }
 
@@ -296,8 +295,9 @@ static inline void __downgrade_write(struct rw_semaphore *sem)
 	 * write side. As such, rely on RELEASE semantics.
 	 */
 	DEBUG_RWSEMS_WARN_ON(sem->owner != current, sem);
-	tmp = atomic_long_add_return_release(-RWSEM_WAITING_BIAS, &sem->count);
+	tmp = atomic_long_fetch_add_release(
+		-RWSEM_WRITER_LOCKED+RWSEM_READER_BIAS, &sem->count);
 	rwsem_set_reader_owned(sem);
-	if (tmp < 0)
+	if (tmp & RWSEM_FLAG_WAITERS)
 		rwsem_downgrade_wake(sem);
 }
-- 
2.18.1

