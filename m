Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B96C31E50
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F10F42084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="wtXFPGNJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbfFQOYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:24:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37641 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfFQOYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:24:49 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HEOHfU3455821
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 07:24:17 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HEOHfU3455821
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560781457;
        bh=erawa5D80AlYWE7IugLvLOPh9ThZCS/pUytZuP7teuI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=wtXFPGNJStYXwEh/hLE4gaztQaWgeLiWpnVdtnr0GZ5UmDiD0tsMeToS5VTvbwkpr
         2chAAilXJWNR8AXcwx6FflXZ9nhqYOplRnabvKj911KM4Qqq++s2qRcgeO2Hhm28A8
         hwHfMm4QLC7xnQ+XDEAEcjhPEtNIkiYPedyoiZTw0iu+/A/uLFR5G1h9FL+HbVSHJE
         N5yuHJWbkgjRmAMpRnxIelL7zq2spdwtsUCB8HStrxhZNYIjRatB74zf0ehm4d09UK
         AiX6a1naB1Ihh3/sJakgN8P3mhxv6INbosiE//WiOd80Uac3hWKiRFS1cXkX9FXyus
         sYpQi9E537ROQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HEOHeK3455817;
        Mon, 17 Jun 2019 07:24:17 -0700
Date:   Mon, 17 Jun 2019 07:24:17 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-5c1ec49b60cdb31e51010f8a647f3189b774bddf@git.kernel.org>
Cc:     bp@alien8.de, huang.ying.caritas@gmail.com, dave@stgolabs.net,
        mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, tim.c.chen@linux.intel.com,
        longman@redhat.com, torvalds@linux-foundation.org, hpa@zytor.com,
        will.deacon@arm.com
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org,
          mingo@kernel.org, bp@alien8.de, huang.ying.caritas@gmail.com,
          dave@stgolabs.net, tim.c.chen@linux.intel.com,
          peterz@infradead.org, will.deacon@arm.com, hpa@zytor.com,
          longman@redhat.com, torvalds@linux-foundation.org
In-Reply-To: <20190520205918.22251-3-longman@redhat.com>
References: <20190520205918.22251-3-longman@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/rwsem: Remove rwsem_wake() wakeup
 optimization
Git-Commit-ID: 5c1ec49b60cdb31e51010f8a647f3189b774bddf
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

Commit-ID:  5c1ec49b60cdb31e51010f8a647f3189b774bddf
Gitweb:     https://git.kernel.org/tip/5c1ec49b60cdb31e51010f8a647f3189b774bddf
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Mon, 20 May 2019 16:59:01 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 17 Jun 2019 12:27:55 +0200

locking/rwsem: Remove rwsem_wake() wakeup optimization

After the following commit:

  59aabfc7e959 ("locking/rwsem: Reduce spinlock contention in wakeup after up_read()/up_write()")

the rwsem_wake() forgoes doing a wakeup if the wait_lock cannot be directly
acquired and an optimistic spinning locker is present.  This can help performance
by avoiding spinning on the wait_lock when it is contended.

With the later commit:

  133e89ef5ef3 ("locking/rwsem: Enable lockless waiter wakeup(s)")

the performance advantage of the above optimization diminishes as the average
wait_lock hold time become much shorter.

With a later patch that supports rwsem lock handoff, we can no
longer relies on the fact that the presence of an optimistic spinning
locker will ensure that the lock will be acquired by a task soon and
rwsem_wake() will be called later on to wake up waiters. This can lead
to missed wakeup and application hang.

So the original 59aabfc7e959 commit has to be reverted.

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
Link: https://lkml.kernel.org/r/20190520205918.22251-3-longman@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/rwsem-xadd.c | 72 ---------------------------------------------
 1 file changed, 72 deletions(-)

diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index c0500679fd2f..3083fdf50447 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -411,25 +411,11 @@ done:
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
