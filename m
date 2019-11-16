Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35097C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 08:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED60820723
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 08:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y/4486Ei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfKPIr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 03:47:56 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45304 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfKPIr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 03:47:56 -0500
Received: by mail-lf1-f66.google.com with SMTP id v8so9812881lfa.12
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2019 00:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bp91uD0/PiW/BRpY7HaS8KieB9FSTnD2w31WsW+jdmY=;
        b=y/4486Eimo018DrcBEqfmHn2cw4vwyZQL2FCCIS1qbeA6plSyTD641cf2JiLmZfIuo
         4f0qXk8sgbQTXuOb/5CIVc6wl0W5vCcFS25hiBBIp9Fq2tktamU1gw7VQNYUpzoUaHMu
         ycZsSZbULIx8Olov6AhZCOyf2wnVMOJSvf4o1A+uxVRblkzfC0IatMiqu6G5df85zk9a
         Io1BLR+3IbByD/Qq3QcLtR3qugFClG7AUpW/HFFWBH1sz3hAGw64mo7WSgsVWbyPfJVa
         BBbIaNGv5XC7DOSBrgZLLhPkuJAy67DG3p5TCdVdJ8iDVWKax6JIx59FE/uv+cRyWYji
         SyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bp91uD0/PiW/BRpY7HaS8KieB9FSTnD2w31WsW+jdmY=;
        b=Wkin6xt2vpDfatmpLDEkmGNfdKIUv7NEhVq/5BwSKS3RMR+Gm1MqP0VmetFEZpOcFa
         ax/rbLNjGBRDU5GQRerk0Lvaxhgb+bndnUlN8t7B5KQ6oAlKRCQWgpuy+8IcPp0QmFgm
         o4TVPA7R1ROMU2zb2df735NIovYGdetSJ9exqbEncuZzLBS7ZPoy1YcBEW66c+ZRsxu6
         Zz3yqvgqEE27Jt+eyCFhBGQiTxfredIUlBTQqfYuu8+AONRukb292T4x7o4KvphurDNx
         RAYTDMvX8ptlyrVcuX7cfJh2zJaDnmaPb4qJnVwEQBa8dITCL66rUgeDKTQt5HOaJLaD
         unRA==
X-Gm-Message-State: APjAAAWhyjZkRtKRdlJ4Czn/+hjmzEGKGR4zhoRUQnW2fEqF4eTlMW5x
        oLOJHXqiL5B0Bw2gOr0x9awzOOr5mVU/znsKSMBNXQ==
X-Google-Smtp-Source: APXvYqzMLc7nuk9MO3TViXexHb2VFT5V9zfY78caMJQJZvQ3BdJcJwM2SZ/Hh81F2Ka+cDnlzaN/kpIyULvjcA/Io38=
X-Received: by 2002:a19:800a:: with SMTP id b10mr14490861lfd.15.1573894073025;
 Sat, 16 Nov 2019 00:47:53 -0800 (PST)
MIME-Version: 1.0
References: <1573751251-3505-1-git-send-email-vincent.guittot@linaro.org> <20191115215228.GN3079@worktop.programming.kicks-ass.net>
In-Reply-To: <20191115215228.GN3079@worktop.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Sat, 16 Nov 2019 09:47:41 +0100
Message-ID: <CAKfTPtDyZ5gom41S-8Nu+BMK7hPijWoZPqo0HFYkRnNmWo1UTA@mail.gmail.com>
Subject: Re: [PATCH v4] sched/freq: move call to cpufreq_update_util
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Doug Smythies <dsmythies@telus.net>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sargun Dhillon <sargun@sargun.me>, Tejun Heo <tj@kernel.org>,
        Xie XiuQi <xiexiuqi@huawei.com>, xiezhipeng1@huawei.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Nov 2019 at 22:52, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Nov 14, 2019 at 06:07:31PM +0100, Vincent Guittot wrote:
> > update_cfs_rq_load_avg() calls cfs_rq_util_change() everytime pelt decays,
> > which might be inefficient when cpufreq driver has rate limitation.
> >
> > When a task is attached on a CPU, we have call path:
> >
> > update_load_avg()
> >   update_cfs_rq_load_avg()
> >     cfs_rq_util_change -- > trig frequency update
> >   attach_entity_load_avg()
> >     cfs_rq_util_change -- > trig frequency update
> >
> > The 1st frequency update will not take into account the utilization of the
> > newly attached task and the 2nd one might be discard because of rate
> > limitation of the cpufreq driver.
> >
> > update_cfs_rq_load_avg() is only called by update_blocked_averages()
> > and update_load_avg() so we can move the call to
> > cfs_rq_util_change/cpufreq_update_util() into these 2 functions. It's also
> > interesting to notice that update_load_avg() already calls directly
> > cfs_rq_util_change() for !SMP case.
> >
> > This changes will also ensure that cpufreq_update_util() is called even
> > when there is no more CFS rq in the leaf_cfs_rq_list to update but only
> > irq, rt or dl pelt signals.
> >
> > Reported-by: Doug Smythies <dsmythies@telus.net>
> > Fixes: 039ae8bcf7a5 ("sched/fair: Fix O(nr_cgroups) in the load balancing path")
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > ---
>
> OK, but shall we write it like so instead?

Yes. Looks good to me

