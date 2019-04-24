Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B84FC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 683C32148D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u7xYv0kg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729904AbfDXGr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 02:47:58 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44886 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729807AbfDXGr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 02:47:57 -0400
Received: by mail-pf1-f194.google.com with SMTP id y13so8772774pfm.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 23:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=968WudXwXE4EGjMKHJVraATlmVhLXGYihRUuZAhZ8Eo=;
        b=u7xYv0kgcaktqZCBiYDlcBv/1VBHeJ/iLy6qGjF10bzFuRgI4UC2NY9iiGbs5+4+9+
         HNwWRGbp9Ok9qqvjixT4rGIb/e0KGVUO7Ej8vOOr5lmGJ2+3+wwR5ox8fxPuY//xsyzV
         E43HFeQVaLQLYYgch8c/HGJF7Fhn0SAoA4NninjJdfPzY0oWfLziXRPWvc0lakJ9ImVy
         hoPUE7vs5y8adiePqEaPHTZaXG1hVG9NttS+vCqrNJsi0gk4qzf2NSFnePvORwa3IZbw
         YXnSIUNiVFCHVQqij/OIjMA8b0knQMihOTOB1oLz5P+Il8XpQJBTjyz6M8vLawUmqnWA
         rtug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=968WudXwXE4EGjMKHJVraATlmVhLXGYihRUuZAhZ8Eo=;
        b=f7jrSyoL6sYvC+nsE4flLGYJoIDIHbqtAo3fuwo5w1igRNQwdafm5UUc1zI9kQTbpO
         83SIMYHhToHbRWG5VccYRMkVZCDCtNCu6xuYovRebbnFZd/fcQyEAeECa8PHBsvEpogH
         jgbq+4dxrNWLHnGtd9cIp9uZYuraYW+9EHzOXcgPor21O+aBP7PYpHm5aI+ZyzZeWeC1
         xLGEzNaJ32ouCmtjLgZMT0uubFq6I1c8bUClR4S9mSgv62OmXC00kTnIQPXihMSUBTQB
         6yBczSj46rY8RvLauegHY0GKLrQdbAdwQH7l+DzxjsOoJ4wHwvmlt5b22BjE3pv4dYFj
         Dc9Q==
X-Gm-Message-State: APjAAAUUgHgXvOupmxW/aGE6TDR+uGxaDD1j3CujVd6PCCrl7vPn5izV
        VD+tfy/KrODrP5uusoKW1W3i7Q==
X-Google-Smtp-Source: APXvYqyVATuRRSNFzq1QRrGzEFmpDS+QUaLSguMAvPAN2Sba0iw/t6WtXPwEwTT/lr4h4ruLaSXwVw==
X-Received: by 2002:a63:2b41:: with SMTP id r62mr29132034pgr.403.1556088477075;
        Tue, 23 Apr 2019 23:47:57 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id t21sm23993224pfe.22.2019.04.23.23.47.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 23:47:55 -0700 (PDT)
Date:   Wed, 24 Apr 2019 12:17:53 +0530
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
Message-ID: <20190424064753.lwfsdeodncaai5oz@vireshk-i7>
References: <1eb27e3bbcbb2c67e6eadc0893c9b41e5d76894b.1553057341.git.viresh.kumar@linaro.org>
 <20190321114535.GM6058@hirez.programming.kicks-ass.net>
 <20190322061957.hzhnlbmnkpuqviiv@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322061957.hzhnlbmnkpuqviiv@vireshk-i7>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-03-19, 11:49, Viresh Kumar wrote:
> On 21-03-19, 12:45, Peter Zijlstra wrote:
> > On Wed, Mar 20, 2019 at 10:22:23AM +0530, Viresh Kumar wrote:

> > > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > > index 65e4559eef2f..1ac8c710cccc 100644
> > > --- a/arch/x86/kvm/x86.c
> > > +++ b/arch/x86/kvm/x86.c
> > > @@ -6649,10 +6649,8 @@ static void kvm_hyperv_tsc_notifier(void)
> > >  }
> > >  #endif
> > >  
> > > -static int kvmclock_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
> > > -				     void *data)
> > > +static void __kvmclock_cpufreq_notifier(struct cpufreq_freqs *freq, int cpu)
> > >  {
> > > -	struct cpufreq_freqs *freq = data;
> > >  	struct kvm *kvm;
> > >  	struct kvm_vcpu *vcpu;
> > >  	int i, send_ipi = 0;
> > > @@ -6696,17 +6694,12 @@ static int kvmclock_cpufreq_notifier(struct notifier_block *nb, unsigned long va
> > >  	 *
> > >  	 */
> > >  
> > > -	if (val == CPUFREQ_PRECHANGE && freq->old > freq->new)
> > > -		return 0;
> > > -	if (val == CPUFREQ_POSTCHANGE && freq->old < freq->new)
> > > -		return 0;
> > > -
> > > -	smp_call_function_single(freq->cpu, tsc_khz_changed, freq, 1);
> > > +	smp_call_function_single(cpu, tsc_khz_changed, freq, 1);
> > >  
> > >  	spin_lock(&kvm_lock);
> > >  	list_for_each_entry(kvm, &vm_list, vm_list) {
> > >  		kvm_for_each_vcpu(i, vcpu, kvm) {
> > > -			if (vcpu->cpu != freq->cpu)
> > > +			if (vcpu->cpu != cpu)
> > >  				continue;
> > >  			kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
> > >  			if (vcpu->cpu != smp_processor_id())
> > > @@ -6728,8 +6721,24 @@ static int kvmclock_cpufreq_notifier(struct notifier_block *nb, unsigned long va
> > >  		 * guest context is entered kvmclock will be updated,
> > >  		 * so the guest will not see stale values.
> > >  		 */
> > > -		smp_call_function_single(freq->cpu, tsc_khz_changed, freq, 1);
> > > +		smp_call_function_single(cpu, tsc_khz_changed, freq, 1);
> > >  	}
> > > +}
> > > +
> > > +static int kvmclock_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
> > > +				     void *data)
> > > +{
> > > +	struct cpufreq_freqs *freq = data;
> > > +	int cpu;
> > > +
> > > +	if (val == CPUFREQ_PRECHANGE && freq->old > freq->new)
> > > +		return 0;
> > > +	if (val == CPUFREQ_POSTCHANGE && freq->old < freq->new)
> > > +		return 0;
> > > +
> > > +	for_each_cpu(cpu, freq->policy->cpus)
> > > +		__kvmclock_cpufreq_notifier(freq, cpu);
> > > +
> > >  	return 0;
> > >  }
> > >  
> > 
> > Then why to we pretend otherwise here?
> 
> My intention was to not add any bug here because of lack of my
> knowledge of the architecture in question and so I tried to be safe.
> 
> If you guys think the behavior should be same here as of the tsc, then
> we can add similar checks here.

I am rebasing this patch over Rafael's patch [1] and wondering if I
should change anything here.

-- 
viresh

[1] https://lore.kernel.org/lkml/38900622.ao2n2t5aPS@kreacher/
