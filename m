Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8AEC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DE2B20825
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbfDOU67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 16:58:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45970 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbfDOU65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 16:58:57 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EBDA559441;
        Mon, 15 Apr 2019 20:58:56 +0000 (UTC)
Received: from llong.com (ovpn-122-46.rdu2.redhat.com [10.10.122.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 62AE919C68;
        Mon, 15 Apr 2019 20:58:55 +0000 (UTC)
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
Subject: [PATCH-tip 1/2] locking/rwsem: Clarify usage of owner's nonspinaable bit
Date:   Mon, 15 Apr 2019 16:58:28 -0400
Message-Id: <20190415205829.32707-2-longman@redhat.com>
In-Reply-To: <20190415205829.32707-1-longman@redhat.com>
References: <20190415205829.32707-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 15 Apr 2019 20:58:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bit 1 of sem->owner was previously used to designate an anonymous
owner - reader or anonymous writer. With the reader optimistic spinning
patches, bit 1 is now used to indicate that optimistic spinning should
be disabled. So change RWSEM_ANONYMOUSLY_OWNED to RWSEM_NONSPINNABLE
to clarify its current meaning.

Since we leave sem->owner unchanged when the reader unlocks, the
nonspinnable bit together with count's RWSEM_FLAG_WAITERS bit will act
like the RWSEM_FLAG_HANDOFF bit. This is too draconian for its purpose.

For fairness, we want a writer to acquire the lock after the readers
hold the lock for a relatively long time. In order to give preference
to writers under such a circumstance, the single RWSEM_NONSPINNABLE
bit is now split into two - one for reader and one for writer. When
optimistic spinning is disabled, both bits will be set. When the reader
count drop down to 0, the writer nonspinnable bit will be cleared to
allow writers to spin on the lock, but not the readers. When a writer
acquires the lock, it will write its own task structure pointer into
sem->owner and clear the reader nonspinnable bit in the process.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/rwsem.h  |   2 +-
 kernel/locking/rwsem.c | 123 ++++++++++++++++++++++++-----------------
 2 files changed, 74 insertions(+), 51 deletions(-)

diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 148983e21d47..bb76e82398b2 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -50,7 +50,7 @@ struct rw_semaphore {
 };
 
 /*
- * Setting bit 1 of the owner field but not bit 0 will indicate
+ * Setting all bits of the owner field except bit 0 will indicate
  * that the rwsem is writer-owned with an unknown owner.
  */
 #define RWSEM_OWNER_UNKNOWN	((struct task_struct *)-2L)
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 2c8187690c7c..bb75584d99e3 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -31,13 +31,19 @@
 #include "lock_events.h"
 
 /*
- * The least significant 2 bits of the owner value has the following
+ * The least significant 3 bits of the owner value has the following
  * meanings when set.
- *  - RWSEM_READER_OWNED (bit 0): The rwsem is owned by readers
- *  - RWSEM_ANONYMOUSLY_OWNED (bit 1): The rwsem is anonymously owned,
- *    i.e. the owner(s) cannot be readily determined. It can be reader
- *    owned or the owning writer is indeterminate. Optimistic spinning
- *    should be disabled if this flag is set.
+ *  - Bit 0: RWSEM_READER_OWNED - The rwsem is owned by readers
+ *  - Bit 1: RWSEM_RD_NONSPINNABLE - Readers cannot spin on this lock.
+ *  - Bit 2: RWSEM_WR_NONSPINNABLE - Writers cannot spin on this lock.
+ *
+ * When the rwsem is either owned by an anonymous writer, or it is
+ * reader-owned, but a spinning writer has timed out, both nonspinnable
+ * bits will be set to disable optimistic spinning by readers and writers.
+ * In the later case, the last unlocking reader should then check the
+ * writer nonspinnable bit and clear it only to give writers preference
+ * to acquire the lock via optimistic spinning, but not readers. Similar
+ * action is also done in the reader slowpath.
  *
  * When a writer acquires a rwsem, it puts its task_struct pointer
  * into the owner field or the count itself (64-bit only. It should
@@ -47,9 +53,7 @@
  * pointer into the owner field with the RWSEM_READER_OWNED bit set.
  * On unlock, the owner field will largely be left untouched. So
  * for a free or reader-owned rwsem, the owner value may contain
- * information about the last reader that acquires the rwsem. The
- * anonymous bit may also be set to permanently disable optimistic
- * spinning on a reader-own rwsem until a writer comes along.
+ * information about the last reader that acquires the rwsem.
  *
  * That information may be helpful in debugging cases where the system
  * seems to hang on a reader owned rwsem especially if only one reader
@@ -57,7 +61,10 @@
  * a rwsem, but the overhead is simply too big.
  */
 #define RWSEM_READER_OWNED	(1UL << 0)
-#define RWSEM_ANONYMOUSLY_OWNED	(1UL << 1)
+#define RWSEM_RD_NONSPINNABLE	(1UL << 1)
+#define RWSEM_WR_NONSPINNABLE	(1UL << 2)
+#define RWSEM_NONSPINNABLE	(RWSEM_RD_NONSPINNABLE | RWSEM_WR_NONSPINNABLE)
+#define RWSEM_OWNER_FLAGS_MASK	(RWSEM_READER_OWNED | RWSEM_NONSPINNABLE)
 
 #ifdef CONFIG_DEBUG_RWSEMS
 # define DEBUG_RWSEMS_WARN_ON(c, sem)	do {			\
@@ -219,7 +226,7 @@ static inline void rwsem_clear_owner(struct rw_semaphore *sem)
 #ifdef RWSEM_MERGE_OWNER_TO_COUNT
 /*
  * Get the owner value from count to have early access to the task structure.
- * Owner from sem->count should includes the RWSEM_ANONYMOUSLY_OWNED bit
+ * Owner from sem->count should includes the RWSEM_NONSPINNABLE bit
  * from sem->owner.
  */
 static inline struct task_struct *rwsem_get_owner(struct rw_semaphore *sem)
@@ -228,12 +235,16 @@ static inline struct task_struct *rwsem_get_owner(struct rw_semaphore *sem)
 	unsigned long sowner = (unsigned long)READ_ONCE(sem->owner);
 
 	return (struct task_struct *) (cowner
-		? cowner | (sowner & RWSEM_ANONYMOUSLY_OWNED) : sowner);
+		? cowner | (sowner & RWSEM_NONSPINNABLE) : sowner);
 }
 #else /* !RWSEM_MERGE_OWNER_TO_COUNT */
 static inline struct task_struct *rwsem_get_owner(struct rw_semaphore *sem)
 {
-	return READ_ONCE(sem->owner);
+	unsigned long owner = (unsigned long)READ_ONCE(sem->owner);
+
+	/* Clear all the flag bits for writer */
+	return (struct task_struct *)((owner & RWSEM_READER_OWNED)
+		? owner : (owner & ~RWSEM_OWNER_FLAGS_MASK));
 }
 #endif /* RWSEM_MERGE_OWNER_TO_COUNT */
 
