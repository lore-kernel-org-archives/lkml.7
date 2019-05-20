Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11422C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDADD2171F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbfETVBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 17:01:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47686 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726843AbfETU76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 16:59:58 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BED85308FB9D;
        Mon, 20 May 2019 20:59:57 +0000 (UTC)
Received: from llong.com (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7E26F60BF3;
        Mon, 20 May 2019 20:59:56 +0000 (UTC)
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
Subject: [PATCH v8 05/19] locking/rwsem: Code cleanup after files merging
Date:   Mon, 20 May 2019 16:59:04 -0400
Message-Id: <20190520205918.22251-6-longman@redhat.com>
In-Reply-To: <20190520205918.22251-1-longman@redhat.com>
References: <20190520205918.22251-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 20 May 2019 20:59:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After merging all the relevant rwsem code into one single file, there
are a number of optimizations and cleanups that can be done:

 1) Remove all the EXPORT_SYMBOL() calls for functions that are not
    accessed elsewhere.
 2) Remove all the __visible tags as none of the functions will be
    called from assembly code anymore.
 3) Make all the internal functions static.
 4) Remove some unneeded blank lines.
 5) Remove the intermediate rwsem_down_{read|write}_failed*() functions
    and rename __rwsem_down_{read|write}_failed_common() to
    rwsem_down_{read|write}_slowpath().
 6) Remove "__" prefix of __rwsem_mark_wake().
 7) Use atomic_long_try_cmpxchg_acquire() as much as possible.
 8) Remove the rwsem_rtrylock and rwsem_wtrylock lock events as they
    are not that useful.

That enables the compiler to do better optimization and reduce code
size. The text+data size of rwsem.o on an x86-64 machine with gcc8 was
reduced from 10237 bytes to 5030 bytes with this change.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lock_events_list.h |   2 -
 kernel/locking/rwsem.c            | 135 ++++++++++--------------------
 2 files changed, 42 insertions(+), 95 deletions(-)

diff --git a/kernel/locking/lock_events_list.h b/kernel/locking/lock_events_list.h
index ad7668cfc9da..11187a1d40b8 100644
--- a/kernel/locking/lock_events_list.h
+++ b/kernel/locking/lock_events_list.h
@@ -61,7 +61,5 @@ LOCK_EVENT(rwsem_opt_fail)	/* # of failed opt-spinnings		*/
 LOCK_EVENT(rwsem_rlock)		/* # of read locks acquired		*/
 LOCK_EVENT(rwsem_rlock_fast)	/* # of fast read locks acquired	*/
 LOCK_EVENT(rwsem_rlock_fail)	/* # of failed read lock acquisitions	*/
-LOCK_EVENT(rwsem_rtrylock)	/* # of read trylock calls		*/
 LOCK_EVENT(rwsem_wlock)		/* # of write locks acquired		*/
 LOCK_EVENT(rwsem_wlock_fail)	/* # of failed write lock acquisitions	*/
-LOCK_EVENT(rwsem_wtrylock)	/* # of write trylock calls		*/
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 8317bcdf063b..f56329240ef1 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -205,7 +205,6 @@ void __init_rwsem(struct rw_semaphore *sem, const char *name,
 	osq_lock_init(&sem->osq);
 #endif
 }
