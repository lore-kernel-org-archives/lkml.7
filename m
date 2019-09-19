Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC451C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 08:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 950BB207FC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 08:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vtP961Mw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388311AbfISIA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 04:00:28 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37581 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388269AbfISIA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 04:00:27 -0400
Received: by mail-lf1-f66.google.com with SMTP id w67so1645407lff.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 01:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sgTCP96FLp9YNilI982cLmg/GDlavq1GIDyPQXwddlQ=;
        b=vtP961Mw0ZWI1S1jwgv6+Tv4nDQePMs5hU9AAF7cJVbP8YOReOgmk/9Es/V2RH34Te
         aJr8JEeKGbO/LnQsfKjN5RuLKyHMBx9jKEyPHNU3zqUG9TuuWsgG73+MIkRNmujow6qf
         czU+N8CPRWBDQ8TNc3z47w8DqNMKHX0IUqQY7S+KwgChCwFmVk80THAm/517E1YN656l
         yxdUvZoBR0Bip1ibjUlt4Gb7JH/6zTw2yjiOTk0dmprCBh81EoiZYZFFO0fdsMGwGWnz
         HKmtiiQoleJM672OqvNfYnAuWgZU6wzTivj3Bx2KJDDUscQCrIaY6MZ42Bg1VZvPO5Ow
         kvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sgTCP96FLp9YNilI982cLmg/GDlavq1GIDyPQXwddlQ=;
        b=N6TH0bCR1n5SHjAF4NLkHFsQyTI5YhsKEs3a+eOkH4BoK5//aHSQjWEvWLjtx9ht1B
         LWZG4GFOc9q3oK2WwyKlTuxZUzrh62QnwMrGBFPDI/b3TRHFqupC5UwRjD0YKSLaP53k
         2T2rnZsPlFAVLBSRiCqPdyzpVKvYk/Y+gvIyhWePDkt8ykYHnSieOGc5LdC27KwEluOi
         T/wnWSMXxuC0etvUzMIvynR66LnypEEcc05n7vAGiRBkd19knDkn59okdytrl6hMNNSo
         eibJXp3QNY7yo7yoqaomG4Ui2+N/G1OgHjW0R/3U/LKKXuKrKiv6OiELhuBmF6kN+1Ps
         vmdg==
X-Gm-Message-State: APjAAAVEET/qjXoP+UecOYHJGa8EpirQejTvKl76HZiI5sF1E/8UPkTr
        w4F/wTLSoOOMMA4IsZI2wBbBx2jYnWnDDFRkW/PX3RHaAoo=
X-Google-Smtp-Source: APXvYqyW2CpznJtbLWGcqjTVa+1aQcN7NzrdNN6eL6dX9xgtd54K2hxPHEv5YzEj7hlNN+zN/Ft2/uOR4h+5FV92TAc=
X-Received: by 2002:ac2:5a07:: with SMTP id q7mr4058834lfn.177.1568880024796;
 Thu, 19 Sep 2019 01:00:24 -0700 (PDT)
MIME-Version: 1.0
References: <1568877622-28073-1-git-send-email-yt.chang@mediatek.com>
In-Reply-To: <1568877622-28073-1-git-send-email-yt.chang@mediatek.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 19 Sep 2019 10:00:13 +0200
Message-ID: <CAKfTPtBFQJKmr0tw6_mA5OLsDu=HE+f4nFgZLGd4vv8dvyiubg@mail.gmail.com>
Subject: Re: [PATCH 1/1] sched/eas: introduce system-wide overutil indicator
To:     YT Chang <yt.chang@mediatek.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        wsd_upstream@mediatek.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Sep 2019 at 09:20, YT Chang <yt.chang@mediatek.com> wrote:
>
> When the system is overutilization, the load-balance crossing

s/overutilization/overutilized/

> clusters will be triggered and scheduler will not use energy
> aware scheduling to choose CPUs.
>
> The overutilization means the loading of  ANY CPUs

s/ANY/any/

> exceeds threshold (80%).
>
> However, only 1 heavy task or while-1 program will run on highest
> capacity CPUs and it still result to trigger overutilization. So
> the system will not use Energy Aware scheduling.
>
> To avoid it, a system-wide over-utilization indicator to trigger
> load-balance cross clusters.

The current rd->overutilized is already system wide. I mean that as
soon as one CPU is overutilized, the whole system is considered as
overutilized whereas you would like a finer grain level of
overutilization.
I remember a patch that was proposing a per sched_domain
overutilization detection. The load_balance at one sched_domain level
was enabled only if the child level was not able to handle the
overutilization and the energy aware scheduling was still used in the
other sched_domain

