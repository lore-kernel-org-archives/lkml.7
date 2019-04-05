Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC53C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 19:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A052186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 19:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731911AbfDETWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 15:22:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42022 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731183AbfDETWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 15:22:20 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 80D1F8AE5D;
        Fri,  5 Apr 2019 19:22:19 +0000 (UTC)
Received: from llong.com (dhcp-17-47.bos.redhat.com [10.18.17.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E193161367;
        Fri,  5 Apr 2019 19:22:17 +0000 (UTC)
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
Subject: [PATCH-tip v2 08/12] locking/rwsem: Enable time-based spinning on reader-owned rwsem
Date:   Fri,  5 Apr 2019 15:21:11 -0400
Message-Id: <20190405192115.17416-9-longman@redhat.com>
In-Reply-To: <20190405192115.17416-1-longman@redhat.com>
References: <20190405192115.17416-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 05 Apr 2019 19:22:19 +0000 (UTC)
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

When the time threshold is exceeded, a bit will be set in the owner field
to indicate that no more optimistic spinning will be allowed on this
rwsem until it becomes writer owned again. Not even readers is allowed
to acquire the reader-locked rwsem by optimistic spinning for fairness.

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
 kernel/locking/lock_events_list.h |  1 +
 kernel/locking/rwsem-xadd.c       | 76 +++++++++++++++++++++++++++++--
 kernel/locking/rwsem.h            | 45 ++++++++++++++----
 3 files changed, 107 insertions(+), 15 deletions(-)

diff --git a/kernel/locking/lock_events_list.h b/kernel/locking/lock_events_list.h
index 333ed5fda333..f3550aa5866a 100644
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
diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index 1d61c6a5717f..bc3fd14cf354 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -19,6 +19,7 @@
 #include <linux/sched/rt.h>
 #include <linux/sched/wake_q.h>
 #include <linux/sched/debug.h>
+#include <linux/sched/clock.h>
 #include <linux/osq_lock.h>
 
 #include "rwsem.h"
@@ -314,7 +315,7 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 	owner = READ_ONCE(sem->owner);
 	if (owner) {
 		ret = is_rwsem_owner_spinnable(owner) &&
-		      owner_on_cpu(owner);
+		     (is_rwsem_owner_reader(owner) || owner_on_cpu(owner));
 	}
 	rcu_read_unlock();
 	preempt_enable();
@@ -339,7 +340,7 @@ enum owner_state {
 	OWNER_READER		= 1 << 2,
 	OWNER_NONSPINNABLE	= 1 << 3,
 };
-#define OWNER_SPINNABLE		(OWNER_NULL | OWNER_WRITER)
+#define OWNER_SPINNABLE		(OWNER_NULL | OWNER_WRITER | OWNER_READER)
 
 static noinline enum owner_state rwsem_spin_on_owner(struct rw_semaphore *sem)
 {
@@ -350,7 +351,8 @@ static noinline enum owner_state rwsem_spin_on_owner(struct rw_semaphore *sem)
 		return OWNER_NONSPINNABLE;
 
 	rcu_read_lock();
-	while (owner && (READ_ONCE(sem->owner) == owner)) {
+	while (owner && !is_rwsem_owner_reader(owner)
+		     && (READ_ONCE(sem->owner) == owner)) {
 		/*
 		 * Ensure we emit the owner->on_cpu, dereference _after_
 		 * checking sem->owner still matches owner, if that fails,
@@ -389,11 +391,47 @@ static noinline enum owner_state rwsem_spin_on_owner(struct rw_semaphore *sem)
 	return !owner ? OWNER_NULL : OWNER_READER;
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
+ * the longer it will take for them to wind down and free the rwsem. This
+ * is subjected to a maximum value of 25us.
+ *
+ * In the second case with RWSEM_FLAG_WAITERS off, new readers can join
+ * and become one of the owners. So assuming for the worst case and spin
+ * for at most 25us.
+ */
+static inline u64 rwsem_rspin_threshold(struct rw_semaphore *sem)
+{
+	long count = atomic_long_read(&sem->count);
+	int reader_cnt = atomic_long_read(&sem->count) >> RWSEM_READER_SHIFT;
+
+	if (reader_cnt > 30)
+		reader_cnt = 30;
+	return sched_clock() + ((count & RWSEM_FLAG_WAITERS)
+		? 10 * NSEC_PER_USEC + reader_cnt * NSEC_PER_USEC/2
+		: 25 * NSEC_PER_USEC);
+}
+
 static bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock)
 {
 	bool taken = false;
 	bool is_rt_task = rt_task(current);
 	int prev_owner_state = OWNER_NULL;
+	int loop = 0;
+	u64 rspin_threshold = 0;
 
 	preempt_disable();
 
@@ -405,8 +443,7 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock)
 	 * Optimistically spin on the owner field and attempt to acquire the
 	 * lock whenever the owner changes. Spinning will be stopped when:
 	 *  1) the owning writer isn't running; or
-	 *  2) readers own the lock as we can't determine if they are
-	 *     actively running or not.
+	 *  2) readers own the lock and spinning count has reached 0.
 	 */
 	for (;;) {
 		enum owner_state owner_state = rwsem_spin_on_owner(sem);
@@ -423,6 +460,35 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock)
 		if (taken)
 			break;
 
+		/*
+		 * Time-based reader-owned rwsem optimistic spinning
+		 */
+		if (wlock && (owner_state == OWNER_READER)) {
+			/*
+			 * Initialize rspin_threshold when the owner
+			 * state changes from non-reader to reader.
+			 */
+			if (prev_owner_state != OWNER_READER) {
+				if (!is_rwsem_spinnable(sem))
+					break;
+				rspin_threshold = rwsem_rspin_threshold(sem);
+				loop = 0;
+			}
+
+			/*
+			 * Check time threshold every 16 iterations to
+			 * avoid calling sched_clock() too frequently.
+			 * This will make the actual spinning time a
+			 * bit more than that specified in the threshold.
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
diff --git a/kernel/locking/rwsem.h b/kernel/locking/rwsem.h
index 0a8657fe4bc9..1398799b7547 100644
--- a/kernel/locking/rwsem.h
+++ b/kernel/locking/rwsem.h
@@ -5,18 +5,20 @@
  *  - RWSEM_READER_OWNED (bit 0): The rwsem is owned by readers
  *  - RWSEM_ANONYMOUSLY_OWNED (bit 1): The rwsem is anonymously owned,
  *    i.e. the owner(s) cannot be readily determined. It can be reader
- *    owned or the owning writer is indeterminate.
+ *    owned or the owning writer is indeterminate. Optimistic spinning
+ *    should be disabled if this flag is set.
  *
  * When a writer acquires a rwsem, it puts its task_struct pointer
- * into the owner field. It is cleared after an unlock.
+ * into the owner field or the count itself (64-bit only. It should
+ * be cleared after an unlock.
  *
  * When a reader acquires a rwsem, it will also puts its task_struct
- * pointer into the owner field with both the RWSEM_READER_OWNED and
- * RWSEM_ANONYMOUSLY_OWNED bits set. On unlock, the owner field will
- * largely be left untouched. So for a free or reader-owned rwsem,
- * the owner value may contain information about the last reader that
- * acquires the rwsem. The anonymous bit is set because that particular
- * reader may or may not still own the lock.
+ * pointer into the owner field with the RWSEM_READER_OWNED bit set.
+ * On unlock, the owner field will largely be left untouched. So
+ * for a free or reader-owned rwsem, the owner value may contain
+ * information about the last reader that acquires the rwsem. The
+ * anonymous bit may also be set to permanently disable optimistic
+ * spinning on a reader-own rwsem until a writer comes along.
  *
  * That information may be helpful in debugging cases where the system
  * seems to hang on a reader owned rwsem especially if only one reader
@@ -101,8 +103,7 @@ static inline void rwsem_clear_owner(struct rw_semaphore *sem)
 static inline void __rwsem_set_reader_owned(struct rw_semaphore *sem,
 					    struct task_struct *owner)
 {
-	unsigned long val = (unsigned long)owner | RWSEM_READER_OWNED
-						 | RWSEM_ANONYMOUSLY_OWNED;
+	unsigned long val = (unsigned long)owner | RWSEM_READER_OWNED;
 
 	WRITE_ONCE(sem->owner, (struct task_struct *)val);
 }
@@ -127,6 +128,14 @@ static inline bool is_rwsem_owner_reader(struct task_struct *owner)
 	return (unsigned long)owner & RWSEM_READER_OWNED;
 }
 
+/*
+ * Return true if the rwsem is spinnable.
+ */
+static inline bool is_rwsem_spinnable(struct rw_semaphore *sem)
+{
+	return is_rwsem_owner_spinnable(READ_ONCE(sem->owner));
+}
+
 /*
  * Return true if rwsem is owned by an anonymous writer or readers.
  */
@@ -185,6 +194,22 @@ extern struct rw_semaphore *rwsem_down_write_failed_killable(struct rw_semaphore
 extern struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem, long count);
 extern struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem);
 
+/*
+ * Set the RWSEM_ANONYMOUSLY_OWNED flag if the RWSEM_READER_OWNED flag
+ * remains set. Otherwise, the operation will be aborted.
+ */
+static inline void rwsem_set_nonspinnable(struct rw_semaphore *sem)
+{
+	long owner = (long)READ_ONCE(sem->owner);
+
+	while (is_rwsem_owner_reader((struct task_struct *)owner)) {
+		if (!is_rwsem_owner_spinnable((struct task_struct *)owner))
+			break;
+		owner = cmpxchg((long *)&sem->owner, owner,
+				owner | RWSEM_ANONYMOUSLY_OWNED);
+	}
+}
+
 /*
  * lock for reading
  */
-- 
2.18.1

