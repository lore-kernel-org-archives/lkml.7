Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F6FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7878C21917
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z6z0dtDC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfCUVOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 17:14:05 -0400
Received: from merlin.infradead.org ([205.233.59.134]:39736 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbfCUVOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 17:14:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MOISAbKcZMp+a43e5zNZ2EjZQPAnZv7zjRxMPZchaP8=; b=Z6z0dtDChmKTDoV29ELhL42ar
        refyfSIi6yAIPgeX4gT+T4DXQ4O4JwZ5Kfq6bMjGnTSy1zl9JQ62zIKfLk4FBTfXu/TpOlej7J6fx
        PAeS1+ScBujR82U42mh4EISXWp0uN1dRM3eesg4sIbqqkhWgIgfLohidR0kHciWydaPczseE/1BcH
        7ZCcA5jFbTP/NVvs/ETF1AhFMMts2s5OlSXhnTZv5VdpyT7VkGiWsHCE2+aFuxLd2wevu35zuflgb
        aWrYb64qzZyyEgOScdZVdJ4rmysHsVnuiFHav3Kek6lnQOqed74qL6YpAiluQSareBiiE9CMvRPEr
        ireOgtEpg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h750f-0002eN-99; Thu, 21 Mar 2019 21:13:57 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7B5B2984EEA; Thu, 21 Mar 2019 22:13:55 +0100 (CET)
Date:   Thu, 21 Mar 2019 22:13:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH V2 04/23] perf/x86/intel: Support adaptive PEBSv4
Message-ID: <20190321211355.GB7905@worktop.programming.kicks-ass.net>
References: <20190321205703.4256-1-kan.liang@linux.intel.com>
 <20190321205703.4256-5-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321205703.4256-5-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 01:56:44PM -0700, kan.liang@linux.intel.com wrote:
> @@ -1434,20 +1692,20 @@ static void __intel_pmu_pebs_event(struct perf_event *event,
>  		return;
>  
>  	while (count > 1) {
> -		setup_pebs_sample_data(event, iregs, at, &data, &regs);
> -		perf_event_output(event, &data, &regs);
> -		at += x86_pmu.pebs_record_size;
> +		x86_pmu.setup_pebs_sample_data(event, iregs, at, &data, regs);
> +		perf_event_output(event, &data, regs);
> +		at = next_pebs_record(at);
>  		at = get_next_pebs_record_by_bit(at, top, bit);
>  		count--;
>  	}
>  
> -	setup_pebs_sample_data(event, iregs, at, &data, &regs);
> +	x86_pmu.setup_pebs_sample_data(event, iregs, at, &data, regs);

If you make the setup_pebs_sample_data() a function pointer argument of
this function.

>  
>  	/*
>  	 * All but the last records are processed.
>  	 * The last one is left to be able to call the overflow handler.
>  	 */
> -	if (perf_event_overflow(event, &data, &regs)) {
> +	if (perf_event_overflow(event, &data, regs)) {
>  		x86_pmu_stop(event, 0);
>  		return;
>  	}
> @@ -1626,6 +1884,59 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs)
>  	}
>  }
>  
> +static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs)
> +{
> +	short counts[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +	struct debug_store *ds = cpuc->ds;
> +	struct perf_event *event;
> +	void *base, *at, *top;
> +	int bit, size;
> +	u64 mask;
> +
> +	if (!x86_pmu.pebs_active)
> +		return;
> +
> +	base = (struct pebs_basic *)(unsigned long)ds->pebs_buffer_base;
> +	top = (struct pebs_basic *)(unsigned long)ds->pebs_index;
> +
> +	ds->pebs_index = ds->pebs_buffer_base;
> +
> +	mask = ((1ULL << x86_pmu.max_pebs_events) - 1) |
> +	       (((1ULL << x86_pmu.num_counters_fixed) - 1) << INTEL_PMC_IDX_FIXED);
> +	size = INTEL_PMC_IDX_FIXED + x86_pmu.num_counters_fixed;
> +
> +	if (unlikely(base >= top)) {
> +		intel_pmu_pebs_event_update_no_drain(cpuc, size);
> +		return;
> +	}
> +
> +	for (at = base; at < top; at = next_pebs_record(at)) {
> +		u64 pebs_status;
> +
> +		pebs_status = get_pebs_status(at) & cpuc->pebs_enabled;
> +		pebs_status &= mask;
> +
> +		for_each_set_bit(bit, (unsigned long *)&pebs_status, size)
> +			counts[bit]++;
> +	}
> +
> +	for (bit = 0; bit < size; bit++) {
> +		if (counts[bit] == 0)
> +			continue;
> +
> +		event = cpuc->events[bit];
> +		if (WARN_ON_ONCE(!event))
> +			continue;
> +
> +		if (WARN_ON_ONCE(!event->attr.precise_ip))
> +			continue;
> +
> +		__intel_pmu_pebs_event(event, iregs, base,
> +				       top, bit, counts[bit]);

		__intel_pmu_pebs_event(event, iregs, base, top, bit,
				       count[bits], setup_adaptibe_pebs_sample_data);

> +	}
> +}

And we can do away with that x86_pmu method..
