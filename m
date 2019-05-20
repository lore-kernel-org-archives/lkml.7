Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46FAC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73E6A2173C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfETVAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 17:00:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32982 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbfETVAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 17:00:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 985213082133;
        Mon, 20 May 2019 21:00:20 +0000 (UTC)
Received: from llong.com (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 53EE664049;
        Mon, 20 May 2019 21:00:19 +0000 (UTC)
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
Subject: [PATCH v8 17/19] locking/rwsem: Merge owner into count on x86-64
Date:   Mon, 20 May 2019 16:59:16 -0400
Message-Id: <20190520205918.22251-18-longman@redhat.com>
In-Reply-To: <20190520205918.22251-1-longman@redhat.com>
References: <20190520205918.22251-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 20 May 2019 21:00:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With separate count and owner, there are timing windows where the two
values are inconsistent. That can cause problem when trying to figure
out the exact state of the rwsem. For instance, a RT task will stop
optimistic spinning if the lock is acquired by a writer but the owner
field isn't set yet. That can be solved by combining the count and
owner together in a single atomic value.

On 32-bit architectures, there aren't enough bits to hold both.
64-bit architectures, however, can have enough bits to do that. For
x86-64, the physical address can use up to 52 bits. That is 4PB of
memory. That leaves 12 bits available for other use. The task structure
pointer is aligned to the L1 cache size. That means another 6 bits
(64 bytes cacheline) will be available. Reserving 2 bits for status
flags, we will have 16 bits for the reader count and the read fail bit.
That can supports up to (32k-1) readers. Without 5-level page table,
we can supports up to (2M-1) readers.

The owner value will still be duplicated in the owner field as that will
ease debugging when looking at core dump. There may be a slight overhead
in transforming the task pointer to fit into a smaller number of bits,
but that shouldn't be noticeable in real workloads.

This change is currently enabled for x86-64 only. Other 64-bit
architectures may be enabled in the future if the need arises.

With a locking microbenchmark running on 5.1 based kernel, the total
locking rates (in kops/s) on a 8-socket IvyBridge-EX system with
writer-only locking threads and then equal numbers of readers and writers
(mixed) before patch and after this and subsequent related patches were
as follows:

                  Before Patch      After Patch
   # of Threads  wlock    mixed    wlock    mixed
   ------------  -----    -----    -----    -----
        1        30,422   31,034   30,323   30,379
        2         6,427    6,684    7,804    9,436
        4         6,742    6,738    7,568    8,268
        8         7,092    7,222    5,679    7,041
       16         6,882    7,163    6,848    7,652
       32         7,458    7,316    7,975    2,189
       64         7,906      520    8,269      534
      128         1,680      425    8,047      448

In the single thread case, the complex write-locking operation does
introduce a little bit of overhead (about 0.3%). For the contended cases,
except for some anomalies in the data, there is no evidence that this
change will adversely impact performance.

When running the same microbenchmark with RT locking threads instead,
we got the following results:

                  Before Patch      After Patch
   # of Threads  wlock    mixed    wlock    mixed
   ------------  -----    -----    -----    -----
        2         4,065    3,642    4,756    5,062
        4         2,254    1,907    3,460    2,496
        8         2,386      964    3,012    1,964
       16         2,095    1,596    3,083    1,862
       32         2,388      530    3,717      359
       64         1,424      322    4,060      401
      128         1,642      510    4,488      628

It is obvious that RT tasks can benefit pretty significantly with this set
of patches.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 arch/x86/Kconfig       |   6 ++
 kernel/Kconfig.locks   |  12 +++
 kernel/locking/rwsem.c | 162 ++++++++++++++++++++++++++++++++++++++---
 3 files changed, 171 insertions(+), 9 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2bbbd4d1ba31..141be11a3a6a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -91,6 +91,7 @@ config X86
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
+	select ARCH_USE_RWSEM_OWNER_COUNT	if X86_64
 	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
 	select ARCH_WANTS_DYNAMIC_TASK_STRUCT
 	select ARCH_WANTS_THP_SWAP		if X86_64
@@ -353,6 +354,11 @@ config PGTABLE_LEVELS
 	default 3 if X86_PAE
 	default 2
 
+config RWSEM_OWNER_COUNT_PA_BITS
+	int
+	default 52 if X86_5LEVEL
+	default 46 if X86_64
+
 config CC_HAS_SANE_STACKPROTECTOR
 	bool
 	default $(success,$(srctree)/scripts/gcc-x86_64-has-stack-protector.sh $(CC)) if 64BIT
diff --git a/kernel/Kconfig.locks b/kernel/Kconfig.locks
index bf770d7556f7..9cd5f8547674 100644
--- a/kernel/Kconfig.locks
+++ b/kernel/Kconfig.locks
@@ -258,3 +258,15 @@ config ARCH_HAS_MMIOWB
 config MMIOWB
 	def_bool y if ARCH_HAS_MMIOWB
 	depends on SMP
+
+#
+# An 64-bit architecture that wants to merge rwsem write-owner into
+# count should select ARCH_USE_RWSEM_OWNER_COUNT and define
+# RWSEM_OWNER_COUNT_PA_BITS as the correct number of physical address
+# bits. In addition, the number of bits available for reader count
+# should allow all the CPUs as defined in NR_CPUS to acquire the same
+# read lock without overflowing it.
+#
+config ARCH_USE_RWSEM_OWNER_COUNT
+	bool
+	depends on SMP && 64BIT
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 028f29b39045..8196ace2d4a2 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -116,7 +116,38 @@
 #endif
 
 /*
- * On 64-bit architectures, the bit definitions of the count are:
+ * With separate count and owner, there are timing windows where the two
+ * values are inconsistent. That can cause problem when trying to figure
+ * out the exact state of the rwsem. That can be solved by combining
+ * the count and owner together in a single atomic value.
+ *
+ * On 64-bit architectures, the owner task structure pointer can be
+ * compressed and combined with reader count and other status flags.
+ * A simple compression method is to map the virtual address back to
+ * the physical address by subtracting PAGE_OFFSET. On 32-bit
+ * architectures, the long integer value just isn't big enough for
+ * combining owner and count. So they remain separate.
+ *
+ * For x86-64, the physical address can use up to 52 bits if
+ * CONFIG_X86_5LEVEL. That is 4PB of memory. That leaves 12 bits
+ * available for other use. The task structure pointer is also aligned
+ * to the L1 cache size. That means another 6 bits (64 bytes cacheline)
+ * will be available. Reserving 2 bits for status flags, we will have
+ * 16 bits for the reader count and read fail bit. That can supports up
+ * to (32k-1) active readers. If 5-level page table support isn't
+ * configured, we can supports up to (2M-1) active readers.
+ *
+ * On x86-64 with CONFIG_X86_5LEVEL and CONFIG_ARCH_USE_RWSEM_OWNER_COUNT,
+ * the bit definitions of the count are:
+ *
+ * Bit   0    - waiters present bit
+ * Bit   1    - lock handoff bit
+ * Bits  2-47 - compressed task structure pointer
+ * Bits 48-62 - 15-bit reader counts
+ * Bit  63    - read fail bit
+ *
+ * On other 64-bit architectures without MERGE_OWNER_INTO_COUNT, the bit
+ * definitions are:
  *
  * Bit  0    - writer locked bit
  * Bit  1    - waiters present bit
@@ -151,26 +182,81 @@
  * be the first one in the wait_list to be eligible for setting the handoff
  * bit. So concurrent setting/clearing of handoff bit is not possible.
  */
-#define RWSEM_WRITER_LOCKED	(1UL << 0)
-#define RWSEM_FLAG_WAITERS	(1UL << 1)
-#define RWSEM_FLAG_HANDOFF	(1UL << 2)
+#define RWSEM_FLAG_WAITERS	(1UL << 0)
+#define RWSEM_FLAG_HANDOFF	(1UL << 1)
 #define RWSEM_FLAG_READFAIL	(1UL << (BITS_PER_LONG - 1))
 
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
+				 L1_CACHE_SHIFT + 2)
+# define __READER_COUNT_BITS	(BITS_PER_LONG - __READER_SHIFT - 1)
+# define __READER_COUNT_MAX	((1UL << __READER_COUNT_BITS) - 1)
+# if (NR_CPUS <= __READER_COUNT_MAX)
+#  define MERGE_OWNER_INTO_COUNT
+# endif
+#endif
+
+#ifdef MERGE_OWNER_INTO_COUNT
+#define RWSEM_READER_SHIFT	__READER_SHIFT
+#define RWSEM_WRITER_MASK	((1UL << RWSEM_READER_SHIFT) - 4)
+#define RWSEM_WRITER_LOCKED	rwsem_owner_count(current)
+#else /* !MERGE_OWNER_INTO_COUNT */
 #define RWSEM_READER_SHIFT	8
