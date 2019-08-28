Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BBEC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EDAB22CED
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h0ISrF6g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfH1NyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:54:07 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40692 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfH1NyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:54:06 -0400
Received: by mail-lj1-f194.google.com with SMTP id e27so2652759ljb.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 06:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YNLlD3gJWjjp8ucvxy4uYTyzUvgVA2hBhg1OuWiRkb0=;
        b=h0ISrF6g3mpaROi/eBdse9DLCHtnSu9apCZxs+iLsZ88RGHMZvwt4U8V5osKz3xnul
         YRmvGKjZqMDnv+gXZLk9K0yiyby6TfzKalFeTuZkinI1dMKHD67N1sUgtrGJ2518pjrn
         9xs/Q0kSXu2PYFNDmsGyoJ/meLaGC1o52kF09EEii/HWh5DRXBVTST1p+8uU1hl7M7Re
         RkzClyAIbZNC6b0jkw6xyM1W/rguVPYQA4qnzTMOVGVoOH9R+CbS1bpw+37wvCNaClXx
         brysnsGt8pn0fb1UfIFJnok6M/+opDuyV/TogYtKJb8jeJMlilC41NZhfGIrOu8wI5db
         Yn8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YNLlD3gJWjjp8ucvxy4uYTyzUvgVA2hBhg1OuWiRkb0=;
        b=pGA7oVyqWtRWrS7jzsGcdK1vv4gIk3l7SRAW9xkQp8TFL0LbltRAgTAg2PN3py9ygb
         PbuQfeDCdugS5yDe5zi08y1HpxbA+k2KaJiRu+k5vNZKxRSAmH4cIQVCyvOjbvWv0nRX
         t184G1yf6bwlQUSFcHytNCHgIalQAyMn8SosvZb9NWbLRP3OZ65gnrRpBbAtQbVbfHiL
         mWtms9lUFE8hmNQsiSa3HkOAeG0tON4Vz22sShTkHBAUS9xcMGc6lLHgIO+e4aH28D0P
         AuBG+Y5W6fBDoXEwZmJI9xVFeqyK+U0mgDYqMf+k8BmoONgbeSWZEDWsw0KBex8Kjaj8
         +P7g==
X-Gm-Message-State: APjAAAX6U1c469Y74wklGY7Xh4nRo2fhAtOG3qZxRskeoJgZyEwf8q01
        1bP4xKNibKRK3+xldBxgoM4iFv2xuhM5krumgdfFuA==
X-Google-Smtp-Source: APXvYqw88VqlBgQaXlC/tInHRObAlBZsED/hJat/ZDtYj/36G7e1vrmQx92P10Mgfko8fySLQHA1fCga2mZ1DwrBkm0=
X-Received: by 2002:a2e:8ec6:: with SMTP id e6mr2051953ljl.192.1567000444702;
 Wed, 28 Aug 2019 06:54:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190822021740.15554-1-riel@surriel.com> <20190822021740.15554-7-riel@surriel.com>
In-Reply-To: <20190822021740.15554-7-riel@surriel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 28 Aug 2019 15:53:53 +0200
Message-ID: <CAKfTPtCsuz7DN-NkmbMpLyNG=CqbAeONV8JpCVQmSCsd387eNQ@mail.gmail.com>
Subject: Re: [PATCH 06/15] sched,cfs: use explicit cfs_rq of parent se helper
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

On Thu, 22 Aug 2019 at 04:18, Rik van Riel <riel@surriel.com> wrote:
>
> Use an explicit "cfs_rq of parent sched_entity" helper in a few
> strategic places, where cfs_rq_of(se) may no longer point at the

The only case is the sched_entity of a task which will point to root
cfs, isn't it ?

> right runqueue once we flatten the hierarchical cgroup runqueues.
>
> No functional change.
>
> Signed-off-by: Rik van Riel <riel@surriel.com>
> ---
>  kernel/sched/fair.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 04b216234265..31a26737a873 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -276,6 +276,15 @@ static inline struct cfs_rq *group_cfs_rq(struct sched_entity *grp)
>         return grp->my_q;
>  }
>
> +/* runqueue owned by the parent entity; the root cfs_rq for a top level se */
> +static inline struct cfs_rq *group_cfs_rq_of_parent(struct sched_entity *se)
> +{
> +       if (se->parent)
> +               return group_cfs_rq(se->parent);
> +
> +       return cfs_rq_of(se);
> +}
> +
>  static inline bool list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
>  {
>         struct rq *rq = rq_of(cfs_rq);
> @@ -3319,7 +3328,7 @@ static inline int propagate_entity_load_avg(struct sched_entity *se)
>
>         gcfs_rq->propagate = 0;
>
> -       cfs_rq = cfs_rq_of(se);
> +       cfs_rq = group_cfs_rq_of_parent(se);
>
>         add_tg_cfs_propagate(cfs_rq, gcfs_rq->prop_runnable_sum);
>
> @@ -7796,7 +7805,7 @@ static void update_cfs_rq_h_load(struct cfs_rq *cfs_rq)
>
>         WRITE_ONCE(cfs_rq->h_load_next, NULL);
>         for_each_sched_entity(se) {
> -               cfs_rq = cfs_rq_of(se);
> +               cfs_rq = group_cfs_rq_of_parent(se);
>                 WRITE_ONCE(cfs_rq->h_load_next, se);
>                 if (cfs_rq->last_h_load_update == now)
>                         break;
> @@ -7819,7 +7828,7 @@ static void update_cfs_rq_h_load(struct cfs_rq *cfs_rq)
>
>  static unsigned long task_se_h_load(struct sched_entity *se)
>  {
> -       struct cfs_rq *cfs_rq = cfs_rq_of(se);
> +       struct cfs_rq *cfs_rq = group_cfs_rq_of_parent(se);
>
>         update_cfs_rq_h_load(cfs_rq);
>         return div64_ul(se->avg.load_avg * cfs_rq->h_load,
> @@ -10166,7 +10175,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
>         struct sched_entity *se = &curr->se;
>
>         for_each_sched_entity(se) {
> -               cfs_rq = cfs_rq_of(se);
> +               cfs_rq = group_cfs_rq_of_parent(se);
>                 entity_tick(cfs_rq, se, queued);
>         }
>
> --
> 2.20.1
>