-
 EXPORT_SYMBOL(__init_rwsem);
 
 enum rwsem_waiter_type {
@@ -237,9 +236,9 @@ enum rwsem_wake_type {
  * - woken process blocks are discarded from the list after having task zeroed
  * - writers are only marked woken if downgrading is false
  */
-static void __rwsem_mark_wake(struct rw_semaphore *sem,
-			      enum rwsem_wake_type wake_type,
-			      struct wake_q_head *wake_q)
+static void rwsem_mark_wake(struct rw_semaphore *sem,
+			    enum rwsem_wake_type wake_type,
+			    struct wake_q_head *wake_q)
 {
 	struct rwsem_waiter *waiter, *tmp;
 	long oldcount, woken = 0, adjustment = 0;
@@ -330,7 +329,7 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 
 		/*
 		 * Ensure calling get_task_struct() before setting the reader
-		 * waiter to nil such that rwsem_down_read_failed() cannot
+		 * waiter to nil such that rwsem_down_read_slowpath() cannot
 		 * race with do_exit() by always holding a reference count
 		 * to the task to wakeup.
 		 */
@@ -516,8 +515,8 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 /*
  * Wait for the read lock to be granted
  */
-static inline struct rw_semaphore __sched *
-__rwsem_down_read_failed_common(struct rw_semaphore *sem, int state)
+static struct rw_semaphore __sched *
+rwsem_down_read_slowpath(struct rw_semaphore *sem, int state)
 {
 	long count, adjustment = -RWSEM_READER_BIAS;
 	struct rwsem_waiter waiter;
@@ -555,7 +554,7 @@ __rwsem_down_read_failed_common(struct rw_semaphore *sem, int state)
 	 */
 	if (!(count & RWSEM_LOCK_MASK) ||
 	   (!(count & RWSEM_WRITER_MASK) && (adjustment & RWSEM_FLAG_WAITERS)))
-		__rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
+		rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
 
 	raw_spin_unlock_irq(&sem->wait_lock);
 	wake_up_q(&wake_q);
@@ -589,25 +588,11 @@ __rwsem_down_read_failed_common(struct rw_semaphore *sem, int state)
 	return ERR_PTR(-EINTR);
 }
 
-__visible struct rw_semaphore * __sched
-rwsem_down_read_failed(struct rw_semaphore *sem)
-{
-	return __rwsem_down_read_failed_common(sem, TASK_UNINTERRUPTIBLE);
-}
-EXPORT_SYMBOL(rwsem_down_read_failed);
-
-__visible struct rw_semaphore * __sched
-rwsem_down_read_failed_killable(struct rw_semaphore *sem)
-{
-	return __rwsem_down_read_failed_common(sem, TASK_KILLABLE);
-}
-EXPORT_SYMBOL(rwsem_down_read_failed_killable);
-
 /*
  * Wait until we successfully acquire the write lock
  */
-static inline struct rw_semaphore *
-__rwsem_down_write_failed_common(struct rw_semaphore *sem, int state)
+static struct rw_semaphore *
+rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 {
 	long count;
 	bool waiting = true; /* any queued threads before us */
@@ -646,7 +631,7 @@ __rwsem_down_write_failed_common(struct rw_semaphore *sem, int state)
 		 */
 		if (!(count & RWSEM_WRITER_MASK) &&
 		     (count & RWSEM_READER_MASK)) {
-			__rwsem_mark_wake(sem, RWSEM_WAKE_READERS, &wake_q);
+			rwsem_mark_wake(sem, RWSEM_WAKE_READERS, &wake_q);
 			/*
 			 * The wakeup is normally called _after_ the wait_lock
 			 * is released, but given that we are proactively waking
@@ -700,7 +685,7 @@ __rwsem_down_write_failed_common(struct rw_semaphore *sem, int state)
 	if (list_empty(&sem->wait_list))
 		atomic_long_andnot(RWSEM_FLAG_WAITERS, &sem->count);
 	else
-		__rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
+		rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
 	raw_spin_unlock_irq(&sem->wait_lock);
 	wake_up_q(&wake_q);
 	lockevent_inc(rwsem_wlock_fail);
@@ -708,26 +693,11 @@ __rwsem_down_write_failed_common(struct rw_semaphore *sem, int state)
 	return ERR_PTR(-EINTR);
 }
 
-__visible struct rw_semaphore * __sched
-rwsem_down_write_failed(struct rw_semaphore *sem)
-{
-	return __rwsem_down_write_failed_common(sem, TASK_UNINTERRUPTIBLE);
-}
-EXPORT_SYMBOL(rwsem_down_write_failed);
-
-__visible struct rw_semaphore * __sched
-rwsem_down_write_failed_killable(struct rw_semaphore *sem)
-{
-	return __rwsem_down_write_failed_common(sem, TASK_KILLABLE);
-}
-EXPORT_SYMBOL(rwsem_down_write_failed_killable);
-
 /*
  * handle waking up a waiter on the semaphore
  * - up_read/up_write has decremented the active part of count if we come here
  */
-__visible
-struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem)
+static struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem)
 {
 	unsigned long flags;
 	DEFINE_WAKE_Q(wake_q);
@@ -735,22 +705,20 @@ struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem)
 	raw_spin_lock_irqsave(&sem->wait_lock, flags);
 
 	if (!list_empty(&sem->wait_list))
-		__rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
+		rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
 
 	raw_spin_unlock_irqrestore(&sem->wait_lock, flags);
 	wake_up_q(&wake_q);
 
 	return sem;
 }
-EXPORT_SYMBOL(rwsem_wake);
 
 /*
  * downgrade a write lock into a read lock
  * - caller incremented waiting part of count and discovered it still negative
  * - just wake up any readers at the front of the queue
  */
-__visible
-struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem)
+static struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem)
 {
 	unsigned long flags;
 	DEFINE_WAKE_Q(wake_q);
@@ -758,14 +726,13 @@ struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem)
 	raw_spin_lock_irqsave(&sem->wait_lock, flags);
 
 	if (!list_empty(&sem->wait_list))
