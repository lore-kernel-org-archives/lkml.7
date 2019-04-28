Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1D2C4321A
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 21:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD24B2067C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 21:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfD1V1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 17:27:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56668 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726975AbfD1V1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 17:27:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 46F5430842CE;
        Sun, 28 Apr 2019 21:27:00 +0000 (UTC)
Received: from llong.com (ovpn-120-22.rdu2.redhat.com [10.10.120.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 648286BF93;
        Sun, 28 Apr 2019 21:26:58 +0000 (UTC)
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
Subject: [PATCH-tip v7 14/20] locking/rwsem: Enable time-based spinning on reader-owned rwsem
Date:   Sun, 28 Apr 2019 17:25:51 -0400
Message-Id: <20190428212557.13482-15-longman@redhat.com>
In-Reply-To: <20190428212557.13482-1-longman@redhat.com>
References: <20190428212557.13482-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Sun, 28 Apr 2019 21:27:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the rwsem is owned by reader, writers stop optimistic spinning
simply because there is no easy way to figure out if all the readers
are actively running or not. However, there are scenarios where
the readers are unlikely to sleep and optimistic spinning can help
performance.

This patch provides a simple mechanism for spinning on a reader-owned
rwsem by a writer. It is a time threshold based spinning where the
allowable spinning time can vary from 10us to 25us depending on the
condition of the rwsem.

When the time threshold is exceeded, the nonspinnable bits will be set
in the owner field to indicate that no more optimistic spinning will
be allowed on this rwsem until it becomes writer owned again. Not even
readers is allowed to acquire the reader-locked rwsem by optimistic
spinning for fairness.

We also want a writer to acquire the lock after the readers hold the
lock for a relatively long time. In order to give preference to writers
under such a circumstance, the single RWSEM_NONSPINNABLE bit is now split
into two - one for reader and one for writer. When optimistic spinning
is disabled, both bits will be set. When the reader count drop down
to 0, the writer nonspinnable bit will be cleared to allow writers to
spin on the lock, but not the readers. When a writer acquires the lock,
it will write its own task structure pointer into sem->owner and clear
the reader nonspinnable bit in the process.

The time taken for each iteration of the reader-owned rwsem spinning
loop varies. Below are sample minimum elapsed times for 16 iterations
of the loop.

      System                 Time for 16 Iterations
      ------                 ----------------------
  1-socket Skylake                  ~800ns
  4-socket Broadwell                ~300ns
  2-socket ThunderX2 (arm64)        ~250ns

When the lock cacheline is contended, we can see up to almost 10X
increase in elapsed time.  So 25us will be at most 500, 1300 and 1600
iterations for each of the above systems.

With a locking microbenchmark running on 5.1 based kernel, the total
locking rates (in kops/s) on a 8-socket IvyBridge-EX system with
equal numbers of readers and writers before and after this patch were
as follows:

   # of Threads  Pre-patch    Post-patch
   ------------  ---------    ----------
        2          1,759        6,684
        4          1,684        6,738
        8          1,074        7,222
       16            900        7,163
       32            458        7,316
       64            208          520
      128            168          425
      240            143          474

This patch gives a big boost in performance for mixed reader/writer
workloads.

With 32 locking threads, the rwsem lock event data were:

rwsem_opt_fail=79850
rwsem_opt_nospin=5069
rwsem_opt_rlock=597484
rwsem_opt_wlock=957339
rwsem_sleep_reader=57782
rwsem_sleep_writer=55663

With 64 locking threads, the data looked like:

rwsem_opt_fail=346723
rwsem_opt_nospin=6293
rwsem_opt_rlock=1127119
rwsem_opt_wlock=1400628
rwsem_sleep_reader=308201
rwsem_sleep_writer=72281

So a lot more threads acquired the lock in the slowpath and more threads
went to sleep.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lock_events_list.h |   1 +
 kernel/locking/rwsem.c            | 242 ++++++++++++++++++++++++------
 2 files changed, 197 insertions(+), 46 deletions(-)

diff --git a/kernel/locking/lock_events_list.h b/kernel/locking/lock_events_list.h
index ca954e4e00e4..baa998401052 100644
--- a/kernel/locking/lock_events_list.h
+++ b/kernel/locking/lock_events_list.h
@@ -59,6 +59,7 @@ LOCK_EVENT(rwsem_wake_writer)	/* # of writer wakeups			*/
 LOCK_EVENT(rwsem_opt_rlock)	/* # of read locks opt-spin acquired	*/
 LOCK_EVENT(rwsem_opt_wlock)	/* # of write locks opt-spin acquired	*/
 LOCK_EVENT(rwsem_opt_fail)	/* # of failed opt-spinnings		*/
+LOCK_EVENT(rwsem_opt_nospin)	/* # of disabled reader opt-spinnings	*/
 LOCK_EVENT(rwsem_rlock)		/* # of read locks acquired		*/
 LOCK_EVENT(rwsem_rlock_fast)	/* # of fast read locks acquired	*/
 LOCK_EVENT(rwsem_rlock_fail)	/* # of failed read lock acquisitions	*/
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 6b11dce3139d..62fcb8bacfab 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -23,6 +23,7 @@
 #include <linux/sched/debug.h>
 #include <linux/sched/wake_q.h>
 #include <linux/sched/signal.h>
+#include <linux/sched/clock.h>
 #include <linux/export.h>
 #include <linux/rwsem.h>
 #include <linux/atomic.h>
@@ -31,24 +32,28 @@
 #include "lock_events.h"
 
 /*
- * The least significant 2 bits of the owner value has the following
+ * The least significant 3 bits of the owner value has the following
  * meanings when set.
  *  - Bit 0: RWSEM_READER_OWNED - The rwsem is owned by readers
- *  - Bit 1: RWSEM_NONSPINNABLE - Waiters cannot spin on the rwsem
- *    The rwsem is anonymously owned, i.e. the owner(s) cannot be
- *    readily determined. It can be reader owned or the owning writer
- *    is indeterminate.
+ *  - Bit 1: RWSEM_RD_NONSPINNABLE - Readers cannot spin on this lock.
+ *  - Bit 2: RWSEM_WR_NONSPINNABLE - Writers cannot spin on this lock.
  *
+ * When the rwsem is either owned by an anonymous writer, or it is
+ * reader-owned, but a spinning writer has timed out, both nonspinnable
+ * bits will be set to disable optimistic spinning by readers and writers.
+ * In the later case, the last unlocking reader should then check the
+ * writer nonspinnable bit and clear it only to give writers preference
+ * to acquire the lock via optimistic spinning, but not readers. Similar
+ * action is also done in the reader slowpath.
+
  * When a writer acquires a rwsem, it puts its task_struct pointer
  * into the owner field. It is cleared after an unlock.
  *
  * When a reader acquires a rwsem, it will also puts its task_struct
- * pointer into the owner field with both the RWSEM_READER_OWNED and
- * RWSEM_NONSPINNABLE bits set. On unlock, the owner field will
- * largely be left untouched. So for a free or reader-owned rwsem,
- * the owner value may contain information about the last reader that
- * acquires the rwsem. The anonymous bit is set because that particular
- * reader may or may not still own the lock.
+ * pointer into the owner field with the RWSEM_READER_OWNED bit set.
+ * On unlock, the owner field will largely be left untouched. So
+ * for a free or reader-owned rwsem, the owner value may contain
+ * information about the last reader that acquires the rwsem.
  *
  * That information may be helpful in debugging cases where the system
  * seems to hang on a reader owned rwsem especially if only one reader
@@ -56,7 +61,9 @@
  * a rwsem, but the overhead is simply too big.
  */
 #define RWSEM_READER_OWNED	(1UL << 0)
-#define RWSEM_NONSPINNABLE	(1UL << 1)
+#define RWSEM_RD_NONSPINNABLE	(1UL << 1)
+#define RWSEM_WR_NONSPINNABLE	(1UL << 2)
+#define RWSEM_NONSPINNABLE	(RWSEM_RD_NONSPINNABLE | RWSEM_WR_NONSPINNABLE)
 #define RWSEM_OWNER_FLAGS_MASK	(RWSEM_READER_OWNED | RWSEM_NONSPINNABLE)
 
 #ifdef CONFIG_DEBUG_RWSEMS
@@ -133,8 +140,7 @@ static inline void rwsem_clear_owner(struct rw_semaphore *sem)
 static inline void __rwsem_set_reader_owned(struct rw_semaphore *sem,
 					    struct task_struct *owner)
 {
-	unsigned long val = (unsigned long)owner | RWSEM_READER_OWNED
-						 | RWSEM_NONSPINNABLE;
+	unsigned long val = (unsigned long)owner | RWSEM_READER_OWNED;
 
 	WRITE_ONCE(sem->owner, (struct task_struct *)val);
 }
@@ -149,9 +155,27 @@ static inline void rwsem_set_reader_owned(struct rw_semaphore *sem)
  * and steal the lock.
  * N.B. !owner is considered spinnable.
  */
-static inline bool is_rwsem_owner_spinnable(struct task_struct *owner)
+static inline bool is_rwsem_owner_spinnable(struct task_struct *owner, bool wr)
 {
-	return !((unsigned long)owner & RWSEM_NONSPINNABLE);
+	unsigned long bit = wr ? RWSEM_WR_NONSPINNABLE : RWSEM_RD_NONSPINNABLE;
+
+	return !((unsigned long)owner & bit);
+}
+
+/*
+ * Return true if the rwsem is spinnable.
+ */
+static inline bool is_rwsem_spinnable(struct rw_semaphore *sem, bool wr)
+{
+	return is_rwsem_owner_spinnable(READ_ONCE(sem->owner), wr);
+}
+
+/*
+ * Remove all the flag bits from owner.
+ */
+static inline struct task_struct *owner_without_flags(struct task_struct *owner)
+{
+	return (struct task_struct *)((long)owner & ~RWSEM_OWNER_FLAGS_MASK);
 }
 
 #ifdef CONFIG_DEBUG_RWSEMS
@@ -163,11 +187,11 @@ static inline bool is_rwsem_owner_spinnable(struct task_struct *owner)
  */
 static inline void rwsem_clear_reader_owned(struct rw_semaphore *sem)
 {
-	unsigned long val = (unsigned long)current | RWSEM_READER_OWNED
-						   | RWSEM_NONSPINNABLE;
-	if (READ_ONCE(sem->owner) == (struct task_struct *)val)
+	unsigned long owner = (unsigned long)READ_ONCE(sem->owner);
+
+	if ((owner & ~RWSEM_OWNER_FLAGS_MASK) == (unsigned long)current)
 		cmpxchg_relaxed((unsigned long *)&sem->owner, val,
-				RWSEM_READER_OWNED | RWSEM_NONSPINNABLE);
+				owner & RWSEM_OWNER_FLAGS_MASK);
 }
 #else
 static inline void rwsem_clear_reader_owned(struct rw_semaphore *sem)
@@ -175,6 +199,22 @@ static inline void rwsem_clear_reader_owned(struct rw_semaphore *sem)
 }
 #endif
 
