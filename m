Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201A4CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6DE32087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uqxz0laE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387724AbfJ2MU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 08:20:58 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42527 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729058AbfJ2MU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 08:20:58 -0400
Received: by mail-lf1-f66.google.com with SMTP id z12so10352904lfj.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 05:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jc6xJ5tRiw/D4wSaGm8R7NZms7zX9RMGEWc/1FbPTnY=;
        b=uqxz0laEIEDbtWP1AKUuSo5rMhBMlEekN5iz8xThc3WmlJ2R5OUfN/GSyWh4rdxZVk
         Q3e7O6gKZM6z4iX0Wzket1dqZvBrGzXSJbUd8X2DamJsXKJKsBnS8vr0QlZ2srtJ3xew
         vLIR2+bSj2KklT8E9umyW1H3ZJFlukNooJIu/YDMBS14R/snOJLwf6lSkFgiR6XLo5ro
         kCVuohlSl8sOjb2Vqg0QTQr9PjZLjmFRU23TnP+QSNCcaEVHMYUZqUi+z+30tp6969o1
         ZfS5s9be+baJDzNEHtxw3igG7m3L4yvE2Jwvyn7b/v60YaV/6bpbgypuJlvV/Ehya/qE
         Z82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jc6xJ5tRiw/D4wSaGm8R7NZms7zX9RMGEWc/1FbPTnY=;
        b=jKO7j119ByY+63GXhHZH9yjH3fDFNBqRSU/YYF8aqEA8zXYjNlnR0ZWD8jRr/akFG/
         8hFA+d4JAeU+AEsp10HGLO3pUuXnkH+mZJIOTXC2qbx6j7hcX+xWRn8ZLxxoo8en2K91
         iZsRyol27J5g/+bxQID0d+/CvHSC7o6KTeAe7uyrhGaCfBTUSXvr8ef0RCu11LGXTSo6
         G04SXGc1lRx703uc/ubd7FMHDowpUdMjvQoZuD0Id18PyFxo6Vm/nXxW4Ch5A2YMBEEp
         50G/Olgzwac25bgHsiQvZtRcqqiIZLpmi6vpYtuAGixN5pYwjxWRDzQnUp1lyzLOUysh
         pViQ==
X-Gm-Message-State: APjAAAUmVmZ5gPY9HEZTqznCzekXjkLv9gjfijVgvrYT7xbxHWD9Fdvp
        D6tLBPQayaAginXLLSt4/vvKBWL9pBa51VDkTYLieg==
X-Google-Smtp-Source: APXvYqxFJvXWzsBvt1rHMPoCdli4bnYTYCCSRtpEtMaWKnuFsBzGcSDYvCOR8To5m9t0O9wXL1ohtZ4kDsuOyqr1DLY=
X-Received: by 2002:a19:ca13:: with SMTP id a19mr2225124lfg.133.1572351655457;
 Tue, 29 Oct 2019 05:20:55 -0700 (PDT)
MIME-Version: 1.0
References: <20191009104611.15363-1-qais.yousef@arm.com> <CAKfTPtA6Fvc374oTfbHYkviAJbZebHkBg=w2O3f0oZ0m3ujVjA@mail.gmail.com>
 <20191029110224.awoi37pdquachqtd@e107158-lin.cambridge.arm.com>
 <CAKfTPtA=CzkTVwdCJL6ULYB628tWdGAvpD-sHfgSfL59PyYvxA@mail.gmail.com> <20191029114824.2kb4fygxxx72r3in@e107158-lin.cambridge.arm.com>
