Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426D7C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C19E20693
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lr0lNY+X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391165AbfGHQQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 12:16:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41224 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390552AbfGHQQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 12:16:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3zpuNoUL2stQindiQdfg5Hndkq8wNSz7AfBaZDcdsV0=; b=lr0lNY+XSSrJepENKbf7XOxy4
        0lRckhqok3yfxwXd00Fbxp2tjS8uEGyOhBmM+HaJAR/EjJj8/IEyhhiR1pikL65JqK1GRhD2LvuYB
        M9dhXAf+pLyNYlLzbjGZf9zXHr5hqKFRdkcl3361ohb4u1Tr6ki0BryhUffENv1yOSsF2XgBG56zT
        vMMbxL/Cl3Qtahc6qcRu2ff/DPIQZHJsFz88bVbzxwnpwsn40y6gPtoebBWHmiMZaLW4/Hv7OA6wq
        dHcVnlhkpgQBEGSfZoyblKateCBXez3sfTqJM0w7bw6ePiN0ELPdIVPWVY+QlW1xQGl7WAaIzBTAS
        DDHASb0sw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hkWJi-0002E6-P9; Mon, 08 Jul 2019 16:16:39 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5643620976D60; Mon,  8 Jul 2019 18:16:36 +0200 (CEST)
Date:   Mon, 8 Jul 2019 18:16:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 2/7] perf/cgroup: order events in RB tree by cgroup id
Message-ID: <20190708161636.GE3419@hirez.programming.kicks-ass.net>
References: <20190702065955.165738-1-irogers@google.com>
 <20190702065955.165738-3-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702065955.165738-3-irogers@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 11:59:50PM -0700, Ian Rogers wrote:
> +static int visit_groups_merge(struct perf_event_context *ctx,
> +			      struct perf_cpu_context *cpuctx,
> +			      struct perf_event_groups *groups,
> +			      int (*func)(struct perf_event_context *,
> +					  struct perf_cpu_context *,
> +					  struct perf_event *,
> +					  int *),
> +			      int *data)

> -struct sched_in_data {
> -	struct perf_event_context *ctx;
> -	struct perf_cpu_context *cpuctx;
> -	int can_add_hw;
> -};
> -
> -static int pinned_sched_in(struct perf_event *event, void *data)
> +static int pinned_sched_in(struct perf_event_context *ctx,
> +			   struct perf_cpu_context *cpuctx,
> +			   struct perf_event *event,
> +			   int *unused)
>  {
> -	struct sched_in_data *sid = data;
> -
>  	if (event->state <= PERF_EVENT_STATE_OFF)
>  		return 0;
>  
>  	if (!event_filter_match(event))
>  		return 0;
>  
> -	if (group_can_go_on(event, sid->cpuctx, sid->can_add_hw)) {
> -		if (!group_sched_in(event, sid->cpuctx, sid->ctx))
> -			list_add_tail(&event->active_list, &sid->ctx->pinned_active);
> +	if (group_can_go_on(event, cpuctx, 1)) {
> +		if (!group_sched_in(event, cpuctx, ctx))
> +			list_add_tail(&event->active_list, &ctx->pinned_active);
>  	}
>  
>  	/*
> @@ -3317,24 +3444,25 @@ static int pinned_sched_in(struct perf_event *event, void *data)
>  	return 0;
>  }
>  
> -static int flexible_sched_in(struct perf_event *event, void *data)
> +static int flexible_sched_in(struct perf_event_context *ctx,
> +			     struct perf_cpu_context *cpuctx,
> +			     struct perf_event *event,
> +			     int *can_add_hw)
>  {
> -	struct sched_in_data *sid = data;
> -
>  	if (event->state <= PERF_EVENT_STATE_OFF)
>  		return 0;
>  
>  	if (!event_filter_match(event))
>  		return 0;
>  
> -	if (group_can_go_on(event, sid->cpuctx, sid->can_add_hw)) {
> -		int ret = group_sched_in(event, sid->cpuctx, sid->ctx);
> +	if (group_can_go_on(event, cpuctx, *can_add_hw)) {
> +		int ret = group_sched_in(event, cpuctx, ctx);
>  		if (ret) {
> -			sid->can_add_hw = 0;
> -			sid->ctx->rotate_necessary = 1;
> +			*can_add_hw = 0;
> +			ctx->rotate_necessary = 1;
>  			return 0;
>  		}
> -		list_add_tail(&event->active_list, &sid->ctx->flexible_active);
> +		list_add_tail(&event->active_list, &ctx->flexible_active);
>  	}
>  
>  	return 0;
> @@ -3344,30 +3472,24 @@ static void
>  ctx_pinned_sched_in(struct perf_event_context *ctx,
>  		    struct perf_cpu_context *cpuctx)
>  {
> -	struct sched_in_data sid = {
> -		.ctx = ctx,
> -		.cpuctx = cpuctx,
> -		.can_add_hw = 1,
> -	};
> -
> -	visit_groups_merge(&ctx->pinned_groups,
> -			   smp_processor_id(),
> -			   pinned_sched_in, &sid);
> +	visit_groups_merge(ctx,
> +			   cpuctx,
> +			   &ctx->pinned_groups,
> +			   pinned_sched_in,
> +			   NULL);
>  }
>  
>  static void
>  ctx_flexible_sched_in(struct perf_event_context *ctx,
>  		      struct perf_cpu_context *cpuctx)
>  {
> -	struct sched_in_data sid = {
> -		.ctx = ctx,
> -		.cpuctx = cpuctx,
> -		.can_add_hw = 1,
> -	};
> +	int can_add_hw = 1;
>  
> -	visit_groups_merge(&ctx->flexible_groups,
> -			   smp_processor_id(),
> -			   flexible_sched_in, &sid);
> +	visit_groups_merge(ctx,
> +			   cpuctx,
> +			   &ctx->flexible_groups,
> +			   flexible_sched_in,
> +			   &can_add_hw);
>  }

It is not clear to me why you're doing away with that sched_in_data
abstraction. AFAICT that has no material impact on this patch.
