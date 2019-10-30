Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94035CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 17:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54A6C2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 17:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RRFqE+OQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfJ3Rwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 13:52:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37898 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfJ3Rwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 13:52:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MP9KdkmqTdyloWfwooC3vQgwh/3TKPIL5Ju4Qbw/tp0=; b=RRFqE+OQzFhfmsJbTkVpPtAnf
        9UeGUvAfhJ7ih+bNEWH0SHoMZnX4tzS8fn5IqgCc6vyBHZkeimMxkMM4BwWvh1U8VOI3YaHh6WYMx
        8RvbHPEtXq71I4G2TbEKBMlAp8/+NLoKTSLqNNZ1ZqS2mSv72ZAQE+BBhkiD3li4qbvLQVvdpNOj8
        /MskIdoc9aX1KfNWGGL21W7EosFggyYi35a72AfnFdcDE8XKfNp7TBO+ZDZvg7E6VV3/MeQ17MHpv
        GnpanA1M3zAq6NQkuSmKoQKJ8x+AiP6MGezdeSYXKWGHfj0cCf+BUffDmfFmn6BOzF45x+2BZvKbb
        WN/vqbtyQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iPs93-0002Km-Hj; Wed, 30 Oct 2019 17:52:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 15D1E30025A;
        Wed, 30 Oct 2019 18:51:30 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 587822B44D068; Wed, 30 Oct 2019 18:52:31 +0100 (CET)
Date:   Wed, 30 Oct 2019 18:52:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Will Deacon <will.deacon@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        juri.lelli@redhat.com, williams@redhat.com, bristot@redhat.com,
        longman@redhat.com, dave@stgolabs.net, jack@suse.com
Subject: Re: [PATCH] locking/percpu_rwsem: Rewrite to not use rwsem
Message-ID: <20191030175231.GF5671@hirez.programming.kicks-ass.net>
References: <20190805140241.GI2332@hirez.programming.kicks-ass.net>
 <20190806161741.GC21454@redhat.com>
 <20190806171515.GR2349@hirez.programming.kicks-ass.net>
 <20190807095657.GA24112@redhat.com>
 <20191029184739.GA3079@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029184739.GA3079@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 07:47:39PM +0100, Peter Zijlstra wrote:
> I've made these changes. Now let me go have a play with that second
> waitqueue.

What I've ended up with is a 'custom' waitqueue and an rcuwait. The
rcuwait conveniently got around the tedious preempt_enable/disable
around the __percpu_up_read() wakeup.

I realized that up_read will only ever have to wake a (single) blocked
writer, never a series of readers.

Compile tested only, I'll build and boot test once i've had dinner.

---
 include/linux/percpu-rwsem.h  |  64 +++++++++--------
 include/linux/wait.h          |   1 +
 kernel/cpu.c                  |   4 +-
 kernel/locking/percpu-rwsem.c | 156 ++++++++++++++++++++++++++++++------------
 4 files changed, 150 insertions(+), 75 deletions(-)

diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
index ad2ca2a89d5b..806af4bf257e 100644
--- a/include/linux/percpu-rwsem.h
+++ b/include/linux/percpu-rwsem.h
@@ -6,38 +6,51 @@
 #include <linux/rwsem.h>
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
 	.writer = __RCUWAIT_INITIALIZER(name.writer),			\
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
@@ -48,8 +61,9 @@ static inline void percpu_down_read(struct percpu_rw_semaphore *sem)
 	 * and that once the synchronize_rcu() is done, the writer will see
 	 * anything we did within this RCU-sched read-size critical section.
 	 */
-	__this_cpu_inc(*sem->read_count);
-	if (unlikely(!rcu_sync_is_idle(&sem->rss)))
+	if (likely(rcu_sync_is_idle(&sem->rss)))
+		__this_cpu_inc(*sem->read_count);
+	else
 		__percpu_down_read(sem, false); /* Unconditional memory barrier */
 	/*
 	 * The preempt_enable() prevents the compiler from
@@ -58,16 +72,17 @@ static inline void percpu_down_read(struct percpu_rw_semaphore *sem)
 	preempt_enable();
 }
 
-static inline int percpu_down_read_trylock(struct percpu_rw_semaphore *sem)
+static inline bool percpu_down_read_trylock(struct percpu_rw_semaphore *sem)
 {
-	int ret = 1;
+	bool ret = true;
 
 	preempt_disable();
 	/*
 	 * Same as in percpu_down_read().
 	 */
