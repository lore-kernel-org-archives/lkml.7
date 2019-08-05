Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A422C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 14:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58238214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 14:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZCgP+Tn7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbfHEOCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 10:02:52 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50786 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbfHEOCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 10:02:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dF/YlHasfMtf9mVAXeFHhqUH7QXxsLYrhg6uJNzfKDk=; b=ZCgP+Tn7saSZK1eS0k93ZSB/Kl
        Z9PvoIPZTR0TB64pz5uHE+dzi6GtEg52mNxB1xQSXTSFRIbviFSFbpgjZGYGe8g+3oU2WYSgFWFrz
        kNfKKD3n/Q2AGHIdTJ6cnSXxRoJwWCiiPN0EsCJU3++6H9kh6gvh2RioYORWrx3T1NDs3tWan+8CY
        kZUd0U6ONLep5QGCrAiP2R1tHg/twMUalTrOVioGIiCwl5EqtTe4GGZrdCeXk21vYSlktoiMKLvvh
        qPD2x1zZ/T2rJPzgd1Z5yYtK9Osj2Z8CYNOzgZS04MNJGS0Bm1Yn6SpVaBlXI+b/e6pCxRwMh+GZg
        aKgFj4pQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hudZT-0000oi-Ta; Mon, 05 Aug 2019 14:02:45 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 43286201F0983; Mon,  5 Aug 2019 16:02:41 +0200 (CEST)
Date:   Mon, 5 Aug 2019 16:02:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>,
        Will Deacon <will.deacon@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        juri.lelli@redhat.com, williams@redhat.com, bristot@redhat.com,
        longman@redhat.com, dave@stgolabs.net, oleg@redhat.com,
        jack@suse.com
Subject: [PATCH] locking/percpu_rwsem: Rewrite to not use rwsem
Message-ID: <20190805140241.GI2332@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The filesystem freezer uses percpu_rwsem in a way that is effectively
write_non_owner() and achieves this with a few horrible hacks that
rely on the rwsem (!percpu) implementation.

When -RT re-implements rwsem this house of cards comes undone.

Re-implement percpu_rwsem without relying on rwsem.

Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reported-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Juri Lelli <juri.lelli@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Waiman Long <longman@redhat.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: jack@suse.com
---
 include/linux/percpu-rwsem.h  |   72 +++++++++++++-------------
 include/linux/wait.h          |    3 +
 kernel/cpu.c                  |    4 -
 kernel/locking/percpu-rwsem.c |  116 +++++++++++++++++++++++++-----------------
 4 files changed, 112 insertions(+), 83 deletions(-)

--- a/include/linux/percpu-rwsem.h
+++ b/include/linux/percpu-rwsem.h
@@ -5,39 +5,49 @@
 #include <linux/atomic.h>
 #include <linux/rwsem.h>
 #include <linux/percpu.h>
