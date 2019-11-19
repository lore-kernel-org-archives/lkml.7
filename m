Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A9BC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 10:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8074E208D4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 10:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="OMvg4l6/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfKSKwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 05:52:25 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:37048 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbfKSKwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 05:52:25 -0500
Received: by mail-ua1-f67.google.com with SMTP id l38so6353336uad.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 02:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dy5ixUlyf68dNjAjwb1L9Qd0I2zb6jWFc6s6RugNUDI=;
        b=OMvg4l6/1nsKABdXlt6h8gh6Ym39dQDfCvdV1DQvdd7dawW+KxDoRvRZeVw0FkljC4
         SugleFom8jwSWziUC3QsDJXAJmSNposL+3wlshDhjjcM1JocsT7yofbGIV9Yeni2hvoV
         x/nNjf0ta5tkSY4qElrafJIYPqaXIK5rPafmlTchKiJQ1ouCffEGvOPxVlHEYAs/X+XO
         JMmY8rY5sicmIeZF7qIduSnYd6cTmkx1YrCWTbCl1Jvgmy67j8/TXem/BKABWoKd3Xs9
         P0EpN/0bQZYdL92BxxOVilcKQS/nodBmxum/GCCiTmAcGnGml3KgCPO3ELLusEqVwV63
         lyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dy5ixUlyf68dNjAjwb1L9Qd0I2zb6jWFc6s6RugNUDI=;
        b=CXFjqL3twG61FGqJoB5uR3NedrYtXU5DKiBfkuiFMDUYEJkp0rbvji4L5AZERbW9xs
         OsQEErYShfqOI50UePSbJbJyDQyoi73z++7x8zb2dbEe7JkeUTXTJzvb1PiRKZAlBfv6
         DZXCNdwryYmPXFakOoxdKRPCuEVRmzsCKoEBn5/OCYFQ0xexiQErRQfqGKK6ol/edJkn
         g0GRX4nPMvYM5wscjqtHCs2dgGvo7QChWQwfgLfcuv42G5w9QlPGZehtWlEd9fR/jAUv
         MOpoUF2HmRKm4ubBkaagCeRM+Y5mDuR8ZkqQdM/IFeWQkRz62XYnpsM8mtPKAsh60ZIY
         elnA==
X-Gm-Message-State: APjAAAXTDhbcGSumPGvYMtYrtP9ZwgoKBF2rzU+kNKwb8BpirszdJWA5
        RPmuDKzDWYcyaJ4Q/D+4a6cyzJJwoF/giVSQJ8oKaQ==
X-Google-Smtp-Source: APXvYqyiTLPgd/9WoKz41fj59NRZa7KVA2T30HQdmoPUe+v2zZ73magRTcbaNPRMaFIwtXAIC8bNrK4exghYeEJgQQc=
X-Received: by 2002:a9f:364c:: with SMTP id s12mr19811993uad.77.1574160743379;
 Tue, 19 Nov 2019 02:52:23 -0800 (PST)
MIME-Version: 1.0
References: <1572979786-20361-1-git-send-email-thara.gopinath@linaro.org> <1572979786-20361-7-git-send-email-thara.gopinath@linaro.org>
In-Reply-To: <1572979786-20361-7-git-send-email-thara.gopinath@linaro.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Tue, 19 Nov 2019 16:22:12 +0530
Message-ID: <CAHLCerMVRn48x_CPVPrXkvRH+6EzuQ16WfWCJFUchYU=M66hOA@mail.gmail.com>
Subject: Re: [Patch v5 6/6] sched/fair: Enable tuning of decay period
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
> Thermal pressure follows pelt signas which means the
> decay period for thermal pressure is the default pelt
> decay period. Depending on soc charecteristics and thermal
> activity, it might be beneficial to decay thermal pressure
> slower, but still in-tune with the pelt signals.
> One way to achieve this is to provide a command line parameter
> to set a decay shift parameter to an integer between 0 and 10.
>
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>
> v4->v5:
>         - Changed _coeff to _shift as per review comments on the list.
>
>  Documentation/admin-guide/kernel-parameters.txt |  5 +++++
>  kernel/sched/fair.c                             | 25 +++++++++++++++++++++++--
>  2 files changed, 28 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index c82f87c..0b8f55e 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4281,6 +4281,11 @@
>                         incurs a small amount of overhead in the scheduler
>                         but is useful for debugging and performance tuning.
>
> +       sched_thermal_decay_shift=
> +                       [KNL, SMP] Set decay shift for thermal pressure signal.
> +                       Format: integer betweer 0 and 10
> +                       Default is 0.
> +
>         skew_tick=      [KNL] Offset the periodic timer tick per cpu to mitigate
>                         xtime_lock contention on larger systems, and/or RCU lock
>                         contention on all systems with CONFIG_MAXSMP set.
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 5f6c371..61a020b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -91,6 +91,18 @@ const_debug unsigned int sysctl_sched_migration_cost = 500000UL;
>   * and maximum available capacity due to thermal events.
>   */
>  static DEFINE_PER_CPU(unsigned long, thermal_pressure);
> +/**
> + * By default the decay is the default pelt decay period.
> + * The decay shift can change the decay period in
> + * multiples of 32.
> + *  Decay shift                Decay period(ms)
> + *     0                       32
> + *     1                       64
> + *     2                       128
> + *     3                       256
> + *     4                       512
> + */
> +static int sched_thermal_decay_shift;
>
>  static void trigger_thermal_pressure_average(struct rq *rq);
>
> @@ -10435,6 +10447,15 @@ void update_thermal_pressure(int cpu, unsigned long capped_capacity)
>         delta = arch_scale_cpu_capacity(cpu) - capped_capacity;
>         per_cpu(thermal_pressure, cpu) = delta;
>  }
> +
> +static int __init setup_sched_thermal_decay_shift(char *str)
> +{
> +       if (kstrtoint(str, 0, &sched_thermal_decay_shift))
> +               pr_warn("Unable to set scheduler thermal pressure decay shift parameter\n");

You're reading straight from the cmdline into a kernel variable w/o
any bounds checking. Perhaps use clamp or clamp_val to make sure it is
between 0 and 10?


> +
> +       return 1;
> +}
> +__setup("sched_thermal_decay_shift=", setup_sched_thermal_decay_shift);
>  #endif
>
>  /**
> @@ -10444,8 +10465,8 @@ void update_thermal_pressure(int cpu, unsigned long capped_capacity)
>  static void trigger_thermal_pressure_average(struct rq *rq)
>  {
>  #ifdef CONFIG_SMP
> -       update_thermal_load_avg(rq_clock_task(rq), rq,
> -                               per_cpu(thermal_pressure, cpu_of(rq)));
> +       update_thermal_load_avg(rq_clock_task(rq) >> sched_thermal_decay_shift,
> +                               rq, per_cpu(thermal_pressure, cpu_of(rq)));
>  #endif
>  }
>
> --
> 2.1.4
>
