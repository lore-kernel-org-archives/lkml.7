Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD779C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 08:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD6821670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 08:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zv8uUeiz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfD3I4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 04:56:51 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34272 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfD3I4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 04:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AYiFlKw1DfzIn8BobVsm4z2gtv05NkpPoP8jBI1+aX4=; b=zv8uUeizCdoWJh2gIf5PpxJac
        l6uZOHpzSEjZM813DjwilvkcQyjuTEh6GlvAKiCKevEzAxSCMAqTpivi0CXabGPKyPrEPfwq8BfFx
        YNvXl82GiZliGXprFVS3Y6cge+WOV80I1yQbwNm/licTLLUEz/GyzLUeCoDN3yyazOIrJhIVKTkzX
        E7d3Y0qBYIIJvbyJ1MAk2mjbpCdd3YnXqnXSFAwNqIS3oWN4eo/sfHJYrEk5VCs7Zb6VCqiXhQ6/a
        Y7OUaf+P0HnckZyWAjtA4xYHVVbJeWo1pUZuEhhmDMl8hSLu7KM3UvFlF23jGGyq8WSngiZ1MguVk
        DJV0Rc/Eg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLOZ8-0007eH-KC; Tue, 30 Apr 2019 08:56:42 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DBC9D202C6BE7; Tue, 30 Apr 2019 10:56:40 +0200 (CEST)
Date:   Tue, 30 Apr 2019 10:56:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     tglx@linutronix.de, mingo@redhat.com, linux-kernel@vger.kernel.org,
        eranian@google.com, tj@kernel.org, ak@linux.intel.com
Subject: Re: [PATCH 1/4] perf: Fix system-wide events miscounting during
 cgroup monitoring
Message-ID: <20190430085640.GJ2623@hirez.programming.kicks-ass.net>
References: <1556549045-71814-1-git-send-email-kan.liang@linux.intel.com>
 <1556549045-71814-2-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556549045-71814-2-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 07:44:02AM -0700, kan.liang@linux.intel.com wrote:

> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index e47ef76..039e2f2 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -795,6 +795,7 @@ struct perf_cpu_context {
>  #ifdef CONFIG_CGROUP_PERF
>  	struct perf_cgroup		*cgrp;
>  	struct list_head		cgrp_cpuctx_entry;
> +	unsigned int			cgrp_switch		:1;

If you're not adding more bits, why not just keep it an int?

>  #endif
>  
>  	struct list_head		sched_cb_entry;
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index dc7dead..388dd42 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -809,6 +809,7 @@ static void perf_cgroup_switch(struct task_struct *task, int mode)
>  
>  		perf_ctx_lock(cpuctx, cpuctx->task_ctx);
>  		perf_pmu_disable(cpuctx->ctx.pmu);
> +		cpuctx->cgrp_switch = true;
>  
>  		if (mode & PERF_CGROUP_SWOUT) {
>  			cpu_ctx_sched_out(cpuctx, EVENT_ALL);
> @@ -832,6 +833,7 @@ static void perf_cgroup_switch(struct task_struct *task, int mode)
>  							     &cpuctx->ctx);
>  			cpu_ctx_sched_in(cpuctx, EVENT_ALL, task);
>  		}
> +		cpuctx->cgrp_switch = false;
>  		perf_pmu_enable(cpuctx->ctx.pmu);
>  		perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
>  	}

That is a bit of a hack...

> @@ -2944,13 +2946,25 @@ static void ctx_sched_out(struct perf_event_context *ctx,
>  
>  	perf_pmu_disable(ctx->pmu);
>  	if (is_active & EVENT_PINNED) {
> -		list_for_each_entry_safe(event, tmp, &ctx->pinned_active, active_list)
> +		list_for_each_entry_safe(event, tmp, &ctx->pinned_active, active_list) {
> +#ifdef CONFIG_CGROUP_PERF
> +			/* Don't sched system-wide event when cgroup context switch */
> +			if (cpuctx->cgrp_switch && !event->cgrp)
> +				continue;
> +#endif
>  			group_sched_out(event, cpuctx, ctx);
> +		}
>  	}

This works by accident, however..

>  
>  	if (is_active & EVENT_FLEXIBLE) {
> -		list_for_each_entry_safe(event, tmp, &ctx->flexible_active, active_list)
> +		list_for_each_entry_safe(event, tmp, &ctx->flexible_active, active_list) {
> +#ifdef CONFIG_CGROUP_PERF
> +			/* Don't sched system-wide event when cgroup context switch */
> +			if (cpuctx->cgrp_switch && !event->cgrp)
> +				continue;
> +#endif
>  			group_sched_out(event, cpuctx, ctx);
> +		}
>  	}
>  	perf_pmu_enable(ctx->pmu);
>  }

this one is just wrong afaict.

Suppose the new cgroup has pinned events, which we cannot schedule
because you left !cgroup flexible events on.
