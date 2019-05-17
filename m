Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EC4C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 13:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64B4520833
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 13:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbfEQNVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 09:21:30 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43528 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728100AbfEQNVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 09:21:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72B8A1715;
        Fri, 17 May 2019 06:21:29 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ECE1D3F5AF;
        Fri, 17 May 2019 06:21:27 -0700 (PDT)
Date:   Fri, 17 May 2019 14:21:25 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Raphael Gault <raphael.gault@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, acme@kernel.org
Subject: Re: [PATCH 3/6] arm64: pmu: Add function implementation to update
 event index in userpage.
Message-ID: <20190517132124.GB48991@lakrids.cambridge.arm.com>
References: <20190516132148.10085-1-raphael.gault@arm.com>
 <20190516132148.10085-4-raphael.gault@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516132148.10085-4-raphael.gault@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 02:21:45PM +0100, Raphael Gault wrote:
> In order to be able to access the counter directly for userspace,
> we need to provide the index of the counter using the userpage.
> We thus need to override the event_idx function to retrieve and
> convert the perf_event index to armv8 hardware index.

It would be worth noting that since the arm_pmu framework can be used
with other versions of the PMU architecture which could not permit safe
userspace access, we allow the arch code to opt-in with the
ARMPMU_EL0_RD_CNTR flag.

> Signed-off-by: Raphael Gault <raphael.gault@arm.com>
> ---
>  arch/arm64/kernel/perf_event.c |  4 ++++
>  drivers/perf/arm_pmu.c         | 10 ++++++++++
>  include/linux/perf/arm_pmu.h   |  2 ++
>  3 files changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index 6164d389eed6..e6316f99f66b 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -890,6 +890,8 @@ static int __armv8_pmuv3_map_event(struct perf_event *event,
>  	if (armv8pmu_event_is_64bit(event))
>  		event->hw.flags |= ARMPMU_EVT_64BIT;
>  
> +	event->hw.flags |= ARMPMU_EL0_RD_CNTR;
> +
>  	/* Only expose micro/arch events supported by this PMU */
>  	if ((hw_event_id > 0) && (hw_event_id < ARMV8_PMUV3_MAX_COMMON_EVENTS)
>  	    && test_bit(hw_event_id, armpmu->pmceid_bitmap)) {
> @@ -1188,6 +1190,8 @@ void arch_perf_update_userpage(struct perf_event *event,
>  	 */
>  	freq = arch_timer_get_rate();
>  	userpg->cap_user_time = 1;
> +	userpg->cap_user_rdpmc =
> +		!!(event->hw.flags & ARMPMU_EL0_RD_CNTR);

This is under 80 columns when placed on a single line, so it doesn't
need to be split here.

>  
>  	clocks_calc_mult_shift(&userpg->time_mult, &shift, freq,
>  			NSEC_PER_SEC, 0);
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index eec75b97e7ea..3f4c2ec7ff89 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -777,6 +777,15 @@ static void cpu_pmu_destroy(struct arm_pmu *cpu_pmu)
>  					    &cpu_pmu->node);
>  }
>  
> +
> +static int armpmu_event_idx(struct perf_event *event)
> +{
> +	if (!(event->hw.flags & ARMPMU_EL0_RD_CNTR))
> +		return 0;
> +
> +	return event->hw.idx;

I think this needs to remap ARMV8_IDX_CYCLE_COUNTER to 32, to match the
offset applie to the rest of counter indices.

Otherwise, this looks good to me.

Thanks,
Mark.

> +}
> +
>  static struct arm_pmu *__armpmu_alloc(gfp_t flags)
>  {
>  	struct arm_pmu *pmu;
> @@ -803,6 +812,7 @@ static struct arm_pmu *__armpmu_alloc(gfp_t flags)
>  		.start		= armpmu_start,
>  		.stop		= armpmu_stop,
>  		.read		= armpmu_read,
> +		.event_idx	= armpmu_event_idx,
>  		.filter_match	= armpmu_filter_match,
>  		.attr_groups	= pmu->attr_groups,
>  		/*
> diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
> index 4641e850b204..3bef390c1069 100644
> --- a/include/linux/perf/arm_pmu.h
> +++ b/include/linux/perf/arm_pmu.h
> @@ -30,6 +30,8 @@
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
