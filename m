Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F37C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 712D12081C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xrw0IB5e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfE1MUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 08:20:35 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49326 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbfE1MUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 08:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SZLEzd/xBAgLZb2PnTp1mexneqn8iaJZgoOM8hGMfXs=; b=xrw0IB5eEExm1vGadSi/294l6
        gfPvOKJZXjH3D6xl5D8lJHmgljmeUoMnZEP3gYviXlhKxe0IConyiI3HCNW0aHdIRqf85L7DukUN6
        kgGdsFzxSJS5SF9N/+9zgxcFERXoGv6ds2BKPZLfcprR8KqEr4+CdMWBiDCBUlO+SUnBhl+DO7LB/
        weS1V5PyHbHbbNm71Z429q3xCT2hIx/xfdsbRDg6VQ9Djdeb6s3qF//1jbg6z7AtMarmAR2Fln7pA
        MvUvyVHMK3dnylx/srMgmOC3mtg3Kx052i0+A/9Wy3dxrudOiAi5IOsWRaoZJ9GawMb+/HLuUMOdw
        FfFn9fGkQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVb5i-0003Kr-Oj; Tue, 28 May 2019 12:20:31 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6180A20750747; Tue, 28 May 2019 14:20:29 +0200 (CEST)
Date:   Tue, 28 May 2019 14:20:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH 3/9] perf/x86/intel: Support overflows on SLOTS
Message-ID: <20190528122029.GT2606@hirez.programming.kicks-ass.net>
References: <20190521214055.31060-1-kan.liang@linux.intel.com>
 <20190521214055.31060-4-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521214055.31060-4-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 02:40:49PM -0700, kan.liang@linux.intel.com wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> The internal counters used for the metrics can overflow. If this happens
> an overflow is triggered on the SLOTS fixed counter. Add special code
> that resets all the slave metric counters in this case.

The SDM also talked about a OVF_PERF_METRICS overflow bit. Which seems
to suggest something else.

> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  arch/x86/events/intel/core.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 75ed91a36413..a66dc761f09d 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -2279,12 +2279,35 @@ static void intel_pmu_add_event(struct perf_event *event)
>  		intel_pmu_lbr_add(event);
>  }
>  
> +/* When SLOTS overflowed update all the active topdown-* events */
> +static void intel_pmu_update_metrics(struct perf_event *event)
> +{
> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +	int idx;
> +	u64 slots_events;
> +
> +	slots_events = *(u64 *)cpuc->enabled_events & INTEL_PMC_MSK_ANY_SLOTS;
> +
> +	for_each_set_bit(idx, (unsigned long *)&slots_events, 64) {

	for (idx = INTEL_PMC_IDX_TD_RETIRING;
	     idx <= INTEL_PMC_IDX_TD_BE_BOUND; idx++)

perhaps?

> +		struct perf_event *ev = cpuc->events[idx];
> +
> +		if (ev == event)
> +			continue;
> +		x86_perf_event_update(event);

		if (ev != event)
			x86_perf_event_update(event)
> +	}
> +}
> +
>  /*
>   * Save and restart an expired event. Called by NMI contexts,
>   * so it has to be careful about preempting normal event ops:
>   */
>  int intel_pmu_save_and_restart(struct perf_event *event)
>  {
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	if (unlikely(hwc->reg_idx == INTEL_PMC_IDX_FIXED_SLOTS))
> +		intel_pmu_update_metrics(event);
> +
>  	x86_perf_event_update(event);
>  	/*
>  	 * For a checkpointed counter always reset back to 0.  This
> -- 
> 2.14.5
> 
