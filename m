Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDC5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75C402082F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbfC1SMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 14:12:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42302 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727642AbfC1SMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 14:12:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1A8FB5947D;
        Thu, 28 Mar 2019 18:12:09 +0000 (UTC)
Received: from llong.com (dhcp-17-19.bos.redhat.com [10.18.17.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 16D6B5D71A;
        Thu, 28 Mar 2019 18:12:08 +0000 (UTC)
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
Subject: [PATCH 08/12] locking/rwsem: Enable count-based spinning on reader
Date:   Thu, 28 Mar 2019 14:11:02 -0400
Message-Id: <20190328181106.22887-9-longman@redhat.com>
In-Reply-To: <20190328181106.22887-1-longman@redhat.com>
References: <20190328181106.22887-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 28 Mar 2019 18:12:09 +0000 (UTC)
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
rwsem. It is a loop count threshold based spinning where the count will
get reset whenenver the rwsem reader count value changes indicating
that the rwsem is still active. There is another maximum count value
that limits that maximum number of spinnings that can happen.

When the loop or max counts reach 0, a bit will be set in the owner
field to indicate that no more optimistic spinning should be done on
this rwsem until it becomes writer owned again. Not even readers
is allowed to acquire the reader-locked rwsem for better fairness.

The spinning threshold and maximum values can be overridden by
architecture specific header file, if necessary. The current default
threshold value is 512 iterations.

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
 kernel/locking/rwsem-xadd.c       | 62 ++++++++++++++++++++++++++++---
 kernel/locking/rwsem.h            | 45 +++++++++++++++++-----
 3 files changed, 93 insertions(+), 15 deletions(-)

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
index 333bb82efc46..71253d63c206 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -88,6 +88,22 @@ enum rwsem_wake_type {
  */
 #define RWSEM_WAIT_TIMEOUT	((HZ - 1)/200 + 1)
 
+/*
+ * Reader-owned rwsem spinning threshold and maximum value
+ *
+ * This threshold and maximum values can be overridden by architecture
+ * specific value. The loop count will be reset whenenver the rwsem count
+ * value changes. The max value constrains the total number of reader-owned
+ * lock spinnings that can happen.
+ */
+#ifdef	ARCH_RWSEM_RSPIN_THRESHOLD
+# define RWSEM_RSPIN_THRESHOLD	ARCH_RWSEM_RSPIN_THRESHOLD
+# define RWSEM_RSPIN_MAX	ARCH_RWSEM_RSPIN_MAX
+#else
+# define RWSEM_RSPIN_THRESHOLD	(1 << 9)
+# define RWSEM_RSPIN_MAX	(1 << 12)
+#endif
+
 /*
  * We limit the maximum number of readers that can be woken up for a
  * wake-up call to not penalizing the waking thread for spending too
@@ -314,7 +330,7 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 	owner = READ_ONCE(sem->owner);
 	if (owner) {
 		ret = is_rwsem_owner_spinnable(owner) &&
-		      owner_on_cpu(owner);
+		     (is_rwsem_owner_reader(owner) || owner_on_cpu(owner));
 	}
 	rcu_read_unlock();
 	preempt_enable();
@@ -339,7 +355,7 @@ enum owner_state {
 	OWNER_READER		= 1 << 2,
 	OWNER_NONSPINNABLE	= 1 << 3,
 };
-#define OWNER_SPINNABLE		(OWNER_NULL | OWNER_WRITER)
+#define OWNER_SPINNABLE		(OWNER_NULL | OWNER_WRITER | OWNER_READER)
 
 static noinline enum owner_state rwsem_spin_on_owner(struct rw_semaphore *sem)
 {
@@ -350,7 +366,8 @@ static noinline enum owner_state rwsem_spin_on_owner(struct rw_semaphore *sem)
 		return OWNER_NONSPINNABLE;
 
 	rcu_read_lock();
-	while (owner && (READ_ONCE(sem->owner) == owner)) {
+	while (owner && !is_rwsem_owner_reader(owner)
+		     && (READ_ONCE(sem->owner) == owner)) {
 		/*
 		 * Ensure we emit the owner->on_cpu, dereference _after_
 		 * checking sem->owner still matches owner, if that fails,
@@ -394,6 +411,9 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock)
 	bool taken = false;
 	bool prev_not_writer = false;
 	bool is_rt_task = rt_task(current);
+	int rspin_cnt = RWSEM_RSPIN_THRESHOLD;
+	int rspin_max = RWSEM_RSPIN_MAX;
+	int old_rcount = 0;
 
 	preempt_disable();
 
@@ -401,12 +421,14 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock)
 	if (!osq_lock(&sem->osq))
 		goto done;
 
+	if (!is_rwsem_spinnable(sem))
+		rspin_cnt = 0;
+
 	/*
 	 * Optimistically spin on the owner field and attempt to acquire the
 	 * lock whenever the owner changes. Spinning will be stopped when:
 	 *  1) the owning writer isn't running; or
-	 *  2) readers own the lock as we can't determine if they are
-	 *     actively running or not.
+	 *  2) readers own the lock and spinning count has reached 0.
 	 */
 	for (;;) {
 		enum owner_state owner_state = rwsem_spin_on_owner(sem);
@@ -423,6 +445,36 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock)
 		if (taken)
 			break;
 
+		/*
+		 * We only decremnt rspin_cnt when a writer is trying to
+		 * acquire a lock owned by readers. In which case,
+		 * rwsem_spin_on_owner() will essentially be a no-op
+		 * and we will be spinning in this main loop. The spinning
+		 * count will be reset whenever the rwsem count value
+		 * changes.
+		 */
+		if (wlock && (owner_state == OWNER_READER)) {
+			int rcount;
+
+			if (!rspin_cnt || !rspin_max) {
+				if (is_rwsem_spinnable(sem)) {
+					rwsem_set_nonspinnable(sem);
+					lockevent_inc(rwsem_opt_nospin);
+				}
+				break;
+			}
+
+			rcount = atomic_long_read(&sem->count)
+					>> RWSEM_READER_SHIFT;
+			if (rcount != old_rcount) {
+				old_rcount = rcount;
+				rspin_cnt = RWSEM_RSPIN_THRESHOLD;
+			} else {
+				rspin_cnt--;
+			}
+			rspin_max--;
+		}
+
 		/*
 		 * An RT task cannot do optimistic spinning if it cannot
 		 * be sure the lock holder is running or live-lock may
diff --git a/kernel/locking/rwsem.h b/kernel/locking/rwsem.h
index fa119cb55a25..c711f4323a52 100644
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
@@ -99,8 +101,7 @@ static inline void rwsem_clear_owner(struct rw_semaphore *sem)
 static inline void __rwsem_set_reader_owned(struct rw_semaphore *sem,
 					    struct task_struct *owner)
 {
-	unsigned long val = (unsigned long)owner | RWSEM_READER_OWNED
-						 | RWSEM_ANONYMOUSLY_OWNED;
+	unsigned long val = (unsigned long)owner | RWSEM_READER_OWNED;
 
 	WRITE_ONCE(sem->owner, (struct task_struct *)val);
 }
@@ -125,6 +126,14 @@ static inline bool is_rwsem_owner_reader(struct task_struct *owner)
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
@@ -183,6 +192,22 @@ extern struct rw_semaphore *rwsem_down_write_failed_killable(struct rw_semaphore
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

