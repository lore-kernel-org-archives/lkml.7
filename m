Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF560FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC9A2178F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J30OBU3o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbfKHNVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 08:21:36 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59258 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727909AbfKHNVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 08:21:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ou1/q/XFb8Q6EtgkQzG/LRw+uiS404KsbseaotfbGPs=; b=J30OBU3o8X20gu3Ploi15U/JJe
        KTlxm5X72dOR21KiqSlOUoQRflMi8Rd6L9zWOd5jnxY7IdNNEn5dCRRCWR8RF8mC4emlSSYtPflbq
        0rZ3paDgKUNgTRzqtVRZ2JGC5LS0KIwH53Q6mZzSywiT8VCeWSEj/7B7bQ6uGYW0PAWlQRf4hk+mb
        dyzo813Avyfn+XUE+stkE00XffOJXU/IL/zO+5XhXQG8hygutLnYYEvcOUKSkbEy2g2zMajUw0+Qb
        wd3FhmyWPrqQNo57Aip/K50PINoqyWBCvkVCErXPLyVaoW6dg3I+sW/tfVIWIsxTJAhZE3o/pviqv
        umYUCDAg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iT4Ca-0006lQ-KB; Fri, 08 Nov 2019 13:21:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 582E4305FC2;
        Fri,  8 Nov 2019 14:20:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4BC5220C10EBB; Fri,  8 Nov 2019 14:21:20 +0100 (CET)
Message-Id: <20191108131909.603037345@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 08 Nov 2019 14:15:57 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, qperret@google.com,
        valentin.schneider@arm.com, qais.yousef@arm.com,
        ktkhai@virtuozzo.com, peterz@infradead.org
Subject: [PATCH 4/7] sched: Optimize pick_next_task()
References: <20191108131553.027892369@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ever since we moved the sched_class defenitions into their own files,
the constant expression {fair,idle}_sched_class.pick_next_task() is
not in fact a compile time constant anymore and results in an indirect
call (barring LTO).

Fix that by exposing pick_next_task_{fair,idle}() directly, this gets
rid of the indirect call (and RETPOLINE) on the fast path.

Also remove the unlikely() from the idle case, it is in fact /the/ way
we select idle -- and that is a very common thing to do.

Performance for will-it-scale/sched_yield improves by 2% (as reported
by 0-day).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c  |    6 +++---
 kernel/sched/fair.c  |    2 +-
 kernel/sched/idle.c  |    2 +-
 kernel/sched/sched.h |    3 +++
 4 files changed, 8 insertions(+), 5 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3917,14 +3917,14 @@ pick_next_task(struct rq *rq, struct tas
 		    prev->sched_class == &fair_sched_class) &&
 		   rq->nr_running == rq->cfs.h_nr_running)) {
 
-		p = fair_sched_class.pick_next_task(rq, prev, rf);
+		p = pick_next_task_fair(rq, prev, rf);
 		if (unlikely(p == RETRY_TASK))
 			goto restart;
 
 		/* Assumes fair_sched_class->next == idle_sched_class */
-		if (unlikely(!p)) {
+		if (!p) {
 			put_prev_task(rq, prev);
-			p = idle_sched_class.pick_next_task(rq, NULL, NULL);
+			p = pick_next_task_idle(rq, NULL, NULL);
 		}
 
 		return p;
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6599,7 +6599,7 @@ static void check_preempt_wakeup(struct
 		set_last_buddy(se);
 }
 
-static struct task_struct *
+struct task_struct *
 pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
 	struct cfs_rq *cfs_rq = &rq->cfs;
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -391,7 +391,7 @@ static void set_next_task_idle(struct rq
 	schedstat_inc(rq->sched_goidle);
 }
 
-static struct task_struct *
+struct task_struct *
 pick_next_task_idle(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
 	struct task_struct *next = rq->idle;
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1821,6 +1821,9 @@ static inline bool sched_fair_runnable(s
 	return rq->cfs.nr_running > 0;
 }
 
+extern struct task_struct *pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
+extern struct task_struct *pick_next_task_idle(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
+
 #ifdef CONFIG_SMP
 
 extern void update_group_capacity(struct sched_domain *sd, int cpu);


