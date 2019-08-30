Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D74C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1368921726
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UVEbVzrO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfH3Glc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 02:41:32 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46173 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfH3Glc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 02:41:32 -0400
Received: by mail-lf1-f68.google.com with SMTP id n19so4437097lfe.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 23:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vWBOF7L/DOCaXKkeBfa9bHcFotH7VO/yMH6MWg+pOs8=;
        b=UVEbVzrOcyBD9t7iur7XNpIk4mk114Y4yd9S55ZNizwKYZfTBQNFqi9/kxI4iOMh1N
         s464ZhcarWv02wag88TJuDsrPO/ok09wjh8jzTCwfmDfFTzv5crFcAe+2vkO2HKxEVmq
         B2HkuBxjKYxYKB0cDOgKuZwEpapCrkBCjcUX8GJCiL/ElHWHK0bBCkhxZqNDxuFRSJDn
         r7URIldThRjLe1sur+3KZMAOJhkXEbaZXfhvRAElPNoHVjAl3DCK0G6dCvfnzbIT0m+B
         ZeqHagY989QX/AyingVkSlTx5c6mTyld7f8MFBciKvQkiBWhHTp28/TdIQA0JsPr3XA2
         OWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vWBOF7L/DOCaXKkeBfa9bHcFotH7VO/yMH6MWg+pOs8=;
        b=JzdIWKek6/r3k/yGvKbdjnfTPpEbqZIyh9Mw2kAXyxZ4OojnT0R3aJdO1JsFyOO2e0
         X7JHB3ju4YtW8wajzrbf7CLVKMZ/s/y+SDjt1qcNn/dpcD4+ELpuWUsdc6AZwzSLoSNm
         veqA4H6r2/H4F35Nupyl96PSZqWJ3bLxZB6NPsorwgdUoa4hjAIapRl0vT66jpWmuEsF
         DaMsfXdL06mb1YQAhCBmvIUXE8+I+kDvw91NGUT5d8BdkYrv/yGBCTgn6fqJz2I2+Sgz
         YeyIffZsKTaOf9GhwXyqS1+sC2EjK31IxL2lI/kuJdlpz0TDkAK0FpQm0JsY8DmIsohE
         GcIA==
X-Gm-Message-State: APjAAAWhX+xfoaINLOA+spgD/yUDoN6Z2s+Zm8Jf1gOVScT9k99eHAwb
        suQeqoupW0c+4Jncr3fvwkMc8kCnHBMU6rcNvkhxgQ==
X-Google-Smtp-Source: APXvYqzNHkk48QdykrCa7nUQ5bgYkDthjxlYnNFho7YV8cxx+XVNa82Ph7h5UpeTPzzpIjWNGcYD+TNoX7vdies4qYY=
X-Received: by 2002:ac2:4a8f:: with SMTP id l15mr7672532lfp.125.1567147289641;
 Thu, 29 Aug 2019 23:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190822021740.15554-1-riel@surriel.com> <20190822021740.15554-9-riel@surriel.com>
 <CAKfTPtDxHijR3PCOFfxA-r02rf2hVP4LpB=y-9emHS7znTPxTA@mail.gmail.com>
 <d703071084dadb477b8248b041d0d1aa730d65cd.camel@surriel.com>
 <CAKfTPtDX+keNfNxf78yMoF3QaXSG_fZHJ_nqCFKYDMYGa84A6Q@mail.gmail.com> <2a87463e8a51c34733e9c1fcf63380f9caa7afc4.camel@surriel.com>
In-Reply-To: <2a87463e8a51c34733e9c1fcf63380f9caa7afc4.camel@surriel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 30 Aug 2019 08:41:17 +0200
Message-ID: <CAKfTPtCAU7bT3sJ_FPexqKrfFzd8Yk0hVTEB5Da=+VbqPViXpA@mail.gmail.com>
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

On Thu, 29 Aug 2019 at 18:00, Rik van Riel <riel@surriel.com> wrote:
>
> On Thu, 2019-08-29 at 16:02 +0200, Vincent Guittot wrote:
> > On Thu, 29 Aug 2019 at 01:19, Rik van Riel <riel@surriel.com> wrote:
> >
> > > What am I overlooking?
> >
> > My point is more for task that runs several ticks in a row. Their
> > sched_slice will be shorter in some cases with your changes so they
> > can be preempted earlier by other runnable tasks with a lower
> > vruntime
> > and there will be more context switch
>
> I can think of exactly one case where the time slice
> will be shorter with my new code than with the old code,
> and that is the case where:
> - A CPU has nr_running > sched_nr_latency

yes nr_running must be higher than  sched_nr_latency

> - __sched_period returns a value larger than sysctl_sched_latency
> - one of the tasks is much higher priority than the others

it's not only one, that can be several. It depends of the number of
running tasks

> - that one task alone gets a timeslice larger than sysctl_sched_latency
>
> With the new code, that high priority task will get a time
> slice that is a (large) fraction of sysctl_sched_latency,

yes

> while the other (lower priority) tasks get their time slices
> rounded up to sysctl_sched_min_granularity.

yes and if the jify period is higher than sysctl_sched_min_granularity
they will get a full jiffy period

>
> When tasks get their timeslice rounded up, that will increase
> the total sched period in a similar way the old code did by
> returning a longer period from __sched_period.

sched_slice is not a strict value and scheduler will not schedule out
the task after the sched_slice (unless you enable HRTICK which is
disable by default). Instead it will wait for next tick to change the
running task

sched_slice is mainly use to ensure a minimum running time in a row.
With this change, the running time of the high priority task will most
probably be split in several slice instead of one

>
> If a CPU is faced with a large number of equal priority tasks,
> both the old code and the new code would end up giving each
> task a timeslice length of sysctl_sched_min_granularity.
>
> What am I missing?
>
> --
> All Rights Reversed.
