Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF11C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 23:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F200B206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 23:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfDRXrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 19:47:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39868 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726719AbfDRXrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 19:47:10 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8B0EB30917F0;
        Thu, 18 Apr 2019 23:47:09 +0000 (UTC)
Received: from llong.com (ovpn-120-92.rdu2.redhat.com [10.10.120.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1FD1D5D707;
        Thu, 18 Apr 2019 23:47:06 +0000 (UTC)
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
Subject: [PATCH v5 09/18] locking/rwsem: More optimal RT task handling of null owner
Date:   Thu, 18 Apr 2019 19:46:19 -0400
Message-Id: <20190418234628.3675-10-longman@redhat.com>
In-Reply-To: <20190418234628.3675-1-longman@redhat.com>
References: <20190418234628.3675-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 18 Apr 2019 23:47:09 +0000 (UTC)
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

When the owner is temporarily set to NULL, there are two cases
where we may want to continue spinning:

 1) The lock owner is in the process of releasing the lock, sem->owner
    is cleared but the lock has not been released yet.

 2) The lock was free and owner cleared, but another task just comes
    in and acquire the lock before we try to get it. The new owner may
    be a spinnable writer.

So an RT task is now made to retry one more time to see if it can
acquire the lock or continue spinning on the new owning writer.

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
 kernel/locking/rwsem.c | 51 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 44 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 087bbef2089e..97c4e92482be 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -545,6 +545,7 @@ static noinline enum owner_state rwsem_spin_on_owner(struct rw_semaphore *sem)
 static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 {
 	bool taken = false;
+	int prev_owner_state = OWNER_NULL;
 
 	preempt_disable();
 
@@ -562,7 +563,12 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
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
@@ -572,13 +578,44 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 		}
 
 		/*
-		 * When there's no owner, we might have preempted between the
-		 * owner acquiring the lock and setting the owner field. If
-		 * we're an RT task that will live-lock because we won't let
-		 * the owner complete.
+		 * An RT task cannot do optimistic spinning if it cannot
+		 * be sure the lock holder is running or live-lock may
+		 * happen if the current task and the lock holder happen
+		 * to run in the same CPU. However, aborting optimistic
+		 * spinning while a NULL owner is detected may miss some
+		 * opportunity where spinning can continue without causing
+		 * problem.
+		 *
+		 * There are 2 possible cases where an RT task may be able
+		 * to continue spinning.
+		 *
+		 * 1) The lock owner is in the process of releasing the
+		 *    lock, sem->owner is cleared but the lock has not
+		 *    been released yet.
+		 * 2) The lock was free and owner cleared, but another
+		 *    task just comes in and acquire the lock before
+		 *    we try to get it. The new owner may be a spinnable
+		 *    writer.
+		 *
+		 * To take advantage of two scenarios listed agove, the RT
+		 * task is made to retry one more time to see if it can
+		 * acquire the lock or continue spinning on the new owning
+		 * writer. Of course, if the time lag is long enough or the
+		 * new owner is not a writer or spinnable, the RT task will
+		 * quit spinning.
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
+			if (rt_task(current) &&
+			   (prev_owner_state != OWNER_WRITER))
+				break;
+		}
+		prev_owner_state = owner_state;
 
 		/*
 		 * The cpu_relax() call is a compiler barrier which forces
-- 
2.18.1