+/*
+ * Set the RWSEM_NONSPINNABLE bits if the RWSEM_READER_OWNED flag
+ * remains set. Otherwise, the operation will be aborted.
+ */
+static inline void rwsem_set_nonspinnable(struct rw_semaphore *sem)
+{
+	long owner = (long)READ_ONCE(sem->owner);
+
+	while (owner & RWSEM_READER_OWNED) {
+		if (!is_rwsem_owner_spinnable((void *)owner, false))
+			break;
+		owner = cmpxchg((long *)&sem->owner, owner,
+				owner | RWSEM_NONSPINNABLE);
+	}
+}
+
 /*
  * Guide to the rw_semaphore's count field.
  *
@@ -496,6 +536,11 @@ static inline bool rwsem_try_write_lock_unqueued(struct rw_semaphore *sem)
 
 static inline bool owner_on_cpu(struct task_struct *owner)
 {
+	/*
+	 * Clear all the flag bits in owner
+	 */
+	owner = owner_without_flags(owner);
+
 	/*
 	 * As lock holder preemption issue, we both skip spinning if
 	 * task is not on cpu or its cpu is preempted
@@ -503,12 +548,12 @@ static inline bool owner_on_cpu(struct task_struct *owner)
 	return owner->on_cpu && !vcpu_is_preempted(task_cpu(owner));
 }
 
-static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
+static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem, bool wr)
 {
 	struct task_struct *owner;
 	bool ret = true;
 
-	BUILD_BUG_ON(is_rwsem_owner_spinnable(RWSEM_OWNER_UNKNOWN));
+	BUILD_BUG_ON(is_rwsem_owner_spinnable(RWSEM_OWNER_UNKNOWN, true));
 
 	if (need_resched()) {
 		lockevent_inc(rwsem_opt_fail);
@@ -517,14 +562,17 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 
 	preempt_disable();
 	rcu_read_lock();
+
 	owner = READ_ONCE(sem->owner);
-	if (owner) {
-		ret = is_rwsem_owner_spinnable(owner) &&
-		      owner_on_cpu(owner);
-	}
+	if (!is_rwsem_owner_spinnable(owner, wr))
+		ret = false;
+	else if ((unsigned long)owner & RWSEM_READER_OWNED)
+		ret = true;
+	else if ((owner = owner_without_flags(owner)))
+		ret = owner_on_cpu(owner);
+
 	rcu_read_unlock();
 	preempt_enable();
-
 	lockevent_cond_inc(rwsem_opt_fail, !ret);
 	return ret;
 }
@@ -546,26 +594,27 @@ enum owner_state {
 	OWNER_READER		= 1 << 2,
 	OWNER_NONSPINNABLE	= 1 << 3,
 };
-#define OWNER_SPINNABLE		(OWNER_NULL | OWNER_WRITER)
+#define OWNER_SPINNABLE		(OWNER_NULL | OWNER_WRITER | OWNER_READER)
 
-static inline enum owner_state rwsem_owner_state(unsigned long owner)
+static inline enum owner_state rwsem_owner_state(unsigned long owner, bool wr)
 {
-	if (!owner)
-		return OWNER_NULL;
-
-	if (owner & RWSEM_NONSPINNABLE)
+	if (!is_rwsem_owner_spinnable((void *)owner, wr))
 		return OWNER_NONSPINNABLE;
 
 	if (owner & RWSEM_READER_OWNED)
 		return OWNER_READER;
 
+	if (!(owner & ~RWSEM_OWNER_FLAGS_MASK))
+		return OWNER_NULL;
+
 	return OWNER_WRITER;
 }
 
-static noinline enum owner_state rwsem_spin_on_owner(struct rw_semaphore *sem)
+static noinline enum owner_state
+rwsem_spin_on_owner(struct rw_semaphore *sem, bool wr)
 {
 	struct task_struct *tmp, *owner = READ_ONCE(sem->owner);
-	enum owner_state state = rwsem_owner_state((unsigned long)owner);
+	enum owner_state state = rwsem_owner_state((unsigned long)owner, wr);
 
 	if (state != OWNER_WRITER)
 		return state;
@@ -579,7 +628,7 @@ static noinline enum owner_state rwsem_spin_on_owner(struct rw_semaphore *sem)
 
 		tmp = READ_ONCE(sem->owner);
 		if (tmp != owner) {
-			state = rwsem_owner_state((unsigned long)tmp);
+			state = rwsem_owner_state((unsigned long)tmp, wr);
 			break;
 		}
 
@@ -603,10 +652,53 @@ static noinline enum owner_state rwsem_spin_on_owner(struct rw_semaphore *sem)
 	return state;
 }
 
+/*
+ * Calculate reader-owned rwsem spinning threshold for writer
+ *
+ * It is assumed that the more readers own the rwsem, the longer it will
+ * take for them to wind down and free the rwsem. So the formula to
+ * determine the actual spinning time limit is:
+ *
+ * 1) RWSEM_FLAG_WAITERS set
+ *    Spinning threshold = (10 + nr_readers/2)us
+ *
+ * 2) RWSEM_FLAG_WAITERS not set
+ *    Spinning threshold = 25us
+ *
+ * In the first case when RWSEM_FLAG_WAITERS is set, no new reader can
+ * become rwsem owner. It is assumed that the more readers own the rwsem,
+ * the longer it will take for them to wind down and free the rwsem. In
+ * addition, if it happens that a previous task that releases the lock
+ * is in the process of waking up readers one-by-one, the process will
+ * take longer when more readers needed to be woken up. This is subjected
+ * to a maximum value of 25us.
+ *
+ * In the second case with RWSEM_FLAG_WAITERS off, new readers can join
+ * and become one of the owners. So assuming for the worst case and spin
+ * for at most 25us.
+ */
+static inline u64 rwsem_rspin_threshold(struct rw_semaphore *sem)
+{
+	long count = atomic_long_read(&sem->count);
+	u64 delta = 25 * NSEC_PER_USEC;
+
+	if (count & RWSEM_FLAG_WAITERS) {
+		int readers = count >> RWSEM_READER_SHIFT;
+
+		if (readers > 30)
+			readers = 30;
+		delta = (20 + readers) * NSEC_PER_USEC / 2;
+	}
+
+	return sched_clock() + delta;
+}
+
 static bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock)
 {
 	bool taken = false;
 	int prev_owner_state = OWNER_NULL;
+	int loop = 0;
+	u64 rspin_threshold = 0;
 
 	preempt_disable();
 
@@ -618,11 +710,10 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock)
 	 * Optimistically spin on the owner field and attempt to acquire the
 	 * lock whenever the owner changes. Spinning will be stopped when:
 	 *  1) the owning writer isn't running; or