-		__rwsem_mark_wake(sem, RWSEM_WAKE_READ_OWNED, &wake_q);
+		rwsem_mark_wake(sem, RWSEM_WAKE_READ_OWNED, &wake_q);
 
 	raw_spin_unlock_irqrestore(&sem->wait_lock, flags);
 	wake_up_q(&wake_q);
 
 	return sem;
 }
-EXPORT_SYMBOL(rwsem_downgrade_wake);
 
 /*
  * lock for reading
@@ -774,7 +741,7 @@ inline void __down_read(struct rw_semaphore *sem)
 {
 	if (unlikely(atomic_long_fetch_add_acquire(RWSEM_READER_BIAS,
 			&sem->count) & RWSEM_READ_FAILED_MASK)) {
-		rwsem_down_read_failed(sem);
+		rwsem_down_read_slowpath(sem, TASK_UNINTERRUPTIBLE);
 		DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner &
 					RWSEM_READER_OWNED), sem);
 	} else {
@@ -786,7 +753,7 @@ static inline int __down_read_killable(struct rw_semaphore *sem)
 {
 	if (unlikely(atomic_long_fetch_add_acquire(RWSEM_READER_BIAS,
 			&sem->count) & RWSEM_READ_FAILED_MASK)) {
-		if (IS_ERR(rwsem_down_read_failed_killable(sem)))
+		if (IS_ERR(rwsem_down_read_slowpath(sem, TASK_KILLABLE)))
 			return -EINTR;
 		DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner &
 					RWSEM_READER_OWNED), sem);
@@ -803,7 +770,6 @@ static inline int __down_read_trylock(struct rw_semaphore *sem)
 	 */
 	long tmp = RWSEM_UNLOCKED_VALUE;
 
-	lockevent_inc(rwsem_rtrylock);
 	do {
 		if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
 					tmp + RWSEM_READER_BIAS)) {
@@ -819,30 +785,33 @@ static inline int __down_read_trylock(struct rw_semaphore *sem)
  */
 static inline void __down_write(struct rw_semaphore *sem)
 {
-	if (unlikely(atomic_long_cmpxchg_acquire(&sem->count, 0,
-						 RWSEM_WRITER_LOCKED)))
-		rwsem_down_write_failed(sem);
+	long tmp = RWSEM_UNLOCKED_VALUE;
+
+	if (unlikely(!atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
+						      RWSEM_WRITER_LOCKED)))
+		rwsem_down_write_slowpath(sem, TASK_UNINTERRUPTIBLE);
 	rwsem_set_owner(sem);
 }
 
 static inline int __down_write_killable(struct rw_semaphore *sem)
 {
-	if (unlikely(atomic_long_cmpxchg_acquire(&sem->count, 0,
-						 RWSEM_WRITER_LOCKED)))
-		if (IS_ERR(rwsem_down_write_failed_killable(sem)))
+	long tmp = RWSEM_UNLOCKED_VALUE;
+
+	if (unlikely(!atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
+						      RWSEM_WRITER_LOCKED))) {
+		if (IS_ERR(rwsem_down_write_slowpath(sem, TASK_KILLABLE)))
 			return -EINTR;
+	}
 	rwsem_set_owner(sem);
 	return 0;
 }
 
 static inline int __down_write_trylock(struct rw_semaphore *sem)
 {
-	long tmp;
+	long tmp = RWSEM_UNLOCKED_VALUE;
 
-	lockevent_inc(rwsem_wtrylock);
-	tmp = atomic_long_cmpxchg_acquire(&sem->count, RWSEM_UNLOCKED_VALUE,
-					  RWSEM_WRITER_LOCKED);
-	if (tmp == RWSEM_UNLOCKED_VALUE) {
+	if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
+					    RWSEM_WRITER_LOCKED)) {
 		rwsem_set_owner(sem);
 		return true;
 	}
