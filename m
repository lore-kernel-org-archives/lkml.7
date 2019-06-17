Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F677C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AB012084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="bAaLJJuJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbfFQO0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:26:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48587 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfFQO0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:26:38 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HEOx453455946
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 07:25:00 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HEOx453455946
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560781500;
        bh=ABULmBwgcgvxRmNL05lmNqthOI94+AItK9bxMxS8ClU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=bAaLJJuJcczF+fNhFIYdpTxMDGU50uPJ8VPPcUlMvalUytWpWmFLWzv8AFhjgLhZr
         lipduZsbKp/xTzcxTKrOxs77Db/30ti31gpsEkprKcWgQ9/I1slpTCr83y5WZd5PVh
         aivZxUM8jVkzum8jwmnP9QUK+gIX5CiKZreIWaVUiE41HUmaen3VbRLs4mBp/4Pb8X
         UPazXkrdfJsm8zTu9jeZkohqdqgRgQjAYtj/hjFyXzHsvzVAkeFoPpVJ4f8TfNcrFJ
         tLgUFtgM9+TFYBboNDGk0LZ97TgzPrJp05YLdQiMLyizs/Ha2k9cOj6mlfMXXnRjfv
         zxaHH9ppYBarg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HEOxWX3455943;
        Mon, 17 Jun 2019 07:24:59 -0700
Date:   Mon, 17 Jun 2019 07:24:59 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-64489e78004cb5623211c75790cac90bd25ff5e9@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, will.deacon@arm.com,
        peterz@infradead.org, dave@stgolabs.net, hpa@zytor.com,
        tglx@linutronix.de, huang.ying.caritas@gmail.com, bp@alien8.de,
        mingo@kernel.org, tim.c.chen@linux.intel.com,
        torvalds@linux-foundation.org, longman@redhat.com
Reply-To: will.deacon@arm.com, peterz@infradead.org,
          linux-kernel@vger.kernel.org, dave@stgolabs.net, hpa@zytor.com,
          tglx@linutronix.de, huang.ying.caritas@gmail.com, bp@alien8.de,
          mingo@kernel.org, tim.c.chen@linux.intel.com,
          torvalds@linux-foundation.org, longman@redhat.com
In-Reply-To: <20190520205918.22251-4-longman@redhat.com>
References: <20190520205918.22251-4-longman@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/rwsem: Implement a new locking scheme
Git-Commit-ID: 64489e78004cb5623211c75790cac90bd25ff5e9
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

Commit-ID:  64489e78004cb5623211c75790cac90bd25ff5e9
Gitweb:     https://git.kernel.org/tip/64489e78004cb5623211c75790cac90bd25ff5e9
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Mon, 20 May 2019 16:59:02 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 17 Jun 2019 12:27:56 +0200

locking/rwsem: Implement a new locking scheme

The current way of using various reader, writer and waiting biases
in the rwsem code are confusing and hard to understand. I have to
reread the rwsem count guide in the rwsem-xadd.c file from time to
time to remind myself how this whole thing works. It also makes the
rwsem code harder to be optimized.

To make rwsem more sane, a new locking scheme similar to the one in
qrwlock is now being used.  The atomic long count has the following
bit definitions:

  Bit  0   - writer locked bit
  Bit  1   - waiters present bit
  Bits 2-7 - reserved for future extension
  Bits 8-X - reader count (24/56 bits)

The cmpxchg instruction is now used to acquire the write lock. The read
lock is still acquired with xadd instruction, so there is no change here.
This scheme will allow up to 16M/64P active readers which should be
more than enough. We can always use some more reserved bits if necessary.

With that change, we can deterministically know if a rwsem has been
write-locked. Looking at the count alone, however, one cannot determine
for certain if a rwsem is owned by readers or not as the readers that
set the reader count bits may be in the process of backing out. So we
still need the reader-owned bit in the owner field to be sure.

