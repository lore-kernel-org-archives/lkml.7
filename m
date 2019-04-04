Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33887C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0007F205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554370654;
	bh=+99nPX0BD/OKqi6HTdELshrGt916SX9sHcTiExDomOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iQik7tIDgFXYvd3jN1X3YkxVLaW8b9TVSs6Q8rC4SBvMRBT7T9DQ2qFo7kSCnyOJe
	 N2I42kKwKWy11u6IZwJkP1Hg6Ndf+B/N4rJuRRPtWvYVnVS4i/7srO7LIYfeMy+nMu
	 UE2EuSVhJd9IymhESbu3emEfr7rMXnGhiy47mdt8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732323AbfDDJhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:37:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731812AbfDDJEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:04:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7E2F2183E;
        Thu,  4 Apr 2019 09:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368693;
        bh=+99nPX0BD/OKqi6HTdELshrGt916SX9sHcTiExDomOE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zd9QcPWItKV6hANcw1YpsCiWkQwuAZARiY6leiUsggyQRyyIUGtSLBVNDNJs+qNkG
         SN1EOT3e7/UdxGkZycr2PH//Dy/EFNaVo1pdR0x8cTr+rEUbo3hQbXjRKpm9D2i+fO
         f4SnG56aRINyWXJyHS8oAD0MUpFgB/M9g57zCbb4=
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
Subject: [PATCH 4.19 134/187] sched/core: Use READ_ONCE()/WRITE_ONCE() in move_queued_task()/task_rq_lock()
Date:   Thu,  4 Apr 2019 10:47:51 +0200
Message-Id: <20190404084609.508910932@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index 4abb5bd74b04..5dc024e28397 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1737,9 +1737,9 @@ static __always_inline bool need_resched(void)
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
index 152a0b0c91bb..9a4f57d7e931 100644
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
@@ -910,7 +911,7 @@ static struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
 {
 	lockdep_assert_held(&rq->lock);
 
-	p->on_rq = TASK_ON_RQ_MIGRATING;
+	WRITE_ONCE(p->on_rq, TASK_ON_RQ_MIGRATING);
 	dequeue_task(rq, p, DEQUEUE_NOCLOCK);
 	set_task_cpu(p, new_cpu);
 	rq_unlock(rq, rf);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b63172288f7b..4c7a837d7c14 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1331,9 +1331,9 @@ static inline void __set_task_cpu(struct task_struct *p, unsigned int cpu)
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
@@ -1434,7 +1434,7 @@ static inline int task_on_rq_queued(struct task_struct *p)
 
 static inline int task_on_rq_migrating(struct task_struct *p)
 {
-	return p->on_rq == TASK_ON_RQ_MIGRATING;
+	return READ_ONCE(p->on_rq) == TASK_ON_RQ_MIGRATING;
 }
 
 /*
-- 
2.19.1



