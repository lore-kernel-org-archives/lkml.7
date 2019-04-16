Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B997CC282DC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 812B9206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbfDPKDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:03:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33139 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfDPKDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 06:03:55 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3GA16jT3396557
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 16 Apr 2019 03:01:06 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3GA161w3396554;
        Tue, 16 Apr 2019 03:01:06 -0700
Date:   Tue, 16 Apr 2019 03:01:06 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-eecec78f777742903ec9167490c625661284155d@git.kernel.org>
Cc:     will.deacon@arm.com, arnd@arndb.de, longman@redhat.com,
        dave@stgolabs.net, mingo@kernel.org, tim.c.chen@linux.intel.com,
        hpa@zytor.com, bp@alien8.de, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        paulmck@linux.vnet.ibm.com, dbueso@suse.de, a.p.zijlstra@chello.nl,
        peterz@infradead.org, akpm@linux-foundation.org
Reply-To: peterz@infradead.org, akpm@linux-foundation.org,
          a.p.zijlstra@chello.nl, tglx@linutronix.de,
          paulmck@linux.vnet.ibm.com, dbueso@suse.de,
          linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
          bp@alien8.de, hpa@zytor.com, mingo@kernel.org,
          tim.c.chen@linux.intel.com, longman@redhat.com,
          dave@stgolabs.net, arnd@arndb.de, will.deacon@arm.com
In-Reply-To: <20190404174320.22416-2-longman@redhat.com>
References: <20190404174320.22416-2-longman@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/rwsem: Relocate rwsem_down_read_failed()
Git-Commit-ID: eecec78f777742903ec9167490c625661284155d
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

Commit-ID:  eecec78f777742903ec9167490c625661284155d
Gitweb:     https://git.kernel.org/tip/eecec78f777742903ec9167490c625661284155d
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Thu, 4 Apr 2019 13:43:10 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 10 Apr 2019 10:55:59 +0200

locking/rwsem: Relocate rwsem_down_read_failed()

The rwsem_down_read_failed*() functions were relocated from above the
optimistic spinning section to below that section. This enables the
reader functions to use optimisitic spinning in future patches. There
is no code change.

Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Acked-by: Will Deacon <will.deacon@arm.com>
Acked-by: Davidlohr Bueso <dbueso@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Link: http://lkml.kernel.org/r/20190404174320.22416-2-longman@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/rwsem-xadd.c | 172 ++++++++++++++++++++++----------------------
 1 file changed, 86 insertions(+), 86 deletions(-)

diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index fbe96341beee..0d518b52ade4 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -224,92 +224,6 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 		atomic_long_add(adjustment, &sem->count);
 }
 
