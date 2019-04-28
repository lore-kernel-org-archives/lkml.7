Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A78AC43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 15:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E21A22067D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 15:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfD1P6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 11:58:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49794 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727017AbfD1P6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 11:58:47 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 56AA9307D911;
        Sun, 28 Apr 2019 15:58:47 +0000 (UTC)
Received: from llong.com (ovpn-120-22.rdu2.redhat.com [10.10.120.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DFA9F63BAB;
        Sun, 28 Apr 2019 15:58:45 +0000 (UTC)
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
Subject: [PATCH-tip v6 09/20] locking/rwsem: Always release wait_lock before waking up tasks
Date:   Sun, 28 Apr 2019 11:57:44 -0400
Message-Id: <20190428155755.14267-10-longman@redhat.com>
In-Reply-To: <20190428155755.14267-1-longman@redhat.com>
References: <20190428155755.14267-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Sun, 28 Apr 2019 15:58:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the use of wake_q, we can do task wakeups without holding the
wait_lock. There is one exception in the rwsem code, though. It is
when the writer in the slowpath detects that there are waiters ahead
but the rwsem is not held by a writer. This can lead to a long wait_lock
hold time especially when a large number of readers are to be woken up.

Remediate this situation by releasing the wait_lock before waking up
tasks and re-acquiring it afterward.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/sched/wake_q.h |  5 +++++
 kernel/locking/rwsem.c       | 30 +++++++++++++++++++-----------
 2 files changed, 24 insertions(+), 11 deletions(-)

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
index 36e69b773d36..0181f9353a77 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -748,17 +748,25 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
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
+			/*
+			 * This waiter may have become first in the wait
+			 * list after re-acquring the wait_lock. The
+			 * rwsem_first_waiter() test in the main while
+			 * loop below will correctly detect that. We do
+			 * need to reload count to perform proper trylock
+			 * and avoid missed wakeup.
+			 */
+			count = atomic_long_read(&sem->count);
+		}
 	} else {
 		count = atomic_long_add_return(RWSEM_FLAG_WAITERS, &sem->count);
 	}
-- 
2.18.1

