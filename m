Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A03DC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F74320665
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387403AbfFMQNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:13:02 -0400
Received: from mga11.intel.com ([192.55.52.93]:55999 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730487AbfFMQNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 12:13:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2019 09:13:00 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 13 Jun 2019 09:12:59 -0700
Received: from [10.254.98.131] (kliang2-mobl.ccr.corp.intel.com [10.254.98.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 2ABBB5801A8;
        Thu, 13 Jun 2019 09:12:58 -0700 (PDT)
Subject: Re: [PATCH] perf cgroups: Don't rotate events for cgroups
 unnecessarily
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, ak@linux.intel.com,
        eranian@google.com
References: <20190601082722.44543-1-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <5084acfa-59a4-996f-bb1d-69fbbac01b87@linux.intel.com>
Date:   Thu, 13 Jun 2019 12:12:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190601082722.44543-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/1/2019 4:27 AM, Ian Rogers wrote:
> Currently perf_rotate_context assumes that if the context's nr_events !=
> nr_active a rotation is necessary for perf event multiplexing. With
> cgroups, nr_events is the total count of events for all cgroups and
> nr_active will not include events in a cgroup other than the current
> task's. This makes rotation appear necessary for cgroups when it is not.
> 
> Add a perf_event_context flag that is set when rotation is necessary.
> Clear the flag during sched_out and set it when a flexible sched_in
> fails due to resources.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   include/linux/perf_event.h |  5 +++++
>   kernel/events/core.c       | 42 +++++++++++++++++++++++---------------
>   2 files changed, 30 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 15a82ff0aefe..7ab6c251aa3d 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -747,6 +747,11 @@ struct perf_event_context {
>   	int				nr_stat;
>   	int				nr_freq;
>   	int				rotate_disable;
> +	/*
> +	 * Set when nr_events != nr_active, except tolerant to events not
> +	 * needing to be active due to scheduling constraints, such as cgroups.
> +	 */
> +	int				rotate_necessary;

It looks like the rotate_necessary is only useful for cgroup and cpuctx.
Why not move it to struct perf_cpu_context and under #ifdef 
CONFIG_CGROUP_PERF?
And rename it cgrp_rotate_necessary?

Thanks,
Kan

>   	refcount_t			refcount;
>   	struct task_struct		*task;
>   
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index abbd4b3b96c2..41ae424b9f1d 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2952,6 +2952,12 @@ static void ctx_sched_out(struct perf_event_context *ctx,
>   	if (!ctx->nr_active || !(is_active & EVENT_ALL))
>   		return;
>   
> +	/*
> +	 * If we had been multiplexing, no rotations are necessary now no events
> +	 * are active.
> +	 */
> +	ctx->rotate_necessary = 0;
> +
>   	perf_pmu_disable(ctx->pmu);
>   	if (is_active & EVENT_PINNED) {
>   		list_for_each_entry_safe(event, tmp, &ctx->pinned_active, active_list)
> @@ -3325,6 +3331,15 @@ static int flexible_sched_in(struct perf_event *event, void *data)
>   			sid->can_add_hw = 0;
>   	}
>   
> +	/*
> +	 * If the group wasn't scheduled then set that multiplexing is necessary
> +	 * for the context. Note, this won't be set if the event wasn't
> +	 * scheduled due to event_filter_match failing due to the earlier
> +	 * return.
> +	 */
> +	if (event->state == PERF_EVENT_STATE_INACTIVE)
> +		sid->ctx->rotate_necessary = 1;
> +
>   	return 0;
>   }
>   
> @@ -3690,24 +3705,17 @@ ctx_first_active(struct perf_event_context *ctx)
>   static bool perf_rotate_context(struct perf_cpu_context *cpuctx)
>   {
>   	struct perf_event *cpu_event = NULL, *task_event = NULL;
> -	bool cpu_rotate = false, task_rotate = false;
> -	struct perf_event_context *ctx = NULL;
> +	struct perf_event_context *task_ctx = NULL;
> +	int cpu_rotate, task_rotate;
>   
>   	/*
>   	 * Since we run this from IRQ context, nobody can install new
>   	 * events, thus the event count values are stable.
>   	 */
>   
> -	if (cpuctx->ctx.nr_events) {
> -		if (cpuctx->ctx.nr_events != cpuctx->ctx.nr_active)
> -			cpu_rotate = true;
> -	}
> -
> -	ctx = cpuctx->task_ctx;
> -	if (ctx && ctx->nr_events) {
> -		if (ctx->nr_events != ctx->nr_active)
> -			task_rotate = true;
> -	}
> +	cpu_rotate = cpuctx->ctx.rotate_necessary;
> +	task_ctx = cpuctx->task_ctx;
> +	task_rotate = task_ctx ? task_ctx->rotate_necessary : 0;
>   
>   	if (!(cpu_rotate || task_rotate))
>   		return false;
> @@ -3716,7 +3724,7 @@ static bool perf_rotate_context(struct perf_cpu_context *cpuctx)
>   	perf_pmu_disable(cpuctx->ctx.pmu);
>   
>   	if (task_rotate)
> -		task_event = ctx_first_active(ctx);
> +		task_event = ctx_first_active(task_ctx);
>   	if (cpu_rotate)
>   		cpu_event = ctx_first_active(&cpuctx->ctx);
>   
> @@ -3724,17 +3732,17 @@ static bool perf_rotate_context(struct perf_cpu_context *cpuctx)
>   	 * As per the order given at ctx_resched() first 'pop' task flexible
>   	 * and then, if needed CPU flexible.
>   	 */
> -	if (task_event || (ctx && cpu_event))
> -		ctx_sched_out(ctx, cpuctx, EVENT_FLEXIBLE);
> +	if (task_event || (task_ctx && cpu_event))
> +		ctx_sched_out(task_ctx, cpuctx, EVENT_FLEXIBLE);
>   	if (cpu_event)
>   		cpu_ctx_sched_out(cpuctx, EVENT_FLEXIBLE);
>   
>   	if (task_event)
> -		rotate_ctx(ctx, task_event);
> +		rotate_ctx(task_ctx, task_event);
>   	if (cpu_event)
>   		rotate_ctx(&cpuctx->ctx, cpu_event);
>   
> -	perf_event_sched_in(cpuctx, ctx, current);
> +	perf_event_sched_in(cpuctx, task_ctx, current);
>   
>   	perf_pmu_enable(cpuctx->ctx.pmu);
>   	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
> 
