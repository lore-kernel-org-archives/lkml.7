Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E9BC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C6B4217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FZMeB9HY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfH1HwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 03:52:20 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45176 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfH1HwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 03:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8PXB9ABTilydihE3Gb8q5wBSvHgzk09E4AOCFNyrau0=; b=FZMeB9HYg0EdOqIfg+1qQDPLZ
        afrYplqiqSjtey2IRkZVwoXK97TMHQqxayKBYPdFutEKZiNZDCHlouRFK8mlKMKgUJB1Ev2oQFLeZ
        9uJ2Ls2j5K3CSiV9+3ucaI5Ul8KrClL5oAka19IoJffJ2HhA/NKKHTOt7tXbMX/8Or3VvE5kAANaH
        5Hh4svanf148HExDc3v0UyZM44UWOHTkFxVC50Vvzo46nkLvgDXu60pqTwbU8feumpEw5VMVxQUh4
        DTXa38yP/3v0IyDuAeI+h6GaNKMLdXbjMWULduwHrtXvikShD0Javi0NkjGZq+UHFrqfRzVB+Mbp0
        1VddxzBZA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2skZ-0007FC-Hd; Wed, 28 Aug 2019 07:52:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D381A3070F4;
        Wed, 28 Aug 2019 09:51:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B7AC020230B05; Wed, 28 Aug 2019 09:52:13 +0200 (CEST)
Date:   Wed, 28 Aug 2019 09:52:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [RESEND PATCH V3 2/8] perf/x86/intel: Basic support for metrics
 counters
Message-ID: <20190828075213.GB2369@hirez.programming.kicks-ass.net>
References: <20190826144740.10163-1-kan.liang@linux.intel.com>
 <20190826144740.10163-3-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826144740.10163-3-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 07:47:34AM -0700, kan.liang@linux.intel.com wrote:

> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 81b005e4c7d9..54534ff00940 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -1033,18 +1033,30 @@ static inline void x86_assign_hw_event(struct perf_event *event,
>  				struct cpu_hw_events *cpuc, int i)
>  {
>  	struct hw_perf_event *hwc = &event->hw;
> +	int reg_idx;
>  
>  	hwc->idx = cpuc->assign[i];
>  	hwc->last_cpu = smp_processor_id();
>  	hwc->last_tag = ++cpuc->tags[i];
>  
> +	/*
> +	 * Metrics counters use different indexes in the scheduler
> +	 * versus the hardware.
> +	 *
> +	 * Map metrics to fixed counter 3 (which is the base count),
> +	 * but the update event callback reads the extra metric register
> +	 * and converts to the right metric.
> +	 */
> +	reg_idx = get_reg_idx(hwc->idx);
> +
>  	if (hwc->idx == INTEL_PMC_IDX_FIXED_BTS) {
>  		hwc->config_base = 0;
>  		hwc->event_base	= 0;
>  	} else if (hwc->idx >= INTEL_PMC_IDX_FIXED) {
>  		hwc->config_base = MSR_ARCH_PERFMON_FIXED_CTR_CTRL;
> -		hwc->event_base = MSR_ARCH_PERFMON_FIXED_CTR0 + (hwc->idx - INTEL_PMC_IDX_FIXED);
> -		hwc->event_base_rdpmc = (hwc->idx - INTEL_PMC_IDX_FIXED) | 1<<30;
> +		hwc->event_base = MSR_ARCH_PERFMON_FIXED_CTR0 +
> +				  (reg_idx - INTEL_PMC_IDX_FIXED);
> +		hwc->event_base_rdpmc = (reg_idx - INTEL_PMC_IDX_FIXED) | 1<<30;
>  	} else {
>  		hwc->config_base = x86_pmu_config_addr(hwc->idx);
>  		hwc->event_base  = x86_pmu_event_addr(hwc->idx);

That reg_idx is a pointless unconditional branch; better to write it
like:

static inline void x86_assign_hw_event(struct perf_event *event,
				struct cpu_hw_events *cpuc, int i)
{
	struct hw_perf_event *hwc = &event->hw;
	int idx;

	idx = hwc->idx = cpuc->assign[i];
	hwc->last_cpu = smp_processor_id();
	hwc->last_tag = ++cpuc->tags[i];

	switch (hwc->idx) {
	case INTEL_PMC_IDX_FIXED_BTS:
		hwc->config_base = 0;
		hwc->event_base	= 0;
		break;

	case INTEL_PMC_IDX_FIXED_METRIC_BASE ... INTEL_PMC_IDX_FIXED_METRIC_BASE+3:
		/* All METRIC events are mapped onto the fixed SLOTS counter */
		idx = INTEL_PMC_IDX_FIXED_SLOTS;

	case INTEL_PMC_IDX_FIXED ... INTEL_PMC_IDX_FIXED_METRIC_BASE-1:
		hwc->config_base = MSR_ARCH_PERFMON_FIXED_CTR_CTRL;
		hwc->event_base = MSR_ARCH_PERFMON_FIXED_CTR0 +
				  (idx - INTEL_PMC_IDX_FIXED);
		hwc->event_base_rdpmc = (idx - INTEL_PMC_IDX_FIXED) | 1<<30;
		break;

	default:
		hwc->config_base = x86_pmu_config_addr(hwc->idx);
		hwc->event_base = x86_pmu_event_addr(hwc->idx);
		hwc->event_base_rdpmc = x86_pmu_rdpmc_index(hwc->idx);
		break;
	}
}

On that; wth does this to the RDPMC userspace support!? Does that even
work with these counters?