>
> ---
>  kernel/sched/fair.c | 111 +++++++++++++++++++++++++++++-----------------------
>  1 file changed, 62 insertions(+), 49 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 545bcb90b4de..7a762266c335 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3508,9 +3508,6 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
>         cfs_rq->load_last_update_time_copy = sa->last_update_time;
>  #endif
>
> -       if (decayed)
> -               cfs_rq_util_change(cfs_rq, 0);
> -
>         return decayed;
>  }
>
> @@ -3620,8 +3617,12 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>                 attach_entity_load_avg(cfs_rq, se, SCHED_CPUFREQ_MIGRATION);
>                 update_tg_load_avg(cfs_rq, 0);
>
> -       } else if (decayed && (flags & UPDATE_TG))
> -               update_tg_load_avg(cfs_rq, 0);
> +       } else if (decayed) {
> +               cfs_rq_util_change(cfs_rq, 0);
> +
> +               if (flags & UPDATE_TG)
> +                       update_tg_load_avg(cfs_rq, 0);
> +       }
>  }
>
>  #ifndef CONFIG_64BIT
> @@ -7428,6 +7429,28 @@ static inline bool others_have_blocked(struct rq *rq) { return false; }
>  static inline void update_blocked_load_status(struct rq *rq, bool has_blocked) {}
>  #endif
>
> +static bool __update_blocked_others(struct rq *rq, bool *done)
> +{
> +       const struct sched_class *curr_class;
> +       u64 now = rq_clock_pelt(rq);
> +       bool decayed;
> +
> +       /*
> +        * update_load_avg() can call cpufreq_update_util(). Make sure that RT,
> +        * DL and IRQ signals have been updated before updating CFS.
> +        */
> +       curr_class = rq->curr->sched_class;
> +
> +       decayed = update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
> +                 update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
> +                 update_irq_load_avg(rq, 0);
> +
> +       if (others_have_blocked(rq))
> +               *done = false;
> +
> +       return decayed;
> +}
> +
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>
>  static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
> @@ -7447,29 +7470,11 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
>         return true;
>  }
>
> -static void update_blocked_averages(int cpu)
> +static bool __update_blocked_fair(struct rq *rq, bool *done)
>  {
> -       struct rq *rq = cpu_rq(cpu);
>         struct cfs_rq *cfs_rq, *pos;
> -       const struct sched_class *curr_class;
> -       struct rq_flags rf;
> -       bool done = true;
> -
> -       rq_lock_irqsave(rq, &rf);
> -       update_rq_clock(rq);
> -
> -       /*
> -        * update_cfs_rq_load_avg() can call cpufreq_update_util(). Make sure
> -        * that RT, DL and IRQ signals have been updated before updating CFS.
> -        */
> -       curr_class = rq->curr->sched_class;
> -       update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
> -       update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
> -       update_irq_load_avg(rq, 0);
> -
> -       /* Don't need periodic decay once load/util_avg are null */
> -       if (others_have_blocked(rq))
> -               done = false;
> +       bool decayed = false;
> +       int cpu = cpu_of(rq);
>
>         /*
>          * Iterates the task_group tree in a bottom up fashion, see
> @@ -7478,9 +7483,13 @@ static void update_blocked_averages(int cpu)
>         for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos) {
>                 struct sched_entity *se;
>
> -               if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq))
> +               if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq)) {
>                         update_tg_load_avg(cfs_rq, 0);
>
> +                       if (cfs_rq == &rq->cfs)
> +                               decayed = true;
> +               }
> +
>                 /* Propagate pending load changes to the parent, if any: */
>                 se = cfs_rq->tg->se[cpu];
>                 if (se && !skip_blocked_update(se))
> @@ -7495,11 +7504,10 @@ static void update_blocked_averages(int cpu)
>
>                 /* Don't need periodic decay once load/util_avg are null */
>                 if (cfs_rq_has_blocked(cfs_rq))
> -                       done = false;
> +                       *done = false;
>         }
>
> -       update_blocked_load_status(rq, !done);
> -       rq_unlock_irqrestore(rq, &rf);
> +       return decayed;
>  }
>
>  /*
> @@ -7549,29 +7557,16 @@ static unsigned long task_h_load(struct task_struct *p)
>                         cfs_rq_load_avg(cfs_rq) + 1);
>  }
>  #else
> -static inline void update_blocked_averages(int cpu)
> +static bool __update_blocked_fair(struct rq *rq, bool *done)
>  {
> -       struct rq *rq = cpu_rq(cpu);
>         struct cfs_rq *cfs_rq = &rq->cfs;
> -       const struct sched_class *curr_class;
> -       struct rq_flags rf;
> -
> -       rq_lock_irqsave(rq, &rf);
> -       update_rq_clock(rq);
> -
> -       /*
> -        * update_cfs_rq_load_avg() can call cpufreq_update_util(). Make sure
> -        * that RT, DL and IRQ signals have been updated before updating CFS.
> -        */
> -       curr_class = rq->curr->sched_class;
> -       update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
> -       update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
> -       update_irq_load_avg(rq, 0);
> +       bool decayed;
>
> -       update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq);
> +       decayed = update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq);
> +       if (cfs_rq_has_blocked(cfs_rq))
> +               *done = false;
>
> -       update_blocked_load_status(rq, cfs_rq_has_blocked(cfs_rq) || others_have_blocked(rq));
> -       rq_unlock_irqrestore(rq, &rf);
> +       return decayed;
>  }
>
>  static unsigned long task_h_load(struct task_struct *p)
> @@ -7580,6 +7575,24 @@ static unsigned long task_h_load(struct task_struct *p)
>  }
>  #endif
>
> +static void update_blocked_averages(int cpu)
> +{
> +       bool decayed = false, done = true;
> +       struct rq *rq = cpu_rq(cpu);
> +       struct rq_flags rf;
> +
> +       rq_lock_irqsave(rq, &rf);
> +       update_rq_clock(rq);
> +
> +       decayed |= __update_blocked_others(rq, &done);
> +       decayed |= __update_blocked_fair(rq, &done);
> +
> +       update_blocked_load_status(rq, !done);
> +       if (decayed)
> +               cpufreq_update_util(rq, 0);
> +       rq_unlock_irqrestore(rq, &rf);
> +}
> +
>  /********** Helpers for find_busiest_group ************************/
>
>  /*
>
