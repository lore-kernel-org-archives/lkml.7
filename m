Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41BAC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 15:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60C982053B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 15:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posk.io header.i=@posk.io header.b="RfsnL1Cb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbfFDP7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 11:59:41 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:39169 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbfFDP7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 11:59:40 -0400
Received: by mail-vs1-f66.google.com with SMTP id n2so5432779vso.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 08:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pNSmlxy+hHS9DdorXvCYVqoqTtmJb7A32aLQZ8rGLog=;
        b=RfsnL1Cbm3++1fTT2oGbQiSR45EERV453FCrAn8rOCd28WFS7LG/EAeJ2yCFN2XybD
         XI8/icvh2H2QI6+HRCPUlTjo4pZVdlgKgMQGLdWd/jG/oLKHWp2/lZGEBzUGqtLQRxh3
         FG0t4K2f7GbVj8ORugI7RNhutqiBPT3PXLsLWQwdWj7jSwutVlADqPYeWTb39h6z689z
         5XoNsGqZZAlEMLOLskrBAOx+0Zj06NIaRHTlXl+WEmjPcnO/K3p+oa7Me394MngtPSjm
         QWTSLWFF7YZmdOGLaJzrQf6c6T/n//nr51idY2+OMa4CUH5fYUxP7EPaptsRdVt6c1j1
         5hMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pNSmlxy+hHS9DdorXvCYVqoqTtmJb7A32aLQZ8rGLog=;
        b=lCEVnSVq5frlRMx55l+ubU7f/j1VKCVViGU8ho/VwX6IUbogcWjOxkiFjOlfv0MZ9i
         2l5SM2z/t3e1xMcjWNYUtUXqPYSkYmaUBsvYR6UIcDwdDgzQCIaZhot+Uv7PtR5uUjNJ
         YgdVQuMcer5F7z5HOj0tIgIHgRrfSxm8hpNIhv1hFvhT8S96/6AmrF5vPf6mWPjstCgU
         SlqZBzP2bXHsOt5JRaj0x1o0WpK6b6q/0sGXvDO1LRhHtf8C7CgEgSBZA/+0m4wZRPHE
         UxjOx3G+m1Ih6t/izkGky0EQsQYC5pA7RChF+3mxK6Pss2k3TUAg6WJXGL7k/OYg04oM
         FXSQ==
X-Gm-Message-State: APjAAAVtru1ri+LfYV1KO2ihQIFKT65csj868BTlc9SuWjcJ3oZooAZY
        jKirJq82qiF5BYkn6jTFuYTEdXfeXP3XyuMr6gooxQ==
X-Google-Smtp-Source: APXvYqzmEbcEQLzsKI5Mr/6AhhWgZhi9tfoIoQbe0F5ZUEaJn8TCq8CL+QBWe3VBgS7UmzAm/55bL9ZC3B5I5usQkPs=
X-Received: by 2002:a67:ea58:: with SMTP id r24mr16770160vso.60.1559663979613;
 Tue, 04 Jun 2019 08:59:39 -0700 (PDT)
MIME-Version: 1.0
References: <b477ac75a2b163048bdaeb37f57b4c3f04f75a31.1559631700.git.viresh.kumar@linaro.org>
In-Reply-To: <b477ac75a2b163048bdaeb37f57b4c3f04f75a31.1559631700.git.viresh.kumar@linaro.org>
From:   Peter Oskolkov <posk@posk.io>
Date:   Tue, 4 Jun 2019 08:59:28 -0700
Message-ID: <CAFTs51WUXwJbgsFCRbOwdUWnv55Mbt55-hmoMyETPGC5yMDSCQ@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Introduce fits_capacity()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 4, 2019 at 12:02 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> The same formula to check utilization against capacity (after
> considering capacity_margin) is already used at 5 different locations.
>
> This patch creates a new macro, fits_capacity(), which can be used from
> all these locations without exposing the details of it and hence
> simplify code.
>
> All the 5 code locations are updated as well to use it..
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  kernel/sched/fair.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 7f8d477f90fe..db3a218b7928 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -102,6 +102,8 @@ int __weak arch_asym_cpu_priority(int cpu)
>   * (default: ~20%)
>   */
>  static unsigned int capacity_margin                    = 1280;
> +
> +#define fits_capacity(cap, max)        ((cap) * capacity_margin < (max) * 1024)

Any reason to have this as a macro and not as an inline function?

>  #endif
>
>  #ifdef CONFIG_CFS_BANDWIDTH
> @@ -3727,7 +3729,7 @@ util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
>
>  static inline int task_fits_capacity(struct task_struct *p, long capacity)
>  {
> -       return capacity * 1024 > task_util_est(p) * capacity_margin;
> +       return fits_capacity(task_util_est(p), capacity);
>  }
>
>  static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
> @@ -5143,7 +5145,7 @@ static inline unsigned long cpu_util(int cpu);
>
>  static inline bool cpu_overutilized(int cpu)
>  {
> -       return (capacity_of(cpu) * 1024) < (cpu_util(cpu) * capacity_margin);
> +       return !fits_capacity(cpu_util(cpu), capacity_of(cpu));
>  }
>
>  static inline void update_overutilized_status(struct rq *rq)
> @@ -6304,7 +6306,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>                         /* Skip CPUs that will be overutilized. */
>                         util = cpu_util_next(cpu, p, cpu);
>                         cpu_cap = capacity_of(cpu);
> -                       if (cpu_cap * 1024 < util * capacity_margin)
> +                       if (!fits_capacity(util, cpu_cap))
>                                 continue;
>
>                         /* Always use prev_cpu as a candidate. */
> @@ -7853,8 +7855,7 @@ group_is_overloaded(struct lb_env *env, struct sg_lb_stats *sgs)
>  static inline bool
>  group_smaller_min_cpu_capacity(struct sched_group *sg, struct sched_group *ref)
>  {
> -       return sg->sgc->min_capacity * capacity_margin <
> -                                               ref->sgc->min_capacity * 1024;
> +       return fits_capacity(sg->sgc->min_capacity, ref->sgc->min_capacity);
>  }
>
>  /*
> @@ -7864,8 +7865,7 @@ group_smaller_min_cpu_capacity(struct sched_group *sg, struct sched_group *ref)
>  static inline bool
>  group_smaller_max_cpu_capacity(struct sched_group *sg, struct sched_group *ref)
>  {
> -       return sg->sgc->max_capacity * capacity_margin <
> -                                               ref->sgc->max_capacity * 1024;
> +       return fits_capacity(sg->sgc->max_capacity, ref->sgc->max_capacity);
>  }
>
>  static inline enum
> --
> 2.21.0.rc0.269.g1a574e7a288b
>
