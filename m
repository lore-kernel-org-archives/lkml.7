Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13626C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 07:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA752087F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 07:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="JvAH6Zcv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfEGHHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 03:07:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42117 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbfEGHHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 03:07:45 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x47770aP355922
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 7 May 2019 00:07:00 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x47770aP355922
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1557212821;
        bh=jJJAS++DwwhviYTEtHslAE5eTRHqSq/delEGoB/SbQc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=JvAH6ZcvDvdw6Vwx5P/sUgpQv7qxi0zW17+N4fTdGMAKF1SFHdO5o8Viqupam23ND
         CknR3uZPhbYpjVfuOTpQdFz4GLrtVjyo0RfX8axvVxX8pno6rOArQVsdaW+HAAUdUW
         s0DBu4Tn/Ul9QIhBrXLwszcpUKOd1DHdvYPSXoG5GtHTzkox9gWowAwlek6VPrWybr
         G0Wu/Qaq+Oxk++aqA+JKF7/iKQ980oBd+MW9+92shP/dgVmaQPFU/hfbBcSFd9xtog
         i5aswlog6iHW3P9E6Og9di7dGEXujr1VqM7NRuhtH+7UuRe5BY3hQ9WqK7TLJwoNIu
         vcCzLtcFyQNXg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x477704O355919;
        Tue, 7 May 2019 00:07:00 -0700
Date:   Tue, 7 May 2019 00:07:00 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-a9e9bcb45b1525ba7aea26ed9441e8632aeeda58@git.kernel.org>
Cc:     huang.ying.caritas@gmail.com, dave@stgolabs.net, hpa@zytor.com,
        bp@alien8.de, will.deacon@arm.com, tglx@linutronix.de,
        tim.c.chen@linux.intel.com, peterz@infradead.org,
        longman@redhat.com, torvalds@linux-foundation.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, bp@alien8.de, will.deacon@arm.com,
          huang.ying.caritas@gmail.com, dave@stgolabs.net,
          torvalds@linux-foundation.org, mingo@kernel.org,
          tim.c.chen@linux.intel.com, longman@redhat.com,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          tglx@linutronix.de
In-Reply-To: <20190428212557.13482-2-longman@redhat.com>
References: <20190428212557.13482-2-longman@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/urgent] locking/rwsem: Prevent decrement of reader
 count before increment
Git-Commit-ID: a9e9bcb45b1525ba7aea26ed9441e8632aeeda58
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

Commit-ID:  a9e9bcb45b1525ba7aea26ed9441e8632aeeda58
Gitweb:     https://git.kernel.org/tip/a9e9bcb45b1525ba7aea26ed9441e8632aeeda58
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Sun, 28 Apr 2019 17:25:38 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 7 May 2019 08:46:46 +0200

locking/rwsem: Prevent decrement of reader count before increment

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

The wakeup was actually done in 2 passes before the following v4.9 commit:

  70800c3c0cc5 ("locking/rwsem: Scan the wait_list for readers only once")

To fix this problem, the wakeup is now done in two passes
again. In the first pass, we collect the readers and count them.
The reader count is then fully incremented. In the second pass, the
waiter->task is then cleared and they are put into wake_q to be woken
up later.

Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: huang ying <huang.ying.caritas@gmail.com>
Fixes: 70800c3c0cc5 ("locking/rwsem: Scan the wait_list for readers only once")
Link: http://lkml.kernel.org/r/20190428212557.13482-2-longman@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/rwsem-xadd.c | 46 ++++++++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index 6b3ee9948bf1..0b1f77957240 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -130,6 +130,7 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 {
 	struct rwsem_waiter *waiter, *tmp;
 	long oldcount, woken = 0, adjustment = 0;
+	struct list_head wlist;
 
 	/*
 	 * Take a peek at the queue head waiter such that we can determine
@@ -188,18 +189,43 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
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
-	list_for_each_entry_safe(waiter, tmp, &sem->wait_list, list) {
-		struct task_struct *tsk;
-
+	list_for_each_entry(waiter, &sem->wait_list, list) {
 		if (waiter->type == RWSEM_WAITING_FOR_WRITE)
 			break;
 
 		woken++;
-		tsk = waiter->task;
+	}
+	list_cut_before(&wlist, &sem->wait_list, &waiter->list);
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
+	list_for_each_entry_safe(waiter, tmp, &wlist, list) {
+		struct task_struct *tsk;
 
+		tsk = waiter->task;
 		get_task_struct(tsk);
-		list_del(&waiter->list);
+
 		/*
 		 * Ensure calling get_task_struct() before setting the reader
 		 * waiter to nil such that rwsem_down_read_failed() cannot
@@ -213,16 +239,6 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
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
