Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65948C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 15:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3735C20651
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 15:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbfD2PEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 11:04:49 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59820 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728253AbfD2PEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 11:04:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D99E680D;
        Mon, 29 Apr 2019 08:04:47 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 503A83F5C1;
        Mon, 29 Apr 2019 08:04:46 -0700 (PDT)
Date:   Mon, 29 Apr 2019 16:04:43 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     kan.liang@linux.intel.com
Cc:     peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        linux-kernel@vger.kernel.org, eranian@google.com, tj@kernel.org,
        ak@linux.intel.com
Subject: Re: [PATCH 1/4] perf: Fix system-wide events miscounting during
 cgroup monitoring
Message-ID: <20190429150443.GB2182@lakrids.cambridge.arm.com>
References: <1556549045-71814-1-git-send-email-kan.liang@linux.intel.com>
 <1556549045-71814-2-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556549045-71814-2-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 07:44:02AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> When counting system-wide events and cgroup events simultaneously, the
> value of system-wide events are miscounting. For example,
> 
>     perf stat -e cycles,instructions -e cycles,instructions -G
> cgroup1,cgroup1,cgroup2,cgroup2 -a -e cycles,instructions -I 1000
> 
>      1.096265502     12,375,398,872      cycles              cgroup1
>      1.096265502      8,396,184,503      instructions        cgroup1
>  #    0.10  insn per cycle
>      1.096265502    109,609,027,112      cycles              cgroup2
>      1.096265502     11,533,690,148      instructions        cgroup2
>  #    0.14  insn per cycle
>      1.096265502    121,672,937,058      cycles
>      1.096265502     19,331,496,727      instructions               #
> 0.24  insn per cycle
> 
> The events are identical events for system-wide and cgroup. The
> value of system-wide events is less than the sum of cgroup events,
> which is wrong.
> 
> Both system-wide and cgroup are per-cpu. They share the same cpuctx
> groups, cpuctx->flexible_groups/pinned_groups.
> In context switch, cgroup switch tries to schedule all the events in
> the cpuctx groups. The unmatched cgroup events can be filtered by its
> event->cgrp. However, system-wide events, which event->cgrp is NULL, are
> unconditionally switched, which causes miscounting.

Why exactly does that cause mis-counting?

Are the system-wide events not switched back in? Or filtered
erroneously?

> Introduce cgrp_switch in cpuctx to indicate the cgroup context switch.
> If it's system-wide event in context switch, don't try to switch it.
> 
> Fixes: e5d1367f17ba ("perf: Add cgroup support")
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  include/linux/perf_event.h |  1 +
>  kernel/events/core.c       | 30 ++++++++++++++++++++++++++++--
>  2 files changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index e47ef76..039e2f2 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -795,6 +795,7 @@ struct perf_cpu_context {
>  #ifdef CONFIG_CGROUP_PERF
>  	struct perf_cgroup		*cgrp;
>  	struct list_head		cgrp_cpuctx_entry;
> +	unsigned int			cgrp_switch		:1;
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

This pattern is duplicated several times, and should probably be a
helper like:

static bool skip_cgroup_switch(struct perf_cpu_context *cpuctx,
			       struct perf_event *event);
{
	return IS_ENABLED(CONFIG_CGROUP_PERF) &&
	       cpuctx->cgrp_switch &&
	       !event->cgrp;
}

... allowing the above to be an unconditional:

	if (skip_cgroup_switch(cpuctx, event))
		continue;

... and likewise for the other cases.

Thanks,
Mark.

>  			group_sched_out(event, cpuctx, ctx);
> +		}
>  	}
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
> @@ -3280,6 +3294,12 @@ static int pinned_sched_in(struct perf_event *event, void *data)
>  	if (event->state <= PERF_EVENT_STATE_OFF)
>  		return 0;
>  
> +#ifdef CONFIG_CGROUP_PERF
> +	/* Don't sched system-wide event when cgroup context switch */
> +	if (sid->cpuctx->cgrp_switch && !event->cgrp)
> +		return 0;
> +#endif
> +
>  	if (!event_filter_match(event))
>  		return 0;
>  
> @@ -3305,6 +3325,12 @@ static int flexible_sched_in(struct perf_event *event, void *data)
>  	if (event->state <= PERF_EVENT_STATE_OFF)
>  		return 0;
>  
> +#ifdef CONFIG_CGROUP_PERF
> +	/* Don't sched system-wide event when cgroup context switch */
> +	if (sid->cpuctx->cgrp_switch && !event->cgrp)
> +		return 0;
> +#endif
> +
>  	if (!event_filter_match(event))
>  		return 0;
>  
> -- 
> 2.7.4
> 