@@ -856,12 +825,11 @@ inline void __up_read(struct rw_semaphore *sem)
 {
 	long tmp;
 
-	DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner & RWSEM_READER_OWNED),
-				sem);
+	DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner & RWSEM_READER_OWNED), sem);
 	rwsem_clear_reader_owned(sem);
 	tmp = atomic_long_add_return_release(-RWSEM_READER_BIAS, &sem->count);
-	if (unlikely((tmp & (RWSEM_LOCK_MASK|RWSEM_FLAG_WAITERS))
-			== RWSEM_FLAG_WAITERS))
+	if (unlikely((tmp & (RWSEM_LOCK_MASK|RWSEM_FLAG_WAITERS)) ==
+		      RWSEM_FLAG_WAITERS))
 		rwsem_wake(sem);
 }
 
@@ -870,10 +838,12 @@ inline void __up_read(struct rw_semaphore *sem)
  */
 static inline void __up_write(struct rw_semaphore *sem)
 {
+	long tmp;
+
 	DEBUG_RWSEMS_WARN_ON(sem->owner != current, sem);
 	rwsem_clear_owner(sem);
-	if (unlikely(atomic_long_fetch_add_release(-RWSEM_WRITER_LOCKED,
-			&sem->count) & RWSEM_FLAG_WAITERS))
+	tmp = atomic_long_fetch_add_release(-RWSEM_WRITER_LOCKED, &sem->count);
+	if (unlikely(tmp & RWSEM_FLAG_WAITERS))
 		rwsem_wake(sem);
 }
 
@@ -909,7 +879,6 @@ void __sched down_read(struct rw_semaphore *sem)
 
 	LOCK_CONTENDED(sem, __down_read_trylock, __down_read);
 }
-
 EXPORT_SYMBOL(down_read);
 
 int __sched down_read_killable(struct rw_semaphore *sem)
@@ -924,7 +893,6 @@ int __sched down_read_killable(struct rw_semaphore *sem)
 
 	return 0;
 }