-#include <linux/rcuwait.h>
+#include <linux/wait.h>
 #include <linux/rcu_sync.h>
 #include <linux/lockdep.h>
 
 struct percpu_rw_semaphore {
 	struct rcu_sync		rss;
 	unsigned int __percpu	*read_count;
-	struct rw_semaphore	rw_sem; /* slowpath */
-	struct rcuwait          writer; /* blocked writer */
-	int			readers_block;
+	wait_queue_head_t	waiters;
+	atomic_t		block;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map	dep_map;
+#endif
 };
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#define __PERCPU_RWSEM_DEP_MAP_INIT(lockname)	.dep_map = { .name = #lockname },
+#else
+#define __PERCPU_RWSEM_DEP_MAP_INIT(lockname)
+#endif
+
 #define __DEFINE_PERCPU_RWSEM(name, is_static)				\
 static DEFINE_PER_CPU(unsigned int, __percpu_rwsem_rc_##name);		\
 is_static struct percpu_rw_semaphore name = {				\
 	.rss = __RCU_SYNC_INITIALIZER(name.rss),			\
 	.read_count = &__percpu_rwsem_rc_##name,			\
-	.rw_sem = __RWSEM_INITIALIZER(name.rw_sem),			\
-	.writer = __RCUWAIT_INITIALIZER(name.writer),			\
+	.waiters = __WAIT_QUEUE_HEAD_INITIALIZER(name.waiters),		\
+	.block = ATOMIC_INIT(0),					\
+	__PERCPU_RWSEM_DEP_MAP_INIT(name)				\
 }
+
 #define DEFINE_PERCPU_RWSEM(name)		\
 	__DEFINE_PERCPU_RWSEM(name, /* not static */)
 #define DEFINE_STATIC_PERCPU_RWSEM(name)	\
 	__DEFINE_PERCPU_RWSEM(name, static)
 
-extern int __percpu_down_read(struct percpu_rw_semaphore *, int);
+extern bool __percpu_down_read(struct percpu_rw_semaphore *, bool);
 extern void __percpu_up_read(struct percpu_rw_semaphore *);
 
 static inline void percpu_down_read(struct percpu_rw_semaphore *sem)
 {
 	might_sleep();
 
-	rwsem_acquire_read(&sem->rw_sem.dep_map, 0, 0, _RET_IP_);
+	rwsem_acquire_read(&sem->dep_map, 0, 0, _RET_IP_);
 
 	preempt_disable();
 	/*
@@ -58,42 +68,42 @@ static inline void percpu_down_read(stru
 	preempt_enable();
 }
 
-static inline int percpu_down_read_trylock(struct percpu_rw_semaphore *sem)
+static inline bool percpu_down_read_trylock(struct percpu_rw_semaphore *sem)
 {
-	int ret = 1;
-
 	preempt_disable();
 	/*
 	 * Same as in percpu_down_read().
 	 */
 	__this_cpu_inc(*sem->read_count);
-	if (unlikely(!rcu_sync_is_idle(&sem->rss)))
-		ret = __percpu_down_read(sem, true); /* Unconditional memory barrier */
+	if (unlikely(!rcu_sync_is_idle(&sem->rss))) {
+		if (!__percpu_down_read(sem, true)) /* Unconditional memory barrier */
+			return false;
+	}
 	preempt_enable();
 	/*
 	 * The barrier() from preempt_enable() prevents the compiler from
 	 * bleeding the critical section out.
 	 */
 
-	if (ret)
-		rwsem_acquire_read(&sem->rw_sem.dep_map, 0, 1, _RET_IP_);
-
-	return ret;
+	rwsem_acquire_read(&sem->dep_map, 0, 1, _RET_IP_);
+	return true;
 }
 
 static inline void percpu_up_read(struct percpu_rw_semaphore *sem)
 {
+	rwsem_release(&sem->dep_map, 1, _RET_IP_);
+
 	preempt_disable();
 	/*
 	 * Same as in percpu_down_read().
 	 */
-	if (likely(rcu_sync_is_idle(&sem->rss)))
+	if (likely(rcu_sync_is_idle(&sem->rss))) {
 		__this_cpu_dec(*sem->read_count);
-	else
-		__percpu_up_read(sem); /* Unconditional memory barrier */
-	preempt_enable();
+		preempt_enable();
+		return;
+	}
 
-	rwsem_release(&sem->rw_sem.dep_map, 1, _RET_IP_);
+	__percpu_up_read(sem); /* Unconditional memory barrier */
 }
 
 extern void percpu_down_write(struct percpu_rw_semaphore *);
@@ -110,29 +120,19 @@ extern void percpu_free_rwsem(struct per
 	__percpu_init_rwsem(sem, #sem, &rwsem_key);		\
 })
 
-#define percpu_rwsem_is_held(sem) lockdep_is_held(&(sem)->rw_sem)
-
-#define percpu_rwsem_assert_held(sem)				\
-	lockdep_assert_held(&(sem)->rw_sem)
+#define percpu_rwsem_is_held(sem)	lockdep_is_held(sem)
+#define percpu_rwsem_assert_held(sem)	lockdep_assert_held(sem)
 
 static inline void percpu_rwsem_release(struct percpu_rw_semaphore *sem,
 					bool read, unsigned long ip)
 {
-	lock_release(&sem->rw_sem.dep_map, 1, ip);
-#ifdef CONFIG_RWSEM_SPIN_ON_OWNER
-	if (!read)
-		atomic_long_set(&sem->rw_sem.owner, RWSEM_OWNER_UNKNOWN);
-#endif
+	lock_release(&sem->dep_map, 1, ip);
 }
 
 static inline void percpu_rwsem_acquire(struct percpu_rw_semaphore *sem,
 					bool read, unsigned long ip)
 {
-	lock_acquire(&sem->rw_sem.dep_map, 0, 1, read, 1, NULL, ip);
-#ifdef CONFIG_RWSEM_SPIN_ON_OWNER
-	if (!read)
-		atomic_long_set(&sem->rw_sem.owner, (long)current);
-#endif
+	lock_acquire(&sem->dep_map, 0, 1, read, 1, NULL, ip);
 }
 
 #endif
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -408,6 +408,9 @@ do {										\
 	__wait_event_exclusive_cmd(wq_head, condition, cmd1, cmd2);		\
 } while (0)
 
+#define wait_event_exclusive(wq_head, condition)				\
+	wait_event_exclusive_cmd(wq_head, condition, ,)
+
 #define __wait_event_cmd(wq_head, condition, cmd1, cmd2)			\
 	(void)___wait_event(wq_head, condition, TASK_UNINTERRUPTIBLE, 0, 0,	\
 			    cmd1; schedule(); cmd2)
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -331,12 +331,12 @@ void lockdep_assert_cpus_held(void)
 
 static void lockdep_acquire_cpus_lock(void)
 {
-	rwsem_acquire(&cpu_hotplug_lock.rw_sem.dep_map, 0, 0, _THIS_IP_);
+	rwsem_acquire(&cpu_hotplug_lock.dep_map, 0, 0, _THIS_IP_);
 }
 
 static void lockdep_release_cpus_lock(void)
 {
-	rwsem_release(&cpu_hotplug_lock.rw_sem.dep_map, 1, _THIS_IP_);
+	rwsem_release(&cpu_hotplug_lock.dep_map, 1, _THIS_IP_);
 }
 
 /*
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -2,6 +2,7 @@
 #include <linux/atomic.h>
 #include <linux/rwsem.h>
 #include <linux/percpu.h>
+#include <linux/wait.h>
 #include <linux/lockdep.h>
 #include <linux/percpu-rwsem.h>
 #include <linux/rcupdate.h>
@@ -11,17 +12,19 @@
 #include "rwsem.h"
 
 int __percpu_init_rwsem(struct percpu_rw_semaphore *sem,
-			const char *name, struct lock_class_key *rwsem_key)
+			const char *name, struct lock_class_key *key)
 {
 	sem->read_count = alloc_percpu(int);
 	if (unlikely(!sem->read_count))
 		return -ENOMEM;
 
-	/* ->rw_sem represents the whole percpu_rw_semaphore for lockdep */
 	rcu_sync_init(&sem->rss);
-	__init_rwsem(&sem->rw_sem, name, rwsem_key);
-	rcuwait_init(&sem->writer);
-	sem->readers_block = 0;
+	init_waitqueue_head(&sem->waiters);
+	atomic_set(&sem->block, 0);
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	debug_check_no_locks_freed((void *)sem, sizeof(*sem));
+	lockdep_init_map(&sem->dep_map, name, key, 0);
+#endif
 	return 0;
 }
 EXPORT_SYMBOL_GPL(__percpu_init_rwsem);
