Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E491C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EB0D22CED
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SEja0+k8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfH1Pbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 11:31:45 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48944 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbfH1Pbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 11:31:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BNOvFVq3jNzK7po4WBGMwj7ptEL02y2Z5cirivFEXtY=; b=SEja0+k8Fq+9+HoOuJ/QTTeRq
        Sdi8NfzyKIb1XhCeihX6HimJc3fej1rsijjdOZyaCKrlzDQvWustQUQmKT6+TMPUtDafC+Ytb9O3i
        4cYc1kq1o3kUuP04a3IzLamXbi9UlY+0VqksJOGFIhBkfVJpZMZEypyPp/mI9F3rEMzyRlcIVKSGk
        c1AawqDkjjmjQxBS/ITBjcJo2jd5oaj0vAX6V+JeWD4BTYWdyGSrCldz3efnMT3d8PSLxKuDphbQD
        mEtnRfl4QxnD57jR6xMk8XxJQxOlckwgKJqo4X90y/iAx0TpL7V0rHMIUxIu5Lfs2RfPYRvByeHIE
        yud6kHRDQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2zv2-000543-Qq; Wed, 28 Aug 2019 15:31:33 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id F131E980BFD; Wed, 28 Aug 2019 17:19:21 +0200 (CEST)
Date:   Wed, 28 Aug 2019 17:19:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [RESEND PATCH V3 3/8] perf/x86/intel: Support hardware TopDown
 metrics
Message-ID: <20190828151921.GD17205@worktop.programming.kicks-ass.net>
References: <20190826144740.10163-1-kan.liang@linux.intel.com>
 <20190826144740.10163-4-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826144740.10163-4-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 07:47:35AM -0700, kan.liang@linux.intel.com wrote:
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 54534ff00940..1ae23db5c2d7 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -76,6 +76,8 @@ u64 x86_perf_event_update(struct perf_event *event)
>  	if (idx == INTEL_PMC_IDX_FIXED_BTS)
>  		return 0;
>  
> +	if (is_topdown_count(event) && x86_pmu.update_topdown_event)
> +		return x86_pmu.update_topdown_event(event);

If is_topdown_count() is true; it had better bloody well have that
function. But I really hate this.

>  	/*
>  	 * Careful: an NMI might modify the previous event value.
>  	 *
> @@ -1003,6 +1005,10 @@ static int collect_events(struct cpu_hw_events *cpuc, struct perf_event *leader,
>  
>  	max_count = x86_pmu.num_counters + x86_pmu.num_counters_fixed;
>  
> +	/* There are 4 TopDown metrics events. */
> +	if (x86_pmu.intel_cap.perf_metrics)
> +		max_count += 4;

I'm thinking this is wrong.. this unconditionally allows collecting 4
extra events on every part that has this metrics crud on.

>  	/* current number of events already accepted */
>  	n = cpuc->n_events;
>  
> @@ -1184,6 +1190,10 @@ int x86_perf_event_set_period(struct perf_event *event)
>  	if (idx == INTEL_PMC_IDX_FIXED_BTS)
>  		return 0;
>  
> +	if (unlikely(is_topdown_count(event)) &&
> +	    x86_pmu.set_topdown_event_period)
> +		return x86_pmu.set_topdown_event_period(event);

Same as with the other method; and I similarly hates it.

> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index f4d6335a18e2..616313d7f3d7 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c

> +static int icl_set_topdown_event_period(struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	s64 left = local64_read(&hwc->period_left);
> +
> +	/*
> +	 * Clear PERF_METRICS and Fixed counter 3 in initialization.
> +	 * After that, both MSRs will be cleared for each read.
> +	 * Don't need to clear them again.
> +	 */
> +	if (left == x86_pmu.max_period) {
> +		wrmsrl(MSR_CORE_PERF_FIXED_CTR3, 0);
> +		wrmsrl(MSR_PERF_METRICS, 0);
> +		local64_set(&hwc->period_left, 0);
> +	}

This really doesn't make sense to me; if you set FIXED_CTR3 := 0, you'll
never trigger the overflow there; this then seems to suggest the actual
counter value is irrelevant. Therefore you don't actually need this.

> +
> +	perf_event_update_userpage(event);
> +
> +	return 0;
> +}
> +
> +static u64 icl_get_metrics_event_value(u64 metric, u64 slots, int idx)
> +{
> +	u32 val;
> +
> +	/*
> +	 * The metric is reported as an 8bit integer percentage

s/percentage/fraction/

percentage is 1/100, 8bit is 256.

> +	 * suming up to 0xff.
> +	 * slots-in-metric = (Metric / 0xff) * slots
> +	 */
> +	val = (metric >> ((idx - INTEL_PMC_IDX_FIXED_METRIC_BASE) * 8)) & 0xff;
> +	return  mul_u64_u32_div(slots, val, 0xff);

This really utterly blows.. I'd have wasted range to be able to do a
power-of-two fraction here. That is use 8 bits with a range [0,128].

But also; x86_64 seems to lack a sane implementation of that function,
and it currently compiles into utter crap (it can be 2 instructions).

> +}

> +/*
> + * Update all active Topdown events.
> + * PMU has to be disabled before calling this function.

Forgets to explain why...

> + */
