Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72276C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C0622173C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfETVAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 17:00:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48038 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727074AbfETVAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 17:00:14 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E56F3C04BE32;
        Mon, 20 May 2019 21:00:12 +0000 (UTC)
Received: from llong.com (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9B5F817995;
        Mon, 20 May 2019 21:00:11 +0000 (UTC)
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
Subject: [PATCH v8 13/19] locking/rwsem: Make rwsem->owner an atomic_long_t
Date:   Mon, 20 May 2019 16:59:12 -0400
Message-Id: <20190520205918.22251-14-longman@redhat.com>
In-Reply-To: <20190520205918.22251-1-longman@redhat.com>
References: <20190520205918.22251-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 20 May 2019 21:00:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rwsem->owner contains not just the task structure pointer, it also
holds some flags for storing the current state of the rwsem. Some of
the flags may have to be atomically updated. To reflect the new reality,
the owner is now changed to an atomic_long_t type.

New helper functions are added to properly separate out the task
structure pointer and the embedded flags.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/percpu-rwsem.h |   4 +-
 include/linux/rwsem.h        |  11 +--
 kernel/locking/rwsem.c       | 125 ++++++++++++++++++++++-------------
 3 files changed, 88 insertions(+), 52 deletions(-)

diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
index 03cb4b6f842e..0a43830f1932 100644
--- a/include/linux/percpu-rwsem.h
+++ b/include/linux/percpu-rwsem.h
@@ -117,7 +117,7 @@ static inline void percpu_rwsem_release(struct percpu_rw_semaphore *sem,
 	lock_release(&sem->rw_sem.dep_map, 1, ip);
 #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
 	if (!read)
-		sem->rw_sem.owner = RWSEM_OWNER_UNKNOWN;
+		atomic_long_set(&sem->rw_sem.owner, RWSEM_OWNER_UNKNOWN);
 #endif
 }
 
@@ -127,7 +127,7 @@ static inline void percpu_rwsem_acquire(struct percpu_rw_semaphore *sem,
 	lock_acquire(&sem->rw_sem.dep_map, 0, 1, read, 1, NULL, ip);
 #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
 	if (!read)
-		sem->rw_sem.owner = current;
+		atomic_long_set(&sem->rw_sem.owner, (long)current);
 #endif
 }
 
diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index bb76e82398b2..e401358c4e7e 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -35,10 +35,11 @@
 struct rw_semaphore {
 	atomic_long_t count;
 	/*
-	 * Write owner or one of the read owners. Can be used as a
-	 * speculative check to see if the owner is running on the cpu.
+	 * Write owner or one of the read owners as well flags regarding
+	 * the current state of the rwsem. Can be used as a speculative
+	 * check to see if the write owner is running on the cpu.
 	 */
-	struct task_struct *owner;
+	atomic_long_t owner;
 #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
 	struct optimistic_spin_queue osq; /* spinner MCS lock */
 #endif
@@ -53,7 +54,7 @@ struct rw_semaphore {
  * Setting all bits of the owner field except bit 0 will indicate
  * that the rwsem is writer-owned with an unknown owner.
  */
-#define RWSEM_OWNER_UNKNOWN	((struct task_struct *)-2L)
+#define RWSEM_OWNER_UNKNOWN	(-2L)
 
 /* In all implementations count != 0 means locked */
 static inline int rwsem_is_locked(struct rw_semaphore *sem)
@@ -80,7 +81,7 @@ static inline int rwsem_is_locked(struct rw_semaphore *sem)
 
 #define __RWSEM_INITIALIZER(name)				\
 	{ __RWSEM_INIT_COUNT(name),				\
-	  .owner = NULL,					\
+	  .owner = ATOMIC_LONG_INIT(0),				\
 	  .wait_list = LIST_HEAD_INIT((name).wait_list),	\
 	  .wait_lock = __RAW_SPIN_LOCK_UNLOCKED(name.wait_lock)	\
 	  __RWSEM_OPT_INIT(name)				\
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 9eb46ab9edaa..555da4868e54 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -64,7 +64,7 @@
 	if (!debug_locks_silent &&				\
 	    WARN_ONCE(c, "DEBUG_RWSEMS_WARN_ON(%s): count = 0x%lx, owner = 0x%lx, curr 0x%lx, list %sempty\n",\
 		#c, atomic_long_read(&(sem)->count),		\
-		(long)((sem)->owner), (long)current,		\
+		atomic_long_read(&(sem)->owner), (long)current,	\
 		list_empty(&(sem)->wait_list) ? "" : "not "))	\
 			debug_locks_off();			\
 	} while (0)
@@ -114,12 +114,20 @@
  */
 static inline void rwsem_set_owner(struct rw_semaphore *sem)
 {
-	WRITE_ONCE(sem->owner, current);
+	atomic_long_set(&sem->owner, (long)current);
 }
 
 static inline void rwsem_clear_owner(struct rw_semaphore *sem)
 {
-	WRITE_ONCE(sem->owner, NULL);
+	atomic_long_set(&sem->owner, 0);
+}
+
+/*
+ * Test the flags in the owner field.
+ */
+static inline bool rwsem_test_oflags(struct rw_semaphore *sem, long flags)
+{
+	return atomic_long_read(&sem->owner) & flags;
 }
 
 /*
@@ -133,10 +141,9 @@ static inline void rwsem_clear_owner(struct rw_semaphore *sem)
 static inline void __rwsem_set_reader_owned(struct rw_semaphore *sem,
 					    struct task_struct *owner)
 {
-	unsigned long val = (unsigned long)owner | RWSEM_READER_OWNED
-						 | RWSEM_NONSPINNABLE;
+	long val = (long)owner | RWSEM_READER_OWNED | RWSEM_NONSPINNABLE;
 
-	WRITE_ONCE(sem->owner, (struct task_struct *)val);
+	atomic_long_set(&sem->owner, val);
 }
 
 static inline void rwsem_set_reader_owned(struct rw_semaphore *sem)
@@ -145,13 +152,20 @@ static inline void rwsem_set_reader_owned(struct rw_semaphore *sem)
 }
 
 /*
- * Return true if the a rwsem waiter can spin on the rwsem's owner
- * and steal the lock.
- * N.B. !owner is considered spinnable.
+ * Return true if the rwsem is owned by a reader.
  */
-static inline bool is_rwsem_owner_spinnable(struct task_struct *owner)
+static inline bool is_rwsem_reader_owned(struct rw_semaphore *sem)
 {
-	return !((unsigned long)owner & RWSEM_NONSPINNABLE);
+#ifdef CONFIG_DEBUG_RWSEMS
+	/*
+	 * Check the count to see if it is write-locked.
+	 */
+	long count = atomic_long_read(&sem->count);
+
+	if (count & RWSEM_WRITER_MASK)
+		return false;
+#endif
+	return rwsem_test_oflags(sem, RWSEM_READER_OWNED);
 }
 
 #ifdef CONFIG_DEBUG_RWSEMS
@@ -163,11 +177,13 @@ static inline bool is_rwsem_owner_spinnable(struct task_struct *owner)
  */
 static inline void rwsem_clear_reader_owned(struct rw_semaphore *sem)
 {
-	unsigned long val = (unsigned long)current | RWSEM_READER_OWNED
-						   | RWSEM_NONSPINNABLE;
-	if (READ_ONCE(sem->owner) == (struct task_struct *)val)
-		cmpxchg_relaxed((unsigned long *)&sem->owner, val,
-				RWSEM_READER_OWNED | RWSEM_NONSPINNABLE);
+	long val = atomic_long_read(&sem->owner);
+
+	while ((val & ~RWSEM_OWNER_FLAGS_MASK) == (long)current) {
+		if (atomic_long_try_cmpxchg(&sem->owner, &val,
+					    val & RWSEM_OWNER_FLAGS_MASK))
+			return;
+	}
 }
 #else
 static inline void rwsem_clear_reader_owned(struct rw_semaphore *sem)
@@ -175,6 +191,28 @@ static inline void rwsem_clear_reader_owned(struct rw_semaphore *sem)
 }
 #endif
 
+/*
+ * Return just the real task structure pointer of the owner
+ */
+static inline struct task_struct *rwsem_read_owner(struct rw_semaphore *sem)
+{
+	return (struct task_struct *)(atomic_long_read(&sem->owner) &
+					~RWSEM_OWNER_FLAGS_MASK);
+}
+
+/*
+ * Return the real task structure pointer of the owner and the embedded
+ * flags in the owner. pflags must be non-NULL.
+ */
+static inline struct task_struct *
+rwsem_read_owner_flags(struct rw_semaphore *sem, long *pflags)
+{
+	long owner = atomic_long_read(&sem->owner);
+
+	*pflags = owner & RWSEM_OWNER_FLAGS_MASK;
+	return (struct task_struct *)(owner & ~RWSEM_OWNER_FLAGS_MASK);
+}
+
 /*
  * Guide to the rw_semaphore's count field.
  *
@@ -208,7 +246,7 @@ void __init_rwsem(struct rw_semaphore *sem, const char *name,
 	atomic_long_set(&sem->count, RWSEM_UNLOCKED_VALUE);
 	raw_spin_lock_init(&sem->wait_lock);
 	INIT_LIST_HEAD(&sem->wait_list);
-	sem->owner = NULL;
+	atomic_long_set(&sem->owner, 0L);
 #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
 	osq_lock_init(&sem->osq);
 #endif
@@ -511,9 +549,10 @@ static inline bool owner_on_cpu(struct task_struct *owner)
 static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 {
 	struct task_struct *owner;
+	long flags;
 	bool ret = true;
 
-	BUILD_BUG_ON(is_rwsem_owner_spinnable(RWSEM_OWNER_UNKNOWN));
+	BUILD_BUG_ON(!(RWSEM_OWNER_UNKNOWN & RWSEM_NONSPINNABLE));
 
 	if (need_resched()) {
 		lockevent_inc(rwsem_opt_fail);
@@ -522,11 +561,9 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 
 	preempt_disable();
 	rcu_read_lock();
-	owner = READ_ONCE(sem->owner);
-	if (owner) {
-		ret = is_rwsem_owner_spinnable(owner) &&
-		      owner_on_cpu(owner);
-	}
+	owner = rwsem_read_owner_flags(sem, &flags);
+	if ((flags & RWSEM_NONSPINNABLE) || (owner && !owner_on_cpu(owner)))
+		ret = false;
 	rcu_read_unlock();
 	preempt_enable();
 
@@ -553,25 +590,26 @@ enum owner_state {
 };
 #define OWNER_SPINNABLE		(OWNER_NULL | OWNER_WRITER)
 
-static inline enum owner_state rwsem_owner_state(unsigned long owner)
+static inline enum owner_state rwsem_owner_state(struct task_struct *owner,
+						 long flags)
 {
-	if (!owner)
-		return OWNER_NULL;
-
-	if (owner & RWSEM_NONSPINNABLE)
+	if (flags & RWSEM_NONSPINNABLE)
 		return OWNER_NONSPINNABLE;
 
-	if (owner & RWSEM_READER_OWNED)
+	if (flags & RWSEM_READER_OWNED)
 		return OWNER_READER;
 
-	return OWNER_WRITER;
+	return owner ? OWNER_WRITER : OWNER_NULL;
 }
 
 static noinline enum owner_state rwsem_spin_on_owner(struct rw_semaphore *sem)
 {
-	struct task_struct *tmp, *owner = READ_ONCE(sem->owner);
-	enum owner_state state = rwsem_owner_state((unsigned long)owner);
+	struct task_struct *new, *owner;
+	long flags, new_flags;
+	enum owner_state state;
 
+	owner = rwsem_read_owner_flags(sem, &flags);
+	state = rwsem_owner_state(owner, flags);
 	if (state != OWNER_WRITER)
 		return state;
 
@@ -582,9 +620,9 @@ static noinline enum owner_state rwsem_spin_on_owner(struct rw_semaphore *sem)
 			break;
 		}
 
-		tmp = READ_ONCE(sem->owner);
-		if (tmp != owner) {
-			state = rwsem_owner_state((unsigned long)tmp);
+		new = rwsem_read_owner_flags(sem, &new_flags);
+		if ((new != owner) || (new_flags != flags)) {
+			state = rwsem_owner_state(new, new_flags);
 			break;
 		}
 
@@ -1001,8 +1039,7 @@ inline void __down_read(struct rw_semaphore *sem)
 	if (unlikely(atomic_long_fetch_add_acquire(RWSEM_READER_BIAS,
 			&sem->count) & RWSEM_READ_FAILED_MASK)) {
 		rwsem_down_read_slowpath(sem, TASK_UNINTERRUPTIBLE);
-		DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner &
-					RWSEM_READER_OWNED), sem);
+		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
 	} else {
 		rwsem_set_reader_owned(sem);
 	}
@@ -1014,8 +1051,7 @@ static inline int __down_read_killable(struct rw_semaphore *sem)
 			&sem->count) & RWSEM_READ_FAILED_MASK)) {
 		if (IS_ERR(rwsem_down_read_slowpath(sem, TASK_KILLABLE)))
 			return -EINTR;
-		DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner &
-					RWSEM_READER_OWNED), sem);
+		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
 	} else {
 		rwsem_set_reader_owned(sem);
 	}
@@ -1084,7 +1120,7 @@ inline void __up_read(struct rw_semaphore *sem)
 {
 	long tmp;
 
-	DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner & RWSEM_READER_OWNED), sem);
+	DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
 	rwsem_clear_reader_owned(sem);
 	tmp = atomic_long_add_return_release(-RWSEM_READER_BIAS, &sem->count);
 	if (unlikely((tmp & (RWSEM_LOCK_MASK|RWSEM_FLAG_WAITERS)) ==
@@ -1103,8 +1139,8 @@ static inline void __up_write(struct rw_semaphore *sem)
 	 * sem->owner may differ from current if the ownership is transferred
 	 * to an anonymous writer by setting the RWSEM_NONSPINNABLE bits.
 	 */
-	DEBUG_RWSEMS_WARN_ON((sem->owner != current) &&
-			    !((long)sem->owner & RWSEM_NONSPINNABLE), sem);
+	DEBUG_RWSEMS_WARN_ON((rwsem_read_owner(sem) != current) &&
+			    !rwsem_test_oflags(sem, RWSEM_NONSPINNABLE), sem);
 	rwsem_clear_owner(sem);
 	tmp = atomic_long_fetch_add_release(-RWSEM_WRITER_LOCKED, &sem->count);
 	if (unlikely(tmp & RWSEM_FLAG_WAITERS))
@@ -1125,7 +1161,7 @@ static inline void __downgrade_write(struct rw_semaphore *sem)
 	 * read-locked region is ok to be re-ordered into the
 	 * write side. As such, rely on RELEASE semantics.
 	 */
-	DEBUG_RWSEMS_WARN_ON(sem->owner != current, sem);
+	DEBUG_RWSEMS_WARN_ON(rwsem_read_owner(sem) != current, sem);
 	tmp = atomic_long_fetch_add_release(
 		-RWSEM_WRITER_LOCKED+RWSEM_READER_BIAS, &sem->count);
 	rwsem_set_reader_owned(sem);
@@ -1296,8 +1332,7 @@ EXPORT_SYMBOL(down_write_killable_nested);
 
 void up_read_non_owner(struct rw_semaphore *sem)
 {
-	DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner & RWSEM_READER_OWNED),
-				sem);
+	DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
 	__up_read(sem);
 }
 EXPORT_SYMBOL(up_read_non_owner);
-- 
2.18.1

