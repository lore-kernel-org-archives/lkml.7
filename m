Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D924ACA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 10:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB5BE2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 10:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="x7FieTAb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfJ2KFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 06:05:15 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38702 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfJ2KFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 06:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dJCDVLdqkAr+W3Koo7ilDlkhVjSvDu2e8VbFMsJFDkk=; b=x7FieTAbbc3QQFQx9uIkfh5bn
        8iBDuintK8a7REjxu9NMJX0iAZqf6RQD1aHDsBfihVCLX3iPL+gxMB1uKKAYG5cfpiSx6JAdPpVqJ
        MEon+piWO9vW2xyPJfG9VTPCRVHzHVfEKDAX5Lf9uIaVnAzsYlHnCA/ghmZCqf5OeeFmm6L3kXFP8
        UApr0iWTdzi19vRvUcyj2A5lCWDTIcmgzQPwcsLEWTgMVUi88V+PIlMc0iOiqWB1LtE30Pt/7cGg4
        EZZmjfNLqKIqo0QWsQV5yBWszoByyhwUbUEiUsf8BcVniwrkpdi05wkysKR81pcFfUlT4HJBN52yC
        F3QIde5kg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iPONC-0001ax-J8; Tue, 29 Oct 2019 10:05:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1736330025A;
        Tue, 29 Oct 2019 11:04:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BAE0420D7FEEA; Tue, 29 Oct 2019 11:05:06 +0100 (CET)
Date:   Tue, 29 Oct 2019 11:05:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Scott Wood <swood@redhat.com>
Subject: Re: [PATCH] timers/nohz: Update nohz load even if tick already
 stopped
Message-ID: <20191029100506.GJ4114@hirez.programming.kicks-ass.net>
References: <20191028150716.22890-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028150716.22890-1-frederic@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 04:07:16PM +0100, Frederic Weisbecker wrote:
> From: Scott Wood <swood@redhat.com>
> 
> The way loadavg is tracked during nohz only pays attention to the load
> upon entering nohz. This can be particularly noticeable if nohz is
> entered while non-idle, and then the cpu goes idle and stays that way for
> a long time. We've had reports of a loadavg near 150 on a mostly idle
> system.
> 
> Calling calc_load_nohz_start() regardless of whether the tick is already
> stopped addresses the issue when going idle. Tracking load changes when
> not going idle (e.g. multiple SCHED_FIFO tasks coming and going) is not
> addressed by this patch.

Hurph, is that phenomena you describe NOHZ or NOHZ_FULL? Because that
second thing you talk about, multiple SCHED_FIFO tasks running without a
tick is definitely NOHZ_FULL.

I'm thinking all of this is NOHZ_FULL because IIRC we always start the
tick when there is a runnable task. So your example of going idle in
NOHZ already cannot happen for regular NOHZ.

And for loadavg vs NOHZ_FULL I don't much like this patch. It ductapes
one symptom but doesn't address the actual issue. Let me go rediscover
how loadavg-nohz works again, I so hate all this crap :/

Bah, I can't get me head straight, but I'm thinking something like the
below ought to do. Does it actually work?

---
 include/linux/sched/nohz.h |  2 ++
 kernel/sched/core.c        |  3 +++
 kernel/sched/loadavg.c     | 26 +++++++++++++++++++-------
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/include/linux/sched/nohz.h b/include/linux/sched/nohz.h
index 1abe91ff6e4a..a2296004351f 100644
--- a/include/linux/sched/nohz.h
+++ b/include/linux/sched/nohz.h
@@ -16,9 +16,11 @@ static inline void nohz_balance_enter_idle(int cpu) { }
 #ifdef CONFIG_NO_HZ_COMMON
 void calc_load_nohz_start(void);
 void calc_load_nohz_stop(void);
+void calc_load_nohz_remote(int cpu);
 #else
 static inline void calc_load_nohz_start(void) { }
 static inline void calc_load_nohz_stop(void) { }
+static inline void calc_load_nohz_remote(int cpu) { }
 #endif /* CONFIG_NO_HZ_COMMON */
 
 #if defined(CONFIG_NO_HZ_COMMON) && defined(CONFIG_SMP)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index eb42b71faab9..209e50d48f80 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3666,6 +3666,8 @@ static void sched_tick_remote(struct work_struct *work)
 	 * having one too much is no big deal because the scheduler tick updates
 	 * statistics and checks timeslices in a time-independent way, regardless
 	 * of when exactly it is running.
+	 *
+	 * XXX should we be checking tick_nohz_tick_stopped_cpu() under rq->lock ?
 	 */
 	if (idle_cpu(cpu) || !tick_nohz_tick_stopped_cpu(cpu))
 		goto out_requeue;
@@ -3686,6 +3688,7 @@ static void sched_tick_remote(struct work_struct *work)
 	curr->sched_class->task_tick(rq, curr, 0);
 
 out_unlock:
+	calc_load_nohz_remote(cpu);
 	rq_unlock_irq(rq, &rf);
 
 out_requeue:
diff --git a/kernel/sched/loadavg.c b/kernel/sched/loadavg.c
index 28a516575c18..7549bd9b6853 100644
--- a/kernel/sched/loadavg.c
+++ b/kernel/sched/loadavg.c
@@ -231,16 +231,11 @@ static inline int calc_load_read_idx(void)
 	return calc_load_idx & 1;
 }
 
-void calc_load_nohz_start(void)
+static void calc_load_nohz_fold(struct rq *rq)
 {
-	struct rq *this_rq = this_rq();
 	long delta;
 
-	/*
-	 * We're going into NO_HZ mode, if there's any pending delta, fold it
-	 * into the pending NO_HZ delta.
-	 */
-	delta = calc_load_fold_active(this_rq, 0);
+	delta = calc_load_fold_active(rq, 0);
 	if (delta) {
 		int idx = calc_load_write_idx();
 
@@ -248,6 +243,23 @@ void calc_load_nohz_start(void)
 	}
 }
 
+void calc_load_nohz_start(void)
+{
+	/*
+	 * We're going into NO_HZ mode, if there's any pending delta, fold it
+	 * into the pending NO_HZ delta.
+	 */
+	calc_load_nohz_fold(this_rq());
+}
+
+void calc_load_nohz_remote(int cpu)
+{
+	/*
+	 * XXX comment goes here.
+	 */
+	calc_load_nohz_fold(cpu_rq(cpu));
+}
+
 void calc_load_nohz_stop(void)
 {
 	struct rq *this_rq = this_rq();
