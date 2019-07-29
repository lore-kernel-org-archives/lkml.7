Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16693C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 11:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E004C206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 11:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S88qVkXq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387757AbfG2LbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 07:31:17 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45540 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387638AbfG2LbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 07:31:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=P3TKPDZQPD5gXt2IiDJs0VEeFQQfYbDYBVnCgJofwQM=; b=S88qVkXqKFkxmOOvTDgvCfW6f
        0ZDQoAkk1MuDM7JeYWsF7KlORvIGUELwh74+3hRG7R8BGV688PmFQwDD7rtCRcsC/TK5doB5sikGH
        a/6bl7mZjHT+5WpPCEScX1gpw/CkjWZxbxqcVwl4Q140DqYRHE2mFed5Eq4acD33RL9i/D0YVuNFz
        WCqgWVi44Dj0On5VzRn/cwqIjotVQRLq7y+ETSzI+QGL748pYu+E0pi6iZy/grO4ux3AG6uNZVDkr
        dmpBxezYk/GVBo0EWfcpmJWukU+Pyaov2pEvlTo/RWfJO7LVu+Q1pE85r4aP8/wNVorsx09j54SFJ
        AOGG+rUEg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hs3s2-00015F-J9; Mon, 29 Jul 2019 11:31:14 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2FBCB20B0155B; Mon, 29 Jul 2019 13:31:13 +0200 (CEST)
Date:   Mon, 29 Jul 2019 13:31:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kan.liang@linux.intel.com
Subject: Re: [PATCH v1 1/7] perf: Allow normal events to be sources of AUX
 data
Message-ID: <20190729113113.GB31381@hirez.programming.kicks-ass.net>
References: <20190704160024.56600-1-alexander.shishkin@linux.intel.com>
 <20190704160024.56600-2-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704160024.56600-2-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 07:00:18PM +0300, Alexander Shishkin wrote:
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 8cfb721bb284..fc586da37067 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -1887,6 +1887,57 @@ list_del_event(struct perf_event *event, struct perf_event_context *ctx)
>  	ctx->generation++;
>  }
>  
> +static int
> +perf_aux_source_match(struct perf_event *event, struct perf_event *aux_event)
> +{
> +	if (!has_aux(aux_event))
> +		return 0;
> +
> +	if (!event->pmu->aux_source_match)
> +		return 0;
> +
> +	return event->pmu->aux_source_match(aux_event);
> +}
> +
> +static void put_event(struct perf_event *event);
> +static void event_sched_out(struct perf_event *event,
> +			    struct perf_cpu_context *cpuctx,
> +			    struct perf_event_context *ctx);
> +
> +static void perf_put_aux_event(struct perf_event *event)
> +{
> +	struct perf_event_context *ctx = event->ctx;
> +	struct perf_cpu_context *cpuctx = __get_cpu_context(ctx);
> +	struct perf_event *iter = NULL;
> +
> +	/*
> +	 * If event uses aux_event tear down the link
> +	 */
> +	if (event->aux_event) {
> +		put_event(event->aux_event);
> +		event->aux_event = NULL;
> +		return;
> +	}
> +
> +	/*
> +	 * If the event is an aux_event, tear down all links to
> +	 * it from other events.
> +	 */
> +	for_each_sibling_event(iter, event->group_leader) {
> +		if (iter->aux_event != event)
> +			continue;
> +
> +		iter->aux_event = NULL;
> +		put_event(event);
> +
> +		/*
> +		 * If it's ACTIVE, schedule it out. It won't schedule
> +		 * again because !aux_event.
> +		 */
> +		event_sched_out(iter, cpuctx, ctx);
> +	}
> +}

I'm thinking we can use a perf_get_aux_event() to use below.

> +
>  static void perf_group_detach(struct perf_event *event)
>  {
>  	struct perf_event *sibling, *tmp;
> @@ -1902,6 +1953,8 @@ static void perf_group_detach(struct perf_event *event)
>  
>  	event->attach_state &= ~PERF_ATTACH_GROUP;
>  
> +	perf_put_aux_event(event);
> +
>  	/*
>  	 * If this is a sibling, remove it from its group.
>  	 */
> @@ -10396,6 +10449,12 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
>  		goto err_ns;
>  	}
>  
> +	if (event->attr.aux_source &&
> +	    !(pmu->capabilities & PERF_PMU_CAP_AUX_SOURCE)) {
> +		err = -EOPNOTSUPP;
> +		goto err_pmu;
> +	}
> +
>  	err = exclusive_event_init(event);
>  	if (err)
>  		goto err_pmu;
> @@ -11052,6 +11111,39 @@ SYSCALL_DEFINE5(perf_event_open,
>  		}
>  	}
>  
> +	if (event->attr.aux_source) {
> +		struct perf_event *aux_event = group_leader;
> +
> +		/*
> +		 * One of the events in the group must be an aux event
> +		 * if we want to be an aux_source. This way, the aux event
> +		 * will precede its aux_source events in the group, and
> +		 * therefore will always schedule first.

Can't we mandate that the group leader is the AUX event?

> +		 */
> +		err = -EINVAL;
> +		if (!aux_event)
> +			goto err_locked;
> +
> +		if (perf_aux_source_match(event, aux_event))
> +			goto found_aux;
> +
> +		for_each_sibling_event(aux_event, group_leader) {
> +			if (perf_aux_source_match(event, aux_event))
> +				goto found_aux;
> +		}
> +
> +		goto err_locked;
> +
> +found_aux:
> +		/*
> +		 * Link aux_sources to their aux event; this is undone in
> +		 * perf_group_detach(). When the group in torn down, the
> +		 * aux_source events loose their link to the aux_event and
> +		 * can't schedule any more.
> +		 */
> +		if (atomic_long_inc_not_zero(&aux_event->refcount))
> +			event->aux_event = aux_event;

I'm thinking failing that inc_not_zero() is BAD (tm) ?!

> +	}

With the sugggested perf_get_aux_event() this would become something
like:

	if (event->attr.aux_source && !perf_get_aux_event(event, group_leader))
		goto err_locked;

or something.

>  
>  	/*
>  	 * Must be under the same ctx::mutex as perf_install_in_context(),
> -- 
> 2.20.1
> 
