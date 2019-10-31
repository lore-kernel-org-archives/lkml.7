Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17269CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 12:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D21A82067D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 12:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iZpvMwET"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfJaMnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 08:43:46 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33758 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfJaMnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 08:43:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jBmZlBwr/Ks6ozQpHVTeR+373gRUmQy202/ToYUuLdQ=; b=iZpvMwETeTxeBk8hPf/qRkJWl
        492kC9Xhwdh3ydVEq1rYTJlyaclOuT8hQO0K26nMUQ7L/Gq3Se2NqGE4qn+vpNpbGYQuzZHk5W1bi
        +aTouhu7n8VoXIkCJerO4kw46KG8zLjWnOHyY9lIr5uTNiHOx3DbJqj0zBOga3Qpn6Yflb6nejkiA
        y9qeXToyeYP7IVyCOjPeNazp3zpZ4D8JcF8h/wK1FdOpNRWy0LsA+NZjyFoDcA7XGMK2OmrEYU8JX
        jQaxOty+xukOP88YQaRmTY1FEKYu3bQXq8xuHa7X7MOIYw/BKTar8nDCJ63I+lWVwWOjH4TviiSmO
        +iPLsBTaA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iQ9nb-0005dX-VS; Thu, 31 Oct 2019 12:43:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 00E4E30025A;
        Thu, 31 Oct 2019 13:42:30 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 840812B45E75A; Thu, 31 Oct 2019 13:43:32 +0100 (CET)
Date:   Thu, 31 Oct 2019 13:43:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, acme@kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v6] perf: Sharing PMU counters across compatible events
Message-ID: <20191031124332.GQ4131@hirez.programming.kicks-ass.net>
References: <20190919052314.2925604-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919052314.2925604-1-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 10:23:14PM -0700, Song Liu wrote:
> This patch tries to enable PMU sharing. To make perf event scheduling
> fast, we use special data structures.
> 
> An array of "struct perf_event_dup" is added to the perf_event_context,
> to remember all the duplicated events under this ctx. All the events
> under this ctx has a "dup_id" pointing to its perf_event_dup. Compatible
> events under the same ctx share the same perf_event_dup. The following
> figure shows a simplified version of the data structure.
> 
>       ctx ->  perf_event_dup -> master
>                      ^
>                      |
>          perf_event /|
>                      |
>          perf_event /
> 
> Connection among perf_event and perf_event_dup are built when events are
> added or removed from the ctx. So these are not on the critical path of
> schedule or perf_rotate_context().
> 
> On the critical paths (add, del read), sharing PMU counters doesn't
> increase the complexity. Helper functions event_pmu_[add|del|read]() are
> introduced to cover these cases. All these functions have O(1) time
> complexity.
> 
> We allocate a separate perf_event for perf_event_dup->master. This needs
> extra attention, because perf_event_alloc() may sleep. To allocate the
> master event properly, a new pointer, tmp_master, is added to perf_event.
> tmp_master carries a separate perf_event into list_[add|del]_event().
> The master event has valid ->ctx and holds ctx->refcount.

That is realy nasty and expensive, it basically means every !sampling
event carries a double allocate.

Why can't we use one of the actual events as master?

> +/*
> + * Sharing PMU across compatible events
> + *
> + * If two perf_events in the same perf_event_context are counting same
> + * hardware events (instructions, cycles, etc.), they could share the
> + * hardware PMU counter.
> + *
> + * When a perf_event is added to the ctx (list_add_event), it is compared
> + * against other events in the ctx. If they can share the PMU counter,
> + * a perf_event_dup is allocated to represent the sharing.
> + *
> + * Each perf_event_dup has a virtual master event, which is called by
> + * pmu->add() and pmu->del(). We cannot call perf_event_alloc() in
> + * list_add_event(), so it is allocated and carried by event->tmp_master
> + * into list_add_event().
> + *
> + * Virtual master in different cases/paths:
> + *
> + * < I > perf_event_open() -> close() path:
> + *
> + * 1. Allocated by perf_event_alloc() in sys_perf_event_open();
> + * 2. event->tmp_master->ctx assigned in perf_install_in_context();
> + * 3.a. if used by ctx->dup_events, freed in perf_event_release_kernel();
> + * 3.b. if not used by ctx->dup_events, freed in perf_event_open().
> + *
> + * < II > inherit_event() path:
> + *
> + * 1. Allocated by perf_event_alloc() in inherit_event();
> + * 2. tmp_master->ctx assigned in inherit_event();
> + * 3.a. if used by ctx->dup_events, freed in perf_event_release_kernel();
> + * 3.b. if not used by ctx->dup_events, freed in inherit_event().
> + *
> + * < III > perf_pmu_migrate_context() path:
> + * all dup_events removed during migration (no sharing after the move).
> + *
> + * < IV > perf_event_create_kernel_counter() path:
> + * not supported yet.
> + */
> +struct perf_event_dup {
> +	/*
> +	 * master event being called by pmu->add() and pmu->del().
> +	 * This event is allocated with perf_event_alloc(). When
> +	 * attached to a ctx, this event should hold ctx->refcount.
> +	 */
> +	struct perf_event       *master;
> +	/* number of events in the ctx that shares the master */
> +	int			total_event_count;
> +	/* number of active events of the master */
> +	int			active_event_count;
> +};
> +
> +#define MAX_PERF_EVENT_DUP_PER_CTX 4
>  /**
>   * struct perf_event_context - event context structure
>   *
> @@ -791,6 +849,9 @@ struct perf_event_context {
>  #endif
>  	void				*task_ctx_data; /* pmu specific data */
>  	struct rcu_head			rcu_head;
> +
> +	/* for PMU sharing. array is needed for O(1) access */
> +	struct perf_event_dup		dup_events[MAX_PERF_EVENT_DUP_PER_CTX];

