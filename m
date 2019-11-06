Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5632AC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 11:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 296282077C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 11:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730386AbfKFLhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 06:37:35 -0500
Received: from foss.arm.com ([217.140.110.172]:38380 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbfKFLhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 06:37:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48C0A7A7;
        Wed,  6 Nov 2019 03:37:34 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D70B3F6C4;
        Wed,  6 Nov 2019 03:37:32 -0800 (PST)
Date:   Wed, 6 Nov 2019 11:37:30 +0000
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
Subject: Re: [PATCH 2/2] Thunderx2, uncore: Add workaround for ThunderX2
 erratum 221
Message-ID: <20191106113730.GB50610@lakrids.cambridge.arm.com>
References: <1573002091-9744-1-git-send-email-gkulkarni@marvell.com>
 <1573002091-9744-3-git-send-email-gkulkarni@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573002091-9744-3-git-send-email-gkulkarni@marvell.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 01:01:41AM +0000, Ganapatrao Prabhakerrao Kulkarni wrote:
> When perf tried with more events than the PMU supported counters, the perf
> core uses event multiplexing to accommodate all events. This results in
> burst of PMU register read and writes and causes the system hang, when
> executed along with the CPU intensive applications.

Can you please elaborate on how a burst of PMU reads/writes leads to a
hang?

I see the PMU counts DMC/L3C events -- does this occur under heavy /cpu/
load, or heavy /memory/ load?

Does this only happen with a specific timing of reads/writes, or is it
always possible that accessing the PMU can trigger a lockup, and it's
just more likely when the PMU is accessed more often?

Thanks,
Mark.

> 
> Adding software workaround by disabling event multiplexing.
> 
> Signed-off-by: Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>
> ---
>  Documentation/admin-guide/perf/thunderx2-pmu.rst | 9 +++++++++
>  drivers/perf/thunderx2_pmu.c                     | 3 ++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/perf/thunderx2-pmu.rst b/Documentation/admin-guide/perf/thunderx2-pmu.rst
> index 08e33675853a..fff65382c887 100644
> --- a/Documentation/admin-guide/perf/thunderx2-pmu.rst
> +++ b/Documentation/admin-guide/perf/thunderx2-pmu.rst
> @@ -40,3 +40,12 @@ Examples::
>    uncore_l3c_0/read_hit/,\
>    uncore_l3c_0/inv_request/,\
>    uncore_l3c_0/inv_hit/ sleep 1
> +
> +ThunderX2 erratum 221:
> +When perf tried with more events than the PMU supported counters, the perf core
> +uses event multiplexing to accommodate all events. This results in burst of PMU
> +registers read and write and leading to system hang when executed along with
> +CPU intensive applications.
> +
> +
> +Disabling PMUs event multiplexing capability.
> diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
> index 43d76c85da56..c443be8bd449 100644
> --- a/drivers/perf/thunderx2_pmu.c
> +++ b/drivers/perf/thunderx2_pmu.c
> @@ -563,7 +563,8 @@ static int tx2_uncore_pmu_register(
>  		.start		= tx2_uncore_event_start,
>  		.stop		= tx2_uncore_event_stop,
>  		.read		= tx2_uncore_event_read,
> -		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
> +		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
> +					PERF_PMU_CAP_NO_MUX_EVENTS,
>  	};
>  
>  	tx2_pmu->pmu.name = devm_kasprintf(dev, GFP_KERNEL,
> -- 
> 2.17.1
> 
