Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA3EC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0DB1215EA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nQyfMz0r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbfH2OCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:02:41 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45543 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfH2OCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:02:40 -0400
Received: by mail-lj1-f195.google.com with SMTP id l1so3116609lji.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 07:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dg3waXVhGBOhHjSyELaZhZ1UjdRtnKIsZjLbc8wGGk0=;
        b=nQyfMz0rrIB7W4KOr8ftop9bYn7B4EJBAeM7qcy/8CD0hq1IQw7UHG/0pcdTT8nXmS
         lpNCkUPn/MvnHkcTjxwokWTRmIgfKDtpRhTkCW+mBkiN9nWe6g7TobZRF1kAgK7u0Kh3
         T9wy3PEeNQSDvqPP528u/uSUEyAvUmRVxyEl/tOoFTdU9qfejLAHaT+IZ+An8l5Fismw
         x32AooA4j0IHIXRdQ3ktDIvLwTBFN+ikdwkm4rwHoteKCr34oPKmQTdTNFZKscwUowkD
         2Z2KVlh8ZJNClGp+2fzl0Wwb1f5L/P9jgVZFXDXb30ZrFCgCmUFc2pDWj7k42JacCeO9
         Uqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dg3waXVhGBOhHjSyELaZhZ1UjdRtnKIsZjLbc8wGGk0=;
        b=m4+cqoDWWcp1WFqqtOPWWHC/QnDpOv3ZRPLXWjRiZo8BpwjVIq7ILGR8fyGrRnFpkd
         Ljx+OroIJqIYyIoglUIBIO8l9/4o/r9jyLmNXJQhswnir6gzgokph3I3SwbVhVlQMJeB
         p283tUruuswDgyiA/pgG9txkKBcv4qZQOow8KUL+MlYL3Fn/fC7RNRMH3QQCokpK3J/h
         UxEw+uJzW5OfAEClj+4gZQl9G58cvDBakEexWCkOOxWFrFpQwdvvPFH9NWnjdF4tF4xT
         7sXa5L/5l1hoVK8aqQ8NI2BoKTFhkeMOu43KeUHNCK3MD3+Qnq/y/jDTRhUvtJQImSOq
         LpsQ==
X-Gm-Message-State: APjAAAWeXIL23KCJULHsclChVdnQ25Rm4+CzfloBhBS1w6nfdhmxxg6X
        fZj8conti9IqCHVFuMpbC8kqYBoazpb6vpsvMfKRUA==
X-Google-Smtp-Source: APXvYqz7jaLnW8arwTpP0kHVBtETPT7wrAXZG0RObWqv2gyY67Sy8idWOyzSlgruh6H2DYTZjheygwOwqk29INSjbTA=
X-Received: by 2002:a2e:8ec6:: with SMTP id e6mr363229ljl.192.1567087358119;
 Thu, 29 Aug 2019 07:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190822021740.15554-1-riel@surriel.com> <20190822021740.15554-9-riel@surriel.com>
 <CAKfTPtDxHijR3PCOFfxA-r02rf2hVP4LpB=y-9emHS7znTPxTA@mail.gmail.com> <d703071084dadb477b8248b041d0d1aa730d65cd.camel@surriel.com>
In-Reply-To: <d703071084dadb477b8248b041d0d1aa730d65cd.camel@surriel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 29 Aug 2019 16:02:26 +0200
Message-ID: <CAKfTPtDX+keNfNxf78yMoF3QaXSG_fZHJ_nqCFKYDMYGa84A6Q@mail.gmail.com>
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

On Thu, 29 Aug 2019 at 01:19, Rik van Riel <riel@surriel.com> wrote:
>
> On Wed, 2019-08-28 at 19:32 +0200, Vincent Guittot wrote:
> > On Thu, 22 Aug 2019 at 04:18, Rik van Riel <riel@surriel.com> wrote:
> > > The idea behind __sched_period makes sense, but the results do not
> > > always.
> > >
> > > When a CPU has one high priority task and a large number of low
> > > priority
> > > tasks, __sched_period will return a value larger than
> > > sysctl_sched_latency,
> > > and the one high priority task may end up getting a timeslice all
> > > for itself
> > > that is also much larger than sysctl_sched_latency.
> >
> > note that unless you enable sched_feat(HRTICK), the sched_slice is
> > mainly used to decide how fast we preempt running task at tick but a
> > newly wake up task can preempt it before
> >
> > > The low priority tasks will have their time slices rounded up to
> > > sysctl_sched_min_granularity, resulting in an even larger
> > > scheduling
> > > latency than targeted by __sched_period.
> >
> > Will this not break the fairness between a always running task and a
> > short sleeping one with this changes ?
>
> In what way?
>
> The vruntime for the always running task will continue
> to advance the same way it always has.

Ok so 1st, my brain is probably not yet fully back from vacations as I
have read sysctl_sched_min_granularity instead of sysctl_sched_latency
 and wrongly thought that you were setting
sysctl_sched_min_granularity for all tasks.
That being said, sched_slice is used to prevent other tasks to preempt
the running task before it get a chances to run its ideal time
compared to others and before new tasks modify the ideal sched_slice
of each. By capping this max value, the task can be preempted earlier
than before by newly wake up task and don't get the amount of running
time it could have expect before the situation is changing

>
> > > Simplify the code by simply ripping out __sched_period and always
> > > taking
> > > fractions of sysctl_sched_latency.
> > >
> > > If a high priority task ends up getting a "too small" time slice
> > > compared
> > > to low priority tasks, the vruntime scaling ensures that it will
> > > simply
> > > get scheduled more frequently than low priority tasks.
> >
> > Will you not increase the number of context switch ?
>
> It should actually decrease the number of context
> switches. If a nice +19 task gets a longer time slice
> than it would today, its vruntime will be advanced by

In fact that's already the case today, when a task is scheduled, it
runs a full jiffy even if its sched_slice is smaller than a jiffy
(unless you have enabled sched_feat(HRTICK)).

> more than sysctl_sched_latency, and it will not get
> to run again until another task has caught up with its
> vruntime.
>
> That means the regular (or high) priority task that
> shares the CPU with that nice +19 task might get
> several time slices in a row until the nice +19 task
> gets to run again.
>
> What am I overlooking?

My point is more for task that runs several ticks in a row. Their
sched_slice will be shorter in some cases with your changes so they
can be preempted earlier by other runnable tasks with a lower vruntime
and there will be more context switch

>
> --
> All Rights Reversed.
