Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4649AC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 16:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 183BD21907
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 16:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SEwIBnnF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731825AbfIRQAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 12:00:23 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:42770 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfIRQAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 12:00:23 -0400
Received: by mail-lj1-f170.google.com with SMTP id y23so440390lje.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 09:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kB3klimaMBAXuxxPltf9dvAUon1ngAzWdJNC6nDa9xY=;
        b=SEwIBnnFJgl52sap2TEUKcLV5i6OrZ8gthazapBPFC11qrkx8al/RlQOFWq8cpAbgo
         Jk1LyASoAbErR2XwYxV95Qeh6Z+bHRUe/EEc6JS4w3eOjCLjLu6gqr3QpqRrzXKITZWr
         9I6H2ZLlPy3OO0WTJEaUWqeAjATe5rjTdhvvLRjoQt4MGk/LpjAQQ4IVwFReu/WniU40
         7S0iWJGXKNOKym4bdZauK54kJjRO0pUE2Mk+fxlew7yf9x9BnsERXbazf3KWpCAKZIqI
         uM3Mzs4M7j53CMh1YVgtCLchSKzyKqzPKZeNLNMbNwp+kvGxjNMmcRdKb9luDzOZCS9O
         VPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kB3klimaMBAXuxxPltf9dvAUon1ngAzWdJNC6nDa9xY=;
        b=LPwSRPRb8XcmrrLa5fctEXYoScL+7DovfydqwUndrb0/ckoSKqrzroW3wuoe0snKUg
         4IL53ORKujsNT/ZPwpk3GbS57Ed5vWrQqskwh2MalfdCbUbB9T13LEfzy0r22jUH9OtA
         wRMavflQtj/k3NBUui6kqionURWzkypNHtFLk9ZxHpSJuutSKqbIqo8hF8szT9NnTAOD
         nODpolWYrr+/AKBe4w2Vfg4InCFA3LOfJbSVIaE61JfMEl5v5uEJCAGoRdNQReKRvXo9
         wkKJTdFZ14L1MuB7qHsBAD4lxH4tHndVhns7mcaBb0gvDUVazvRdFAonE6W9jdvtkBKs
         N90Q==
X-Gm-Message-State: APjAAAXPJEAnCQec89QKmpQ9dI1zeKMlKi+Zru2Df1BdhAnwcBRiIMRE
        P2U4Tt1nboLPvEpwCPSGFdg7+imvYhHdPJY7PDOyBg==
X-Google-Smtp-Source: APXvYqyN/OD06ODukSbHqVsiGfnK/cppj65X3rgN2oL+cjzN4zUFVpJL8zdiSCoo5n9CR64gHVcmrxeRtqox+dTw+Qc=
X-Received: by 2002:a2e:9689:: with SMTP id q9mr2724146lji.2.1568822420806;
 Wed, 18 Sep 2019 09:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <3e5c3f36-b806-5bcc-e666-14dc759a2d7b@linux.ibm.com>
 <87woe51ydd.fsf@arm.com> <CAKfTPtAF1WM6tCktgyyj=SLfJGT0qT5e_2Fu+SVheyfrJ-pg2A@mail.gmail.com>
 <87v9tp1ub9.fsf@arm.com>
In-Reply-To: <87v9tp1ub9.fsf@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 18 Sep 2019 18:00:09 +0200
Message-ID: <CAKfTPtDck+J7f6tD8SJPbR99f3JTHxW6_LxtRjieHy8jufs=aw@mail.gmail.com>
Subject: Re: Usecases for the per-task latency-nice attribute
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     Parth Shah <parth@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        subhra mazumdar <subhra.mazumdar@oracle.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Sep 2019 at 17:46, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
>
>
> On Wed, Sep 18, 2019 at 16:22:32 +0100, Vincent Guittot wrote...
>
> > On Wed, 18 Sep 2019 at 16:19, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
>
> [...]
>
> >> $> Wakeup path tunings
> >> ==========================
> >>
> >> Some additional possible use-cases was already discussed in [3]:
> >>
> >>  - dynamically tune the policy of a task among SCHED_{OTHER,BATCH,IDLE}
> >>    depending on crossing certain pre-configured threshold of latency
> >>    niceness.
> >>
> >>  - dynamically bias the vruntime updates we do in place_entity()
> >>    depending on the actual latency niceness of a task.
> >>
> >>    PeterZ thinks this is dangerous but that we can "(carefully) fumble a
> >>    bit there."
> >
> > I agree with Peter that we can easily break the fairness if we bias vruntime
>
> Just to be more precise here and also to better understand, here I'm
> talking about turning the tweaks we already have for:
>
>  - START_DEBIT
>  - GENTLE_FAIR_SLEEPERS

ok. So extending these 2 features could make sense

>
> a bit more parametric and proportional to the latency-nice of a task.
>
> In principle, if a task declares a positive latency niceness, could we
> not read this also as "I accept to be a bit penalised in terms of
> fairness at wakeup time"?

I would say no. It's not because you declare a positive latency
niceness that you should lose some fairness and runtime. If task
accept long latency because it's only care about throughput, it
doesn't want to lost some running time

>
> Whatever tweaks we do there should affect anyway only one sched_latency
> period... although I'm not yet sure if that's possible and how.
>
> >>  - bias the decisions we take in check_preempt_tick() still depending
> >>    on a relative comparison of the current and wakeup task latency
> >>    niceness values.
> >
> > This one seems possible as it will mainly enable a task to preempt
> > "earlier" the running task but will not break the fairness
> > So the main impact will be the number of context switch between tasks
> > to favor or not the scheduling latency
>
> Preempting before is definitively a nice-to-have feature.
>
> At the same time it's interesting a support where a low latency-nice
> task (e.g. TOP_APP) RUNNABLE on a CPU has better chances to be executed
> up to completion without being preempted by an high latency-nice task
> (e.g. BACKGROUND) waking up on its CPU.
>
> For that to happen, we need a mechanism to "delay" the execution of a
> less important RUNNABLE task up to a certain period.
>
> It's impacting the fairness, true, but latency-nice in this case will
> means that we want to "complete faster", not just "start faster".

you TOP_APP task will have to set both nice and latency-nice  if it
wants to make (almost) sure to have time to finish before BACKGROUND


>
> Is this definition something we can reason about?
>
> Best,
> Patrick
>
> --
> #include <best/regards.h>
>
> Patrick Bellasi
