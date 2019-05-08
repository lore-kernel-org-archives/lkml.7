Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42699C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 09:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0899220578
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 09:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="msZ9+WhG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfEHJea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 05:34:30 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46486 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbfEHJea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 05:34:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8TccHtGxS8LKWDqBwI3XHg8TLKIlomLkbEsr7hUcvqs=; b=msZ9+WhGMw3dYt01bRGUuiCh0
        6q14HLt+tQNerddFAz9P1Mqez2S72rsnQfGr4KP//gXBBcmEZN4ifnCWtBM2yS/l9lHQS0zi3qQsQ
        /kI8fF+y1mTLIaJYIX56aGj96t+vYWETYXEWYyGY8i1AN4h/7rLWP7B/y1jrWiopn7nKof505vJSj
        nrBwQCFKJmb5uM8qBZFtH8p8D//nvwu5IbAksImHdwEUC1MD1ETsMQvjXzdKTZOpoBZIQFO9Bq2YW
        fuRx3tlYXP+x4NmVztJuq2boxHNjT3qZnOZ2MC6JXwZKFgOlRSTYG3D/C7BUPYMcB1dFm7vUS+/Wu
        Qb38SCb3g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hOIxy-0004wp-S2; Wed, 08 May 2019 09:34:23 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 60FA52029F886; Wed,  8 May 2019 11:34:21 +0200 (CEST)
Date:   Wed, 8 May 2019 11:34:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, adrian.hunter@intel.com
Subject: Re: [PATCH 2/2] perf/x86/intel: Support PEBS output to PT
Message-ID: <20190508093421.GD2606@hirez.programming.kicks-ass.net>
References: <20190502105022.15534-1-alexander.shishkin@linux.intel.com>
 <20190502105022.15534-3-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502105022.15534-3-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 01:50:22PM +0300, Alexander Shishkin wrote:

> The output setting is per-CPU, so all PEBS events must be either writing
> to PT or to the DS area, so in order to not mess up the event scheduling,
> we fall back to the latter in case both types of events are scheduled in.

> +static void intel_pmu_pebs_via_pt_disable(struct perf_event *event)
> +{
> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +
> +	if (!(event->hw.flags & PERF_X86_EVENT_PEBS_VIA_PT))
> +		return;
> +
> +	if (!(cpuc->pebs_enabled & ~PEBS_VIA_PT_MASK))
> +		cpuc->pebs_enabled &= ~PEBS_VIA_PT_MASK;
> +}
> +
> +static void intel_pmu_pebs_via_pt_enable(struct perf_event *event)
> +{
> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct debug_store *ds = cpuc->ds;
> +
> +	if (!(event->hw.flags & PERF_X86_EVENT_PEBS_VIA_PT))
> +		return;
> +
> +	/*
> +	 * In case there's a mix of PEBS->PT and PEBS->DS, fall back
> +	 * to DS.
> +	 */
> +	if (cpuc->n_pebs != cpuc->n_pebs_via_pt) {
> +		/* PEBS-to-DS events present, fall back to DS */
> +		intel_pmu_pebs_via_pt_disable(event);
> +		return;
> +	}
> +
> +	if (!(event->hw.flags & PERF_X86_EVENT_LARGE_PEBS))
> +		cpuc->pebs_enabled |= PEBS_PMI_AFTER_EACH_RECORD;
> +
> +	cpuc->pebs_enabled |= PEBS_OUTPUT_PT;
> +
> +	wrmsrl(MSR_RELOAD_PMC0 + hwc->idx, ds->pebs_event_reset[hwc->idx]);
> +}
> +
>  void intel_pmu_pebs_enable(struct perf_event *event)
>  {
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> @@ -1100,6 +1146,8 @@ void intel_pmu_pebs_enable(struct perf_event *event)
>  	} else {
>  		ds->pebs_event_reset[hwc->idx] = 0;
>  	}
> +
> +	intel_pmu_pebs_via_pt_enable(event);
>  }

I think that doesn't even do what it says on the tin. Suppose you first
schedule that PEBS-via-PT event and then the normal one, nothing then
cancels the PT link.

Like I wrote in that prevoius email; I really don't like this. I think
silently falling back to another output method is wrong.

Ideally we create schedulig conflicts and cause the PT and DS events to
round robin.
