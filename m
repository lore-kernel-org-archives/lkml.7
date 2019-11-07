Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FD0C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CCB2214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sx+eF8Wi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387847AbfKGKs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 05:48:59 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39709 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbfKGKs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 05:48:58 -0500
Received: by mail-lj1-f193.google.com with SMTP id p18so1720975ljc.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 02:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IT22kOGDAtljK81pVJrF6m7J52zc/v0AXE8pR5gi9WM=;
        b=sx+eF8WiH7x1S3cbNbtNKMOj/0P/3Tatbj+bf4L6zOJVk+cxbFO5R5F9wZvOGzxXrl
         bfr94Y6zouFd93YwqnXNLC7vZS3U3SsHZK6GLKu2W6NpG8XHkNsbsDmNGp9ZKVwo7iwA
         Ju0mIV5mxdU9aKbKu1d6xeacfZRApz6YdEHJmjSjxZD4csTnbM3Edrd4CBpDzkmK95Xx
         JJEgPClqSJsiys0ze2fYXeuyhiRUr0yKGv7xGLupCnZKi14IJ5JU4ZmL1s9lqDSWez9D
         LDreA+6oGZe35VA8x2VsIkAaHs3YBmsP5JdcBcndNhxlZvPySpq6rX5sv5ZyqSysoeH9
         W0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IT22kOGDAtljK81pVJrF6m7J52zc/v0AXE8pR5gi9WM=;
        b=PCZLpYVb+lUB+mSv20Zz+YqMcipWmEsawD4q4egJV1oOur+p2Xl72pLhdIG4HRU8Om
         HdkxPHTgmMZdYzYNUQahSBMnh+tDkVlE2TGSUr0wXs9c++Ol8CN+r+XyXfNbVZjJpwK9
         PyJ4uLVz8duKWUSpRxeS74XxilIUxiGzRM4FTf9nm73S6bFErsr9B6uMz7s1joBBY/iO
         /2TPJEbY6hQYVuNacUxinWm76gHilvGX/pYou9gZ8pjtVStl77VGrYMEzfekYkpsFOO3
         9IOitJbhu2h+BC00nGBcB7+WyIYBfm7AKYCFmEnW11/Ubk1MGQgR9U0ErbrXx5w9caaz
         TkjA==
X-Gm-Message-State: APjAAAVw+lNry1kvZHx2mEOulJfvU+jze+jj/pwCMp+gQHmo1BDflIJQ
        ufZcN7ALZTde45Z5U5dUufYiRJKT4ARvkJwggIGQkw==
X-Google-Smtp-Source: APXvYqyOPL7YXqG7JWxF9jabb9/ZexZIhJi783Or1BlVDSHpbeYxjCCH4uU5z7vl6lLEy9GxjJVE4vUDr3KOIvQtfpc=
X-Received: by 2002:a2e:b0fa:: with SMTP id h26mr1826318ljl.206.1573123736378;
 Thu, 07 Nov 2019 02:48:56 -0800 (PST)
MIME-Version: 1.0
References: <1572979786-20361-1-git-send-email-thara.gopinath@linaro.org>
 <1572979786-20361-3-git-send-email-thara.gopinath@linaro.org>
 <20191105202037.GA17494@e108754-lin> <5DC1E348.2090104@linaro.org>
 <20191105211446.GA25349@e108754-lin> <5DC1E9BC.1010001@linaro.org>
 <20191105215233.GA6450@e108754-lin> <436ad772-c727-127e-1469-d99549db03fc@arm.com>
 <5DC3088B.8070401@linaro.org> <943a8368-1f19-d981-7583-0db4e32895af@arm.com>