-	 *  2) readers own the lock as we can't determine if they are
-	 *     actively running or not.
+	 *  2) readers own the lock and spinning time has exceeded limit.
 	 */
 	for (;;) {
-		enum owner_state owner_state = rwsem_spin_on_owner(sem);
+		enum owner_state owner_state = rwsem_spin_on_owner(sem, wlock);
 
 		if (!(owner_state & OWNER_SPINNABLE))
 			break;
@@ -636,6 +727,39 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock)
 		if (taken)
 			break;
 
+		/*
+		 * Time-based reader-owned rwsem optimistic spinning
+		 */
+		if (wlock && (owner_state == OWNER_READER)) {
+			/*
+			 * Re-initialize rspin_threshold every time when
+			 * the owner state changes from non-reader to reader.
+			 * This allows a writer to steal the lock in between
+			 * 2 reader phases and have the threshold reset at
+			 * the beginning of the 2nd reader phase.
+			 */
+			if (prev_owner_state != OWNER_READER) {
+				if (!is_rwsem_spinnable(sem, wlock))
+					break;
+				rspin_threshold = rwsem_rspin_threshold(sem);
+				loop = 0;
+			}
+
+			/*
+			 * Check time threshold once every 16 iterations to
+			 * avoid calling sched_clock() too frequently so
+			 * as to reduce the average latency between the times
+			 * when the lock becomes free and when the spinner
+			 * is ready to do a trylock.
+			 */
+			else if (!(++loop & 0xf) &&
+				 (sched_clock() > rspin_threshold)) {
+				rwsem_set_nonspinnable(sem);
+				lockevent_inc(rwsem_opt_nospin);
+				break;
+			}
+		}
+
 		/*
 		 * An RT task cannot do optimistic spinning if it cannot
 		 * be sure the lock holder is running or live-lock may
@@ -690,8 +814,25 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock)
 	lockevent_cond_inc(rwsem_opt_fail, !taken);
 	return taken;
 }
+
+/*
+ * Clear the owner's RWSEM_WR_NONSPINNABLE bit if it is set. This should
+ * only be called when the reader count reaches 0.
+ *
+ * This give writers better chance to acquire the rwsem first before
+ * readers when the rwsem was being held by readers for a relatively long
+ * period of time. Race can happen that an optimistic spinner may have
+ * just stolen the rwsem and set the owner, but just clearing the
+ * RWSEM_WR_NONSPINNABLE bit will do no harm anyway.
+ */
+static inline void clear_wr_nonspinnable(struct rw_semaphore *sem)
+{
+	if (!is_rwsem_spinnable(sem, true))
+		atomic_long_andnot(RWSEM_WR_NONSPINNABLE,
+				  (atomic_long_t *)&sem->owner);
+}
 #else
