Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9DDC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A712084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="pjy0KxoA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfFQO25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:28:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35153 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfFQO24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:28:56 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HESTTA3456732
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 07:28:29 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HESTTA3456732
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560781710;
        bh=iurL0Ms4B3HOItAzsIajRwpl1/RChfVo6Hnf3PN5SrE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=pjy0KxoAx9+Sf4d2jYDN+mLZ6c3Wzkvj+JPLwxqN7iAYbRrxoVqXeSbIczKrnoZUH
         h9k9WHIjrVaza0/A7s5nvJ+osJOehGE4VUhN52SM4FEoU6zyuUrbCZfp4OPql52+1j
         CGcnjDeE1qpr2NvmGEXE2+FjMfqWnLG1zUExyDatLmE8gTJgR3IMIXVSKOM9z26Q1C
         xWg+gsI0wW9JhFiSG1Sa4IRiuaW6VUzLBkPGoAuZMDKmB/JA5nwPjieOIBmf+GN6fU
         zvINasZ5G4vyDt29lsyd0fhc66KzyMhhFLmsByF6PM2Q/TgtdaCYxApm5/W7XZvC3f
         C14oDciIOMuIA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HESTZp3456729;
        Mon, 17 Jun 2019 07:28:29 -0700
Date:   Mon, 17 Jun 2019 07:28:29 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-00f3c5a3df2c1e3dab14d0dd2b71f852d46be97f@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, huang.ying.caritas@gmail.com,
        longman@redhat.com, peterz@infradead.org, will.deacon@arm.com,
        mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        tim.c.chen@linux.intel.com, dave@stgolabs.net, bp@alien8.de,
        torvalds@linux-foundation.org
Reply-To: torvalds@linux-foundation.org, dave@stgolabs.net,
          tim.c.chen@linux.intel.com, bp@alien8.de, tglx@linutronix.de,
          hpa@zytor.com, mingo@kernel.org, will.deacon@arm.com,
          peterz@infradead.org, longman@redhat.com,
          huang.ying.caritas@gmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <20190520205918.22251-9-longman@redhat.com>
References: <20190520205918.22251-9-longman@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/rwsem: Always release wait_lock before
 waking up tasks
Git-Commit-ID: 00f3c5a3df2c1e3dab14d0dd2b71f852d46be97f
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

Commit-ID:  00f3c5a3df2c1e3dab14d0dd2b71f852d46be97f
Gitweb:     https://git.kernel.org/tip/00f3c5a3df2c1e3dab14d0dd2b71f852d46be97f
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Mon, 20 May 2019 16:59:07 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 17 Jun 2019 12:28:00 +0200

locking/rwsem: Always release wait_lock before waking up tasks

With the use of wake_q, we can do task wakeups without holding the
wait_lock. There is one exception in the rwsem code, though. It is
when the writer in the slowpath detects that there are waiters ahead
but the rwsem is not held by a writer. This can lead to a long wait_lock
hold time especially when a large number of readers are to be woken up.

Remediate this situation by releasing the wait_lock before waking
up tasks and re-acquiring it afterward. The rwsem_try_write_lock()
function is also modified to read the rwsem count directly to avoid
stale count value.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: huang ying <huang.ying.caritas@gmail.com>
Link: https://lkml.kernel.org/r/20190520205918.22251-9-longman@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/sched/wake_q.h |  5 +++++
 kernel/locking/rwsem.c       | 31 +++++++++++++++----------------
 2 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/include/linux/sched/wake_q.h b/include/linux/sched/wake_q.h
index ad826d2a4557..26a2013ac39c 100644
--- a/include/linux/sched/wake_q.h
+++ b/include/linux/sched/wake_q.h
@@ -51,6 +51,11 @@ static inline void wake_q_init(struct wake_q_head *head)
 	head->lastp = &head->first;
 }
 
+static inline bool wake_q_empty(struct wake_q_head *head)
+{
+	return head->first == WAKE_Q_TAIL;
+}
+
 extern void wake_q_add(struct wake_q_head *head, struct task_struct *task);
 extern void wake_q_add_safe(struct wake_q_head *head, struct task_struct *task);
 extern void wake_up_q(struct wake_q_head *head);
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index decda9fb8c6d..5532304406f7 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -400,13 +400,14 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
  * If wstate is WRITER_HANDOFF, it will make sure that either the handoff
  * bit is set or the lock is acquired with handoff bit cleared.
  */
-static inline bool rwsem_try_write_lock(long count, struct rw_semaphore *sem,
+static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
 					enum writer_wait_state wstate)
 {
-	long new;
+	long count, new;
 
 	lockdep_assert_held(&sem->wait_lock);
 
+	count = atomic_long_read(&sem->count);
 	do {
 		bool has_handoff = !!(count & RWSEM_FLAG_HANDOFF);
 
@@ -751,26 +752,25 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 					? RWSEM_WAKE_READERS
 					: RWSEM_WAKE_ANY, &wake_q);
 
-		/*
-		 * The wakeup is normally called _after_ the wait_lock
-		 * is released, but given that we are proactively waking
-		 * readers we can deal with the wake_q overhead as it is
-		 * similar to releasing and taking the wait_lock again
-		 * for attempting rwsem_try_write_lock().
-		 */
-		wake_up_q(&wake_q);
-
-		/* We need wake_q again below, reinitialize */
-		wake_q_init(&wake_q);
+		if (!wake_q_empty(&wake_q)) {
+			/*
+			 * We want to minimize wait_lock hold time especially
+			 * when a large number of readers are to be woken up.
+			 */
+			raw_spin_unlock_irq(&sem->wait_lock);
+			wake_up_q(&wake_q);
+			wake_q_init(&wake_q);	/* Used again, reinit */
+			raw_spin_lock_irq(&sem->wait_lock);
+		}
 	} else {
-		count = atomic_long_add_return(RWSEM_FLAG_WAITERS, &sem->count);
+		atomic_long_or(RWSEM_FLAG_WAITERS, &sem->count);
 	}
 
 wait:
 	/* wait until we successfully acquire the lock */
 	set_current_state(state);
 	while (true) {
-		if (rwsem_try_write_lock(count, sem, wstate))
+		if (rwsem_try_write_lock(sem, wstate))
 			break;
 
 		raw_spin_unlock_irq(&sem->wait_lock);
@@ -811,7 +811,6 @@ wait:
 		}
 
 		raw_spin_lock_irq(&sem->wait_lock);
-		count = atomic_long_read(&sem->count);
 	}
 	__set_current_state(TASK_RUNNING);
 	list_del(&waiter.list);
