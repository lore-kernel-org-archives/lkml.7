Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B39ECA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70CF321734
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tMqTpyML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387497AbfJ2LRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:17:42 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38455 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730435AbfJ2LRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:17:41 -0400
Received: by mail-lj1-f196.google.com with SMTP id q78so14826626lje.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 04:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PQEUwAx1vILI4PrR9n6JJL0hKjguX42y6g+HOz6pp38=;
        b=tMqTpyMLampvMGnbHIns5fyGynaDf9d5c5UmZDX7elDGiqHXkFgANEhhJQWM1P/0VC
         lqhBQtUYE4dYXsx3mZ5V+vNvkx9Uor1elywaY3iXuWDFb6msEPgqZRzSMhw0kJHFRphM
         NuNNxlCLz4IWwhFd0Rqjgzqdr6xwuQdQYLbVTLms8E+QmB43l2Oax9tXlnIRp9TKyF2S
         dSof1l6wnoHb0r7BbzC/jwuBfYbzZPTMKVU9E0gsqk9pXx3azU3Kft4+BhyouAdGVFl0
         zU/OpAoFWpvtV3dzRcFVMUi8mhumHm/RBsm6BTLGV0gR1SkwLA2NgabnupcycFXImR98
         rR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PQEUwAx1vILI4PrR9n6JJL0hKjguX42y6g+HOz6pp38=;
        b=eUifCZRbh9BbHXGjUEe7NIGSr4HXdPnNLXj4UUQrBvFrRElY+h/xBVOtpRNVvNfZf7
         6/L8mSuSbc5jpRkhiXHu3PnWuZSVD03a+lHsWGoZDqEgzWBIIH92ochDZnHGQIfQsV5d
         VVwg554Fb21jQMruogEe0Z1bNvozq+f1vjcRkOemv0up5eGPu2n6+SEmJfcsex46Hpyp
         J3LSWN+V2sdGhn0O6QZxahgEx/my/x837QV0Y7l35U2c7r467Lr5ejtHJM6atNrLwj6n
         5pghKE9Y60byFZXMOLWxrTwdfyBnyxnc6S3Zzq65yXMolPzlRg2gsDkn4qcqo00Sqg5n
         5L2Q==
X-Gm-Message-State: APjAAAU/+b9GTKQW8NMunvQMhs2DzX9s2+mIS+mc4XboA0hmq31UUB5k
        EhjBO5SiJJyh0izKXaKgLZvkKDDKNtzyfZaGLp2+Zg==
X-Google-Smtp-Source: APXvYqzkSnKnbpe8o3EuzdhK2n/whmPiu11PILokukpWwNxRfHo2zoyFyTq6MagS3Vb5HKj4iw7LHArgJPo+Yp5SoiA=
X-Received: by 2002:a05:651c:28a:: with SMTP id b10mr2190355ljo.193.1572347858004;
 Tue, 29 Oct 2019 04:17:38 -0700 (PDT)
MIME-Version: 1.0
References: <20191009104611.15363-1-qais.yousef@arm.com> <CAKfTPtA6Fvc374oTfbHYkviAJbZebHkBg=w2O3f0oZ0m3ujVjA@mail.gmail.com>
 <20191029110224.awoi37pdquachqtd@e107158-lin.cambridge.arm.com>
In-Reply-To: <20191029110224.awoi37pdquachqtd@e107158-lin.cambridge.arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 29 Oct 2019 12:17:25 +0100
Message-ID: <CAKfTPtA=CzkTVwdCJL6ULYB628tWdGAvpD-sHfgSfL59PyYvxA@mail.gmail.com>
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

On Tue, 29 Oct 2019 at 12:02, Qais Yousef <qais.yousef@arm.com> wrote:
>
> On 10/29/19 09:13, Vincent Guittot wrote:
> > On Wed, 9 Oct 2019 at 12:46, Qais Yousef <qais.yousef@arm.com> wrote:
> > >
> > > Capacity Awareness refers to the fact that on heterogeneous systems
> > > (like Arm big.LITTLE), the capacity of the CPUs is not uniform, hence
> > > when placing tasks we need to be aware of this difference of CPU
> > > capacities.
> > >
> > > In such scenarios we want to ensure that the selected CPU has enough
> > > capacity to meet the requirement of the running task. Enough capacity
> > > means here that capacity_orig_of(cpu) >= task.requirement.
> > >
> > > The definition of task.requirement is dependent on the scheduling class.
> > >
> > > For CFS, utilization is used to select a CPU that has >= capacity value
> > > than the cfs_task.util.
> > >
> > >         capacity_orig_of(cpu) >= cfs_task.util
> > >
> > > DL isn't capacity aware at the moment but can make use of the bandwidth
> > > reservation to implement that in a similar manner CFS uses utilization.
> > > The following patchset implements that:
> > >
> > > https://lore.kernel.org/lkml/20190506044836.2914-1-luca.abeni@santannapisa.it/
> > >
> > >         capacity_orig_of(cpu)/SCHED_CAPACITY >= dl_deadline/dl_runtime
> > >
> > > For RT we don't have a per task utilization signal and we lack any
> > > information in general about what performance requirement the RT task
> > > needs. But with the introduction of uclamp, RT tasks can now control
> > > that by setting uclamp_min to guarantee a minimum performance point.
> > >
> > > ATM the uclamp value are only used for frequency selection; but on
> > > heterogeneous systems this is not enough and we need to ensure that the
> > > capacity of the CPU is >= uclamp_min. Which is what implemented here.
> > >
> > >         capacity_orig_of(cpu) >= rt_task.uclamp_min
> > >
> > > Note that by default uclamp.min is 1024, which means that RT tasks will
> > > always be biased towards the big CPUs, which make for a better more
> > > predictable behavior for the default case.
> >
> > hmm... big cores are not always the best choices for rt tasks, they
> > generally took more time to wake up or to switch context because of
> > the pipeline depth and others branch predictions
>
> Can you quantify this into a number? I suspect this latency should be in the

As a general rule, we pinned IRQs on little core because of such
responsiveness  difference. I don't have numbers in mind as the tests
were run at the beg of b.L system.. few years ago
Then, if you look at some idle states definitions in DT, you will see
that exit latency of cluster down state of big core of hikey960 is
2900us vs 1600us for little

> 200-300us range. And the difference between little and big should be much
> smaller than that, no? We can't give guarantees in Linux in that order in
> general and for serious real time users they have to do extra tweaks like
> disabling power management which can introduce latency and hinder determinism.
> Beside enabling PREEMPT_RT.
>
> For generic systems a few ms is the best we can give and we can easily fall out
> of this without any tweaks.
>
> The choice of going to the maximum performance point in the system for RT tasks
> by default goes beyond this patch anyway. I'm just making it consistent here
> since we have different performance levels and RT didn't understand this
> before.
>
> So what I'm doing here is just make things consistent rather than change the
> default.
>
> What do you suggest?

Making big cores the default CPUs for all RT tasks is not a minor
change and IMO locality should stay the default behavior when there is
no uclamp constraint

>
> Thanks
>
> --
> Qais Yousef
