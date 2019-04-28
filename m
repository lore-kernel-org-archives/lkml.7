Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34C5C43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 15:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46B9A206E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 15:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfD1P63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 11:58:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39916 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726744AbfD1P63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 11:58:29 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4679BC057F2F;
        Sun, 28 Apr 2019 15:58:28 +0000 (UTC)
Received: from llong.com (ovpn-120-22.rdu2.redhat.com [10.10.120.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4598563BA4;
        Sun, 28 Apr 2019 15:58:22 +0000 (UTC)
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
Subject: [PATCH-tip v6 00/20] locking/rwsem: Rwsem rearchitecture part 2
Date:   Sun, 28 Apr 2019 11:57:35 -0400
Message-Id: <20190428155755.14267-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Sun, 28 Apr 2019 15:58:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

 v5:
  - Drop v4 patch 1 as it is merged into tip's locking/core branch.
  - Integrate the 2 followup patches into the series. The first
    follow-up patch is broken into 2 pieces. The first piece comes in
    before the "Enable readers spinning on writer" and the 2nd piece
    is merged into the "Enable time-based spinning on reader-owned
    rwsem" patch. The 2nd followup patch is added after that.
  - Add a new patch to make all wake_up_q() calls after dropping
    wait_lock as suggested by PeterZ.
  - Incorporate numerouos suggestions by PeterZ and Davidlohr.

 v4:
  - Fix the missing initialization bug with !CONFIG_RWSEM_SPIN_ON_OWNER
    in patch 2.
  - Move the "Remove rwsem_wake() wakeup optimization" patch before
    the "Implement a new locking scheme" patch.
  - Add two new patches to merge the relevant content of rwsem.h and
    rwsem-xadd.c into rwsem.c as suggested by PeterZ.
  - Refactor the lock handoff patch to make all setting and clearing
    of the handoff bit serialized by wait_lock to ensure correctness.
  - Adapt the rest of the patches to the new code base.

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

  40 readers, Iterations Min/Mean/Max = 2,017/2,018/2,022
  40 writers, Iterations Min/Mean/Max = 2,018/60,936/142,804

After the patchset, they became:

  40 readers, Iterations Min/Mean/Max = 33,648/35,442/37,748
  40 writers, Iterations Min/Mean/Max = 91,033/92,342/93,474

It can be seen that the performance improves for both readers and writers.
It also makes rwsem fairer to readers as well as among different threads
within the reader and writer groups.

Patch 1 fixes an existing rwsem bug that allows both readers and
writer to become the rwsem owners simultaneously which may lead to
data corruption.

Patch 2 makes owner a permanent member of the rw_semaphore structure and
set it irrespective of CONFIG_RWSEM_SPIN_ON_OWNER.

Patch 3 removes rwsem_wake() wakeup optimization as it doesn't work
with lock handoff.

Patch 4 implements a new rwsem locking scheme similar to what qrwlock
is current doing. Write lock is done by atomic_cmpxchg() while read
lock is still being done by atomic_add().

Patch 5 merges the content of rwsem.h and rwsem-xadd.c into rwsem.c just
like the mutex. The rwsem-xadd.c is removed and a bare-bone rwsem.h is
left for internal function declaration needed by percpu-rwsem.c.

Patch 6 optimizes the merged rwsem.c file to generate smaller object
file and performs other miscellaneous code cleanups.

Patch 7 makes rwsem_spin_on_owner() returns owner state.

Patch 8 implments lock handoff to prevent lock starvation. It is expected
that throughput will be lower on workloads with highly contended rwsems
for better fairness.

Patch 9 makes sure that all wake_up_q() calls happened after dropping
the wait_lock.

Patch 10 makes RT task's handling of NULL owner more optimal.

Patch 11 makes reader wakeup to wake up almost all the readers in the
wait queue instead of just those in the front.

Patch 12 renames the RWSEM_ANONYMOUSLY_OWNED bit to RWSEM_NONSPINNABLE.

Patch 13 enables reader to spin on a writer-owned rwsem.

Patch 14 enables a writer to spin on a reader-owned rwsem for at most
25us and extends the RWSEM_NONSPINNABLE bit to 2 separate ones - one
for readers and one for writers.

Patch 15 implements the adaptive disabling of reader optimistic spinning
when the reader-owned rwsem spinning timeouts happen.

Patch 16 adds some new rwsem owner access helper functions.

Patch 17 handles the case of too many readers by reserving the sign
bit to designate that a reader lock attempt will fail and the locking
reader will be put to sleep. This will ensure that we will not overflow
the reader count.

Patch 18 merges the write-lock owner task pointer into the count.
Only 64-bit count has enough space to provide a reasonable number of
bits for reader count. This is for x86-64 only for the time being.

Patch 19 eliminates redundant computation of the merged owner-count.

Patch 20 disable preemption during the down_read() call to eliminate
the remote possibility that the reader count may overflow.

With a locking microbenchmark running on 5.1 based kernel, the total
locking rates (in kops/s) on a 2-socket Skylake system with equal numbers
of readers and writers (mixed) before and after this patchset were:

   # of Threads   Before Patch      After Patch
   ------------   ------------      -----------
        2            2,394             4,541
        4            1,184             4,083
        8              817             4,070
       16              747             3,786
       32              319             3,173
       64               81             3,125

On workloads where the rwsem reader critical section is relatively long
(longer than the spinning period), optimistic of writer on reader-owned
rwsem may not be that helpful. In fact, the performance may regress
in some cases like the will-it-sclae page_fault1 microbenchmark. This
is likely due to the fact that larger reader groups where the readers
acquire the lock together are broken into smaller ones. So more work
will be needed to better tune the rwsem code to that kind of workload.

The v5 to v6 diff is attached at the end.

Waiman Long (20):
  locking/rwsem: Prevent decrement of reader count before increment
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
  locking/rwsem: Enable time-based spinning on reader-owned rwsem
  locking/rwsem: Adaptive disabling of reader optimistic spinning
  locking/rwsem: Add more rwsem owner access helpers
  locking/rwsem: Guard against making count negative
  locking/rwsem: Merge owner into count on x86-64
  locking/rwsem: Remove redundant computation of writer lock word
  locking/rwsem: Disable preemption in down_read*() if owner in count

 arch/x86/Kconfig                  |    6 +
 include/linux/rwsem.h             |   11 +-
 include/linux/sched/wake_q.h      |    5 +
 kernel/Kconfig.locks              |   12 +
 kernel/locking/Makefile           |    2 +-
 kernel/locking/lock_events_list.h |   12 +-
 kernel/locking/rwsem-xadd.c       |  729 -------------
 kernel/locking/rwsem.c            | 1678 ++++++++++++++++++++++++++++-
 kernel/locking/rwsem.h            |  306 +-----
 lib/Kconfig.debug                 |    8 +-
 10 files changed, 1699 insertions(+), 1070 deletions(-)
 delete mode 100644 kernel/locking/rwsem-xadd.c

 v5-to-v6 diff
 -------------

diff --git a/kernel/Kconfig.locks b/kernel/Kconfig.locks
index 3370ea21407b..818e595831a1 100644
--- a/kernel/Kconfig.locks
+++ b/kernel/Kconfig.locks
@@ -253,13 +253,13 @@ config QUEUED_RWLOCKS
 	depends on SMP
 
 #
-# An architecture that want to merge rwsem write-owner into count should
-# select ARCH_USE_RWSEM_OWNER_COUNT and define RWSEM_OWNER_COUNT_PA_BITS
-# as the correct number of physical address bits.
+# An 64-bit architecture that wants to merge rwsem write-owner into
+# count should select ARCH_USE_RWSEM_OWNER_COUNT and define
+# RWSEM_OWNER_COUNT_PA_BITS as the correct number of physical address
+# bits. In addition, the number of bits available for reader count
+# should allow all the CPUs as defined in NR_CPUS to acquire the same
+# read lock without overflowing it.
 #
 config ARCH_USE_RWSEM_OWNER_COUNT
 	bool
-
-config RWSEM_OWNER_COUNT
-	def_bool y if ARCH_USE_RWSEM_OWNER_COUNT
 	depends on SMP && 64BIT
diff --git a/kernel/locking/lock_events_list.h b/kernel/locking/lock_events_list.h
index 661326885800..239039d0ce21 100644
--- a/kernel/locking/lock_events_list.h
+++ b/kernel/locking/lock_events_list.h
@@ -61,6 +61,7 @@ LOCK_EVENT(rwsem_opt_wlock)	/* # of opt-acquired write locks	*/
 LOCK_EVENT(rwsem_opt_fail)	/* # of failed optspins			*/
 LOCK_EVENT(rwsem_opt_nospin)	/* # of disabled optspins		*/
 LOCK_EVENT(rwsem_opt_norspin)	/* # of disabled reader-only optspins	*/
+LOCK_EVENT(rwsem_opt_rlock2)	/* # of opt-acquired 2ndary read locks	*/
 LOCK_EVENT(rwsem_rlock)		/* # of read locks acquired		*/
 LOCK_EVENT(rwsem_rlock_fast)	/* # of fast read locks acquired	*/
 LOCK_EVENT(rwsem_rlock_fail)	/* # of failed read lock acquisitions	*/
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 19d8fbd50d17..97a2334d9cd3 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -83,10 +83,18 @@
  * Therefore, any writers that had observed the setting of the writer
  * nonspinnable bit for a given rwsem after they fail to acquire the lock
  * via optimistic spinning will set the reader nonspinnable bit once they
- * acquire the write lock. This is to discourage reader optmistic spinning
- * on that particular rwsem and make writers more preferred. This adaptive
- * disabling of reader optimistic spinning will alleviate the negative
- * side effect of this feature.
+ * acquire the write lock. Similarly, readers that observe the setting
+ * of reader nonspinnable bit at slowpath entry will set the reader
+ * nonspinnable bits when they acquire the read lock via the wakeup path.
+ *
+ * Once the reader nonspinnable bit is on, it will only be reset when
+ * a writer is able to acquire the rwsem in the fast path or somehow a
+ * reader or writer in the slowpath doesn't observe the nonspinable bit.
+ *
+ * This is to discourage reader optmistic spinning on that particular
+ * rwsem and make writers more preferred. This adaptive disabling of reader
+ * optimistic spinning will alleviate the negative side effect of this
+ * feature.
  */
 #define RWSEM_READER_OWNED	(1UL << 0)
 #define RWSEM_RD_NONSPINNABLE	(1UL << 1)
@@ -129,8 +137,8 @@
  * to (32k-1) active readers. If 5-level page table support isn't
  * configured, we can supports up to (2M-1) active readers.
  *
- * On x86-64 with CONFIG_X86_5LEVEL and CONFIG_RWSEM_OWNER_COUNT, the bit
- * definitions of the count are:
+ * On x86-64 with CONFIG_X86_5LEVEL and CONFIG_ARCH_USE_RWSEM_OWNER_COUNT,
+ * the bit definitions of the count are:
  *
  * Bit   0    - waiters present bit
  * Bit   1    - lock handoff bit
@@ -138,7 +146,7 @@
  * Bits 48-62 - 15-bit reader counts
  * Bit  63    - read fail bit
  *
- * On other 64-bit architectures without CONFIG_RWSEM_OWNER_COUNT, the bit
+ * On other 64-bit architectures without MERGE_OWNER_INTO_COUNT, the bit
  * definitions are:
  *
  * Bit  0    - writer locked bit
@@ -178,16 +186,34 @@
 #define RWSEM_FLAG_HANDOFF	(1UL << 1)
 #define RWSEM_FLAG_READFAIL	(1UL << (BITS_PER_LONG - 1))
 
-#ifdef CONFIG_RWSEM_OWNER_COUNT
-#define RWSEM_READER_SHIFT	(CONFIG_RWSEM_OWNER_COUNT_PA_BITS -\
+/*
+ * The MERGE_OWNER_INTO_COUNT macro will only be defined if the following
+ * conditions are true:
+ *  1) Both CONFIG_ARCH_USE_RWSEM_OWNER_COUNT and
+ *     CONFIG_RWSEM_OWNER_COUNT_PA_BITS are defined.
+ *  2) The number of reader count bits available is able to hold the
+ *     maximum number of CPUs as defined in NR_CPUS.
+ */
+#if	defined(CONFIG_ARCH_USE_RWSEM_OWNER_COUNT) && \
+	defined(CONFIG_RWSEM_OWNER_COUNT_PA_BITS)
+# define __READER_SHIFT		(CONFIG_RWSEM_OWNER_COUNT_PA_BITS -\
 				 L1_CACHE_SHIFT + 2)
+# define __READER_COUNT_BITS	(BITS_PER_LONG - __READER_SHIFT - 1)
+# define __READER_COUNT_MAX	((1UL << __READER_COUNT_BITS) - 1)
+# if (NR_CPUS <= __READER_COUNT_MAX)
+#  define MERGE_OWNER_INTO_COUNT
+# endif
+#endif
+
+#ifdef MERGE_OWNER_INTO_COUNT
+#define RWSEM_READER_SHIFT	__READER_SHIFT
 #define RWSEM_WRITER_MASK	((1UL << RWSEM_READER_SHIFT) - 4)
 #define RWSEM_WRITER_LOCKED	rwsem_owner_count(current)
-#else /* !CONFIG_RWSEM_OWNER_COUNT */
+#else /* !MERGE_OWNER_INTO_COUNT */
 #define RWSEM_READER_SHIFT	8
 #define RWSEM_WRITER_MASK	(1UL << 7)
 #define RWSEM_WRITER_LOCKED	RWSEM_WRITER_MASK
-#endif /* CONFIG_RWSEM_OWNER_COUNT */
+#endif /* MERGE_OWNER_INTO_COUNT */
 
 #define RWSEM_READER_BIAS	(1UL << RWSEM_READER_SHIFT)
 #define RWSEM_READER_MASK	(~(RWSEM_READER_BIAS - 1))
@@ -198,9 +224,15 @@
 /*
  * Task structure pointer compression (64-bit only):
  * (owner - PAGE_OFFSET) >> (L1_CACHE_SHIFT - 2)
+ *
+ * However, init_task may lie outside of the linearly mapped physical
+ * to virtual memory range and so has to be handled separately.
  */
 static inline unsigned long rwsem_owner_count(struct task_struct *owner)
 {
+	if (unlikely(owner == &init_task))
+		return RWSEM_WRITER_MASK;
+
 	return ((unsigned long)owner - PAGE_OFFSET) >> (L1_CACHE_SHIFT - 2);
 }
 
@@ -208,6 +240,9 @@ static inline unsigned long rwsem_count_owner(long count)
 {
 	unsigned long writer = (unsigned long)count & RWSEM_WRITER_MASK;
 
+	if (unlikely(writer == RWSEM_WRITER_MASK))
+		return (unsigned long)&init_task;
+
 	return writer ? (writer << (L1_CACHE_SHIFT - 2)) + PAGE_OFFSET : 0;
 }
 
@@ -218,9 +253,8 @@ static inline unsigned long rwsem_count_owner(long count)
  * may not need READ_ONCE() as long as the pointer value is only used
  * for comparison and isn't being dereferenced.
  *
- * On 32-bit architectures, the owner and count are separate. On 64-bit
- * architectures, however, the writer task structure pointer is written
- * to the count as well in addition to the owner field.
+ * With MERGE_OWNER_INTO_COUNT defined, the writer task structure pointer
+ * is written to the count as well in addition to the owner field.
  */
 
 static inline void rwsem_set_owner(struct rw_semaphore *sem)
@@ -233,27 +267,6 @@ static inline void rwsem_clear_owner(struct rw_semaphore *sem)
 	WRITE_ONCE(sem->owner, NULL);
 }
 
