Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21ACCC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E531C21841
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556007587;
	bh=mC5YvKlBNAd1rnr7YlnEjwkVNwtweqKiQ5Oh01VZI+s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=I3aWpls9JGfqClaPsJxyCwoUwzvu51ZuDDZODYLmhrBRmKLOySGP52UGgDwy9CWQt
	 C91fF4FbWKSi7a8+dh8luiYEhAhzTFKfYwLSc1T8kFce6ZHXvF8G+JS7+JIcSgxchV
	 Tkx+v5KnVal0usWc+WcO2ZzQ0DhUjedO3JzZ5JZg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfDWITp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 04:19:45 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35458 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfDWITp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 04:19:45 -0400
Received: by mail-ot1-f68.google.com with SMTP id m10so12065070otp.2;
        Tue, 23 Apr 2019 01:19:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=516p+GjAHChMueYIwW6iWAf1BlxelEA1TY1wh3RJfac=;
        b=mHnuCL90glABiO9sHKPavTMb5a7OP8WBQhobAVFxJY3GPAib8zrK2cg+Z8CCbivGhP
         fYM7nvauqG8KymhveloNCOHX5KHobaiHlDC5dMb3kD3ljdu/7etTTnDb4ou+YLSlqFeM
         +clvQq4RIhUxfWinq3z4E//x2h9Vqs4ZpFnJgG7mHlp0mQN5vh2nsoa7LyuLzxIQQPA3
         e9r5v0XkAQwP0HDqxIhLqpw1AbNVTfAN+fMAkBQhkz3LAMRjfdHdoFg6Omq/yQ7AKafn
         FRu9U/UJx3AaIiHS+yKbdjBxIbjczsCOiQIMt+4t1ixlgLkw+Lpw+O44NliBHr+i8AlS
         w2tA==
X-Gm-Message-State: APjAAAViizm+v5N/wNr+CowlvSWxucJ55I53/DIbKQWaE4tnFud+zqfD
        wK1mcDN0UAe0fVBs6PHwQYr8CG2XxJjiBG5Dm7k=
X-Google-Smtp-Source: APXvYqxOhc4NT+Tts6ECSd9M4180Yx3dyXYSWJ6yMtp54wuKJ9LMMtVt2MA+uzXoPYiLZoKekNLpWZuX7vVX629hJtY=
X-Received: by 2002:a9d:648f:: with SMTP id g15mr14105987otl.220.1556007583924;
 Tue, 23 Apr 2019 01:19:43 -0700 (PDT)
MIME-Version: 1.0
References: <38900622.ao2n2t5aPS@kreacher> <20190422081709.i5mv4fbket5ls4xc@vireshk-i7>
In-Reply-To: <20190422081709.i5mv4fbket5ls4xc@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 23 Apr 2019 10:19:29 +0200
Message-ID: <CAJZ5v0iP4TGAdRKJ3WaXTTgg1ZyGWoYLm2cJZdww=BmYWZ2tUQ@mail.gmail.com>
Subject: Re: [PATCH] x86: tsc: Rework time_cpufreq_notifier()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        x86 Maintainers <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 10:17 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 18-04-19, 16:11, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > There are problems with running time_cpufreq_notifier() on SMP
> > systems.
> >
> > First off, the rdtsc() called from there runs on the CPU executing
> > that code and not necessarily on the CPU whose sched_clock() rate is
> > updated which is questionable at best.
> >
> > Second, in the cases when the frequencies of all CPUs in an SMP
> > system are always in sync, it is not sufficient to update just
> > one of them or the set associated with a given cpufreq policy on
> > frequency changes - all CPUs in the system should be updated and
> > that would require more than a simple transition notifier.
> >
> > Note, however, that the underlying issue (the TSC rate depending on
> > the CPU frequency) has not been present in hardware shipping for the
> > last few years and in quite a few relevant cases (acpi-cpufreq in
> > particular) running time_cpufreq_notifier() will cause the TSC to
> > be marked as unstable anyway.
> >
> > For this reason, make time_cpufreq_notifier() simply mark the TSC
> > as unstable and give up when run on SMP and only try to carry out
> > any adjustments otherwise.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  arch/x86/kernel/tsc.c |   29 ++++++++++++++---------------
> >  1 file changed, 14 insertions(+), 15 deletions(-)
> >
> > Index: linux-pm/arch/x86/kernel/tsc.c
> > ===================================================================
> > --- linux-pm.orig/arch/x86/kernel/tsc.c
> > +++ linux-pm/arch/x86/kernel/tsc.c
> > @@ -185,8 +185,7 @@ static void __init cyc2ns_init_boot_cpu(
> >  /*
> >   * Secondary CPUs do not run through tsc_init(), so set up
> >   * all the scale factors for all CPUs, assuming the same
> > - * speed as the bootup CPU. (cpufreq notifiers will fix this
> > - * up if their speed diverges)
> > + * speed as the bootup CPU.
> >   */
> >  static void __init cyc2ns_init_secondary_cpus(void)
> >  {
> > @@ -937,12 +936,12 @@ void tsc_restore_sched_clock_state(void)
> >  }
> >
> >  #ifdef CONFIG_CPU_FREQ
> > -/* Frequency scaling support. Adjust the TSC based timer when the cpu frequency
> > +/*
> > + * Frequency scaling support. Adjust the TSC based timer when the CPU frequency
> >   * changes.
> >   *
> > - * RED-PEN: On SMP we assume all CPUs run with the same frequency.  It's
> > - * not that important because current Opteron setups do not support
> > - * scaling on SMP anyroads.
> > + * NOTE: On SMP the situation is not fixable in general, so simply mark the TSC
> > + * as unstable and give up in those cases.
> >   *
> >   * Should fix up last_tsc too. Currently gettimeofday in the
> >   * first tick after the change will be slightly wrong.
> > @@ -956,22 +955,22 @@ static int time_cpufreq_notifier(struct
> >                               void *data)
> >  {
> >       struct cpufreq_freqs *freq = data;
> > -     unsigned long *lpj;
> >
> > -     lpj = &boot_cpu_data.loops_per_jiffy;
> > -#ifdef CONFIG_SMP
> > -     if (!(freq->flags & CPUFREQ_CONST_LOOPS))
> > -             lpj = &cpu_data(freq->cpu).loops_per_jiffy;
> > -#endif
> > +     if (num_online_cpus() > 1) {
>
> What about checking num_possible_cpus() instead ? So we reliably quit
> everytime even if some CPUs are offlined.

That would work too.

The point here is that the adjustments can work if the "additional"
CPUs never go online.

> And can we place this check before registering the notifier, so it
> never gets called ?

Well, in that case the TSC would need to be marked as unstable
upfront, but that really only would be necessary if cpufreq was
actually used.  If it wasn't used, whatever the reason, marking the
TSC as unstable here would be excessive.

We're talking about old HW, mind you, and I know about systems shipped
around that time frame that didn't support performance scaling at all
and had the TSC (see the Opteron comment removed by this patch, for
instance).

So I'd rather not change that part.
