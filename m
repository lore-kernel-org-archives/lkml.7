Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08D1C282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 08:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B870D217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 08:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y3SPFbdv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfDVIRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 04:17:13 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40201 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfDVIRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 04:17:13 -0400
Received: by mail-pg1-f194.google.com with SMTP id d31so5515869pgl.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 01:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=42VKjbmgGJszKQVYdbl0cK7YeGeYgHMGOiMgkawBYX8=;
        b=y3SPFbdvzwTlth0kuvgy/Zcf1lTl8LR0S7OoXISh0O37xaqdUD2Gq8D4fd6zZoABWi
         MHfALCLxAfyOCqB1grDWADP9jEvx0IpBegfF4lVMlJVCmEPk8rbmnmc2HyZ0wKCNXdUF
         LT/v861LY67BJuRdOAtYr+vX7965ch/yKNIPmYkldaxXCmm9S+1sq6cZvE7MvH4SgPuR
         Zr56e1/Mi0kcKlug+555Y4MTSc0ZiC+vQMh9PyE7jCHEEs7+FWHFHpYncIhomZIsk42w
         nBLUVaEkBb6sBH4MueVPBbv5+EoZ2/8o4EY+BqQ/BaoEH8UfF+z50ymX/jOm9odlaOVi
         jclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=42VKjbmgGJszKQVYdbl0cK7YeGeYgHMGOiMgkawBYX8=;
        b=VUdEyFz3GYtWhwOnjyFJkMzKiPQPdcJjbAfRCHQGn9dQSD9QpV2qfOqwL+vavjZ9ZB
         oKwP0D4Cz2Ri0nhItSj1dXD/1y6qX6OUoMlkOXpt0SQtHu8PeTDntlnpkGEDgsOO+rs3
         HtdflOf3eZvDgdPtBkkY9Bdr56RMETsGoRgemCNqhxzW8Oq81JPmlmqx4eYIq6z/dy6+
         Jjbj8l6T3SBrcB4JJCY4XsDzEPvkf885++DsxdpI4R3lsZEceEFa7ylAUUkVR4j5o9JE
         6My7NmJWb176BlqE/22NIH5gXoNldH2DZJzFuSC8s19SxB+xxNXSWy5WDF9PHuNVsrqB
         VHfw==
X-Gm-Message-State: APjAAAXMXlByXcC3nBgnlgGi9yfhgC2V72LsW1J9h18hoCECCJRpkemb
        DvvvhXNbRZGPLNn1KK26Xj5CbA==
X-Google-Smtp-Source: APXvYqxBjZT+/4TAtmMJSU1h0L1tYG3AGoYXdYHnM04KJXA5Xn2L8VxZUBBLwmyd6m/TH/sSu5YD5g==
X-Received: by 2002:a63:84c7:: with SMTP id k190mr17696551pgd.255.1555921031991;
        Mon, 22 Apr 2019 01:17:11 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id b63sm33310308pfj.54.2019.04.22.01.17.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 01:17:10 -0700 (PDT)
Date:   Mon, 22 Apr 2019 13:47:09 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        x86 Maintainers <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: tsc: Rework time_cpufreq_notifier()
Message-ID: <20190422081709.i5mv4fbket5ls4xc@vireshk-i7>
References: <38900622.ao2n2t5aPS@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38900622.ao2n2t5aPS@kreacher>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-04-19, 16:11, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> There are problems with running time_cpufreq_notifier() on SMP
> systems.
> 
> First off, the rdtsc() called from there runs on the CPU executing
> that code and not necessarily on the CPU whose sched_clock() rate is
> updated which is questionable at best.
> 
> Second, in the cases when the frequencies of all CPUs in an SMP
> system are always in sync, it is not sufficient to update just
> one of them or the set associated with a given cpufreq policy on
> frequency changes - all CPUs in the system should be updated and
> that would require more than a simple transition notifier.
> 
> Note, however, that the underlying issue (the TSC rate depending on
> the CPU frequency) has not been present in hardware shipping for the
> last few years and in quite a few relevant cases (acpi-cpufreq in
> particular) running time_cpufreq_notifier() will cause the TSC to
> be marked as unstable anyway.
> 
> For this reason, make time_cpufreq_notifier() simply mark the TSC
> as unstable and give up when run on SMP and only try to carry out
> any adjustments otherwise.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  arch/x86/kernel/tsc.c |   29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
> 
> Index: linux-pm/arch/x86/kernel/tsc.c
> ===================================================================
> --- linux-pm.orig/arch/x86/kernel/tsc.c
> +++ linux-pm/arch/x86/kernel/tsc.c
> @@ -185,8 +185,7 @@ static void __init cyc2ns_init_boot_cpu(
>  /*
>   * Secondary CPUs do not run through tsc_init(), so set up
>   * all the scale factors for all CPUs, assuming the same
> - * speed as the bootup CPU. (cpufreq notifiers will fix this
> - * up if their speed diverges)
> + * speed as the bootup CPU.
>   */
>  static void __init cyc2ns_init_secondary_cpus(void)
>  {
> @@ -937,12 +936,12 @@ void tsc_restore_sched_clock_state(void)
>  }
>  
>  #ifdef CONFIG_CPU_FREQ
> -/* Frequency scaling support. Adjust the TSC based timer when the cpu frequency
> +/*
> + * Frequency scaling support. Adjust the TSC based timer when the CPU frequency
>   * changes.
>   *
> - * RED-PEN: On SMP we assume all CPUs run with the same frequency.  It's
> - * not that important because current Opteron setups do not support
> - * scaling on SMP anyroads.
> + * NOTE: On SMP the situation is not fixable in general, so simply mark the TSC
> + * as unstable and give up in those cases.
>   *
>   * Should fix up last_tsc too. Currently gettimeofday in the
>   * first tick after the change will be slightly wrong.
> @@ -956,22 +955,22 @@ static int time_cpufreq_notifier(struct
>  				void *data)
>  {
>  	struct cpufreq_freqs *freq = data;
> -	unsigned long *lpj;
>  
> -	lpj = &boot_cpu_data.loops_per_jiffy;
> -#ifdef CONFIG_SMP
> -	if (!(freq->flags & CPUFREQ_CONST_LOOPS))
> -		lpj = &cpu_data(freq->cpu).loops_per_jiffy;
> -#endif
> +	if (num_online_cpus() > 1) {

What about checking num_possible_cpus() instead ? So we reliably quit
everytime even if some CPUs are offlined.

And can we place this check before registering the notifier, so it
never gets called ?

> +		mark_tsc_unstable("cpufreq changes on SMP");
> +		return 0;
> +	}
>  
>  	if (!ref_freq) {
>  		ref_freq = freq->old;
> -		loops_per_jiffy_ref = *lpj;
> +		loops_per_jiffy_ref = boot_cpu_data.loops_per_jiffy;
>  		tsc_khz_ref = tsc_khz;
>  	}
> +
>  	if ((val == CPUFREQ_PRECHANGE  && freq->old < freq->new) ||
> -			(val == CPUFREQ_POSTCHANGE && freq->old > freq->new)) {
> -		*lpj = cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
> +	    (val == CPUFREQ_POSTCHANGE && freq->old > freq->new)) {
> +		boot_cpu_data.loops_per_jiffy =
> +			cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
>  
>  		tsc_khz = cpufreq_scale(tsc_khz_ref, ref_freq, freq->new);
>  		if (!(freq->flags & CPUFREQ_CONST_LOOPS))
> 
> 

-- 
viresh