+#define RWSEM_WRITER_MASK	(1UL << 7)
+#define RWSEM_WRITER_LOCKED	RWSEM_WRITER_MASK
+#endif /* MERGE_OWNER_INTO_COUNT */
+
 #define RWSEM_READER_BIAS	(1UL << RWSEM_READER_SHIFT)
 #define RWSEM_READER_MASK	(~(RWSEM_READER_BIAS - 1))
-#define RWSEM_WRITER_MASK	RWSEM_WRITER_LOCKED
 #define RWSEM_LOCK_MASK		(RWSEM_WRITER_MASK|RWSEM_READER_MASK)
 #define RWSEM_READ_FAILED_MASK	(RWSEM_WRITER_MASK|RWSEM_FLAG_WAITERS|\
 				 RWSEM_FLAG_HANDOFF|RWSEM_FLAG_READFAIL)
 
+/*
+ * Task structure pointer compression (64-bit only):
+ * (owner - PAGE_OFFSET) >> (L1_CACHE_SHIFT - 2)
+ *
+ * However, init_task may lie outside of the linearly mapped physical
+ * to virtual memory range and so has to be handled separately.
+ */
+static inline unsigned long rwsem_owner_count(struct task_struct *owner)
+{
+	if (unlikely(owner == &init_task))
+		return RWSEM_WRITER_MASK;
+
+	return ((unsigned long)owner - PAGE_OFFSET) >> (L1_CACHE_SHIFT - 2);
+}
+
+static inline unsigned long rwsem_count_owner(long count)
+{
+	unsigned long writer = (unsigned long)count & RWSEM_WRITER_MASK;
+
+	if (unlikely(writer == RWSEM_WRITER_MASK))
+		return (unsigned long)&init_task;
+
+	return writer ? (writer << (L1_CACHE_SHIFT - 2)) + PAGE_OFFSET : 0;
+}
+
 /*
  * All writes to owner are protected by WRITE_ONCE() to make sure that
  * store tearing can't happen as optimistic spinners may read and use
  * the owner value concurrently without lock. Read from owner, however,
  * may not need READ_ONCE() as long as the pointer value is only used
  * for comparison and isn't being dereferenced.
+ *
+ * With MERGE_OWNER_INTO_COUNT defined, the writer task structure pointer
+ * is written to the count as well in addition to the owner field.
  */
