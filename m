Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0753C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7931B20850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552905914;
	bh=YEFXQmWaGzDWQB8YmVBiOEK0XKsQMzmtZogcs9LwHl0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BPifoTuUZr+Ff+XlcrPpdpEDjMNt0x7/rsyUI6pgjWEq21WXQGKe02qoSliaa/j/P
	 MNVGNotdcj5El/mrxsehQ54jgGXFRVEYDWb7SWjGo+YodAySGipWyHWln9lBGe4ovf
	 qrIR968tdiFT8jsGu63XHWaMzo9qxQcNTwAvTysA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfCRKpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:45:12 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37886 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfCRKpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 06:45:12 -0400
Received: by mail-ot1-f66.google.com with SMTP id c16so2571932otn.4;
        Mon, 18 Mar 2019 03:45:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/tOYhGGOxYjYHiooD5z/VAgbJikvYNc3MQ+iPTou0Lg=;
        b=PTJv/cMZYnTUsFHWR3ea2Y+xwCpGwgM9UST7avx1H/zifRmMt+wFSobuTbM0P/sgHH
         jwgnxoycGIlgGsQ/TsFlPWHwMx4kOML27l68C6IcG8F7eA5HPI8aDK+9JFrNhHRKIPFq
         VA9ef6u2YfcLzPmhw43ZCyWG3J02BB4oSj3CPD0Z3D110RBYI/fuSgzN7l2Xtfbu/JQc
         0zNMFhRv1FJkZSPCph18xdEexuQvKqX99/QVJD6+YM1zY4FVBTVE8Y3RHxi9i3ov0Mta
         BPpDlRcViyRHVVzW/Xf5tsGdnKpLhZvVpc/ZtlouPNL4L/RVT8tR54Hp/aPPxSX5QFfd
         MbPQ==
X-Gm-Message-State: APjAAAVLQgU3QCmHVCCBT0tuMRii7Bs46r/4SJj4zlElgouuOpQeW5fm
        dyCh0XDKYUak338ufEYUe0XeNn4M6LlwjqKctjM=
X-Google-Smtp-Source: APXvYqzYX7SdCpLOLWJ8J+wCXEByb0husoFhUjkNHwsD5wte/9OTLGN2u8jI6mMaEe5JDb729JX9bHFKZdVWH3OyYT4=
X-Received: by 2002:a9d:7a58:: with SMTP id z24mr9560657otm.244.1552905910902;
 Mon, 18 Mar 2019 03:45:10 -0700 (PDT)
MIME-Version: 1.0
References: <e2b56be446eeb67f1905d2ac6f8d82dd4389d0c5.1552640968.git.viresh.kumar@linaro.org>
 <20190315122952.GF6058@hirez.programming.kicks-ass.net>
In-Reply-To: <20190315122952.GF6058@hirez.programming.kicks-ass.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 18 Mar 2019 11:45:00 +0100
Message-ID: <CAJZ5v0g=VYSKAHuncceD-8a1AY+isR7-TMX2dbdMzpZgVkRfBg@mail.gmail.com>
Subject: Re: [PATCH V2] cpufreq: Call transition notifier only once for each policy
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        sparclinux@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 1:30 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Mar 15, 2019 at 02:43:07PM +0530, Viresh Kumar wrote:
> > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > index 3fae23834069..cff8779fc0d2 100644
> > --- a/arch/x86/kernel/tsc.c
> > +++ b/arch/x86/kernel/tsc.c
> > @@ -956,28 +956,38 @@ static int time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
> >                               void *data)
> >  {
> >       struct cpufreq_freqs *freq = data;
> > -     unsigned long *lpj;
> > -
> > -     lpj = &boot_cpu_data.loops_per_jiffy;
> > -#ifdef CONFIG_SMP
> > -     if (!(freq->flags & CPUFREQ_CONST_LOOPS))
> > -             lpj = &cpu_data(freq->cpu).loops_per_jiffy;
> > -#endif
> > +     struct cpumask *cpus = freq->policy->cpus;
> > +     bool boot_cpu = !IS_ENABLED(CONFIG_SMP) || freq->flags & CPUFREQ_CONST_LOOPS;
> > +     unsigned long lpj;
> > +     int cpu;
> >
> >       if (!ref_freq) {
> >               ref_freq = freq->old;
> > -             loops_per_jiffy_ref = *lpj;
> >               tsc_khz_ref = tsc_khz;
> > +
> > +             if (boot_cpu)
> > +                     loops_per_jiffy_ref = boot_cpu_data.loops_per_jiffy;
> > +             else
> > +                     loops_per_jiffy_ref = cpu_data(cpumask_first(cpus)).loops_per_jiffy;
> >       }
> > +
> >       if ((val == CPUFREQ_PRECHANGE  && freq->old < freq->new) ||
> >                       (val == CPUFREQ_POSTCHANGE && freq->old > freq->new)) {
> > -             *lpj = cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
> > -
> > +             lpj = cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
> >               tsc_khz = cpufreq_scale(tsc_khz_ref, ref_freq, freq->new);
> > +
> >               if (!(freq->flags & CPUFREQ_CONST_LOOPS))
> >                       mark_tsc_unstable("cpufreq changes");
> >
> > -             set_cyc2ns_scale(tsc_khz, freq->cpu, rdtsc());
> > +             if (boot_cpu) {
> > +                     boot_cpu_data.loops_per_jiffy = lpj;
> > +             } else {
> > +                     for_each_cpu(cpu, cpus)
> > +                             cpu_data(cpu).loops_per_jiffy = lpj;
> > +             }
> > +
> > +             for_each_cpu(cpu, cpus)
> > +                     set_cyc2ns_scale(tsc_khz, cpu, rdtsc());
>
> This code doesn't make sense, the rdtsc() _must_ be called on the CPU in
> question.

Well, strictly speaking the TSC value here comes from the CPU running the code.

The original code has this problem too, though (as Viresh said), so
the patch really doesn't make it worse in that respect. :-)

I'm not going to defend the original code (I ldidn't invent it
anyway), but it clearly assumes that different CPUs cannot run at
different frequencies and that kind of explains what happens in it.

> That's part of the whole problem here, TSC isn't sync'ed when
> it's subject to CPUFREQ.

So what would you recommend us to do here?

Obviously, this won't run on any new hardware.  Frankly, I'm not even
sure what the most recent HW where this hack would make a difference
is (the comment talking about Opterons suggests early 2000s), so this
clearly falls into the "legacy" bucket to me.

Does it make sense to try to preserve it, or can we simply make
cpufreq init fail on the systems where the TSC rate depends on the
frequency?
