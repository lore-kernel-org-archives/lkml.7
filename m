Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9409EC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 20:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B5F82171F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 20:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfETU7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 16:59:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33966 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbfETU7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 16:59:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5D9643082A9B;
        Mon, 20 May 2019 20:59:43 +0000 (UTC)
Received: from llong.com (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1E79464049;
        Mon, 20 May 2019 20:59:35 +0000 (UTC)
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
Subject: [PATCH v8 00/19] locking/rwsem: Rwsem rearchitecture part 2
Date:   Mon, 20 May 2019 16:58:59 -0400
Message-Id: <20190520205918.22251-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 20 May 2019 20:59:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 v8:
  - Remove v7 patch 1 as it has been merged.
  - Add patch 14 to make rwsem->owner an atomic_long_t as suggested
    by PeterZ.
  - Incorporates other changes suggested by PeterZ like removing
    *_is_spinnable() and owner_without_flags() helpers.

 v7:
  - Fix a bug in patch 1 and include changes suggested by Linus.
  - Refresh the other patches accordingly.

 v6:
  - Add a new patch 1 to fix an existing rwsem bug that allows both
    readers and writer to become rwsem owners simultaneously.
  - Fix a missed wakeup bug (in patch 9) of the v5 series.
  - Fix boot up hang problem on some kernel configurations caused
    by the patch that merge owner into count.
  - Make the adaptive disabling of reader optimistic spinning more
    aggressive to further improve workloads that don't benefit from
    that.
  - Add another patch to disable preemption during down_read() when
    owner is merged into count to prevent the possiblity of reader
    count overflow.
  - Don't allow merging of owner into count if NR_CPUS is greater
    that the max supported reader count.
  - Allow readers dropped out from the optimistic spinning loop to
    attempt a trylock if it is still in the right read phase.
  - Fix incorrect DEBUG_RWSEMS_WARN_ON() warning.

This is part 2 of a 3-part (0/1/2) series to rearchitect the internal
operation of rwsem. Both part 0 and part 1 are merged into tip.

This patchset revamps the current rwsem-xadd implementation to make
it saner and easier to work with. It also implements the following 3
new features:

 1) Waiter lock handoff
 2) Reader optimistic spinning with adapative disabling
 3) Store write-lock owner in the atomic count (x86-64 only for now)

Waiter lock handoff is similar to the mechanism currently in the mutex
code. This ensures that lock starvation won't happen.

Reader optimistic spinning enables readers to acquire the lock more
quickly.  So workloads that use a mix of readers and writers should
see an increase in performance as long as the reader critical sections
are short. For those workloads that have long reader critical sections
reader optimistic spinning may hurt performance, so an adaptive disabling
mechanism is also implemented to disable it when reader-owned lock
spinning timeouts happen.

Finally, storing the write-lock owner into the count will allow
optimistic spinners to get to the lock holder's task structure more
quickly and eliminating the timing gap where the write lock is acquired
but the owner isn't known yet. This is important for RT tasks where
spinning on a lock with an unknown owner is not allowed.

Because of the fact that multiple readers can share the same lock,
there is a natural preference for readers when measuring in term of
locking throughput as more readers are likely to get into the locking
fast path than the writers. With waiter lock handoff, we are not going
to starve the writers.

On a 2-socket 40-core 80-thread Skylake system with 40 reader and writer
locking threads, the min/mean/max locking operations done in a 5-second
testing window before the patchset were:

  40 readers, Iterations Min/Mean/Max = 1,807/1,808/1,810
  40 writers, Iterations Min/Mean/Max = 1,807/50,344/151,255

After the patchset, they became:

  40 readers, Iterations Min/Mean/Max = 30,057/31,359/32,741
  40 writers, Iterations Min/Mean/Max = 94,466/95,845/97,098

It can be seen that the performance improves for both readers and writers.
It also makes rwsem fairer to readers as well as among different threads
within the reader and writer groups.

Patch 1 makes owner a permanent member of the rw_semaphore structure and
set it irrespective of CONFIG_RWSEM_SPIN_ON_OWNER.

Patch 2 removes rwsem_wake() wakeup optimization as it doesn't work
with lock handoff.

Patch 3 implements a new rwsem locking scheme similar to what qrwlock
is current doing. Write lock is done by atomic_cmpxchg() while read
lock is still being done by atomic_add().

Patch 4 merges the content of rwsem.h and rwsem-xadd.c into rwsem.c just
like the mutex. The rwsem-xadd.c is removed and a bare-bone rwsem.h is
left for internal function declaration needed by percpu-rwsem.c.

Patch 5 optimizes the merged rwsem.c file to generate smaller object
file and performs other miscellaneous code cleanups.

