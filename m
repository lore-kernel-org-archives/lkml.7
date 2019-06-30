Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DD1C5B57E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 08:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D0312070D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 08:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pfZhSmCs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfF3In5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 04:43:57 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38157 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfF3In5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 04:43:57 -0400
Received: by mail-lf1-f67.google.com with SMTP id b11so6705396lfa.5
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2019 01:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8xJ3NtDnz126YWDPuehzdo9M2uL1CYBft+8pSEmMCpA=;
        b=pfZhSmCsjXyup+uKoSBqsiP8Pe7j8ELCb9SOsDc4g/CfWT+vUFWojYVaZJjNzXiC+K
         liv/QjkKWo3f7rxOoxT2Qv8RESgHDanuj34h1eWl/jq10/Utwi9JTdfCrL3WshS1utep
         BhRpLaQ+JNv/Aq7Q+74xwFCK2WuL8mK+PMB/PntlAga8SFHRNaiLocAXs2OAACId0k02
         lo/uNrU6DPLMMsZkqGAA0SWsv3f9MvYBg05pBb+WStgz5h0Zh8Pn+/t95v4ps7TwPu0Z
         KtVOSeCtX/Mj5sMayPrcyJ6DAumrJ9eIIREkI5B/l0+YzK2fVF+DQnwsIyadkyOBRx5v
         IA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8xJ3NtDnz126YWDPuehzdo9M2uL1CYBft+8pSEmMCpA=;
        b=Ho1jF780E7G+F18ipthAIxsdgNgRADsMY69LaCeADDGbQr+HndpsNS5Euk4ak5Ck+2
         9WrEBXh0dFXRn7vS1aVwTlfnaMhoPMURiptPyyUFU3fN0pF+88d8PrlSRDclyf3n67nx
         lPIm9ZsP57OFGtqUwA3hE3z45gj5TWtLuyh/YWrO3UMImev2CpKdPCg4bfG//0AFF1kO
         vtDh2lgOSDQsU77CwuNa7zr8cIJV1Db4e4JaMXmN795JON8B//0s539TO+nf8G8GUQln
         fZLVVhilYtip1t3e8hzIB1zZbPAY+cNDjP4H41JnU6QHk2xGwU6MbhHaq96a/CB039FF
         W0LQ==
X-Gm-Message-State: APjAAAXmHtxcdi+oIVc8diIZiQH21t0Qorwv2MCaqpzm3IUoVgW5Ogtc
        DJjS8igIvlx7z1WXzBozifhA9biSMkdEfKasWSe6wA==
X-Google-Smtp-Source: APXvYqxF56iakcH1FtkHl3nii6OSR/l29UEvau0Az1NaIb3gO1E3vFCwbNzJlkfdADLEnp/fQB0YC/jveUz5Io3OeQo=
X-Received: by 2002:ac2:5337:: with SMTP id f23mr9255249lfh.15.1561884234481;
 Sun, 30 Jun 2019 01:43:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150555.15717-1-patrick.bellasi@arm.com>
 <CAKfTPtDTfyBvfwE6_gtjxJoPNS6YGQ7rrLcjg_M-jr=YSc+FNA@mail.gmail.com>
 <20190628100751.lpcwsouacsi2swkm@e110439-lin> <20190628123800.GS3419@hirez.programming.kicks-ass.net>
 <CAKfTPtCyC5R40xjzQjp8qJchay9WzucuE4E-CduR46tNBh0uRg@mail.gmail.com> <20190628141011.d4oo5ezp4kxgrfnn@e110439-lin>
In-Reply-To: <20190628141011.d4oo5ezp4kxgrfnn@e110439-lin>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Sun, 30 Jun 2019 10:43:43 +0200
Message-ID: <CAKfTPtDeR7+-ah4KiQVu7SQAns0yvumr4_mqGiVsVGhSs+v34A@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: util_est: fast ramp-up EWMA on utilization increases
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Douglas Raillard <douglas.raillard@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jun 2019 at 16:10, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
>
> On 28-Jun 15:51, Vincent Guittot wrote:
> > On Fri, 28 Jun 2019 at 14:38, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Fri, Jun 28, 2019 at 11:08:14AM +0100, Patrick Bellasi wrote:
> > > > On 26-Jun 13:40, Vincent Guittot wrote:
> > > > > Hi Patrick,
> > > > >
> > > > > On Thu, 20 Jun 2019 at 17:06, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> > > > > >
> > > > > > The estimated utilization for a task is currently defined based on:
> > > > > >  - enqueued: the utilization value at the end of the last activation
> > > > > >  - ewma:     an exponential moving average which samples are the enqueued values
> > > > > >
> > > > > > According to this definition, when a task suddenly change it's bandwidth
> > > > > > requirements from small to big, the EWMA will need to collect multiple
> > > > > > samples before converging up to track the new big utilization.
> > > > > >
> > > > > > Moreover, after the PELT scale invariance update [1], in the above scenario we
> > > > > > can see that the utilization of the task has a significant drop from the first
> > > > > > big activation to the following one. That's implied by the new "time-scaling"
> > > > >
> > > > > Could you give us more details about this? I'm not sure to understand
> > > > > what changes between the 1st big activation and the following one ?
> > > >
> > > > We are after a solution for the problem Douglas Raillard discussed at
> > > > OSPM, specifically the "Task util drop after 1st idle" highlighted in
> > > > slide 6 of his presentation:
> > > >
> > > >   http://retis.sssup.it/ospm-summit/Downloads/02_05-Douglas_Raillard-How_can_we_make_schedutil_even_more_effective.pdf
> > > >
> > >
> > > So I see the problem, and I don't hate the patch, but I'm still
> > > struggling to understand how exactly it related to the time-scaling
> > > stuff. Afaict the fundamental problem here is layering two averages. The
> >
> > AFAICT, it's not related to the time-scaling
> >
> > In fact the big 1st activation happens because task runs at low OPP
> > and hasn't enough time to finish its running phase before the time to
> > begin the next one happens. This means that the task will run several
> > computations phase in one go which is no more a 75% task.
>
> But in that case, running multiple activations back to back, should we
> not expect the util_avg to exceed the 75% mark?

But task starts with a very low value and Pelt needs time to ramp up.

>
>
> > From a pelt PoV, the task is far larger than a 75% task and its
> > utilization too because it runs far longer (even after scaling time
> > with frequency).
>
> Which thus should match my expectation above, no?

But utilization has to ramp up before stabilizing to final value. The
value at the end of the 1st big activation is not what would be the
utilization if task was always that long

>
> > Once cpu reaches a high enough OPP that enable to have sleep phase
> > between each running phases, the task load tracking comes back to the
> > normal slope increase (the one that would have happen if task would
> > have jump from 5% to 75% but already running at max OPP)
>
>
> Indeed, I can see from the plots a change in slope. But there is also
> that big drop after the first big activation: 375 units in 1.1ms.
>
> Is that expected? I guess yes, since we fix the clock_pelt with the
> lost_idle_time.
>
>
> > > second (EWMA in our case) will always lag/delay the input of the first
> > > (PELT).
> > >
> > > The time-scaling thing might make matters worse, because that helps PELT
> > > ramp up faster, but that is not the primary issue.
> > >
> > > Or am I missing something?
>
> --
> #include <best/regards.h>
>
> Patrick Bellasi