-static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
+static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem, bool wr)
 {
 	return false;
 }
@@ -700,6 +841,8 @@ static inline bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock)
 {
 	return false;
 }
+
+static inline void clear_wr_nonspinnable(struct rw_semaphore *sem) { }
 #endif
 
 /*
@@ -709,10 +852,11 @@ static struct rw_semaphore __sched *
 rwsem_down_read_slowpath(struct rw_semaphore *sem, int state)
 {
 	long count, adjustment = -RWSEM_READER_BIAS;
+	bool wake = false;
 	struct rwsem_waiter waiter;
 	DEFINE_WAKE_Q(wake_q);
 
-	if (!rwsem_can_spin_on_owner(sem))
+	if (!rwsem_can_spin_on_owner(sem, false))
 		goto queue;
 
 	/*
@@ -772,8 +916,12 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state)
 	 * If there are no writers and we are first in the queue,
 	 * wake our own waiter to join the existing active readers !
 	 */
-	if (!(count & RWSEM_LOCK_MASK) ||
-	   (!(count & RWSEM_WRITER_MASK) && (adjustment & RWSEM_FLAG_WAITERS)))
+	if (!(count & RWSEM_LOCK_MASK)) {
+		clear_wr_nonspinnable(sem);
+		wake = true;
+	}
+	if (wake || (!(count & RWSEM_WRITER_MASK) &&
+		    (adjustment & RWSEM_FLAG_WAITERS)))
 		__rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
 
 	raw_spin_unlock_irq(&sem->wait_lock);
