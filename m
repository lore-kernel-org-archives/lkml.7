Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8868FC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 08:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C0221929
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 08:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s9GNFshb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730324AbfKFI1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 03:27:39 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41920 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729951AbfKFI1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 03:27:39 -0500
Received: by mail-lf1-f68.google.com with SMTP id j14so17322238lfb.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 00:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wU786Awcjz+6BSkvh6Je1o6qXR7QFvkpKoodPXBut84=;
        b=s9GNFshb9nAwn/bv6cCM8g+T5gn5Rc+IG0iKjtgg3S1cYLkuCkx5GavWDIHU0uZJ3K
         8yrpWzfq7qEJIFyDL/3n4m9Rup++Ji2eLKTAX8UHqBmV3jSDara7Kpg3oHnlPvcZS/Rk
         eT57j2ZQ0VApzIDT+eosMzV02inMXeLyP5blWfsfeu3XoeQZ9TueE9opm4dVOD8lxCf4
         5vKI2V41SKH5JnBI9uBcW2W5JhaXuuKPTbJy9CSumBCnjSCMT/L+c3yFxRRG+VQOfaYe
         5g/nAFHuQ4/QlZD0z6qYqzm2AtyDC2OlUce5kAdD0DkoFf6kcH/g4drayoNxAnb38WBj
         UskQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wU786Awcjz+6BSkvh6Je1o6qXR7QFvkpKoodPXBut84=;
        b=qnsqTX8Pzn+yghy3sQb0KFKg79pig7g3oG8rAyLQWirgpxytx5fwma0SK5B0kh127z
         v6no8UeKo9nFp92A9JVjpmFIUAteXu8sjwV4v/XgjEq/+n1V8c6GxUOGMQEo/7vMmfdZ
         ZHWS/ZE/KZ/cRYuKryavGKATJwDdDavR+x7hTwNHLrkVAb6sK8F7f2630zg36I1hpuEe
         aO4uRXZv0wFzKNWHx/2BS0jb5+EKiGNTC5AWAFKsHIDjmK7lT4TYxtWp8VVvwYrKaA04
         SPcQRxAWDr6KLBP0jcHdsxUZSiDJlmwHScut/FRSxPp1U2NGyzdtRmFnSCwNRHNaW6bm
         TmUA==
X-Gm-Message-State: APjAAAVD8atkSrsHW5NQsgP9kPnCifAIT20+aRkNXEI4p0jSR1xH22q/
        sODGw8CEHZtvCWnivNkEmHLN+CtPguhmDyraiI6/Eg==
X-Google-Smtp-Source: APXvYqzMPulg84uWK0w+cm+98LMbTv/olVPFsmQAip52riq3jM0NFQRKfuA8pfRa4RE7HyFmQNp4Fru5nXDMEQUCS0A=
X-Received: by 2002:ac2:4650:: with SMTP id s16mr24761323lfo.32.1573028854869;
 Wed, 06 Nov 2019 00:27:34 -0800 (PST)
MIME-Version: 1.0
References: <1572979786-20361-1-git-send-email-thara.gopinath@linaro.org> <1572979786-20361-3-git-send-email-thara.gopinath@linaro.org>
In-Reply-To: <1572979786-20361-3-git-send-email-thara.gopinath@linaro.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 6 Nov 2019 09:27:23 +0100
Message-ID: <CAKfTPtCQXSoR5ohpJvT+esAeXewRDFoBEGGzfgB37_ZWJuKjeQ@mail.gmail.com>
Subject: Re: [Patch v5 2/6] sched/fair: Add infrastructure to store and update
 instantaneous thermal pressure
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Quentin Perret <qperret@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thara,


