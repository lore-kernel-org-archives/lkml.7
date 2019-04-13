Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E7AC10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 17:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6773206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 17:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbfDMRYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 13:24:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41066 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727914AbfDMRYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 13:24:04 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BEC3B30A5A54;
        Sat, 13 Apr 2019 17:24:03 +0000 (UTC)
Received: from llong.com (ovpn-120-133.rdu2.redhat.com [10.10.120.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8E7545D9C6;
        Sat, 13 Apr 2019 17:24:02 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v4 14/16] locking/rwsem: Guard against making count negative
Date:   Sat, 13 Apr 2019 13:22:57 -0400
Message-Id: <20190413172259.2740-15-longman@redhat.com>
In-Reply-To: <20190413172259.2740-1-longman@redhat.com>
References: <20190413172259.2740-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Sat, 13 Apr 2019 17:24:03 +0000 (UTC)
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
 kernel/locking/rwsem.c | 84 ++++++++++++++++++++++++++++++++----------
 1 file changed, 64 insertions(+), 20 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index ab26aba65371..f37ab6358fe0 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -73,13 +73,28 @@
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
@@ -96,6 +111,7 @@
 #define RWSEM_WRITER_LOCKED	(1UL << 0)
 #define RWSEM_FLAG_WAITERS	(1UL << 1)
 #define RWSEM_FLAG_HANDOFF	(1UL << 2)
+#define RWSEM_FLAG_READFAIL	(1UL << (BITS_PER_LONG - 1))
 
 #define RWSEM_READER_SHIFT	8
 #define RWSEM_READER_BIAS	(1UL << RWSEM_READER_SHIFT)
@@ -103,7 +119,7 @@
 #define RWSEM_WRITER_MASK	RWSEM_WRITER_LOCKED
 #define RWSEM_LOCK_MASK		(RWSEM_WRITER_MASK|RWSEM_READER_MASK)
 #define RWSEM_READ_FAILED_MASK	(RWSEM_WRITER_MASK|RWSEM_FLAG_WAITERS|\
-				 RWSEM_FLAG_HANDOFF)
+				 RWSEM_FLAG_HANDOFF|RWSEM_FLAG_READFAIL)
 
 #define RWSEM_COUNT_LOCKED(c)	((c) & RWSEM_LOCK_MASK)
 #define RWSEM_COUNT_WLOCKED(c)	((c) & RWSEM_WRITER_MASK)
@@ -315,7 +331,8 @@ enum writer_wait_state {
 /*
  * We limit the maximum number of readers that can be woken up for a
  * wake-up call to not penalizing the waking thread for spending too
- * much time doing it.
+ * much time doing it as well as the unlikely possiblity of overflowing
+ * the reader count.
  */
 #define MAX_READERS_WAKEUP	0x100
 
@@ -799,12 +816,35 @@ rwsem_waiter_is_first(struct rw_semaphore *sem, struct rwsem_waiter *waiter)
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
 
@@ -905,15 +945,15 @@ __rwsem_down_read_failed_common(struct rw_semaphore *sem, int state)
 }
 
 static inline struct rw_semaphore * __sched
-rwsem_down_read_failed(struct rw_semaphore *sem)
+rwsem_down_read_failed(struct rw_semaphore *sem, long cnt)
 {
-	return __rwsem_down_read_failed_common(sem, TASK_UNINTERRUPTIBLE);
+	return __rwsem_down_read_failed_common(sem, TASK_UNINTERRUPTIBLE, cnt);
 }
 
 static inline struct rw_semaphore * __sched
-rwsem_down_read_failed_killable(struct rw_semaphore *sem)
+rwsem_down_read_failed_killable(struct rw_semaphore *sem, long cnt)
 {
-	return __rwsem_down_read_failed_common(sem, TASK_KILLABLE);
+	return __rwsem_down_read_failed_common(sem, TASK_KILLABLE, cnt);
 }
 
 /*
@@ -1118,9 +1158,11 @@ static struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem)
  */
 inline void __down_read(struct rw_semaphore *sem)
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
@@ -1129,9 +1171,11 @@ inline void __down_read(struct rw_semaphore *sem)
 
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