Patch 6 makes rwsem_spin_on_owner() returns owner state.

Patch 7 implments lock handoff to prevent lock starvation. It is expected
that throughput will be lower on workloads with highly contended rwsems
for better fairness.

Patch 8 makes sure that all wake_up_q() calls happened after dropping
the wait_lock.

Patch 9 makes RT task's handling of NULL owner more optimal.

Patch 10 makes reader wakeup to wake up almost all the readers in the
wait queue instead of just those in the front.

Patch 11 renames the RWSEM_ANONYMOUSLY_OWNED bit to RWSEM_NONSPINNABLE.

Patch 12 enables reader to spin on a writer-owned rwsem.

Patch 13 makes rwsem->owner an atomic_long_t as it is now holding some
flags that may need to be atomically updated.

Patch 14 enables a writer to spin on a reader-owned rwsem for at most
25us and extends the RWSEM_NONSPINNABLE bit to 2 separate ones - one
for readers and one for writers.

Patch 15 implements the adaptive disabling of reader optimistic spinning
when the reader-owned rwsem spinning timeouts happen.

Patch 16 handles the case of too many readers by reserving the sign
bit to designate that a reader lock attempt will fail and the locking
reader will be put to sleep. This will ensure that we will not overflow
the reader count.

Patch 17 merges the write-lock owner task pointer into the count.
Only 64-bit count has enough space to provide a reasonable number of
bits for reader count. This is for x86-64 only for the time being.

Patch 18 eliminates redundant computation of the merged owner-count.

Patch 19 disable preemption during the down_read() call to eliminate
the remote possibility that the reader count may overflow.

With a locking microbenchmark running on 5.1 based kernel, the total
locking rates (in kops/s) on a 2-socket Skylake system with equal numbers
of readers and writers (mixed) before and after this patchset were:

   # of Threads   Before Patch      After Patch
   ------------   ------------      -----------
        2            2,618             4,193
        4            1,202             3,726
        8              802             3,622
       16              729             3,359
       32              319             2,826
       64              102             2,744

On workloads where the rwsem reader critical section is relatively long
(longer than the spinning period), optimistic of writer on reader-owned
rwsem may not be that helpful. In fact, the performance may regress
in some cases like the will-it-sclae page_fault1 microbenchmark. This
is likely due to the fact that larger reader groups where the readers
acquire the lock together are broken into smaller ones. So more work
will be needed to better tune the rwsem code to that kind of workload.

The v7-to-v8 diff is attached at the end.

Waiman Long (19):
  locking/rwsem: Make owner available even if
    !CONFIG_RWSEM_SPIN_ON_OWNER
  locking/rwsem: Remove rwsem_wake() wakeup optimization
  locking/rwsem: Implement a new locking scheme
  locking/rwsem: Merge rwsem.h and rwsem-xadd.c into rwsem.c
  locking/rwsem: Code cleanup after files merging
  locking/rwsem: Make rwsem_spin_on_owner() return owner state
  locking/rwsem: Implement lock handoff to prevent lock starvation
  locking/rwsem: Always release wait_lock before waking up tasks
  locking/rwsem: More optimal RT task handling of null owner
  locking/rwsem: Wake up almost all readers in wait queue
  locking/rwsem: Clarify usage of owner's nonspinaable bit
  locking/rwsem: Enable readers spinning on writer
  locking/rwsem: Make rwsem->owner an atomic_long_t
  locking/rwsem: Enable time-based spinning on reader-owned rwsem
  locking/rwsem: Adaptive disabling of reader optimistic spinning
  locking/rwsem: Guard against making count negative
  locking/rwsem: Merge owner into count on x86-64
  locking/rwsem: Remove redundant computation of writer lock word
  locking/rwsem: Disable preemption in down_read*() if owner in count

 arch/x86/Kconfig                  |    6 +
 include/linux/percpu-rwsem.h      |    4 +-
 include/linux/rwsem.h             |   16 +-
 include/linux/sched/wake_q.h      |    5 +
 kernel/Kconfig.locks              |   12 +
 kernel/locking/Makefile           |    2 +-
 kernel/locking/lock_events_list.h |   12 +-
 kernel/locking/rwsem-xadd.c       |  745 -------------
 kernel/locking/rwsem.c            | 1668 ++++++++++++++++++++++++++++-
 kernel/locking/rwsem.h            |  306 +-----
 lib/Kconfig.debug                 |    8 +-
 11 files changed, 1694 insertions(+), 1090 deletions(-)
 delete mode 100644 kernel/locking/rwsem-xadd.c