-
 EXPORT_SYMBOL(down_read_killable);
 
 /*
@@ -938,7 +906,6 @@ int down_read_trylock(struct rw_semaphore *sem)
 		rwsem_acquire_read(&sem->dep_map, 0, 1, _RET_IP_);
 	return ret;
 }
-
 EXPORT_SYMBOL(down_read_trylock);
 
 /*
@@ -948,10 +915,8 @@ void __sched down_write(struct rw_semaphore *sem)
 {
 	might_sleep();
 	rwsem_acquire(&sem->dep_map, 0, 0, _RET_IP_);
-
 	LOCK_CONTENDED(sem, __down_write_trylock, __down_write);
 }
-
 EXPORT_SYMBOL(down_write);
 
 /*
@@ -962,14 +927,14 @@ int __sched down_write_killable(struct rw_semaphore *sem)
 	might_sleep();
 	rwsem_acquire(&sem->dep_map, 0, 0, _RET_IP_);
 
-	if (LOCK_CONTENDED_RETURN(sem, __down_write_trylock, __down_write_killable)) {
+	if (LOCK_CONTENDED_RETURN(sem, __down_write_trylock,
+				  __down_write_killable)) {
 		rwsem_release(&sem->dep_map, 1, _RET_IP_);
 		return -EINTR;
 	}
 
 	return 0;
 }
-
 EXPORT_SYMBOL(down_write_killable);
 
 /*
@@ -984,7 +949,6 @@ int down_write_trylock(struct rw_semaphore *sem)
 
 	return ret;
 }
-
 EXPORT_SYMBOL(down_write_trylock);
 
 /*
@@ -993,10 +957,8 @@ EXPORT_SYMBOL(down_write_trylock);
 void up_read(struct rw_semaphore *sem)
 {
 	rwsem_release(&sem->dep_map, 1, _RET_IP_);
-
 	__up_read(sem);
 }
-
 EXPORT_SYMBOL(up_read);
 
 /*
@@ -1005,10 +967,8 @@ EXPORT_SYMBOL(up_read);
 void up_write(struct rw_semaphore *sem)
 {
 	rwsem_release(&sem->dep_map, 1, _RET_IP_);
-
 	__up_write(sem);
 }
-
 EXPORT_SYMBOL(up_write);
 
 /*
@@ -1017,10 +977,8 @@ EXPORT_SYMBOL(up_write);
 void downgrade_write(struct rw_semaphore *sem)
 {
 	lock_downgrade(&sem->dep_map, _RET_IP_);
-
 	__downgrade_write(sem);
 }
-
 EXPORT_SYMBOL(downgrade_write);
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
@@ -1029,40 +987,32 @@ void down_read_nested(struct rw_semaphore *sem, int subclass)
 {
 	might_sleep();
 	rwsem_acquire_read(&sem->dep_map, subclass, 0, _RET_IP_);
-
 	LOCK_CONTENDED(sem, __down_read_trylock, __down_read);
 }
-
 EXPORT_SYMBOL(down_read_nested);
 
 void _down_write_nest_lock(struct rw_semaphore *sem, struct lockdep_map *nest)
 {
 	might_sleep();
 	rwsem_acquire_nest(&sem->dep_map, 0, 0, nest, _RET_IP_);
-
 	LOCK_CONTENDED(sem, __down_write_trylock, __down_write);
 }
-
 EXPORT_SYMBOL(_down_write_nest_lock);
 
 void down_read_non_owner(struct rw_semaphore *sem)
 {
 	might_sleep();
-
 	__down_read(sem);
 	__rwsem_set_reader_owned(sem, NULL);
 }
-
 EXPORT_SYMBOL(down_read_non_owner);
 
 void down_write_nested(struct rw_semaphore *sem, int subclass)
 {
 	might_sleep();
 	rwsem_acquire(&sem->dep_map, subclass, 0, _RET_IP_);
-
 	LOCK_CONTENDED(sem, __down_write_trylock, __down_write);
 }
-
 EXPORT_SYMBOL(down_write_nested);
 
 int __sched down_write_killable_nested(struct rw_semaphore *sem, int subclass)
@@ -1070,14 +1020,14 @@ int __sched down_write_killable_nested(struct rw_semaphore *sem, int subclass)
 	might_sleep();
 	rwsem_acquire(&sem->dep_map, subclass, 0, _RET_IP_);
 
-	if (LOCK_CONTENDED_RETURN(sem, __down_write_trylock, __down_write_killable)) {
+	if (LOCK_CONTENDED_RETURN(sem, __down_write_trylock,
+				  __down_write_killable)) {
 		rwsem_release(&sem->dep_map, 1, _RET_IP_);
 		return -EINTR;
 	}
 
 	return 0;
 }
-
 EXPORT_SYMBOL(down_write_killable_nested);
 
 void up_read_non_owner(struct rw_semaphore *sem)
@@ -1086,7 +1036,6 @@ void up_read_non_owner(struct rw_semaphore *sem)
 				sem);
 	__up_read(sem);
 }
-
 EXPORT_SYMBOL(up_read_non_owner);
 
 #endif
-- 
2.18.1

