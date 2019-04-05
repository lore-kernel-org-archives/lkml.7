Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA685C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 19:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEAB72175B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 19:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731975AbfDETW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 15:22:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45904 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731950AbfDETWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 15:22:24 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3783CCD01D;
        Fri,  5 Apr 2019 19:22:24 +0000 (UTC)
Received: from llong.com (dhcp-17-47.bos.redhat.com [10.18.17.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6CD0E61367;
        Fri,  5 Apr 2019 19:22:22 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH-tip v2 11/12] locking/rwsem: Merge owner into count on x86-64
Date:   Fri,  5 Apr 2019 15:21:14 -0400
Message-Id: <20190405192115.17416-12-longman@redhat.com>
In-Reply-To: <20190405192115.17416-1-longman@redhat.com>
References: <20190405192115.17416-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 05 Apr 2019 19:22:24 +0000 (UTC)
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
That can supports up to (32k-1) readers.

The owner value will still be duplicated in the owner field as that
will ease debugging when looking at core dump.

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
 kernel/locking/rwsem-xadd.c |  11 ++--
 kernel/locking/rwsem.h      | 101 +++++++++++++++++++++++++++++++++---
 2 files changed, 103 insertions(+), 9 deletions(-)

diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index d1aee97ee97d..ebdf21fcd75e 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -27,11 +27,11 @@
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
@@ -47,6 +47,11 @@
 void __init_rwsem(struct rw_semaphore *sem, const char *name,
 		  struct lock_class_key *key)
 {
+	/*
+	 * We should support at least (4k-1) concurrent readers
+	 */
+	BUILD_BUG_ON(sizeof(long) * 8 - RWSEM_READER_SHIFT < 12);
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	/*
 	 * Make sure we are not reinitializing a held semaphore:
diff --git a/kernel/locking/rwsem.h b/kernel/locking/rwsem.h
index 52946fc0144e..1153500694ed 100644
--- a/kernel/locking/rwsem.h
+++ b/kernel/locking/rwsem.h
@@ -43,7 +43,41 @@
 #endif
 
 /*
- * On 64-bit architectures, the bit definitions of the count are:
+ * Enable the merging of owner into count for x86-64 only.
+ */
+#ifdef CONFIG_X86_64
+#define RWSEM_MERGE_OWNER_TO_COUNT
+#endif
+
+/*
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
+ * For x86-64, the physical address can use up to 52 bits. That is 4PB
+ * of memory. That leaves 12 bits available for other use. The task
+ * structure pointer is also aligned to the L1 cache size. That means
+ * another 6 bits (64 bytes cacheline) will be available. Reserving
+ * 2 bits for status flags, we will have 16 bits for the reader count
+ * and read fail bit. That can supports up to (32k-1) active readers.
+ *
+ * On x86-64, the bit definitions of the count are:
+ *
+ * Bit   0    - waiters present bit
+ * Bit   1    - lock handoff bit
+ * Bits  2-47 - compressed task structure pointer
+ * Bits 48-62 - 15-bit reader counts
+ * Bit  63    - read fail bit
+ *
+ * On other 64-bit architectures, the bit definitions are:
  *
  * Bit  0    - writer locked bit
  * Bit  1    - waiters present bit
@@ -69,15 +103,30 @@
  * atomic_long_fetch_add() is used to obtain reader lock, whereas
  * atomic_long_cmpxchg() will be used to obtain writer lock.
  */
-#define RWSEM_WRITER_LOCKED	(1UL << 0)
-#define RWSEM_FLAG_WAITERS	(1UL << 1)
-#define RWSEM_FLAG_HANDOFF	(1UL << 2)
+#define RWSEM_FLAG_WAITERS	(1UL << 0)
+#define RWSEM_FLAG_HANDOFF	(1UL << 1)
 #define RWSEM_FLAG_READFAIL	(1UL << (BITS_PER_LONG - 1))
 
+
+#ifdef RWSEM_MERGE_OWNER_TO_COUNT
+
+#ifdef __PHYSICAL_MASK_SHIFT
+#define RWSEM_PA_MASK_SHIFT	__PHYSICAL_MASK_SHIFT
+#else
+#define RWSEM_PA_MASK_SHIFT	52
+#endif
+#define RWSEM_READER_SHIFT	(RWSEM_PA_MASK_SHIFT - L1_CACHE_SHIFT + 2)
+#define RWSEM_WRITER_MASK	((1UL << RWSEM_READER_SHIFT) - 4)
+#define RWSEM_WRITER_LOCKED	rwsem_owner_count(current)
+
+#else /* RWSEM_MERGE_OWNER_TO_COUNT */
 #define RWSEM_READER_SHIFT	8
+#define RWSEM_WRITER_MASK	(1UL << 7)
+#define RWSEM_WRITER_LOCKED	RWSEM_WRITER_MASK
+#endif /* RWSEM_MERGE_OWNER_TO_COUNT */
+
 #define RWSEM_READER_BIAS	(1UL << RWSEM_READER_SHIFT)
 #define RWSEM_READER_MASK	(~(RWSEM_READER_BIAS - 1))
-#define RWSEM_WRITER_MASK	RWSEM_WRITER_LOCKED
 #define RWSEM_LOCK_MASK		(RWSEM_WRITER_MASK|RWSEM_READER_MASK)
 #define RWSEM_READ_FAILED_MASK	(RWSEM_WRITER_MASK|RWSEM_FLAG_WAITERS|\
 				 RWSEM_FLAG_HANDOFF|RWSEM_FLAG_READFAIL)
@@ -90,6 +139,22 @@
 #define RWSEM_COUNT_WLOCKED_OR_HANDOFF(c)	\
 	((c) & (RWSEM_WRITER_MASK | RWSEM_FLAG_HANDOFF))
 
+/*
+ * Task structure pointer compression (64-bit only):
+ * (owner - PAGE_OFFSET) >> (L1_CACHE_SHIFT - 2)
+ */
+static inline unsigned long rwsem_owner_count(struct task_struct *owner)
+{
+	return ((unsigned long)owner - PAGE_OFFSET) >> (L1_CACHE_SHIFT - 2);
+}
+
+static inline unsigned long rwsem_count_owner(long count)
+{
+	unsigned long writer = (unsigned long)count & RWSEM_WRITER_MASK;
+
+	return writer ? (writer << (L1_CACHE_SHIFT - 2)) + PAGE_OFFSET : 0;
+}
+
 #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
 /*
  * All writes to owner are protected by WRITE_ONCE() to make sure that
@@ -97,7 +162,12 @@
  * the owner value concurrently without lock. Read from owner, however,
  * may not need READ_ONCE() as long as the pointer value is only used
  * for comparison and isn't being dereferenced.
+ *
+ * On 32-bit architectures, the owner and count are separate. On 64-bit
+ * architectures, however, the writer task structure pointer is written
+ * to the count as well in addition to the owner field.
  */
+
 static inline void rwsem_set_owner(struct rw_semaphore *sem)
 {
 	WRITE_ONCE(sem->owner, current);
@@ -108,10 +178,26 @@ static inline void rwsem_clear_owner(struct rw_semaphore *sem)
 	WRITE_ONCE(sem->owner, NULL);
 }
 
+#ifdef RWSEM_MERGE_OWNER_TO_COUNT
+/*
+ * Get the owner value from count to have early access to the task structure.
+ * Owner from sem->count should includes the RWSEM_ANONYMOUSLY_OWNED bit
+ * from sem->owner.
+ */
+static inline struct task_struct *rwsem_get_owner(struct rw_semaphore *sem)
+{
+	unsigned long cowner = rwsem_count_owner(atomic_long_read(&sem->count));
+	unsigned long sowner = (unsigned long)READ_ONCE(sem->owner);
+
+	return (struct task_struct *) (cowner
+		? cowner | (sowner & RWSEM_ANONYMOUSLY_OWNED) : sowner);
+}
+#else /* !RWSEM_MERGE_OWNER_TO_COUNT */
 static inline struct task_struct *rwsem_get_owner(struct rw_semaphore *sem)
 {
 	return READ_ONCE(sem->owner);
 }
+#endif /* RWSEM_MERGE_OWNER_TO_COUNT */
 
 /*
  * The task_struct pointer of the last owning reader will be left in
@@ -312,6 +398,9 @@ static inline void __down_write(struct rw_semaphore *sem)
 						 RWSEM_WRITER_LOCKED)))
 		rwsem_down_write_failed(sem);
 	rwsem_set_owner(sem);
+#ifdef RWSEM_MERGE_OWNER_TO_COUNT
+	DEBUG_RWSEMS_WARN_ON(sem->owner != rwsem_get_owner(sem), sem);
+#endif
 }
 
 static inline int __down_write_killable(struct rw_semaphore *sem)
@@ -362,7 +451,7 @@ static inline void __up_write(struct rw_semaphore *sem)
 
 	DEBUG_RWSEMS_WARN_ON(sem->owner != current, sem);
 	rwsem_clear_owner(sem);
-	tmp = atomic_long_fetch_add_release(-RWSEM_WRITER_LOCKED, &sem->count);
+	tmp = atomic_long_fetch_and_release(~RWSEM_WRITER_MASK, &sem->count);
 	if (unlikely(tmp & RWSEM_FLAG_WAITERS))
 		rwsem_wake(sem, tmp);
 }
-- 
2.18.1

