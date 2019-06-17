Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC96C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD342086A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="EWxnrhmT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbfFQOdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:33:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57581 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfFQOdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:33:20 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HEWjn93457522
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 07:32:45 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HEWjn93457522
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560781965;
        bh=UPFEAStcjVczsRXvnyXpk1/9C2jINFhSYkFctyh4pgc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=EWxnrhmTg48vuue8BZs1RIadyMB3UAbuiA4hN4MOZ/UXjISN2mZ7G/s72yKZVzbFC
         jKLzkM8tlo1TP/E+J9Xl0ZahhLcwNsJ+H0y7t1RW8GfVsGyfjxFYtVVMmEAitL4sIe
         AUsgeYjyHen0ZJjsw5ZAX1I5p0zE2Iu7pW86Mi2nbD96HH4uvtPK8zVrRny/pkfAYM
         E/Sfrs07GnPx5ucMwit567iMi1U9t8qnTlxVo6KS+Nhu//HEtlPf9x7KQY7npSVVzw
         /S+IxbthE/3SsxO/eViFQbqw1a0X+iSLJU91li/P+AN7q43t/O9hL/nVK6ykO3rC7i
         K6nWtMZra10iw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HEWioS3457519;
        Mon, 17 Jun 2019 07:32:44 -0700
Date:   Mon, 17 Jun 2019 07:32:44 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-7d43f1ce9dd075d8b2aa3ad1f3970ef386a5c358@git.kernel.org>
Cc:     torvalds@linux-foundation.org, mingo@kernel.org,
        will.deacon@arm.com, bp@alien8.de, longman@redhat.com,
        huang.ying.caritas@gmail.com, tim.c.chen@linux.intel.com,
        hpa@zytor.com, peterz@infradead.org, dave@stgolabs.net,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
          dave@stgolabs.net, hpa@zytor.com, peterz@infradead.org,
          tim.c.chen@linux.intel.com, huang.ying.caritas@gmail.com,
          longman@redhat.com, bp@alien8.de, will.deacon@arm.com,
          mingo@kernel.org, torvalds@linux-foundation.org
In-Reply-To: <20190520205918.22251-15-longman@redhat.com>
References: <20190520205918.22251-15-longman@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/rwsem: Enable time-based spinning on
 reader-owned rwsem
Git-Commit-ID: 7d43f1ce9dd075d8b2aa3ad1f3970ef386a5c358
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  7d43f1ce9dd075d8b2aa3ad1f3970ef386a5c358
Gitweb:     https://git.kernel.org/tip/7d43f1ce9dd075d8b2aa3ad1f3970ef386a5c358
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Mon, 20 May 2019 16:59:13 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 17 Jun 2019 12:28:07 +0200

locking/rwsem: Enable time-based spinning on reader-owned rwsem

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: huang ying <huang.ying.caritas@gmail.com>
Link: https://lkml.kernel.org/r/20190520205918.22251-15-longman@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lock_events_list.h |   1 +
 kernel/locking/rwsem.c            | 173 +++++++++++++++++++++++++++++++-------
 2 files changed, 144 insertions(+), 30 deletions(-)

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
index fae557be8334..2d7cabcfca50 100644
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
@@ -141,7 +148,7 @@ static inline bool rwsem_test_oflags(struct rw_semaphore *sem, long flags)
 static inline void __rwsem_set_reader_owned(struct rw_semaphore *sem,
 					    struct task_struct *owner)
 {
-	unsigned long val = (unsigned long)owner | RWSEM_READER_OWNED | RWSEM_NONSPINNABLE;
+	unsigned long val = (unsigned long)owner | RWSEM_READER_OWNED;
 
 	atomic_long_set(&sem->owner, val);
 }
@@ -191,6 +198,23 @@ static inline void rwsem_clear_reader_owned(struct rw_semaphore *sem)
 }
 #endif
 
+/*
+ * Set the RWSEM_NONSPINNABLE bits if the RWSEM_READER_OWNED flag
+ * remains set. Otherwise, the operation will be aborted.
+ */
+static inline void rwsem_set_nonspinnable(struct rw_semaphore *sem)
+{
+	unsigned long owner = atomic_long_read(&sem->owner);
+
+	do {
+		if (!(owner & RWSEM_READER_OWNED))
+			break;
+		if (owner & RWSEM_NONSPINNABLE)
+			break;
+	} while (!atomic_long_try_cmpxchg(&sem->owner, &owner,
+					  owner | RWSEM_NONSPINNABLE));
+}
+
 /*
  * Return just the real task structure pointer of the owner
  */
@@ -546,7 +570,8 @@ static inline bool owner_on_cpu(struct task_struct *owner)
 	return owner->on_cpu && !vcpu_is_preempted(task_cpu(owner));
 }
 