-#ifdef CONFIG_RWSEM_OWNER_COUNT
-/*
- * Get the owner value from count to have early access to the task structure.
- * Owner from sem->count should includes the RWSEM_NONSPINNABLE bits
- * from sem->owner.
- */
-static inline struct task_struct *rwsem_get_owner(struct rw_semaphore *sem)
-{
-	unsigned long cowner = rwsem_count_owner(atomic_long_read(&sem->count));
-	unsigned long sowner = (unsigned long)READ_ONCE(sem->owner);
-
-	return (struct task_struct *) (cowner
-		? cowner | (sowner & RWSEM_NONSPINNABLE) : sowner);
-}
-#else /* !CONFIG_RWSEM_OWNER_COUNT */
-static inline struct task_struct *rwsem_get_owner(struct rw_semaphore *sem)
-{
-	return READ_ONCE(sem->owner);
-}
-#endif /* CONFIG_RWSEM_OWNER_COUNT */
-
 /*
  * The task_struct pointer of the last owning reader will be left in
  * the owner field.
@@ -261,11 +274,15 @@ static inline struct task_struct *rwsem_get_owner(struct rw_semaphore *sem)
  * Note that the owner value just indicates the task has owned the rwsem
  * previously, it may not be the real owner or one of the real owners
  * anymore when that field is examined, so take it with a grain of salt.
+ *
+ * The reader non-spinnable bit is preserved.
  */
 static inline void __rwsem_set_reader_owned(struct rw_semaphore *sem,
 					    struct task_struct *owner)
 {
-	unsigned long val = (unsigned long)owner | RWSEM_READER_OWNED;
+	unsigned long val = (unsigned long)owner | RWSEM_READER_OWNED |
+			   ((unsigned long)READ_ONCE(sem->owner) &
+			     RWSEM_RD_NONSPINNABLE);
 
 	WRITE_ONCE(sem->owner, (struct task_struct *)val);
 }