Yuck!

event_pmu_{add,del,read}() appear to be the consumer of this array
thing, but I'm not seeing why we need it.

That is, again, why can't we use one of the actual events as master and
have a dup_master pointer per event and then do something like:

event_pmu_add()
{
	if (event->dup_master != event)
		return;

	event->pmu->add(event, PERF_EF_START);
}

Such that we only schedule the master events and ignore all duplicates.

Then on read it can do something like:

event_pmu_read()
{
	if (event->dup_master == event)
		return;

	/* use event->dup_master as counter */
again:
	prev_count = local64_read(&hwc->prev_count);
	count = local64_read(&event->dup_master->count);
	if (local64_cmpxchg(&hwc->prev_count, prev_count, count) != prev_count)
		goto again;

	delta = count - prev_count;
	local64_add(delta, &event->count);
}

>  };

> +/* Returns whether a perf_event can share PMU counter with other events */
> +static inline bool perf_event_can_share(struct perf_event *event)
> +{
> +	/* only do sharing for hardware events */
> +	if (is_software_event(event))
> +		return false;
> +
> +	/*
> +	 * limit sharing to counting events.
> +	 * perf-stat sets PERF_SAMPLE_IDENTIFIER for counting events, so
> +	 * let that in.
> +	 */
> +	if (event->attr.sample_type & ~PERF_SAMPLE_IDENTIFIER)
> +		return false;

Why is is_sampling_event() not usable?

> +
> +	return true;
> +}
> +
> +/*
> + * Returns whether the two events can share a PMU counter.
> + *
> + * Note: This function does NOT check perf_event_can_share() for
> + * the two events, they should be checked before this function
> + */
> +static inline bool perf_event_compatible(struct perf_event *event_a,
> +					 struct perf_event *event_b)
> +{
> +	return event_a->attr.type == event_b->attr.type &&
> +		event_a->attr.config == event_b->attr.config &&
> +		event_a->attr.config1 == event_b->attr.config1 &&
> +		event_a->attr.config2 == event_b->attr.config2;
> +}

Slightly scared by this one.


> @@ -2612,20 +2828,9 @@ static int  __perf_install_in_context(void *info)
>  		raw_spin_lock(&task_ctx->lock);
>  	}
>  
> -#ifdef CONFIG_CGROUP_PERF
> -	if (is_cgroup_event(event)) {
> -		/*
> -		 * If the current cgroup doesn't match the event's
> -		 * cgroup, we should not try to schedule it.
> -		 */
> -		struct perf_cgroup *cgrp = perf_cgroup_from_task(current, ctx);
> -		reprogram = cgroup_is_descendant(cgrp->css.cgroup,
> -					event->cgrp->css.cgroup);
> -	}
> -#endif

Why is this removed?

> @@ -10986,6 +11198,14 @@ SYSCALL_DEFINE5(perf_event_open,
>  		goto err_cred;
>  	}
>  
> +	if (perf_event_can_share(event)) {
> +		event->tmp_master = perf_event_alloc(&event->attr, cpu,
> +						     task, NULL, NULL,
> +						     NULL, NULL, -1);
> +		if (IS_ERR(event->tmp_master))
> +			event->tmp_master = NULL;
> +	}


> @@ -11773,6 +12005,14 @@ inherit_event(struct perf_event *parent_event,
>  	if (IS_ERR(child_event))
>  		return child_event;
>  
> +	if (perf_event_can_share(child_event)) {
> +		child_event->tmp_master = perf_event_alloc(&parent_event->attr,
> +							   parent_event->cpu,
> +							   child, NULL, NULL,
> +							   NULL, NULL, -1);
> +		if (IS_ERR(child_event->tmp_master))
> +			child_event->tmp_master = NULL;
> +	}

So this is terrible!

> 
