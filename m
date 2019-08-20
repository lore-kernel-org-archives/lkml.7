Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BECC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DE632054F
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730632AbfHTPfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 11:35:04 -0400
Received: from foss.arm.com ([217.140.110.172]:43394 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730063AbfHTPfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 11:35:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E9B928;
        Tue, 20 Aug 2019 08:35:02 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34F753F246;
        Tue, 20 Aug 2019 08:35:01 -0700 (PDT)
Date:   Tue, 20 Aug 2019 16:34:51 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Raphael Gault <raphael.gault@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, acme@kernel.org, raph.gault+kdev@gmail.com
Subject: Re: [PATCH v3 3/5] arm64: pmu: Add function implementation to update
 event index in userpage.
Message-ID: <20190820153450.GA43412@lakrids.cambridge.arm.com>
References: <20190816125934.18509-1-raphael.gault@arm.com>
 <20190816125934.18509-4-raphael.gault@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816125934.18509-4-raphael.gault@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 01:59:32PM +0100, Raphael Gault wrote:
> In order to be able to access the counter directly for userspace,
> we need to provide the index of the counter using the userpage.
> We thus need to override the event_idx function to retrieve and
> convert the perf_event index to armv8 hardware index.
> 
> Since the arm_pmu driver can be used by any implementation, even
> if not armv8, two components play a role into making sure the
> behaviour is correct and consistent with the PMU capabilities:
> 
> * the ARMPMU_EL0_RD_CNTR flag which denotes the capability to access
> counter from userspace.
> * the event_idx call back, which is implemented and initialized by
> the PMU implementation: if no callback is provided, the default
> behaviour applies, returning 0 as index value.
> 
> Signed-off-by: Raphael Gault <raphael.gault@arm.com>
> ---
>  arch/arm64/kernel/perf_event.c | 22 ++++++++++++++++++++++
>  include/linux/perf/arm_pmu.h   |  2 ++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index a0b4f1bca491..9fe3f6909513 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -818,6 +818,22 @@ static void armv8pmu_clear_event_idx(struct pmu_hw_events *cpuc,
>  		clear_bit(idx - 1, cpuc->used_mask);
>  }
>  
> +static int armv8pmu_access_event_idx(struct perf_event *event)
> +{
> +	if (!(event->hw.flags & ARMPMU_EL0_RD_CNTR))
> +		return 0;
> +
> +	/*
> +	 * We remap the cycle counter index to 32 to
> +	 * match the offset applied to the rest of
> +	 * the counter indeces.

Typo: s/indeces/indices/

> +	 */
> +	if (event->hw.idx == ARMV8_IDX_CYCLE_COUNTER)
> +		return 32;
> +
> +	return event->hw.idx;
> +}
> +
>  /*
>   * Add an event filter to a given event.
>   */
> @@ -911,6 +927,9 @@ static int __armv8_pmuv3_map_event(struct perf_event *event,
>  	if (armv8pmu_event_is_64bit(event))
>  		event->hw.flags |= ARMPMU_EVT_64BIT;
>  
> +	if (!cpus_have_const_cap(ARM64_HAS_HETEROGENEOUS_PMU))
> +		event->hw.flags |= ARMPMU_EL0_RD_CNTR;
> +
>  	/* Only expose micro/arch events supported by this PMU */
>  	if ((hw_event_id > 0) && (hw_event_id < ARMV8_PMUV3_MAX_COMMON_EVENTS)
>  	    && test_bit(hw_event_id, armpmu->pmceid_bitmap)) {
> @@ -1031,6 +1050,8 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu)
>  	cpu_pmu->set_event_filter	= armv8pmu_set_event_filter;
>  	cpu_pmu->filter_match		= armv8pmu_filter_match;
>  
> +	cpu_pmu->pmu.event_idx		= armv8pmu_access_event_idx;
> +
>  	return 0;
>  }
>  
> @@ -1209,6 +1230,7 @@ void arch_perf_update_userpage(struct perf_event *event,
>  	 */
>  	freq = arch_timer_get_rate();
>  	userpg->cap_user_time = 1;
> +	userpg->cap_user_rdpmc = !!(event->hw.flags & ARMPMU_EL0_RD_CNTR);

For bisectability, we should only expose this to userspace once we have
the code to enable/disable it, so the code exposing the index and
setting up the user page cap needs to be added after the context switch
code.

Thanks,
Mark.

>  
>  	clocks_calc_mult_shift(&userpg->time_mult, &shift, freq,
>  			NSEC_PER_SEC, 0);
> diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
> index 71f525a35ac2..1106a9ac00fd 100644
> --- a/include/linux/perf/arm_pmu.h
> +++ b/include/linux/perf/arm_pmu.h
> @@ -26,6 +26,8 @@
>   */
>  /* Event uses a 64bit counter */
>  #define ARMPMU_EVT_64BIT		1
> +/* Allow access to hardware counter from userspace */
> +#define ARMPMU_EL0_RD_CNTR		2
>  
>  #define HW_OP_UNSUPPORTED		0xFFFF
>  #define C(_x)				PERF_COUNT_HW_CACHE_##_x
> -- 
> 2.17.1
> 
