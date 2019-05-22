Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C61EC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 14:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F306420863
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 14:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tRFD3Vc6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbfEVOgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 10:36:24 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49906 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728409AbfEVOgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 10:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eq/H5RwjBNHhJrA53GEHBaRmVdHWZhwfz8MzKKlljQI=; b=tRFD3Vc6RzjVeFIxqOYQ9eCA9
        lk5ZGKJR3T66Oe4phdSDDYC0jGhU2R+4DXYXdekh5ug7XUmrO7KpifaiarZ9Lc8KgP/JL/T0IMPzI
        WYTuBM/+Vt2q0PBHWl8vqzqitBgETewRNq8fGydAnurqDlBCbFlCi9FXtGQwoKTBjQJQ665IWkew9
        zVb+dFiEE7Y6NhXHyAbq/QbzQwiJsCmLGKV9Z04LRsLmPT5AZLUYMbdzIxg01o5KmvCUvOAHELq1I
        erKxqd7bBWA2C7bjAYpWiEyeJwrDhfHyuEAVvetLz7YrAYs8GO8jFLn96IghYX7IOzcqiDurNHIyl
        tfSkLjWkA==;
Received: from [31.161.185.207] (helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hTSLO-0003q5-NC; Wed, 22 May 2019 14:35:51 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 03CEC984E0B; Wed, 22 May 2019 16:35:45 +0200 (CEST)
Date:   Wed, 22 May 2019 16:35:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Viktor Rosendahl <viktor.rosendahl@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v4 1/4] ftrace: Implement fs notification for
 tracing_max_latency
Message-ID: <20190522143545.GG16275@worktop.programming.kicks-ass.net>
References: <20190521120142.186487e9@gandalf.local.home>
 <20190522003014.1359-1-viktor.rosendahl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522003014.1359-1-viktor.rosendahl@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 02:30:14AM +0200, Viktor Rosendahl wrote:

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 874c427742a9..440cd1a62722 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3374,6 +3374,7 @@ static void __sched notrace __schedule(bool preempt)
>  	struct rq *rq;
>  	int cpu;
>  
> +	trace_disable_fsnotify();
>  	cpu = smp_processor_id();
>  	rq = cpu_rq(cpu);
>  	prev = rq->curr;
> @@ -3449,6 +3450,7 @@ static void __sched notrace __schedule(bool preempt)
>  	}
>  
>  	balance_callback(rq);
> +	trace_enable_fsnotify();
>  }
>  
>  void __noreturn do_task_dead(void)
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index 80940939b733..1a38bcdb3652 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -225,6 +225,7 @@ static void cpuidle_idle_call(void)
>  static void do_idle(void)
>  {
>  	int cpu = smp_processor_id();
> +	trace_disable_fsnotify();
>  	/*
>  	 * If the arch has a polling bit, we maintain an invariant:
>  	 *
> @@ -284,6 +285,7 @@ static void do_idle(void)
>  	smp_mb__after_atomic();
>  
>  	sched_ttwu_pending();
> +	/* schedule_idle() will call trace_enable_fsnotify() */
>  	schedule_idle();
>  
>  	if (unlikely(klp_patch_pending(current)))

I still hate this.. why are we doing this? We already have this
stop_critical_timings() nonsense and are now adding more gunk.



> +static DEFINE_PER_CPU(atomic_t, notify_disabled) = ATOMIC_INIT(0);

> +	atomic_set(&per_cpu(notify_disabled, cpu), 1);

> +	atomic_set(&per_cpu(notify_disabled, cpu), 0);

> +	if (!atomic_read(&per_cpu(notify_disabled, cpu)))

That's just wrong on so many levels..
