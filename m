Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7A7C4321A
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 21:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A934620679
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 21:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbfD1V1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 17:27:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57124 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726975AbfD1V1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 17:27:11 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4B7B83086258;
        Sun, 28 Apr 2019 21:27:10 +0000 (UTC)
Received: from llong.com (ovpn-120-22.rdu2.redhat.com [10.10.120.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E054217989;
        Sun, 28 Apr 2019 21:27:08 +0000 (UTC)
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
Subject: [PATCH-tip v7 17/20] locking/rwsem: Guard against making count negative
Date:   Sun, 28 Apr 2019 17:25:54 -0400
Message-Id: <20190428212557.13482-18-longman@redhat.com>
In-Reply-To: <20190428212557.13482-1-longman@redhat.com>
References: <20190428212557.13482-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Sun, 28 Apr 2019 21:27:10 +0000 (UTC)
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

To prevent this count overflow from happening, the most significant
bit is now treated as a guard bit (RWSEM_FLAG_READFAIL). Read-lock
attempts will now fail for both the fast and slow paths whenever this
bit is set. So all those extra readers will be put to sleep in the wait
list. Wakeup will not happen until the reader count reaches 0.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem.c | 95 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 80 insertions(+), 15 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 1a4f2c1c27c4..1ab1762e9988 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -116,13 +116,28 @@
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
@@ -139,6 +154,7 @@
 #define RWSEM_WRITER_LOCKED	(1UL << 0)
 #define RWSEM_FLAG_WAITERS	(1UL << 1)
 #define RWSEM_FLAG_HANDOFF	(1UL << 2)
+#define RWSEM_FLAG_READFAIL	(1UL << (BITS_PER_LONG - 1))
 
 #define RWSEM_READER_SHIFT	8
 #define RWSEM_READER_BIAS	(1UL << RWSEM_READER_SHIFT)
@@ -146,7 +162,7 @@
 #define RWSEM_WRITER_MASK	RWSEM_WRITER_LOCKED
 #define RWSEM_LOCK_MASK		(RWSEM_WRITER_MASK|RWSEM_READER_MASK)
 #define RWSEM_READ_FAILED_MASK	(RWSEM_WRITER_MASK|RWSEM_FLAG_WAITERS|\
-				 RWSEM_FLAG_HANDOFF)
+				 RWSEM_FLAG_HANDOFF|RWSEM_FLAG_READFAIL)
 
 /*
  * All writes to owner are protected by WRITE_ONCE() to make sure that
@@ -277,6 +293,28 @@ static inline void rwsem_set_nonspinnable(struct rw_semaphore *sem)
 	}
 }
 
+/*
+ * This function does a read trylock by incrementing the reader count
+ * and then decrementing it immediately if too many readers are present
+ * (count becomes negative) in order to prevent the remote possibility
+ * of overflowing the count with minimal delay between the increment
+ * and decrement.
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
 /*
  * Guide to the rw_semaphore's count field.
  *
@@ -403,6 +441,12 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
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
@@ -964,13 +1008,30 @@ static inline bool rwsem_reader_phase_trylock(struct rw_semaphore *sem,
  * Wait for the read lock to be granted
  */
 static struct rw_semaphore __sched *
-rwsem_down_read_slowpath(struct rw_semaphore *sem, int state)
+rwsem_down_read_slowpath(struct rw_semaphore *sem, int state, long adjustment)
 {
-	long count, adjustment = -RWSEM_READER_BIAS;
+	long count;
 	bool wake = false;
 	struct rwsem_waiter waiter;
 	DEFINE_WAKE_Q(wake_q);
 
+	if (unlikely(!adjustment)) {
+		/*
+		 * This shouldn't happen. If it does, there is probably
+		 * something wrong in the system.
+		 */
+		WARN_ON_ONCE(1);
+
+		/*
+		 * An adjustment of 0 means that there are too many readers
+		 * holding or trying to acquire the lock. So disable
+		 * optimistic spinning and go directly into the wait list.
+		 */
+		if (is_rwsem_spinnable(sem, false))
+			rwsem_set_nonspinnable(sem);
+		goto queue;
+	}
+
 	/*
 	 * Save the current read-owner of rwsem, if available, and the
 	 * reader nonspinnable bit.
@@ -1294,9 +1355,10 @@ static struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem)
  */
 inline void __down_read(struct rw_semaphore *sem)
 {
-	if (unlikely(atomic_long_fetch_add_acquire(RWSEM_READER_BIAS,
-			&sem->count) & RWSEM_READ_FAILED_MASK)) {
-		rwsem_down_read_slowpath(sem, TASK_UNINTERRUPTIBLE);
+	long tmp, adjustment = rwsem_read_trylock(sem, &tmp);
+
+	if (unlikely(tmp & RWSEM_READ_FAILED_MASK)) {
+		rwsem_down_read_slowpath(sem, TASK_UNINTERRUPTIBLE, adjustment);
 		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
 	} else {
 		rwsem_set_reader_owned(sem);
@@ -1305,9 +1367,11 @@ inline void __down_read(struct rw_semaphore *sem)
 
 static inline int __down_read_killable(struct rw_semaphore *sem)
 {
-	if (unlikely(atomic_long_fetch_add_acquire(RWSEM_READER_BIAS,
-			&sem->count) & RWSEM_READ_FAILED_MASK)) {
-		if (IS_ERR(rwsem_down_read_slowpath(sem, TASK_KILLABLE)))
+	long tmp, adjustment = rwsem_read_trylock(sem, &tmp);
+
+	if (unlikely(tmp & RWSEM_READ_FAILED_MASK)) {
+		if (IS_ERR(rwsem_down_read_slowpath(sem, TASK_KILLABLE,
+						    adjustment)))
 			return -EINTR;
 		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
 	} else {
@@ -1383,6 +1447,7 @@ inline void __up_read(struct rw_semaphore *sem)
 	DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
 	rwsem_clear_reader_owned(sem);
 	tmp = atomic_long_add_return_release(-RWSEM_READER_BIAS, &sem->count);
+	DEBUG_RWSEMS_WARN_ON(tmp < 0, sem);
 	if (unlikely((tmp & (RWSEM_LOCK_MASK|RWSEM_FLAG_WAITERS)) ==
 		      RWSEM_FLAG_WAITERS)) {
 		clear_wr_nonspinnable(sem);
-- 
2.18.1

