Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFA4C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B456A2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Qc9YcflK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbfFQObt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:31:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54731 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfFQObs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:31:48 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HEVJSf3457303
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 07:31:19 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HEVJSf3457303
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560781880;
        bh=RYRKdUDCnZTQugvPYiQdsU0tnfL+dYxWxZc61NJSO74=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Qc9YcflKdmcOyW0iorih56FJ03R0iRm8xkRR/qT0dJOkC60jajb2au87yADNPmfQL
         Svm3P70Ojo6uYmYPT8lpNt+YcNdY+XCBRyVoyG5vSi+FxYkraRXHT3XRRv9/A4qQTq
         lcA7wujj1I7xxSquhALAVinvmy5dOlAfrV3v2/aa53kxv1KISEqLEXvHZZxnln2LZZ
         M0MUlA574UPPhd/14Ea3xWDa6YYdWPYipG052rqNAPfkWvfXDaJpgVvIf0lXBt2UpK
         5FhYZZVa8V6o4JtcbqRgj7DwhUzet4U7nZwF18CpGYHj9LuM9y1SsDIWHlRPNPA+aR
         EVEw4ecFKQCag==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HEVJF13457298;
        Mon, 17 Jun 2019 07:31:19 -0700
Date:   Mon, 17 Jun 2019 07:31:19 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-cf69482d62d996d3ce840eeead8e160de281ac6c@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com,
        dave@stgolabs.net, peterz@infradead.org, will.deacon@arm.com,
        longman@redhat.com, torvalds@linux-foundation.org,
        mingo@kernel.org, huang.ying.caritas@gmail.com, bp@alien8.de,
        tim.c.chen@linux.intel.com
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
          peterz@infradead.org, dave@stgolabs.net, will.deacon@arm.com,
          longman@redhat.com, tim.c.chen@linux.intel.com,
          torvalds@linux-foundation.org, bp@alien8.de,
          huang.ying.caritas@gmail.com, mingo@kernel.org
In-Reply-To: <20190520205918.22251-13-longman@redhat.com>
References: <20190520205918.22251-13-longman@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/rwsem: Enable readers spinning on writer
Git-Commit-ID: cf69482d62d996d3ce840eeead8e160de281ac6c
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

Commit-ID:  cf69482d62d996d3ce840eeead8e160de281ac6c
Gitweb:     https://git.kernel.org/tip/cf69482d62d996d3ce840eeead8e160de281ac6c
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Mon, 20 May 2019 16:59:11 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 17 Jun 2019 12:28:05 +0200

locking/rwsem: Enable readers spinning on writer

This patch enables readers to optimistically spin on a
rwsem when it is owned by a writer instead of going to sleep
directly.  The rwsem_can_spin_on_owner() function is extracted
out of rwsem_optimistic_spin() and is called directly by
rwsem_down_read_slowpath() and rwsem_down_write_slowpath().

With a locking microbenchmark running on 5.1 based kernel, the total
locking rates (in kops/s) on a 8-socket IvyBrige-EX system with equal
numbers of readers and writers before and after the patch were as
follows:

   # of Threads  Pre-patch    Post-patch
   ------------  ---------    ----------
        4          1,674        1,684
        8          1,062        1,074
       16            924          900
       32            300          458
       64            195          208
      128            164          168
      240            149          143

The performance change wasn't significant in this case, but this change
is required by a follow-on patch.

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
Link: https://lkml.kernel.org/r/20190520205918.22251-13-longman@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lock_events_list.h |  1 +
 kernel/locking/rwsem.c            | 86 +++++++++++++++++++++++++++++++++------
 2 files changed, 75 insertions(+), 12 deletions(-)

diff --git a/kernel/locking/lock_events_list.h b/kernel/locking/lock_events_list.h
index 634b47fd8b5e..ca954e4e00e4 100644
--- a/kernel/locking/lock_events_list.h
+++ b/kernel/locking/lock_events_list.h
@@ -56,6 +56,7 @@ LOCK_EVENT(rwsem_sleep_reader)	/* # of reader sleeps			*/
 LOCK_EVENT(rwsem_sleep_writer)	/* # of writer sleeps			*/
 LOCK_EVENT(rwsem_wake_reader)	/* # of reader wakeups			*/
 LOCK_EVENT(rwsem_wake_writer)	/* # of writer wakeups			*/
+LOCK_EVENT(rwsem_opt_rlock)	/* # of read locks opt-spin acquired	*/
 LOCK_EVENT(rwsem_opt_wlock)	/* # of write locks opt-spin acquired	*/
 LOCK_EVENT(rwsem_opt_fail)	/* # of failed opt-spinnings		*/
 LOCK_EVENT(rwsem_rlock)		/* # of read locks acquired		*/
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 180455b6b0d4..985a03ad3f8c 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -457,6 +457,30 @@ static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
 }
 
 #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
