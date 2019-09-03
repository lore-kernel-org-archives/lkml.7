Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12320C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 15:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF0C02077B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 15:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ts0NY2/s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbfICPi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 11:38:58 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34596 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbfICPi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 11:38:57 -0400
Received: by mail-lf1-f65.google.com with SMTP id z21so13284898lfe.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 08:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W1Tb9t4twp/nux6lXbmtrYQ5FWLSza1v+0RZOROryBI=;
        b=Ts0NY2/sRIP/7b27INZQksbp5peZPBNCTGDqagCisxjOvkrpdPsd274vEbhSAKUkie
         L7O0G9SsB7tGdu+HCbM2Vki0FvNg3rTz4MXz+j6GCudu1/Akln0EkYnTjeXXAO4aVBAc
         mJVo7mcoCyho2uA2Cv1jFi8Z+AcwC9LLVuzm69FJ4hBxOMIbDmFwsDKN6Rbyc9W69B5J
         sYPopsGsodZ7Gn5KSqCQk1jejoGhWplsicRwpnX2Mk34lLCzoNzdRV36+Fmf0bQ/6/ww
         pskPnRFfrrS4//exYKMAiUZ0XDxPcihlv5vHba5KGleDrmTRrQK9AY/RtZgR868lMiel
         saPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W1Tb9t4twp/nux6lXbmtrYQ5FWLSza1v+0RZOROryBI=;
        b=GyNSOX7xHDwwDHxu1+GqSgVpiUCmuffPMskc9KQu81woL8kn2e9lc7X22rxg/nrJWZ
         MZW1hQrbH0awRbc5Ysws31PoS2R179fY5EdldA9m+Ilh91AZ6xbiQVdI3nARAOdRnNm+
         Zvj9nlXBJfX2y7iMk/Bc11jdrlD2dYdoBOfYNi+u7ZaaXCrhb24AiLI9EEpHv3cYiQM4
         b2WDFWVGfy15eDaWqCjSzF6SqySjBKJn6LPToS4rC16cqsU+oMo9w9B3nz1wZS/4R8rH
         6e6Q12uRs/O7nfHrUynwq3xOVsKSTjtFHhzza1h4Dgmk5U/ouC1NTg9ymSTxLh+QzcTf
         cTFg==
X-Gm-Message-State: APjAAAWahFV/GcHr/Qup1M86qYoBhO9lyAKo7a658t5j77G/Ml7nAEy5
        Lun9H+0XayGQfv64nhETYtvNWkNMUCAtub0elv1F6A==
X-Google-Smtp-Source: APXvYqwrVEPc58DhYIyK5rYN3fjybOwhUUYuFA6X6iOZkGLH6gijnwK6jRTS2O3SuI9gHykGbD62gY8a029TEVZe8b0=
X-Received: by 2002:ac2:59c2:: with SMTP id x2mr9106428lfn.125.1567525134666;
 Tue, 03 Sep 2019 08:38:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190822021740.15554-1-riel@surriel.com> <20190822021740.15554-10-riel@surriel.com>
In-Reply-To: <20190822021740.15554-10-riel@surriel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 3 Sep 2019 17:38:43 +0200
Message-ID: <CAKfTPtAw1f89d4Sv+vSfytP8pJy-fy1hvpcz-=hoz4nrZXQV6A@mail.gmail.com>
Subject: Re: [PATCH 09/15] sched,fair: refactor enqueue/dequeue_entity
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

Hi Rik,

On Thu, 22 Aug 2019 at 04:18, Rik van Riel <riel@surriel.com> wrote:
>
> Refactor enqueue_entity, dequeue_entity, and update_load_avg, in order
> to split out the things we still want to happen at every level in the
> cgroup hierarchy with a flat runqueue from the things we only need to
> happen once.
>
> No functional changes.
>
> Signed-off-by: Rik van Riel <riel@surriel.com>
> ---
>  kernel/sched/fair.c | 64 +++++++++++++++++++++++++++++----------------
>  1 file changed, 42 insertions(+), 22 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 74ee22c59d13..7b0d95f2e3a8 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3502,7 +3502,7 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>  #define DO_ATTACH      0x4
>
>  /* Update task and its cfs_rq load average */
> -static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> +static inline bool update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  {
>         u64 now = cfs_rq_clock_pelt(cfs_rq);
>         int decayed;
> @@ -3531,6 +3531,8 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>
>         } else if (decayed && (flags & UPDATE_TG))
>                 update_tg_load_avg(cfs_rq, 0);
> +
> +       return decayed;

