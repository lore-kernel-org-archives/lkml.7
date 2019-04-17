Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627BFC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 23:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3378F2183F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 23:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pBw+np0n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387702AbfDQXIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 19:08:02 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36595 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387617AbfDQXIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 19:08:01 -0400
Received: by mail-wr1-f66.google.com with SMTP id y13so459822wrd.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 16:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m0+XMLd9YsaoHc4iKK68JAe8iNUvJjRM/ShPYIP04nk=;
        b=pBw+np0nsENmTaXuAa3htCqg4W2eEQV4XWA++dkWlgrXQUvfCAnjSTir3MFBBEAyYO
         07CE45zMHxFjD763shuTNYuRCLJ8o2skqdab5DW0KrUhJTscWz6P5IAnkbOrq8yUTm43
         2fYHLFKyzn468+BjO1Vh7N/UhGOKfn+vTQIAKC8dQBAZPvEXxAwXOAvROfJEs7jhJ4Qk
         c95eTrgjWOdibkzRWNw9129Ybd8vUeI7PAWMYhuPx38+BXDtd5WJu0a0kSRAXM8pNmWg
         91VHPaEmv8ZUCQc+q0CAQOUS325DFVVy/f7tb/+CbZ/41dEFGee0wl7mcRhsA21QhMFL
         bFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m0+XMLd9YsaoHc4iKK68JAe8iNUvJjRM/ShPYIP04nk=;
        b=C+Pt+3Qvd51TT/UbankYycXUWb804elBaSVNAtqQ9l0upNtvsP0ANdo3eqxGc3KmfE
         b3xpAU0aKfvPm5akwXlBvs7KzdQGescTPxBmCZBIZSLYq03wyqc3md+PXyRtPJb6Vl5T
         0xQJnUEuxx09SDhFHlHcT2HT6J7kstUNf/mFHE1VJtXcq+a9el7/1yKNG1AVUSwDKQRF
         +ABq/HEtpE+CbVlETJBgnC90DgUCUtJD5NnTVxAxrfj1XxCOO65KAVHSvqtoB6M9jIW/
         0XJp0wStLFqr0uYO97WnYoHrrPrZCIQBwvB4ffg2iWYzIgwM+u5mFE9N6IKt3d9lL+u5
         rsYA==
X-Gm-Message-State: APjAAAUh9GKmxufY4lWuw/lwNGYNrtNUw471OjHLboW4cPPnr1RYG9bG
        4QduY118jjqQeD4BQUt4QzdeufCXZnxVEAEYf9IT2A==
X-Google-Smtp-Source: APXvYqzFOHyqZUZ5RJ93xh1sS/UW+R6siuj863T4cJnREaeiWM5+qkieXfJvd9nA04+h0VrJGd5Q61w6NpRpJiWIFXg=
X-Received: by 2002:a5d:4f8b:: with SMTP id d11mr28114025wru.150.1555542479268;
 Wed, 17 Apr 2019 16:07:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190402104153.25404-1-patrick.bellasi@arm.com> <20190402104153.25404-9-patrick.bellasi@arm.com>
In-Reply-To: <20190402104153.25404-9-patrick.bellasi@arm.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 17 Apr 2019 16:07:48 -0700
Message-ID: <CAJuCfpH9E2Khc1WP8MZgLK+yF7GgwW29ECES4hqPN3jaB34RqA@mail.gmail.com>
Subject: Re: [PATCH v8 08/16] sched/core: uclamp: Set default clamps for RT tasks
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 2, 2019 at 3:42 AM Patrick Bellasi <patrick.bellasi@arm.com> wrote:
>
> By default FAIR tasks start without clamps, i.e. neither boosted nor
> capped, and they run at the best frequency matching their utilization
> demand.  This default behavior does not fit RT tasks which instead are
> expected to run at the maximum available frequency, if not otherwise
> required by explicitly capping them.
>
> Enforce the correct behavior for RT tasks by setting util_min to max
> whenever:
>
>  1. the task is switched to the RT class and it does not already have a
>     user-defined clamp value assigned.
>
>  2. an RT task is forked from a parent with RESET_ON_FORK set.
>
> NOTE: utilization clamp values are cross scheduling class attributes and
> thus they are never changed/reset once a value has been explicitly
> defined from user-space.
>
> Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> ---
>  kernel/sched/core.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index bdebdabe9bc4..71c9dd6487b1 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1042,6 +1042,28 @@ static int uclamp_validate(struct task_struct *p,
>  static void __setscheduler_uclamp(struct task_struct *p,
>                                   const struct sched_attr *attr)
>  {
> +       unsigned int clamp_id;
> +
> +       /*
> +        * On scheduling class change, reset to default clamps for tasks
> +        * without a task-specific value.
> +        */
> +       for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
> +               struct uclamp_se *uc_se = &p->uclamp_req[clamp_id];
> +               unsigned int clamp_value = uclamp_none(clamp_id);
> +
> +               /* Keep using defined clamps across class changes */
> +               if (uc_se->user_defined)
> +                       continue;
> +
> +               /* By default, RT tasks always get 100% boost */
> +               if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN))
> +                       clamp_value = uclamp_none(UCLAMP_MAX);
> +
> +               uc_se->bucket_id = uclamp_bucket_id(clamp_value);
> +               uc_se->value = clamp_value;

Is it possible for p->uclamp_req[UCLAMP_MAX].value to be less than
uclamp_none(UCLAMP_MAX) for this RT task? If that's a possibility then
I think we will end up with a case of p->uclamp_req[UCLAMP_MIN].value
> p->uclamp_req[UCLAMP_MAX].value after these assignments are done.

> +       }
> +
>         if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
>                 return;
>
> @@ -1077,6 +1099,10 @@ static void uclamp_fork(struct task_struct *p)
>         for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
>                 unsigned int clamp_value = uclamp_none(clamp_id);
>
> +               /* By default, RT tasks always get 100% boost */
> +               if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN))
> +                       clamp_value = uclamp_none(UCLAMP_MAX);
> +
>                 p->uclamp_req[clamp_id].user_defined = false;
>                 p->uclamp_req[clamp_id].value = clamp_value;
>                 p->uclamp_req[clamp_id].bucket_id = uclamp_bucket_id(clamp_value);
> --
> 2.20.1
>