@@ -260,15 +271,17 @@ static inline void rwsem_set_reader_owned(struct rw_semaphore *sem)
 
 /*
  * Return true if the a rwsem waiter can spin on the rwsem's owner
- * and steal the lock, i.e. the lock is not anonymously owned.
+ * and steal the lock.
  * N.B. !owner is considered spinnable.
  */
-static inline bool is_rwsem_owner_spinnable(struct task_struct *owner)
+static inline bool is_rwsem_owner_spinnable(void *owner, bool wr)
 {
-	return !((unsigned long)owner & RWSEM_ANONYMOUSLY_OWNED);
+	unsigned long bit = wr ? RWSEM_WR_NONSPINNABLE : RWSEM_RD_NONSPINNABLE;
+
+	return !((unsigned long)owner & bit);
 }
 
-static inline bool is_rwsem_owner_reader(struct task_struct *owner)
+static inline bool is_rwsem_owner_reader(void *owner)
 {
 	return (unsigned long)owner & RWSEM_READER_OWNED;
 }
@@ -276,9 +289,9 @@ static inline bool is_rwsem_owner_reader(struct task_struct *owner)
 /*
  * Return true if the rwsem is spinnable.
  */
-static inline bool is_rwsem_spinnable(struct rw_semaphore *sem)
+static inline bool is_rwsem_spinnable(struct rw_semaphore *sem, bool wr)
 {
-	return is_rwsem_owner_spinnable(READ_ONCE(sem->owner));
+	return is_rwsem_owner_spinnable(READ_ONCE(sem->owner), wr);
 }
 
 /*
@@ -298,14 +311,6 @@ static inline bool is_rwsem_reader_owned(struct rw_semaphore *sem)
 	return (unsigned long)sem->owner & RWSEM_READER_OWNED;
 }
 
-/*
- * Return true if rwsem is owned by an anonymous writer or readers.
- */
-static inline bool rwsem_has_anonymous_owner(struct task_struct *owner)
-{
-	return (unsigned long)owner & RWSEM_ANONYMOUSLY_OWNED;
-}
-
 #ifdef CONFIG_DEBUG_RWSEMS
 /*
  * With CONFIG_DEBUG_RWSEMS configured, it will make sure that if there
@@ -315,12 +320,11 @@ static inline bool rwsem_has_anonymous_owner(struct task_struct *owner)
  */
 static inline void rwsem_clear_reader_owned(struct rw_semaphore *sem)
 {
-	unsigned long val = (unsigned long)current | RWSEM_READER_OWNED
-						   | RWSEM_ANONYMOUSLY_OWNED;
+	unsigned long owner = (unsigned long)READ_ONCE(sem->owner);
 
-	if (READ_ONCE(sem->owner) == (struct task_struct *)val)
-		cmpxchg_relaxed((unsigned long *)&sem->owner, val,
-				RWSEM_READER_OWNED | RWSEM_ANONYMOUSLY_OWNED);
+	if ((owner & ~RWSEM_OWNER_FLAGS_MASK) == (unsigned long)current)
+		cmpxchg_relaxed((unsigned long *)&sem->owner, owner,
+				owner & RWSEM_OWNER_FLAGS_MASK);
 }
 #else
 static inline void rwsem_clear_reader_owned(struct rw_semaphore *sem)