@@ -295,6 +312,14 @@ static inline bool is_rwsem_spinnable(struct rw_semaphore *sem, bool wr)
 	return is_rwsem_owner_spinnable(READ_ONCE(sem->owner), wr);
 }
 
+/*
+ * Remove all the flag bits from owner.
+ */
+static inline struct task_struct *owner_without_flags(struct task_struct *owner)
+{
+	return (struct task_struct *)((long)owner & ~RWSEM_OWNER_FLAGS_MASK);
+}
+
 /*
  * Return true if the rwsem is owned by a reader.
  */
@@ -349,6 +374,98 @@ static inline void rwsem_set_nonspinnable(struct rw_semaphore *sem)
 	}
 }
 
+#ifdef MERGE_OWNER_INTO_COUNT
+/*
+ * It is very unlikely that successive preemption at the middle of
+ * down_read's inc-check-dec sequence will cause the reader count to
+ * overflow, For absolute correctness, we still need to prevent
+ * that possibility from happening. So preemption will be disabled
+ * during the down_read*() call.
+ *
+ * For PREEMPT=n kernels, there isn't much overhead in doing that.
+ * For PREEMPT=y kernels, there will be some additional cost.
+ *
+ * If MERGE_OWNER_INTO_COUNT isn't defined, we don't need to worry
+ * about reader count overflow and so we don't need to disable
+ * preemption.
+ */
+#define rwsem_preempt_disable()			preempt_disable()
+#define rwsem_preempt_enable()			preempt_enable()
+#define rwsem_schedule_preempt_disabled()	schedule_preempt_disabled()
+
+/*
+ * Get the owner value from count to have early access to the task structure.
+ * Owner from sem->count should includes the RWSEM_NONSPINNABLE bits
+ * from sem->owner.
+ */
+static inline struct task_struct *rwsem_get_owner(struct rw_semaphore *sem)
+{
+	unsigned long cowner = rwsem_count_owner(atomic_long_read(&sem->count));
+	unsigned long sowner = (unsigned long)READ_ONCE(sem->owner);
+
+	return (struct task_struct *) (cowner
+		? cowner | (sowner & RWSEM_NONSPINNABLE) : sowner);
+}
+
+/*
+ * This function does a read trylock by incrementing the reader count
+ * and then decrementing it immediately if too many readers are present
+ * (count becomes negative) in order to prevent the remote possibility
+ * of overflowing the count with minimal delay between the increment
+ * and decrement.
+ *
+ * When the owner task structure pointer is merged into couunt, less bits
+ * will be available for readers (down to 15 bits for x86-64). There is a
+ * very slight chance that preemption may happen in the middle of the
+ * inc-check-dec sequence leaving the reader count incremented for a
+ * certain period of time until the reader wakes up and move on. Still
+ * the chance of having enough of these unfortunate sequence of events to
+ * overflow the reader count is infinitesimally small.
+ *
+ * If MERGE_OWNER_INTO_COUNT isn't defined, we don't really need to
+ * worry about the possibility of overflowing the reader counts even
+ * for 32-bit architectures which can support up to 8M readers.
+ *
+ * It returns the adjustment that should be added back to the count
+ * in the slowpath.
+ */
+static inline long rwsem_read_trylock(struct rw_semaphore *sem, long *cnt)
+{
+	long adjustment = -RWSEM_READER_BIAS;
+
+	*cnt = atomic_long_fetch_add_acquire(RWSEM_READER_BIAS, &sem->count);
+	if (unlikely(*cnt < 0)) {
+		atomic_long_add(-RWSEM_READER_BIAS, &sem->count);
+		adjustment = 0;
+	}
+	return adjustment;
+}
+
+static int __init rwsem_show_count_status(void)
+{
+	pr_info("RW Semaphores: Write-owner in count & %d bits for readers.\n",
+		__READER_COUNT_BITS);
+	return 0;
+}
+late_initcall(rwsem_show_count_status);
+#else /* !MERGE_OWNER_INTO_COUNT */
+
+#define rwsem_preempt_disable()
+#define rwsem_preempt_enable()
+#define rwsem_schedule_preempt_disabled()	schedule()
+
+static inline struct task_struct *rwsem_get_owner(struct rw_semaphore *sem)
+{
+	return READ_ONCE(sem->owner);
+}
+
+static inline long rwsem_read_trylock(struct rw_semaphore *sem, long *cnt)
+{
+	*cnt = atomic_long_fetch_add_acquire(RWSEM_READER_BIAS, &sem->count);
+	return -RWSEM_READER_BIAS;
+}
+#endif /* MERGE_OWNER_INTO_COUNT */
+
 /*
  * Guide to the rw_semaphore's count field.
  *
@@ -372,11 +489,6 @@ static inline void rwsem_set_nonspinnable(struct rw_semaphore *sem)
 void __init_rwsem(struct rw_semaphore *sem, const char *name,
 		  struct lock_class_key *key)
 {
-	/*
-	 * We should support at least (8k-1) concurrent readers
-	 */
-	BUILD_BUG_ON(sizeof(long) * 8 - RWSEM_READER_SHIFT < 14);
-
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	/*
 	 * Make sure we are not reinitializing a held semaphore:
@@ -404,6 +516,7 @@ struct rwsem_waiter {
 	struct task_struct *task;
 	enum rwsem_waiter_type type;
 	unsigned long timeout;
+	unsigned long last_rowner;
 };
 #define rwsem_first_waiter(sem) \
 	list_first_entry(&sem->wait_list, struct rwsem_waiter, list)
@@ -453,6 +566,7 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 {
 	struct rwsem_waiter *waiter, *tmp;
 	long oldcount, woken = 0, adjustment = 0;
+	struct list_head wlist;
 
 	lockdep_assert_held(&sem->wait_lock);
 
@@ -478,12 +592,20 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 		return;
 	}
 
+	/*
+	 * No reader wakeup if there are too many of them already.
+	 */
+	if (unlikely(atomic_long_read(&sem->count) < 0))
+		return;
+
 	/*
 	 * Writers might steal the lock before we grant it to the next reader.
 	 * We prefer to do the first reader grant before counting readers
 	 * so we can bail out early if a writer stole the lock.
 	 */
 	if (wake_type != RWSEM_WAKE_READ_OWNED) {
+		struct task_struct *owner;
+
 		adjustment = RWSEM_READER_BIAS;
 		oldcount = atomic_long_fetch_add(adjustment, &sem->count);
 		if (unlikely(oldcount & RWSEM_WRITER_MASK)) {
@@ -504,8 +626,15 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 		/*
 		 * Set it to reader-owned to give spinners an early
 		 * indication that readers now have the lock.
+		 * The reader nonspinnable bit seen at slowpath entry of
+		 * the reader is copied over.
 		 */
-		__rwsem_set_reader_owned(sem, waiter->task);
+		owner = waiter->task;
+		if (waiter->last_rowner & RWSEM_RD_NONSPINNABLE) {
+			owner = (void *)((long)owner | RWSEM_RD_NONSPINNABLE);
+			lockevent_inc(rwsem_opt_norspin);
+		}
+		__rwsem_set_reader_owned(sem, owner);
 	}
 
 	/*
@@ -519,30 +648,25 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 	 * to acquire the lock at the same time irrespective of their order
 	 * in the queue. The writers acquire the lock according to their
 	 * order in the queue.
+	 *
+	 * We have to do wakeup in 2 passes to prevent the possibility that
+	 * the reader count may be decremented before it is incremented. It
+	 * is because the to-be-woken waiter may not have slept yet. So it
+	 * may see waiter->task got cleared, finish its critical section and
+	 * do an unlock before the reader count increment.
+	 *
+	 * 1) Collect the read-waiters in a separate list, count them and
+	 *    fully increment the reader count in rwsem.
+	 * 2) For each waiters in the new list, clear waiter->task and
+	 *    put them into wake_q to be woken up later.
 	 */
+	INIT_LIST_HEAD(&wlist);
 	list_for_each_entry_safe(waiter, tmp, &sem->wait_list, list) {
-		struct task_struct *tsk;
-
 		if (waiter->type == RWSEM_WAITING_FOR_WRITE)
 			continue;
 
 		woken++;
-		tsk = waiter->task;
-
-		get_task_struct(tsk);
-		list_del(&waiter->list);
-		/*
-		 * Ensure calling get_task_struct() before setting the reader
-		 * waiter to nil such that rwsem_down_read_slowpath() cannot
-		 * race with do_exit() by always holding a reference count
-		 * to the task to wakeup.
-		 */
-		smp_store_release(&waiter->task, NULL);
-		/*
-		 * Ensure issuing the wakeup (either by us or someone else)
-		 * after setting the reader waiter to nil.
-		 */
-		wake_q_add_safe(wake_q, tsk);
+		list_move_tail(&waiter->list, &wlist);
 
 		/*
 		 * Limit # of readers that can be woken up per wakeup call.
@@ -567,6 +691,27 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 
 	if (adjustment)
 		atomic_long_add(adjustment, &sem->count);
+
+	/* 2nd pass */
+	list_for_each_entry(waiter, &wlist, list) {
+		struct task_struct *tsk;
+
+		tsk = waiter->task;
+		get_task_struct(tsk);
+
+		/*
+		 * Ensure calling get_task_struct() before setting the reader
+		 * waiter to nil such that rwsem_down_read_slowpath() cannot
+		 * race with do_exit() by always holding a reference count
+		 * to the task to wakeup.
+		 */
+		smp_store_release(&waiter->task, NULL);
+		/*
+		 * Ensure issuing the wakeup (either by us or someone else)
+		 * after setting the reader waiter to nil.
+		 */
+		wake_q_add_safe(wake_q, tsk);
+	}
 }
 
 /*
@@ -662,7 +807,7 @@ static inline bool owner_on_cpu(struct task_struct *owner)
 	/*
 	 * Clear all the flag bits in owner
 	 */
-	*((unsigned long *)&owner) &= ~RWSEM_OWNER_FLAGS_MASK;
+	owner = owner_without_flags(owner);
 
 	/*
 	 * As lock holder preemption issue, we both skip spinning if
@@ -685,15 +830,17 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem, bool wr)
 
 	preempt_disable();
 	rcu_read_lock();
+
 	owner = rwsem_get_owner(sem);
-	if (owner) {
-		ret = is_rwsem_owner_spinnable(owner, wr) &&
-		      (((unsigned long)owner & RWSEM_READER_OWNED) ||
-		       owner_on_cpu(owner));
-	}
+	if (!is_rwsem_owner_spinnable(owner, wr))
+		ret = false;
+	else if ((unsigned long)owner & RWSEM_READER_OWNED)
+		ret = true;
+	else if ((owner = owner_without_flags(owner)))
+		ret = owner_on_cpu(owner);
+
 	rcu_read_unlock();
 	preempt_enable();
-
 	lockevent_cond_inc(rwsem_opt_fail, !ret);
 	return ret;
 }
@@ -719,15 +866,15 @@ enum owner_state {
 
 static inline enum owner_state rwsem_owner_state(unsigned long owner, bool wr)
 {
-	if (!owner)
-		return OWNER_NULL;
-
 	if (!is_rwsem_owner_spinnable((void *)owner, wr))
 		return OWNER_NONSPINNABLE;
 
 	if (owner & RWSEM_READER_OWNED)
 		return OWNER_READER;
 
+	if (!(owner & ~RWSEM_OWNER_FLAGS_MASK))
+		return OWNER_NULL;
+
 	return OWNER_WRITER;
 }
 
@@ -952,6 +1099,43 @@ static inline void clear_wr_nonspinnable(struct rw_semaphore *sem)
 		atomic_long_andnot(RWSEM_WR_NONSPINNABLE,
 				  (atomic_long_t *)&sem->owner);
 }
+
+/*
+ * This function is called when the reader fails to acquire the lock via
+ * optimistic spinning. In this case we will still attempt to do a trylock
+ * when comparing the rwsem state right now with the state when entering
+ * the slowpath indicates that the reader is still in a valid reader phase.
+ * This happens when the following conditions are true:
+ *
+ * 1) The lock is currently reader owned, and
+ * 2) The lock is previously not reader-owned or the last read owner changes.
+ *
+ * In the former case, we have transitioned from a writer phase to a
+ * reader-phase while spinning. In the latter case, it means the reader
+ * phase hasn't ended when we entered the optimistic spinning loop. In
+ * both cases, the reader is eligible to acquire the lock. This is the
+ * secondary path where a read lock is acquired optimistically.
+ *
+ * The reader non-spinnable bit wasn't set at time of entry or it will
+ * not be here at all.
+ */
+static inline bool rwsem_reader_phase_trylock(struct rw_semaphore *sem,
+					      unsigned long last_rowner)
+{
+	unsigned long owner = (unsigned long)READ_ONCE(sem->owner);
+
+	if (!(owner & RWSEM_READER_OWNED))
+		return false;
+
+	owner	    &= ~RWSEM_OWNER_FLAGS_MASK;
+	last_rowner &= ~RWSEM_OWNER_FLAGS_MASK;
+	if ((owner != last_rowner) && rwsem_try_read_lock_unqueued(sem)) {
+		lockevent_inc(rwsem_opt_rlock2);
+		lockevent_add(rwsem_opt_fail, -1);
+		return true;
+	}
+	return false;
+}
 #else
 static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem, bool wr)
 {
@@ -965,42 +1149,50 @@ static inline bool rwsem_optimistic_spin(struct rw_semaphore *sem,
 }
 
 static inline void clear_wr_nonspinnable(struct rw_semaphore *sem) { }
+
+static inline bool rwsem_reader_phase_trylock(struct rw_semaphore *sem,
+					      unsigned long last_rowner)
+{
+	return false;
+}
 #endif
 
 /*
  * Wait for the read lock to be granted
  */
 static struct rw_semaphore __sched *
-rwsem_down_read_slowpath(struct rw_semaphore *sem, int state, long count)
+rwsem_down_read_slowpath(struct rw_semaphore *sem, int state, long adjustment)
 {
-	long adjustment = -RWSEM_READER_BIAS;
+	long count;
 	bool wake = false;
 	struct rwsem_waiter waiter;
 	DEFINE_WAKE_Q(wake_q);
 
-	if (unlikely(count < 0)) {
+	if (unlikely(!adjustment)) {
 		/*
-		 * The sign bit has been set meaning that too many active
-		 * readers are present. We need to decrement reader count &
-		 * enter wait queue immediately to avoid overflowing the
-		 * reader count.
-		 *
-		 * As preemption is not disabled, there is a remote
-		 * possibility that preemption can happen in the narrow
-		 * timing window between incrementing and decrementing
-		 * the reader count and the task is put to sleep for a
-		 * considerable amount of time. If sufficient number
-		 * of such unfortunate sequence of events happen, we
-		 * may still overflow the reader count. It is extremely
-		 * unlikey, though. If this is a concern, we should consider
-		 * disable preemption during this timing window to make
-		 * sure that such unfortunate event will not happen.
+		 * This shouldn't happen. If it does, there is probably
+		 * something wrong in the system.
 		 */
-		atomic_long_add(-RWSEM_READER_BIAS, &sem->count);
-		adjustment = 0;
+		WARN_ON_ONCE(1);
+
+		/*
+		 * An adjustment of 0 means that there are too many readers
+		 * holding or trying to acquire the lock. So disable
+		 * optimistic spinning and go directly into the wait list.
+		 */
+		if (is_rwsem_spinnable(sem, false))
+			rwsem_set_nonspinnable(sem);
 		goto queue;
 	}
 
+	/*
+	 * Save the current read-owner of rwsem, if available, and the
+	 * reader nonspinnable bit.
+	 */
+	waiter.last_rowner = (long)READ_ONCE(sem->owner);
+	if (!(waiter.last_rowner & RWSEM_READER_OWNED))
+		waiter.last_rowner &= RWSEM_RD_NONSPINNABLE;
+
 	if (!rwsem_can_spin_on_owner(sem, false))
 		goto queue;
 
@@ -1011,11 +1203,11 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state, long count)
 	adjustment = 0;
 	if (rwsem_optimistic_spin(sem, false)) {
 		/*
-		 * Opportunistically wake up other readers in the wait queue.
-		 * It has another chance of wakeup at unlock time.
+		 * Wake up other readers in the wait list if the front
+		 * waiter is a reader.
 		 */
-		if ((atomic_long_read(&sem->count) & RWSEM_FLAG_WAITERS) &&
-		    raw_spin_trylock_irq(&sem->wait_lock)) {
+		if ((atomic_long_read(&sem->count) & RWSEM_FLAG_WAITERS)) {
+			raw_spin_lock_irq(&sem->wait_lock);
 			if (!list_empty(&sem->wait_list))
 				__rwsem_mark_wake(sem, RWSEM_WAKE_READ_OWNED,
 						  &wake_q);
@@ -1023,6 +1215,8 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state, long count)
 			wake_up_q(&wake_q);
 		}
 		return sem;
+	} else if (rwsem_reader_phase_trylock(sem, waiter.last_rowner)) {
+		return sem;
 	}
 
 queue:
@@ -1084,7 +1278,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state, long count)
 			raw_spin_unlock_irq(&sem->wait_lock);
 			break;
 		}
