Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A335C388F3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 09:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 055A021920
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 09:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tf2QY8xO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbfJAJOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 05:14:47 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:32946 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbfJAJOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 05:14:47 -0400
Received: by mail-lj1-f194.google.com with SMTP id a22so12546532ljd.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 02:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lpGVuUxSxKMiuwRTwy01a7scEo77bnYExxr3k+l2+X0=;
        b=Tf2QY8xOlAdj1IcCPnKHYar5usIdaAw0zLTtghp0Qtj2p4F/aIxi0RHLQ2AOGpQ9T0
         m5pIvx5Zo6FQ4K1oKtf1fCBE3I/VcyFjFV6czrrd48ER0PgKV3yESJ3k5oWD5AxpbNIp
         09po/kHeK47eNvqdkTrKmweqwsai6sM5POg4p2S0XFEITB+SjOlRzaO5I5Zxhhrc/ZWg
         fp/evDg0J7fEgR4Kj52tGnEv/4+NDlAeu3k1G5qmVOcOMSZv6PWErgJN6eoyt5XB8u6k
         fvdlUNOrHSOSk6VTLSSg4F8Eia9Qg/9a9WPpUjUnRvKMnUUfmWQbhzgbXhK1I/0n2NtT
         jsMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lpGVuUxSxKMiuwRTwy01a7scEo77bnYExxr3k+l2+X0=;
        b=a+Dp32mnycp88ZJUNvsUvXeKR6q6IBwgExODDGrmcn8vqg8wc/xuxOzGQCgK1mA/T2
         jKZylVlxtY/QYQzZqk6tmyJzA4bZCWIsNHS9LFTcPJk1RQb+g5hxv10JxayvTaOKZ2oW
         wK/lMZq/0BKmsQitBmJRg/Slnv+aTYFzKN0Xb3w9wZ8jCqWrk/Vo6pd9Dq+wIqLEWfey
         Zl8kddbqvOusxcdf18uTmJ2w8KfMZwtszwvXsGoQ31FHxQBj+XRBDqMRJEBNZVt8Fkyh
         1sTjngDu0NbfzXc0RhM4jwEclw4sdJ9E7XKUF5TcpyIaNi2hGnxuQfyPnvrZl+xid+Ru
         pmWg==
X-Gm-Message-State: APjAAAW1xg0I+s2ijr3Tva8eWSK4yzDtjblXJupkTCbiQN3kORIc7UBf
        1VzsWh26mDTxadG3cpXexH1jvhOH9Jmng9tdTQfYoQ==
X-Google-Smtp-Source: APXvYqwmNdK9EX5N8hJMGqXnwRBul4VPcVs3d6fjXgg76iT9fYTSIsGVashExSg+w5hPMLpc1SaL2R5oPrrHqQp8Qq8=
X-Received: by 2002:a2e:42c9:: with SMTP id h70mr14817238ljf.88.1569921284671;
 Tue, 01 Oct 2019 02:14:44 -0700 (PDT)
MIME-Version: 1.0
References: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
 <1568878421-12301-5-git-send-email-vincent.guittot@linaro.org> <46e81a81-f88e-c935-d452-9b746bde492b@arm.com>
In-Reply-To: <46e81a81-f88e-c935-d452-9b746bde492b@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 1 Oct 2019 11:14:32 +0200
Message-ID: <CAKfTPtA7E5p1VZ+Ujbw4Sgp2fw8+TmSiLR-fGuUAdk=R8cQ9VQ@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] sched/fair: rework load_balance
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

group_asym_packing

On Tue, 1 Oct 2019 at 10:15, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 19/09/2019 09:33, Vincent Guittot wrote:
>
>
> [...]
>
> > @@ -8042,14 +8104,24 @@ static inline void update_sg_lb_stats(struct lb_env *env,
> >               }
> >       }
> >
> > -     /* Adjust by relative CPU capacity of the group */
> > +     /* Check if dst cpu is idle and preferred to this group */
> > +     if (env->sd->flags & SD_ASYM_PACKING &&
> > +         env->idle != CPU_NOT_IDLE &&
> > +         sgs->sum_h_nr_running &&
> > +         sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu)) {
> > +             sgs->group_asym_packing = 1;
> > +     }
> > +
>
> Since asym_packing check is done per-sg rather per-CPU (like misfit_task), can you
> not check for asym_packing in group_classify() directly (like for overloaded) and
> so get rid of struct sg_lb_stats::group_asym_packing?

asym_packing uses a lot of fields of env to set group_asym_packing but
env is not statistics and i'd like to remove env from
group_classify() argument so it will use only statistics.
At now, env is an arg of group_classify only for imbalance_pct field
and I have replaced env by imabalnce_pct in a patch that is under
preparation.
With this change, I can use group_classify outside load_balance()

>
> Something like (only compile tested).
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d0c3aa1dc290..b2848d6f8a2a 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7692,7 +7692,6 @@ struct sg_lb_stats {
>         unsigned int idle_cpus;
>         unsigned int group_weight;
>         enum group_type group_type;
> -       unsigned int group_asym_packing; /* Tasks should be moved to preferred CPU */
>         unsigned long group_misfit_task_load; /* A CPU has a task too big for its capacity */
>  #ifdef CONFIG_NUMA_BALANCING
>         unsigned int nr_numa_running;
> @@ -7952,6 +7951,20 @@ group_is_overloaded(struct lb_env *env, struct sg_lb_stats *sgs)
>         return false;
>  }
>
> +static inline bool
> +group_has_asym_packing(struct lb_env *env, struct sched_group *sg,
> +                      struct sg_lb_stats *sgs)
> +{
> +       if (env->sd->flags & SD_ASYM_PACKING &&
> +           env->idle != CPU_NOT_IDLE &&
> +           sgs->sum_h_nr_running &&
> +           sched_asym_prefer(env->dst_cpu, sg->asym_prefer_cpu)) {
> +               return true;
> +       }
> +
> +       return false;
> +}
> +
>  /*
>   * group_smaller_min_cpu_capacity: Returns true if sched_group sg has smaller
>   * per-CPU capacity than sched_group ref.
> @@ -7983,7 +7996,7 @@ group_type group_classify(struct lb_env *env,
>         if (sg_imbalanced(group))
>                 return group_imbalanced;
>
> -       if (sgs->group_asym_packing)
> +       if (group_has_asym_packing(env, group, sgs))
>                 return group_asym_packing;
>
>         if (sgs->group_misfit_task_load)
> @@ -8076,14 +8089,6 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>                 }
>         }
>
> -       /* Check if dst cpu is idle and preferred to this group */
> -       if (env->sd->flags & SD_ASYM_PACKING &&
> -           env->idle != CPU_NOT_IDLE &&
> -           sgs->sum_h_nr_running &&
> -           sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu)) {
> -               sgs->group_asym_packing = 1;
> -       }
> -
>         sgs->group_capacity = group->sgc->capacity;
>
> [...]