This is a functional change, isn't it ?
update_cfs_group is now called only if decayed but we can we attach a
task during the enqueue and there is no decay

>
>  }
>
>  #ifndef CONFIG_64BIT
> @@ -3747,9 +3749,10 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
>  #define SKIP_AGE_LOAD  0x0
>  #define DO_ATTACH      0x0
>
> -static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int not_used1)
> +static inline bool update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int not_used1)
>  {
>         cfs_rq_util_change(cfs_rq, 0);
> +       return false;
>  }
>
>  static inline void remove_entity_load_avg(struct sched_entity *se) {}
> @@ -3872,6 +3875,24 @@ static inline void check_schedstat_required(void)
>   * CPU and an up-to-date min_vruntime on the destination CPU.
>   */
>
> +static bool
> +enqueue_entity_groups(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> +{
> +       /*
> +        * When enqueuing a sched_entity, we must:
> +        *   - Update loads to have both entity and cfs_rq synced with now.
> +        *   - Add its load to cfs_rq->runnable_avg
> +        *   - For group_entity, update its weight to reflect the new share of
> +        *     its group cfs_rq
> +        *   - Add its new weight to cfs_rq->load.weight
> +        */
> +       if (!update_load_avg(cfs_rq, se, UPDATE_TG | DO_ATTACH))
> +               return false;
>
> +
> +       update_cfs_group(se);
> +       return true;
> +}
> +
>  static void
>  enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  {
> @@ -3896,16 +3917,6 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>         if (renorm && !curr)
>                 se->vruntime += cfs_rq->min_vruntime;
>
> -       /*
> -        * When enqueuing a sched_entity, we must:
> -        *   - Update loads to have both entity and cfs_rq synced with now.
> -        *   - Add its load to cfs_rq->runnable_avg
> -        *   - For group_entity, update its weight to reflect the new share of
> -        *     its group cfs_rq
> -        *   - Add its new weight to cfs_rq->load.weight
> -        */
> -       update_load_avg(cfs_rq, se, UPDATE_TG | DO_ATTACH);
> -       update_cfs_group(se);
>         enqueue_runnable_load_avg(cfs_rq, se);
>         account_entity_enqueue(cfs_rq, se);
>
> @@ -3972,14 +3983,9 @@ static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se)
>
>  static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq);
>
> -static void
> -dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> +static bool
> +dequeue_entity_groups(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  {
> -       /*
> -        * Update run-time statistics of the 'current'.
> -        */
> -       update_curr(cfs_rq);
> -
>         /*
>          * When dequeuing a sched_entity, we must:
>          *   - Update loads to have both entity and cfs_rq synced with now.
> @@ -3988,7 +3994,21 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>          *   - For group entity, update its weight to reflect the new share
>          *     of its group cfs_rq.
>          */
> -       update_load_avg(cfs_rq, se, UPDATE_TG);
> +       if (!update_load_avg(cfs_rq, se, UPDATE_TG))
> +               return false;
> +       update_cfs_group(se);
> +
> +       return true;
> +}
> +
> +static void
> +dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> +{
> +       /*
> +        * Update run-time statistics of the 'current'.
> +        */
> +       update_curr(cfs_rq);
> +
>         dequeue_runnable_load_avg(cfs_rq, se);
>
>         update_stats_dequeue(cfs_rq, se, flags);
> @@ -4012,8 +4032,6 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>         /* return excess runtime on last dequeue */
>         return_cfs_rq_runtime(cfs_rq);
>
> -       update_cfs_group(se);
> -
>         /*
>          * Now advance min_vruntime if @se was the entity holding it back,
>          * except when: DEQUEUE_SAVE && !DEQUEUE_MOVE, in this case we'll be
> @@ -5178,6 +5196,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>                 if (se->on_rq)
>                         break;
>                 cfs_rq = cfs_rq_of(se);
> +               enqueue_entity_groups(cfs_rq, se, flags);
>                 enqueue_entity(cfs_rq, se, flags);
>
>                 /*
> @@ -5260,6 +5279,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>
>         for_each_sched_entity(se) {
>                 cfs_rq = cfs_rq_of(se);
> +               dequeue_entity_groups(cfs_rq, se, flags);
>                 dequeue_entity(cfs_rq, se, flags);
>
>                 /*
> --
> 2.20.1
>