With a locking microbenchmark running on 5.1 based kernel, the total
locking rates (in kops/s) of the benchmark on a 8-socket 120-core
IvyBridge-EX system before and after the patch were as follows:

                  Before Patch      After Patch
   # of Threads  wlock    rlock    wlock    rlock
   ------------  -----    -----    -----    -----
        1        30,659   31,341   31,055   31,283
        2         8,909   16,457    9,884   17,659
        4         9,028   15,823    8,933   20,233
        8         8,410   14,212    7,230   17,140
       16         8,217   25,240    7,479   24,607

The locking rates of the benchmark on a Power8 system were as follows:

                  Before Patch      After Patch
   # of Threads  wlock    rlock    wlock    rlock
   ------------  -----    -----    -----    -----
        1        12,963   13,647   13,275   13,601
        2         7,570   11,569    7,902   10,829
        4         5,232    5,516    5,466    5,435
        8         5,233    3,386    5,467    3,168

The locking rates of the benchmark on a 2-socket ARM64 system were
as follows:

                  Before Patch      After Patch
   # of Threads  wlock    rlock    wlock    rlock
   ------------  -----    -----    -----    -----
        1        21,495   21,046   21,524   21,074
        2         5,293   10,502    5,333   10,504
        4         5,325   11,463    5,358   11,631
        8         5,391   11,712    5,470   11,680

The performance are roughly the same before and after the patch. There
are run-to-run variations in performance. Runs with higher variances
usually have higher throughput.

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
Link: https://lkml.kernel.org/r/20190520205918.22251-4-longman@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/rwsem-xadd.c | 147 +++++++++++++++-----------------------------
 kernel/locking/rwsem.h      |  74 +++++++++++-----------
 2 files changed, 85 insertions(+), 136 deletions(-)

diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index 3083fdf50447..7d537b50a849 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -9,6 +9,8 @@
  *
  * Optimistic spinning by Tim Chen <tim.c.chen@intel.com>
  * and Davidlohr Bueso <davidlohr@hp.com>. Based on mutexes.
+ *
+ * Rwsem count bit fields re-definition by Waiman Long <longman@redhat.com>.
  */
 #include <linux/rwsem.h>
 #include <linux/init.h>
