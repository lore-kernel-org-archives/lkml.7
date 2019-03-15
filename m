Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1140BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 12:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3A9E21871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 12:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Et69gAI1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbfCOMaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 08:30:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36848 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727671AbfCOMaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 08:30:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/Ckel4zvjLrhxvyqm3MFEjjHJgoBIPigW3uv5xckhjE=; b=Et69gAI1ytf+ehROyT4f/n7Ca
        TaZiomf07G4wk7y8LSQcY5hY7cH/tuVuC4kKEptJfXxFFPurIDzKaVkYpJxy9Wshb1qU3w5BsLi+V
        JrDXK5wfRPYYY/qlEJV426RG4HzZQOtPDezYgC/IAW+CUI/ch7UykyZfqjYX0yrkJcMo4zB/DOCv6
        xdvC9/TNcGDjWtezXQHc0pSkuwhXUuaN4HTSGRKdAV3XxjAm/1zC9wwq/b5p+apvPTwB768WdBClO
        3HuEmfXX1xQnw0/H5SM12jMTmtgejJfEI62uFjFCoKzdpxoReLXmFY0rdBBT7nYXia+AFNP35lNWW
        ppwQUTLrA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h4lyD-0006bW-Uy; Fri, 15 Mar 2019 12:29:54 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7693F21419E57; Fri, 15 Mar 2019 13:29:52 +0100 (CET)
Date:   Fri, 15 Mar 2019 13:29:52 +0100
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
Message-ID: <20190315122952.GF6058@hirez.programming.kicks-ass.net>
References: <e2b56be446eeb67f1905d2ac6f8d82dd4389d0c5.1552640968.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2b56be446eeb67f1905d2ac6f8d82dd4389d0c5.1552640968.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 02:43:07PM +0530, Viresh Kumar wrote:
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index 3fae23834069..cff8779fc0d2 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -956,28 +956,38 @@ static int time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
>  				void *data)
>  {
>  	struct cpufreq_freqs *freq = data;
> -	unsigned long *lpj;
> -
> -	lpj = &boot_cpu_data.loops_per_jiffy;
> -#ifdef CONFIG_SMP
> -	if (!(freq->flags & CPUFREQ_CONST_LOOPS))
> -		lpj = &cpu_data(freq->cpu).loops_per_jiffy;
> -#endif
> +	struct cpumask *cpus = freq->policy->cpus;
> +	bool boot_cpu = !IS_ENABLED(CONFIG_SMP) || freq->flags & CPUFREQ_CONST_LOOPS;
> +	unsigned long lpj;
> +	int cpu;
>  
>  	if (!ref_freq) {
>  		ref_freq = freq->old;
> -		loops_per_jiffy_ref = *lpj;
>  		tsc_khz_ref = tsc_khz;
> +
> +		if (boot_cpu)
> +			loops_per_jiffy_ref = boot_cpu_data.loops_per_jiffy;
> +		else
> +			loops_per_jiffy_ref = cpu_data(cpumask_first(cpus)).loops_per_jiffy;
>  	}
> +
>  	if ((val == CPUFREQ_PRECHANGE  && freq->old < freq->new) ||
>  			(val == CPUFREQ_POSTCHANGE && freq->old > freq->new)) {
> -		*lpj = cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
> -
> +		lpj = cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
>  		tsc_khz = cpufreq_scale(tsc_khz_ref, ref_freq, freq->new);
> +
>  		if (!(freq->flags & CPUFREQ_CONST_LOOPS))
>  			mark_tsc_unstable("cpufreq changes");
>  
> -		set_cyc2ns_scale(tsc_khz, freq->cpu, rdtsc());
> +		if (boot_cpu) {
> +			boot_cpu_data.loops_per_jiffy = lpj;
> +		} else {
> +			for_each_cpu(cpu, cpus)
> +				cpu_data(cpu).loops_per_jiffy = lpj;
> +		}
> +
> +		for_each_cpu(cpu, cpus)
> +			set_cyc2ns_scale(tsc_khz, cpu, rdtsc());

This code doesn't make sense, the rdtsc() _must_ be called on the CPU in
question. That's part of the whole problem here, TSC isn't sync'ed when
it's subject to CPUFREQ.

>  	}
>  
>  	return 0;
