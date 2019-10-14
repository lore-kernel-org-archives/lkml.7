Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE17BECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 15:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5C93217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 15:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C0zDPBy8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730208AbfJNPuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 11:50:22 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38629 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730000AbfJNPuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 11:50:22 -0400
Received: by mail-lj1-f196.google.com with SMTP id b20so17154017ljj.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 08:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HhOsQy6UHZi94Qo2wix25ACjhisSG2e6KieU8k6VH3Q=;
        b=C0zDPBy8mKMNrihW6Sq0nwwwQIZChvyeeM+Dbnsl3m0ERXia0RgQ2VralaYgTsV2rb
         XO/figIHm4DV1I7V51KkKqqXU5zNAhSKtVFBKblzH+AQbjgHYo/hmCq4Q00DRhgkX301
         B/xIl+49oYAiJZa73xrXGMqPks7u4JYH3Vn5d6maOgyZArcIUGECCuW2B2lOAC4wXwIb
         VEJMbW7wmlMB3WX6NVdXOgI0E/CzJ6MMU2XsfeGHlYLb3JixQ5StsB5MqPuBMpJGwZPl
         kaV0VDMwsM34T3qi1jWJWTOYLLhwy7CZciEDHbr4NHIBqU/ftO8ZT0Sph4tF7yYLDKzm
         IAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HhOsQy6UHZi94Qo2wix25ACjhisSG2e6KieU8k6VH3Q=;
        b=cU0XLWIHBpQDleMTAEUVMo5a6YH8zIcT++i7fV3gnrFX70h0rzCXNE8qgvjpn6nNoN
         eX8h4Op/jLOqZuJWJw9f7WGjohtAPUep7c7eDrlYXp7CSyqp1G39s/0mLaYwGtIQEpaV
         YQ1KaRkFtW3GbrOKnKt0zypH/P4CoXr1X+3wBv3pGptKUPhB21XYlivYU+bZB19XAcI9
         qrYarrYuhKE5w6Tz09uRlXm2IddeJelVClXJhjwbWt+Krg6RlEbdP5bYMMsxWQEQnkdh
         7YYOyg/uXtlJufnqQpRhXOswHq3q8Cm3sKu2ZQuoHNrNDh8S6kuC1+ZJmhVV6iNoXIIA
         9TQg==
X-Gm-Message-State: APjAAAWvM8QpVkU5plTN5QAP5tuja6ysmEFfLehBOYT11ilvtHoOdFjb
        LeAjW9MIlUNrOh9Da6JTUkFDNPEfNMiF7/RdX+ztpw==
X-Google-Smtp-Source: APXvYqyGGT4p5iD0whTneLAnUP1BEE6yVINOsWRZ/mAzh6C/av4Aihrjic4w07E8SB/KbIKOL67TvhL/4M/jaV2ewnM=
X-Received: by 2002:a05:651c:112e:: with SMTP id e14mr18845994ljo.193.1571068217836;
 Mon, 14 Oct 2019 08:50:17 -0700 (PDT)
MIME-Version: 1.0
References: <1571014705-19646-1-git-send-email-thara.gopinath@linaro.org> <1571014705-19646-3-git-send-email-thara.gopinath@linaro.org>
In-Reply-To: <1571014705-19646-3-git-send-email-thara.gopinath@linaro.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 14 Oct 2019 17:50:06 +0200
Message-ID: <CAKfTPtD13=7VNvZBt9nMwMTg=_2xfJsEAApfFKagwKikh9g6-Q@mail.gmail.com>
Subject: Re: [Patch v3 2/7] sched: Add infrastructure to store and update
 instantaneous thermal pressure
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
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