-- 

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
index 60783267b50d..cede2f99220b 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -107,7 +107,7 @@
 	if (!debug_locks_silent &&				\
 	    WARN_ONCE(c, "DEBUG_RWSEMS_WARN_ON(%s): count = 0x%lx, owner = 0x%lx, curr 0x%lx, list %sempty\n",\
 		#c, atomic_long_read(&(sem)->count),		\
-		(long)((sem)->owner), (long)current,		\
+		atomic_long_read(&(sem)->owner), (long)current,	\
 		list_empty(&(sem)->wait_list) ? "" : "not "))	\
 			debug_locks_off();			\
 	} while (0)
@@ -174,9 +174,9 @@
  * atomic_long_cmpxchg() will be used to obtain writer lock.
  *
  * There are three places where the lock handoff bit may be set or cleared.
- * 1) __rwsem_mark_wake() for readers.
+ * 1) rwsem_mark_wake() for readers.
  * 2) rwsem_try_write_lock() for writers.
- * 3) Error path of __rwsem_down_write_failed_common().
+ * 3) Error path of rwsem_down_write_slowpath().
  *
  * For all the above cases, wait_lock will be held. A writer must also
  * be the first one in the wait_list to be eligible for setting the handoff
@@ -259,12 +259,20 @@ static inline unsigned long rwsem_count_owner(long count)
 
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
@@ -280,11 +288,10 @@ static inline void rwsem_clear_owner(struct rw_semaphore *sem)
 static inline void __rwsem_set_reader_owned(struct rw_semaphore *sem,
 					    struct task_struct *owner)
 {
-	unsigned long val = (unsigned long)owner | RWSEM_READER_OWNED |
-			   ((unsigned long)READ_ONCE(sem->owner) &
-			     RWSEM_RD_NONSPINNABLE);
+	long val = (long)owner | RWSEM_READER_OWNED |
+		   (atomic_long_read(&sem->owner) & RWSEM_RD_NONSPINNABLE);
 
-	WRITE_ONCE(sem->owner, (struct task_struct *)val);
+	atomic_long_set(&sem->owner, val);
 }
 
 static inline void rwsem_set_reader_owned(struct rw_semaphore *sem)
@@ -292,34 +299,6 @@ static inline void rwsem_set_reader_owned(struct rw_semaphore *sem)
 	__rwsem_set_reader_owned(sem, current);
 }
 
-/*
- * Return true if the a rwsem waiter can spin on the rwsem's owner
- * and steal the lock.
- * N.B. !owner is considered spinnable.
- */
-static inline bool is_rwsem_owner_spinnable(struct task_struct *owner, bool wr)
-{
-	unsigned long bit = wr ? RWSEM_WR_NONSPINNABLE : RWSEM_RD_NONSPINNABLE;
-
-	return !((unsigned long)owner & bit);
-}
-
-/*
- * Return true if the rwsem is spinnable.
- */
-static inline bool is_rwsem_spinnable(struct rw_semaphore *sem, bool wr)
-{
-	return is_rwsem_owner_spinnable(READ_ONCE(sem->owner), wr);
-}
-
-/*
- * Remove all the flag bits from owner.
- */
-static inline struct task_struct *owner_without_flags(struct task_struct *owner)
-{
-	return (struct task_struct *)((long)owner & ~RWSEM_OWNER_FLAGS_MASK);
-}
-
 /*
  * Return true if the rwsem is owned by a reader.
  */
@@ -334,7 +313,7 @@ static inline bool is_rwsem_reader_owned(struct rw_semaphore *sem)
 	if (count & RWSEM_WRITER_MASK)
 		return false;
 #endif
-	return (unsigned long)sem->owner & RWSEM_READER_OWNED;
+	return rwsem_test_oflags(sem, RWSEM_READER_OWNED);
 }
 
 #ifdef CONFIG_DEBUG_RWSEMS
@@ -346,11 +325,13 @@ static inline bool is_rwsem_reader_owned(struct rw_semaphore *sem)
  */
 static inline void rwsem_clear_reader_owned(struct rw_semaphore *sem)
 {
-	unsigned long owner = (unsigned long)READ_ONCE(sem->owner);
+	long val = atomic_long_read(&sem->owner);
 
-	if ((owner & ~RWSEM_OWNER_FLAGS_MASK) == (unsigned long)current)
-		cmpxchg_relaxed((unsigned long *)&sem->owner, owner,
-				owner & RWSEM_OWNER_FLAGS_MASK);
+	while ((val & ~RWSEM_OWNER_FLAGS_MASK) == (long)current) {
+		if (atomic_long_try_cmpxchg(&sem->owner, &val,
+					    val & RWSEM_OWNER_FLAGS_MASK))
+			return;
+	}
 }
 #else
 static inline void rwsem_clear_reader_owned(struct rw_semaphore *sem)
