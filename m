Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E684C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 20:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8225421743
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 20:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfETU76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 16:59:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34394 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbfETU74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 16:59:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 893698666D;
        Mon, 20 May 2019 20:59:49 +0000 (UTC)
Received: from llong.com (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F422643E8;
        Mon, 20 May 2019 20:59:47 +0000 (UTC)
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
Subject: [PATCH v8 02/19] locking/rwsem: Remove rwsem_wake() wakeup optimization
Date:   Mon, 20 May 2019 16:59:01 -0400
Message-Id: <20190520205918.22251-3-longman@redhat.com>
In-Reply-To: <20190520205918.22251-1-longman@redhat.com>
References: <20190520205918.22251-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 20 May 2019 20:59:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the commit 59aabfc7e959 ("locking/rwsem: Reduce spinlock contention
in wakeup after up_read()/up_write()"), the rwsem_wake() forgoes doing
a wakeup if the wait_lock cannot be directly acquired and an optimistic
spinning locker is present.  This can help performance by avoiding
spinning on the wait_lock when it is contended.

With the later commit 133e89ef5ef3 ("locking/rwsem: Enable lockless
waiter wakeup(s)"), the performance advantage of the above optimization
diminishes as the average wait_lock hold time become much shorter.

With a later patch that supports rwsem lock handoff, we can no
longer relies on the fact that the presence of an optimistic spinning
locker will ensure that the lock will be acquired by a task soon and
rwsem_wake() will be called later on to wake up waiters. This can lead
to missed wakeup and application hang. So the commit 59aabfc7e959
("locking/rwsem: Reduce spinlock contention in wakeup after
up_read()/up_write()") will have to be reverted.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem-xadd.c | 72 -------------------------------------
 1 file changed, 72 deletions(-)

diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index c0500679fd2f..3083fdf50447 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -411,25 +411,11 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 	lockevent_cond_inc(rwsem_opt_fail, !taken);
 	return taken;
 }
-
-/*
- * Return true if the rwsem has active spinner
- */
-static inline bool rwsem_has_spinner(struct rw_semaphore *sem)
-{
-	return osq_is_locked(&sem->osq);
-}
-
 #else
 static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 {
 	return false;
 }
-
-static inline bool rwsem_has_spinner(struct rw_semaphore *sem)
-{
-	return false;
-}
 #endif
 
 /*
@@ -651,65 +637,7 @@ struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem)
 	unsigned long flags;
 	DEFINE_WAKE_Q(wake_q);
 
-	/*
-	* __rwsem_down_write_failed_common(sem)
-	*   rwsem_optimistic_spin(sem)
-	*     osq_unlock(sem->osq)
-	*   ...
-	*   atomic_long_add_return(&sem->count)
-	*
-	*      - VS -
-	*
-	*              __up_write()
-	*                if (atomic_long_sub_return_release(&sem->count) < 0)
-	*                  rwsem_wake(sem)
-	*                    osq_is_locked(&sem->osq)
-	*
-	* And __up_write() must observe !osq_is_locked() when it observes the
-	* atomic_long_add_return() in order to not miss a wakeup.
-	*
-	* This boils down to:
-	*
-	* [S.rel] X = 1                [RmW] r0 = (Y += 0)
-	*         MB                         RMB
-	* [RmW]   Y += 1               [L]   r1 = X
-	*
-	* exists (r0=1 /\ r1=0)
-	*/
-	smp_rmb();
-
-	/*
-	 * If a spinner is present, it is not necessary to do the wakeup.
-	 * Try to do wakeup only if the trylock succeeds to minimize
-	 * spinlock contention which may introduce too much delay in the
-	 * unlock operation.
-	 *
-	 *    spinning writer		up_write/up_read caller
-	 *    ---------------		-----------------------
-	 * [S]   osq_unlock()		[L]   osq
-	 *	 MB			      RMB
-	 * [RmW] rwsem_try_write_lock() [RmW] spin_trylock(wait_lock)
-	 *
-	 * Here, it is important to make sure that there won't be a missed
-	 * wakeup while the rwsem is free and the only spinning writer goes
-	 * to sleep without taking the rwsem. Even when the spinning writer
-	 * is just going to break out of the waiting loop, it will still do
-	 * a trylock in rwsem_down_write_failed() before sleeping. IOW, if
-	 * rwsem_has_spinner() is true, it will guarantee at least one
-	 * trylock attempt on the rwsem later on.
-	 */
-	if (rwsem_has_spinner(sem)) {
-		/*
-		 * The smp_rmb() here is to make sure that the spinner
-		 * state is consulted before reading the wait_lock.
-		 */
-		smp_rmb();
-		if (!raw_spin_trylock_irqsave(&sem->wait_lock, flags))
-			return sem;
-		goto locked;
-	}
 	raw_spin_lock_irqsave(&sem->wait_lock, flags);
-locked:
 
 	if (!list_empty(&sem->wait_list))
 		__rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
-- 
2.18.1