On Tue, 5 Nov 2019 at 19:49, Thara Gopinath <thara.gopinath@linaro.org> wrote:
>
> Add interface APIs to initialize, update/average, track, accumulate
> and decay thermal pressure per cpu basis. A per cpu variable
> thermal_pressure is introduced to keep track of instantaneous per
> cpu thermal pressure. Thermal pressure is the delta between maximum
> capacity and capped capacity due to a thermal event.
> API trigger_thermal_pressure_average is called for periodic accumulate
> and decay of the thermal pressure.This API passes on the instantaneous
> thermal pressure of a cpu to update_thermal_load_avg to do the necessary
> accumulate, decay and average.
> API update_thermal_pressure is for the system to update the thermal
> pressure by providing a capped maximum capacity.
> Considering, trigger_thermal_pressure_average reads thermal_pressure and
> update_thermal_pressure writes into thermal_pressure, one can argue for
> some sort of locking mechanism to avoid a stale value.
> But considering trigger_thermal_pressure_average can be called from a
> system critical path like scheduler tick function, a locking mechanism
> is not ideal. This means that it is possible the thermal_pressure value
> used to calculate average thermal pressure for a cpu can be
> stale for upto 1 tick period.
>
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>
> v3->v4:
>         - Dropped per cpu max_capacity_info struct and instead added a per
>           delta_capacity variable to store the delta between maximum
>           capacity and capped capacity. The delta is now calculated when
>           thermal pressure is updated and not every tick.
>         - Dropped populate_max_capacity_info api as only per cpu delta
>           capacity is stored.
>         - Renamed update_periodic_maxcap to
>           trigger_thermal_pressure_average and update_maxcap_capacity to
>           update_thermal_pressure.
> v4->v5:
>         - As per Peter's review comments folded thermal.c into fair.c.
>         - As per Ionela's review comments revamped update_thermal_pressure
>           to take maximum available capacity as input instead of maximum
>           capped frequency ration.
>
> ---
>  include/linux/sched.h |  9 +++++++++
>  kernel/sched/fair.c   | 37 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 46 insertions(+)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 263cf08..3c31084 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1993,6 +1993,15 @@ static inline void rseq_syscall(struct pt_regs *regs)
>
>  #endif
>
> +#ifdef CONFIG_SMP
> +void update_thermal_pressure(int cpu, unsigned long capped_capacity);
> +#else
> +static inline void
> +update_thermal_pressure(int cpu, unsigned long capped_capacity)
> +{
> +}
> +#endif
> +
>  const struct sched_avg *sched_trace_cfs_rq_avg(struct cfs_rq *cfs_rq);
>  char *sched_trace_cfs_rq_path(struct cfs_rq *cfs_rq, char *str, int len);
>  int sched_trace_cfs_rq_cpu(struct cfs_rq *cfs_rq);
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 682a754..2e907cc 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -86,6 +86,12 @@ static unsigned int normalized_sysctl_sched_wakeup_granularity       = 1000000UL;
>
>  const_debug unsigned int sysctl_sched_migration_cost   = 500000UL;
>
> +/*
> + * Per-cpu instantaneous delta between maximum capacity
> + * and maximum available capacity due to thermal events.
> + */
> +static DEFINE_PER_CPU(unsigned long, thermal_pressure);
> +
>  #ifdef CONFIG_SMP
>  /*
>   * For asym packing, by default the lower numbered CPU has higher priority.
> @@ -10401,6 +10407,37 @@ static unsigned int get_rr_interval_fair(struct rq *rq, struct task_struct *task
>         return rr_interval;
>  }
>
> +#ifdef CONFIG_SMP
> +/**
> + * update_thermal_pressure: Update thermal pressure
> + * @cpu: the cpu for which thermal pressure is to be updated for
> + * @capped_capacity: maximum capacity of the cpu after the capping
> + *                  due to thermal event.
> + *
> + * Delta between the arch_scale_cpu_capacity and capped max capacity is
> + * stored in per cpu thermal_pressure variable.
> + */
> +void update_thermal_pressure(int cpu, unsigned long capped_capacity)
> +{
> +       unsigned long delta;
> +
> +       delta = arch_scale_cpu_capacity(cpu) - capped_capacity;
> +       per_cpu(thermal_pressure, cpu) = delta;

use WRITE_ONCE

> +}
> +#endif
> +
> +/**
> + * trigger_thermal_pressure_average: Trigger the thermal pressure accumulate
> + *                                  and average algorithm
> + */
> +static void trigger_thermal_pressure_average(struct rq *rq)
> +{
> +#ifdef CONFIG_SMP
> +       update_thermal_load_avg(rq_clock_task(rq), rq,
> +                               per_cpu(thermal_pressure, cpu_of(rq)));
> +#endif
> +}
> +
>  /*
>   * All the scheduling class methods:
>   */
> --
> 2.1.4
>