@@ -364,13 +345,13 @@ static inline void rwsem_clear_reader_owned(struct rw_semaphore *sem)
  */
 static inline void rwsem_set_nonspinnable(struct rw_semaphore *sem)
 {
-	long owner = (long)READ_ONCE(sem->owner);
+	long owner = atomic_long_read(&sem->owner);
 
 	while (owner & RWSEM_READER_OWNED) {
-		if (!is_rwsem_owner_spinnable((void *)owner, false))
+		if (owner & RWSEM_NONSPINNABLE)
 			break;
-		owner = cmpxchg((long *)&sem->owner, owner,
-				owner | RWSEM_NONSPINNABLE);
+		owner = atomic_long_cmpxchg(&sem->owner, owner,
+					    owner | RWSEM_NONSPINNABLE);
 	}
 }
 
@@ -395,16 +376,22 @@ static inline void rwsem_set_nonspinnable(struct rw_semaphore *sem)
 
 /*
  * Get the owner value from count to have early access to the task structure.
- * Owner from sem->count should includes the RWSEM_NONSPINNABLE bits
- * from sem->owner.
  */
-static inline struct task_struct *rwsem_get_owner(struct rw_semaphore *sem)
+static inline struct task_struct *rwsem_read_owner(struct rw_semaphore *sem)
 {
-	unsigned long cowner = rwsem_count_owner(atomic_long_read(&sem->count));
-	unsigned long sowner = (unsigned long)READ_ONCE(sem->owner);
+	return (struct task_struct *)
+		rwsem_count_owner(atomic_long_read(&sem->count));
+}
 
-	return (struct task_struct *) (cowner
-		? cowner | (sowner & RWSEM_NONSPINNABLE) : sowner);
+/*
+ * Return the real task structure pointer of the owner and the embedded
+ * flags in the owner.
+ */
+static inline struct task_struct *
+rwsem_read_owner_flags(struct rw_semaphore *sem, long *pflags)
+{
+	*pflags = atomic_long_read(&sem->owner) & RWSEM_OWNER_FLAGS_MASK;
+	return rwsem_read_owner(sem);
 }
 
 /*
@@ -448,15 +435,33 @@ static int __init rwsem_show_count_status(void)
 	return 0;
 }
 late_initcall(rwsem_show_count_status);
+
 #else /* !MERGE_OWNER_INTO_COUNT */
 
 #define rwsem_preempt_disable()
 #define rwsem_preempt_enable()
 #define rwsem_schedule_preempt_disabled()	schedule()
 
-static inline struct task_struct *rwsem_get_owner(struct rw_semaphore *sem)
+/*
+ * Return just the real task structure pointer of the owner
+ */
+static inline struct task_struct *rwsem_read_owner(struct rw_semaphore *sem)
 {
-	return READ_ONCE(sem->owner);
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
 }
 
 static inline long rwsem_read_trylock(struct rw_semaphore *sem, long *cnt)
