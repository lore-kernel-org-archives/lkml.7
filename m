Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F26C46460
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEEF72075E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q/f9cBhZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfE0Nbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 09:31:42 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34012 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfE0Nbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 09:31:41 -0400
Received: by mail-lf1-f68.google.com with SMTP id v18so12100137lfi.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 06:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ki99Ehc580gWd8hhNfc7HwwOLF8508UisRqsJ52Auuc=;
        b=Q/f9cBhZbzQeotXwv0HUsnNr9WQ/GAnJZLkl2ZixI2H34C7r5RtMUkgWpXmyHyRky6
         83eG8SeOmaFXHw8pnXPYgBPmw5IElH1ZHZM4IZZIISdhRvhbtwWmwfqE+s+XV7jnYr7m
         3z7aNmAe04bzzqnZjWQYSXXjdHux4rH78aZVGPgLsei0kEAAkt/O0J7y6zFI+eEdfdT6
         OFRp4oW75dsm782/TS84TJbNmh8tsNnnRayAoYZ6qPJTcfDDIpv3kGOdZkmBkfVdj/oO
         fcSrh+yrd/hxH0/eXxictiQJdXNa4uXbf/iHi9fjCKilQtplA8FTW/hdqNJkKZqsT3w1
         T41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ki99Ehc580gWd8hhNfc7HwwOLF8508UisRqsJ52Auuc=;
        b=QicmYP1fRPxU2Z+rwTCmTMxNqOW4v1mpzk8MxcA/Sn4OD6bZyVqgF+fqLyTnOFGtIK
         euFiS/mVMBPNZEfCd26jKTryrihX8N29WeSDTDHA2u1AWL6utGk7v9il/ARRgnEJ4PXD
         hxszsElpudJeiD/mfTi1izeTZ1eELA1x72ZL3TaiXPfmKtceMgi2dfRpU8hMmk/R3s7o
         1D0Hbl+oiWmRdmapgHeYn0Emxrkit3Na+5Nm1NXHSmtbMAMkhXbDkouso0tpSlIyonJn
         sAarAkUYAgy8cUqAMqRVRBwsX7uRtGGyefiQ69AGUaJleymm/es4go7rE5nAvDLw++Ts
         m0uQ==
X-Gm-Message-State: APjAAAV9gB5Hcb3NIZV0K+OGMn+QlrmejhFk8yDPtBvDJcCfzkrAQfci
        /uikTKhIV7MDW9gAWpvJc4KgeRz3QfcMWQUhQvH2tA==
X-Google-Smtp-Source: APXvYqwZwsOLhzwK3nJBkzMlbpMaOWbgQz5RLF1PztKNi7R3TBUYAVv3Tpie4gWiP4Ai3GbhtlGnc+H/sCdisL8dczI=
X-Received: by 2002:ac2:51a3:: with SMTP id f3mr5840459lfk.125.1558963898788;
 Mon, 27 May 2019 06:31:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190527062116.11512-1-dietmar.eggemann@arm.com> <20190527062116.11512-8-dietmar.eggemann@arm.com>
