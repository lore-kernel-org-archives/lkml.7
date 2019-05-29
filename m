Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08B6C04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 08:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D6B20B7C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 08:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oJVqjQo2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfE2IPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 04:15:11 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60158 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfE2IPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 04:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=89kkSP52+zBKcZ9ALivlFqEaMzzWrvtjO+agUKAHnOM=; b=oJVqjQo2y8YcIXnHP+5L/MvpV
        vHfYUbt99zS50CB6X1toAOhgyGkCeWoQl/bNZYSAEOkhseZ2Xp0vSoFSfbMsNW3jsn0snwKlUqytT
        mquaK38l/XRgCmTjXD45+uFHxBhB3CSdycIoI0nsl8GQyCdBafgvuV10e9JUGMLM1MKg9RRz/1Hpp
        Ob4ybRN6OJ4Tg9j225ZsN+RoZRg6RdcF2R7avRie9gP/1iGi42WDvE8MXYIrecDYEo6c0dTgwZmOu
        FC+WapUb173WTWRWna+MBEm6zHgKELT+vteeLOT9UdX+n38J9DqWhSvU15S/lTZQueCHGrjSyvBWb
        bcufIsYjQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVtjf-0002Qa-IT; Wed, 29 May 2019 08:14:59 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 07E57201A7E42; Wed, 29 May 2019 10:14:58 +0200 (CEST)
Date:   Wed, 29 May 2019 10:14:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH 2/9] perf/x86/intel: Basic support for metrics counters
Message-ID: <20190529081457.GD2623@hirez.programming.kicks-ass.net>
References: <20190521214055.31060-1-kan.liang@linux.intel.com>
 <20190521214055.31060-3-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521214055.31060-3-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, May 28, 2019 at 02:20:53PM -0400, Liang, Kan wrote:
> On 5/28/2019 8:05 AM, Peter Zijlstra wrote:
> > On Tue, May 21, 2019 at 02:40:48PM -0700, kan.liang@linux.intel.com wrote:

> @@ -2155,9 +2155,19 @@ static void intel_pmu_disable_event(struct perf_event *event)
>  		return;
>  	}
>  
> -	cpuc->intel_ctrl_guest_mask &= ~(1ull << hwc->idx);
> -	cpuc->intel_ctrl_host_mask &= ~(1ull << hwc->idx);
> -	cpuc->intel_cp_status &= ~(1ull << hwc->idx);
> +	__clear_bit(hwc->idx, cpuc->enabled_events);
> +
> +	/*
> +	 * When any other slots sharing event is still enabled,
> +	 * cancel the disabling.
> +	 */
> +	if (is_any_slots_idx(hwc->idx) &&
> +	    (*(u64 *)&cpuc->enabled_events & INTEL_PMC_MSK_ANY_SLOTS))
> +		return;
> +
> +	cpuc->intel_ctrl_guest_mask &= ~(1ull << hwc->reg_idx);
> +	cpuc->intel_ctrl_host_mask &= ~(1ull << hwc->reg_idx);
> +	cpuc->intel_cp_status &= ~(1ull << hwc->reg_idx);
>  
>  	if (unlikely(hwc->config_base == MSR_ARCH_PERFMON_FIXED_CTR_CTRL)) {
>  		intel_pmu_disable_fixed(hwc);

> @@ -2242,18 +2252,19 @@ static void intel_pmu_enable_event(struct perf_event *event)
>  	}
>  
>  	if (event->attr.exclude_host)
> -		cpuc->intel_ctrl_guest_mask |= (1ull << hwc->idx);
> +		cpuc->intel_ctrl_guest_mask |= (1ull << hwc->reg_idx);
>  	if (event->attr.exclude_guest)
> -		cpuc->intel_ctrl_host_mask |= (1ull << hwc->idx);
> +		cpuc->intel_ctrl_host_mask |= (1ull << hwc->reg_idx);
>  
>  	if (unlikely(event_is_checkpointed(event)))
> -		cpuc->intel_cp_status |= (1ull << hwc->idx);
> +		cpuc->intel_cp_status |= (1ull << hwc->reg_idx);
>  
>  	if (unlikely(event->attr.precise_ip))
>  		intel_pmu_pebs_enable(event);
>  
>  	if (unlikely(hwc->config_base == MSR_ARCH_PERFMON_FIXED_CTR_CTRL)) {
> -		intel_pmu_enable_fixed(event);
> +		if (!__test_and_set_bit(hwc->idx, cpuc->enabled_events))
> +			intel_pmu_enable_fixed(event);
>  		return;
>  	}
>  
> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index 7ae2912f16de..dd6c86a758f7 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -203,6 +203,7 @@ struct cpu_hw_events {
>  	unsigned long		active_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
>  	unsigned long		running[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
>  	int			enabled;
> +	unsigned long		enabled_events[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
>  
>  	int			n_events; /* the # of events in the below arrays */
>  	int			n_added;  /* the # last events in the below arrays;

> > Also, why do we need that whole enabled_events[] array. Do we really not
> > have that information elsewhere?
> 
> No. We don't have a case that several events share a counter at the same
> time. We don't need to check if other events are enabled when we try to
> disable a counter. So we don't save such information.
> But we have to do it for metrics events.

So you have x86_pmu.disable() clear the bit, and x86_pmu.enable() set
the bit, and then, if you look at arch/x86/events/core.c that doesn't
look redundant?

That is, explain to me how exactly this new enabled_events[] is different
from active_mask[].