@@ -499,7 +504,7 @@ void __init_rwsem(struct rw_semaphore *sem, const char *name,
 	atomic_long_set(&sem->count, RWSEM_UNLOCKED_VALUE);
 	raw_spin_lock_init(&sem->wait_lock);
 	INIT_LIST_HEAD(&sem->wait_list);
-	sem->owner = NULL;
+	atomic_long_set(&sem->owner, 0L);
 #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
 	osq_lock_init(&sem->osq);
 #endif
@@ -516,7 +521,7 @@ struct rwsem_waiter {
 	struct task_struct *task;
 	enum rwsem_waiter_type type;
 	unsigned long timeout;
-	unsigned long last_rowner;
+	long last_rowner;
 };
 #define rwsem_first_waiter(sem) \
 	list_first_entry(&sem->wait_list, struct rwsem_waiter, list)
@@ -560,9 +565,9 @@ enum writer_wait_state {
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
@@ -722,25 +727,31 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
  * If wstate is WRITER_HANDOFF, it will make sure that either the handoff
  * bit is set or the lock is acquired with handoff bit cleared.
  */
-static inline bool rwsem_try_write_lock(long count, struct rw_semaphore *sem,
+static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
 					const long wlock,
 					enum writer_wait_state wstate)
 {
-	long new;
+	long count, new;
 
 	lockdep_assert_held(&sem->wait_lock);
+
+	count = atomic_long_read(&sem->count);
 	do {
 		bool has_handoff = !!(count & RWSEM_FLAG_HANDOFF);
 
 		if (has_handoff && wstate == WRITER_NOT_FIRST)
 			return false;
 
+		new = count;
+
 		if (count & RWSEM_LOCK_MASK) {
 			if (has_handoff || (wstate != WRITER_HANDOFF))
 				return false;
-			new = count | RWSEM_FLAG_HANDOFF;
+
+			new |= RWSEM_FLAG_HANDOFF;
 		} else {
-			new = (count | wlock) & ~RWSEM_FLAG_HANDOFF;
+			new |= wlock;
+			new &= ~RWSEM_FLAG_HANDOFF;
 
 			if (list_is_singular(&sem->wait_list))
 				new &= ~RWSEM_FLAG_WAITERS;
@@ -804,11 +815,6 @@ static inline bool rwsem_try_write_lock_unqueued(struct rw_semaphore *sem,
 
 static inline bool owner_on_cpu(struct task_struct *owner)
 {
-	/*
-	 * Clear all the flag bits in owner
-	 */
-	owner = owner_without_flags(owner);
-
 	/*
 	 * As lock holder preemption issue, we both skip spinning if
 	 * task is not on cpu or its cpu is preempted
@@ -816,12 +822,14 @@ static inline bool owner_on_cpu(struct task_struct *owner)
 	return owner->on_cpu && !vcpu_is_preempted(task_cpu(owner));
 }
 
-static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem, bool wr)
+static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem,
+					   long nonspinnable)
 {
 	struct task_struct *owner;
+	long flags;
 	bool ret = true;
 
-	BUILD_BUG_ON(is_rwsem_owner_spinnable(RWSEM_OWNER_UNKNOWN, true));
+	BUILD_BUG_ON(!(RWSEM_OWNER_UNKNOWN & RWSEM_NONSPINNABLE));
 
 	if (need_resched()) {
 		lockevent_inc(rwsem_opt_fail);
@@ -830,17 +838,12 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem, bool wr)
 
 	preempt_disable();
 	rcu_read_lock();
-
-	owner = rwsem_get_owner(sem);
-	if (!is_rwsem_owner_spinnable(owner, wr))
+	owner = rwsem_read_owner_flags(sem, &flags);
+	if ((flags & nonspinnable) || (owner && !owner_on_cpu(owner)))
 		ret = false;
-	else if ((unsigned long)owner & RWSEM_READER_OWNED)
-		ret = true;
-	else if ((owner = owner_without_flags(owner)))
-		ret = owner_on_cpu(owner);
-
 	rcu_read_unlock();
 	preempt_enable();
+
 	lockevent_cond_inc(rwsem_opt_fail, !ret);
 	return ret;
 }
@@ -864,26 +867,27 @@ enum owner_state {
 };
 #define OWNER_SPINNABLE		(OWNER_NULL | OWNER_WRITER | OWNER_READER)
 
-static inline enum owner_state rwsem_owner_state(unsigned long owner, bool wr)
+static inline enum owner_state rwsem_owner_state(struct task_struct *owner,
+						 long flags, long nonspinnable)
 {
-	if (!is_rwsem_owner_spinnable((void *)owner, wr))
+	if (flags & nonspinnable)
 		return OWNER_NONSPINNABLE;
 
-	if (owner & RWSEM_READER_OWNED)
+	if (flags & RWSEM_READER_OWNED)
 		return OWNER_READER;
 
-	if (!(owner & ~RWSEM_OWNER_FLAGS_MASK))
-		return OWNER_NULL;
-
-	return OWNER_WRITER;
+	return owner ? OWNER_WRITER : OWNER_NULL;
 }
 
-static noinline enum owner_state
-rwsem_spin_on_owner(struct rw_semaphore *sem, bool wr)
+static noinline enum owner_state rwsem_spin_on_owner(struct rw_semaphore *sem,
+						     long nonspinnable)
 {
-	struct task_struct *tmp, *owner = rwsem_get_owner(sem);
-	enum owner_state state = rwsem_owner_state((unsigned long)owner, wr);
+	struct task_struct *new, *owner;
+	long flags, new_flags;
+	enum owner_state state;
 
+	owner = rwsem_read_owner_flags(sem, &flags);
+	state = rwsem_owner_state(owner, flags, nonspinnable);
 	if (state != OWNER_WRITER)
 		return state;
 
@@ -894,9 +898,9 @@ rwsem_spin_on_owner(struct rw_semaphore *sem, bool wr)
 			break;
 		}
 
-		tmp = rwsem_get_owner(sem);
-		if (tmp != owner) {
-			state = rwsem_owner_state((unsigned long)tmp, wr);
+		new = rwsem_read_owner_flags(sem, &new_flags);
+		if ((new != owner) || (new_flags != flags)) {
+			state = rwsem_owner_state(new, new_flags, nonspinnable);
 			break;
 		}
 
@@ -923,40 +927,24 @@ rwsem_spin_on_owner(struct rw_semaphore *sem, bool wr)
 /*
  * Calculate reader-owned rwsem spinning threshold for writer
  *
- * It is assumed that the more readers own the rwsem, the longer it will
- * take for them to wind down and free the rwsem. So the formula to
- * determine the actual spinning time limit is:
- *
- * 1) RWSEM_FLAG_WAITERS set
- *    Spinning threshold = (10 + nr_readers/2)us
+ * The more readers own the rwsem, the longer it will take for them to
+ * wind down and free the rwsem. So the empirical formula used to
+ * determine the actual spinning time limit here is:
  *
- * 2) RWSEM_FLAG_WAITERS not set
- *    Spinning threshold = 25us
+ *   Spinning threshold = (10 + nr_readers/2)us
  *
- * In the first case when RWSEM_FLAG_WAITERS is set, no new reader can
- * become rwsem owner. It is assumed that the more readers own the rwsem,
- * the longer it will take for them to wind down and free the rwsem. In
- * addition, if it happens that a previous task that releases the lock
- * is in the process of waking up readers one-by-one, the process will
- * take longer when more readers needed to be woken up. This is subjected
- * to a maximum value of 25us.
- *
- * In the second case with RWSEM_FLAG_WAITERS off, new readers can join
- * and become one of the owners. So assuming for the worst case and spin
- * for at most 25us.
+ * The limit is capped to a maximum of 25us (30 readers). This is just
+ * a heuristic and is subjected to change in the future.
  */
 static inline u64 rwsem_rspin_threshold(struct rw_semaphore *sem)
 {
 	long count = atomic_long_read(&sem->count);
-	u64 delta = 25 * NSEC_PER_USEC;
+	int readers = count >> RWSEM_READER_SHIFT;
+	u64 delta;
 
-	if (count & RWSEM_FLAG_WAITERS) {
-		int readers = count >> RWSEM_READER_SHIFT;
-
-		if (readers > 30)
-			readers = 30;
-		delta = (20 + readers) * NSEC_PER_USEC / 2;
-	}
+	if (readers > 30)
+		readers = 30;
+	delta = (20 + readers) * NSEC_PER_USEC / 2;
 
 	return sched_clock() + delta;
 }
@@ -967,6 +955,8 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem, const long wlock)
 	int prev_owner_state = OWNER_NULL;
 	int loop = 0;
 	u64 rspin_threshold = 0;
+	long nonspinnable = wlock ? RWSEM_WR_NONSPINNABLE
+				  : RWSEM_RD_NONSPINNABLE;
 
 	preempt_disable();
 
@@ -981,8 +971,9 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem, const long wlock)
 	 *  2) readers own the lock and spinning time has exceeded limit.
 	 */
 	for (;;) {
-		enum owner_state owner_state = rwsem_spin_on_owner(sem, wlock);
+		enum owner_state owner_state;
 
+		owner_state = rwsem_spin_on_owner(sem, nonspinnable);
 		if (!(owner_state & OWNER_SPINNABLE))
 			break;
 
@@ -1007,7 +998,7 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem, const long wlock)
 			 * the beginning of the 2nd reader phase.
 			 */
 			if (prev_owner_state != OWNER_READER) {
-				if (!is_rwsem_spinnable(sem, wlock))
+				if (rwsem_test_oflags(sem, nonspinnable))
 					break;
 				rspin_threshold = rwsem_rspin_threshold(sem);
 				loop = 0;
@@ -1095,9 +1086,8 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem, const long wlock)
  */
 static inline void clear_wr_nonspinnable(struct rw_semaphore *sem)
 {
-	if (!is_rwsem_spinnable(sem, true))
-		atomic_long_andnot(RWSEM_WR_NONSPINNABLE,
-				  (atomic_long_t *)&sem->owner);
+	if (rwsem_test_oflags(sem, RWSEM_WR_NONSPINNABLE))
+		atomic_long_andnot(RWSEM_WR_NONSPINNABLE, &sem->owner);
 }
 
 /*
@@ -1120,9 +1110,9 @@ static inline void clear_wr_nonspinnable(struct rw_semaphore *sem)
  * not be here at all.
  */
 static inline bool rwsem_reader_phase_trylock(struct rw_semaphore *sem,
-					      unsigned long last_rowner)
+					      long last_rowner)
 {
-	unsigned long owner = (unsigned long)READ_ONCE(sem->owner);
+	long owner = atomic_long_read(&sem->owner);
 
 	if (!(owner & RWSEM_READER_OWNED))
 		return false;
@@ -1137,7 +1127,8 @@ static inline bool rwsem_reader_phase_trylock(struct rw_semaphore *sem,
 	return false;
 }
 #else
-static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem, bool wr)
+static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem,
+					   long nonspinnable)
 {
 	return false;
 }
@@ -1180,7 +1171,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state, long adjustment)
 		 * holding or trying to acquire the lock. So disable
 		 * optimistic spinning and go directly into the wait list.
 		 */
-		if (is_rwsem_spinnable(sem, false))
+		if (rwsem_test_oflags(sem, RWSEM_RD_NONSPINNABLE))
 			rwsem_set_nonspinnable(sem);
 		goto queue;
 	}
