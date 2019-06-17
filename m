Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB92C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7D9F2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="YISaOXk2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbfFQOb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:31:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57563 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfFQOb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:31:28 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HETrRn3456868
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 07:29:53 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HETrRn3456868
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560781793;
        bh=CfR4iv4TseLBAwQEyZUpCik5itcY5PgiYqyjNjlDrnU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=YISaOXk2HBB1y5MPtqHdncdsX9DEJH0easAo4BTqObTPPOQRVsncJygQllv0fclp/
         lTQ5r+N7Oa6+cO7NQRmZMkrtwCoKpwY3oehX+tdlLMtl1VhEYxeXcj1CAaFLsUL2j1
         BYZibzZAh4baCPkzejuyQo0SoTFRMwartcy9x/4akQEzc0mxJaE8uAz74UFQjd66OI
         fvsJYGwx6jGsco/RtHo1Vk6FCvZXGIN4yOhrPP4e3oMpnMbEg3hJClUhFky2J0F+cy
         K48YHxjZuNPiVjEB8WysHNuHtABGwOtWg6RWS0itzwDorXGnKy3cmumRKSYRqGCeMr
         k+BLVyngM2ZhQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HETrAv3456865;
        Mon, 17 Jun 2019 07:29:53 -0700
Date:   Mon, 17 Jun 2019 07:29:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-d3681e269fff84048c94012342c3434b227c4706@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com, will.deacon@arm.com,
        dave@stgolabs.net, bp@alien8.de, tglx@linutronix.de,
        peterz@infradead.org, longman@redhat.com,
        huang.ying.caritas@gmail.com, mingo@kernel.org,
        torvalds@linux-foundation.org, tim.c.chen@linux.intel.com
Reply-To: hpa@zytor.com, will.deacon@arm.com, tglx@linutronix.de,
          peterz@infradead.org, dave@stgolabs.net, bp@alien8.de,
          torvalds@linux-foundation.org, tim.c.chen@linux.intel.com,
          huang.ying.caritas@gmail.com, mingo@kernel.org,
          longman@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20190520205918.22251-11-longman@redhat.com>
References: <20190520205918.22251-11-longman@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/rwsem: Wake up almost all readers in
 wait queue
Git-Commit-ID: d3681e269fff84048c94012342c3434b227c4706
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

Commit-ID:  d3681e269fff84048c94012342c3434b227c4706
Gitweb:     https://git.kernel.org/tip/d3681e269fff84048c94012342c3434b227c4706
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Mon, 20 May 2019 16:59:09 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 17 Jun 2019 12:28:02 +0200

locking/rwsem: Wake up almost all readers in wait queue

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
Link: https://lkml.kernel.org/r/20190520205918.22251-11-longman@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/rwsem.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index e1840b7c5310..ded96023f4dc 100644
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
@@ -329,11 +337,17 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
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
@@ -345,13 +359,20 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
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
