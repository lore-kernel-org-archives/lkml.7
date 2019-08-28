Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF58CC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CA43214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YpmxYUVQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfH1RcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 13:32:19 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39495 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfH1RcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 13:32:19 -0400
Received: by mail-lj1-f193.google.com with SMTP id x4so325741ljj.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 10:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8qd9uDtDKAYrGf5FVzWTysgwl4bOPCeZQ18mj4Gsi3k=;
        b=YpmxYUVQN4Bc3N0gHlrPqxI/acBLSzcAUD5kCstyYybhjimnPZjcT4bxa6oXHpaowL
         3wEQqGbTomQydS0dxVAUQm90+u881tmpxMOpdXCouusYEi1fln0XtVtiqSnMq0f6/Ooq
         6mrGOXKOIqAudzqxItKkvb9FVIQjC5X+NFiIwtw+vilykvfw+nZTVx/3CENytKepIsd4
         KN0thSj9D0S61f9J76MdK3u60PYRqeVJHTozaE7n5Glh2QYZwhBwwB2KuuYw0q13zm4+
         /ZORwWQIygDPaH0hfPP/nEARvrPhzRhzByfp9HLsBw0mK4HtbxFBAcqmY2VrbLhTwN94
         m0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8qd9uDtDKAYrGf5FVzWTysgwl4bOPCeZQ18mj4Gsi3k=;
        b=F3MYnCjfFUOGJUCO828XJKKAhaPtOumame26CDSHnhCKzRbXCSFQA0QJmTlxPCDttL
         dZg+EQYS5h1+1b1iKGkeKDc7qvv1Jfgv828zbB3PRbgk8FgjcQIxDVsN5lV5Nq+EV2Fe
         lOcNlbA4CaCYV+YrbO3yeU+hZD2GHw67FAGHQlpQgteCUJc4/AWqeN0inNM6WcTC5XnU
         DiFBU40tdI3qDNZGqCBVqfMDvdNNbMHQOsMKUwPmbcNF6yItpiRSvqiag2+kVFfKx6WG
         eP4TDe5L/Qjs7QnzeZTGHPZs5UOJY0Aishcw6vILVsFCDXQLRF3098MWQu2pALXRzy2k
         6pRQ==
X-Gm-Message-State: APjAAAV1a8yyzj/m9FB2+uPOjYP6aoBtRQ8hbJ/8wfeC23Oay4XVxTHp
        OSc0QbZL8rSZGzX0iH7n0UdLOW6rp/DdY03Gib/W6g==
X-Google-Smtp-Source: APXvYqxxGgDzLtIMSUYhug4BtQvbD5qbWAUyw3a7t0FA09sestyJmYS8nHkDT3G6XruToS8W8hAnweD4TmSajD4ba7g=
X-Received: by 2002:a05:651c:1b8:: with SMTP id c24mr2730534ljn.2.1567013536968;
 Wed, 28 Aug 2019 10:32:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190822021740.15554-1-riel@surriel.com> <20190822021740.15554-9-riel@surriel.com>
In-Reply-To: <20190822021740.15554-9-riel@surriel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 28 Aug 2019 19:32:05 +0200
Message-ID: <CAKfTPtDxHijR3PCOFfxA-r02rf2hVP4LpB=y-9emHS7znTPxTA@mail.gmail.com>
Subject: Re: [PATCH 08/15] sched,fair: simplify timeslice length code
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
> The idea behind __sched_period makes sense, but the results do not always.
>
> When a CPU has one high priority task and a large number of low priority
> tasks, __sched_period will return a value larger than sysctl_sched_latency,
> and the one high priority task may end up getting a timeslice all for itself
> that is also much larger than sysctl_sched_latency.

note that unless you enable sched_feat(HRTICK), the sched_slice is
mainly used to decide how fast we preempt running task at tick but a
newly wake up task can preempt it before

>
> The low priority tasks will have their time slices rounded up to
> sysctl_sched_min_granularity, resulting in an even larger scheduling
> latency than targeted by __sched_period.

Will this not break the fairness between a always running task and a
short sleeping one with this changes ?

>
> Simplify the code by simply ripping out __sched_period and always taking
> fractions of sysctl_sched_latency.
>
> If a high priority task ends up getting a "too small" time slice compared
> to low priority tasks, the vruntime scaling ensures that it will simply
> get scheduled more frequently than low priority tasks.

Will you not increase the number of context switch ?

>
> Signed-off-by: Rik van Riel <riel@surriel.com>
> ---
>  kernel/sched/fair.c | 18 +-----------------
>  1 file changed, 1 insertion(+), 17 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8f8c85c6da9b..74ee22c59d13 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -691,22 +691,6 @@ static inline u64 calc_delta_fair(u64 delta, struct sched_entity *se)
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
> @@ -715,7 +699,7 @@ static u64 __sched_period(unsigned long nr_running)
>   */
>  static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  {
> -       u64 slice = __sched_period(cfs_rq->nr_running + !se->on_rq);
> +       u64 slice = sysctl_sched_latency;
>
>         for_each_sched_entity(se) {
>                 struct load_weight *load;
> --
> 2.20.1
>
