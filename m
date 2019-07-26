Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EE9C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 16:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A81021901
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 16:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pha/+B/m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbfGZQVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 12:21:06 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57072 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728606AbfGZQUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 12:20:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JXvlIC4u4F2IkNU/GkwEGhYaRWxhelNM+5dXTenAYmE=; b=pha/+B/mvy8eksAFgaeU6jUHAq
        D9ts31kx2sujmMlOjBsiDhd7pJIGRGhfRX5yOP5NtHRNRApwdPkOPt63HCbGimu5We8Fzol4WqoBX
        Xs3MqNKGfH7xQiSP76X7KLKvAtRNAn+YOJXMxgwYvp/z82bvXh6lZ+RB4Z92Mu8jNt7ZXqDBnmSvQ
        8HOqJpq0kSqNWnplDm0cbctNA+IxdFyORPGZvdloMYcEgmlvh/aBTGXvUzqDOEkR1fVdXJzUl6GWe
        ZKEwycH7D9PBRsIJYF3WAAXNbS1UbMM3bG6lmwXqcKsVWuEqv2863znKyUokx153k9k2Dwkc48Qfl
        9FWDM0kg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hr2wy-00066U-Vd; Fri, 26 Jul 2019 16:20:09 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5442620229752; Fri, 26 Jul 2019 18:20:05 +0200 (CEST)
Message-Id: <20190726161357.696559863@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 26 Jul 2019 16:54:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, juri.lelli@redhat.com
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        luca.abeni@santannapisa.it, bristot@redhat.com,
        balsini@android.com, dvyukov@google.com, tglx@linutronix.de,
        vpillai@digitalocean.com, rostedt@goodmis.org, peterz@infradead.org
Subject: [RFC][PATCH 06/13] sched/fair: Export newidle_balance()
References: <20190726145409.947503076@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For pick_next_task_fair() it is the newidle balance that requires
dropping the rq->lock; provided we do put_prev_task() early, we can
also detect the condition for doing newidle early.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c  |   18 ++++++++----------
 kernel/sched/sched.h |    4 ++++
 2 files changed, 12 insertions(+), 10 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3635,8 +3635,6 @@ static inline unsigned long cfs_rq_load_
 	return cfs_rq->avg.load_avg;
 }
 
-static int idle_balance(struct rq *this_rq, struct rq_flags *rf);
-
 static inline unsigned long task_util(struct task_struct *p)
 {
 	return READ_ONCE(p->se.avg.util_avg);
@@ -6848,11 +6846,10 @@ done: __maybe_unused;
 	return p;
 
 idle:
-	update_misfit_status(NULL, rq);
-	new_tasks = idle_balance(rq, rf);
+	new_tasks = newidle_balance(rq, rf);
 
 	/*
-	 * Because idle_balance() releases (and re-acquires) rq->lock, it is
+	 * Because newidle_balance() releases (and re-acquires) rq->lock, it is
 	 * possible for any higher priority task to appear. In that case we
 	 * must re-start the pick_next_entity() loop.
 	 */
@@ -9016,10 +9013,10 @@ static int load_balance(int this_cpu, st
 	ld_moved = 0;
 
 	/*
-	 * idle_balance() disregards balance intervals, so we could repeatedly
-	 * reach this code, which would lead to balance_interval skyrocketting
-	 * in a short amount of time. Skip the balance_interval increase logic
-	 * to avoid that.
+	 * newidle_balance() disregards balance intervals, so we could
+	 * repeatedly reach this code, which would lead to balance_interval
+	 * skyrocketting in a short amount of time. Skip the balance_interval
+	 * increase logic to avoid that.
 	 */
 	if (env.idle == CPU_NEWLY_IDLE)
 		goto out;
@@ -9729,7 +9726,7 @@ static inline void nohz_newidle_balance(
  * idle_balance is called by schedule() if this_cpu is about to become
  * idle. Attempts to pull tasks from other CPUs.
  */
-static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
+int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 {
 	unsigned long next_balance = jiffies + HZ;
 	int this_cpu = this_rq->cpu;
@@ -9737,6 +9734,7 @@ static int idle_balance(struct rq *this_
 	int pulled_task = 0;
 	u64 curr_cost = 0;
 
+	update_misfit_status(NULL, this_rq);
 	/*
 	 * We must set idle_stamp _before_ calling idle_balance(), such that we
 	 * measure the duration of idle_balance() as idle time.
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1449,10 +1449,14 @@ static inline void unregister_sched_doma
 }
 #endif
 
+extern int newidle_balance(struct rq *this_rq, struct rq_flags *rf);
+
 #else
 
 static inline void sched_ttwu_pending(void) { }
 
+static inline int newidle_balance(struct rq *this_rq, struct rq_flags *rf) { return 0; }
+
 #endif /* CONFIG_SMP */
 
 #include "stats.h"


