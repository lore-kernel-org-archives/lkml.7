Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9544C282DC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 19:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6F9F21738
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 19:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731959AbfDETWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 15:22:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60746 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731928AbfDETWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 15:22:22 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4C05E307CEBD;
        Fri,  5 Apr 2019 19:22:22 +0000 (UTC)
Received: from llong.com (dhcp-17-47.bos.redhat.com [10.18.17.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 19BAE61367;
        Fri,  5 Apr 2019 19:22:21 +0000 (UTC)
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
Subject: [PATCH-tip v2 10/12] locking/rwsem: Guard against making count negative
Date:   Fri,  5 Apr 2019 15:21:13 -0400
Message-Id: <20190405192115.17416-11-longman@redhat.com>
In-Reply-To: <20190405192115.17416-1-longman@redhat.com>
References: <20190405192115.17416-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 05 Apr 2019 19:22:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upper bits of the count field is used as reader count. When
sufficient number of active readers are present, the most significant
bit will be set and the count becomes negative. If the number of active
readers keep on piling up, we may eventually overflow the reader counts.
This is not likely to happen unless the number of bits reserved for
reader count is reduced because those bits are need for other purpose.

To prevent this count overflow from happening, the most significant bit
is now treated as a guard bit (RWSEM_FLAG_READFAIL). Read-lock attempts
will now fail for both the fast and optimistic spinning paths whenever
this bit is set. So all those extra readers will be put to sleep in
the wait queue. Wakeup will not happen until the reader count reaches 0.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem-xadd.c | 38 +++++++++++++++++++-----
 kernel/locking/rwsem.h      | 59 ++++++++++++++++++++++++++-----------
 2 files changed, 73 insertions(+), 24 deletions(-)

diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index a9756e3e3a73..d1aee97ee97d 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -92,7 +92,8 @@ enum rwsem_wake_type {
 /*
  * We limit the maximum number of readers that can be woken up for a
  * wake-up call to not penalizing the waking thread for spending too
- * much time doing it.
+ * much time doing it as well as the unlikely possiblity of overflowing
+ * the reader count.
  */
 #define MAX_READERS_WAKEUP	0x100
 
@@ -558,12 +559,35 @@ rwsem_waiter_is_first(struct rw_semaphore *sem, struct rwsem_waiter *waiter)
  * Wait for the read lock to be granted
  */
 static inline struct rw_semaphore __sched *
-__rwsem_down_read_failed_common(struct rw_semaphore *sem, int state)
+__rwsem_down_read_failed_common(struct rw_semaphore *sem, int state, long count)
 {
-	long count, adjustment = -RWSEM_READER_BIAS;
+	long adjustment = -RWSEM_READER_BIAS;
 	struct rwsem_waiter waiter;
 	DEFINE_WAKE_Q(wake_q);
 
+	if (unlikely(count < 0)) {
+		/*
+		 * The sign bit has been set meaning that too many active
+		 * readers are present. We need to decrement reader count &
+		 * enter wait queue immediately to avoid overflowing the
+		 * reader count.
+		 *
+		 * As preemption is not disabled, there is a remote
+		 * possibility that premption can happen in the narrow
+		 * timing window between incrementing and decrementing
+		 * the reader count and the task is put to sleep for a
+		 * considerable amount of time. If sufficient number
+		 * of such unfortunate sequence of events happen, we
+		 * may still overflow the reader count. It is extremely
+		 * unlikey, though. If this is a concern, we should consider
+		 * disable preemption during this timing window to make
+		 * sure that such unfortunate event will not happen.
+		 */
+		atomic_long_add(-RWSEM_READER_BIAS, &sem->count);
+		adjustment = 0;
+		goto queue;
+	}
+
 	if (!rwsem_can_spin_on_owner(sem))
 		goto queue;
 
@@ -664,16 +688,16 @@ __rwsem_down_read_failed_common(struct rw_semaphore *sem, int state)
 }
 
 __visible struct rw_semaphore * __sched
-rwsem_down_read_failed(struct rw_semaphore *sem)
+rwsem_down_read_failed(struct rw_semaphore *sem, long cnt)
 {
-	return __rwsem_down_read_failed_common(sem, TASK_UNINTERRUPTIBLE);
+	return __rwsem_down_read_failed_common(sem, TASK_UNINTERRUPTIBLE, cnt);
 }
 EXPORT_SYMBOL(rwsem_down_read_failed);
 
 __visible struct rw_semaphore * __sched
-rwsem_down_read_failed_killable(struct rw_semaphore *sem)
+rwsem_down_read_failed_killable(struct rw_semaphore *sem, long cnt)
 {
-	return __rwsem_down_read_failed_common(sem, TASK_KILLABLE);
+	return __rwsem_down_read_failed_common(sem, TASK_KILLABLE, cnt);
 }
 EXPORT_SYMBOL(rwsem_down_read_failed_killable);
 
diff --git a/kernel/locking/rwsem.h b/kernel/locking/rwsem.h
index bbb8a266dd50..52946fc0144e 100644
--- a/kernel/locking/rwsem.h
+++ b/kernel/locking/rwsem.h
@@ -43,13 +43,28 @@
 #endif
 
 /*
- * The definition of the atomic counter in the semaphore:
+ * On 64-bit architectures, the bit definitions of the count are:
  *
- * Bit  0   - writer locked bit
- * Bit  1   - waiters present bit
- * Bit  2   - lock handoff bit
- * Bits 3-7 - reserved
- * Bits 8-X - 24-bit (32-bit) or 56-bit reader count
+ * Bit  0    - writer locked bit
+ * Bit  1    - waiters present bit
+ * Bit  2    - lock handoff bit
+ * Bits 3-7  - reserved
+ * Bits 8-62 - 55-bit reader count
+ * Bit  63   - read fail bit
+ *
+ * On 32-bit architectures, the bit definitions of the count are:
+ *
+ * Bit  0    - writer locked bit
+ * Bit  1    - waiters present bit
+ * Bit  2    - lock handoff bit
+ * Bits 3-7  - reserved
+ * Bits 8-30 - 23-bit reader count
+ * Bit  31   - read fail bit
+ *
+ * It is not likely that the most significant bit (read fail bit) will ever
+ * be set. This guard bit is still checked anyway in the down_read() fastpath
+ * just in case we need to use up more of the reader bits for other purpose
+ * in the future.
  *
  * atomic_long_fetch_add() is used to obtain reader lock, whereas
  * atomic_long_cmpxchg() will be used to obtain writer lock.
@@ -57,6 +72,7 @@
 #define RWSEM_WRITER_LOCKED	(1UL << 0)
 #define RWSEM_FLAG_WAITERS	(1UL << 1)
 #define RWSEM_FLAG_HANDOFF	(1UL << 2)
+#define RWSEM_FLAG_READFAIL	(1UL << (BITS_PER_LONG - 1))
 
 #define RWSEM_READER_SHIFT	8
 #define RWSEM_READER_BIAS	(1UL << RWSEM_READER_SHIFT)
@@ -64,7 +80,7 @@
 #define RWSEM_WRITER_MASK	RWSEM_WRITER_LOCKED
 #define RWSEM_LOCK_MASK		(RWSEM_WRITER_MASK|RWSEM_READER_MASK)
 #define RWSEM_READ_FAILED_MASK	(RWSEM_WRITER_MASK|RWSEM_FLAG_WAITERS|\
-				 RWSEM_FLAG_HANDOFF)
+				 RWSEM_FLAG_HANDOFF|RWSEM_FLAG_READFAIL)
 
 #define RWSEM_COUNT_LOCKED(c)	((c) & RWSEM_LOCK_MASK)
 #define RWSEM_COUNT_WLOCKED(c)	((c) & RWSEM_WRITER_MASK)
@@ -210,10 +226,15 @@ static inline void rwsem_clear_reader_owned(struct rw_semaphore *sem)
 }
 #endif
 
-extern struct rw_semaphore *rwsem_down_read_failed(struct rw_semaphore *sem);
-extern struct rw_semaphore *rwsem_down_read_failed_killable(struct rw_semaphore *sem);
-extern struct rw_semaphore *rwsem_down_write_failed(struct rw_semaphore *sem);
-extern struct rw_semaphore *rwsem_down_write_failed_killable(struct rw_semaphore *sem);
+extern struct rw_semaphore *
+rwsem_down_read_failed(struct rw_semaphore *sem, long count);
+extern struct rw_semaphore *
+rwsem_down_read_failed_killable(struct rw_semaphore *sem, long count);
+extern struct rw_semaphore *
+rwsem_down_write_failed(struct rw_semaphore *sem);
+extern struct rw_semaphore *
+rwsem_down_write_failed_killable(struct rw_semaphore *sem);
+
 extern struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem, long count);
 extern struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem);
 
@@ -238,9 +259,11 @@ static inline void rwsem_set_nonspinnable(struct rw_semaphore *sem)
  */
 static inline void __down_read(struct rw_semaphore *sem)
 {
-	if (unlikely(atomic_long_fetch_add_acquire(RWSEM_READER_BIAS,
-			&sem->count) & RWSEM_READ_FAILED_MASK)) {
-		rwsem_down_read_failed(sem);
+	long count = atomic_long_fetch_add_acquire(RWSEM_READER_BIAS,
+						   &sem->count);
+
+	if (unlikely(count & RWSEM_READ_FAILED_MASK)) {
+		rwsem_down_read_failed(sem, count);
 		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
 	} else {
 		rwsem_set_reader_owned(sem);
@@ -249,9 +272,11 @@ static inline void __down_read(struct rw_semaphore *sem)
 
 static inline int __down_read_killable(struct rw_semaphore *sem)
 {
-	if (unlikely(atomic_long_fetch_add_acquire(RWSEM_READER_BIAS,
-			&sem->count) & RWSEM_READ_FAILED_MASK)) {
-		if (IS_ERR(rwsem_down_read_failed_killable(sem)))
+	long count = atomic_long_fetch_add_acquire(RWSEM_READER_BIAS,
+						   &sem->count);
+
+	if (unlikely(count & RWSEM_READ_FAILED_MASK)) {
+		if (IS_ERR(rwsem_down_read_failed_killable(sem, count)))
 			return -EINTR;
 		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
 	} else {
-- 
2.18.1

