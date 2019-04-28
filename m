Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E75C43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 21:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C7B720679
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 21:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfD1V06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 17:26:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56636 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbfD1V0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 17:26:55 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 19E6C30842AC;
        Sun, 28 Apr 2019 21:26:55 +0000 (UTC)
Received: from llong.com (ovpn-120-22.rdu2.redhat.com [10.10.120.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 45234646A5;
        Sun, 28 Apr 2019 21:26:53 +0000 (UTC)
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
Subject: [PATCH-tip v7 11/20] locking/rwsem: Wake up almost all readers in wait queue
Date:   Sun, 28 Apr 2019 17:25:48 -0400
Message-Id: <20190428212557.13482-12-longman@redhat.com>
In-Reply-To: <20190428212557.13482-1-longman@redhat.com>
References: <20190428212557.13482-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Sun, 28 Apr 2019 21:26:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the front of the wait queue is a reader, other readers
immediately following the first reader will also be woken up at the
same time. However, if there is a writer in between. Those readers
behind the writer will not be woken up.

Because of optimistic spinning, the lock acquisition order is not FIFO
anyway. The lock handoff mechanism will ensure that lock starvation
will not happen.

Assuming that the lock hold times of the other readers still in the
queue will be about the same as the readers that are being woken up,
there is really not much additional cost other than the additional
latency due to the wakeup of additional tasks by the waker. Therefore
all the readers up to a maximum of 256 in the queue are woken up when
the first waiter is a reader to improve reader throughput. This is
somewhat similar in concept to a phase-fair R/W lock.

With a locking microbenchmark running on 5.1 based kernel, the total
locking rates (in kops/s) on a 8-socket IvyBridge-EX system with
equal numbers of readers and writers before and after this patch were
as follows:

   # of Threads  Pre-Patch   Post-patch
   ------------  ---------   ----------
        4          1,641        1,674
        8            731        1,062
       16            564          924
       32             78          300
       64             38          195
      240             50          149

There is no performance gain at low contention level. At high contention
level, however, this patch gives a pretty decent performance boost.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 62ca834d59d0..8c212b658854 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -254,6 +254,14 @@ enum writer_wait_state {
  */
 #define RWSEM_WAIT_TIMEOUT	DIV_ROUND_UP(HZ, 250)
 
+/*
+ * Magic number to batch-wakeup waiting readers, even when writers are
+ * also present in the queue. This both limits the amount of work the
+ * waking thread must do and also prevents any potential counter overflow,
+ * however unlikely.
+ */
+#define MAX_READERS_WAKEUP	0x100
+
 /*
  * handle the lock release when processes blocked on it that can now run
  * - if we come here from up_xxxx(), then the RWSEM_FLAG_WAITERS bit must
@@ -329,11 +337,17 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 	}
 
 	/*
-	 * Grant an infinite number of read locks to the readers at the front
-	 * of the queue. We know that woken will be at least 1 as we accounted
+	 * Grant up to MAX_READERS_WAKEUP read locks to all the readers in the
+	 * queue. We know that the woken will be at least 1 as we accounted
 	 * for above. Note we increment the 'active part' of the count by the
 	 * number of readers before waking any processes up.
 	 *
+	 * This is an adaptation of the phase-fair R/W locks where at the
+	 * reader phase (first waiter is a reader), all readers are eligible
+	 * to acquire the lock at the same time irrespective of their order
+	 * in the queue. The writers acquire the lock according to their
+	 * order in the queue.
+	 *
 	 * We have to do wakeup in 2 passes to prevent the possibility that
 	 * the reader count may be decremented before it is incremented. It
 	 * is because the to-be-woken waiter may not have slept yet. So it
@@ -345,13 +359,20 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 	 * 2) For each waiters in the new list, clear waiter->task and
 	 *    put them into wake_q to be woken up later.
 	 */
-	list_for_each_entry(waiter, &sem->wait_list, list) {
+	INIT_LIST_HEAD(&wlist);
+	list_for_each_entry_safe(waiter, tmp, &sem->wait_list, list) {
 		if (waiter->type == RWSEM_WAITING_FOR_WRITE)
-			break;
+			continue;
 
 		woken++;
+		list_move_tail(&waiter->list, &wlist);
+
+		/*
+		 * Limit # of readers that can be woken up per wakeup call.
+		 */
+		if (woken >= MAX_READERS_WAKEUP)
+			break;
 	}
-	list_cut_before(&wlist, &sem->wait_list, &waiter->list);
 
 	adjustment = woken * RWSEM_READER_BIAS - adjustment;
 	lockevent_cond_inc(rwsem_wake_reader, woken);
-- 
2.18.1