+/*
+ * Try to acquire read lock before the reader is put on wait queue.
+ * Lock acquisition isn't allowed if the rwsem is locked or a writer handoff
+ * is ongoing.
+ */
+static inline bool rwsem_try_read_lock_unqueued(struct rw_semaphore *sem)
+{
+	long count = atomic_long_read(&sem->count);
+
+	if (count & (RWSEM_WRITER_MASK | RWSEM_FLAG_HANDOFF))
+		return false;
+
+	count = atomic_long_fetch_add_acquire(RWSEM_READER_BIAS, &sem->count);
+	if (!(count & (RWSEM_WRITER_MASK | RWSEM_FLAG_HANDOFF))) {
+		rwsem_set_reader_owned(sem);
+		lockevent_inc(rwsem_opt_rlock);
+		return true;
+	}
+
+	/* Back out the change */
+	atomic_long_add(-RWSEM_READER_BIAS, &sem->count);
+	return false;
+}
+
 /*
  * Try to acquire write lock before the writer has been put on wait queue.
  */
@@ -491,9 +515,12 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 
 	BUILD_BUG_ON(is_rwsem_owner_spinnable(RWSEM_OWNER_UNKNOWN));
 
-	if (need_resched())
+	if (need_resched()) {
+		lockevent_inc(rwsem_opt_fail);
 		return false;
+	}
 
+	preempt_disable();
 	rcu_read_lock();
 	owner = READ_ONCE(sem->owner);
 	if (owner) {
@@ -501,6 +528,9 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 		      owner_on_cpu(owner);
 	}
 	rcu_read_unlock();
+	preempt_enable();
+
+	lockevent_cond_inc(rwsem_opt_fail, !ret);
 	return ret;
 }
 
@@ -578,7 +608,7 @@ static noinline enum owner_state rwsem_spin_on_owner(struct rw_semaphore *sem)
 	return state;
 }
 
-static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
+static bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock)
 {
 	bool taken = false;
 	int prev_owner_state = OWNER_NULL;
@@ -586,9 +616,6 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 	preempt_disable();
 
 	/* sem->wait_lock should not be held when doing optimistic spinning */
-	if (!rwsem_can_spin_on_owner(sem))
-		goto done;
-
 	if (!osq_lock(&sem->osq))
 		goto done;
 
@@ -608,10 +635,11 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 		/*
 		 * Try to acquire the lock
 		 */
-		if (rwsem_try_write_lock_unqueued(sem)) {
-			taken = true;
+		taken = wlock ? rwsem_try_write_lock_unqueued(sem)
+			      : rwsem_try_read_lock_unqueued(sem);
+
+		if (taken)
 			break;
-		}
 
 		/*
 		 * An RT task cannot do optimistic spinning if it cannot
@@ -668,7 +696,12 @@ done:
 	return taken;
 }
 #else
-static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
+static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
+{
+	return false;
+}
+
+static inline bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock)
 {
 	return false;
 }
@@ -684,6 +717,31 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state)
 	struct rwsem_waiter waiter;
 	DEFINE_WAKE_Q(wake_q);
 
+	if (!rwsem_can_spin_on_owner(sem))
+		goto queue;
+
+	/*
+	 * Undo read bias from down_read() and do optimistic spinning.
+	 */
+	atomic_long_add(-RWSEM_READER_BIAS, &sem->count);
+	adjustment = 0;
+	if (rwsem_optimistic_spin(sem, false)) {
+		/*
+		 * Wake up other readers in the wait list if the front
+		 * waiter is a reader.
+		 */
+		if ((atomic_long_read(&sem->count) & RWSEM_FLAG_WAITERS)) {
+			raw_spin_lock_irq(&sem->wait_lock);
+			if (!list_empty(&sem->wait_list))
+				rwsem_mark_wake(sem, RWSEM_WAKE_READ_OWNED,
+						&wake_q);
+			raw_spin_unlock_irq(&sem->wait_lock);
+			wake_up_q(&wake_q);
+		}
+		return sem;
+	}
+
+queue:
 	waiter.task = current;
 	waiter.type = RWSEM_WAITING_FOR_READ;
 	waiter.timeout = jiffies + RWSEM_WAIT_TIMEOUT;
@@ -696,7 +754,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state)
 		 * exit the slowpath and return immediately as its
 		 * RWSEM_READER_BIAS has already been set in the count.
 		 */
-		if (!(atomic_long_read(&sem->count) &
+		if (adjustment && !(atomic_long_read(&sem->count) &
 		     (RWSEM_WRITER_MASK | RWSEM_FLAG_HANDOFF))) {
 			raw_spin_unlock_irq(&sem->wait_lock);
 			rwsem_set_reader_owned(sem);
@@ -708,7 +766,10 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state)
 	list_add_tail(&waiter.list, &sem->wait_list);
 
 	/* we're now waiting on the lock, but no longer actively locking */
-	count = atomic_long_add_return(adjustment, &sem->count);
+	if (adjustment)
+		count = atomic_long_add_return(adjustment, &sem->count);
+	else
+		count = atomic_long_read(&sem->count);
 
 	/*
 	 * If there are no active locks, wake the front queued process(es).
@@ -767,7 +828,8 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 	DEFINE_WAKE_Q(wake_q);
 
 	/* do optimistic spinning and steal lock if possible */
-	if (rwsem_optimistic_spin(sem))
+	if (rwsem_can_spin_on_owner(sem) &&
+	    rwsem_optimistic_spin(sem, true))
 		return sem;
 
 	/*
