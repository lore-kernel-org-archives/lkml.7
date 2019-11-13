Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CBEC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0262245A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eoWI3j8K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbfKMK3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 05:29:38 -0500
Received: from merlin.infradead.org ([205.233.59.134]:36286 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbfKMK3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 05:29:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ivT5EbvBxgi1baF9RgFN/brDObNe915RkfWbKZ/bNlQ=; b=eoWI3j8KHCTsMUZbzhi2FDX/Ck
        I4OJ9UuZ6/4JF6bxElw8u7l4y8/vjUxbZot7rlakLnGY/rVUVC6GshNON581QCS0pzEL9w31cotmU
        mSHn+etxQoPkWbQYNh/DEv69DZJqDZ0k03wikklBaLVHAEyC2o3cN53qVV+HQuqqQ8OMs9U5eBwPo
        D6CpbZL6jCsp1uccvZxgWcGiwaSdMRcYqXrKHbyH/vSDZwVY3fGjiAMI2s+FNh+/hTRZNenkLnmGK
        PdjSNe1kv021b4KjtZUSyHV+fWUZcXzRy0gFD6Sy6lt7t5AsHo7GdTw8UmUB98girgPGCQD8XXflx
        UE8eiNzA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUpte-0000X4-Lk; Wed, 13 Nov 2019 10:29:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DC4D43060C2;
        Wed, 13 Nov 2019 11:28:01 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A34232997AACC; Wed, 13 Nov 2019 11:29:08 +0100 (CET)
Message-Id: <20191113102855.925208237@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 13 Nov 2019 11:21:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     peterz@infradead.org, mingo@kernel.org, will@kernel.org
Cc:     oleg@redhat.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, juri.lelli@redhat.com, williams@redhat.com,
        bristot@redhat.com, longman@redhat.com, dave@stgolabs.net,
        jack@suse.com
Subject: [PATCH 5/5] locking/percpu-rwsem: Remove the embedded rwsem
References: <20191113102115.116470462@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The filesystem freezer uses percpu-rwsem in a way that is effectively
write_non_owner() and achieves this with a few horrible hacks that
rely on the rwsem (!percpu) implementation.

When PREEMPT_RT replaces the rwsem implementation with a PI aware
variant this comes apart.

Remove the embedded rwsem and implement it using a waitqueue and an
atomic_t.

 - make readers_block an atomic, and use it, with the waitqueue
   for a blocking test-and-set write-side.

 - have the read-side wait for the 'lock' state to clear.

Have the waiters use FIFO queueing and mark them (reader/writer) with
a new WQ_FLAG. Use a custom wake_function to wake either a single
writer or all readers until a writer.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/percpu-rwsem.h  |   19 +----
 include/linux/wait.h          |    1 
 kernel/locking/percpu-rwsem.c |  140 +++++++++++++++++++++++++++++-------------
 kernel/locking/rwsem.c        |    9 +-
 kernel/locking/rwsem.h        |   12 ---
 5 files changed, 110 insertions(+), 71 deletions(-)

--- a/include/linux/percpu-rwsem.h
+++ b/include/linux/percpu-rwsem.h
@@ -3,18 +3,18 @@
 #define _LINUX_PERCPU_RWSEM_H
 
 #include <linux/atomic.h>
-#include <linux/rwsem.h>
 #include <linux/percpu.h>
 #include <linux/rcuwait.h>
+#include <linux/wait.h>
 #include <linux/rcu_sync.h>
 #include <linux/lockdep.h>
 
 struct percpu_rw_semaphore {
 	struct rcu_sync		rss;
 	unsigned int __percpu	*read_count;
-	struct rw_semaphore	rw_sem; /* slowpath */
-	struct rcuwait          writer; /* blocked writer */
-	int			readers_block;
+	struct rcuwait		writer;
+	wait_queue_head_t	waiters;
+	atomic_t		block;
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map	dep_map;
 #endif
@@ -31,8 +31,9 @@ static DEFINE_PER_CPU(unsigned int, __pe
 is_static struct percpu_rw_semaphore name = {				\
 	.rss = __RCU_SYNC_INITIALIZER(name.rss),			\
 	.read_count = &__percpu_rwsem_rc_##name,			\
-	.rw_sem = __RWSEM_INITIALIZER(name.rw_sem),			\
 	.writer = __RCUWAIT_INITIALIZER(name.writer),			\
+	.waiters = __WAIT_QUEUE_HEAD_INITIALIZER(name.waiters),		\
+	.block = ATOMIC_INIT(0),					\
 	__PERCPU_RWSEM_DEP_MAP_INIT(name)				\
 }
 
@@ -130,20 +131,12 @@ static inline void percpu_rwsem_release(
 					bool read, unsigned long ip)
 {
 	lock_release(&sem->dep_map, ip);
-#ifdef CONFIG_RWSEM_SPIN_ON_OWNER
-	if (!read)
-		atomic_long_set(&sem->rw_sem.owner, RWSEM_OWNER_UNKNOWN);
-#endif
 }
 
 static inline void percpu_rwsem_acquire(struct percpu_rw_semaphore *sem,
 					bool read, unsigned long ip)
 {
 	lock_acquire(&sem->dep_map, 0, 1, read, 1, NULL, ip);
-#ifdef CONFIG_RWSEM_SPIN_ON_OWNER
-	if (!read)
-		atomic_long_set(&sem->rw_sem.owner, (long)current);
-#endif
 }
 
 #endif
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -20,6 +20,7 @@ int default_wake_function(struct wait_qu
 #define WQ_FLAG_EXCLUSIVE	0x01
 #define WQ_FLAG_WOKEN		0x02
 #define WQ_FLAG_BOOKMARK	0x04
+#define WQ_FLAG_CUSTOM		0x08
 
 /*
  * A single wait-queue entry structure:
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -1,15 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/atomic.h>
-#include <linux/rwsem.h>
 #include <linux/percpu.h>
+#include <linux/wait.h>
 #include <linux/lockdep.h>
 #include <linux/percpu-rwsem.h>
 #include <linux/rcupdate.h>
 #include <linux/sched.h>
+#include <linux/sched/task.h>
 #include <linux/errno.h>
 
-#include "rwsem.h"
-
 int __percpu_init_rwsem(struct percpu_rw_semaphore *sem,
 			const char *name, struct lock_class_key *key)
 {
@@ -17,11 +16,10 @@ int __percpu_init_rwsem(struct percpu_rw
 	if (unlikely(!sem->read_count))
 		return -ENOMEM;
 
-	/* ->rw_sem represents the whole percpu_rw_semaphore for lockdep */
 	rcu_sync_init(&sem->rss);
-	__init_rwsem(&sem->rw_sem, name, rwsem_key);
 	rcuwait_init(&sem->writer);
-	sem->readers_block = 0;
+	init_waitqueue_head(&sem->waiters);
+	atomic_set(&sem->block, 0);
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	debug_check_no_locks_freed((void *)sem, sizeof(*sem));
 	lockdep_init_map(&sem->dep_map, name, key, 0);
@@ -54,23 +52,23 @@ static bool __percpu_down_read_trylock(s
 	 * the same CPU as the increment, avoiding the
 	 * increment-on-one-CPU-and-decrement-on-another problem.
 	 *
-	 * If the reader misses the writer's assignment of readers_block, then
-	 * the writer is guaranteed to see the reader's increment.
+	 * If the reader misses the writer's assignment of sem->block, then the
+	 * writer is guaranteed to see the reader's increment.
 	 *
 	 * Conversely, any readers that increment their sem->read_count after
-	 * the writer looks are guaranteed to see the readers_block value,
-	 * which in turn means that they are guaranteed to immediately
-	 * decrement their sem->read_count, so that it doesn't matter that the
-	 * writer missed them.
+	 * the writer looks are guaranteed to see the sem->block value, which
+	 * in turn means that they are guaranteed to immediately decrement
+	 * their sem->read_count, so that it doesn't matter that the writer
+	 * missed them.
 	 */
 
 	smp_mb(); /* A matches D */
 
 	/*
-	 * If !readers_block the critical section starts here, matched by the
+	 * If !sem->block the critical section starts here, matched by the
 	 * release in percpu_up_write().
 	 */
-	if (likely(!atomic_read_acquire(&sem->readers_block)))
+	if (likely(!atomic_read_acquire(&sem->block)))
 		return true;
 
 	__this_cpu_dec(*sem->read_count);
@@ -81,6 +79,75 @@ static bool __percpu_down_read_trylock(s
 	return false;
 }
 
+static inline bool __percpu_down_write_trylock(struct percpu_rw_semaphore *sem)
+{
+	if (atomic_read(&sem->block))
+		return false;
+
+	return atomic_xchg(&sem->block, 1) == 0;
+}
+
+static bool __percpu_rwsem_trylock(struct percpu_rw_semaphore *sem, bool reader)
+{
+	if (reader) {
+		bool ret;
+
+		preempt_disable();
+		ret = __percpu_down_read_trylock(sem);
+		preempt_enable();
+
+		return ret;
+	}
+	return __percpu_down_write_trylock(sem);
+}
+
+static int percpu_rwsem_wake_function(struct wait_queue_entry *wq_entry,
+				      unsigned int mode, int wake_flags,
+				      void *key)
+{
+	struct task_struct *p = get_task_struct(wq_entry->private);
+	bool reader = wq_entry->flags & WQ_FLAG_CUSTOM;
+	struct percpu_rw_semaphore *sem = key;
+
+	/* concurrent against percpu_down_write(), can get stolen */
+	if (!__percpu_rwsem_trylock(sem, reader))
+		return 1;
+
+	list_del_init(&wq_entry->entry);
+	smp_store_release(&wq_entry->private, NULL);
+
+	wake_up_process(p);
+	put_task_struct(p);
+
+	return !reader; /* wake 'all' readers and 1 writer */
+}
+
+static void percpu_rwsem_wait(struct percpu_rw_semaphore *sem, bool reader)
+{
+	DEFINE_WAIT_FUNC(wq_entry, percpu_rwsem_wake_function);
+	bool wait;
+
+	spin_lock_irq(&sem->waiters.lock);
+	/*
+	 * Serialize against the wakeup in percpu_up_write(), if we fail
+	 * the trylock, the wakeup must see us on the list.
+	 */
+	wait = !__percpu_rwsem_trylock(sem, reader);
+	if (wait) {
+		wq_entry.flags |= WQ_FLAG_EXCLUSIVE | reader * WQ_FLAG_CUSTOM;
+		__add_wait_queue_entry_tail(&sem->waiters, &wq_entry);
+	}
+	spin_unlock_irq(&sem->waiters.lock);
+
+	while (wait) {
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		if (!smp_load_acquire(&wq_entry.private))
+			break;
+		schedule();
+	}
+	__set_current_state(TASK_RUNNING);
+}
+
 bool __percpu_down_read(struct percpu_rw_semaphore *sem, bool try)
 {
 	if (__percpu_down_read_trylock(sem))
@@ -89,20 +156,10 @@ bool __percpu_down_read(struct percpu_rw
 	if (try)
 		return false;
 
-	/*
-	 * We either call schedule() in the wait, or we'll fall through
-	 * and reschedule on the preempt_enable() in percpu_down_read().
-	 */
-	preempt_enable_no_resched();
-
-	/*
-	 * Avoid lockdep for the down/up_read() we already have them.
-	 */
-	__down_read(&sem->rw_sem);
-	this_cpu_inc(*sem->read_count);
-	__up_read(&sem->rw_sem);
-
+	preempt_enable();
+	percpu_rwsem_wait(sem, /* .reader = */ true );
 	preempt_disable();
+
 	return true;
 }
 EXPORT_SYMBOL_GPL(__percpu_down_read);
@@ -117,7 +174,7 @@ void __percpu_up_read(struct percpu_rw_s
 	 */
 	__this_cpu_dec(*sem->read_count);
 
-	/* Prod writer to recheck readers_active */
+	/* Prod writer to re-evaluate readers_active_check() */
 	rcuwait_wake_up(&sem->writer);
 }
 EXPORT_SYMBOL_GPL(__percpu_up_read);
@@ -137,6 +194,8 @@ EXPORT_SYMBOL_GPL(__percpu_up_read);
  * zero.  If this sum is zero, then it is stable due to the fact that if any
  * newly arriving readers increment a given counter, they will immediately
  * decrement that same counter.
+ *
+ * Assumes sem->block is set.
  */
 static bool readers_active_check(struct percpu_rw_semaphore *sem)
 {
@@ -160,23 +219,22 @@ void percpu_down_write(struct percpu_rw_
 	/* Notify readers to take the slow path. */
 	rcu_sync_enter(&sem->rss);
 
-	__down_write(&sem->rw_sem);
-
 	/*
-	 * Notify new readers to block; up until now, and thus throughout the
-	 * longish rcu_sync_enter() above, new readers could still come in.
+	 * Try set sem->block; this provides writer-writer exclusion.
+	 * Having sem->block set makes new readers block.
 	 */
-	WRITE_ONCE(sem->readers_block, 1);
+	if (!__percpu_down_write_trylock(sem))
+		percpu_rwsem_wait(sem, /* .reader = */ false);
 
-	smp_mb(); /* D matches A */
+	/* smp_mb() implied by __percpu_down_writer_trylock() on success -- D matches A */
 
 	/*
-	 * If they don't see our writer of readers_block, then we are
-	 * guaranteed to see their sem->read_count increment, and therefore
-	 * will wait for them.
+	 * If they don't see our store of sem->block, then we are guaranteed to
+	 * see their sem->read_count increment, and therefore will wait for
+	 * them.
 	 */
 
-	/* Wait for all now active readers to complete. */
+	/* Wait for all active readers to complete. */
 	rcuwait_wait_event(&sem->writer, readers_active_check(sem));
 }
 EXPORT_SYMBOL_GPL(percpu_down_write);
@@ -195,12 +253,12 @@ void percpu_up_write(struct percpu_rw_se
 	 * Therefore we force it through the slow path which guarantees an
 	 * acquire and thereby guarantees the critical section's consistency.
 	 */
-	smp_store_release(&sem->readers_block, 0);
+	atomic_set_release(&sem->block, 0);
 
 	/*
-	 * Release the write lock, this will allow readers back in the game.
+	 * Prod any pending reader/writer to make progress.
 	 */
-	__up_write(&sem->rw_sem);
+	__wake_up(&sem->waiters, TASK_NORMAL, 1, sem);
 
 	/*
 	 * Once this completes (at least one RCU-sched grace period hence) the
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -28,7 +28,6 @@
 #include <linux/rwsem.h>
 #include <linux/atomic.h>
 
-#include "rwsem.h"
 #include "lock_events.h"
 
 /*
@@ -1338,7 +1337,7 @@ static struct rw_semaphore *rwsem_downgr
 /*
  * lock for reading
  */
-inline void __down_read(struct rw_semaphore *sem)
+static inline void __down_read(struct rw_semaphore *sem)
 {
 	if (!rwsem_read_trylock(sem)) {
 		rwsem_down_read_slowpath(sem, TASK_UNINTERRUPTIBLE);
@@ -1383,7 +1382,7 @@ static inline int __down_read_trylock(st
 /*
  * lock for writing
  */
-inline void __down_write(struct rw_semaphore *sem)
+static inline void __down_write(struct rw_semaphore *sem)
 {
 	long tmp = RWSEM_UNLOCKED_VALUE;
 
@@ -1426,7 +1425,7 @@ static inline int __down_write_trylock(s
 /*
  * unlock after reading
  */
-inline void __up_read(struct rw_semaphore *sem)
+static inline void __up_read(struct rw_semaphore *sem)
 {
 	long tmp;
 
@@ -1446,7 +1445,7 @@ inline void __up_read(struct rw_semaphor
 /*
  * unlock after writing
  */
-inline void __up_write(struct rw_semaphore *sem)
+static inline void __up_write(struct rw_semaphore *sem)
 {
 	long tmp;
 
--- a/kernel/locking/rwsem.h
+++ b/kernel/locking/rwsem.h
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-#ifndef __INTERNAL_RWSEM_H
-#define __INTERNAL_RWSEM_H
-#include <linux/rwsem.h>
-
-extern void __down_read(struct rw_semaphore *sem);
-extern void __up_read(struct rw_semaphore *sem);
-extern void __down_write(struct rw_semaphore *sem);
-extern void __up_write(struct rw_semaphore *sem);
-
-#endif /* __INTERNAL_RWSEM_H */


