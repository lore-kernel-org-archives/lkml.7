Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD8FC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 11:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EAAD20659
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 11:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730339AbfKFL2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 06:28:40 -0500
Received: from foss.arm.com ([217.140.110.172]:38280 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbfKFL2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 06:28:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED8BC7A7;
        Wed,  6 Nov 2019 03:28:38 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B3DC83F6C4;
        Wed,  6 Nov 2019 03:28:37 -0800 (PST)
Date:   Wed, 6 Nov 2019 11:28:29 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "will@kernel.org" <will@kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "gklkml16@gmail.com" <gklkml16@gmail.com>
Subject: Re: [PATCH 1/2] perf/core: Adding capability to disable PMUs event
 multiplexing
Message-ID: <20191106112810.GA50610@lakrids.cambridge.arm.com>
References: <1573002091-9744-1-git-send-email-gkulkarni@marvell.com>
 <1573002091-9744-2-git-send-email-gkulkarni@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573002091-9744-2-git-send-email-gkulkarni@marvell.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 01:01:40AM +0000, Ganapatrao Prabhakerrao Kulkarni wrote:
> When PMUs are registered, perf core enables event multiplexing
> support by default. There is no provision for PMUs to disable
> event multiplexing, if PMUs want to disable due to unavoidable
> circumstances like hardware errata etc.
> 
> Adding PMU capability flag PERF_PMU_CAP_NO_MUX_EVENTS and support
> to allow PMUs to explicitly disable event multiplexing.

Even without multiplexing, this PMU activity can happen when switching
tasks, or when creating/destroying events, so as-is I don't think this
makes much sense.

If there's an erratum whereby heavy access to the PMU can lockup the
core, and it's possible to workaround that by minimzing accesses, that
should be done in the back-end PMU driver.

Either way, this minimzes the utility of the PMU.

Thanks,
Mark.

> 
> Signed-off-by: Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>
> ---
>  include/linux/perf_event.h | 1 +
>  kernel/events/core.c       | 8 ++++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 61448c19a132..9e18d841daf7 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -247,6 +247,7 @@ struct perf_event;
>  #define PERF_PMU_CAP_HETEROGENEOUS_CPUS		0x40
>  #define PERF_PMU_CAP_NO_EXCLUDE			0x80
>  #define PERF_PMU_CAP_AUX_OUTPUT			0x100
> +#define PERF_PMU_CAP_NO_MUX_EVENTS		0x200
>  
>  /**
>   * struct pmu - generic performance monitoring unit
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 4655adbbae10..65452784f81c 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -1092,6 +1092,10 @@ static void __perf_mux_hrtimer_init(struct perf_cpu_context *cpuctx, int cpu)
>  	if (pmu->task_ctx_nr == perf_sw_context)
>  		return;
>  
> +	/* No PMU support */
> +	if (pmu->capabilities & PERF_PMU_CAP_NO_MUX_EVENTS)
> +		return 0;
> +
>  	/*
>  	 * check default is sane, if not set then force to
>  	 * default interval (1/tick)
> @@ -1117,6 +1121,10 @@ static int perf_mux_hrtimer_restart(struct perf_cpu_context *cpuctx)
>  	if (pmu->task_ctx_nr == perf_sw_context)
>  		return 0;
>  
> +	/* No PMU support */
> +	if (pmu->capabilities & PERF_PMU_CAP_NO_MUX_EVENTS)
> +		return 0;
> +
>  	raw_spin_lock_irqsave(&cpuctx->hrtimer_lock, flags);
>  	if (!cpuctx->hrtimer_active) {
>  		cpuctx->hrtimer_active = 1;
> -- 
> 2.17.1
> 