In-Reply-To: <20191029114824.2kb4fygxxx72r3in@e107158-lin.cambridge.arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 29 Oct 2019 13:20:43 +0100
Message-ID: <CAKfTPtD7e-dXhZ3mG36igArt=0f-mNc52vaJ1bb-jv5zB9bkgg@mail.gmail.com>
Subject: Re: [PATCH v2] sched: rt: Make RT capacity aware
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2019 at 12:48, Qais Yousef <qais.yousef@arm.com> wrote:
>
> On 10/29/19 12:17, Vincent Guittot wrote:
> > On Tue, 29 Oct 2019 at 12:02, Qais Yousef <qais.yousef@arm.com> wrote:
> > >
> > > On 10/29/19 09:13, Vincent Guittot wrote:
> > > > On Wed, 9 Oct 2019 at 12:46, Qais Yousef <qais.yousef@arm.com> wrote:
> > > > >
> > > > > Capacity Awareness refers to the fact that on heterogeneous systems
> > > > > (like Arm big.LITTLE), the capacity of the CPUs is not uniform, hence
> > > > > when placing tasks we need to be aware of this difference of CPU
> > > > > capacities.
> > > > >
> > > > > In such scenarios we want to ensure that the selected CPU has enough
> > > > > capacity to meet the requirement of the running task. Enough capacity
> > > > > means here that capacity_orig_of(cpu) >= task.requirement.
> > > > >
> > > > > The definition of task.requirement is dependent on the scheduling class.
> > > > >
> > > > > For CFS, utilization is used to select a CPU that has >= capacity value
> > > > > than the cfs_task.util.
> > > > >
> > > > >         capacity_orig_of(cpu) >= cfs_task.util
> > > > >
> > > > > DL isn't capacity aware at the moment but can make use of the bandwidth
> > > > > reservation to implement that in a similar manner CFS uses utilization.
> > > > > The following patchset implements that:
> > > > >
> > > > > https://lore.kernel.org/lkml/20190506044836.2914-1-luca.abeni@santannapisa.it/
> > > > >
> > > > >         capacity_orig_of(cpu)/SCHED_CAPACITY >= dl_deadline/dl_runtime
> > > > >
> > > > > For RT we don't have a per task utilization signal and we lack any
> > > > > information in general about what performance requirement the RT task
> > > > > needs. But with the introduction of uclamp, RT tasks can now control
> > > > > that by setting uclamp_min to guarantee a minimum performance point.
> > > > >
> > > > > ATM the uclamp value are only used for frequency selection; but on
> > > > > heterogeneous systems this is not enough and we need to ensure that the
> > > > > capacity of the CPU is >= uclamp_min. Which is what implemented here.
> > > > >
> > > > >         capacity_orig_of(cpu) >= rt_task.uclamp_min
> > > > >
> > > > > Note that by default uclamp.min is 1024, which means that RT tasks will
> > > > > always be biased towards the big CPUs, which make for a better more
> > > > > predictable behavior for the default case.
> > > >
> > > > hmm... big cores are not always the best choices for rt tasks, they
> > > > generally took more time to wake up or to switch context because of
> > > > the pipeline depth and others branch predictions
> > >
> > > Can you quantify this into a number? I suspect this latency should be in the
> >
> > As a general rule, we pinned IRQs on little core because of such
> > responsiveness  difference. I don't have numbers in mind as the tests
> > were run at the beg of b.L system.. few years ago
> > Then, if you look at some idle states definitions in DT, you will see
> > that exit latency of cluster down state of big core of hikey960 is
> > 2900us vs 1600us for little
>
> I don't think hikey960 is a good system to use as a reference. SD845 shows more
> sensible numbers

It is not worse than another

>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/qcom/sdm845.dtsi?h=v5.4-rc5#n407
>
> >
> > > 200-300us range. And the difference between little and big should be much
> > > smaller than that, no? We can't give guarantees in Linux in that order in
> > > general and for serious real time users they have to do extra tweaks like
> > > disabling power management which can introduce latency and hinder determinism.
> > > Beside enabling PREEMPT_RT.
> > >
> > > For generic systems a few ms is the best we can give and we can easily fall out
> > > of this without any tweaks.
> > >
> > > The choice of going to the maximum performance point in the system for RT tasks
> > > by default goes beyond this patch anyway. I'm just making it consistent here
> > > since we have different performance levels and RT didn't understand this
> > > before.
> > >
> > > So what I'm doing here is just make things consistent rather than change the
> > > default.
> > >
> > > What do you suggest?
> >
> > Making big cores the default CPUs for all RT tasks is not a minor
> > change and IMO locality should stay the default behavior when there is
> > no uclamp constraint
>
> How this is affecting locality? The task will always go to the big core, so it
> should be local.

local with the waker
You will force rt task to run on big cluster although waker, data and
interrupts can be on little one.
So making big core as default is far from always being the best choice

>
> And before introducing uclamp the default was going to the maximum frequency
> anyway - which is the highest performance point. So what this does is basically
> make sure that if we asked for a 1024 capacity, we get that.
>
> Beside the decision is taken by the setup of the system wide uclamp.min. We
> can change this to be something smaller but I don't think we can come up with
> a better value by default. Admin should tune this to something smaller if the
> performance of their little cores is good for their needs.
>
> What this patch says if I want my uclamp.min of my RT task to be 1024, then we
> give better guarantees it'll get that 1024 performance it asked for. And the
> default of 1024 is consistent with what Linux has always done for RT out of the
> box.
>
> --
> Qais Yousef
