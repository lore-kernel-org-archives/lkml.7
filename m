Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCB8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 02:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E07922085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 02:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g6Jgcy/I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfCRCfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 22:35:19 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45654 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbfCRCfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 22:35:19 -0400
Received: by mail-pf1-f194.google.com with SMTP id v21so10192968pfm.12
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 19:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wU6o8V6Vc561uCXfzS7X4gdukWheS1MDzVWA2U3wsFc=;
        b=g6Jgcy/I1CaxtO2Oyn7C6BaN4o26Ytt1XNJOaKMM5b3m7vaIJDtJv71xfKF1eNP3qi
         KlaiphKE39cH9M6oxuUcT7toO5KiyCqvsNNB3XjldK8L3QavTHgKoqQ0khmrrM9x9srB
         Gduqo8wkczLTqZtgr4x7J3JBAgvKqPIOatLV5rZMZtatZCELUa07SAXaK/GpCDJRvQT2
         NDCgjZxjRmrovLO02zZR+P04HHwBgrXmWi9wcjx8xABulRvRW3v0iqRpGrd1SQkJ5dKr
         IeeSD2p9vYqrPDaZqzhZ1tncgMC2/aVMTU/O5C+ZJMEo+pWCnGrHVEGMkL0uNub9xdCC
         dyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wU6o8V6Vc561uCXfzS7X4gdukWheS1MDzVWA2U3wsFc=;
        b=su+GmrUJNqD0bK9wVfqiW3exywSEWEnmjEDo1annUtNF7T0z8kL9SJzJmK/87QeaYZ
         yDrfEMzc+P6MVhyHCm5JnNSlRz8TDh0xsEVrnuIfUhpG5bJoOQETYz2unfIacGW+SR1u
         S9lLmqSQP0Mdz9XtOZUQ2HWGnDapmM6xq1El+ZC+zELRlc4aA5rUeDGiWLswjhZfThnQ
         f27BPkkyItGcm1vMZgpQCJBBtCvuGX4/ymHiY6FOxXc9zPA6w51wyiMQnsczHNW89U5d
         LQ8VeamI9IBbFu0qFdwFh6litFO7Ya67WDrNG7C+w74aZTkt5cNJb9gzUoPMJrZZ35Pm
         BHYg==
X-Gm-Message-State: APjAAAVIHsWRjM2rPLTWqNyS8NMplNcSrnEL2b7xcc5qjjuyLvqjgrQH
        iAg28w3BD5GN8n+dC5cCng9NZA==
X-Google-Smtp-Source: APXvYqz1kmcndDml7PE/Cu5bvCkokDGcw6UmctpNXPEvrheL8UNFKsv7kwq2TMHxXnRS3xFXoyW/Yg==
X-Received: by 2002:a17:902:b493:: with SMTP id y19mr17870016plr.9.1552876518236;
        Sun, 17 Mar 2019 19:35:18 -0700 (PDT)
Received: from localhost ([122.166.134.37])
        by smtp.gmail.com with ESMTPSA id 202sm3595340pfc.86.2019.03.17.19.35.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 19:35:16 -0700 (PDT)
Date:   Mon, 18 Mar 2019 08:05:14 +0530
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
Subject: Re: [PATCH V2] cpufreq: Call transition notifier only once for each
 policy
Message-ID: <20190318023514.67gxypb4w7llcmha@vireshk-i7>
References: <e2b56be446eeb67f1905d2ac6f8d82dd4389d0c5.1552640968.git.viresh.kumar@linaro.org>
 <20190315122952.GF6058@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315122952.GF6058@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-03-19, 13:29, Peter Zijlstra wrote:
> On Fri, Mar 15, 2019 at 02:43:07PM +0530, Viresh Kumar wrote:
> > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > index 3fae23834069..cff8779fc0d2 100644
> > --- a/arch/x86/kernel/tsc.c
> > +++ b/arch/x86/kernel/tsc.c
> > @@ -956,28 +956,38 @@ static int time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
> >  				void *data)
> >  {
> >  	struct cpufreq_freqs *freq = data;
> > -	unsigned long *lpj;
> > -
> > -	lpj = &boot_cpu_data.loops_per_jiffy;
> > -#ifdef CONFIG_SMP
> > -	if (!(freq->flags & CPUFREQ_CONST_LOOPS))
> > -		lpj = &cpu_data(freq->cpu).loops_per_jiffy;
> > -#endif
> > +	struct cpumask *cpus = freq->policy->cpus;
> > +	bool boot_cpu = !IS_ENABLED(CONFIG_SMP) || freq->flags & CPUFREQ_CONST_LOOPS;
> > +	unsigned long lpj;
> > +	int cpu;
> >  
> >  	if (!ref_freq) {
> >  		ref_freq = freq->old;
> > -		loops_per_jiffy_ref = *lpj;
> >  		tsc_khz_ref = tsc_khz;
> > +
> > +		if (boot_cpu)
> > +			loops_per_jiffy_ref = boot_cpu_data.loops_per_jiffy;
> > +		else
> > +			loops_per_jiffy_ref = cpu_data(cpumask_first(cpus)).loops_per_jiffy;
> >  	}
> > +
> >  	if ((val == CPUFREQ_PRECHANGE  && freq->old < freq->new) ||
> >  			(val == CPUFREQ_POSTCHANGE && freq->old > freq->new)) {
> > -		*lpj = cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
> > -
> > +		lpj = cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
> >  		tsc_khz = cpufreq_scale(tsc_khz_ref, ref_freq, freq->new);
> > +
> >  		if (!(freq->flags & CPUFREQ_CONST_LOOPS))
> >  			mark_tsc_unstable("cpufreq changes");
> >  
> > -		set_cyc2ns_scale(tsc_khz, freq->cpu, rdtsc());
> > +		if (boot_cpu) {
> > +			boot_cpu_data.loops_per_jiffy = lpj;
> > +		} else {
> > +			for_each_cpu(cpu, cpus)
> > +				cpu_data(cpu).loops_per_jiffy = lpj;
> > +		}
> > +
> > +		for_each_cpu(cpu, cpus)
> > +			set_cyc2ns_scale(tsc_khz, cpu, rdtsc());
> 
> This code doesn't make sense, the rdtsc() _must_ be called on the CPU in
> question.

You mean rdtsc() must be locally on that CPU? The cpufreq core never guaranteed
that and it was left for the notifier to do. This patch doesn't change the
behavior at all, just that it moves the for-loop to the notifier instead of the
cpufreq core.

> That's part of the whole problem here, TSC isn't sync'ed when
> it's subject to CPUFREQ.
> 
> >  	}
> >  
> >  	return 0;

-- 
viresh
