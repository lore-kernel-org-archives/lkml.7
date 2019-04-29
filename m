Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881A6C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 12:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 499B920673
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 12:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lEtrtAYu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbfD2MZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 08:25:10 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36010 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728005AbfD2MZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 08:25:09 -0400
Received: by mail-lf1-f66.google.com with SMTP id u17so7839567lfi.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 05:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pLitZGF5ife6QL5sDYHdKPMjB6Uz30fjPiq+Pr5oBcY=;
        b=lEtrtAYuXtTAYltm10ZvTaqQSz336/Uhs+JACwIjBLWpGBIswNrXM1nBa+OGbWUnJ/
         p6H129UmXuDAgTHYhE6GnpNQxIIc0HwIZikVnh/hWNJ+y8wsnakxHVGUlM1iz6KIcf7X
         GK6nM5fLufd9e1tyNAAdJkfkBorm8AnzWn53otK7bTSiAWGZyfuMkwLOGvv/FKh8GpZm
         weh8yJP1O/RMTeoliPTusqfYdIsEf8WqGnX4IjVYy05FG9OOck8UjT9uZyefdmQrbE0a
         cHjdObH3sMCCIDLHG8xhxnGIWNAgE71BZQRWs+hJfc7blFG4jLQ8lSDYXxyGlCLhO3wi
         0E2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pLitZGF5ife6QL5sDYHdKPMjB6Uz30fjPiq+Pr5oBcY=;
        b=GgXc5KbKgHU+v6DY+zA9yqOhlbAb8KHGBI6JQyFsx0+YRCb4bYD0ZaKWRqkfE+8FuA
         tqDnv6ip3E7dxDbgaFRWwXgsDfWV/R3ONPtuEx9RqDCSixPX8wtKWf30H8+X56VILIcD
         Hu/CKyLsD2hra5rm0QuTV2lEsKEWT/9BkgVxu1zRfQ1ihB0sCUC8hcYLzcxyU1ex/nr0
         E+jxlWTyEwfg2T8G2tqronRx0eppPRpp7tKfi68d35eMkJPd84MdCY0XItlB4yo33h7l
         Z7FrQLnAF5Z8hkIMcpbMdLHJmp/20De9JMbmig+Q0Mb9VUooMHRhK2eTjzY9r6k09Ozz
         dfxw==
X-Gm-Message-State: APjAAAVhQiHmN9qhw3OHrVbqftDkxwAD1ozT6pzQfu5sPxnHzZEekm0L
        PjLVn4K0G0UaYUVouwMOmeK+Q9wESuGqvygR5imITw==
X-Google-Smtp-Source: APXvYqxmUHSojA+E+02ehwhUF+P7BoJlno5qtIQ0MosbtBG8PhP6HuaAdy36RlIC6cAGMcO/nv/zmBe0prdiuNeTL8U=
X-Received: by 2002:a19:7005:: with SMTP id h5mr6999348lfc.143.1556540706265;
 Mon, 29 Apr 2019 05:25:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190408214539.2705660-1-songliubraving@fb.com>
 <20190410115907.GE19434@e105550-lin.cambridge.arm.com> <A2E9A149-9EAA-478D-A096-1D4D4BA442B3@fb.com>
 <CAKfTPtAFB3gSZYJN1BcjU_XoY=Pfu2xtea+2MEw7FkVc3mwTSA@mail.gmail.com>
 <E97E73F4-CE8C-4CD7-B6B6-5F63A4E881B1@fb.com> <F0A127DD-F9B6-4FBE-B9AD-8E8B00A7D676@fb.com>
In-Reply-To: <F0A127DD-F9B6-4FBE-B9AD-8E8B00A7D676@fb.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 29 Apr 2019 14:24:55 +0200
Message-ID: <CAKfTPtA_ouYCes9LnYn0quAKm273mi3vP-++GTBtYcQn07xc6Q@mail.gmail.com>
Subject: Re: [PATCH 0/7] introduce cpu.headroom knob to cpu controller
To:     Song Liu <songliubraving@fb.com>
Cc:     Morten Rasmussen <morten.rasmussen@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Kernel Team <Kernel-team@fb.com>,
        viresh kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Song,

