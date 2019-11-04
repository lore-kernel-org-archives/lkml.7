Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE2ECA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 16:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F7F2084D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 16:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbfKDQMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 11:12:17 -0500
Received: from foss.arm.com ([217.140.110.172]:46260 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728287AbfKDQMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 11:12:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A41E91FB;
        Mon,  4 Nov 2019 08:12:16 -0800 (PST)
Received: from localhost (e108754-lin.cambridge.arm.com [10.1.199.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 449153F71A;
        Mon,  4 Nov 2019 08:12:16 -0800 (PST)
Date:   Mon, 4 Nov 2019 16:12:14 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        rui.zhang@intel.com, edubezval@gmail.com, qperret@google.com,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
Subject: Re: [Patch v4 6/6] sched: thermal: Enable tuning of decay period
Message-ID: <20191104161035.GA6680@e108754-lin>
References: <1571776465-29763-1-git-send-email-thara.gopinath@linaro.org>
 <1571776465-29763-7-git-send-email-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571776465-29763-7-git-send-email-thara.gopinath@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thara,

On Tuesday 22 Oct 2019 at 16:34:25 (-0400), Thara Gopinath wrote:
> Thermal pressure follows pelt signas which means the
> decay period for thermal pressure is the default pelt
> decay period. Depending on soc charecteristics and thermal
> activity, it might be beneficial to decay thermal pressure
> slower, but still in-tune with the pelt signals.

I wonder if it can be beneficial to decay thermal pressure faster as
well.

This implementation makes 32 (LOAD_AVG_PERIOD) the minimum half-life
of the thermal pressure samples. This results in more than 100ms for a
sample to decay significantly and therefore let's say it can take more
than 100ms for capacity to return to (close to) max when the CPU is no
longer capped. This value seems high to me considering that a minimum
value should result in close to 'instantaneous' behaviour, when there
are thermal capping mechanisms that can react in ~20ms (hikey960 has a
polling delay of 25ms, if I'm remembering correctly).

I agree 32ms seems like a good default but given that you've made this
configurable as to give users options, I'm wondering if it would be
better to cover a wider range.

> One way to achieve this is to provide a command line parameter
> to set the decay coefficient to an integer between 0 and 10.
> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
> v3->v4:
> 	- Removed the sysctl setting to tune decay period and instead
> 	  introduced a command line parameter to control it. The rationale
> 	  here being changing decay period of a PELT signal runtime can
> 	  result in a skewed average value for atleast some cycles.
> 
>  Documentation/admin-guide/kernel-parameters.txt |  5 +++++
>  kernel/sched/thermal.c                          | 25 ++++++++++++++++++++++++-
>  2 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index a84a83f..61d7baa 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4273,6 +4273,11 @@
>  			incurs a small amount of overhead in the scheduler
>  			but is useful for debugging and performance tuning.
>  
> +	sched_thermal_decay_coeff=
> +			[KNL, SMP] Set decay coefficient for thermal pressure signal.
> +			Format: integer betweer 0 and 10
> +			Default is 0.
> +
>  	skew_tick=	[KNL] Offset the periodic timer tick per cpu to mitigate
>  			xtime_lock contention on larger systems, and/or RCU lock
>  			contention on all systems with CONFIG_MAXSMP set.
> diff --git a/kernel/sched/thermal.c b/kernel/sched/thermal.c
> index 0c84960..0da31e1 100644
> --- a/kernel/sched/thermal.c
> +++ b/kernel/sched/thermal.c
> @@ -10,6 +10,28 @@
>  #include "pelt.h"
>  #include "thermal.h"
>  
> +/**
> + * By default the decay is the default pelt decay period.
> + * The decay coefficient can change is decay period in
> + * multiples of 32.

This description has to be corrected as well, as per Peter's comment.

Also, it might be good not to use the value 32 directly but to mention
that the decay period is a shift of LOAD_AVG_PERIOD. If that changes,
the translation from decay shift to decay period below will change as
well.

Thank you,
Ionela.

> + *   Decay coefficient    Decay period(ms)
> + *	0			32
> + *	1			64
> + *	2			128
> + *	3			256
> + *	4			512
> + */
> +static int sched_thermal_decay_coeff;
> +
> +static int __init setup_sched_thermal_decay_coeff(char *str)
> +{
> +	if (kstrtoint(str, 0, &sched_thermal_decay_coeff))
> +		pr_warn("Unable to set scheduler thermal pressure decay coefficient\n");
> +
> +	return 1;
> +}
> +__setup("sched_thermal_decay_coeff=", setup_sched_thermal_decay_coeff);
> +
>  static DEFINE_PER_CPU(unsigned long, delta_capacity);
>  
>  /**
> @@ -40,6 +62,7 @@ void update_thermal_pressure(int cpu, u64 capped_freq_ratio)
>   */
>  void trigger_thermal_pressure_average(struct rq *rq)
>  {
> -	update_thermal_load_avg(rq_clock_task(rq), rq,
> +	update_thermal_load_avg(rq_clock_task(rq) >>
> +				sched_thermal_decay_coeff, rq,
>  				per_cpu(delta_capacity, cpu_of(rq)));
>  }
> -- 
> 2.1.4
> 
