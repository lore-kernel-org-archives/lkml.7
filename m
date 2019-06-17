Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E8CC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D88C32086A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="JaXjbNBF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfFQO3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:29:40 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59027 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfFQO3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:29:39 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HETBPD3456800
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 07:29:11 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HETBPD3456800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560781751;
        bh=K/pbXir+r+SMZavmfFxMSg6MArz2c8CL6TAuKWY1A5Q=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=JaXjbNBFwxWb1jPLE1MpHY4ELfJ6oiDO6zhwE9qAfkBXQmrenMrmRrGfFa0rU0ERR
         d7eoRzdEHCJXpZFZG60zHiv1GcRirzrkz1osegOm37MnRzIPsTuPv8CfxD1Kcijdiu
         PLydFmln0LDb0UoIDCymTJHAY6pVzLLdqNQC80wY3USjpbYfwWB58IvAWfTo3zJBkX
         t6rd/S38WNp1uSuOn5gSZ7TZev5F2Cwie3LegHRY3pVaLEXKWcQNN9W8c3V2qqg9Dd
         joYWXkpazf+c+y0Oimi+oVCFOf4ocXjca0s+FBnVu6rEAC7z/YGjn2uq/8c2vd8pQl
         zljf+ZWuxD0bg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HETAxi3456797;
        Mon, 17 Jun 2019 07:29:10 -0700
Date:   Mon, 17 Jun 2019 07:29:10 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-990fa7384a3057a3298bcf493651c6e14416c47c@git.kernel.org>
Cc:     peterz@infradead.org, longman@redhat.com,
        huang.ying.caritas@gmail.com, bp@alien8.de,
        tim.c.chen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        will.deacon@arm.com, dave@stgolabs.net, tglx@linutronix.de,
        mingo@kernel.org
Reply-To: huang.ying.caritas@gmail.com, longman@redhat.com,
          peterz@infradead.org, bp@alien8.de, hpa@zytor.com,
          tim.c.chen@linux.intel.com, linux-kernel@vger.kernel.org,
          torvalds@linux-foundation.org, dave@stgolabs.net,
          tglx@linutronix.de, will.deacon@arm.com, mingo@kernel.org
In-Reply-To: <20190520205918.22251-10-longman@redhat.com>
References: <20190520205918.22251-10-longman@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/rwsem: More optimal RT task handling of
 null owner
Git-Commit-ID: 990fa7384a3057a3298bcf493651c6e14416c47c
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

Commit-ID:  990fa7384a3057a3298bcf493651c6e14416c47c
Gitweb:     https://git.kernel.org/tip/990fa7384a3057a3298bcf493651c6e14416c47c
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Mon, 20 May 2019 16:59:08 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 17 Jun 2019 12:28:01 +0200

locking/rwsem: More optimal RT task handling of null owner

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
Link: https://lkml.kernel.org/r/20190520205918.22251-10-longman@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/rwsem.c | 51 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 44 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 5532304406f7..e1840b7c5310 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -566,6 +566,7 @@ static noinline enum owner_state rwsem_spin_on_owner(struct rw_semaphore *sem)
 static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 {
 	bool taken = false;
+	int prev_owner_state = OWNER_NULL;
 
 	preempt_disable();
 
@@ -583,7 +584,12 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
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
@@ -593,13 +599,44 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
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
