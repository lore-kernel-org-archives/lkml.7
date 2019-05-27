Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1004C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 14:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7534C205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 14:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o9zYwl72"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfE0OHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 10:07:16 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43911 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbfE0OHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 10:07:16 -0400
Received: by mail-lj1-f196.google.com with SMTP id z5so14802100lji.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 07:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ug4d1f+ohs3NURMTPtwC1Hci+/10RkUCukOMEMhD1do=;
        b=o9zYwl72p6ifvKLI1GZJyvUTjg/c7/9zonDJbiIKpCKFGl6yZuCqdtjR1ajNJRRH5I
         L2o9ijAfGrQMJuIdSxPg8f8pfuPBneMISCaj1DP99KOUjZBvYyNeAxY5tyIVMmR/4XzS
         z5vAi31rHRUh6KV2jK6docUAzJyZhjM6Ei3C7mqNI8JP/0avPhOm8Pm+aCl8usIcudbd
         SNLRQjY827x0Ecrl3WNW6AEZvh8wwkcV8jN/Aehi+MtXm2kWe4OzX5pmvnitcYVMGE/B
         Z6pHuzzLbcBssWd1xFWl9s//Akepa7U5BT5Y3agL/a6yjTcAdslC8Jk8bKuMXsp7D3NH
         PyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ug4d1f+ohs3NURMTPtwC1Hci+/10RkUCukOMEMhD1do=;
        b=iBlJcyU/5rS3h87tEfQi4Ti9oH80uvmC+CtC63yxctAxYlYpmekTiJJniui5uDIL3m
         LqtQFeFDs+gObDXEq6NsW5DTiBEoT53DCRIgROoX4pDYI35gBvhrA1Qhf5RffRM/IwIz
         5ELrO/oTqI1m8Xo1wRH/ZnJFy8PcA5JHEtmPRNMlJN6Cm5Vw+xIGVnlq5xeRt48h8iyF
         Nnm6pQlwgxkVQyt5d9VcLZd7MQwRcpI8YNDpLIJQlyeJV8yHZHqDrXb6ao9xLakaUHUq
         Twzhxs2TeAkxI4fQdvlphm4lhy6QApP1qU9PzhARFoR0EUcr18FBp2i5f4d2ZF74UuRw
         Dxzg==
X-Gm-Message-State: APjAAAVBruBkReIhk3tAsZ6WsSX6/OESdBEuluPjmzmkhxDD8KJe9vn0
        +JEfH8Xq0RHS1Q3oR3N5kANK+4MJsknRmgeEdukVcQ==
X-Google-Smtp-Source: APXvYqye40QoU4Yxjx6am1gOt6/8kH5LZxD+f6cya9yLR17Ccv/pUkn7h25LBamO+rwt7uS+N2b4bsgOFqXyd8S2sZw=
X-Received: by 2002:a2e:8185:: with SMTP id e5mr29285075ljg.14.1558966034047;
 Mon, 27 May 2019 07:07:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190527062116.11512-1-dietmar.eggemann@arm.com> <20190527062116.11512-7-dietmar.eggemann@arm.com>
In-Reply-To: <20190527062116.11512-7-dietmar.eggemann@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 27 May 2019 16:07:02 +0200
Message-ID: <CAKfTPtBcYVH=SsUUnJc-eQpdXD=KOQ3GMKRdTKSRaU-TiE6KwA@mail.gmail.com>
Subject: Re: [PATCH 6/7] sched/fair: Remove sgs->sum_weighted_load
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 May 2019 at 08:21, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> Since sg_lb_stats::sum_weighted_load is now identical with
> sg_lb_stats::group_load remove it and replace its use case
> (calculating load per task) with the latter.
>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

FWIW
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 88779c45e8e6..a33f196703a7 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7580,7 +7580,6 @@ static unsigned long task_h_load(struct task_struct *p)
>  struct sg_lb_stats {
>         unsigned long avg_load; /*Avg load across the CPUs of the group */
>         unsigned long group_load; /* Total load over the CPUs of the group */
> -       unsigned long sum_weighted_load; /* Weighted load of group's tasks */
>         unsigned long load_per_task;
>         unsigned long group_capacity;
>         unsigned long group_util; /* Total utilization of the group */
> @@ -7947,7 +7946,6 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>                 sgs->nr_numa_running += rq->nr_numa_running;
>                 sgs->nr_preferred_running += rq->nr_preferred_running;
>  #endif
> -               sgs->sum_weighted_load += weighted_cpuload(rq);
>                 /*
>                  * No need to call idle_cpu() if nr_running is not 0
>                  */
> @@ -7966,7 +7964,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>         sgs->avg_load = (sgs->group_load*SCHED_CAPACITY_SCALE) / sgs->group_capacity;
>
>         if (sgs->sum_nr_running)
> -               sgs->load_per_task = sgs->sum_weighted_load / sgs->sum_nr_running;
> +               sgs->load_per_task = sgs->group_load / sgs->sum_nr_running;
>
>         sgs->group_weight = group->group_weight;
>
> --
> 2.17.1
>
