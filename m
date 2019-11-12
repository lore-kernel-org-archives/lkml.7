Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33439C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 10:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07765214E0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 10:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="azhyGPst"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfKLKvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 05:51:52 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57312 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfKLKvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 05:51:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fQPGWUIEjEA8RFpXlmD09Q56VRgX4CJvKk1Wqfm2t+Q=; b=azhyGPstkyQQHDc34tr07wjHs
        VyIIo3De+Ksh3p9EmrafDDMx3RWFFNEZf1k6KvEaAsdIqdXuX9jMq8sWPcO4azAIiPTu9yRbYoCE3
        g57QW00m9dpw3VmbSZHMsvqnOaJUjKQggrwVkCY7kn2cwsjyFBtMLj33DCNfQqYDXFAxguZPJ2owt
        s2XuHj176nY1CqOcpYUrE7qioIS09ZvqfVkjEtKs64gUnd1W+bY0ZNS5QPG7XVnPkMCDqki/tXDTV
        roXQMO5LlRBeupxNXhIX5erxgPW511H6G+e74T15DFEs6zVsHrrEzvRGh0PNazhibUHkEXyQztqwl
        qQ0Ramc2A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUTlm-0001ph-4Y; Tue, 12 Nov 2019 10:51:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EDACA3056BE;
        Tue, 12 Nov 2019 11:50:23 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AD2C729A31BB7; Tue, 12 Nov 2019 11:51:30 +0100 (CET)
Date:   Tue, 12 Nov 2019 11:51:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     mingo@redhat.com, glenn@aurora.tech, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, tglx@linutronix.de,
        luca.abeni@santannapisa.it, c.scordino@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, bristot@redhat.com
Subject: Re: [PATCH 2/2] sched/deadline: Temporary copy static parameters to
 boosted non-DEADLINE entities
Message-ID: <20191112105130.GZ4131@hirez.programming.kicks-ass.net>
References: <20191112075056.19971-1-juri.lelli@redhat.com>
 <20191112075056.19971-3-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112075056.19971-3-juri.lelli@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 08:50:56AM +0100, Juri Lelli wrote:
> Boosted entities (Priority Inheritance) use static DEADLINE parameters
> of the top priority waiter. However, there might be cases where top
> waiter could be a non-DEADLINE entity that is currently boosted by a
> DEADLINE entity from a different lock chain (i.e., nested priority
> chains involving entities of non-DEADLINE classes). In this case, top
> waiter static DEADLINE parameters could null (initialized to 0 at
> fork()) and replenish_dl_entity() would hit a BUG().

Argh!

> Fix this by temporarily copying static DEADLINE parameters of top
> DEADLINE waiter (there must be at least one in the chain(s) for the
> problem above to happen) into boosted entities. Parameters are reset
> during deboost.

Also, yuck!

> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4441,19 +4441,21 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
>  		if (!dl_prio(p->normal_prio) ||
>  		    (pi_task && dl_entity_preempt(&pi_task->dl, &p->dl))) {
>  			p->dl.dl_boosted = 1;
> +			if (!dl_prio(p->normal_prio))
> +				__dl_copy_static(p, pi_task);
>  			queue_flag |= ENQUEUE_REPLENISH;
>  		} else
>  			p->dl.dl_boosted = 0;
>  		p->sched_class = &dl_sched_class;

So I thought our basic approach was deadline inheritance and screw
runtime accounting.

Given that, I don't quite understand the REPLENISH hack there. Should we
not simply copy dl->deadline around (and restore on unboost)?

That is, should we not do something 'simple' like this:


diff --git a/include/linux/sched.h b/include/linux/sched.h
index 84b26d38c929..1579c571cb83 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -522,6 +522,7 @@ struct sched_dl_entity {
 	 */
 	s64				runtime;	/* Remaining runtime for this instance	*/
 	u64				deadline;	/* Absolute deadline for this instance	*/
+	u64				normal_deadline;
 	unsigned int			flags;		/* Specifying the scheduler behaviour	*/
 
 	/*
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 26e4ffa01e7a..16164b0ba80b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4452,9 +4452,11 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 		if (!dl_prio(p->normal_prio) ||
 		    (pi_task && dl_entity_preempt(&pi_task->dl, &p->dl))) {
 			p->dl.dl_boosted = 1;
-			queue_flag |= ENQUEUE_REPLENISH;
-		} else
+			p->dl.deadline = pi_task->dl.deadline;
+		} else {
 			p->dl.dl_boosted = 0;
+			p->dl.deadline = p->dl.normal_deadline;
+		}
 		p->sched_class = &dl_sched_class;
 	} else if (rt_prio(prio)) {
 		if (dl_prio(oldprio))
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 43323f875cb9..0ad7c2797f11 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -674,6 +674,7 @@ static inline void setup_new_dl_entity(struct sched_dl_entity *dl_se)
 	 * spent on hardirq context, etc.).
 	 */
 	dl_se->deadline = rq_clock(rq) + dl_se->dl_deadline;
+	dl_se->normal_deadline = dl_se->deadline;
 	dl_se->runtime = dl_se->dl_runtime;
 }
 
@@ -709,6 +710,7 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se,
 	 */
 	if (dl_se->dl_deadline == 0) {
 		dl_se->deadline = rq_clock(rq) + pi_se->dl_deadline;
+		dl_se->normal_deadline = dl_se->deadline;
 		dl_se->runtime = pi_se->dl_runtime;
 	}
 
@@ -723,6 +725,7 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se,
 	 */
 	while (dl_se->runtime <= 0) {
 		dl_se->deadline += pi_se->dl_period;
+		dl_se->normal_deadline = dl_se->normal;
 		dl_se->runtime += pi_se->dl_runtime;
 	}
 
@@ -738,6 +741,7 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se,
 	if (dl_time_before(dl_se->deadline, rq_clock(rq))) {
 		printk_deferred_once("sched: DL replenish lagged too much\n");
 		dl_se->deadline = rq_clock(rq) + pi_se->dl_deadline;
+		dl_se->normal_deadline = dl_se->deadline;
 		dl_se->runtime = pi_se->dl_runtime;
 	}
 
@@ -898,6 +902,7 @@ static void update_dl_entity(struct sched_dl_entity *dl_se,
 		}
 
 		dl_se->deadline = rq_clock(rq) + pi_se->dl_deadline;
+		dl_se->normal_deadline = dl_se->deadline;
 		dl_se->runtime = pi_se->dl_runtime;
 	}
 }
