Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580A8C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2734B2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369784;
	bh=kCVN6nSKa5vON9Fhi4l0oXnAHt5l1l+fKjeUX1kMFTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vvQmJGCZy8QL3fn3gELcQTxDUYS4bsFSOJgFYYcrvMuz2YkxKtXKUcq2f1TgsftHO
	 +mP4hAPrp9DlgwfYLD/7PNfsGO4w73+IzD5NMQydO1fm15g1FYcXQM9JxnCbdLsLko
	 oNDThpZVSCen+F9BcQRe+V/RwVau9y2u/oGU15xc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388157AbfDDJW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:22:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:56850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387693AbfDDJPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:15:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CD552075E;
        Thu,  4 Apr 2019 09:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369344;
        bh=kCVN6nSKa5vON9Fhi4l0oXnAHt5l1l+fKjeUX1kMFTs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hnowGBfQdLlQWWfEwugCRm/4sdbBAmKJPv+1OL7EafHD/RRFpX/pWOXW+hQ68VHiD
         6AmxzhRte9JExWF+oyOJF/KIyjLde2/CWYfVG64mIC66R4664uzDssaRjocAb8rpyM
         MsDuwo2tr5n8rX0bsQKKV7ugN/9KddjxpsxGyuz8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Galbraith <efault@gmx.de>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 176/246] sched/core: Use READ_ONCE()/WRITE_ONCE() in move_queued_task()/task_rq_lock()
Date:   Thu,  4 Apr 2019 10:47:56 +0200
Message-Id: <20190404084625.341155513@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

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