@@ -41,59 +44,62 @@ void percpu_free_rwsem(struct percpu_rw_
 }
 EXPORT_SYMBOL_GPL(percpu_free_rwsem);
 
-int __percpu_down_read(struct percpu_rw_semaphore *sem, int try)
+/*
+ * Called with preemption disabled, and returns with preemption disabled,
+ * except when it fails the trylock.
+ */
+bool __percpu_down_read(struct percpu_rw_semaphore *sem, bool try)
 {
 	/*
 	 * Due to having preemption disabled the decrement happens on
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
 
+again:
 	smp_mb(); /* A matches D */
 
 	/*
-	 * If !readers_block the critical section starts here, matched by the
+	 * If !sem->block the critical section starts here, matched by the
 	 * release in percpu_up_write().
 	 */
-	if (likely(!smp_load_acquire(&sem->readers_block)))
-		return 1;
+	if (likely(!atomic_read_acquire(&sem->block)))
+		return true;
 
 	/*
 	 * Per the above comment; we still have preemption disabled and
 	 * will thus decrement on the same CPU as we incremented.
 	 */
-	__percpu_up_read(sem);
+	__percpu_up_read(sem); /* implies preempt_enable() */
 
 	if (try)
-		return 0;
+		return false;
 
-	/*
-	 * We either call schedule() in the wait, or we'll fall through
-	 * and reschedule on the preempt_enable() in percpu_down_read().
-	 */
-	preempt_enable_no_resched();
+	wait_event(sem->waiters, !atomic_read_acquire(&sem->block));
+	preempt_disable();
+	__this_cpu_inc(*sem->read_count);
 
 	/*
-	 * Avoid lockdep for the down/up_read() we already have them.
+	 * percpu_down_write() could've set sem->block right after we've seen
+	 * it 0 but missed our this_cpu_inc(), which is exactly the condition
+	 * we get called for from percpu_down_read().
 	 */
-	__down_read(&sem->rw_sem);
-	this_cpu_inc(*sem->read_count);
-	__up_read(&sem->rw_sem);
-
-	preempt_disable();
-	return 1;
+	goto again;
 }
 EXPORT_SYMBOL_GPL(__percpu_down_read);
 