In-Reply-To: <943a8368-1f19-d981-7583-0db4e32895af@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 7 Nov 2019 11:48:45 +0100
Message-ID: <CAKfTPtBkDzYv5cFgCNjOHN53KBQZJBAJ77ft-CARo=g=GuZ8Sg@mail.gmail.com>
Subject: Re: [Patch v5 2/6] sched/fair: Add infrastructure to store and update
 instantaneous thermal pressure
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Quentin Perret <qperret@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Nov 2019 at 10:32, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 06/11/2019 18:53, Thara Gopinath wrote:
> > On 11/06/2019 07:50 AM, Dietmar Eggemann wrote:
> >> On 05/11/2019 22:53, Ionela Voinescu wrote:
> >>> On Tuesday 05 Nov 2019 at 16:29:32 (-0500), Thara Gopinath wrote:
> >>>> On 11/05/2019 04:15 PM, Ionela Voinescu wrote:
> >>>>> On Tuesday 05 Nov 2019 at 16:02:00 (-0500), Thara Gopinath wrote:
> >>>>>> On 11/05/2019 03:21 PM, Ionela Voinescu wrote:
> >>>>>>> Hi Thara,
> >>>>>>>
> >>>>>>> On Tuesday 05 Nov 2019 at 13:49:42 (-0500), Thara Gopinath wrote:
> >>>>>>> [...]
> >>>>>>>> +static void trigger_thermal_pressure_average(struct rq *rq)
> >>>>>>>> +{
> >>>>>>>> +#ifdef CONFIG_SMP
> >>>>>>>> +      update_thermal_load_avg(rq_clock_task(rq), rq,
> >>>>>>>> +                              per_cpu(thermal_pressure, cpu_of(rq)));
> >>>>>>>> +#endif
> >>>>>>>> +}
> >>>>>>>
> >>>>>>> Why did you decide to keep trigger_thermal_pressure_average and not
> >>>>>>> call update_thermal_load_avg directly?
> >>>>>>>
> >>>>>>> For !CONFIG_SMP you already have an update_thermal_load_avg function
> >>>>>>> that does nothing, in kernel/sched/pelt.h, so you don't need that
> >>>>>>> ifdef.
> >>>>>> Hi,
> >>>>>>
> >>>>>> Yes you are right. But later with the shift option added, I shift
> >>>>>> rq_clock_task(rq) by the shift. I thought it is better to contain it in
> >>>>>> a function that replicate it in three different places. I can remove the
> >>>>>> CONFIG_SMP in the next version.
> >>>>>
> >>>>> You could still keep that in one place if you shift the now argument of
> >>>>> ___update_load_sum instead.
> >>>>
> >>>> No. I cannot do this. The authors of the pelt framework  prefers not to
> >>>> include a shift parameter there. I had discussed this with Vincent earlier.
> >>>>
> >>>
> >>> Right! I missed Vincent's last comment on this in v4.
> >>>
> >>> I would argue that it's more of a PELT parameter than a CFS parameter
> >>> :), where it's currently being used. I would also argue that's more of a
> >>> PELT parameter than a thermal parameter. It controls the PELT time
> >>> progression for the thermal signal, but it seems more to configure the
> >>> PELT algorithm, rather than directly characterize thermals.
> >>>
> >>> In any case, it only seemed to me that adding a wrapper function for
> >>> this purpose only was not worth doing.
> >>
> >> Coming back to the v4 discussion
> >> https://lore.kernel.org/r/379d23e5-79a5-9d90-0fb6-125d9be85e99@arm.com
> >>
> >> There is no API between pelt.c and other parts of the scheduler/kernel
> >> so why should we keep an unnecessary parameter and wrapper functions?
> >>
> >> There is also no abstraction, update_thermal_load_avg() in pelt.c even
> >> carries '_thermal_' in its name.
> >>
> >> So why not define this shift value '[sched_|pelt_]thermal_decay_shift'
> >> there as well? It belongs to update_thermal_load_avg().
> >>
> >> All call sites of update_thermal_load_avg() use 'rq_clock_task(rq) >>
> >> sched_thermal_decay_shift' so I don't see the need to pass it in.
> >>
> >> IMHO, preparing for eventual code changes (e.g. parsing different now
> >> values) is not a good practice in the kernel. Keeping the code small and
> >> tidy is.
> >
> > I think we are going in circles on this one. I acknowledge you have an
> > issue. That being said, I also understand the need to keep the pelt
> > framework code tight. Also Ionela pointed out that there could be a need
> > for a faster decay in which case it could mean a left shift leading to
> > further complications if defined in pelt.c (I am not saying that I will
> > implement a faster decay in this patch set but it is more of a future
> > extension if needed!)
>
> The issue still exists so why not discussing it here?
>
> Placing thermal related time shift operations in a
> update_*thermal*_load_avg() PELT function look perfectly fine to me.

As already said, having thermal related clock shift operation in
update_thermal_load_avg and pelt.c is a nack for me

>
> > I can make trigger_thermal_pressure_average inline if that will
> > alleviate some of the concerns.

In fact, trigger_thermal_pressure_average is only there because of
shifting the clock which is introduced only in patch 6.
So remove trigger_thermal_pressure_average from this patch and call directly

+       update_thermal_load_avg(rq_clock_task(rq), rq,
+                               per_cpu(thermal_pressure, cpu_of(rq)));

in patch3

>
> That's not the issue here. The issue is the extra shim layer which is
> unnecessary in the current implementation.
>
> update_blocked_averages()
> {
>     ...
>     update_rt_rq_load_avg()
>     update_dl_rq_load_avg()
>     update_irq_load_avg()
>     trigger_thermal_pressure_average() <--- ?
>     ...
> }
>
> Wouldn't a direct call to update_thermal_load_avg() here make things so
> much more clear? And I'm not talking about today and about people
> involved in this review.
>
> > I would also urge you to reconsider the merits of arguing this point
> > back and forth.
>
> I just did.
>
> [...]