>
> The policy is:
>         The loading of "ALL CPUs in the highest capacity"
>                                                 exceeds threshold(80%) or
>         The loading of "Any CPUs not in the highest capacity"
>                                                 exceed threshold(80%)

Do you have UCs or figures that show a benefit with this change ?

>
> Signed-off-by: YT Chang <yt.chang@mediatek.com>
> ---
>  kernel/sched/fair.c | 76 +++++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 65 insertions(+), 11 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 036be95..f4c3d70 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5182,10 +5182,71 @@ static inline bool cpu_overutilized(int cpu)
>  static inline void update_overutilized_status(struct rq *rq)
>  {
>         if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu)) {
> -               WRITE_ONCE(rq->rd->overutilized, SG_OVERUTILIZED);
> -               trace_sched_overutilized_tp(rq->rd, SG_OVERUTILIZED);
> +               if (capacity_orig_of(cpu_of(rq)) < rq->rd->max_cpu_capacity) {
> +                       WRITE_ONCE(rq->rd->overutilized, SG_OVERUTILIZED);
> +                       trace_sched_overutilized_tp(rq->rd, SG_OVERUTILIZED);
> +               }
>         }
>  }
> +
> +static
> +void update_system_overutilized(struct sched_domain *sd, struct cpumask *cpus)
> +{
> +       unsigned long group_util;
> +       bool intra_overutil = false;
> +       unsigned long max_capacity;
> +       struct sched_group *group = sd->groups;
> +       struct root_domain *rd;
> +       int this_cpu;
> +       bool overutilized;
> +       int i;
> +
> +       this_cpu = smp_processor_id();
> +       rd = cpu_rq(this_cpu)->rd;
> +       overutilized = READ_ONCE(rd->overutilized);
> +       max_capacity = rd->max_cpu_capacity;
> +
> +       do {
> +               group_util = 0;
> +               for_each_cpu_and(i, sched_group_span(group), cpus) {
> +                       group_util += cpu_util(i);
> +                       if (cpu_overutilized(i)) {
> +                               if (capacity_orig_of(i) < max_capacity) {
> +                                       intra_overutil = true;
> +                                       break;
> +                               }
> +                       }
> +               }
> +
> +               /*
> +                * A capacity base hint for over-utilization.
> +                * Not to trigger system overutiled if heavy tasks
> +                * in Big.cluster, so
> +                * add the free room(20%) of Big.cluster is impacted which means
> +                * system-wide over-utilization,
> +                * that considers whole cluster not single cpu
> +                */
> +               if (group->group_weight > 1 && (group->sgc->capacity * 1024 <
> +                                               group_util * capacity_margin)) {
> +                       intra_overutil = true;
> +                       break;
> +               }
> +
> +               group = group->next;
> +
> +       } while (group != sd->groups && !intra_overutil);
> +
> +       if (overutilized != intra_overutil) {
> +               if (intra_overutil == true) {
> +                       WRITE_ONCE(rd->overutilized, SG_OVERUTILIZED);
> +                       trace_sched_overutilized_tp(rd, SG_OVERUTILIZED);
> +               } else {
> +                       WRITE_ONCE(rd->overutilized, 0);
> +                       trace_sched_overutilized_tp(rd, 0);
> +               }
> +       }
> +}
> +
>  #else
>  static inline void update_overutilized_status(struct rq *rq) { }
>  #endif
> @@ -8242,15 +8303,6 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>
>                 /* update overload indicator if we are at root domain */
>                 WRITE_ONCE(rd->overload, sg_status & SG_OVERLOAD);
> -
> -               /* Update over-utilization (tipping point, U >= 0) indicator */
> -               WRITE_ONCE(rd->overutilized, sg_status & SG_OVERUTILIZED);
> -               trace_sched_overutilized_tp(rd, sg_status & SG_OVERUTILIZED);
> -       } else if (sg_status & SG_OVERUTILIZED) {
> -               struct root_domain *rd = env->dst_rq->rd;
> -
> -               WRITE_ONCE(rd->overutilized, SG_OVERUTILIZED);
> -               trace_sched_overutilized_tp(rd, SG_OVERUTILIZED);
>         }
>  }
>
> @@ -8476,6 +8528,8 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
>          */
>         update_sd_lb_stats(env, &sds);
>
> +       update_system_overutilized(env->sd, env->cpus);

This should be called only if (sched_energy_enabled())

> +
>         if (sched_energy_enabled()) {
>                 struct root_domain *rd = env->dst_rq->rd;
>
> --
> 1.9.1
>