+/*
+ * Called with preemption disabled, returns with preemption enabled.
+ */
 void __percpu_up_read(struct percpu_rw_semaphore *sem)
 {
 	smp_mb(); /* B matches C */
@@ -103,9 +109,10 @@ void __percpu_up_read(struct percpu_rw_s
 	 * critical section.
 	 */
 	__this_cpu_dec(*sem->read_count);
+	preempt_enable();
 
-	/* Prod writer to recheck readers_active */
-	rcuwait_wake_up(&sem->writer);
+	/* Prod writer to re-evaluate readers_active_check() */
+	wake_up(&sem->waiters);
 }
 EXPORT_SYMBOL_GPL(__percpu_up_read);
 
@@ -124,6 +131,8 @@ EXPORT_SYMBOL_GPL(__percpu_up_read);
  * zero.  If this sum is zero, then it is stable due to the fact that if any
  * newly arriving readers increment a given counter, they will immediately
  * decrement that same counter.
+ *
+ * Assumes sem->block is set.
  */
 static bool readers_active_check(struct percpu_rw_semaphore *sem)
 {
@@ -140,29 +149,37 @@ static bool readers_active_check(struct
 	return true;
 }
 
+static inline bool try_acquire_block(struct percpu_rw_semaphore *sem)
+{
+	if (atomic_read(&sem->block))
+		return false;
+
+	return atomic_xchg(&sem->block, 1) == 0;
+}
+
 void percpu_down_write(struct percpu_rw_semaphore *sem)
 {
+	rwsem_acquire(&sem->dep_map, 0, 0, _RET_IP_);
+
 	/* Notify readers to take the slow path. */
 	rcu_sync_enter(&sem->rss);
 
-	down_write(&sem->rw_sem);
-
 	/*
-	 * Notify new readers to block; up until now, and thus throughout the
-	 * longish rcu_sync_enter() above, new readers could still come in.
+	 * Try set sem->block; this provides writer-writer exclusion.
+	 * Having sem->block set makes new readers block.
 	 */
-	WRITE_ONCE(sem->readers_block, 1);
+	wait_event_exclusive(sem->waiters, try_acquire_block(sem));
 
-	smp_mb(); /* D matches A */
+	/* smp_mb() implied by acquire_block() on success -- D matches A */
 
 	/*
-	 * If they don't see our writer of readers_block, then we are
-	 * guaranteed to see their sem->read_count increment, and therefore
-	 * will wait for them.
+	 * If they don't see our store of sem->block, then we are guaranteed to
+	 * see their sem->read_count increment, and therefore will wait for
+	 * them.
 	 */
 
-	/* Wait for all now active readers to complete. */
-	rcuwait_wait_event(&sem->writer, readers_active_check(sem));
+	/* Wait for all active readers to complete. */
+	wait_event(sem->waiters, readers_active_check(sem));
 }
 EXPORT_SYMBOL_GPL(percpu_down_write);
 
@@ -178,12 +195,19 @@ void percpu_up_write(struct percpu_rw_se
 	 * Therefore we force it through the slow path which guarantees an
 	 * acquire and thereby guarantees the critical section's consistency.
 	 */
-	smp_store_release(&sem->readers_block, 0);
+	atomic_set_release(&sem->block, 0);
 
 	/*
-	 * Release the write lock, this will allow readers back in the game.
+	 * Prod any pending reader/writer to make progress.
+	 *
+	 * While there is no fairness guarantee; readers are waiting !exclusive
+	 * and will thus be on the wait_list head, while writers are waiting
+	 * exclusive and will thus be on the wait_list tail.
+	 *
+	 * Therefore it is more likely a reader will acquire the lock; if there
+	 * are any.
 	 */
-	up_write(&sem->rw_sem);
+	wake_up(&sem->waiters);
 
 	/*
 	 * Once this completes (at least one RCU-sched grace period hence) the
@@ -191,5 +215,7 @@ void percpu_up_write(struct percpu_rw_se
 	 * exclusive write lock because its counting.
 	 */
 	rcu_sync_exit(&sem->rss);
+
+	rwsem_release(&sem->dep_map, 1, _RET_IP_);
 }
 EXPORT_SYMBOL_GPL(percpu_up_write);
