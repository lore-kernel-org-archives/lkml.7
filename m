Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E910EC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDEC12053B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730333AbfLJWMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 17:12:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:60742 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729369AbfLJWMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 17:12:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 903DCAD2B;
        Tue, 10 Dec 2019 22:12:45 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     peterz@infradead.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, will@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH] Revert "locking/mutex: Complain upon mutex API misuse in IRQ contexts"
Date:   Tue, 10 Dec 2019 14:05:23 -0800
Message-Id: <20191210220523.28540-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191210193011.GA11802@worktop.programming.kicks-ass.net>
References: <20191210193011.GA11802@worktop.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This ended up causing some noise in places such as rxrpc running in softirq.

The warning is misleading in this case as the mutex trylock and unlock
operations are done within the same context; and therefore we need not
worry about the PI-boosting issues that comes along with no single-owner
lock guarantees.

While we don't want to support this in mutexes, there is no way out of
this yet; so lets get rid of the WARNs for now, as it is only fair to
code that has historically relied on non-preemptible softirq guarantees.
In addition, changing the lock type is also unviable: exclusive rwsems
have the same issue (just not the WARN_ON) and counting semaphores
would introduce a performance hit as mutexes are a lot more optimized.

This reverts commit 5d4ebaa87329ef226e74e52c80ac1c62e4948987.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 kernel/locking/mutex.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 54cc5f9286e9..5352ce50a97e 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -733,9 +733,6 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
  */
 void __sched mutex_unlock(struct mutex *lock)
 {
-#ifdef CONFIG_DEBUG_MUTEXES
-	WARN_ON(in_interrupt());
-#endif
 #ifndef CONFIG_DEBUG_LOCK_ALLOC
 	if (__mutex_unlock_fast(lock))
 		return;
@@ -1416,7 +1413,6 @@ int __sched mutex_trylock(struct mutex *lock)
 
 #ifdef CONFIG_DEBUG_MUTEXES
 	DEBUG_LOCKS_WARN_ON(lock->magic != lock);
-	WARN_ON(in_interrupt());
 #endif
 
 	locked = __mutex_trylock(lock);
-- 
2.16.4