-/*
- * Wait for the read lock to be granted
- */
-static inline struct rw_semaphore __sched *
-__rwsem_down_read_failed_common(struct rw_semaphore *sem, int state)
-{
-	long count, adjustment = -RWSEM_ACTIVE_READ_BIAS;
-	struct rwsem_waiter waiter;
-	DEFINE_WAKE_Q(wake_q);
-
-	waiter.task = current;
-	waiter.type = RWSEM_WAITING_FOR_READ;
-
-	raw_spin_lock_irq(&sem->wait_lock);
-	if (list_empty(&sem->wait_list)) {
-		/*
-		 * In case the wait queue is empty and the lock isn't owned
-		 * by a writer, this reader can exit the slowpath and return
-		 * immediately as its RWSEM_ACTIVE_READ_BIAS has already
-		 * been set in the count.
-		 */
-		if (atomic_long_read(&sem->count) >= 0) {
-			raw_spin_unlock_irq(&sem->wait_lock);
-			return sem;
-		}
-		adjustment += RWSEM_WAITING_BIAS;
-	}
-	list_add_tail(&waiter.list, &sem->wait_list);
-
-	/* we're now waiting on the lock, but no longer actively locking */
-	count = atomic_long_add_return(adjustment, &sem->count);
-
-	/*
-	 * If there are no active locks, wake the front queued process(es).
-	 *
-	 * If there are no writers and we are first in the queue,
-	 * wake our own waiter to join the existing active readers !
-	 */
-	if (count == RWSEM_WAITING_BIAS ||
-	    (count > RWSEM_WAITING_BIAS &&
-	     adjustment != -RWSEM_ACTIVE_READ_BIAS))
-		__rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
-
-	raw_spin_unlock_irq(&sem->wait_lock);
-	wake_up_q(&wake_q);
-
-	/* wait to be given the lock */
-	while (true) {
-		set_current_state(state);
-		if (!waiter.task)
-			break;
-		if (signal_pending_state(state, current)) {
-			raw_spin_lock_irq(&sem->wait_lock);
-			if (waiter.task)
-				goto out_nolock;
-			raw_spin_unlock_irq(&sem->wait_lock);
-			break;
-		}
-		schedule();
-	}
-
-	__set_current_state(TASK_RUNNING);
-	return sem;
-out_nolock:
-	list_del(&waiter.list);
-	if (list_empty(&sem->wait_list))
-		atomic_long_add(-RWSEM_WAITING_BIAS, &sem->count);
-	raw_spin_unlock_irq(&sem->wait_lock);
-	__set_current_state(TASK_RUNNING);
-	return ERR_PTR(-EINTR);
-}
-
-__visible struct rw_semaphore * __sched
-rwsem_down_read_failed(struct rw_semaphore *sem)
-{
-	return __rwsem_down_read_failed_common(sem, TASK_UNINTERRUPTIBLE);
-}
-EXPORT_SYMBOL(rwsem_down_read_failed);
-
-__visible struct rw_semaphore * __sched
-rwsem_down_read_failed_killable(struct rw_semaphore *sem)
-{
-	return __rwsem_down_read_failed_common(sem, TASK_KILLABLE);
-}
-EXPORT_SYMBOL(rwsem_down_read_failed_killable);
-
 /*
  * This function must be called with the sem->wait_lock held to prevent
  * race conditions between checking the rwsem wait list and setting the
@@ -504,6 +418,92 @@ static inline bool rwsem_has_spinner(struct rw_semaphore *sem)
 }
 #endif
 
+/*
+ * Wait for the read lock to be granted
+ */
+static inline struct rw_semaphore __sched *
+__rwsem_down_read_failed_common(struct rw_semaphore *sem, int state)
+{
+	long count, adjustment = -RWSEM_ACTIVE_READ_BIAS;
+	struct rwsem_waiter waiter;
+	DEFINE_WAKE_Q(wake_q);
+
+	waiter.task = current;
+	waiter.type = RWSEM_WAITING_FOR_READ;
+
+	raw_spin_lock_irq(&sem->wait_lock);
+	if (list_empty(&sem->wait_list)) {
+		/*
+		 * In case the wait queue is empty and the lock isn't owned
+		 * by a writer, this reader can exit the slowpath and return
+		 * immediately as its RWSEM_ACTIVE_READ_BIAS has already
+		 * been set in the count.
+		 */
+		if (atomic_long_read(&sem->count) >= 0) {
+			raw_spin_unlock_irq(&sem->wait_lock);
+			return sem;
+		}
+		adjustment += RWSEM_WAITING_BIAS;
+	}
+	list_add_tail(&waiter.list, &sem->wait_list);
+
+	/* we're now waiting on the lock, but no longer actively locking */
+	count = atomic_long_add_return(adjustment, &sem->count);
+
+	/*
+	 * If there are no active locks, wake the front queued process(es).
+	 *
+	 * If there are no writers and we are first in the queue,
+	 * wake our own waiter to join the existing active readers !
+	 */
+	if (count == RWSEM_WAITING_BIAS ||
+	    (count > RWSEM_WAITING_BIAS &&
+	     adjustment != -RWSEM_ACTIVE_READ_BIAS))
+		__rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
+
+	raw_spin_unlock_irq(&sem->wait_lock);
+	wake_up_q(&wake_q);
+
+	/* wait to be given the lock */
+	while (true) {
+		set_current_state(state);
+		if (!waiter.task)
+			break;
+		if (signal_pending_state(state, current)) {
+			raw_spin_lock_irq(&sem->wait_lock);
+			if (waiter.task)
+				goto out_nolock;
+			raw_spin_unlock_irq(&sem->wait_lock);
+			break;
+		}
+		schedule();
+	}
+
+	__set_current_state(TASK_RUNNING);
+	return sem;
+out_nolock:
+	list_del(&waiter.list);
+	if (list_empty(&sem->wait_list))
+		atomic_long_add(-RWSEM_WAITING_BIAS, &sem->count);
+	raw_spin_unlock_irq(&sem->wait_lock);
+	__set_current_state(TASK_RUNNING);
+	return ERR_PTR(-EINTR);
+}
+
+__visible struct rw_semaphore * __sched
+rwsem_down_read_failed(struct rw_semaphore *sem)
+{
+	return __rwsem_down_read_failed_common(sem, TASK_UNINTERRUPTIBLE);
+}
+EXPORT_SYMBOL(rwsem_down_read_failed);
+
+__visible struct rw_semaphore * __sched
+rwsem_down_read_failed_killable(struct rw_semaphore *sem)
+{
+	return __rwsem_down_read_failed_common(sem, TASK_KILLABLE);
+}
+EXPORT_SYMBOL(rwsem_down_read_failed_killable);
+
 /*
  * Wait until we successfully acquire the write lock
  */