@@ -1189,11 +1180,11 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state, long adjustment)
 	 * Save the current read-owner of rwsem, if available, and the
 	 * reader nonspinnable bit.
 	 */
-	waiter.last_rowner = (long)READ_ONCE(sem->owner);
+	waiter.last_rowner = atomic_long_read(&sem->owner);
 	if (!(waiter.last_rowner & RWSEM_READER_OWNED))
 		waiter.last_rowner &= RWSEM_RD_NONSPINNABLE;
 
-	if (!rwsem_can_spin_on_owner(sem, false))
+	if (!rwsem_can_spin_on_owner(sem, RWSEM_RD_NONSPINNABLE))
 		goto queue;
 
 	/*
@@ -1209,8 +1200,8 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state, long adjustment)
 		if ((atomic_long_read(&sem->count) & RWSEM_FLAG_WAITERS)) {
 			raw_spin_lock_irq(&sem->wait_lock);
 			if (!list_empty(&sem->wait_list))
-				__rwsem_mark_wake(sem, RWSEM_WAKE_READ_OWNED,
-						  &wake_q);
+				rwsem_mark_wake(sem, RWSEM_WAKE_READ_OWNED,
+						&wake_q);
 			raw_spin_unlock_irq(&sem->wait_lock);
 			wake_up_q(&wake_q);
 		}
@@ -1261,7 +1252,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state, long adjustment)
 	}
 	if (wake || (!(count & RWSEM_WRITER_MASK) &&
 		    (adjustment & RWSEM_FLAG_WAITERS)))
-		__rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
+		rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
 
 	raw_spin_unlock_irq(&sem->wait_lock);
 	wake_up_q(&wake_q);
@@ -1297,11 +1288,15 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state, long adjustment)
 	return ERR_PTR(-EINTR);
 }
 
+/*
+ * This function is called by the a write lock owner. So the owner value
+ * won't get changed by others.
+ */
 static inline void rwsem_disable_reader_optspin(struct rw_semaphore *sem,
 						bool disable)
 {
 	if (unlikely(disable)) {
-		*((unsigned long *)&sem->owner) |= RWSEM_RD_NONSPINNABLE;
+		atomic_long_or(RWSEM_RD_NONSPINNABLE, &sem->owner);
 		lockevent_inc(rwsem_opt_norspin);
 	}
 }
