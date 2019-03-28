Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56CCC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEDD02082F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfC1SMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 14:12:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39694 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbfC1SME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 14:12:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AB5E93091755;
        Thu, 28 Mar 2019 18:12:03 +0000 (UTC)
Received: from llong.com (dhcp-17-19.bos.redhat.com [10.18.17.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A4A6E5D75F;
        Thu, 28 Mar 2019 18:12:02 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 05/12] locking/rwsem: Ensure an RT task will not spin on reader
Date:   Thu, 28 Mar 2019 14:10:59 -0400
Message-Id: <20190328181106.22887-6-longman@redhat.com>
In-Reply-To: <20190328181106.22887-1-longman@redhat.com>
References: <20190328181106.22887-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 28 Mar 2019 18:12:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An RT task can do optimistic spinning only if the lock holder is
actually running. If the state of the lock holder isn't known, there
is a possibility that high priority of the RT task may block forward
progress of the lock holder if it happens to reside on the same CPU.
This will lead to deadlock. So we have to make sure that an RT task
will not spin on a reader-owned rwsem.

When the owner is temporarily set to NULL, it is more tricky to decide
if an RT task should stop spinning as it may be a temporary state
where another writer may have just stolen the lock which then failed
the task's trylock attempt. So one more retry is allowed to make sure
that the lock is not spinnable by an RT task.

When testing on a 8-socket IvyBridge-EX system, the one additional retry
seems to improve locking performance of RT write locking threads under
heavy contentions. The table below shows the locking rates (in kops/s)
with various write locking threads before and after the patch.

    Locking threads     Pre-patch     Post-patch
    ---------------     ---------     -----------
            4             2,753          2,608
            8             2,529          2,520
           16             1,727          1,918
           32             1,263          1,956
           64               889          1,343

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem-xadd.c | 38 ++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index 35891c53338b..db9ae5fe6d63 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -349,6 +349,8 @@ static noinline enum owner_state rwsem_spin_on_owner(struct rw_semaphore *sem)
 static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 {
 	bool taken = false;
+	bool prev_not_writer = false;
+	bool is_rt_task = rt_task(current);
 
 	preempt_disable();
 
@@ -366,7 +368,12 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 	 *  2) readers own the lock as we can't determine if they are
 	 *     actively running or not.
 	 */
-	while (rwsem_spin_on_owner(sem) & OWNER_SPINNABLE) {
+	for (;;) {
+		enum owner_state owner_state = rwsem_spin_on_owner(sem);
+
+		if (!(owner_state & OWNER_SPINNABLE))
+			break;
+
 		/*
 		 * Try to acquire the lock
 		 */
@@ -376,13 +383,30 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 		}
 
 		/*
-		 * When there's no owner, we might have preempted between the
-		 * owner acquiring the lock and setting the owner field. If
-		 * we're an RT task that will live-lock because we won't let
-		 * the owner complete.
+		 * An RT task cannot do optimistic spinning if it cannot
+		 * be sure the lock holder is running or live-lock may
+		 * happen if the current task and the lock holder happen
+		 * to run in the same CPU.
+		 *
+		 * When there's no owner or is reader-owned, an RT task
+		 * will stop spinning if the owner state is not a writer
+		 * at the previous iteration of the loop. This allows the
+		 * RT task to recheck if the task that steals the lock is
+		 * a spinnable writer. If so, it can keeps on spinning.
+		 *
+		 * If the owner is a writer, the need_resched() check is
+		 * done inside rwsem_spin_on_owner(). If the owner is not
+		 * a writer, need_resched() check needs to be done here.
 		 */
-		if (!sem->owner && (need_resched() || rt_task(current)))
-			break;
+		if (owner_state != OWNER_WRITER) {
+			if (need_resched())
+				break;
+			if (is_rt_task && prev_not_writer)
+				break;
+			prev_not_writer = true;
+		} else {
+			prev_not_writer = false;
+		}
 
 		/*
 		 * The cpu_relax() call is a compiler barrier which forces
-- 
2.18.1

