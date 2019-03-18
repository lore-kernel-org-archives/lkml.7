Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A5EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D902084F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552907361;
	bh=O4eddPFSsuPYV16k56jD73MPm+GLhqSJoHPrJ6Kf2NQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=DQrB6xXf5sCXfeEdToz5HLSsPFe3eCe8apV/B2G/FYmb4/4pmxIUqsB8Lk6NQrvRW
	 qxZlAwgugylkx5ilJ+WfGM/eZYEHrqS4PL9kw4GMDolf0m2HpekdnwE5tTsjFpvBPf
	 5yvDGw5FxVTJVOFioIi1mgO+7OJ/u8DfbuEeuqS4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfCRLJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 07:09:20 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41290 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfCRLJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 07:09:19 -0400
Received: by mail-ot1-f65.google.com with SMTP id t7so14004716otk.8;
        Mon, 18 Mar 2019 04:09:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qRH2Rvk2U18hLgWBdLBa0Fcr0HlfRCY0laF/qDg9QIQ=;
        b=QG79kBCiA8kbuYPF/96QQHzO8DliHzhbO1pQUsXG8cGKsH9MOgTBWNRubNaQf3xWSx
         EAG3/dgFBg6A67R+rmSrQmCDx8xvy/bpRjNxqMGRJnw2p3FuIellUgVA+ed2Ibp5DJ1s
         4iObE0sLasE7YXfFkTrusmwIXG0h1wJHBHQ/DotePGJWT0csjTrUj/35fcPIklto+MBw
         bw0rfZusid//98fcmlR1XGFVpaeZ0IvHFHG1FO6W6zx/HKiEP3HQ/g1yDSypwc9cqp8c
         mASHO3xguqyhesuwG621Wy2XOvGHUxDnsqAcydzsrrv0iI3bWA1x1xsC0rrroQIzbmnz
         Xl3A==
X-Gm-Message-State: APjAAAW3EUFvddsEPMXASqrDTUPfyrqGpXdA5IP1aLzluwtRc056u+oV
        1h7CiAla7BQCs3JEiLQq00AKUok42PDA/w9smww=
X-Google-Smtp-Source: APXvYqwEqMC1kv+/UY//omIf65qdUIVsIg1jdboi//WIHKIFLGVpkGylX57DrjgFCt0WY6P+oBe94NhW7P/OQzvV580=
X-Received: by 2002:a9d:6498:: with SMTP id g24mr10653457otl.343.1552907358650;
 Mon, 18 Mar 2019 04:09:18 -0700 (PDT)
MIME-Version: 1.0
References: <e2b56be446eeb67f1905d2ac6f8d82dd4389d0c5.1552640968.git.viresh.kumar@linaro.org>
 <20190315122952.GF6058@hirez.programming.kicks-ass.net> <20190318023514.67gxypb4w7llcmha@vireshk-i7>
 <20190318105356.GM6058@hirez.programming.kicks-ass.net>
In-Reply-To: <20190318105356.GM6058@hirez.programming.kicks-ass.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 18 Mar 2019 12:09:07 +0100
Message-ID: <CAJZ5v0h5k72Oer0v6iaqfzNU6fNfoPK+YLsKxi6ZE14P_rWD1Q@mail.gmail.com>
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

On Mon, Mar 18, 2019 at 11:54 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Mar 18, 2019 at 08:05:14AM +0530, Viresh Kumar wrote:
> > On 15-03-19, 13:29, Peter Zijlstra wrote:
> > > On Fri, Mar 15, 2019 at 02:43:07PM +0530, Viresh Kumar wrote:
> > > > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > > > index 3fae23834069..cff8779fc0d2 100644
> > > > --- a/arch/x86/kernel/tsc.c
> > > > +++ b/arch/x86/kernel/tsc.c
> > > > @@ -956,28 +956,38 @@ static int time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
> > > >                           void *data)
> > > >  {
> > > >   struct cpufreq_freqs *freq = data;
> > > > - unsigned long *lpj;
> > > > -
> > > > - lpj = &boot_cpu_data.loops_per_jiffy;
> > > > -#ifdef CONFIG_SMP
> > > > - if (!(freq->flags & CPUFREQ_CONST_LOOPS))
> > > > -         lpj = &cpu_data(freq->cpu).loops_per_jiffy;
> > > > -#endif
> > > > + struct cpumask *cpus = freq->policy->cpus;
> > > > + bool boot_cpu = !IS_ENABLED(CONFIG_SMP) || freq->flags & CPUFREQ_CONST_LOOPS;
> > > > + unsigned long lpj;
> > > > + int cpu;
> > > >
> > > >   if (!ref_freq) {
> > > >           ref_freq = freq->old;
> > > > -         loops_per_jiffy_ref = *lpj;
> > > >           tsc_khz_ref = tsc_khz;
> > > > +
> > > > +         if (boot_cpu)
> > > > +                 loops_per_jiffy_ref = boot_cpu_data.loops_per_jiffy;
> > > > +         else
> > > > +                 loops_per_jiffy_ref = cpu_data(cpumask_first(cpus)).loops_per_jiffy;
> > > >   }
> > > > +
> > > >   if ((val == CPUFREQ_PRECHANGE  && freq->old < freq->new) ||
> > > >                   (val == CPUFREQ_POSTCHANGE && freq->old > freq->new)) {
> > > > -         *lpj = cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
> > > > -
> > > > +         lpj = cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
> > > >           tsc_khz = cpufreq_scale(tsc_khz_ref, ref_freq, freq->new);
> > > > +
> > > >           if (!(freq->flags & CPUFREQ_CONST_LOOPS))
> > > >                   mark_tsc_unstable("cpufreq changes");
> > > >
> > > > -         set_cyc2ns_scale(tsc_khz, freq->cpu, rdtsc());
> > > > +         if (boot_cpu) {
> > > > +                 boot_cpu_data.loops_per_jiffy = lpj;
> > > > +         } else {
> > > > +                 for_each_cpu(cpu, cpus)
> > > > +                         cpu_data(cpu).loops_per_jiffy = lpj;
> > > > +         }
> > > > +
> > > > +         for_each_cpu(cpu, cpus)
> > > > +                 set_cyc2ns_scale(tsc_khz, cpu, rdtsc());
> > >
> > > This code doesn't make sense, the rdtsc() _must_ be called on the CPU in
> > > question.
> >
> > You mean rdtsc() must be locally on that CPU? The cpufreq core never guaranteed
> > that and it was left for the notifier to do. This patch doesn't change the
> > behavior at all, just that it moves the for-loop to the notifier instead of the
> > cpufreq core.
>
> Yuck..
>
> Rafael; how does this work in practise? Earlier you said that on x86 the
> policies typically have a single cpu in them anyway.

Yes.

> Is the freq change also notified from _that_ cpu?

May not be, depending on what CPU runs the work item/thread changing
the freq.  It generally is not guaranteed to always be the same as the
target CPU.

> I don't think I have old enough hardware around anymore to test any of
> this. This was truly ancient p6 era stuff IIRC.
>
> Because in that case, I'm all for not doing the changes to this notifier
> Viresh is proposing but simply adding something like:
>
>
>         WARN_ON_ONCE(cpumask_weight(cpuc) != 1);
>         WARN_ON_ONCE(cpumask_first(cpuc) != smp_processor_id());
>
> And leave it at that.

That may not work I'm afraid.