+
 static inline void rwsem_set_owner(struct rw_semaphore *sem)
 {
 	atomic_long_set(&sem->owner, (long)current);
@@ -269,6 +355,27 @@ static inline void rwsem_set_nonspinnable(struct rw_semaphore *sem)
 	}
 }
 
+#ifdef MERGE_OWNER_INTO_COUNT
+/*
+ * Get the owner value from count to have early access to the task structure.
+ */
+static inline struct task_struct *rwsem_read_owner(struct rw_semaphore *sem)
+{
+	return (struct task_struct *)
+		rwsem_count_owner(atomic_long_read(&sem->count));
+}
+
+/*
+ * Return the real task structure pointer of the owner and the embedded
+ * flags in the owner.
+ */
+static inline struct task_struct *
+rwsem_read_owner_flags(struct rw_semaphore *sem, long *pflags)
+{
+	*pflags = atomic_long_read(&sem->owner) & RWSEM_OWNER_FLAGS_MASK;
+	return rwsem_read_owner(sem);
+}
+
 /*
  * This function does a read trylock by incrementing the reader count
  * and then decrementing it immediately if too many readers are present
@@ -276,6 +383,18 @@ static inline void rwsem_set_nonspinnable(struct rw_semaphore *sem)
  * of overflowing the count with minimal delay between the increment
  * and decrement.
  *
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
  * It returns the adjustment that should be added back to the count
  * in the slowpath.
  */
