Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD45C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 264A52084A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="BC/LR+Nw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbfFQOfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:35:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51001 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfFQOfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:35:46 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HEYASA3458034
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 07:34:10 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HEYASA3458034
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560782051;
        bh=XyjqqB3F5HzeH/8QWTSHWXoo8Q2O6MgXfx2RNvolEj0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=BC/LR+NwB0qWylUGEFPee7knOq3T+71TJE4Oxkf8bjWXZ9jrk65e+gm2b2aJ99QXQ
         83kprTScJhCvYa7hPQa4JrTgIsw4v82eCa/tpBN5ollNDWmEYxfTybziYFckW/5QY5
         WY2/FUwlTyBe5sZNEGl5rJFbhEMwyZROgQucf8na14b81wDBgqHGwZbWx1sXERsYFW
         vKyqbEzOHldfqhe4PU+2Ilz39MqbeDUNOnl4yjV5qmf6T/c8lwwfFLcGXQsvuXNXgY
         BwOEorNnSL+2L1YlX5T7yAhzpPxHrnNCn/5LDWbgYsr2FYRffkHC2RGBF3Jax3Tsaj
         cJFswSE68ntvw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HEYAcL3458031;
        Mon, 17 Jun 2019 07:34:10 -0700
Date:   Mon, 17 Jun 2019 07:34:10 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-a15ea1a35f1b2782befc8b958c123c5d6a7cab0a@git.kernel.org>
Cc:     tim.c.chen@linux.intel.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, huang.ying.caritas@gmail.com,
        longman@redhat.com, dave@stgolabs.net, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
        bp@alien8.de, peterz@infradead.org
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
          bp@alien8.de, peterz@infradead.org,
          torvalds@linux-foundation.org, tim.c.chen@linux.intel.com,
          tglx@linutronix.de, huang.ying.caritas@gmail.com,
          longman@redhat.com, dave@stgolabs.net, will.deacon@arm.com
In-Reply-To: <20190520205918.22251-17-longman@redhat.com>
References: <20190520205918.22251-17-longman@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/rwsem: Guard against making count
 negative
Git-Commit-ID: a15ea1a35f1b2782befc8b958c123c5d6a7cab0a
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  a15ea1a35f1b2782befc8b958c123c5d6a7cab0a
Gitweb:     https://git.kernel.org/tip/a15ea1a35f1b2782befc8b958c123c5d6a7cab0a
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Mon, 20 May 2019 16:59:15 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 17 Jun 2019 12:28:11 +0200

locking/rwsem: Guard against making count negative

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: huang ying <huang.ying.caritas@gmail.com>
Link: https://lkml.kernel.org/r/20190520205918.22251-17-longman@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/rwsem.c | 53 ++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 41 insertions(+), 12 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index e1e0bac957c4..37524a47f002 100644
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
@@ -254,6 +270,14 @@ static inline void rwsem_set_nonspinnable(struct rw_semaphore *sem)
 					  owner | RWSEM_NONSPINNABLE));
 }
 
+static inline bool rwsem_read_trylock(struct rw_semaphore *sem)
+{
+	long cnt = atomic_long_add_return_acquire(RWSEM_READER_BIAS, &sem->count);
+	if (WARN_ON_ONCE(cnt < 0))
+		rwsem_set_nonspinnable(sem);
+	return !(cnt & RWSEM_READ_FAILED_MASK);
+}
+
 /*
  * Return just the real task structure pointer of the owner
  */
@@ -402,6 +426,12 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
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
@@ -949,9 +979,9 @@ static struct rw_semaphore __sched *
 rwsem_down_read_slowpath(struct rw_semaphore *sem, int state)
 {
 	long count, adjustment = -RWSEM_READER_BIAS;
-	bool wake = false;
 	struct rwsem_waiter waiter;
 	DEFINE_WAKE_Q(wake_q);
+	bool wake = false;
 
 	/*
 	 * Save the current read-owner of rwsem, if available, and the
@@ -1270,8 +1300,7 @@ static struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem)
  */
 inline void __down_read(struct rw_semaphore *sem)
 {
-	if (unlikely(atomic_long_fetch_add_acquire(RWSEM_READER_BIAS,
-			&sem->count) & RWSEM_READ_FAILED_MASK)) {
+	if (!rwsem_read_trylock(sem)) {
 		rwsem_down_read_slowpath(sem, TASK_UNINTERRUPTIBLE);
 		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
 	} else {
@@ -1281,8 +1310,7 @@ inline void __down_read(struct rw_semaphore *sem)
 
 static inline int __down_read_killable(struct rw_semaphore *sem)
 {
-	if (unlikely(atomic_long_fetch_add_acquire(RWSEM_READER_BIAS,
-			&sem->count) & RWSEM_READ_FAILED_MASK)) {
+	if (!rwsem_read_trylock(sem)) {
 		if (IS_ERR(rwsem_down_read_slowpath(sem, TASK_KILLABLE)))
 			return -EINTR;
 		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
@@ -1359,6 +1387,7 @@ inline void __up_read(struct rw_semaphore *sem)
 	DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
 	rwsem_clear_reader_owned(sem);
 	tmp = atomic_long_add_return_release(-RWSEM_READER_BIAS, &sem->count);
+	DEBUG_RWSEMS_WARN_ON(tmp < 0, sem);
 	if (unlikely((tmp & (RWSEM_LOCK_MASK|RWSEM_FLAG_WAITERS)) ==
 		      RWSEM_FLAG_WAITERS)) {
 		clear_wr_nonspinnable(sem);