In-Reply-To: <20190527062116.11512-8-dietmar.eggemann@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 27 May 2019 15:31:27 +0200
Message-ID: <CAKfTPtA4hs1+Xu_bG5o2RjOZy792_yLTm_GSv2u6t7_qyfjhTQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] sched/fair: Rename weighted_cpuload() to cpu_load()
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
> This is done to align the per cpu (i.e. per rq) load with the util
> counterpart (cpu_util(int cpu)). The term 'weighted' is not needed
> since there is no 'unweighted' load to distinguish it from.
>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>  kernel/sched/fair.c | 44 ++++++++++++++++++++------------------------
>  1 file changed, 20 insertions(+), 24 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a33f196703a7..f6d0aad13090 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1466,7 +1466,7 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
>                group_faults_cpu(ng, src_nid) * group_faults(p, dst_nid) * 4;
>  }
>
> -static unsigned long weighted_cpuload(struct rq *rq);
> +static unsigned long cpu_load(int cpu);
>
>  /* Cached statistics for all CPUs within a node */
>  struct numa_stats {
> @@ -1485,9 +1485,7 @@ static void update_numa_stats(struct numa_stats *ns, int nid)
>
>         memset(ns, 0, sizeof(*ns));
>         for_each_cpu(cpu, cpumask_of_node(nid)) {
> -               struct rq *rq = cpu_rq(cpu);
> -
> -               ns->load += weighted_cpuload(rq);
> +               ns->load += cpu_load(cpu);
>                 ns->compute_capacity += capacity_of(cpu);
>         }
>
> @@ -5334,9 +5332,9 @@ static struct {
>
>  #endif /* CONFIG_NO_HZ_COMMON */
>
> -static unsigned long weighted_cpuload(struct rq *rq)
> +static unsigned long cpu_load(int cpu)

it would be better to use cpu_runnable_load instead of cpu_load
because it returns runnable_load_avg and not load_avg

>  {
> -       return cfs_rq_runnable_load_avg(&rq->cfs);
> +       return cfs_rq_runnable_load_avg(&cpu_rq(cpu)->cfs);
>  }
>
>  static unsigned long capacity_of(int cpu)
> @@ -5348,7 +5346,7 @@ static unsigned long cpu_avg_load_per_task(int cpu)
>  {
>         struct rq *rq = cpu_rq(cpu);
>         unsigned long nr_running = READ_ONCE(rq->cfs.h_nr_running);
> -       unsigned long load_avg = weighted_cpuload(rq);
> +       unsigned long load_avg = cpu_load(cpu);
>
>         if (nr_running)
>                 return load_avg / nr_running;
> @@ -5446,7 +5444,7 @@ wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
>         s64 this_eff_load, prev_eff_load;
>         unsigned long task_load;
>
> -       this_eff_load = weighted_cpuload(cpu_rq(this_cpu));
> +       this_eff_load = cpu_load(this_cpu);
>
>         if (sync) {
>                 unsigned long current_load = task_h_load(current);
> @@ -5464,7 +5462,7 @@ wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
>                 this_eff_load *= 100;
>         this_eff_load *= capacity_of(prev_cpu);
>
> -       prev_eff_load = weighted_cpuload(cpu_rq(this_cpu));
> +       prev_eff_load = cpu_load(this_cpu);
>         prev_eff_load -= task_load;
>         if (sched_feat(WA_BIAS))
>                 prev_eff_load *= 100 + (sd->imbalance_pct - 100) / 2;
> @@ -5552,7 +5550,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p,
>                 max_spare_cap = 0;
>
>                 for_each_cpu(i, sched_group_span(group)) {
> -                       load = weighted_cpuload(cpu_rq(i));
> +                       load = cpu_load(i);
>                         runnable_load += load;
>
>                         avg_load += cfs_rq_load_avg(&cpu_rq(i)->cfs);
> @@ -5688,7 +5686,7 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
>                                 shallowest_idle_cpu = i;
>                         }
>                 } else if (shallowest_idle_cpu == -1) {
> -                       load = weighted_cpuload(cpu_rq(i));
> +                       load = cpu_load(i);
>                         if (load < min_load) {
>                                 min_load = load;
>                                 least_loaded_cpu = i;
> @@ -7259,8 +7257,8 @@ static struct task_struct *detach_one_task(struct lb_env *env)
>  static const unsigned int sched_nr_migrate_break = 32;
>
>  /*
> - * detach_tasks() -- tries to detach up to imbalance weighted load from
> - * busiest_rq, as part of a balancing operation within domain "sd".
> + * detach_tasks() -- tries to detach up to imbalance load from busiest_rq,
> + * as part of a balancing operation within domain "sd".
>   *
>   * Returns number of detached tasks if successful and 0 otherwise.
>   */
> @@ -7326,8 +7324,7 @@ static int detach_tasks(struct lb_env *env)
>  #endif
>
>                 /*
> -                * We only want to steal up to the prescribed amount of
> -                * weighted load.
> +                * We only want to steal up to the prescribed amount of load.
>                  */
>                 if (env->imbalance <= 0)
>                         break;
> @@ -7931,7 +7928,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>                 if ((env->flags & LBF_NOHZ_STATS) && update_nohz_stats(rq, false))
>                         env->flags |= LBF_NOHZ_AGAIN;
>
> -               sgs->group_load += weighted_cpuload(rq);
> +               sgs->group_load += cpu_load(i);
>                 sgs->group_util += cpu_util(i);
>                 sgs->sum_nr_running += rq->cfs.h_nr_running;
>
> @@ -8385,8 +8382,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>   * find_busiest_group - Returns the busiest group within the sched_domain
>   * if there is an imbalance.
>   *
> - * Also calculates the amount of weighted load which should be moved
> - * to restore balance.
> + * Also calculates the amount of load which should be moved to restore balance.
>   *
>   * @env: The load balancing environment.
>   *
> @@ -8558,11 +8554,11 @@ static struct rq *find_busiest_queue(struct lb_env *env,
>                     rq->nr_running == 1)
>                         continue;
>
> -               wl = weighted_cpuload(rq);
> +               wl = cpu_load(i);
>
>                 /*
> -                * When comparing with imbalance, use weighted_cpuload()
> -                * which is not scaled with the CPU capacity.
> +                * When comparing with imbalance, use cpu_load() which is not
> +                * scaled with the CPU capacity.
>                  */
>
>                 if (rq->nr_running == 1 && wl > env->imbalance &&
> @@ -8571,9 +8567,9 @@ static struct rq *find_busiest_queue(struct lb_env *env,
>
>                 /*
>                  * For the load comparisons with the other CPU's, consider
> -                * the weighted_cpuload() scaled with the CPU capacity, so
> -                * that the load can be moved away from the CPU that is
> -                * potentially running at a lower capacity.
> +                * the cpu_load() scaled with the CPU capacity, so that the
> +                * load can be moved away from the CPU that is potentially
> +                * running at a lower capacity.
>                  *
>                  * Thus we're looking for max(wl_i / capacity_i), crosswise
>                  * multiplication to rid ourselves of the division works out
> --
> 2.17.1
>
