Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EDEC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2E4320685
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HPqKNjBS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfDWImI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 04:42:08 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41143 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfDWImH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 04:42:07 -0400
Received: by mail-pf1-f196.google.com with SMTP id 188so7111674pfd.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 01:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8w9VNlyZqpAKTkIdsm4PiiifY3KqFI2bz26ZPb3A428=;
        b=HPqKNjBSOWKviv37kjcig2xc7QvMKOAndeZKti0oUD7ZLzLGWYEUNX7s7sxevbCisc
         R7odbU0f8GhnyAar/OimMuj2GnUeRg73KffetAEg3X30b7Mua1h2L6WKjL3NMoEt1PMC
         u3Ef0Y23a4fEHroxHekcxC7zGATIDjdcpL11+oCeRnJpdpPqkTlgQVEtV/gazar4zhrx
         EOK0uQpfiy5VG/oMrcuPZlBG3FnVzwxSRa6Z9wRl7Y24y+g9qMOPTwFjBjw2OaM3q0i8
         lX29yFOClVAUDhMb//C4WMbOWeS2D9B863uLsLaNZPi9zvV0o8GzOwskZJv+PhrbaJpH
         9vrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8w9VNlyZqpAKTkIdsm4PiiifY3KqFI2bz26ZPb3A428=;
        b=FZ7YgQV6PyORotMACyGtd/b36KzXLZrFz4ImSw45NiHMscSnHWCNz4Q2ydiY8fS/jf
         uUNLKoHbgZUNG/pPa7WYs+Ze2fR1Zp/vj3YhQZ1Z59PbakMEyM5H0oCb3m7AXTwvr6Dz
         wo/+sTTtDhm2wu1GkU4KS4chtv9zHNgZciOMEtzd+D+H8o73Fl2aU0H4rYceXT6kwEPm
         IZCZ9iO5/YstDW34EULx7W/+gbWrm2Km1MqclgaUOqUtRdWWzLPxsPgpSz1GFPBxLeCh
         DJIKT6nBVesLyZzUrlNNFSTWkpyIRWkPKK1Zdts5K+EC3fRLIjm7ElNaq+Lqb19d8UBL
         c48g==
X-Gm-Message-State: APjAAAXokqRHiqu/fnP5BuzUmnyAYfygMpgJ8AlXpbqMovbFVZcD1IQV
        q2MjmJb+JKbHRXfq/wuTMF/HFQ==
X-Google-Smtp-Source: APXvYqyq4P4oA8E6RZxIqIBXEpmKw8Vi4QGgaztH8CkAnEvnZCwBOoaPHXHIIfmZ/zHOg+qPOcmqmQ==
X-Received: by 2002:aa7:8b12:: with SMTP id f18mr26163383pfd.89.1556008926476;
        Tue, 23 Apr 2019 01:42:06 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id w189sm31234828pfw.147.2019.04.23.01.42.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 01:42:05 -0700 (PDT)
Date:   Tue, 23 Apr 2019 14:12:03 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        x86 Maintainers <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: tsc: Rework time_cpufreq_notifier()
Message-ID: <20190423084203.docjhm5chi6l4cmb@vireshk-i7>
References: <38900622.ao2n2t5aPS@kreacher>
 <20190422081709.i5mv4fbket5ls4xc@vireshk-i7>
 <CAJZ5v0iP4TGAdRKJ3WaXTTgg1ZyGWoYLm2cJZdww=BmYWZ2tUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iP4TGAdRKJ3WaXTTgg1ZyGWoYLm2cJZdww=BmYWZ2tUQ@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-04-19, 10:19, Rafael J. Wysocki wrote:
> On Mon, Apr 22, 2019 at 10:17 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 18-04-19, 16:11, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > There are problems with running time_cpufreq_notifier() on SMP
> > > systems.
> > >
> > > First off, the rdtsc() called from there runs on the CPU executing
> > > that code and not necessarily on the CPU whose sched_clock() rate is
> > > updated which is questionable at best.
> > >
> > > Second, in the cases when the frequencies of all CPUs in an SMP
> > > system are always in sync, it is not sufficient to update just
> > > one of them or the set associated with a given cpufreq policy on
> > > frequency changes - all CPUs in the system should be updated and
> > > that would require more than a simple transition notifier.
> > >
> > > Note, however, that the underlying issue (the TSC rate depending on
> > > the CPU frequency) has not been present in hardware shipping for the
> > > last few years and in quite a few relevant cases (acpi-cpufreq in
> > > particular) running time_cpufreq_notifier() will cause the TSC to
> > > be marked as unstable anyway.
> > >
> > > For this reason, make time_cpufreq_notifier() simply mark the TSC
> > > as unstable and give up when run on SMP and only try to carry out
> > > any adjustments otherwise.
> > >
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >  arch/x86/kernel/tsc.c |   29 ++++++++++++++---------------
> > >  1 file changed, 14 insertions(+), 15 deletions(-)
> > >
> > > Index: linux-pm/arch/x86/kernel/tsc.c
> > > ===================================================================
> > > --- linux-pm.orig/arch/x86/kernel/tsc.c
> > > +++ linux-pm/arch/x86/kernel/tsc.c
> > > @@ -185,8 +185,7 @@ static void __init cyc2ns_init_boot_cpu(
> > >  /*
> > >   * Secondary CPUs do not run through tsc_init(), so set up
> > >   * all the scale factors for all CPUs, assuming the same
> > > - * speed as the bootup CPU. (cpufreq notifiers will fix this
> > > - * up if their speed diverges)
> > > + * speed as the bootup CPU.
> > >   */
> > >  static void __init cyc2ns_init_secondary_cpus(void)
> > >  {
> > > @@ -937,12 +936,12 @@ void tsc_restore_sched_clock_state(void)
> > >  }
> > >
> > >  #ifdef CONFIG_CPU_FREQ
> > > -/* Frequency scaling support. Adjust the TSC based timer when the cpu frequency
> > > +/*
> > > + * Frequency scaling support. Adjust the TSC based timer when the CPU frequency
> > >   * changes.
> > >   *
> > > - * RED-PEN: On SMP we assume all CPUs run with the same frequency.  It's
> > > - * not that important because current Opteron setups do not support
> > > - * scaling on SMP anyroads.
> > > + * NOTE: On SMP the situation is not fixable in general, so simply mark the TSC
> > > + * as unstable and give up in those cases.
> > >   *
> > >   * Should fix up last_tsc too. Currently gettimeofday in the
> > >   * first tick after the change will be slightly wrong.
> > > @@ -956,22 +955,22 @@ static int time_cpufreq_notifier(struct
> > >                               void *data)
> > >  {
> > >       struct cpufreq_freqs *freq = data;
> > > -     unsigned long *lpj;
> > >
> > > -     lpj = &boot_cpu_data.loops_per_jiffy;
> > > -#ifdef CONFIG_SMP
> > > -     if (!(freq->flags & CPUFREQ_CONST_LOOPS))
> > > -             lpj = &cpu_data(freq->cpu).loops_per_jiffy;
> > > -#endif
> > > +     if (num_online_cpus() > 1) {
> >
> > What about checking num_possible_cpus() instead ? So we reliably quit
> > everytime even if some CPUs are offlined.
> 
> That would work too.
> 
> The point here is that the adjustments can work if the "additional"
> CPUs never go online.

Hmm, okay.

> > And can we place this check before registering the notifier, so it
> > never gets called ?
> 
> Well, in that case the TSC would need to be marked as unstable
> upfront, but that really only would be necessary if cpufreq was
> actually used.  If it wasn't used, whatever the reason, marking the
> TSC as unstable here would be excessive.
> 
> We're talking about old HW, mind you, and I know about systems shipped
> around that time frame that didn't support performance scaling at all
> and had the TSC (see the Opteron comment removed by this patch, for
> instance).
> 
> So I'd rather not change that part.

Fair enough.

-- 
viresh
