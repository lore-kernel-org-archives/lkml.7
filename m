Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E24C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D5820857
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552908014;
	bh=lyVXGPC9zErnTV1YR3dJiSh3Bzds1WG8V6YhtYP5ECM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0lHyOn4z8Z9Zct8NiStY6nZmzVku0L53imIJeHj5unhgfY1Xgg1a+rJAEiiVA6iWT
	 4yCE96bYTgDHtBDbUSb/K/85Lq6MaGZrxc3Qpr0tN49f7aaxxk3o/VL57GKiyYXPVt
	 TttNFBS5+DJLRxozs8XZamIMrDZCr1g0VFI0kLBI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfCRLUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 07:20:13 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33360 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfCRLUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 07:20:12 -0400
Received: by mail-oi1-f196.google.com with SMTP id e22so5550688oiy.0;
        Mon, 18 Mar 2019 04:20:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hyijU7qwwjjH/yhGYvuxId6NK7gc1ZChCp8pKRDl2FI=;
        b=gUbkbg6Xjlgn9lDrcnlIerfgOYaiq+Uyy12ZHthxKOMFEe0ses+KlTaJjmVLFZGZAB
         HbR9jo+8U/89qZRbizvXiz+IN8/0QYU/agW8o9L/CZUdMKc//H0ntq8pzEGyzysKNI6G
         QRjX5MTIywrud7eOpUVWVf4nls3+oOKCWLZ2WSqmf7OO1VxcF1eQeUbtyyOrAfUNzXRL
         zCYK/OJqfq49XE4ei/dpstFzfcUFuddNZidFFIhCkUuPgljP5askhohscNhpbwi5dq1+
         hzoIekP5IseyeLYuXYlVi/tQTTTfVMmXqKblEflLlj2N/jYmZ0o3JEc0TqejdTk3WU0x
         +YMA==
X-Gm-Message-State: APjAAAXDdBYHSkza4V26X/KKwXdKwCoDoua4eq1O12WKb/SILjt8oSlW
        5EaRxxYdmiPC5NpqrsN3ZYS1+vr73HI75oPMhd8=
X-Google-Smtp-Source: APXvYqyYh7N/+m9DhaJeUjqbCHydHu1lq/4p5ldyQ24KY0aZ3nLxt6E7dHPLv2eI4WR4uJt3skDYJpZoIimYR4nO/T0=
X-Received: by 2002:aca:6046:: with SMTP id u67mr9136721oib.84.1552908011576;
 Mon, 18 Mar 2019 04:20:11 -0700 (PDT)
MIME-Version: 1.0
References: <e2b56be446eeb67f1905d2ac6f8d82dd4389d0c5.1552640968.git.viresh.kumar@linaro.org>
 <20190315122952.GF6058@hirez.programming.kicks-ass.net> <20190318023514.67gxypb4w7llcmha@vireshk-i7>
 <20190318105356.GM6058@hirez.programming.kicks-ass.net> <CAJZ5v0h5k72Oer0v6iaqfzNU6fNfoPK+YLsKxi6ZE14P_rWD1Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0h5k72Oer0v6iaqfzNU6fNfoPK+YLsKxi6ZE14P_rWD1Q@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 18 Mar 2019 12:20:00 +0100
Message-ID: <CAJZ5v0guJoSanBRs232aVdHgiBRysdLs+LFhSnKaPbeKSrrtzA@mail.gmail.com>
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

