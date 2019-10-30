Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB6BCA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 13:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6364C2080F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 13:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OgLOifYK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfJ3Nbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 09:31:36 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50996 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfJ3Nbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 09:31:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3dQu/Y6BQBuqx+sqo4SkSkjd36H/g8qFYAZTXsAn2dY=; b=OgLOifYK4kO/IJpwyhCg56W95
        7OQC8zDdqiPFbXoV1I0m2pvk9HPGjXMRlrNVcBqniJco1ijlN29kcfk2HG3GtHmFnZrLG9xSqK1EH
        AihntLS88LMv65kLnSmytxJ1iTTLgXaAjzxfiIzG6/t/W8GlCJCD1GBOXlu498ORMVed1wuFsRTjh
        gs2hck+HN+eSMqwnk3GNn5D6CySv4qdDc8Nop5i3Ikh9CPr7T4pZA/NS7xj5HXd64fW8VweyLA1Mk
        W6nT1tCgtrRsXcjoviikbqgoatIUvDY/3gPrbbkceQRu804MilS8gdxC1kCDCO7I/0CyIJrIJ+XgP
        yefX6oKDw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iPo4S-0004yA-Jc; Wed, 30 Oct 2019 13:31:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 67647300596;
        Wed, 30 Oct 2019 14:30:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 916B32B4032A2; Wed, 30 Oct 2019 14:31:30 +0100 (CET)
Date:   Wed, 30 Oct 2019 14:31:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Scott Wood <swood@redhat.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] timers/nohz: Update nohz load even if tick already
 stopped
Message-ID: <20191030133130.GY4097@hirez.programming.kicks-ass.net>
References: <20191028150716.22890-1-frederic@kernel.org>
 <20191029100506.GJ4114@hirez.programming.kicks-ass.net>
 <52d963553deda810113accd8d69b6dffdb37144f.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52d963553deda810113accd8d69b6dffdb37144f.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 03:48:26AM -0500, Scott Wood wrote:
> On Tue, 2019-10-29 at 11:05 +0100, Peter Zijlstra wrote:

> > @@ -3686,6 +3688,7 @@ static void sched_tick_remote(struct work_struct
> > *work)
> >  	curr->sched_class->task_tick(rq, curr, 0);
> >  
> >  out_unlock:
> > +	calc_load_nohz_remote(cpu);
> >  	rq_unlock_irq(rq, &rf);
> 
> This gets skipped when the cpu is idle, so it still misses the update.

Oh argh! that's a bit radical of the remote tick. The normal tick runs
just fine on idle CPUs, so lets mirror that.

How's this then?

---
diff --git a/include/linux/sched/nohz.h b/include/linux/sched/nohz.h
index 1abe91ff6e4a..6d67e9a5af6b 100644
--- a/include/linux/sched/nohz.h
+++ b/include/linux/sched/nohz.h
@@ -15,9 +15,11 @@ static inline void nohz_balance_enter_idle(int cpu) { }
 
 #ifdef CONFIG_NO_HZ_COMMON
 void calc_load_nohz_start(void);
+void calc_load_nohz_remote(struct rq *rq);
 void calc_load_nohz_stop(void);
 #else
 static inline void calc_load_nohz_start(void) { }
+static inline void calc_load_nohz_remote(struct rq *rq) { }
 static inline void calc_load_nohz_stop(void) { }
 #endif /* CONFIG_NO_HZ_COMMON */
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index eb42b71faab9..d02d1b8f40af 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3660,21 +3660,17 @@ static void sched_tick_remote(struct work_struct *work)
 	u64 delta;
 	int os;
 
-	/*
-	 * Handle the tick only if it appears the remote CPU is running in full
-	 * dynticks mode. The check is racy by nature, but missing a tick or
-	 * having one too much is no big deal because the scheduler tick updates
-	 * statistics and checks timeslices in a time-independent way, regardless
-	 * of when exactly it is running.
-	 */
-	if (idle_cpu(cpu) || !tick_nohz_tick_stopped_cpu(cpu))
+	if (!tick_nohz_tick_stopped_cpu(cpu))
 		goto out_requeue;
 
 	rq_lock_irq(rq, &rf);
-	curr = rq->curr;
-	if (is_idle_task(curr) || cpu_is_offline(cpu))
+	/*
+	 * We must not call calc_load_nohz_remote() when not in NOHZ mode.
+	 */
+	if (cpu_is_offline(cpu) || !tick_nohz_tick_stopped(cpu))
 		goto out_unlock;
 
+	curr = rq->curr;
 	update_rq_clock(rq);
 	delta = rq_clock_task(rq) - curr->se.exec_start;
 
@@ -3685,10 +3681,11 @@ static void sched_tick_remote(struct work_struct *work)
 	WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3);
 	curr->sched_class->task_tick(rq, curr, 0);
 
+	calc_load_nohz_remote(rq);
 out_unlock:
 	rq_unlock_irq(rq, &rf);
-
 out_requeue:
+
 	/*
 	 * Run the remote tick once per second (1Hz). This arbitrary
 	 * frequency is large enough to avoid overload but short enough
diff --git a/kernel/sched/loadavg.c b/kernel/sched/loadavg.c
index 28a516575c18..de22da666ac7 100644
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
 
@@ -248,6 +243,24 @@ void calc_load_nohz_start(void)
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
+/*
+ * Keep track of the load for NOHZ_FULL, must be called between
+ * calc_load_nohz_{start,stop}().
+ */
+void calc_load_nohz_remote(struct rq *rq)
+{
+	calc_load_nohz_fold(rq);
+}
+
 void calc_load_nohz_stop(void)
 {
 	struct rq *this_rq = this_rq();
@@ -268,7 +281,7 @@ void calc_load_nohz_stop(void)
 		this_rq->calc_load_update += LOAD_FREQ;
 }
 
-static long calc_load_nohz_fold(void)
+static long calc_load_nohz_read(void)
 {
 	int idx = calc_load_read_idx();
 	long delta = 0;
@@ -323,7 +336,7 @@ static void calc_global_nohz(void)
 }
 #else /* !CONFIG_NO_HZ_COMMON */
 
-static inline long calc_load_nohz_fold(void) { return 0; }
+static inline long calc_load_nohz_read(void) { return 0; }
 static inline void calc_global_nohz(void) { }
 
 #endif /* CONFIG_NO_HZ_COMMON */
@@ -346,7 +359,7 @@ void calc_global_load(unsigned long ticks)
 	/*
 	 * Fold the 'old' NO_HZ-delta to include all NO_HZ CPUs.
 	 */
-	delta = calc_load_nohz_fold();
+	delta = calc_load_nohz_read();
 	if (delta)
 		atomic_long_add(delta, &calc_load_tasks);
 