On Sun, 28 Apr 2019 at 21:47, Song Liu <songliubraving@fb.com> wrote:
>
> Hi Morten and Vincent,
>
> > On Apr 22, 2019, at 6:22 PM, Song Liu <songliubraving@fb.com> wrote:
> >
> > Hi Vincent,
> >
> >> On Apr 17, 2019, at 5:56 AM, Vincent Guittot <vincent.guittot@linaro.org> wrote:
> >>
> >> On Wed, 10 Apr 2019 at 21:43, Song Liu <songliubraving@fb.com> wrote:
> >>>
> >>> Hi Morten,
> >>>
> >>>> On Apr 10, 2019, at 4:59 AM, Morten Rasmussen <morten.rasmussen@arm.com> wrote:
> >>>>
> >>
> >>>>
> >>>> The bit that isn't clear to me, is _why_ adding idle cycles helps your
> >>>> workload. I'm not convinced that adding headroom gives any latency
> >>>> improvements beyond watering down the impact of your side jobs. AFAIK,
> >>>
> >>> We think the latency improvements actually come from watering down the
> >>> impact of side jobs. It is not just statistically improving average
> >>> latency numbers, but also reduces resource contention caused by the side
> >>> workload. I don't know whether it is from reducing contention of ALUs,
> >>> memory bandwidth, CPU caches, or something else, but we saw reduced
> >>> latencies when headroom is used.
> >>>
> >>>> the throttling mechanism effectively removes the throttled tasks from
> >>>> the schedule according to a specific duty cycle. When the side job is
> >>>> not throttled the main workload is experiencing the same latency issues
> >>>> as before, but by dynamically tuning the side job throttling you can
> >>>> achieve a better average latency. Am I missing something?
> >>>>
> >>>> Have you looked at your distribution of main job latency and tried to
> >>>> compare with when throttling is active/not active?
> >>>
> >>> cfs_bandwidth adjusts allowed runtime for each task_group each period
> >>> (configurable, 100ms by default). cpu.headroom logic applies gentle
> >>> throttling, so that the side workload gets some runtime in every period.
> >>> Therefore, if we look at time window equal to or bigger than 100ms, we
> >>> don't really see "throttling active time" vs. "throttling inactive time".
> >>>
> >>>>
> >>>> I'm wondering if the headroom solution is really the right solution for
> >>>> your use-case or if what you are really after is something which is
> >>>> lower priority than just setting the weight to 1. Something that
> >>>
> >>> The experiments show that, cpu.weight does proper work for priority: the
> >>> main workload gets priority to use the CPU; while the side workload only
> >>> fill the idle CPU. However, this is not sufficient, as the side workload
> >>> creates big enough contention to impact the main workload.
> >>>
> >>>> (nearly) always gets pre-empted by your main job (SCHED_BATCH and
> >>>> SCHED_IDLE might not be enough). If your main job consist
> >>>> of lots of relatively short wake-ups things like the min_granularity
> >>>> could have significant latency impact.
> >>>
> >>> cpu.headroom gives benefits in addition to optimizations in pre-empt
> >>> side. By maintaining some idle time, fewer pre-empt actions are
> >>> necessary, thus the main workload will get better latency.
> >>
> >> I agree with Morten's proposal, SCHED_IDLE should help your latency
> >> problem because side job will be directly preempted unlike normal cfs
> >> task even lowest priority.
> >> In addition to min_granularity, sched_period also has an impact on the
> >> time that a task has to wait before preempting the running task. Also,
> >> some sched_feature like GENTLE_FAIR_SLEEPERS can also impact the
> >> latency of a task.
> >>
> >> It would be nice to know if the latency problem comes from contention
> >> on cache resources or if it's mainly because you main load waits
> >> before running on a CPU
> >>
> >> Regards,
> >> Vincent
> >
> > Thanks for these suggestions. Here are some more tests to show the impact
> > of scheduler knobs and cpu.headroom.
> >
> > side-load | cpu.headroom | side/cpu.weight | min_gran | cpu-idle | main/latency
> > --------------------------------------------------------------------------------
> >  none    |      0       |     n/a         |    1 ms  |  45.20%  |   1.00
> > ffmpeg   |      0       |      1          |   10 ms  |   3.38%  |   1.46
> > ffmpeg   |      0       |   SCHED_IDLE    |    1 ms  |   5.69%  |   1.42
> > ffmpeg   |    20%       |   SCHED_IDLE    |    1 ms  |  19.00%  |   1.13
> > ffmpeg   |    30%       |   SCHED_IDLE    |    1 ms  |  27.60%  |   1.08
> >
> > In all these cases, the main workload is loaded with same level of
> > traffic (request per second). Main workload latency numbers are normalized
> > based on the baseline (first row).
> >
> > For the baseline, the main workload runs without any side workload, the
> > system has about 45.20% idle CPU.
> >
> > The next two rows compare the impact of scheduling knobs cpu.weight and
> > sched_min_granularity. With cpu.weight of 1 and min_granularity of 10ms,
> > we see a latency of 1.46; with SCHED_IDLE and min_granularity of 1ms, we
> > see a latency of 1.42. So SCHED_IDLE and min_granularity help protecting
> > the main workload. However, it is not sufficient, as the latency overhead
> > is high (>40%).
> >
> > The last two rows show the benefit of cpu.headroom. With 20% headroom,
> > the latency is 1.13; while with 30% headroom, the latency is 1.08.
> >
> > We can also see a clear correlation between latency and global idle CPU:
> > more idle CPU yields better lower latency.
> >
> > Over all, these results show that cpu.headroom provides effective
> > mechanism to control the latency impact of side workloads. Other knobs
> > could also help the latency, but they are not as effective and flexible
> > as cpu.headroom.
> >
> > Does this analysis address your concern?

So, you results show that sched_idle class doesn't provide the
intended behavior because it still delay the scheduling of sched_other
tasks. In fact, the wakeup path of the scheduler doesn't make any
difference between a cpu running a sched_other and a cpu running a
sched_idle when looking for the idlest cpu and it can create some
contentions between sched_other tasks whereas a cpu runs sched_idle
task.
Viresh (cced to this email) is working on improving such behavior at
wake up and has sent an patch related to the subject:
https://lkml.org/lkml/2019/4/25/251
I'm curious if this would improve the results.

Regards,
Vincent

> >
> > Thanks,
> > Song
> >
>
> Could you please share your comments and suggestions on this work? Did
> the results address your questions/concerns?
>
> Thanks again,
> Song
>
> >>
> >>>
> >>> Thanks,
> >>> Song
> >>>
> >>>>
> >>>> Morten
>
