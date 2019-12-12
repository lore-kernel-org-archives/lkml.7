Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10A2C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF6362054F
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iEeO/v79"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbfLLPj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 10:39:56 -0500
Received: from merlin.infradead.org ([205.233.59.134]:40794 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729013AbfLLPj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 10:39:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=G47iDtqZyRDhlydRc9ZL4ifY0Wp4GVV7OS64tBYKfUY=; b=iEeO/v796xvS0nRqxU8XuN58z
        iWu9iLJoJ/sPV021GQb+DbZJ4ioNlyRmQltS1Ih8dNMazPv4orJ75xnDI51sTBApevrD9hW2MSCl6
        JSlSOZ4wcF9T2FlarB410JhvMGausp8Ih/Y6UDzLZPlFJs3hZwvAerISq89U20tJKnREQI7TK61O1
        ydL78Slk+H1obZu3UMz7iO+xt/iOE6hgtimXoeDV1UJYn01WxRVQo0EqmEl7QtyL+0tKZaZ+mKP3W
        CMZGiwTR2aBkXk2SRcFGkQwOKON66CmeUc9eZXTUlM/ujzJFG4neyiqRHOcdaC/frRUBVy0VpkEJq
        2fh8wDl1A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifQZC-0003A1-42; Thu, 12 Dec 2019 15:39:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 644F8300F29;
        Thu, 12 Dec 2019 16:38:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BE0322B195D80; Thu, 12 Dec 2019 16:39:47 +0100 (CET)
Date:   Thu, 12 Dec 2019 16:39:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v8] perf: Sharing PMU counters across compatible events
Message-ID: <20191212153947.GY2844@hirez.programming.kicks-ass.net>
References: <20191207002447.2976319-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191207002447.2976319-1-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2019 at 04:24:47PM -0800, Song Liu wrote:

> @@ -2174,6 +2410,14 @@ __perf_remove_from_context(struct perf_event *event,
>  		update_cgrp_time_from_cpuctx(cpuctx);
>  	}
>  
> +	if (event->dup_master == event) {
> +		if (ctx->is_active)
> +			ctx_resched(cpuctx, cpuctx->task_ctx,
> +				    get_event_type(event), NULL, event);
> +		else
> +			perf_event_remove_dup(event, ctx);
> +	}
> +
>  	event_sched_out(event, cpuctx, ctx);
>  	if (flags & DETACH_GROUP)
>  		perf_group_detach(event);
> @@ -2241,6 +2485,14 @@ static void __perf_event_disable(struct perf_event *event,
>  		update_cgrp_time_from_event(event);
>  	}
>  
> +	if (event->dup_master == event) {
> +		if (ctx->is_active)
> +			ctx_resched(cpuctx, cpuctx->task_ctx,
> +				    get_event_type(event), NULL, event);
> +		else
> +			perf_event_remove_dup(event, ctx);
> +	}
> +
>  	if (event == event->group_leader)
>  		group_sched_out(event, cpuctx, ctx);
>  	else

> @@ -2544,7 +2793,9 @@ static void perf_event_sched_in(struct perf_cpu_context *cpuctx,
>   */
>  static void ctx_resched(struct perf_cpu_context *cpuctx,
>  			struct perf_event_context *task_ctx,
> -			enum event_type_t event_type)
> +			enum event_type_t event_type,
> +			struct perf_event *event_add_dup,
> +			struct perf_event *event_del_dup)
>  {
>  	enum event_type_t ctx_event_type;
>  	bool cpu_event = !!(event_type & EVENT_CPU);
> @@ -2574,6 +2825,18 @@ static void ctx_resched(struct perf_cpu_context *cpuctx,
>  	else if (ctx_event_type & EVENT_PINNED)
>  		cpu_ctx_sched_out(cpuctx, EVENT_FLEXIBLE);
>  
> +	if (event_add_dup) {
> +		if (event_add_dup->ctx->is_active)
> +			ctx_sched_out(event_add_dup->ctx, cpuctx, EVENT_ALL);
> +		perf_event_setup_dup(event_add_dup, event_add_dup->ctx);
> +	}
> +
> +	if (event_del_dup) {
> +		if (event_del_dup->ctx->is_active)
> +			ctx_sched_out(event_del_dup->ctx, cpuctx, EVENT_ALL);
> +		perf_event_remove_dup(event_del_dup, event_del_dup->ctx);
> +	}
> +
>  	perf_event_sched_in(cpuctx, task_ctx, current);
>  	perf_pmu_enable(cpuctx->ctx.pmu);
>  }

Yuck!

Why do you do a full reschedule when you take out a master?
