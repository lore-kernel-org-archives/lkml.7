Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF69C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD67E2147C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553714348;
	bh=E+cAm8yZUEoE7KUHNxaVBFmrPnH+eB+CGfQ2NtonmwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QOWqWPdJwXJ0Kj3+K19r00jxl8YA/5+sKAwbiOYYnrjAxt+LggNgmU0tRTGw2v+QK
	 XuPvQssN+4FGr5ixV+nZuGk12K+Kh4csmtbqJIq24yTLrfKVq3RaXlrFN6jqWykyuB
	 g59AN0BsFdAPOsOgrGQSI/VgHN9LY8FrN1DAOSPk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388585AbfC0TTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:19:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:49908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388270AbfC0SH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:07:59 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22E9721734;
        Wed, 27 Mar 2019 18:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710077;
        bh=E+cAm8yZUEoE7KUHNxaVBFmrPnH+eB+CGfQ2NtonmwE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B5rewxu5Q9Y+1qsuVOgQ8Qf7XAlqXZGCW0cUtNY0+Ls/FfYPQNLsBTkA7N4Q7Rxlp
         1wuxEHDmHQYDCqupl+Lr023VSxTvWk47akoz1xJbf7YJeC7FDRXIYlPy+mmeFwozbO
         dZVqiHG1Aakrpdi8hum6QE3XQRwevN/LkU0tJX5I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Galbraith <efault@gmx.de>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 187/262] sched/core: Use READ_ONCE()/WRITE_ONCE() in move_queued_task()/task_rq_lock()
Date:   Wed, 27 Mar 2019 14:00:42 -0400
Message-Id: <20190327180158.10245-187-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Parri <andrea.parri@amarulasolutions.com>

[ Upstream commit c546951d9c9300065bad253ecdf1ac59ce9d06c8 ]

move_queued_task() synchronizes with task_rq_lock() as follows:

	move_queued_task()		task_rq_lock()

	[S] ->on_rq = MIGRATING		[L] rq = task_rq()
	WMB (__set_task_cpu())		ACQUIRE (rq->lock);
	[S] ->cpu = new_cpu		[L] ->on_rq

where "[L] rq = task_rq()" is ordered before "ACQUIRE (rq->lock)" by an
address dependency and, in turn, "ACQUIRE (rq->lock)" is ordered before
"[L] ->on_rq" by the ACQUIRE itself.

Use READ_ONCE() to load ->cpu in task_rq() (c.f., task_cpu()) to honor
this address dependency.  Also, mark the accesses to ->cpu and ->on_rq
with READ_ONCE()/WRITE_ONCE() to comply with the LKMM.

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Paul E. McKenney <paulmck@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Link: https://lkml.kernel.org/r/20190121155240.27173-1-andrea.parri@amarulasolutions.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sched.h | 4 ++--
 kernel/sched/core.c   | 9 +++++----
 kernel/sched/sched.h  | 6 +++---
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index f9b43c989577..9b35aff09f70 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1748,9 +1748,9 @@ static __always_inline bool need_resched(void)
 static inline unsigned int task_cpu(const struct task_struct *p)
 {
 #ifdef CONFIG_THREAD_INFO_IN_TASK
-	return p->cpu;
+	return READ_ONCE(p->cpu);
 #else
-	return task_thread_info(p)->cpu;
+	return READ_ONCE(task_thread_info(p)->cpu);
 #endif
 }
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d8d76a65cfdd..01a2489de94e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -107,11 +107,12 @@ struct rq *task_rq_lock(struct task_struct *p, struct rq_flags *rf)
 		 *					[L] ->on_rq
 		 *	RELEASE (rq->lock)
 		 *
-		 * If we observe the old CPU in task_rq_lock, the acquire of
+		 * If we observe the old CPU in task_rq_lock(), the acquire of
 		 * the old rq->lock will fully serialize against the stores.
 		 *
-		 * If we observe the new CPU in task_rq_lock, the acquire will
-		 * pair with the WMB to ensure we must then also see migrating.
+		 * If we observe the new CPU in task_rq_lock(), the address
+		 * dependency headed by '[L] rq = task_rq()' and the acquire
+		 * will pair with the WMB to ensure we then also see migrating.
 		 */
 		if (likely(rq == task_rq(p) && !task_on_rq_migrating(p))) {
 			rq_pin_lock(rq, rf);
@@ -928,7 +929,7 @@ static struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
 {
 	lockdep_assert_held(&rq->lock);
 
-	p->on_rq = TASK_ON_RQ_MIGRATING;
+	WRITE_ONCE(p->on_rq, TASK_ON_RQ_MIGRATING);
 	dequeue_task(rq, p, DEQUEUE_NOCLOCK);
 	set_task_cpu(p, new_cpu);
 	rq_unlock(rq, rf);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d04530bf251f..425a5589e5f6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1460,9 +1460,9 @@ static inline void __set_task_cpu(struct task_struct *p, unsigned int cpu)
 	 */
 	smp_wmb();
 #ifdef CONFIG_THREAD_INFO_IN_TASK
-	p->cpu = cpu;
+	WRITE_ONCE(p->cpu, cpu);
 #else
-	task_thread_info(p)->cpu = cpu;
+	WRITE_ONCE(task_thread_info(p)->cpu, cpu);
 #endif
 	p->wake_cpu = cpu;
 #endif
@@ -1563,7 +1563,7 @@ static inline int task_on_rq_queued(struct task_struct *p)
 
 static inline int task_on_rq_migrating(struct task_struct *p)
 {
-	return p->on_rq == TASK_ON_RQ_MIGRATING;
+	return READ_ONCE(p->on_rq) == TASK_ON_RQ_MIGRATING;
 }
 
 /*
-- 
2.19.1