@@ -22,52 +24,20 @@
 #include "rwsem.h"
 
 /*
- * Guide to the rw_semaphore's count field for common values.
- * (32-bit case illustrated, similar for 64-bit)
- *
- * 0x0000000X	(1) X readers active or attempting lock, no writer waiting
- *		    X = #active_readers + #readers attempting to lock
- *		    (X*ACTIVE_BIAS)
- *
- * 0x00000000	rwsem is unlocked, and no one is waiting for the lock or
- *		attempting to read lock or write lock.
- *
- * 0xffff000X	(1) X readers active or attempting lock, with waiters for lock
- *		    X = #active readers + # readers attempting lock
- *		    (X*ACTIVE_BIAS + WAITING_BIAS)
- *		(2) 1 writer attempting lock, no waiters for lock
- *		    X-1 = #active readers + #readers attempting lock
- *		    ((X-1)*ACTIVE_BIAS + ACTIVE_WRITE_BIAS)
- *		(3) 1 writer active, no waiters for lock
- *		    X-1 = #active readers + #readers attempting lock
- *		    ((X-1)*ACTIVE_BIAS + ACTIVE_WRITE_BIAS)
- *
- * 0xffff0001	(1) 1 reader active or attempting lock, waiters for lock
- *		    (WAITING_BIAS + ACTIVE_BIAS)
- *		(2) 1 writer active or attempting lock, no waiters for lock
- *		    (ACTIVE_WRITE_BIAS)
+ * Guide to the rw_semaphore's count field.
  *
- * 0xffff0000	(1) There are writers or readers queued but none active
- *		    or in the process of attempting lock.
- *		    (WAITING_BIAS)
- *		Note: writer can attempt to steal lock for this count by adding
- *		ACTIVE_WRITE_BIAS in cmpxchg and checking the old count
+ * When the RWSEM_WRITER_LOCKED bit in count is set, the lock is owned
+ * by a writer.
  *
- * 0xfffe0001	(1) 1 writer active, or attempting lock. Waiters on queue.
- *		    (ACTIVE_WRITE_BIAS + WAITING_BIAS)
- *
- * Note: Readers attempt to lock by adding ACTIVE_BIAS in down_read and checking
- *	 the count becomes more than 0 for successful lock acquisition,
- *	 i.e. the case where there are only readers or nobody has lock.
- *	 (1st and 2nd case above).
- *
- *	 Writers attempt to lock by adding ACTIVE_WRITE_BIAS in down_write and
- *	 checking the count becomes ACTIVE_WRITE_BIAS for successful lock
- *	 acquisition (i.e. nobody else has lock or attempts lock).  If
- *	 unsuccessful, in rwsem_down_write_failed, we'll check to see if there
- *	 are only waiters but none active (5th case above), and attempt to
- *	 steal the lock.
+ * The lock is owned by readers when
+ * (1) the RWSEM_WRITER_LOCKED isn't set in count,
+ * (2) some of the reader bits are set in count, and
+ * (3) the owner field has RWSEM_READ_OWNED bit set.
  *
+ * Having some reader bits set is not enough to guarantee a readers owned
+ * lock as the readers may be in the process of backing out from the count
+ * and a writer has just released the lock. So another writer may steal
+ * the lock immediately after that.
  */
 
 /*
@@ -113,9 +83,8 @@ enum rwsem_wake_type {
 
 /*
  * handle the lock release when processes blocked on it that can now run
- * - if we come here from up_xxxx(), then:
- *   - the 'active part' of count (&0x0000ffff) reached 0 (but may have changed)
- *   - the 'waiting part' of count (&0xffff0000) is -ve (and will still be so)
+ * - if we come here from up_xxxx(), then the RWSEM_FLAG_WAITERS bit must
+ *   have been set.
  * - there must be someone on the queue
  * - the wait_lock must be held by the caller
  * - tasks are marked for wakeup, the caller must later invoke wake_up_q()
@@ -160,22 +129,11 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 	 * so we can bail out early if a writer stole the lock.
 	 */
 	if (wake_type != RWSEM_WAKE_READ_OWNED) {
-		adjustment = RWSEM_ACTIVE_READ_BIAS;
- try_reader_grant:
+		adjustment = RWSEM_READER_BIAS;
 		oldcount = atomic_long_fetch_add(adjustment, &sem->count);
-		if (unlikely(oldcount < RWSEM_WAITING_BIAS)) {
-			/*
-			 * If the count is still less than RWSEM_WAITING_BIAS
-			 * after removing the adjustment, it is assumed that
-			 * a writer has stolen the lock. We have to undo our
-			 * reader grant.
-			 */
-			if (atomic_long_add_return(-adjustment, &sem->count) <
-			    RWSEM_WAITING_BIAS)
-				return;
-
-			/* Last active locker left. Retry waking readers. */
-			goto try_reader_grant;
+		if (unlikely(oldcount & RWSEM_WRITER_MASK)) {
+			atomic_long_sub(adjustment, &sem->count);
+			return;
 		}
 		/*
 		 * Set it to reader-owned to give spinners an early
@@ -209,11 +167,11 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 	}
 	list_cut_before(&wlist, &sem->wait_list, &waiter->list);
 
-	adjustment = woken * RWSEM_ACTIVE_READ_BIAS - adjustment;
+	adjustment = woken * RWSEM_READER_BIAS - adjustment;
 	lockevent_cond_inc(rwsem_wake_reader, woken);
 	if (list_empty(&sem->wait_list)) {
 		/* hit end of list above */
-		adjustment -= RWSEM_WAITING_BIAS;
+		adjustment -= RWSEM_FLAG_WAITERS;
 	}
 
 	if (adjustment)
@@ -248,22 +206,15 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
  */
 static inline bool rwsem_try_write_lock(long count, struct rw_semaphore *sem)
 {
-	/*
-	 * Avoid trying to acquire write lock if count isn't RWSEM_WAITING_BIAS.
-	 */
-	if (count != RWSEM_WAITING_BIAS)
+	long new;
+
+	if (count & RWSEM_LOCK_MASK)
 		return false;
 
-	/*
-	 * Acquire the lock by trying to set it to ACTIVE_WRITE_BIAS. If there
-	 * are other tasks on the wait list, we need to add on WAITING_BIAS.
-	 */
-	count = list_is_singular(&sem->wait_list) ?
-			RWSEM_ACTIVE_WRITE_BIAS :
-			RWSEM_ACTIVE_WRITE_BIAS + RWSEM_WAITING_BIAS;
+	new = count + RWSEM_WRITER_LOCKED -
+	     (list_is_singular(&sem->wait_list) ? RWSEM_FLAG_WAITERS : 0);
 
-	if (atomic_long_cmpxchg_acquire(&sem->count, RWSEM_WAITING_BIAS, count)
-							== RWSEM_WAITING_BIAS) {
+	if (atomic_long_try_cmpxchg_acquire(&sem->count, &count, new)) {
 		rwsem_set_owner(sem);
 		return true;
 	}
@@ -279,9 +230,9 @@ static inline bool rwsem_try_write_lock_unqueued(struct rw_semaphore *sem)
 {
 	long count = atomic_long_read(&sem->count);
 
-	while (!count || count == RWSEM_WAITING_BIAS) {
+	while (!(count & RWSEM_LOCK_MASK)) {
 		if (atomic_long_try_cmpxchg_acquire(&sem->count, &count,
-					count + RWSEM_ACTIVE_WRITE_BIAS)) {
+					count + RWSEM_WRITER_LOCKED)) {
 			rwsem_set_owner(sem);
 			lockevent_inc(rwsem_opt_wlock);
 			return true;
@@ -424,7 +375,7 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 static inline struct rw_semaphore __sched *
 __rwsem_down_read_failed_common(struct rw_semaphore *sem, int state)
 {
-	long count, adjustment = -RWSEM_ACTIVE_READ_BIAS;
+	long count, adjustment = -RWSEM_READER_BIAS;
 	struct rwsem_waiter waiter;
 	DEFINE_WAKE_Q(wake_q);
 
@@ -436,16 +387,16 @@ __rwsem_down_read_failed_common(struct rw_semaphore *sem, int state)
 		/*
 		 * In case the wait queue is empty and the lock isn't owned
 		 * by a writer, this reader can exit the slowpath and return
-		 * immediately as its RWSEM_ACTIVE_READ_BIAS has already
-		 * been set in the count.
+		 * immediately as its RWSEM_READER_BIAS has already been
+		 * set in the count.
 		 */
-		if (atomic_long_read(&sem->count) >= 0) {
+		if (!(atomic_long_read(&sem->count) & RWSEM_WRITER_MASK)) {
 			raw_spin_unlock_irq(&sem->wait_lock);
 			rwsem_set_reader_owned(sem);
 			lockevent_inc(rwsem_rlock_fast);
 			return sem;
 		}
-		adjustment += RWSEM_WAITING_BIAS;
+		adjustment += RWSEM_FLAG_WAITERS;
 	}
 	list_add_tail(&waiter.list, &sem->wait_list);
 
@@ -458,9 +409,8 @@ __rwsem_down_read_failed_common(struct rw_semaphore *sem, int state)
 	 * If there are no writers and we are first in the queue,
 	 * wake our own waiter to join the existing active readers !
 	 */
-	if (count == RWSEM_WAITING_BIAS ||
-	    (count > RWSEM_WAITING_BIAS &&
-	     adjustment != -RWSEM_ACTIVE_READ_BIAS))
+	if (!(count & RWSEM_LOCK_MASK) ||
+	   (!(count & RWSEM_WRITER_MASK) && (adjustment & RWSEM_FLAG_WAITERS)))
 		__rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
 
 	raw_spin_unlock_irq(&sem->wait_lock);
@@ -488,7 +438,7 @@ __rwsem_down_read_failed_common(struct rw_semaphore *sem, int state)
 out_nolock:
 	list_del(&waiter.list);
 	if (list_empty(&sem->wait_list))
-		atomic_long_add(-RWSEM_WAITING_BIAS, &sem->count);
+		atomic_long_andnot(RWSEM_FLAG_WAITERS, &sem->count);
 	raw_spin_unlock_irq(&sem->wait_lock);
 	__set_current_state(TASK_RUNNING);
 	lockevent_inc(rwsem_rlock_fail);
@@ -521,9 +471,6 @@ __rwsem_down_write_failed_common(struct rw_semaphore *sem, int state)
 	struct rw_semaphore *ret = sem;
 	DEFINE_WAKE_Q(wake_q);
 
-	/* undo write bias from down_write operation, stop active locking */
-	count = atomic_long_sub_return(RWSEM_ACTIVE_WRITE_BIAS, &sem->count);
-
 	/* do optimistic spinning and steal lock if possible */
 	if (rwsem_optimistic_spin(sem))
 		return sem;
@@ -543,16 +490,18 @@ __rwsem_down_write_failed_common(struct rw_semaphore *sem, int state)
 
 	list_add_tail(&waiter.list, &sem->wait_list);
 
-	/* we're now waiting on the lock, but no longer actively locking */
+	/* we're now waiting on the lock */
 	if (waiting) {
 		count = atomic_long_read(&sem->count);
 
 		/*
 		 * If there were already threads queued before us and there are
-		 * no active writers, the lock must be read owned; so we try to
-		 * wake any read locks that were queued ahead of us.
+		 * no active writers and some readers, the lock must be read
+		 * owned; so we try to  any read locks that were queued ahead
+		 * of us.
 		 */
-		if (count > RWSEM_WAITING_BIAS) {
+		if (!(count & RWSEM_WRITER_MASK) &&
+		     (count & RWSEM_READER_MASK)) {
 			__rwsem_mark_wake(sem, RWSEM_WAKE_READERS, &wake_q);
 			/*
 			 * The wakeup is normally called _after_ the wait_lock
@@ -569,8 +518,9 @@ __rwsem_down_write_failed_common(struct rw_semaphore *sem, int state)
 			wake_q_init(&wake_q);
 		}
 
-	} else
-		count = atomic_long_add_return(RWSEM_WAITING_BIAS, &sem->count);
+	} else {
+		count = atomic_long_add_return(RWSEM_FLAG_WAITERS, &sem->count);
+	}
 
 	/* wait until we successfully acquire the lock */
 	set_current_state(state);
@@ -587,7 +537,8 @@ __rwsem_down_write_failed_common(struct rw_semaphore *sem, int state)
 			schedule();
 			lockevent_inc(rwsem_sleep_writer);
 			set_current_state(state);
-		} while ((count = atomic_long_read(&sem->count)) & RWSEM_ACTIVE_MASK);
+			count = atomic_long_read(&sem->count);
+		} while (count & RWSEM_LOCK_MASK);
 
 		raw_spin_lock_irq(&sem->wait_lock);
 	}
@@ -603,7 +554,7 @@ out_nolock:
 	raw_spin_lock_irq(&sem->wait_lock);
 	list_del(&waiter.list);
 	if (list_empty(&sem->wait_list))
-		atomic_long_add(-RWSEM_WAITING_BIAS, &sem->count);
+		atomic_long_andnot(RWSEM_FLAG_WAITERS, &sem->count);
 	else
 		__rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
 	raw_spin_unlock_irq(&sem->wait_lock);
diff --git a/kernel/locking/rwsem.h b/kernel/locking/rwsem.h
index eb9c8534299b..499a9b2bda82 100644
--- a/kernel/locking/rwsem.h
+++ b/kernel/locking/rwsem.h
@@ -42,24 +42,24 @@
 #endif
 
 /*
- * R/W semaphores originally for PPC using the stuff in lib/rwsem.c.
- * Adapted largely from include/asm-i386/rwsem.h
- * by Paul Mackerras <paulus@samba.org>.
- */
-
-/*
- * the semaphore definition
+ * The definition of the atomic counter in the semaphore:
+ *
+ * Bit  0   - writer locked bit
+ * Bit  1   - waiters present bit
+ * Bits 2-7 - reserved
+ * Bits 8-X - 24-bit (32-bit) or 56-bit reader count
+ *
+ * atomic_long_fetch_add() is used to obtain reader lock, whereas
+ * atomic_long_cmpxchg() will be used to obtain writer lock.
  */
-#ifdef CONFIG_64BIT
-# define RWSEM_ACTIVE_MASK		0xffffffffL
-#else
-# define RWSEM_ACTIVE_MASK		0x0000ffffL
-#endif
-
-#define RWSEM_ACTIVE_BIAS		0x00000001L
-#define RWSEM_WAITING_BIAS		(-RWSEM_ACTIVE_MASK-1)
-#define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
-#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
+#define RWSEM_WRITER_LOCKED	(1UL << 0)
+#define RWSEM_FLAG_WAITERS	(1UL << 1)
+#define RWSEM_READER_SHIFT	8
+#define RWSEM_READER_BIAS	(1UL << RWSEM_READER_SHIFT)
+#define RWSEM_READER_MASK	(~(RWSEM_READER_BIAS - 1))
+#define RWSEM_WRITER_MASK	RWSEM_WRITER_LOCKED
+#define RWSEM_LOCK_MASK		(RWSEM_WRITER_MASK|RWSEM_READER_MASK)
+#define RWSEM_READ_FAILED_MASK	(RWSEM_WRITER_MASK|RWSEM_FLAG_WAITERS)
 
 /*
  * All writes to owner are protected by WRITE_ONCE() to make sure that
@@ -151,7 +151,8 @@ extern struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem);
  */
 static inline void __down_read(struct rw_semaphore *sem)
 {
-	if (unlikely(atomic_long_inc_return_acquire(&sem->count) <= 0)) {
+	if (unlikely(atomic_long_fetch_add_acquire(RWSEM_READER_BIAS,
+			&sem->count) & RWSEM_READ_FAILED_MASK)) {
 		rwsem_down_read_failed(sem);
 		DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner &
 					RWSEM_READER_OWNED), sem);
@@ -162,7 +163,8 @@ static inline void __down_read(struct rw_semaphore *sem)
 
 static inline int __down_read_killable(struct rw_semaphore *sem)
 {
-	if (unlikely(atomic_long_inc_return_acquire(&sem->count) <= 0)) {
+	if (unlikely(atomic_long_fetch_add_acquire(RWSEM_READER_BIAS,
+			&sem->count) & RWSEM_READ_FAILED_MASK)) {
 		if (IS_ERR(rwsem_down_read_failed_killable(sem)))
 			return -EINTR;
 		DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner &
@@ -183,11 +185,11 @@ static inline int __down_read_trylock(struct rw_semaphore *sem)
 	lockevent_inc(rwsem_rtrylock);
 	do {
 		if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
-					tmp + RWSEM_ACTIVE_READ_BIAS)) {
+					tmp + RWSEM_READER_BIAS)) {
 			rwsem_set_reader_owned(sem);
 			return 1;
 		}
-	} while (tmp >= 0);
+	} while (!(tmp & RWSEM_READ_FAILED_MASK));
 	return 0;
 }
 
@@ -196,22 +198,16 @@ static inline int __down_read_trylock(struct rw_semaphore *sem)
  */
 static inline void __down_write(struct rw_semaphore *sem)
 {
-	long tmp;
-
-	tmp = atomic_long_add_return_acquire(RWSEM_ACTIVE_WRITE_BIAS,
-					     &sem->count);
-	if (unlikely(tmp != RWSEM_ACTIVE_WRITE_BIAS))
+	if (unlikely(atomic_long_cmpxchg_acquire(&sem->count, 0,
+						 RWSEM_WRITER_LOCKED)))
 		rwsem_down_write_failed(sem);
 	rwsem_set_owner(sem);
 }
 
 static inline int __down_write_killable(struct rw_semaphore *sem)
 {
-	long tmp;
-
-	tmp = atomic_long_add_return_acquire(RWSEM_ACTIVE_WRITE_BIAS,
-					     &sem->count);
-	if (unlikely(tmp != RWSEM_ACTIVE_WRITE_BIAS))
+	if (unlikely(atomic_long_cmpxchg_acquire(&sem->count, 0,
+						 RWSEM_WRITER_LOCKED)))
 		if (IS_ERR(rwsem_down_write_failed_killable(sem)))
 			return -EINTR;
 	rwsem_set_owner(sem);
@@ -224,7 +220,7 @@ static inline int __down_write_trylock(struct rw_semaphore *sem)
 
 	lockevent_inc(rwsem_wtrylock);
 	tmp = atomic_long_cmpxchg_acquire(&sem->count, RWSEM_UNLOCKED_VALUE,
-		      RWSEM_ACTIVE_WRITE_BIAS);
+					  RWSEM_WRITER_LOCKED);
 	if (tmp == RWSEM_UNLOCKED_VALUE) {
 		rwsem_set_owner(sem);
 		return true;
@@ -242,8 +238,9 @@ static inline void __up_read(struct rw_semaphore *sem)
 	DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner & RWSEM_READER_OWNED),
 				sem);
 	rwsem_clear_reader_owned(sem);
-	tmp = atomic_long_dec_return_release(&sem->count);
-	if (unlikely(tmp < -1 && (tmp & RWSEM_ACTIVE_MASK) == 0))
+	tmp = atomic_long_add_return_release(-RWSEM_READER_BIAS, &sem->count);
+	if (unlikely((tmp & (RWSEM_LOCK_MASK|RWSEM_FLAG_WAITERS))
+			== RWSEM_FLAG_WAITERS))
 		rwsem_wake(sem);
 }
 
@@ -254,8 +251,8 @@ static inline void __up_write(struct rw_semaphore *sem)
 {
 	DEBUG_RWSEMS_WARN_ON(sem->owner != current, sem);
 	rwsem_clear_owner(sem);
-	if (unlikely(atomic_long_sub_return_release(RWSEM_ACTIVE_WRITE_BIAS,
-						    &sem->count) < 0))
+	if (unlikely(atomic_long_fetch_add_release(-RWSEM_WRITER_LOCKED,
+			&sem->count) & RWSEM_FLAG_WAITERS))
 		rwsem_wake(sem);
 }
 
@@ -274,8 +271,9 @@ static inline void __downgrade_write(struct rw_semaphore *sem)
 	 * write side. As such, rely on RELEASE semantics.
 	 */
 	DEBUG_RWSEMS_WARN_ON(sem->owner != current, sem);
-	tmp = atomic_long_add_return_release(-RWSEM_WAITING_BIAS, &sem->count);
+	tmp = atomic_long_fetch_add_release(
+		-RWSEM_WRITER_LOCKED+RWSEM_READER_BIAS, &sem->count);
 	rwsem_set_reader_owned(sem);
-	if (tmp < 0)
+	if (tmp & RWSEM_FLAG_WAITERS)
 		rwsem_downgrade_wake(sem);
 }