@@ -329,7 +333,7 @@ static inline void rwsem_clear_reader_owned(struct rw_semaphore *sem)
 #endif
 
 /*
- * Set the RWSEM_ANONYMOUSLY_OWNED flag if the RWSEM_READER_OWNED flag
+ * Set the RWSEM_NONSPINNABLE bits if the RWSEM_READER_OWNED flag
  * remains set. Otherwise, the operation will be aborted.
  */
 static inline void rwsem_set_nonspinnable(struct rw_semaphore *sem)
@@ -337,10 +341,10 @@ static inline void rwsem_set_nonspinnable(struct rw_semaphore *sem)
 	long owner = (long)READ_ONCE(sem->owner);
 
 	while (is_rwsem_owner_reader((struct task_struct *)owner)) {
-		if (!is_rwsem_owner_spinnable((struct task_struct *)owner))
+		if (!is_rwsem_owner_spinnable((void *)owner, true))
 			break;
 		owner = cmpxchg((long *)&sem->owner, owner,
-				owner | RWSEM_ANONYMOUSLY_OWNED);
+				owner | RWSEM_NONSPINNABLE);
 	}
 }
 
@@ -649,12 +653,12 @@ static inline bool owner_on_cpu(struct task_struct *owner)
 	return owner->on_cpu && !vcpu_is_preempted(task_cpu(owner));
 }
 
-static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
+static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem, bool wr)
 {
 	struct task_struct *owner;
 	bool ret = true;
 
-	BUILD_BUG_ON(!rwsem_has_anonymous_owner(RWSEM_OWNER_UNKNOWN));
+	BUILD_BUG_ON(is_rwsem_owner_spinnable(RWSEM_OWNER_UNKNOWN, true));
 
 	if (need_resched()) {
 		lockevent_inc(rwsem_opt_fail);
@@ -665,7 +669,7 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 	rcu_read_lock();
 	owner = rwsem_get_owner(sem);
 	if (owner) {
-		ret = is_rwsem_owner_spinnable(owner) &&
+		ret = is_rwsem_owner_spinnable(owner, wr) &&
 		     (is_rwsem_owner_reader(owner) || owner_on_cpu(owner));
 	}
 	rcu_read_unlock();
@@ -693,12 +697,13 @@ enum owner_state {
 };
 #define OWNER_SPINNABLE		(OWNER_NULL | OWNER_WRITER | OWNER_READER)
 
-static noinline enum owner_state rwsem_spin_on_owner(struct rw_semaphore *sem)
+static noinline enum owner_state
+rwsem_spin_on_owner(struct rw_semaphore *sem, bool wr)
 {
 	struct task_struct *owner = rwsem_get_owner(sem);
 	long count;
 
-	if (!is_rwsem_owner_spinnable(owner))
+	if (!is_rwsem_owner_spinnable(owner, wr))
 		return OWNER_NONSPINNABLE;
 
 	rcu_read_lock();
@@ -736,7 +741,7 @@ static noinline enum owner_state rwsem_spin_on_owner(struct rw_semaphore *sem)
 	 * spinning except when here is no active locks and the handoff bit
 	 * is set. In this case, we have to stop spinning.
 	 */
-	if (!is_rwsem_owner_spinnable(owner))
+	if (!is_rwsem_owner_spinnable(owner, wr))
 		return OWNER_NONSPINNABLE;
 	if (owner && !is_rwsem_owner_reader(owner))
 		return OWNER_WRITER;
@@ -802,7 +807,7 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem, const long wlock)
 	 *  2) readers own the lock and spinning count has reached 0.
 	 */
 	for (;;) {
-		enum owner_state owner_state = rwsem_spin_on_owner(sem);
+		enum owner_state owner_state = rwsem_spin_on_owner(sem, wlock);
 
 		if (!(owner_state & OWNER_SPINNABLE))
 			break;
@@ -825,7 +830,7 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem, const long wlock)
 			 * state changes from non-reader to reader.
 			 */
 			if (prev_owner_state != OWNER_READER) {
-				if (!is_rwsem_spinnable(sem))
+				if (!is_rwsem_spinnable(sem, wlock))
 					break;
 				rspin_threshold = rwsem_rspin_threshold(sem);
 				loop = 0;
@@ -884,7 +889,7 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem, const long wlock)
 	return taken;
 }
 #else
