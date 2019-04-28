Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80BAC43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 15:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF775206A3
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 15:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfD1P7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 11:59:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37158 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727145AbfD1P7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 11:59:33 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E3641309265F;
        Sun, 28 Apr 2019 15:59:32 +0000 (UTC)
Received: from llong.com (ovpn-120-22.rdu2.redhat.com [10.10.120.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ACEAC601AE;
        Sun, 28 Apr 2019 15:59:28 +0000 (UTC)
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
Subject: [PATCH-tip v6 20/20] locking/rwsem: Disable preemption in down_read*() if owner in count
Date:   Sun, 28 Apr 2019 11:57:55 -0400
Message-Id: <20190428155755.14267-21-longman@redhat.com>
In-Reply-To: <20190428155755.14267-1-longman@redhat.com>
References: <20190428155755.14267-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Sun, 28 Apr 2019 15:59:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is very unlikely that successive preemption at the middle of
down_read's inc-check-dec sequence will cause the reader count to
overflow, For absolute correctness, however, we still need to prevent
that possibility from happening. So preemption will be disabled during
the down_read*() call.

For PREEMPT=n kernels, there isn't much overhead in doing that.
For PREEMPT=y kernels, there will be some additional cost. RT kernels
have their own rwsem code, so it will not be a problem for them.

If MERGE_OWNER_INTO_COUNT isn't defined, we don't need to worry about
reader count overflow and so we don't need to disable preemption.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem.c | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index f7fcd6a24244..97a2334d9cd3 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -375,6 +375,24 @@ static inline void rwsem_set_nonspinnable(struct rw_semaphore *sem)
 }
 
 #ifdef MERGE_OWNER_INTO_COUNT
+/*
+ * It is very unlikely that successive preemption at the middle of
+ * down_read's inc-check-dec sequence will cause the reader count to
+ * overflow, For absolute correctness, we still need to prevent
+ * that possibility from happening. So preemption will be disabled
+ * during the down_read*() call.
+ *
+ * For PREEMPT=n kernels, there isn't much overhead in doing that.
+ * For PREEMPT=y kernels, there will be some additional cost.
+ *
+ * If MERGE_OWNER_INTO_COUNT isn't defined, we don't need to worry
+ * about reader count overflow and so we don't need to disable
+ * preemption.
+ */
+#define rwsem_preempt_disable()			preempt_disable()
+#define rwsem_preempt_enable()			preempt_enable()
+#define rwsem_schedule_preempt_disabled()	schedule_preempt_disabled()
+
 /*
  * Get the owner value from count to have early access to the task structure.
  * Owner from sem->count should includes the RWSEM_NONSPINNABLE bits
@@ -431,6 +449,11 @@ static int __init rwsem_show_count_status(void)
 }
 late_initcall(rwsem_show_count_status);
 #else /* !MERGE_OWNER_INTO_COUNT */
+
+#define rwsem_preempt_disable()
+#define rwsem_preempt_enable()
+#define rwsem_schedule_preempt_disabled()	schedule()
+
 static inline struct task_struct *rwsem_get_owner(struct rw_semaphore *sem)
 {
 	return READ_ONCE(sem->owner);
@@ -1255,7 +1278,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state, long adjustment)
 			raw_spin_unlock_irq(&sem->wait_lock);
 			break;
 		}
-		schedule();
+		rwsem_schedule_preempt_disabled();
 		lockevent_inc(rwsem_sleep_reader);
 	}
 
@@ -1486,28 +1509,36 @@ static struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem)
  */
 inline void __down_read(struct rw_semaphore *sem)
 {
-	long tmp, adjustment = rwsem_read_trylock(sem, &tmp);
+	long tmp, adjustment;
 
+	rwsem_preempt_disable();
+	adjustment = rwsem_read_trylock(sem, &tmp);
 	if (unlikely(tmp & RWSEM_READ_FAILED_MASK)) {
 		rwsem_down_read_slowpath(sem, TASK_UNINTERRUPTIBLE, adjustment);
 		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
 	} else {
 		rwsem_set_reader_owned(sem);
 	}
+	rwsem_preempt_enable();
 }
 
 static inline int __down_read_killable(struct rw_semaphore *sem)
 {
-	long tmp, adjustment = rwsem_read_trylock(sem, &tmp);
+	long tmp, adjustment;
 
+	rwsem_preempt_disable();
+	adjustment = rwsem_read_trylock(sem, &tmp);
 	if (unlikely(tmp & RWSEM_READ_FAILED_MASK)) {
 		if (IS_ERR(rwsem_down_read_slowpath(sem, TASK_KILLABLE,
-						    adjustment)))
+						    adjustment))) {
+			rwsem_preempt_enable();
 			return -EINTR;
+		}
 		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
 	} else {
 		rwsem_set_reader_owned(sem);
 	}
+	rwsem_preempt_enable();
 	return 0;
 }
 
-- 
2.18.1

