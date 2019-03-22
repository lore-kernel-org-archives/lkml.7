Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634CBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 06:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3253B218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 06:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KdhKeuyg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbfCVGUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 02:20:04 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43020 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbfCVGUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 02:20:03 -0400
Received: by mail-pg1-f194.google.com with SMTP id l11so764584pgq.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 23:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tqzJ4hKyYja5rZPcdKV8LhXCi5TD5kJ4UpCIR+4S3rU=;
        b=KdhKeuyg4pXR0sQiQ+TXNNvny23N7PStIK+quzE8JfghjnZqcohw4psFNBy/5AJYEG
         RFGOc1TID1tWMNG+hEnCSVQqVhQn0z7ZixjJ1+IOqg4PpaOoIdZD9HbZ1ConLUYuevMt
         pbUFQREGKK42pagIC1h0CUDJKl+4FzuENpL8CgpjCx2lMRwhZCQGl0HOZo+pB+c5zhde
         bPNr2nFQcGRz5n1D28hIJix74Fed86eDNGd/fOABxS0QZFRENV9ZhkKFacDtKatg1HQ3
         zwlJopv0Da2a1kHImQWNZvgrqaPp4Hr2tcp05xrmBAI3tJTO/vBKqsFIkbLSzQXpkxK8
         AduQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tqzJ4hKyYja5rZPcdKV8LhXCi5TD5kJ4UpCIR+4S3rU=;
        b=dyCC1Ivm4MIKqjN1tj04HFtt+g72OHNXmw0tf1XSLoIMS7XJdXozfUQQsrrWH50qrf
         3UkCR0j1P7J0IX8RHbt45dP5On2Mn32QNLDVIqTkYyl0x7ZXBYcWCCw157x5FQitlGEZ
         Ubah7XEhv3KWsOuy4FeVk2TYvV1yxEPzEmfsTBGdPm9v++Ij+ExmTizi4qsYp1TZPNuZ
         kZVtpJYpwwissqvlNFwIj+0GVoOo5lJA9raY2xNE6tX2Kp7ndZxS97tEKK5HfTU02XYv
         xKku8RJSjLh75TX1Bi/RM07/F2HvMgZJlujbbXLSJiLRFcQ31nZxQ677GT79Yz/lqE+G
         l/4w==
X-Gm-Message-State: APjAAAXdwaUpxgBAXQ3sdTKQr2HFRoNm7eCMlkO04tIVV+/gzFLkqBIX
        Hebdz9Ae3oSr3c8Q633IB0zHbQ==
X-Google-Smtp-Source: APXvYqzG+S+lCBgGgbU5nbjHQOsZMlVPsdwWIQgyW+YVaboBSecLC47wlQxrOTr0Te2zR5ZAbU/zPg==
X-Received: by 2002:a63:e051:: with SMTP id n17mr7186974pgj.19.1553235601770;
        Thu, 21 Mar 2019 23:20:01 -0700 (PDT)
Received: from localhost ([122.166.134.37])
        by smtp.gmail.com with ESMTPSA id w67sm11556056pfw.173.2019.03.21.23.19.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 23:19:59 -0700 (PDT)
Date:   Fri, 22 Mar 2019 11:49:57 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20190322061957.hzhnlbmnkpuqviiv@vireshk-i7>
References: <1eb27e3bbcbb2c67e6eadc0893c9b41e5d76894b.1553057341.git.viresh.kumar@linaro.org>
 <20190321114535.GM6058@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321114535.GM6058@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-03-19, 12:45, Peter Zijlstra wrote:
