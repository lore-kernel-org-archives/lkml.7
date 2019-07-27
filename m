Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C72FC433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 23:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84947208E4
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 23:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbfG0Xaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 19:30:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51221 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfG0Xaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 19:30:39 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hrW95-0002Ls-Rd; Sun, 28 Jul 2019 01:30:35 +0200
Date:   Sat, 27 Jul 2019 23:26:14 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] locking/urgent for 5.3-rc2 
References: <156426997427.6953.14728916479410000420.tglx@nanos.tec.linutronix.de>
Message-ID: <156426997428.6953.243313961246845573.tglx@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest locking-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-for-linus

up to:  6c11c6e3d5e9: locking/mutex: Test for initialized mutex

A set of locking fixes:

  - Address the fallout of the rwsem rework. Missing ACQUIREs and a sanity
    check to prevent a use-after-free

  - Add missing checks for unitialized mutexes when mutex debugging is enabled.

  - Remove the bogus code in the generic SMP variant of arch_futex_atomic_op_inuser()

  - Fixup the #ifdeffery in lockdep to prevent compile warnings

Thanks,

	tglx

------------------>
Arnd Bergmann (2):
      locking/lockdep: Hide unused 'class' variable
      locking/lockdep: Clean up #ifdef checks

Jan Stancek (1):
      locking/rwsem: Add missing ACQUIRE to read_slowpath exit when queue is empty

Peter Zijlstra (3):
      lcoking/rwsem: Add missing ACQUIRE to read_slowpath sleep loop
      tty/ldsem, locking/rwsem: Add missing ACQUIRE to read_failed sleep loop
      locking/rwsem: Add ACQUIRE comments

Sebastian Andrzej Siewior (1):
      locking/mutex: Test for initialized mutex

Vasily Averin (1):
      futex: Cleanup generic SMP variant of arch_futex_atomic_op_inuser()

Waiman Long (1):
      locking/rwsem: Don't call owner_on_cpu() on read-owner


 drivers/tty/tty_ldsem.c       |  5 ++---
 include/asm-generic/futex.h   | 21 +--------------------
 kernel/locking/lockdep.c      | 13 ++++++-------
 kernel/locking/lockdep_proc.c |  3 ++-
 kernel/locking/mutex.c        | 11 ++++++++++-
 kernel/locking/rwsem.c        | 28 ++++++++++++++++++++++------
 6 files changed, 43 insertions(+), 38 deletions(-)

diff --git a/drivers/tty/tty_ldsem.c b/drivers/tty/tty_ldsem.c
index 717292c1c0df..60ff236a3d63 100644
--- a/drivers/tty/tty_ldsem.c
+++ b/drivers/tty/tty_ldsem.c
@@ -93,8 +93,7 @@ static void __ldsem_wake_readers(struct ld_semaphore *sem)
 
 	list_for_each_entry_safe(waiter, next, &sem->read_wait, list) {
 		tsk = waiter->task;
-		smp_mb();
-		waiter->task = NULL;
+		smp_store_release(&waiter->task, NULL);
 		wake_up_process(tsk);
 		put_task_struct(tsk);
 	}
@@ -194,7 +193,7 @@ down_read_failed(struct ld_semaphore *sem, long count, long timeout)
 	for (;;) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
 
-		if (!waiter.task)
+		if (!smp_load_acquire(&waiter.task))
 			break;
 		if (!timeout)
 			break;
diff --git a/include/asm-generic/futex.h b/include/asm-generic/futex.h
index 8666fe7f35d7..02970b11f71f 100644
--- a/include/asm-generic/futex.h
+++ b/include/asm-generic/futex.h
@@ -118,26 +118,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 static inline int
 arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *uaddr)
 {
-	int oldval = 0, ret;
-
-	pagefault_disable();
-
-	switch (op) {
-	case FUTEX_OP_SET:
-	case FUTEX_OP_ADD:
-	case FUTEX_OP_OR:
-	case FUTEX_OP_ANDN:
-	case FUTEX_OP_XOR:
-	default:
-		ret = -ENOSYS;
-	}
-
-	pagefault_enable();
-
-	if (!ret)
-		*oval = oldval;
-
-	return ret;
+	return -ENOSYS;
 }
 
 static inline int
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 341f52117f88..4861cf8e274b 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -448,7 +448,7 @@ static void print_lockdep_off(const char *bug_msg)
 
 unsigned long nr_stack_trace_entries;
 