-		schedule();
+		rwsem_schedule_preempt_disabled();
 		lockevent_inc(rwsem_sleep_reader);
 	}
 
@@ -1185,8 +1379,11 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 			 * This waiter may have become first in the wait
 			 * list after re-acquring the wait_lock. The
 			 * rwsem_first_waiter() test in the main while
-			 * loop below will correctly detect that.
+			 * loop below will correctly detect that. We do
+			 * need to reload count to perform proper trylock
+			 * and avoid missed wakeup.
 			 */
+			count = atomic_long_read(&sem->count);
 		}
 	} else {
 		count = atomic_long_add_return(RWSEM_FLAG_WAITERS, &sem->count);
@@ -1312,29 +1509,36 @@ static struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem)
  */
 inline void __down_read(struct rw_semaphore *sem)
 {
-	long tmp = atomic_long_fetch_add_acquire(RWSEM_READER_BIAS,
-						 &sem->count);
+	long tmp, adjustment;
 
+	rwsem_preempt_disable();
+	adjustment = rwsem_read_trylock(sem, &tmp);
 	if (unlikely(tmp & RWSEM_READ_FAILED_MASK)) {
-		rwsem_down_read_slowpath(sem, TASK_UNINTERRUPTIBLE, tmp);
+		rwsem_down_read_slowpath(sem, TASK_UNINTERRUPTIBLE, adjustment);
 		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
 	} else {
 		rwsem_set_reader_owned(sem);
 	}
+	rwsem_preempt_enable();
 }
 
 static inline int __down_read_killable(struct rw_semaphore *sem)
 {
-	long tmp = atomic_long_fetch_add_acquire(RWSEM_READER_BIAS,
-						 &sem->count);
+	long tmp, adjustment;
 
+	rwsem_preempt_disable();
+	adjustment = rwsem_read_trylock(sem, &tmp);
 	if (unlikely(tmp & RWSEM_READ_FAILED_MASK)) {
-		if (IS_ERR(rwsem_down_read_slowpath(sem, TASK_KILLABLE, tmp)))
+		if (IS_ERR(rwsem_down_read_slowpath(sem, TASK_KILLABLE,
+						    adjustment))) {
+			rwsem_preempt_enable();
 			return -EINTR;
+		}
 		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
 	} else {
 		rwsem_set_reader_owned(sem);
 	}
+	rwsem_preempt_enable();
 	return 0;
 }
 