@@ -291,6 +410,16 @@ static inline long rwsem_read_trylock(struct rw_semaphore *sem, long *cnt)
 	return adjustment;
 }
 
+static int __init rwsem_show_count_status(void)
+{
+	pr_info("RW Semaphores: Write-owner in count & %d bits for readers.\n",
+		__READER_COUNT_BITS);
+	return 0;
+}
+late_initcall(rwsem_show_count_status);
+
+#else /* !MERGE_OWNER_INTO_COUNT */
+
 /*
  * Return just the real task structure pointer of the owner
  */
@@ -313,14 +442,21 @@ rwsem_read_owner_flags(struct rw_semaphore *sem, long *pflags)
 	return (struct task_struct *)(owner & ~RWSEM_OWNER_FLAGS_MASK);
 }
 
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
- * When the RWSEM_WRITER_LOCKED bit in count is set, the lock is owned
- * by a writer.
+ * When any of the RWSEM_WRITER_MASK bits in count is set, the lock is
+ * owned by a writer.
  *
  * The lock is owned by readers when
- * (1) the RWSEM_WRITER_LOCKED isn't set in count,
+ * (1) none of the RWSEM_WRITER_MASK bits is set in count,
  * (2) some of the reader bits are set in count, and
  * (3) the owner field has RWSEM_READ_OWNED bit set.
  *
@@ -1386,6 +1522,14 @@ static inline void __down_write(struct rw_semaphore *sem)
 		rwsem_down_write_slowpath(sem, TASK_UNINTERRUPTIBLE);
 	else
 		rwsem_set_owner(sem);
+#ifdef MERGE_OWNER_INTO_COUNT
+	/*
+	 * Make sure that count<=>owner translation is correct.
+	 */
+	DEBUG_RWSEMS_WARN_ON(
+		(atomic_long_read(&sem->owner) & ~RWSEM_OWNER_FLAGS_MASK) !=
+		(long)rwsem_read_owner(sem), sem);
+#endif
 }
 
 static inline int __down_write_killable(struct rw_semaphore *sem)
@@ -1446,7 +1590,7 @@ static inline void __up_write(struct rw_semaphore *sem)
 	DEBUG_RWSEMS_WARN_ON((rwsem_read_owner(sem) != current) &&
 			    !rwsem_test_oflags(sem, RWSEM_NONSPINNABLE), sem);
 	rwsem_clear_owner(sem);
-	tmp = atomic_long_fetch_add_release(-RWSEM_WRITER_LOCKED, &sem->count);
+	tmp = atomic_long_fetch_and_release(~RWSEM_WRITER_MASK, &sem->count);
 	if (unlikely(tmp & RWSEM_FLAG_WAITERS))
 		rwsem_wake(sem, tmp);
 }
-- 
2.18.1