@@ -1321,7 +1316,7 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 	const long wlock = RWSEM_WRITER_LOCKED;
 
 	/* do optimistic spinning and steal lock if possible */
-	if (rwsem_can_spin_on_owner(sem, true) &&
+	if (rwsem_can_spin_on_owner(sem, RWSEM_WR_NONSPINNABLE) &&
 	    rwsem_optimistic_spin(sem, wlock))
 		return sem;
 
@@ -1330,7 +1325,7 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 	 * acquiring the write lock when the setting of the nonspinnable
 	 * bits are observed.
 	 */
-	disable_rspin = (long)READ_ONCE(sem->owner) & RWSEM_NONSPINNABLE;
+	disable_rspin = atomic_long_read(&sem->owner) & RWSEM_NONSPINNABLE;
 
 	/*
 	 * Optimistic spinning failed, proceed to the slowpath
@@ -1362,7 +1357,7 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 		if (count & RWSEM_WRITER_MASK)
 			goto wait;
 
-		__rwsem_mark_wake(sem, (count & RWSEM_READER_MASK)
+		rwsem_mark_wake(sem, (count & RWSEM_READER_MASK)
 					? RWSEM_WAKE_READERS
 					: RWSEM_WAKE_ANY, &wake_q);
 
@@ -1375,25 +1370,16 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 			wake_up_q(&wake_q);
 			wake_q_init(&wake_q);	/* Used again, reinit */
 			raw_spin_lock_irq(&sem->wait_lock);
-			/*
-			 * This waiter may have become first in the wait
-			 * list after re-acquring the wait_lock. The
-			 * rwsem_first_waiter() test in the main while
-			 * loop below will correctly detect that. We do
-			 * need to reload count to perform proper trylock
-			 * and avoid missed wakeup.
-			 */
-			count = atomic_long_read(&sem->count);
 		}
 	} else {
-		count = atomic_long_add_return(RWSEM_FLAG_WAITERS, &sem->count);
+		atomic_long_or(RWSEM_FLAG_WAITERS, &sem->count);
 	}
 
 wait:
 	/* wait until we successfully acquire the lock */
 	set_current_state(state);
 	while (true) {
-		if (rwsem_try_write_lock(count, sem, wlock, wstate))
+		if (rwsem_try_write_lock(sem, wlock, wstate))
 			break;
 
 		raw_spin_unlock_irq(&sem->wait_lock);
@@ -1434,7 +1420,6 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 		}
 
 		raw_spin_lock_irq(&sem->wait_lock);