> On Wed, Mar 20, 2019 at 10:22:23AM +0530, Viresh Kumar wrote:
> > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > index 3fae23834069..b2fe665878f7 100644
> > --- a/arch/x86/kernel/tsc.c
> > +++ b/arch/x86/kernel/tsc.c
> > @@ -958,10 +958,15 @@ static int time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
> >  	struct cpufreq_freqs *freq = data;
> >  	unsigned long *lpj;
> >  
> > +	if (WARN_ON_ONCE(cpumask_weight(freq->policy->related_cpus) != 1)) {
> > +		mark_tsc_unstable("cpufreq changes: related CPUs affected");
> 
> I suspect this is a big fat nop, but it won't hurt.
> 
> > +		return 0;
> > +	}
> > +
> >  	lpj = &boot_cpu_data.loops_per_jiffy;
> >  #ifdef CONFIG_SMP
> >  	if (!(freq->flags & CPUFREQ_CONST_LOOPS))
> > -		lpj = &cpu_data(freq->cpu).loops_per_jiffy;
> > +		lpj = &cpu_data(freq->policy->cpu).loops_per_jiffy;
> >  #endif
> >  
> >  	if (!ref_freq) {
> > @@ -977,7 +982,7 @@ static int time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
> >  		if (!(freq->flags & CPUFREQ_CONST_LOOPS))
> >  			mark_tsc_unstable("cpufreq changes");
> >  
> > -		set_cyc2ns_scale(tsc_khz, freq->cpu, rdtsc());
> > +		set_cyc2ns_scale(tsc_khz, freq->policy->cpu, rdtsc());
> >  	}
> >  
> >  	return 0;
> 
> Just wondering, since we say x86 cpufreq handlers will only have a
> single CPU here,
> 
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index 65e4559eef2f..1ac8c710cccc 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -6649,10 +6649,8 @@ static void kvm_hyperv_tsc_notifier(void)
> >  }
> >  #endif
> >  
> > -static int kvmclock_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
> > -				     void *data)
> > +static void __kvmclock_cpufreq_notifier(struct cpufreq_freqs *freq, int cpu)
> >  {
> > -	struct cpufreq_freqs *freq = data;
> >  	struct kvm *kvm;
> >  	struct kvm_vcpu *vcpu;
> >  	int i, send_ipi = 0;
> > @@ -6696,17 +6694,12 @@ static int kvmclock_cpufreq_notifier(struct notifier_block *nb, unsigned long va
> >  	 *
> >  	 */
> >  
> > -	if (val == CPUFREQ_PRECHANGE && freq->old > freq->new)
> > -		return 0;
> > -	if (val == CPUFREQ_POSTCHANGE && freq->old < freq->new)
> > -		return 0;
> > -
> > -	smp_call_function_single(freq->cpu, tsc_khz_changed, freq, 1);
> > +	smp_call_function_single(cpu, tsc_khz_changed, freq, 1);
> >  
> >  	spin_lock(&kvm_lock);
> >  	list_for_each_entry(kvm, &vm_list, vm_list) {
> >  		kvm_for_each_vcpu(i, vcpu, kvm) {
> > -			if (vcpu->cpu != freq->cpu)
> > +			if (vcpu->cpu != cpu)
> >  				continue;
> >  			kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
> >  			if (vcpu->cpu != smp_processor_id())
> > @@ -6728,8 +6721,24 @@ static int kvmclock_cpufreq_notifier(struct notifier_block *nb, unsigned long va
> >  		 * guest context is entered kvmclock will be updated,
> >  		 * so the guest will not see stale values.
> >  		 */
> > -		smp_call_function_single(freq->cpu, tsc_khz_changed, freq, 1);
> > +		smp_call_function_single(cpu, tsc_khz_changed, freq, 1);
> >  	}
> > +}
> > +
> > +static int kvmclock_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
> > +				     void *data)
> > +{
> > +	struct cpufreq_freqs *freq = data;
> > +	int cpu;
> > +
> > +	if (val == CPUFREQ_PRECHANGE && freq->old > freq->new)
> > +		return 0;
> > +	if (val == CPUFREQ_POSTCHANGE && freq->old < freq->new)
> > +		return 0;
> > +
> > +	for_each_cpu(cpu, freq->policy->cpus)
> > +		__kvmclock_cpufreq_notifier(freq, cpu);
> > +
> >  	return 0;
> >  }
> >  
> 
> Then why to we pretend otherwise here?

My intention was to not add any bug here because of lack of my
knowledge of the architecture in question and so I tried to be safe.

If you guys think the behavior should be same here as of the tsc, then
we can add similar checks here.

-- 
viresh