-#if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)
+#ifdef CONFIG_PROVE_LOCKING
 /*
  * Stack-trace: tightly packed array of stack backtrace
  * addresses. Protected by the graph_lock.
@@ -491,7 +491,7 @@ unsigned int max_lockdep_depth;
 DEFINE_PER_CPU(struct lockdep_stats, lockdep_stats);
 #endif
 
-#if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)
+#ifdef CONFIG_PROVE_LOCKING
 /*
  * Locking printouts:
  */
@@ -2969,7 +2969,7 @@ static void check_chain_key(struct task_struct *curr)
 #endif
 }
 
-#if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)
+#ifdef CONFIG_PROVE_LOCKING
 static int mark_lock(struct task_struct *curr, struct held_lock *this,
 		     enum lock_usage_bit new_bit);
 
@@ -3608,7 +3608,7 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 	return ret;
 }
 
-#else /* defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING) */
+#else /* CONFIG_PROVE_LOCKING */
 
 static inline int
 mark_usage(struct task_struct *curr, struct held_lock *hlock, int check)
@@ -3627,7 +3627,7 @@ static inline int separate_irq_context(struct task_struct *curr,
 	return 0;
 }
 
-#endif /* defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING) */
+#endif /* CONFIG_PROVE_LOCKING */
 
 /*
  * Initialize a lock instance's lock-class mapping info:
@@ -4321,8 +4321,7 @@ static void __lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie cookie
  */
 static void check_flags(unsigned long flags)
 {
-#if defined(CONFIG_PROVE_LOCKING) && defined(CONFIG_DEBUG_LOCKDEP) && \
-    defined(CONFIG_TRACE_IRQFLAGS)
+#if defined(CONFIG_PROVE_LOCKING) && defined(CONFIG_DEBUG_LOCKDEP)
 	if (!debug_locks)
 		return;
 
diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index 65b6a1600c8f..bda006f8a88b 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -200,7 +200,6 @@ static void lockdep_stats_debug_show(struct seq_file *m)
 
 static int lockdep_stats_show(struct seq_file *m, void *v)
 {
-	struct lock_class *class;
 	unsigned long nr_unused = 0, nr_uncategorized = 0,
 		      nr_irq_safe = 0, nr_irq_unsafe = 0,
 		      nr_softirq_safe = 0, nr_softirq_unsafe = 0,
@@ -211,6 +210,8 @@ static int lockdep_stats_show(struct seq_file *m, void *v)
 		      sum_forward_deps = 0;
 
 #ifdef CONFIG_PROVE_LOCKING
+	struct lock_class *class;
+
 	list_for_each_entry(class, &all_lock_classes, lock_entry) {
 
 		if (class->usage_mask == 0)
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index edd1c082dbf5..5e069734363c 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -908,6 +908,10 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 
 	might_sleep();
 
+#ifdef CONFIG_DEBUG_MUTEXES
+	DEBUG_LOCKS_WARN_ON(lock->magic != lock);
+#endif
+
 	ww = container_of(lock, struct ww_mutex, base);
 	if (use_ww_ctx && ww_ctx) {
 		if (unlikely(ww_ctx == READ_ONCE(ww->ctx)))
@@ -1379,8 +1383,13 @@ __ww_mutex_lock_interruptible_slowpath(struct ww_mutex *lock,
  */
 int __sched mutex_trylock(struct mutex *lock)
 {
-	bool locked = __mutex_trylock(lock);
+	bool locked;
+
+#ifdef CONFIG_DEBUG_MUTEXES
+	DEBUG_LOCKS_WARN_ON(lock->magic != lock);
+#endif
 
+	locked = __mutex_trylock(lock);
 	if (locked)
 		mutex_acquire(&lock->dep_map, 0, 1, _RET_IP_);
 
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 37524a47f002..bd0f0d05724c 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -666,7 +666,11 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem,
 	preempt_disable();
 	rcu_read_lock();
 	owner = rwsem_owner_flags(sem, &flags);
-	if ((flags & nonspinnable) || (owner && !owner_on_cpu(owner)))
+	/*
+	 * Don't check the read-owner as the entry may be stale.
+	 */
+	if ((flags & nonspinnable) ||
+	    (owner && !(flags & RWSEM_READER_OWNED) && !owner_on_cpu(owner)))
 		ret = false;
 	rcu_read_unlock();
 	preempt_enable();
@@ -1000,6 +1004,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state)
 	atomic_long_add(-RWSEM_READER_BIAS, &sem->count);
 	adjustment = 0;
 	if (rwsem_optimistic_spin(sem, false)) {
+		/* rwsem_optimistic_spin() implies ACQUIRE on success */
 		/*
 		 * Wake up other readers in the wait list if the front
 		 * waiter is a reader.
@@ -1014,6 +1019,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state)
 		}
 		return sem;
 	} else if (rwsem_reader_phase_trylock(sem, waiter.last_rowner)) {
+		/* rwsem_reader_phase_trylock() implies ACQUIRE on success */
 		return sem;
 	}
 
@@ -1032,6 +1038,8 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state)
 		 */
 		if (adjustment && !(atomic_long_read(&sem->count) &
 		     (RWSEM_WRITER_MASK | RWSEM_FLAG_HANDOFF))) {
+			/* Provide lock ACQUIRE */
+			smp_acquire__after_ctrl_dep();
 			raw_spin_unlock_irq(&sem->wait_lock);
 			rwsem_set_reader_owned(sem);
 			lockevent_inc(rwsem_rlock_fast);
@@ -1065,15 +1073,18 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state)
 	wake_up_q(&wake_q);
 
 	/* wait to be given the lock */
-	while (true) {
+	for (;;) {
 		set_current_state(state);
-		if (!waiter.task)
+		if (!smp_load_acquire(&waiter.task)) {
+			/* Matches rwsem_mark_wake()'s smp_store_release(). */
 			break;
+		}
 		if (signal_pending_state(state, current)) {
 			raw_spin_lock_irq(&sem->wait_lock);
 			if (waiter.task)
 				goto out_nolock;
 			raw_spin_unlock_irq(&sem->wait_lock);
+			/* Ordered by sem->wait_lock against rwsem_mark_wake(). */
 			break;
 		}
 		schedule();
@@ -1083,6 +1094,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state)
 	__set_current_state(TASK_RUNNING);
 	lockevent_inc(rwsem_rlock);
 	return sem;
+
 out_nolock:
 	list_del(&waiter.list);
 	if (list_empty(&sem->wait_list)) {
@@ -1123,8 +1135,10 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 
 	/* do optimistic spinning and steal lock if possible */
 	if (rwsem_can_spin_on_owner(sem, RWSEM_WR_NONSPINNABLE) &&
-	    rwsem_optimistic_spin(sem, true))
+	    rwsem_optimistic_spin(sem, true)) {
+		/* rwsem_optimistic_spin() implies ACQUIRE on success */
 		return sem;
+	}
 
 	/*
 	 * Disable reader optimistic spinning for this rwsem after
@@ -1184,9 +1198,11 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 wait:
 	/* wait until we successfully acquire the lock */
 	set_current_state(state);
-	while (true) {
-		if (rwsem_try_write_lock(sem, wstate))
+	for (;;) {
+		if (rwsem_try_write_lock(sem, wstate)) {
+			/* rwsem_try_write_lock() implies ACQUIRE on success */
 			break;
+		}
 
 		raw_spin_unlock_irq(&sem->wait_lock);
 