On Mon, Mar 18, 2019 at 12:09 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Mar 18, 2019 at 11:54 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Mar 18, 2019 at 08:05:14AM +0530, Viresh Kumar wrote:
> > > On 15-03-19, 13:29, Peter Zijlstra wrote:
> > > > On Fri, Mar 15, 2019 at 02:43:07PM +0530, Viresh Kumar wrote:
> > > > > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > > > > index 3fae23834069..cff8779fc0d2 100644
> > > > > --- a/arch/x86/kernel/tsc.c
> > > > > +++ b/arch/x86/kernel/tsc.c
> > > > > @@ -956,28 +956,38 @@ static int time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
> > > > >                           void *data)
> > > > >  {
> > > > >   struct cpufreq_freqs *freq = data;
> > > > > - unsigned long *lpj;
> > > > > -
> > > > > - lpj = &boot_cpu_data.loops_per_jiffy;
> > > > > -#ifdef CONFIG_SMP
> > > > > - if (!(freq->flags & CPUFREQ_CONST_LOOPS))
> > > > > -         lpj = &cpu_data(freq->cpu).loops_per_jiffy;
> > > > > -#endif
> > > > > + struct cpumask *cpus = freq->policy->cpus;
> > > > > + bool boot_cpu = !IS_ENABLED(CONFIG_SMP) || freq->flags & CPUFREQ_CONST_LOOPS;
> > > > > + unsigned long lpj;
> > > > > + int cpu;
> > > > >
> > > > >   if (!ref_freq) {
> > > > >           ref_freq = freq->old;
> > > > > -         loops_per_jiffy_ref = *lpj;
> > > > >           tsc_khz_ref = tsc_khz;
> > > > > +
> > > > > +         if (boot_cpu)
> > > > > +                 loops_per_jiffy_ref = boot_cpu_data.loops_per_jiffy;
> > > > > +         else
> > > > > +                 loops_per_jiffy_ref = cpu_data(cpumask_first(cpus)).loops_per_jiffy;
> > > > >   }
> > > > > +
> > > > >   if ((val == CPUFREQ_PRECHANGE  && freq->old < freq->new) ||
> > > > >                   (val == CPUFREQ_POSTCHANGE && freq->old > freq->new)) {
> > > > > -         *lpj = cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
> > > > > -
> > > > > +         lpj = cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
> > > > >           tsc_khz = cpufreq_scale(tsc_khz_ref, ref_freq, freq->new);
> > > > > +
> > > > >           if (!(freq->flags & CPUFREQ_CONST_LOOPS))
> > > > >                   mark_tsc_unstable("cpufreq changes");
> > > > >
> > > > > -         set_cyc2ns_scale(tsc_khz, freq->cpu, rdtsc());
> > > > > +         if (boot_cpu) {
> > > > > +                 boot_cpu_data.loops_per_jiffy = lpj;
> > > > > +         } else {
> > > > > +                 for_each_cpu(cpu, cpus)
> > > > > +                         cpu_data(cpu).loops_per_jiffy = lpj;
> > > > > +         }
> > > > > +
> > > > > +         for_each_cpu(cpu, cpus)
> > > > > +                 set_cyc2ns_scale(tsc_khz, cpu, rdtsc());
> > > >
> > > > This code doesn't make sense, the rdtsc() _must_ be called on the CPU in
> > > > question.
> > >
> > > You mean rdtsc() must be locally on that CPU? The cpufreq core never guaranteed
> > > that and it was left for the notifier to do. This patch doesn't change the
> > > behavior at all, just that it moves the for-loop to the notifier instead of the
> > > cpufreq core.
> >
> > Yuck..
> >
> > Rafael; how does this work in practise? Earlier you said that on x86 the
> > policies typically have a single cpu in them anyway.
>
> Yes.
>
> > Is the freq change also notified from _that_ cpu?
>
> May not be, depending on what CPU runs the work item/thread changing
> the freq.  It generally is not guaranteed to always be the same as the
> target CPU.

Actually, scratch that.

On x86, with one CPU per cpufreq policy, that will always be the target CPU.

> > I don't think I have old enough hardware around anymore to test any of
> > this. This was truly ancient p6 era stuff IIRC.
> >
> > Because in that case, I'm all for not doing the changes to this notifier
> > Viresh is proposing but simply adding something like:
> >
> >
> >         WARN_ON_ONCE(cpumask_weight(cpuc) != 1);
> >         WARN_ON_ONCE(cpumask_first(cpuc) != smp_processor_id());
> >
> > And leave it at that.
>
> That may not work I'm afraid.

So something like that could work.
