Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190D7C76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 13:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D2F2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 13:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q6Spbf+g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390650AbfGRNxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 09:53:44 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43920 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390574AbfGRNxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 09:53:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=q0KGUBYy1+/7QlMG960RGlggnhNzObvuQQ3z5su4p10=; b=q6Spbf+gLD099kzuQ1i67Mg0x0
        o9Bds4PAfrdwAqPevfxygjFJUPB+9Ey0E3eUs3/MWjh5/MBgE9M0wgMmqhaN1Al8yfokaImPFQ922
        M5uK4eRkmwkTahjeULcKC5c1SWZrBXC7x3cjClp1R2YIS6OEITNEJbzok2RYZIbej6sK4EJ13t5w8
        +AJyc6FeGRy4RCYjJQz/OQImWWRv9pif5+N5o3ASEISx1tTY26PN4yLMDR2Uhe7hhMT+YBorlJ3TK
        u3UB6xqpTKNMGV8X9RDLrmQZ+7vZXtAC4TzetAIu9zCx/h/sVAEDp+NnmTyJqfVcY49B8zw2xjqxz
        fU5bsnoA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1ho6qb-0003u6-Fk; Thu, 18 Jul 2019 13:53:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D4DBD20B979A6; Thu, 18 Jul 2019 15:53:22 +0200 (CEST)
Message-Id: <20190718135206.228078863@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 18 Jul 2019 15:49:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Jan Stancek <jstancek@redhat.com>,
        Waiman Long <longman@redhat.com>, dbueso@suse.de,
        mingo@redhat.com, jade.alglave@arm.com, paulmck@linux.vnet.ibm.com
Subject: [PATCH 4/4] rwsem: Add ACQUIRE comments
References: <20190718134954.496297975@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we just reviewed read_slowpath for ACQUIRE correctness, add a
few coments to retain our findings.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/locking/rwsem.c |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1000,6 +1000,7 @@ rwsem_down_read_slowpath(struct rw_semap
 	atomic_long_add(-RWSEM_READER_BIAS, &sem->count);
 	adjustment = 0;
 	if (rwsem_optimistic_spin(sem, false)) {
+		/* rwsem_optimistic_spin() implies ACQUIRE on success */
 		/*
 		 * Wake up other readers in the wait list if the front
 		 * waiter is a reader.
@@ -1014,6 +1015,7 @@ rwsem_down_read_slowpath(struct rw_semap
 		}
 		return sem;
 	} else if (rwsem_reader_phase_trylock(sem, waiter.last_rowner)) {
+		/* rwsem_reader_phase_trylock() implies ACQUIRE on success */
 		return sem;
 	}
 
@@ -1067,10 +1069,10 @@ rwsem_down_read_slowpath(struct rw_semap
 	wake_up_q(&wake_q);
 
 	/* wait to be given the lock */
-	while (true) {
+	for (;;) {
 		set_current_state(state);
 		if (!smp_load_acquire(&waiter.task)) {
-			/* Orders against rwsem_mark_wake()'s smp_store_release() */
+			/* Matches rwsem_mark_wake()'s smp_store_release(). */
 			break;
 		}
 		if (signal_pending_state(state, current)) {
@@ -1078,6 +1080,7 @@ rwsem_down_read_slowpath(struct rw_semap
 			if (waiter.task)
 				goto out_nolock;
 			raw_spin_unlock_irq(&sem->wait_lock);
+			/* Ordered by sem->wait_lock against rwsem_mark_wake(). */
 			break;
 		}
 		schedule();
@@ -1087,6 +1090,7 @@ rwsem_down_read_slowpath(struct rw_semap
 	__set_current_state(TASK_RUNNING);
 	lockevent_inc(rwsem_rlock);
 	return sem;
+
 out_nolock:
 	list_del(&waiter.list);
 	if (list_empty(&sem->wait_list)) {
@@ -1127,8 +1131,10 @@ rwsem_down_write_slowpath(struct rw_sema
 
 	/* do optimistic spinning and steal lock if possible */
 	if (rwsem_can_spin_on_owner(sem, RWSEM_WR_NONSPINNABLE) &&
-	    rwsem_optimistic_spin(sem, true))
+	    rwsem_optimistic_spin(sem, true)) {
+		/* rwsem_optimistic_spin() implies ACQUIRE on success */
 		return sem;
+	}
 
 	/*
 	 * Disable reader optimistic spinning for this rwsem after
@@ -1188,9 +1194,11 @@ rwsem_down_write_slowpath(struct rw_sema
 wait:
 	/* wait until we successfully acquire the lock */
 	set_current_state(state);
-	while (true) {
-		if (rwsem_try_write_lock(sem, wstate))
+	for (;;) {
+		if (rwsem_try_write_lock(sem, wstate)) {
+			/* rwsem_try_write_lock() implies ACQUIRE on success */
 			break;
+		}
 
 		raw_spin_unlock_irq(&sem->wait_lock);
 