-static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
+static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem,
+					   unsigned long nonspinnable)
 {
 	struct task_struct *owner;
 	unsigned long flags;
@@ -562,7 +587,7 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 	preempt_disable();
 	rcu_read_lock();
 	owner = rwsem_owner_flags(sem, &flags);
-	if ((flags & RWSEM_NONSPINNABLE) || (owner && !owner_on_cpu(owner)))
+	if ((flags & nonspinnable) || (owner && !owner_on_cpu(owner)))
 		ret = false;
 	rcu_read_unlock();
 	preempt_enable();
@@ -588,12 +613,12 @@ enum owner_state {
 	OWNER_READER		= 1 << 2,
 	OWNER_NONSPINNABLE	= 1 << 3,
 };
-#define OWNER_SPINNABLE		(OWNER_NULL | OWNER_WRITER)
+#define OWNER_SPINNABLE		(OWNER_NULL | OWNER_WRITER | OWNER_READER)
 
 static inline enum owner_state
-rwsem_owner_state(struct task_struct *owner, unsigned long flags)
+rwsem_owner_state(struct task_struct *owner, unsigned long flags, unsigned long nonspinnable)
 {
-	if (flags & RWSEM_NONSPINNABLE)
+	if (flags & nonspinnable)
 		return OWNER_NONSPINNABLE;
 
 	if (flags & RWSEM_READER_OWNED)
@@ -602,14 +627,15 @@ rwsem_owner_state(struct task_struct *owner, unsigned long flags)
 	return owner ? OWNER_WRITER : OWNER_NULL;
 }
 
-static noinline enum owner_state rwsem_spin_on_owner(struct rw_semaphore *sem)
+static noinline enum owner_state
+rwsem_spin_on_owner(struct rw_semaphore *sem, unsigned long nonspinnable)
 {
 	struct task_struct *new, *owner;
 	unsigned long flags, new_flags;
 	enum owner_state state;
 
 	owner = rwsem_owner_flags(sem, &flags);
-	state = rwsem_owner_state(owner, flags);
+	state = rwsem_owner_state(owner, flags, nonspinnable);
 	if (state != OWNER_WRITER)
 		return state;
 
@@ -622,7 +648,7 @@ static noinline enum owner_state rwsem_spin_on_owner(struct rw_semaphore *sem)
 
 		new = rwsem_owner_flags(sem, &new_flags);
 		if ((new != owner) || (new_flags != flags)) {
-			state = rwsem_owner_state(new, new_flags);
+			state = rwsem_owner_state(new, new_flags, nonspinnable);
 			break;
 		}
 
@@ -646,10 +672,39 @@ static noinline enum owner_state rwsem_spin_on_owner(struct rw_semaphore *sem)
 	return state;
 }
 
+/*
+ * Calculate reader-owned rwsem spinning threshold for writer
+ *
+ * The more readers own the rwsem, the longer it will take for them to
+ * wind down and free the rwsem. So the empirical formula used to
+ * determine the actual spinning time limit here is:
+ *
+ *   Spinning threshold = (10 + nr_readers/2)us
+ *
+ * The limit is capped to a maximum of 25us (30 readers). This is just
+ * a heuristic and is subjected to change in the future.
+ */
+static inline u64 rwsem_rspin_threshold(struct rw_semaphore *sem)
+{
+	long count = atomic_long_read(&sem->count);
+	int readers = count >> RWSEM_READER_SHIFT;
+	u64 delta;
+
+	if (readers > 30)
+		readers = 30;
+	delta = (20 + readers) * NSEC_PER_USEC / 2;
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
+	unsigned long nonspinnable = wlock ? RWSEM_WR_NONSPINNABLE
+					   : RWSEM_RD_NONSPINNABLE;
 
 	preempt_disable();
 
@@ -661,12 +716,12 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock)
 	 * Optimistically spin on the owner field and attempt to acquire the
 	 * lock whenever the owner changes. Spinning will be stopped when:
 	 *  1) the owning writer isn't running; or
-	 *  2) readers own the lock as we can't determine if they are
-	 *     actively running or not.
+	 *  2) readers own the lock and spinning time has exceeded limit.
 	 */
 	for (;;) {
-		enum owner_state owner_state = rwsem_spin_on_owner(sem);
+		enum owner_state owner_state;
 
+		owner_state = rwsem_spin_on_owner(sem, nonspinnable);
 		if (!(owner_state & OWNER_SPINNABLE))
 			break;
 
@@ -679,6 +734,38 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock)
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
+				if (rwsem_test_oflags(sem, nonspinnable))
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
+			else if (!(++loop & 0xf) && (sched_clock() > rspin_threshold)) {
+				rwsem_set_nonspinnable(sem);
+				lockevent_inc(rwsem_opt_nospin);
+				break;
+			}
+		}
+
 		/*
 		 * An RT task cannot do optimistic spinning if it cannot
 		 * be sure the lock holder is running or live-lock may
@@ -733,8 +820,25 @@ done:
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
+	if (rwsem_test_oflags(sem, RWSEM_WR_NONSPINNABLE))
+		atomic_long_andnot(RWSEM_WR_NONSPINNABLE, &sem->owner);
+}
 #else
-static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
+static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem,
+					   unsigned long nonspinnable)
 {
 	return false;
 }
@@ -743,6 +847,8 @@ static inline bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock)
 {
 	return false;
 }
+
+static inline void clear_wr_nonspinnable(struct rw_semaphore *sem) { }
 #endif
 
 /*
@@ -752,10 +858,11 @@ static struct rw_semaphore __sched *
 rwsem_down_read_slowpath(struct rw_semaphore *sem, int state)
 {
 	long count, adjustment = -RWSEM_READER_BIAS;
+	bool wake = false;
 	struct rwsem_waiter waiter;
 	DEFINE_WAKE_Q(wake_q);
 
-	if (!rwsem_can_spin_on_owner(sem))
+	if (!rwsem_can_spin_on_owner(sem, RWSEM_RD_NONSPINNABLE))
 		goto queue;
 
 	/*
@@ -815,8 +922,12 @@ queue:
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
 		rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
 
 	raw_spin_unlock_irq(&sem->wait_lock);
@@ -866,7 +977,7 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 	DEFINE_WAKE_Q(wake_q);
 
 	/* do optimistic spinning and steal lock if possible */
-	if (rwsem_can_spin_on_owner(sem) &&
+	if (rwsem_can_spin_on_owner(sem, RWSEM_WR_NONSPINNABLE) &&
 	    rwsem_optimistic_spin(sem, true))
 		return sem;
 
@@ -1124,8 +1235,10 @@ inline void __up_read(struct rw_semaphore *sem)
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
