Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B496DC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 16:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A10E214C6
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 16:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lW0P4Igw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbfGZQVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 12:21:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52116 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728500AbfGZQU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 12:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=95pGL7jjUOOxBXZwzIrRwxWHix+QdRjTYhrRFgJeGAE=; b=lW0P4IgwJSpIMH+CtjZIBbh5Ol
        W3QZ675EPpcqq3O8Yj4gawrMOD46OGwD5WszAWU7y/Fb1OOxxWiOjLr2a66gOsZO3tV3GNvqvyx4S
        ecszOZNkbi49XH+rr0dP+jA4QxRvriP5eoaWBtRrJ3r5+D5N05KV8cVDk63euz9e4WW+g2myG88bD
        WMbDLCIkVpgl1nFVlBNrt2kIx8Ci/iCw2uLaPcIsSICdCoIZXK1Y8DQyTlSvVMMpipHmR1UW4OsHq
        hmb/cjhRscSI4YC0HwwVPnaP/M6UQ5mtT63DVIPyy2CS1iqzUd3HSnM1HLaoQT06oVUJjKGwwHLVV
        hYecDznQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hr2x0-00072G-0X; Fri, 26 Jul 2019 16:20:10 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 64A5A20229756; Fri, 26 Jul 2019 18:20:05 +0200 (CEST)
Message-Id: <20190726161357.941355615@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 26 Jul 2019 16:54:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, juri.lelli@redhat.com
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        luca.abeni@santannapisa.it, bristot@redhat.com,
        balsini@android.com, dvyukov@google.com, tglx@linutronix.de,
        vpillai@digitalocean.com, rostedt@goodmis.org, peterz@infradead.org
Subject: [RFC][PATCH 10/13] sched/deadline: Collect sched_dl_entity initialization
References: <20190726145409.947503076@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a single function that initializes a sched_dl_entity.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c     |    5 +----
 kernel/sched/deadline.c |   22 +++++++++++++++-------
 kernel/sched/sched.h    |    6 ++----
 3 files changed, 18 insertions(+), 15 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2581,10 +2581,7 @@ static void __sched_fork(unsigned long c
 	memset(&p->se.statistics, 0, sizeof(p->se.statistics));
 #endif
 
-	RB_CLEAR_NODE(&p->dl.rb_node);
-	init_dl_task_timer(&p->dl);
-	init_dl_inactive_task_timer(&p->dl);
-	__dl_clear_params(p);
+	init_dl_entity(&p->dl);
 
 	INIT_LIST_HEAD(&p->rt.run_list);
 	p->rt.timeout		= 0;
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -180,6 +180,8 @@ void dl_change_utilization(struct task_s
 	__add_rq_bw(new_bw, &rq->dl);
 }
 
+static void __dl_clear_params(struct sched_dl_entity *dl_se);
+
 /*
  * The utilization of a task cannot be immediately removed from
  * the rq active utilization (running_bw) when the task blocks.
@@ -278,7 +280,7 @@ static void task_non_contending(struct t
 				sub_rq_bw(&p->dl, &rq->dl);
 			raw_spin_lock(&dl_b->lock);
 			__dl_sub(dl_b, p->dl.dl_bw, dl_bw_cpus(task_cpu(p)));
-			__dl_clear_params(p);
+			__dl_clear_params(dl_se);
 			raw_spin_unlock(&dl_b->lock);
 		}
 
@@ -1049,7 +1051,7 @@ static enum hrtimer_restart dl_task_time
 	return HRTIMER_NORESTART;
 }
 
-void init_dl_task_timer(struct sched_dl_entity *dl_se)
+static void init_dl_task_timer(struct sched_dl_entity *dl_se)
 {
 	struct hrtimer *timer = &dl_se->dl_timer;
 
@@ -1261,7 +1263,7 @@ static enum hrtimer_restart inactive_tas
 		raw_spin_lock(&dl_b->lock);
 		__dl_sub(dl_b, p->dl.dl_bw, dl_bw_cpus(task_cpu(p)));
 		raw_spin_unlock(&dl_b->lock);
-		__dl_clear_params(p);
+		__dl_clear_params(dl_se);
 
 		goto unlock;
 	}
@@ -1277,7 +1279,7 @@ static enum hrtimer_restart inactive_tas
 	return HRTIMER_NORESTART;
 }
 
-void init_dl_inactive_task_timer(struct sched_dl_entity *dl_se)
+static void init_dl_inactive_task_timer(struct sched_dl_entity *dl_se)
 {
 	struct hrtimer *timer = &dl_se->inactive_timer;
 
@@ -2633,10 +2635,8 @@ bool __checkparam_dl(const struct sched_
 /*
  * This function clears the sched_dl_entity static params.
  */
-void __dl_clear_params(struct task_struct *p)
+static void __dl_clear_params(struct sched_dl_entity *dl_se)
 {
-	struct sched_dl_entity *dl_se = &p->dl;
-
 	dl_se->dl_runtime		= 0;
 	dl_se->dl_deadline		= 0;
 	dl_se->dl_period		= 0;
@@ -2650,6 +2650,14 @@ void __dl_clear_params(struct task_struc
 	dl_se->dl_overrun		= 0;
 }
 
+void init_dl_entity(struct sched_dl_entity *dl_se)
+{
+	RB_CLEAR_NODE(&dl_se->rb_node);
+	init_dl_task_timer(dl_se);
+	init_dl_inactive_task_timer(dl_se);
+	__dl_clear_params(dl_se);
+}
+
 bool dl_param_changed(struct task_struct *p, const struct sched_attr *attr)
 {
 	struct sched_dl_entity *dl_se = &p->dl;
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -239,8 +239,6 @@ struct rt_bandwidth {
 	unsigned int		rt_period_active;
 };
 
-void __dl_clear_params(struct task_struct *p);
-
 /*
  * To keep the bandwidth of -deadline tasks and groups under control
  * we need some place where:
@@ -1844,10 +1842,10 @@ extern void init_rt_bandwidth(struct rt_
 
 extern struct dl_bandwidth def_dl_bandwidth;
 extern void init_dl_bandwidth(struct dl_bandwidth *dl_b, u64 period, u64 runtime);
-extern void init_dl_task_timer(struct sched_dl_entity *dl_se);
-extern void init_dl_inactive_task_timer(struct sched_dl_entity *dl_se);
 extern void init_dl_rq_bw_ratio(struct dl_rq *dl_rq);
 
+extern void init_dl_entity(struct sched_dl_entity *dl_se);
+
 #define BW_SHIFT		20
 #define BW_UNIT			(1 << BW_SHIFT)
 #define RATIO_SHIFT		8