-	__this_cpu_inc(*sem->read_count);
-	if (unlikely(!rcu_sync_is_idle(&sem->rss)))
+	if (likely(!rcu_sync_is_idle(&sem->rss)))
+		__this_cpu_inc(*sem->read_count);
+	else
 		ret = __percpu_down_read(sem, true); /* Unconditional memory barrier */
 	preempt_enable();
 	/*
@@ -76,13 +91,15 @@ static inline int percpu_down_read_trylock(struct percpu_rw_semaphore *sem)
 	 */
 
 	if (ret)
-		rwsem_acquire_read(&sem->rw_sem.dep_map, 0, 1, _RET_IP_);
+		rwsem_acquire_read(&sem->dep_map, 0, 1, _RET_IP_);
 
 	return ret;
 }
 
 static inline void percpu_up_read(struct percpu_rw_semaphore *sem)
 {
+	rwsem_release(&sem->dep_map, _RET_IP_);
+
 	preempt_disable();
 	/*
 	 * Same as in percpu_down_read().
@@ -91,9 +108,8 @@ static inline void percpu_up_read(struct percpu_rw_semaphore *sem)
 		__this_cpu_dec(*sem->read_count);
 	else
 		__percpu_up_read(sem); /* Unconditional memory barrier */
-	preempt_enable();
 
-	rwsem_release(&sem->rw_sem.dep_map, _RET_IP_);
+	preempt_enable();
 }
 
 extern void percpu_down_write(struct percpu_rw_semaphore *);
