Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DE5C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 23:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C51C7206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 23:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfDRXrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 19:47:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39936 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726884AbfDRXrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 19:47:23 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F33073099FC5;
        Thu, 18 Apr 2019 23:47:22 +0000 (UTC)
Received: from llong.com (ovpn-120-92.rdu2.redhat.com [10.10.120.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 75A2C5D707;
        Thu, 18 Apr 2019 23:47:21 +0000 (UTC)
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
Subject: [PATCH v5 16/18] locking/rwsem: Guard against making count negative
Date:   Thu, 18 Apr 2019 19:46:26 -0400
Message-Id: <20190418234628.3675-17-longman@redhat.com>
In-Reply-To: <20190418234628.3675-1-longman@redhat.com>
References: <20190418234628.3675-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 18 Apr 2019 23:47:23 +0000 (UTC)
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
 kernel/locking/rwsem.c | 73 +++++++++++++++++++++++++++++++++---------
 1 file changed, 58 insertions(+), 15 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 327bf8295d5d..7d2dc1314208 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -108,13 +108,28 @@
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
@@ -131,6 +146,7 @@
 #define RWSEM_WRITER_LOCKED	(1UL << 0)
 #define RWSEM_FLAG_WAITERS	(1UL << 1)
 #define RWSEM_FLAG_HANDOFF	(1UL << 2)
+#define RWSEM_FLAG_READFAIL	(1UL << (BITS_PER_LONG - 1))
 
 #define RWSEM_READER_SHIFT	8
 #define RWSEM_READER_BIAS	(1UL << RWSEM_READER_SHIFT)
@@ -138,7 +154,7 @@
 #define RWSEM_WRITER_MASK	RWSEM_WRITER_LOCKED
 #define RWSEM_LOCK_MASK		(RWSEM_WRITER_MASK|RWSEM_READER_MASK)
 #define RWSEM_READ_FAILED_MASK	(RWSEM_WRITER_MASK|RWSEM_FLAG_WAITERS|\
-				 RWSEM_FLAG_HANDOFF)
+				 RWSEM_FLAG_HANDOFF|RWSEM_FLAG_READFAIL)
 
 /*
  * All writes to owner are protected by WRITE_ONCE() to make sure that
@@ -872,13 +888,36 @@ static inline void clear_wr_nonspinnable(struct rw_semaphore *sem) { }
  * Wait for the read lock to be granted
  */
 static struct rw_semaphore __sched *
-rwsem_down_read_slowpath(struct rw_semaphore *sem, int state)
+rwsem_down_read_slowpath(struct rw_semaphore *sem, int state, long count)
 {
-	long count, adjustment = -RWSEM_READER_BIAS;
+	long adjustment = -RWSEM_READER_BIAS;
 	bool wake = false;
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
+		 * possibility that preemption can happen in the narrow
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
 	if (!rwsem_can_spin_on_owner(sem, false))
 		goto queue;
 
@@ -1189,9 +1228,11 @@ static struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem)
  */
 inline void __down_read(struct rw_semaphore *sem)
 {
-	if (unlikely(atomic_long_fetch_add_acquire(RWSEM_READER_BIAS,
-			&sem->count) & RWSEM_READ_FAILED_MASK)) {
-		rwsem_down_read_slowpath(sem, TASK_UNINTERRUPTIBLE);
+	long tmp = atomic_long_fetch_add_acquire(RWSEM_READER_BIAS,
+						 &sem->count);
+
+	if (unlikely(tmp & RWSEM_READ_FAILED_MASK)) {
+		rwsem_down_read_slowpath(sem, TASK_UNINTERRUPTIBLE, tmp);
 		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
 	} else {
 		rwsem_set_reader_owned(sem);
@@ -1200,9 +1241,11 @@ inline void __down_read(struct rw_semaphore *sem)
 
 static inline int __down_read_killable(struct rw_semaphore *sem)
 {
-	if (unlikely(atomic_long_fetch_add_acquire(RWSEM_READER_BIAS,
-			&sem->count) & RWSEM_READ_FAILED_MASK)) {
-		if (IS_ERR(rwsem_down_read_slowpath(sem, TASK_KILLABLE)))
+	long tmp = atomic_long_fetch_add_acquire(RWSEM_READER_BIAS,
+						 &sem->count);
+
+	if (unlikely(tmp & RWSEM_READ_FAILED_MASK)) {
+		if (IS_ERR(rwsem_down_read_slowpath(sem, TASK_KILLABLE, tmp)))
 			return -EINTR;
 		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
 	} else {
-- 
2.18.1

