Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA34BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635B7218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="15rL+MHE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbfCULqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 07:46:11 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60898 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbfCULqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 07:46:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5y9Xi+y7zNWDmZd9L39f36TRBNen5lzKFND7iNlUNEw=; b=15rL+MHEG10GM8uPxNazw34dw
        lqYHhs+8eZOAH/KjXIasateEyR4YkVBDmmFOEbAxXagXfFzhmpWO/aWZiCnlv2OQFNkT8Riy3NuJy
        C7n/voZqLYogihkNcYRanFLg2GBYO6LdWVjvllJst/KQ4385DRS8uW5d6pjvtQsThS+2MZJjns4fQ
        7RfQozhFbJhDdJIhTidLOznyoO/Tg55xTCNVZ+SAOGLvWtZfuTk338ZiP0m15LCuNZuMMvqxhPaVY
        jmpyAPeNnyUDp22RztRlYuHuaULQVwfAwRPXdHng/nm1hPuSiFlAK7YLt6mNQrA1id6heZRtpGL3R
        teM+K75jw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h6w8f-0001op-PY; Thu, 21 Mar 2019 11:45:38 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2D81A285D1C05; Thu, 21 Mar 2019 12:45:35 +0100 (CET)
Date:   Thu, 21 Mar 2019 12:45:35 +0100
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
Subject: Re: [PATCH V3] cpufreq: Call transition notifier only once for each
 policy
Message-ID: <20190321114535.GM6058@hirez.programming.kicks-ass.net>
References: <1eb27e3bbcbb2c67e6eadc0893c9b41e5d76894b.1553057341.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1eb27e3bbcbb2c67e6eadc0893c9b41e5d76894b.1553057341.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 10:22:23AM +0530, Viresh Kumar wrote:
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index 3fae23834069..b2fe665878f7 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -958,10 +958,15 @@ static int time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
>  	struct cpufreq_freqs *freq = data;
>  	unsigned long *lpj;
>  
> +	if (WARN_ON_ONCE(cpumask_weight(freq->policy->related_cpus) != 1)) {
> +		mark_tsc_unstable("cpufreq changes: related CPUs affected");

I suspect this is a big fat nop, but it won't hurt.

> +		return 0;
> +	}
> +
>  	lpj = &boot_cpu_data.loops_per_jiffy;
>  #ifdef CONFIG_SMP
>  	if (!(freq->flags & CPUFREQ_CONST_LOOPS))
> -		lpj = &cpu_data(freq->cpu).loops_per_jiffy;
> +		lpj = &cpu_data(freq->policy->cpu).loops_per_jiffy;
>  #endif
>  
>  	if (!ref_freq) {
> @@ -977,7 +982,7 @@ static int time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
>  		if (!(freq->flags & CPUFREQ_CONST_LOOPS))
>  			mark_tsc_unstable("cpufreq changes");
>  
> -		set_cyc2ns_scale(tsc_khz, freq->cpu, rdtsc());
> +		set_cyc2ns_scale(tsc_khz, freq->policy->cpu, rdtsc());
>  	}
>  
>  	return 0;

Just wondering, since we say x86 cpufreq handlers will only have a
single CPU here,

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 65e4559eef2f..1ac8c710cccc 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -6649,10 +6649,8 @@ static void kvm_hyperv_tsc_notifier(void)
>  }
>  #endif
>  
> -static int kvmclock_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
> -				     void *data)
> +static void __kvmclock_cpufreq_notifier(struct cpufreq_freqs *freq, int cpu)
>  {
> -	struct cpufreq_freqs *freq = data;
>  	struct kvm *kvm;
>  	struct kvm_vcpu *vcpu;
>  	int i, send_ipi = 0;
> @@ -6696,17 +6694,12 @@ static int kvmclock_cpufreq_notifier(struct notifier_block *nb, unsigned long va
>  	 *
>  	 */
>  
> -	if (val == CPUFREQ_PRECHANGE && freq->old > freq->new)
> -		return 0;
> -	if (val == CPUFREQ_POSTCHANGE && freq->old < freq->new)
> -		return 0;
> -
> -	smp_call_function_single(freq->cpu, tsc_khz_changed, freq, 1);
> +	smp_call_function_single(cpu, tsc_khz_changed, freq, 1);
>  
>  	spin_lock(&kvm_lock);
>  	list_for_each_entry(kvm, &vm_list, vm_list) {
>  		kvm_for_each_vcpu(i, vcpu, kvm) {
> -			if (vcpu->cpu != freq->cpu)
> +			if (vcpu->cpu != cpu)
>  				continue;
>  			kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
>  			if (vcpu->cpu != smp_processor_id())
> @@ -6728,8 +6721,24 @@ static int kvmclock_cpufreq_notifier(struct notifier_block *nb, unsigned long va
>  		 * guest context is entered kvmclock will be updated,
>  		 * so the guest will not see stale values.
>  		 */
> -		smp_call_function_single(freq->cpu, tsc_khz_changed, freq, 1);
> +		smp_call_function_single(cpu, tsc_khz_changed, freq, 1);
>  	}
> +}
> +
> +static int kvmclock_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
> +				     void *data)
> +{
> +	struct cpufreq_freqs *freq = data;
> +	int cpu;
> +
> +	if (val == CPUFREQ_PRECHANGE && freq->old > freq->new)
> +		return 0;
> +	if (val == CPUFREQ_POSTCHANGE && freq->old < freq->new)
> +		return 0;
> +
> +	for_each_cpu(cpu, freq->policy->cpus)
> +		__kvmclock_cpufreq_notifier(freq, cpu);
> +
>  	return 0;
>  }
>  

Then why to we pretend otherwise here?