@@ -110,29 +126,19 @@ extern void percpu_free_rwsem(struct percpu_rw_semaphore *);
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
-	lock_release(&sem->rw_sem.dep_map, ip);
-#ifdef CONFIG_RWSEM_SPIN_ON_OWNER
-	if (!read)
-		atomic_long_set(&sem->rw_sem.owner, RWSEM_OWNER_UNKNOWN);
-#endif
+	lock_release(&sem->dep_map, ip);
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
diff --git a/include/linux/wait.h b/include/linux/wait.h
index 3eb7cae8206c..94580163a4b1 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -20,6 +20,7 @@ int default_wake_function(struct wait_queue_entry *wq_entry, unsigned mode, int
 #define WQ_FLAG_EXCLUSIVE	0x01
 #define WQ_FLAG_WOKEN		0x02
 #define WQ_FLAG_BOOKMARK	0x04
+#define WQ_FLAG_CUSTOM		0x08
 
 /*
  * A single wait-queue entry structure:
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 68f85627d909..7ea0c0225590 100644
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
-	rwsem_release(&cpu_hotplug_lock.rw_sem.dep_map, _THIS_IP_);
+	rwsem_release(&cpu_hotplug_lock.dep_map, _THIS_IP_);
 }
 
 /*
diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
index 364d38a0c444..9aa69345cdc8 100644
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
@@ -11,17 +12,20 @@
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
 	rcuwait_init(&sem->writer);
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
@@ -41,31 +45,95 @@ void percpu_free_rwsem(struct percpu_rw_semaphore *sem)
 }
 EXPORT_SYMBOL_GPL(percpu_free_rwsem);
 
-int __percpu_down_read(struct percpu_rw_semaphore *sem, int try)
+enum wake_state {
+	unknown = -1,
+	writer = 0,
+	reader = 1,
+};
+
+/*
+ * percpu_rwsem_wake_function -- provide FIFO fair reader/writer wakeups
+ *
+ * As per percpu_rwsem_wait() all waiters are queued exclusive (tail/FIFO)
+ * without autoremove to preserve FIFO order.
+ */
+static int percpu_rwsem_wake_function(struct wait_queue_entry *wq_entry,
+				      unsigned int mode, int wake_flags,
+				      void *key)
+{
+	enum wake_state state = (wq_entry->flags & WQ_FLAG_CUSTOM) ? reader : writer;
+	enum wake_state *statep = key;
+
+	if (*statep != unknown && (*statep == writer || state == writer))
+		return 1; /* stop; woken 1 writer or exhausted readers */
+
+	if (default_wake_function(wq_entry, mode, wake_flags, NULL))
+		*statep = state;
+
+	return 0; /* continue waking */
+}
+
+#define percpu_rwsem_wait(sem, reader, cond)				\
+do {									\
+	DEFINE_WAIT_FUNC(wq_entry, percpu_rwsem_wake_function);		\
+									\
+	if (reader)							\
+		wq_entry.flags |= WQ_FLAG_CUSTOM;			\
+									\
+	add_wait_queue_exclusive(&(sem)->waiters, &wq_entry);		\
+	for (;;) {							\
+		set_current_state(TASK_UNINTERRUPTIBLE);		\
+		if (cond)						\
+			break;						\
+		schedule();						\
+	}								\
+	__set_current_state(TASK_RUNNING);				\
+	remove_wait_queue(&(sem)->waiters, &wq_entry);			\
+} while (0)
+
+#define percpu_rwsem_wake(sem)						\
+do {									\
+	enum wake_state ____state = unknown;				\
+	__wake_up(&(sem)->waiters, TASK_NORMAL, 1, &____state);		\
+} while (0)
+
+bool __percpu_down_read(struct percpu_rw_semaphore *sem, bool try)
 {
+	if (atomic_read(&sem->block)) {
+again:
+		if (try)
+			return false;
+
+		preempt_enable();
+		percpu_rwsem_wait(sem, reader, !atomic_read(&sem->block));
+		preempt_disable();
+	}
+
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
 
+	__this_cpu_inc(*sem->read_count);
+
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
@@ -73,24 +141,12 @@ int __percpu_down_read(struct percpu_rw_semaphore *sem, int try)
 	 */
 	__percpu_up_read(sem);
 
-	if (try)
-		return 0;
-
-	/*
-	 * We either call schedule() in the wait, or we'll fall through
-	 * and reschedule on the preempt_enable() in percpu_down_read().
-	 */
-	preempt_enable_no_resched();
-
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
 
@@ -104,7 +160,7 @@ void __percpu_up_read(struct percpu_rw_semaphore *sem)
 	 */
 	__this_cpu_dec(*sem->read_count);
 
-	/* Prod writer to recheck readers_active */
+	/* Prod writer to re-evaluate readers_active_check() */
 	rcuwait_wake_up(&sem->writer);
 }
 EXPORT_SYMBOL_GPL(__percpu_up_read);
@@ -124,6 +180,8 @@ EXPORT_SYMBOL_GPL(__percpu_up_read);
  * zero.  If this sum is zero, then it is stable due to the fact that if any
  * newly arriving readers increment a given counter, they will immediately
  * decrement that same counter.
+ *
+ * Assumes sem->block is set.
  */
 static bool readers_active_check(struct percpu_rw_semaphore *sem)
 {
@@ -140,28 +198,36 @@ static bool readers_active_check(struct percpu_rw_semaphore *sem)
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
+	percpu_rwsem_wait(sem, writer, try_acquire_block(sem));
 
-	smp_mb(); /* D matches A */
+	/* smp_mb() implied by try_acquire_block() on success -- D matches A */
 
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
@@ -178,12 +244,12 @@ void percpu_up_write(struct percpu_rw_semaphore *sem)
 	 * Therefore we force it through the slow path which guarantees an
 	 * acquire and thereby guarantees the critical section's consistency.
 	 */
-	smp_store_release(&sem->readers_block, 0);
+	atomic_set_release(&sem->block, 0);
 
 	/*
-	 * Release the write lock, this will allow readers back in the game.
+	 * Prod any pending reader/writer to make progress.
 	 */
-	up_write(&sem->rw_sem);
+	percpu_rwsem_wake(sem);
 
 	/*
 	 * Once this completes (at least one RCU-sched grace period hence) the
@@ -191,5 +257,7 @@ void percpu_up_write(struct percpu_rw_semaphore *sem)
 	 * exclusive write lock because its counting.
 	 */
 	rcu_sync_exit(&sem->rss);
+
+	rwsem_release(&sem->dep_map, _RET_IP_);
 }
 EXPORT_SYMBOL_GPL(percpu_up_write);
