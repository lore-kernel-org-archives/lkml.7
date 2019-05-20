Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CBAC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5879217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfETVAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 17:00:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34080 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726933AbfETVAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 17:00:06 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BE1B83087939;
        Mon, 20 May 2019 21:00:05 +0000 (UTC)
Received: from llong.com (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0FADD17CF3;
        Mon, 20 May 2019 21:00:03 +0000 (UTC)
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
Subject: [PATCH v8 08/19] locking/rwsem: Always release wait_lock before waking up tasks
Date:   Mon, 20 May 2019 16:59:07 -0400
Message-Id: <20190520205918.22251-9-longman@redhat.com>
In-Reply-To: <20190520205918.22251-1-longman@redhat.com>
References: <20190520205918.22251-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 20 May 2019 21:00:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 0c8aef065acb..36aed5236bd2 100644
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
@@ -811,7 +811,6 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 		}
 
 		raw_spin_lock_irq(&sem->wait_lock);
-		count = atomic_long_read(&sem->count);
 	}
 	__set_current_state(TASK_RUNNING);
 	list_del(&waiter.list);
-- 
2.18.1

