Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1010C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 13:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1658214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 13:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SFFiQCGh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387808AbfG2NhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 09:37:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45596 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfG2NhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 09:37:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nc1vR72DXOdJh6mrrkAe1bWzaW6fJHbjX0xgnJfm7j0=; b=SFFiQCGhyIao7MxiKNZ/hx7Ws
        Mx6tLvHJQAJX7cG3lPKXsR7alS5OLP+LdN4+pNa+kNHSBX0Xu2luRqZFD6hMm3AmBRMnsEvDFPrOM
        qDXBaslFjHrvvGEbpvPiSLUt31pNv1qeZwSGzODfMl1cSkdiSTMASbRe9D74ATXWJAuQAATVpxBcE
        EulD7xy6gZdowVS/lsr2Dwi6M+ZEAYnv10yBQ4hLgg4xtU3yPOjb8P4o0PQ70+vfD9VFL7brQyqvc
        2eloijGAq6SFAIJp7OvE0khlbBhZCKbFRVJE4TUfbdcn21IdQoNmxodL0YukAu1LObuX5sfki2c7s
        gbXSy8S0w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hs5pr-0000wa-Eg; Mon, 29 Jul 2019 13:37:07 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 874B420AFFEAD; Mon, 29 Jul 2019 15:37:05 +0200 (CEST)
Date:   Mon, 29 Jul 2019 15:37:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kan.liang@linux.intel.com
Subject: Re: [PATCH v1 2/7] perf/x86/intel: Support PEBS output to PT
Message-ID: <20190729133705.GC31381@hirez.programming.kicks-ass.net>
References: <20190704160024.56600-1-alexander.shishkin@linux.intel.com>
 <20190704160024.56600-3-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704160024.56600-3-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 07:00:19PM +0300, Alexander Shishkin wrote:

> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index f0e4804515d8..a11924e20df3 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -869,6 +869,7 @@ int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
>  	unsigned long used_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
>  	struct perf_event *e;
>  	int n0, i, wmin, wmax, unsched = 0;
> +	int n_pebs_ds, n_pebs_pt;
>  	struct hw_perf_event *hwc;
>  
>  	bitmap_zero(used_mask, X86_PMC_IDX_MAX);
> @@ -884,6 +885,37 @@ int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
>  	if (cpuc->txn_flags & PERF_PMU_TXN_ADD)
>  		n0 -= cpuc->n_txn;
>  
> +	/*
> +	 * Check for PEBS->DS and PEBS->PT events.
> +	 * 1) They can't be scheduled simultaneously;
> +	 * 2) PEBS->PT events depend on a corresponding PT event
> +	 */
> +	for (i = 0, n_pebs_ds = 0, n_pebs_pt = 0; i < n; i++) {
> +		e = cpuc->event_list[i];
> +
> +		if (e->attr.precise_ip) {
> +			if (e->hw.flags & PERF_X86_EVENT_PEBS_VIA_PT) {
> +				/*
> +				 * New PEBS->PT event, check ->aux_event; if
> +				 * it's NULL, the group has been broken down
> +				 * and this event can't schedule any more.
> +				 */
> +				if (!cpuc->is_fake && i >= n0 && !e->aux_event)
> +					return -EINVAL;

How can this happen? Is this an artifact if creating a group, and then
destroying the group leader (the PT event) and then getting a bunch of
unschedulable events as remains?

> +				n_pebs_pt++;
> +			} else {
> +				n_pebs_ds++;
> +			}
> +		}
> +	}

This makes for the 3rd i..n iteration in a row, now the first is over
cpuc->event_constraint[], this is the second and the third isn't
guaranteed to terminate but is over both cpuc->event_list[] and
->event_constraint[].

It just feels like we can do better.

> +
> +	/*
> +	 * Fail to add conflicting PEBS events. If this happens, rotation
> +	 * takes care that all events get to run.
> +	 */
> +	if (n_pebs_ds && n_pebs_pt)
> +		return -EINVAL;

This basically means we can rewrite the above like:

	u8 pebs_pt = 0;

	if (e->attr.precise_ip) {
		bool pt = is_pebs_pt(e);

		if (pebs_pt & (1 << !pt))
			return -EINVAL;

		pebs_pt |= 1 << pt;
	}

There's no need to finish the loop or to actually count how many there
are; all we need to know is there's only one type.

Then again, if you put these counters in cpuc, you can make
collect_events() reject the event before we ever get to scheduling and
avoid the whole iteration.

> +
>  	if (x86_pmu.start_scheduling)
>  		x86_pmu.start_scheduling(cpuc);
>  

> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index bda450ff51ee..6955d4f7e7aa 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c

> @@ -3814,6 +3821,17 @@ static int intel_pmu_check_period(struct perf_event *event, u64 value)
>  	return intel_pmu_has_bts_period(event, value) ? -EINVAL : 0;
>  }
>  
> +static int intel_pmu_aux_source_match(struct perf_event *event)
> +{
> +	if (!x86_pmu.intel_cap.pebs_output_pt_available)
> +		return 0;
> +
> +	if (event->pmu->name && !strcmp(event->pmu->name, "intel_pt"))

Yuck, surely we can do something like:

	if (is_pt_event(event))

which is implemented in intel/pt.c and does something like:

	return event->pmu == &pt_pmu.pmu;

> +		return 1;
> +
> +	return 0;
> +}
> +
>  PMU_FORMAT_ATTR(offcore_rsp, "config1:0-63");
>  
>  PMU_FORMAT_ATTR(ldlat, "config1:0-15");

> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index 7acc526b4ad2..9c59462f38a3 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c

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

I thought we disallowed that from happening !?

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

