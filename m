Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E70AC43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 15:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 123BF206BB
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 15:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfD1P6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 11:58:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50548 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726744AbfD1P6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 11:58:31 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E73AE308FF32;
        Sun, 28 Apr 2019 15:58:29 +0000 (UTC)
Received: from llong.com (ovpn-120-22.rdu2.redhat.com [10.10.120.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6C043620DF;
        Sun, 28 Apr 2019 15:58:28 +0000 (UTC)
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
        Waiman Long <longman@redhat.com>, stable@vger.kernel.org
Subject: [PATCH-tip v6 01/20] locking/rwsem: Prevent decrement of reader count before increment
Date:   Sun, 28 Apr 2019 11:57:36 -0400
Message-Id: <20190428155755.14267-2-longman@redhat.com>
In-Reply-To: <20190428155755.14267-1-longman@redhat.com>
References: <20190428155755.14267-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Sun, 28 Apr 2019 15:58:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During my rwsem testing, it was found that after a down_read(), the
reader count may occasionally become 0 or even negative. Consequently,
a writer may steal the lock at that time and execute with the reader
in parallel thus breaking the mutual exclusion guarantee of the write
lock. In other words, both readers and writer can become rwsem owners
simultaneously.

The current reader wakeup code does it in one pass to clear waiter->task
and put them into wake_q before fully incrementing the reader count.
Once waiter->task is cleared, the corresponding reader may see it,
finish the critical section and do unlock to decrement the count before
the count is incremented. This is not a problem if there is only one
reader to wake up as the count has been pre-incremented by 1.  It is
a problem if there are more than one readers to be woken up and writer
can steal the lock.

The wakeup is actually done in 2 passes before the v4.9 commit
70800c3c0cc5 ("locking/rwsem: Scan the wait_list for readers only
once"). To fix this problem, the wakeup is now done in two passes
again. In the first pass, we collect the readers and count them. The
reader count is then fully incremented. In the second pass, the
waiter->task is then cleared and they are put into wake_q to be woken
up later.

Fixes: 70800c3c0cc5 ("locking/rwsem: Scan the wait_list for readers only once")
Cc: <stable@vger.kernel.org>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem-xadd.c | 45 +++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index 6b3ee9948bf1..cab5b1f6b2de 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -130,6 +130,7 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 {
 	struct rwsem_waiter *waiter, *tmp;
 	long oldcount, woken = 0, adjustment = 0;
+	struct list_head wlist;
 
 	/*
 	 * Take a peek at the queue head waiter such that we can determine
@@ -188,18 +189,44 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 	 * of the queue. We know that woken will be at least 1 as we accounted
 	 * for above. Note we increment the 'active part' of the count by the
 	 * number of readers before waking any processes up.
+	 *
+	 * We have to do wakeup in 2 passes to prevent the possibility that
+	 * the reader count may be decremented before it is incremented. It
+	 * is because the to-be-woken waiter may not have slept yet. So it
+	 * may see waiter->task got cleared, finish its critical section and
+	 * do an unlock before the reader count increment.
+	 *
+	 * 1) Collect the read-waiters in a separate list, count them and
+	 *    fully increment the reader count in rwsem.
+	 * 2) For each waiters in the new list, clear waiter->task and
+	 *    put them into wake_q to be woken up later.
 	 */
+	INIT_LIST_HEAD(&wlist);
 	list_for_each_entry_safe(waiter, tmp, &sem->wait_list, list) {
-		struct task_struct *tsk;
-
 		if (waiter->type == RWSEM_WAITING_FOR_WRITE)
 			break;
 
 		woken++;
-		tsk = waiter->task;
+		list_move_tail(&waiter->list, &wlist);
+	}
+
+	adjustment = woken * RWSEM_ACTIVE_READ_BIAS - adjustment;
+	lockevent_cond_inc(rwsem_wake_reader, woken);
+	if (list_empty(&sem->wait_list)) {
+		/* hit end of list above */
+		adjustment -= RWSEM_WAITING_BIAS;
+	}
+
+	if (adjustment)
+		atomic_long_add(adjustment, &sem->count);
+
+	/* 2nd pass */
+	list_for_each_entry(waiter, &wlist, list) {
+		struct task_struct *tsk;
 
+		tsk = waiter->task;
 		get_task_struct(tsk);
-		list_del(&waiter->list);
+
 		/*
 		 * Ensure calling get_task_struct() before setting the reader
 		 * waiter to nil such that rwsem_down_read_failed() cannot
@@ -213,16 +240,6 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 		 */
 		wake_q_add_safe(wake_q, tsk);
 	}
-
-	adjustment = woken * RWSEM_ACTIVE_READ_BIAS - adjustment;
-	lockevent_cond_inc(rwsem_wake_reader, woken);
-	if (list_empty(&sem->wait_list)) {
-		/* hit end of list above */
-		adjustment -= RWSEM_WAITING_BIAS;
-	}
-
-	if (adjustment)
-		atomic_long_add(adjustment, &sem->count);
 }
 
 /*
-- 
2.18.1