@@ -1367,7 +1571,7 @@ static inline void __down_write(struct rw_semaphore *sem)
 		rwsem_down_write_slowpath(sem, TASK_UNINTERRUPTIBLE);
 	else
 		rwsem_set_owner(sem);
-#ifdef CONFIG_RWSEM_OWNER_COUNT
+#ifdef MERGE_OWNER_INTO_COUNT
 	DEBUG_RWSEMS_WARN_ON(sem->owner != rwsem_get_owner(sem), sem);
 #endif
 }
@@ -1408,6 +1612,7 @@ inline void __up_read(struct rw_semaphore *sem)
 	DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
 	rwsem_clear_reader_owned(sem);
 	tmp = atomic_long_add_return_release(-RWSEM_READER_BIAS, &sem->count);
+	DEBUG_RWSEMS_WARN_ON(tmp < 0, sem);
 	if (unlikely((tmp & (RWSEM_LOCK_MASK|RWSEM_FLAG_WAITERS)) ==
 		      RWSEM_FLAG_WAITERS)) {
 		clear_wr_nonspinnable(sem);
@@ -1448,7 +1653,7 @@ static inline void __downgrade_write(struct rw_semaphore *sem)
 	 * read-locked region is ok to be re-ordered into the
 	 * write side. As such, rely on RELEASE semantics.
 	 */
-	DEBUG_RWSEMS_WARN_ON(sem->owner != current, sem);
+	DEBUG_RWSEMS_WARN_ON(owner_without_flags(sem->owner) != current, sem);
 	tmp = atomic_long_fetch_add_release(
 		-RWSEM_WRITER_LOCKED+RWSEM_READER_BIAS, &sem->count);
 	rwsem_set_reader_owned(sem);

-- 
2.18.1