@@ -823,7 +971,7 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 	DEFINE_WAKE_Q(wake_q);
 
 	/* do optimistic spinning and steal lock if possible */
-	if (rwsem_can_spin_on_owner(sem) &&
+	if (rwsem_can_spin_on_owner(sem, true) &&
 	    rwsem_optimistic_spin(sem, true))
 		return sem;
 
@@ -1093,8 +1241,10 @@ inline void __up_read(struct rw_semaphore *sem)
 	rwsem_clear_reader_owned(sem);
 	tmp = atomic_long_add_return_release(-RWSEM_READER_BIAS, &sem->count);
 	if (unlikely((tmp & (RWSEM_LOCK_MASK|RWSEM_FLAG_WAITERS)) ==
-		      RWSEM_FLAG_WAITERS))
+		      RWSEM_FLAG_WAITERS)) {
+		clear_wr_nonspinnable(sem);
 		rwsem_wake(sem, tmp);
+	}
 }
 
 /*
@@ -1130,7 +1280,7 @@ static inline void __downgrade_write(struct rw_semaphore *sem)
 	 * read-locked region is ok to be re-ordered into the
 	 * write side. As such, rely on RELEASE semantics.
 	 */
-	DEBUG_RWSEMS_WARN_ON(sem->owner != current, sem);
+	DEBUG_RWSEMS_WARN_ON(owner_without_flags(sem->owner) != current, sem);
 	tmp = atomic_long_fetch_add_release(
 		-RWSEM_WRITER_LOCKED+RWSEM_READER_BIAS, &sem->count);
 	rwsem_set_reader_owned(sem);
-- 
2.18.1