On Mon, 14 Oct 2019 at 02:58, Thara Gopinath <thara.gopinath@linaro.org> wrote:
>
> Add thermal.c and thermal.h files that provides interface
> APIs to initialize, update/average, track, accumulate and decay
> thermal pressure per cpu basis. A per cpu structure max_capacity_info is
> introduced to keep track of instantaneous per cpu thermal pressure.
> Thermal pressure is the delta between max_capacity and cap_capacity.
> API update_periodic_maxcap is called for periodic accumulate and decay
> of the thermal pressure. It is to to be called from a periodic tick
> function. This API calculates the delta between max_capacity and
> cap_capacity and passes on the delta to update_thermal_avg to do the
> necessary accumulate, decay and average. API update_maxcap_capacity is for
> the system to update the thermal pressure by updating cap_capacity.
> Considering, update_periodic_maxcap reads cap_capacity and
> update_maxcap_capacity writes into cap_capacity, one can argue for
> some sort of locking mechanism to avoid a stale value.
> But considering update_periodic_maxcap can be called from a system
> critical path like scheduler tick function, a locking mechanism is not
> ideal. This means that it is possible the value used to
> calculate average thermal pressure for a cpu can be stale for upto 1
> tick period.
>
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>  include/linux/sched.h  | 14 +++++++++++
>  kernel/sched/Makefile  |  2 +-
>  kernel/sched/thermal.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  kernel/sched/thermal.h | 13 ++++++++++
>  4 files changed, 94 insertions(+), 1 deletion(-)
>  create mode 100644 kernel/sched/thermal.c
>  create mode 100644 kernel/sched/thermal.h
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 2c2e56b..875ce2b 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1983,6 +1983,20 @@ static inline void rseq_syscall(struct pt_regs *regs)
>
>  #endif
>
> +#ifdef CONFIG_SMP
> +void update_maxcap_capacity(int cpu, u64 capacity);
> +
> +void populate_max_capacity_info(void);
> +#else
> +static inline void update_maxcap_capacity(int cpu, u64 capacity)
> +{
> +}
> +
> +static inline void populate_max_capacity_info(void)
> +{
> +}
> +#endif
> +
>  const struct sched_avg *sched_trace_cfs_rq_avg(struct cfs_rq *cfs_rq);
>  char *sched_trace_cfs_rq_path(struct cfs_rq *cfs_rq, char *str, int len);
>  int sched_trace_cfs_rq_cpu(struct cfs_rq *cfs_rq);
> diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
> index 21fb5a5..4d3b820 100644
> --- a/kernel/sched/Makefile
> +++ b/kernel/sched/Makefile
> @@ -20,7 +20,7 @@ obj-y += core.o loadavg.o clock.o cputime.o
>  obj-y += idle.o fair.o rt.o deadline.o
>  obj-y += wait.o wait_bit.o swait.o completion.o
>
> -obj-$(CONFIG_SMP) += cpupri.o cpudeadline.o topology.o stop_task.o pelt.o
> +obj-$(CONFIG_SMP) += cpupri.o cpudeadline.o topology.o stop_task.o pelt.o thermal.o
>  obj-$(CONFIG_SCHED_AUTOGROUP) += autogroup.o
>  obj-$(CONFIG_SCHEDSTATS) += stats.o
>  obj-$(CONFIG_SCHED_DEBUG) += debug.o
> diff --git a/kernel/sched/thermal.c b/kernel/sched/thermal.c
> new file mode 100644
> index 0000000..5f0b2d4
> --- /dev/null
> +++ b/kernel/sched/thermal.c
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Sceduler Thermal Interactions
> + *
> + *  Copyright (C) 2018 Linaro, Inc., Thara Gopinath <thara.gopinath@linaro.org>
> + */
> +
> +#include <linux/sched.h>
> +#include "sched.h"
> +#include "pelt.h"
> +#include "thermal.h"
> +
> +struct max_capacity_info {
> +       unsigned long max_capacity;
> +       unsigned long cap_capacity;
> +};
> +
> +static DEFINE_PER_CPU(struct max_capacity_info, max_cap);
> +
> +void update_maxcap_capacity(int cpu, u64 capacity)
> +{
> +       struct max_capacity_info *__max_cap;
> +       unsigned long __capacity;
> +
> +       __max_cap = (&per_cpu(max_cap, cpu));
> +       if (!__max_cap) {
> +               pr_err("no max_capacity_info structure for cpu %d\n", cpu);
> +               return;
> +       }
> +
> +       /* Normalize the capacity */
> +       __capacity = (capacity * arch_scale_cpu_capacity(cpu)) >>
> +                                                       SCHED_CAPACITY_SHIFT;
> +       pr_debug("updating cpu%d capped capacity from %lu to %lu\n", cpu, __max_cap->cap_capacity, __capacity);
> +
> +       __max_cap->cap_capacity = __capacity;
> +}
> +
> +void populate_max_capacity_info(void)
> +{
> +       struct max_capacity_info *__max_cap;
> +       u64 capacity;
> +       int cpu;
> +
> +       for_each_possible_cpu(cpu) {
> +               __max_cap = (&per_cpu(max_cap, cpu));
> +               if (!__max_cap)
> +                       continue;
> +               capacity = arch_scale_cpu_capacity(cpu);
> +               __max_cap->max_capacity = capacity;
> +               __max_cap->cap_capacity = capacity;
> +               pr_debug("cpu %d max capacity set to %ld\n", cpu, __max_cap->max_capacity);
> +       }
> +}

everything above seems to be there for the cpu cooling device and
should be included in it instead. The scheduler only need the capacity
capping
The cpu cooling device should just set the delta capacity in the
per-cpu variable (see my comment below)

> +
> +void update_periodic_maxcap(struct rq *rq)
> +{
> +       struct max_capacity_info *__max_cap = (&per_cpu(max_cap, cpu_of(rq)));
> +       unsigned long delta;
> +
> +       if (!__max_cap)
> +               return;
> +
> +       delta = __max_cap->max_capacity - __max_cap->cap_capacity;

Why don't you just save the delta in the per_cpu variable instead of
the struct max_capacity_info ? You have to compute the delta every
tick whereas we can expect it to not change that much compared to the
number of tick

> +       update_thermal_avg(rq_clock_task(rq), rq, delta);
> +}
> diff --git a/kernel/sched/thermal.h b/kernel/sched/thermal.h
> new file mode 100644
> index 0000000..5657cb4
> --- /dev/null
> +++ b/kernel/sched/thermal.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Scheduler thermal interaction internal methods.
> + */
> +
> +#ifdef CONFIG_SMP
> +void update_periodic_maxcap(struct rq *rq);
> +
> +#else
> +static inline void update_periodic_maxcap(struct rq *rq)
> +{
> +}
> +#endif
> --
> 2.1.4
>
