Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D68C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E21CF21773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfC1SMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 14:12:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34630 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727749AbfC1SMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 14:12:18 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 90C3B8110E;
        Thu, 28 Mar 2019 18:12:17 +0000 (UTC)
Received: from llong.com (dhcp-17-19.bos.redhat.com [10.18.17.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8B2895D71A;
        Thu, 28 Mar 2019 18:12:16 +0000 (UTC)
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
Subject: [PATCH 12/12] locking/rwsem: Make MSbit of count as guard bit to fail readlock
Date:   Thu, 28 Mar 2019 14:11:06 -0400
Message-Id: <20190328181106.22887-13-longman@redhat.com>
In-Reply-To: <20190328181106.22887-1-longman@redhat.com>
References: <20190328181106.22887-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 28 Mar 2019 18:12:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the merging of owner into count for x86-64, there is only 16 bits
left for reader count. It is theoretically possible for an application to
cause more than 64k readers to acquire a rwsem leading to count overflow.

To prevent this dire situation, the most significant bit of the count
is now treated as a guard bit (RWSEM_FLAG_READFAIL). Read-lock will now
fails for both the fast and optimistic spinning paths whenever this bit
is set. So all those extra readers will be put to sleep in the wait
queue. Wakeup will not happen until the reader count reaches 0. This
effectively limit the maximum reader count to 32k.

A limit of 256 is also imposed on the number of readers that can be woken
up in one wakeup function call. This will eliminate the possibility of
waking up more than 64k readers and overflowing the count.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lock_events_list.h |  1 +
 kernel/locking/rwsem-xadd.c       | 34 +++++++++++++++++++------
 kernel/locking/rwsem.h            | 41 ++++++++++++++++++++-----------
 3 files changed, 55 insertions(+), 21 deletions(-)

diff --git a/kernel/locking/lock_events_list.h b/kernel/locking/lock_events_list.h
index f3550aa5866a..8c254e9b3f0a 100644
--- a/kernel/locking/lock_events_list.h
+++ b/kernel/locking/lock_events_list.h
@@ -59,6 +59,7 @@ LOCK_EVENT(rwsem_wake_writer)	/* # of writer wakeups			*/
 LOCK_EVENT(rwsem_opt_rlock)	/* # of read locks opt-spin acquired	*/
 LOCK_EVENT(rwsem_opt_wlock)	/* # of write locks opt-spin acquired	*/
 LOCK_EVENT(rwsem_opt_fail)	/* # of failed opt-spinnings		*/
+LOCK_EVENT(rwsem_opt_rfail)	/* # of failed reader-owned readlocks	*/
 LOCK_EVENT(rwsem_opt_nospin)	/* # of disabled reader opt-spinnings	*/
 LOCK_EVENT(rwsem_rlock)		/* # of read locks acquired		*/
 LOCK_EVENT(rwsem_rlock_fast)	/* # of fast read locks acquired	*/
diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index 87348b031b85..2d3a8023c379 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -112,7 +112,8 @@ enum rwsem_wake_type {
 /*
  * We limit the maximum number of readers that can be woken up for a
  * wake-up call to not penalizing the waking thread for spending too
- * much time doing it.
+ * much time doing it as well as the unlikely possiblity of overflowing
+ * the reader count.
  */
 #define MAX_READERS_WAKEUP	0x100
 
@@ -456,6 +457,15 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem, const long wlock)
 		if (taken)
 			break;
 
+		/*
+		 * If a reader cannot acquire a reader-owned lock, we
+		 * have to quit. The handoff bit might have been set.
+		 */
+		if (unlikely(!wlock && (owner_state == OWNER_READER))) {
+			lockevent_inc(rwsem_opt_rfail);
+			break;
+		}
+
 		/*
 		 * We only decremnt rspin_cnt when a writer is trying to
 		 * acquire a lock owned by readers. In which case,
@@ -553,12 +563,22 @@ rwsem_waiter_is_first(struct rw_semaphore *sem, struct rwsem_waiter *waiter)
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
+		 * Too many active readers, decrement count &
+		 * enter the wait queue.
+		 */
+		atomic_long_add(-RWSEM_READER_BIAS, &sem->count);
+		adjustment = 0;
+		goto queue;
+	}
+
 	if (!rwsem_can_spin_on_owner(sem))
 		goto queue;
 
@@ -659,16 +679,16 @@ __rwsem_down_read_failed_common(struct rw_semaphore *sem, int state)
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
index f7449e82a9da..1ce13da7a1f4 100644
--- a/kernel/locking/rwsem.h
+++ b/kernel/locking/rwsem.h
@@ -72,7 +72,8 @@
  * Bit   0    - waiters present bit
  * Bit   1    - lock handoff bit
  * Bits  2-47 - compressed task structure pointer
- * Bits 48-63 - 16-bit reader counts
+ * Bits 48-62 - 15-bit reader counts
+ * Bit  63    - read fail bit
  *
  * On other 64-bit architectures, the bit definitions are:
  *
@@ -80,7 +81,8 @@
  * Bit  1    - lock handoff bit
  * Bits 2-6  - reserved
  * Bit  7    - writer lock bit
- * Bits 8-63 - 56-bit reader counts
+ * Bits 8-62 - 55-bit reader counts
+ * Bit  63   - read fail bit
  *
  * On 32-bit architectures, the bit definitions of the count are:
  *
@@ -88,13 +90,15 @@
  * Bit  1    - lock handoff bit
  * Bits 2-6  - reserved
  * Bit  7    - writer lock bit
- * Bits 8-31 - 24-bit reader counts
+ * Bits 8-30 - 23-bit reader counts
+ * Bit  31   - read fail bit
  *
  * atomic_long_fetch_add() is used to obtain reader lock, whereas
  * atomic_long_cmpxchg() will be used to obtain writer lock.
  */
 #define RWSEM_FLAG_WAITERS	(1UL << 0)
 #define RWSEM_FLAG_HANDOFF	(1UL << 1)
+#define RWSEM_FLAG_READFAIL	(1UL << (BITS_PER_LONG - 1))
 
 #ifdef RWSEM_MERGE_OWNER_TO_COUNT
 
@@ -117,7 +121,7 @@
 #define RWSEM_READER_MASK	(~(RWSEM_READER_BIAS - 1))
 #define RWSEM_LOCK_MASK		(RWSEM_WRITER_MASK|RWSEM_READER_MASK)
 #define RWSEM_READ_FAILED_MASK	(RWSEM_WRITER_MASK|RWSEM_FLAG_WAITERS|\
-				 RWSEM_FLAG_HANDOFF)
+				 RWSEM_FLAG_HANDOFF|RWSEM_FLAG_READFAIL)
 
 #define RWSEM_COUNT_LOCKED(c)	((c) & RWSEM_LOCK_MASK)
 #define RWSEM_COUNT_WLOCKED(c)	((c) & RWSEM_WRITER_MASK)
@@ -300,10 +304,15 @@ static inline void rwsem_clear_reader_owned(struct rw_semaphore *sem)
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
 
@@ -328,9 +337,11 @@ static inline void rwsem_set_nonspinnable(struct rw_semaphore *sem)
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
@@ -339,9 +350,11 @@ static inline void __down_read(struct rw_semaphore *sem)
 
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

