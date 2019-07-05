Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21ED4C4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 14:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E925921721
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 14:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GuKnXgcd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfGEOv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 10:51:58 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43219 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfGEOv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 10:51:58 -0400
Received: by mail-lf1-f66.google.com with SMTP id c19so886694lfm.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 07:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3MvpTP2fFCaQkoA+f5/CTtpJaXvZZnBt/GIh5Twe+DA=;
        b=GuKnXgcdfHnBxseTuVOzqohK5pv/apckKuFKURCRMLJHjFBV2NQfMuVvKSTB6LCf9I
         EmUwt7JSggxOQtq0bV8q2RFTsgqCpMyKQy47G1kVTeJvvUSKlw/2VkjXhKRn6IweN6gB
         rZmgpyBI4B7GD4oZ7BoblZ5DVyQfETZZYytzmKlARlAEQ883E2xtewsSG+aMNUT8Svf4
         rxqOTALu0JFeC7OewPOQx5UdYy8trHGaVogPvlPMo/Y2D1OY8yC/Yy1p/HCXpGSHuWZw
         kCLaU2PN1LVIS3nXoO+VHkSVU4Z4/WTcPlyuEoWYs7j+c/KgvVuMPaZFIH5qg632VUYi
         9gdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3MvpTP2fFCaQkoA+f5/CTtpJaXvZZnBt/GIh5Twe+DA=;
        b=KrAcFZb+G6lLVlS3jqgHxSKmYSAahMYn7f2oD0I68v1STYBB3yVkH8sP9UZaYpcCvK
         0rtFqr73DaihM2CcOvElOtwU9RDAPAXZXY48uAIDEkj/pq2G5zdoBThsFpxbZolJNegE
         kNGOiYPASY9s0pZPAwh4yuWBTDIcBxBrkwHbD+9OBWCgJhrKp2etY0mDOELh9ncxBsGO
         8gMFeDFuYteAEa0untyW9VK1qpHYLVgIxU0j9K5yxGesnOGB/H+SUf4DQlTmZcfgcvxp
         hlLwjQmrU+HZapj2m855+zbfyRCsVhG54vxCKhOBolPmGBOPV6R6nVo//7SLvfF1WvQZ
         FSuw==
X-Gm-Message-State: APjAAAUSsqbYlZFEMfO/b+urdMK0EfpX/IuOAwuCgWHul2zMTWx8rCL6
        zy5bVJdyQ7blBDmfhb0eIFd8P/s+7rwaBvRtW9XejQ==
X-Google-Smtp-Source: APXvYqyzZ2RdpWIm41fdspUWEa7a3dG7kLIi7ZNR4yCPceZiMZz18vLnqCz+08XeeHZZipwHv+607sTcpv5raV0oZp8=
X-Received: by 2002:ac2:4a78:: with SMTP id q24mr2086995lfp.59.1562338316187;
 Fri, 05 Jul 2019 07:51:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190628204913.10287-1-riel@surriel.com> <20190628204913.10287-8-riel@surriel.com>
In-Reply-To: <20190628204913.10287-8-riel@surriel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 5 Jul 2019 16:51:45 +0200
Message-ID: <CAKfTPtDsh-VxTrwuhb88fi-L4j0ODnNOqhoQ=ZC6E8FVV7Kmkw@mail.gmail.com>
Subject: Re: [PATCH 07/10] sched,cfs: fix zero length timeslice calculation
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>, Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jun 2019 at 22:49, Rik van Riel <riel@surriel.com> wrote:
>
> The way the time slice length is currently calculated, not only do high
> priority tasks get longer time slices than low priority tasks, but due
> to fixed point math, low priority tasks could end up with a zero length
> time slice. This can lead to cache thrashing and other inefficiencies.
>
> Simplify the logic a little bit, and cap the minimum time slice length
> to sysctl_sched_min_granularity.
>
> Tasks that end up getting a time slice length too long for their relative
> priority will simply end up having their vruntime advanced much faster than
> other tasks, resulting in them receiving time slices less frequently.
>
> Signed-off-by: Rik van Riel <riel@surriel.com>
> ---
>  kernel/sched/fair.c | 25 ++++++++-----------------
>  1 file changed, 8 insertions(+), 17 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d48bff5118fc..8da2823401ca 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -671,22 +671,6 @@ static inline u64 calc_delta_fair(u64 delta, struct sched_entity *se)
>         return delta;
>  }
>
> -/*
> - * The idea is to set a period in which each task runs once.
> - *
> - * When there are too many tasks (sched_nr_latency) we have to stretch
> - * this period because otherwise the slices get too small.
> - *
> - * p = (nr <= nl) ? l : l*nr/nl
> - */
> -static u64 __sched_period(unsigned long nr_running)
> -{
> -       if (unlikely(nr_running > sched_nr_latency))
> -               return nr_running * sysctl_sched_min_granularity;
> -       else
> -               return sysctl_sched_latency;
> -}
> -
>  /*
>   * We calculate the wall-time slice from the period by taking a part
>   * proportional to the weight.
> @@ -695,7 +679,7 @@ static u64 __sched_period(unsigned long nr_running)
>   */
>  static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  {
> -       u64 slice = __sched_period(cfs_rq->nr_running + !se->on_rq);
> +       u64 slice = sysctl_sched_latency;

Is the change above and the remove of __sched_period() really needed
for fixing the null time slice problem ?
This change impacts how tasks will preempt each other and as a result
the throughput. It should have it dedicated patch so we can evaluate
its impact

>
>         for_each_sched_entity(se) {
>                 struct load_weight *load;
> @@ -712,6 +696,13 @@ static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
>                 }
>                 slice = __calc_delta(slice, se->load.weight, load);
>         }
> +
> +       /*
> +        * To avoid cache thrashing, run at least sysctl_sched_min_granularity.
> +        * The vruntime of a low priority task advances faster; those tasks
> +        * will simply get time slices less frequently.
> +        */
> +       slice = max_t(u64, slice, sysctl_sched_min_granularity);
>         return slice;
>  }
>
> --
> 2.20.1
>
