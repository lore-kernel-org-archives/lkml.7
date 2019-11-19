Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F208C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 10:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1151208D4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 10:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="TReeyc+4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbfKSKvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 05:51:37 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:40321 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbfKSKvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 05:51:36 -0500
Received: by mail-vs1-f66.google.com with SMTP id m9so13875675vsq.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 02:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qqVCqWV0gq/yuZPLqViM0uPHvIcCGNlGcIEn07A4a8s=;
        b=TReeyc+4LNVp7Jbhwu2GXSLf8PLCrM3e2j9URpSqZT4z/2ND/KzmF5Gzx4IBrCY6di
         9otq56lE8QnRHWusOWx7JdYBHfXw14BHmiiTDryhXwS1wFBV5tQQLMYj/BkBXuvbd0PB
         89KI9PGYcK11qdropyRc3irJZsp5upaeb3de8X8QBc9MAy4FqPYEoRlgd8qQJYsM0U3+
         fqDvIkuZkukReyQRlD5ppfm0gToviMnRMpqQtX1o9/oxEW28wakCX+jliIqjDqXQ7+jA
         5YkKblYLclv6RqMHbyJAw0ALhPgNuCfKA5mLdagabVG+JTYskcC8a+H13BC1SSZk16oW
         eHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qqVCqWV0gq/yuZPLqViM0uPHvIcCGNlGcIEn07A4a8s=;
        b=p+qtJaeeHVZkEPIaq4ndRVbd1k4tkdrmkW6p7dGSbSLCC2hYSys7Tg+Zlyt2jYxf7J
         VW5P4B7CX6evQy5nQDxDx8ZfRKb4AO33SJkYOg1+5tHv24eDje/HxBXtM+1WuqWUbimP
         I84UCNhdn1tmUJOhyqxWqWc4PQORuxIqTfUT8VJq3/vowsRqa88kw1SGXTbeeH05buTX
         5o68PWeWlbeIJmGq0WH50jIZU/vswdwHsfqkFjIYfImHMnw37I0c+agGjF25GJJ/CjUp
         wLXJ+iEZ4f4icLejlswQ86WbcUuUCbeDocKWPHdfx7rNxm53CFuXRf1NQN0+9kbqHTFv
         1ldQ==
X-Gm-Message-State: APjAAAWJNZ8t6FyQ3a3bV5RtKnCemtJ1o4Ic9ZkBOlwC9VQZyejayIyK
        Ra6c08JCEVKHJipcwDKPkOUeIU/f1l1sNNNJdnK47A==
X-Google-Smtp-Source: APXvYqwfAkJzO3J9pvR8lrGpKrbudiYwpS6CLhQGlAISmqO2kYgDOmQ5sFh2WG4vW6VbX2tGYi135/wwTW9SaQdx/wQ=
X-Received: by 2002:a67:fb0a:: with SMTP id d10mr21608087vsr.27.1574160693728;
 Tue, 19 Nov 2019 02:51:33 -0800 (PST)
MIME-Version: 1.0
References: <1572979786-20361-1-git-send-email-thara.gopinath@linaro.org> <1572979786-20361-3-git-send-email-thara.gopinath@linaro.org>
In-Reply-To: <1572979786-20361-3-git-send-email-thara.gopinath@linaro.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Tue, 19 Nov 2019 16:21:22 +0530
Message-ID: <CAHLCerPF-K2nOm7SsK7BPkMKZqCx7QGLfOtcnQvObWhGrwhP3g@mail.gmail.com>
Subject: Re: [Patch v5 2/6] sched/fair: Add infrastructure to store and update
 instantaneous thermal pressure
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, ionela.voinescu@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>, qperret@google.com,
        LKML <linux-kernel@vger.kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 6, 2019 at 12:20 AM Thara Gopinath
<thara.gopinath@linaro.org> wrote:
>
> Add interface APIs to initialize, update/average, track, accumulate
> and decay thermal pressure per cpu basis. A per cpu variable

*on a* per cpu basis.

> thermal_pressure is introduced to keep track of instantaneous per
> cpu thermal pressure. Thermal pressure is the delta between maximum
> capacity and capped capacity due to a thermal event.
> API trigger_thermal_pressure_average is called for periodic accumulate

s/accumulate/accumulation

> and decay of the thermal pressure.This API passes on the instantaneous
> thermal pressure of a cpu to update_thermal_load_avg to do the necessary
> accumulate, decay and average.

s/accumulate/accumulation

Add blank line here.

> API update_thermal_pressure is for the system to update the thermal
> pressure by providing a capped maximum capacity.

This is redundant given the below sentence.

> Considering, trigger_thermal_pressure_average reads thermal_pressure and

Lose the comma.

> update_thermal_pressure writes into thermal_pressure, one can argue for
> some sort of locking mechanism to avoid a stale value.
> But considering trigger_thermal_pressure_average can be called from a
> system critical path like scheduler tick function, a locking mechanism
> is not ideal. This means that it is possible the thermal_pressure value
> used to calculate average thermal pressure for a cpu can be
> stale for upto 1 tick period.

Please consider reflowing all your patch descriptions to make the
paragraphs better aligned and easier to read. Leave a blank line
between paragraphs.

In vim, you can do :gqap at each paragraph.


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

Any reason you to save to delta first and then to the per-cpu
variable? Just make it

    per_cpu(thermal_pressure, cpu) = arch_scale_cpu_capacity(cpu) -
capped_capacity;

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