-static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
+static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem, bool wr)
 {
 	return false;
 }
@@ -939,7 +944,7 @@ __rwsem_down_read_failed_common(struct rw_semaphore *sem, int state, long count)
 		goto queue;
 	}
 
-	if (!rwsem_can_spin_on_owner(sem))
+	if (!rwsem_can_spin_on_owner(sem, false))
 		goto queue;
 
 	/*
@@ -997,13 +1002,21 @@ __rwsem_down_read_failed_common(struct rw_semaphore *sem, int state, long count)
 
 	/*
 	 * If there are no active locks, wake the front queued process(es).
+	 * Also clear the owner's RWSEM_WR_NONSPINNABLE bit if set.
 	 *
 	 * If there are no writers and we are first in the queue,
 	 * wake our own waiter to join the existing active readers !
 	 */
-	if (!RWSEM_COUNT_LOCKED(count) ||
-	   (!(count & RWSEM_WRITER_MASK) && (adjustment & RWSEM_FLAG_WAITERS)))
+	if (!RWSEM_COUNT_LOCKED(count)) {
+		/* Clear RWSEM_WR_UNSPINNABLE bit if set */
+		if (!is_rwsem_spinnable(sem, true))
+			atomic_long_andnot(RWSEM_WR_NONSPINNABLE,
+					  (atomic_long_t *)&sem->owner);
+		__rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
+	} else if (!(count & RWSEM_WRITER_MASK) &&
+		    (adjustment & RWSEM_FLAG_WAITERS)) {
 		__rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
+	}
 
 	raw_spin_unlock_irq(&sem->wait_lock);
 	wake_up_q(&wake_q);
@@ -1064,7 +1077,7 @@ __rwsem_down_write_failed_common(struct rw_semaphore *sem, int state)
 	const long wlock = RWSEM_WRITER_LOCKED;
 
 	/* do optimistic spinning and steal lock if possible */
-	if (rwsem_can_spin_on_owner(sem) &&
+	if (rwsem_can_spin_on_owner(sem, true) &&
 	    rwsem_optimistic_spin(sem, wlock))
 		return sem;
 
@@ -1346,8 +1359,13 @@ inline void __up_read(struct rw_semaphore *sem)
 	rwsem_clear_reader_owned(sem);
 	tmp = atomic_long_add_return_release(-RWSEM_READER_BIAS, &sem->count);
 	if (unlikely((tmp & (RWSEM_LOCK_MASK|RWSEM_FLAG_WAITERS))
-			== RWSEM_FLAG_WAITERS))
+			== RWSEM_FLAG_WAITERS)) {
+		/* Clear RWSEM_WR_UNSPINNABLE bit if set */
+		if (!is_rwsem_spinnable(sem, true))
+			atomic_long_andnot(RWSEM_WR_NONSPINNABLE,
+					  (atomic_long_t *)&sem->owner);
 		rwsem_wake(sem, tmp);
+	}
 }
 
 /*
@@ -1357,7 +1375,12 @@ static inline void __up_write(struct rw_semaphore *sem)
 {
 	long tmp;
 
-	DEBUG_RWSEMS_WARN_ON(sem->owner != current, sem);
+	/*
+	 * sem->owner may differ from current if the ownership is transferred
+	 * to an anonymous writer by setting the RWSEM_NONSPINNABLE bits.
+	 */
+	DEBUG_RWSEMS_WARN_ON((sem->owner != current) &&
+			    !((long)sem->owner & RWSEM_NONSPINNABLE), sem);
 	rwsem_clear_owner(sem);
 	tmp = atomic_long_fetch_and_release(~RWSEM_WRITER_MASK, &sem->count);
 	if (unlikely(tmp & RWSEM_FLAG_WAITERS))
-- 
2.18.1

