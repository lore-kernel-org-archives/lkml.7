Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F30C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C132082F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CJxuGH3n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfCRKyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:54:14 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55300 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfCRKyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 06:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EmfkXywzIOkf0D6HSDgi0wJad6afB3/adOnOGAbu1P4=; b=CJxuGH3ngTVu9+lNNzZP8Ag80
        twczCsDbFMgRn5Kc0tigyFy0eLImnkoSBBQXR2WlrB04GTGZqppfOBzVgwwXrEKyP/YlGBENvhRIM
        LNvFPWIVNiBvWtc8tfAA1c+XBUiKAuvQ7ZGWAM6nmol7UpzC3fmCq9XfEmDw4+/h1OxKKvWdivCmm
        aM14n4imVNWxMDKA1b3gHlToynNfnZkhgAyrBKGy4r11EjOcKax+hq62WnqoqD7+FH1LHpJQU1A5R
        f0se4CNeyTD4slJH4/pKvhVpX1Glq31pto3Ok9Ioa+VPfUlMIdstRbi1nItaKckd1PjNyB5LJfwRE
        m2RH+tQkg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h5pu1-0001oT-UO; Mon, 18 Mar 2019 10:53:58 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8CFFE20A0FF8B; Mon, 18 Mar 2019 11:53:56 +0100 (CET)
Date:   Mon, 18 Mar 2019 11:53:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH V2] cpufreq: Call transition notifier only once for each
 policy
Message-ID: <20190318105356.GM6058@hirez.programming.kicks-ass.net>
References: <e2b56be446eeb67f1905d2ac6f8d82dd4389d0c5.1552640968.git.viresh.kumar@linaro.org>
 <20190315122952.GF6058@hirez.programming.kicks-ass.net>
 <20190318023514.67gxypb4w7llcmha@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318023514.67gxypb4w7llcmha@vireshk-i7>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 08:05:14AM +0530, Viresh Kumar wrote:
> On 15-03-19, 13:29, Peter Zijlstra wrote:
> > On Fri, Mar 15, 2019 at 02:43:07PM +0530, Viresh Kumar wrote:
> > > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > > index 3fae23834069..cff8779fc0d2 100644
> > > --- a/arch/x86/kernel/tsc.c
> > > +++ b/arch/x86/kernel/tsc.c
> > > @@ -956,28 +956,38 @@ static int time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
> > >  				void *data)
> > >  {
> > >  	struct cpufreq_freqs *freq = data;
> > > -	unsigned long *lpj;
> > > -
> > > -	lpj = &boot_cpu_data.loops_per_jiffy;
> > > -#ifdef CONFIG_SMP
> > > -	if (!(freq->flags & CPUFREQ_CONST_LOOPS))
> > > -		lpj = &cpu_data(freq->cpu).loops_per_jiffy;
> > > -#endif
> > > +	struct cpumask *cpus = freq->policy->cpus;
> > > +	bool boot_cpu = !IS_ENABLED(CONFIG_SMP) || freq->flags & CPUFREQ_CONST_LOOPS;
> > > +	unsigned long lpj;
> > > +	int cpu;
> > >  
> > >  	if (!ref_freq) {
> > >  		ref_freq = freq->old;
> > > -		loops_per_jiffy_ref = *lpj;
> > >  		tsc_khz_ref = tsc_khz;
> > > +
> > > +		if (boot_cpu)
> > > +			loops_per_jiffy_ref = boot_cpu_data.loops_per_jiffy;
> > > +		else
> > > +			loops_per_jiffy_ref = cpu_data(cpumask_first(cpus)).loops_per_jiffy;
> > >  	}
> > > +
> > >  	if ((val == CPUFREQ_PRECHANGE  && freq->old < freq->new) ||
> > >  			(val == CPUFREQ_POSTCHANGE && freq->old > freq->new)) {
> > > -		*lpj = cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
> > > -
> > > +		lpj = cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
> > >  		tsc_khz = cpufreq_scale(tsc_khz_ref, ref_freq, freq->new);
> > > +
> > >  		if (!(freq->flags & CPUFREQ_CONST_LOOPS))
> > >  			mark_tsc_unstable("cpufreq changes");
> > >  
> > > -		set_cyc2ns_scale(tsc_khz, freq->cpu, rdtsc());
> > > +		if (boot_cpu) {
> > > +			boot_cpu_data.loops_per_jiffy = lpj;
> > > +		} else {
> > > +			for_each_cpu(cpu, cpus)
> > > +				cpu_data(cpu).loops_per_jiffy = lpj;
> > > +		}
> > > +
> > > +		for_each_cpu(cpu, cpus)
> > > +			set_cyc2ns_scale(tsc_khz, cpu, rdtsc());
> > 
> > This code doesn't make sense, the rdtsc() _must_ be called on the CPU in
> > question.
> 
> You mean rdtsc() must be locally on that CPU? The cpufreq core never guaranteed
> that and it was left for the notifier to do. This patch doesn't change the
> behavior at all, just that it moves the for-loop to the notifier instead of the
> cpufreq core.

Yuck..

Rafael; how does this work in practise? Earlier you said that on x86 the
policies typically have a single cpu in them anyway. Is the freq change
also notified from _that_ cpu?

I don't think I have old enough hardware around anymore to test any of
this. This was truly ancient p6 era stuff IIRC.

Because in that case, I'm all for not doing the changes to this notifier
Viresh is proposing but simply adding something like:


	WARN_ON_ONCE(cpumask_weight(cpuc) != 1);
	WARN_ON_ONCE(cpumask_first(cpuc) != smp_processor_id());

And leave it at that.