-		count = atomic_long_read(&sem->count);
 	}
 	__set_current_state(TASK_RUNNING);
 	list_del(&waiter.list);
@@ -1455,7 +1440,7 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 	if (list_empty(&sem->wait_list))
 		atomic_long_andnot(RWSEM_FLAG_WAITERS, &sem->count);
 	else
-		__rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
+		rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
 	raw_spin_unlock_irq(&sem->wait_lock);
 	wake_up_q(&wake_q);
 	lockevent_inc(rwsem_wlock_fail);
@@ -1475,7 +1460,7 @@ static struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem, long count)
 	raw_spin_lock_irqsave(&sem->wait_lock, flags);
 
 	if (!list_empty(&sem->wait_list))
-		__rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
+		rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
 
 	raw_spin_unlock_irqrestore(&sem->wait_lock, flags);
 	wake_up_q(&wake_q);
@@ -1496,7 +1481,7 @@ static struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem)
 	raw_spin_lock_irqsave(&sem->wait_lock, flags);
 
 	if (!list_empty(&sem->wait_list))
-		__rwsem_mark_wake(sem, RWSEM_WAKE_READ_OWNED, &wake_q);
+		rwsem_mark_wake(sem, RWSEM_WAKE_READ_OWNED, &wake_q);
 
 	raw_spin_unlock_irqrestore(&sem->wait_lock, flags);
 	wake_up_q(&wake_q);
@@ -1572,7 +1557,12 @@ static inline void __down_write(struct rw_semaphore *sem)
 	else
 		rwsem_set_owner(sem);
 #ifdef MERGE_OWNER_INTO_COUNT
-	DEBUG_RWSEMS_WARN_ON(sem->owner != rwsem_get_owner(sem), sem);
+	/*
+	 * Make sure that count<=>owner translation is correct.
+	 */
+	DEBUG_RWSEMS_WARN_ON(
+		(atomic_long_read(&sem->owner) & ~RWSEM_OWNER_FLAGS_MASK) !=
+		(long)rwsem_read_owner(sem), sem);
 #endif
 }
 
@@ -1631,8 +1621,8 @@ static inline void __up_write(struct rw_semaphore *sem)
 	 * sem->owner may differ from current if the ownership is transferred
 	 * to an anonymous writer by setting the RWSEM_NONSPINNABLE bits.
 	 */
-	DEBUG_RWSEMS_WARN_ON((sem->owner != current) &&
-			    !((long)sem->owner & RWSEM_NONSPINNABLE), sem);
+	DEBUG_RWSEMS_WARN_ON((rwsem_read_owner(sem) != current) &&
+			    !rwsem_test_oflags(sem, RWSEM_NONSPINNABLE), sem);
 	rwsem_clear_owner(sem);
 	tmp = atomic_long_fetch_and_release(~RWSEM_WRITER_MASK, &sem->count);
 	if (unlikely(tmp & RWSEM_FLAG_WAITERS))
@@ -1653,7 +1643,7 @@ static inline void __downgrade_write(struct rw_semaphore *sem)
 	 * read-locked region is ok to be re-ordered into the
 	 * write side. As such, rely on RELEASE semantics.
 	 */
-	DEBUG_RWSEMS_WARN_ON(owner_without_flags(sem->owner) != current, sem);
+	DEBUG_RWSEMS_WARN_ON(rwsem_read_owner(sem) != current, sem);
 	tmp = atomic_long_fetch_add_release(
 		-RWSEM_WRITER_LOCKED+RWSEM_READER_BIAS, &sem->count);
 	rwsem_set_reader_owned(sem);
