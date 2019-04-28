Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F015C43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 15:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F8E42067D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 15:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfD1P7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 11:59:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59156 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726866AbfD1P7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 11:59:08 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 10D6F3086217;
        Sun, 28 Apr 2019 15:59:07 +0000 (UTC)
Received: from llong.com (ovpn-120-22.rdu2.redhat.com [10.10.120.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC3EB620DF;
        Sun, 28 Apr 2019 15:59:02 +0000 (UTC)
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
Subject: [PATCH-tip v6 13/20] locking/rwsem: Enable readers spinning on writer
Date:   Sun, 28 Apr 2019 11:57:48 -0400
Message-Id: <20190428155755.14267-14-longman@redhat.com>
In-Reply-To: <20190428155755.14267-1-longman@redhat.com>
References: <20190428155755.14267-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Sun, 28 Apr 2019 15:59:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables readers to optimistically spin on a
rwsem when it is owned by a writer instead of going to sleep
directly.  The rwsem_can_spin_on_owner() function is extracted
out of rwsem_optimistic_spin() and is called directly by
__rwsem_down_read_failed_common() and __rwsem_down_write_failed_common().

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
---
 kernel/locking/lock_events_list.h |  1 +
 kernel/locking/rwsem.c            | 86 ++++++++++++++++++++++++++-----
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
index 37fd8400720b..38790546b951 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -452,6 +452,30 @@ static inline bool rwsem_try_write_lock(long count, struct rw_semaphore *sem,
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
@@ -486,9 +510,12 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 
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
@@ -496,6 +523,9 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 		      owner_on_cpu(owner);
 	}
 	rcu_read_unlock();
+	preempt_enable();
+
+	lockevent_cond_inc(rwsem_opt_fail, !ret);
 	return ret;
 }
 
@@ -573,7 +603,7 @@ static noinline enum owner_state rwsem_spin_on_owner(struct rw_semaphore *sem)
 	return state;
 }
 
-static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
+static bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock)
 {
 	bool taken = false;
 	int prev_owner_state = OWNER_NULL;
@@ -581,9 +611,6 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 	preempt_disable();
 
 	/* sem->wait_lock should not be held when doing optimistic spinning */
-	if (!rwsem_can_spin_on_owner(sem))
-		goto done;
-
 	if (!osq_lock(&sem->osq))
 		goto done;
 
@@ -603,10 +630,11 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
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
@@ -663,7 +691,12 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
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
@@ -679,6 +712,31 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state)
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
+				__rwsem_mark_wake(sem, RWSEM_WAKE_READ_OWNED,
+						  &wake_q);
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
@@ -691,7 +749,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state)
 		 * exit the slowpath and return immediately as its
 		 * RWSEM_READER_BIAS has already been set in the count.
 		 */
-		if (!(atomic_long_read(&sem->count) &
+		if (adjustment && !(atomic_long_read(&sem->count) &
 		     (RWSEM_WRITER_MASK | RWSEM_FLAG_HANDOFF))) {
 			raw_spin_unlock_irq(&sem->wait_lock);
 			rwsem_set_reader_owned(sem);
@@ -703,7 +761,10 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state)
 	list_add_tail(&waiter.list, &sem->wait_list);
 
 	/* we're now waiting on the lock, but no longer actively locking */
-	count = atomic_long_add_return(adjustment, &sem->count);
+	if (adjustment)
+		count = atomic_long_add_return(adjustment, &sem->count);
+	else
+		count = atomic_long_read(&sem->count);
 
 	/*
 	 * If there are no active locks, wake the front queued process(es).
@@ -762,7 +823,8 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 	DEFINE_WAKE_Q(wake_q);
 
 	/* do optimistic spinning and steal lock if possible */
-	if (rwsem_optimistic_spin(sem))
+	if (rwsem_can_spin_on_owner(sem) &&
+	    rwsem_optimistic_spin(sem, true))
 		return sem;
 
 	/*
-- 
2.18.1

