Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB85AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2F6E20857
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xu0AIG0p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfCSKtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 06:49:39 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38244 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbfCSKtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 06:49:39 -0400
Received: by mail-pf1-f195.google.com with SMTP id n125so13405002pfn.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 03:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6MUI7M1BuQUG8uN0LprFR9EgNXGFFHQk0nBoBeIuGpE=;
        b=Xu0AIG0p1lbk1iDyAq3YiinZRAcrVlR8++dxy6CDB4KlsfkD5YsqjbXwM1nznqz9bF
         hHg7y5tEYbErlSFkcWxClDDFQacvxoMLyCBekrGqFLnbEU480V2yXUHup8YbmxoBvybt
         QQf5m1v7eoGUAQGp2LLiz7gF5gi+2zWIJeOOLJ1QdGfx5EZxEUI6led5/UzgQVTX3uAH
         z2lq76ZOxVYsacAgnCJN0s+GDXRsxevHMAvvq3Sx9GxCn4qQ5P7cfM2u60DllqS14nm2
         UIWU2rCSnOnJKu+vpQkTh1QA1ENVUpFER/LIHxgD5y0SmYiILDNWjE28o8DvXQ/LbHzp
         PJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6MUI7M1BuQUG8uN0LprFR9EgNXGFFHQk0nBoBeIuGpE=;
        b=FOqGPLjxVDx9TogO/4XWaAZVm/9Ab/xWxNRQBj5KM3MgG0VALo4b2P0C8aICFnZQqE
         5cc4Mmi0F3vyuvFKKLcL/fVlUhsnu52pmyuVRLNRMC0HjHg7xD+05ycSN5LtXr6AyQmB
         kXYwyk3t6eWNhkc0tR8+Oldd1sxzlJw2aFcApiyYSo1sRl3JMAT2T98CuVFyd7TjF5iE
         wbMolYtiV2zfK89Y6bAjVgXNUPtBWiFBqih7OJBvD0gPqbLBWQ+KRIMmmj1akIe/l5jo
         gpbmnF34dCuHk/me6qrR/KsjBW4oPREbBf949xtfpq9mhr/k0t9jRx0AeeNrn2YZX/xi
         sGPA==
X-Gm-Message-State: APjAAAW/YAb+7gkM2XzPknZdnQSUUa70w/VJP2pw/eM46sboDxi/DTuP
        J0eaOZnQyJKAcpqVRych2PM1nw==
X-Google-Smtp-Source: APXvYqz3+9nfv9Y6vdvfwObOKbTo1HxAeiGaVtzJgClTbEXrji7aUj/Yxkt+l39Yp3K49V2iS01tEQ==
X-Received: by 2002:aa7:8615:: with SMTP id p21mr129976pfn.98.1552992577956;
        Tue, 19 Mar 2019 03:49:37 -0700 (PDT)
Received: from localhost ([122.166.134.37])
        by smtp.gmail.com with ESMTPSA id n82sm10187918pfi.63.2019.03.19.03.49.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 03:49:35 -0700 (PDT)
Date:   Tue, 19 Mar 2019 16:19:33 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        sparclinux@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH V2] cpufreq: Call transition notifier only once for each
 policy
Message-ID: <20190319104933.vj6zcscubyp4gwxq@vireshk-i7>
References: <e2b56be446eeb67f1905d2ac6f8d82dd4389d0c5.1552640968.git.viresh.kumar@linaro.org>
 <CAJZ5v0jr-XJ6VbNf3ipYQuycah-GNZKLgGe5wGknkWF7bKSY2w@mail.gmail.com>
 <20190319055044.xbxr6ph5hl4zcucb@vireshk-i7>
 <CAJZ5v0gzjXNizE=e+AdqMdJvE_-wYCq0kvzB-thE=SufKfyRrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gzjXNizE=e+AdqMdJvE_-wYCq0kvzB-thE=SufKfyRrQ@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-03-19, 10:41, Rafael J. Wysocki wrote:
> On Tue, Mar 19, 2019 at 6:50 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 18-03-19, 12:49, Rafael J. Wysocki wrote:
> > > To summarize, I think that it would be sufficient to do this just for
> > > policy->cpu and, as Peter said, warn once if there are more CPUs in
> > > the policy or policy->cpu is not the CPU running this code.  And mark
> > > the TSC as unstable in both of these cases.
> >
> > How about this ?
> 
> We guarantee that this will always run on policy->cpu IIRC, so it LGTM

Yeah, the governor guarantees that unless dvfs_possible_from_any_cpu is set for
the policy. But there are few direct invocations to cpufreq_driver_target() and
__cpufreq_driver_target() which don't take that into account. First one is done
from cpufreq_online(), which can get called on any CPU I believe. Other one is
from cpufreq_generic_suspend(). But I think none of them gets called for x86 and
so below code should be safe.

> overall, but the new message is missing "one".

Talking about print message ?

> > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > index 3fae23834069..4d3681cfb6e0 100644
> > --- a/arch/x86/kernel/tsc.c
> > +++ b/arch/x86/kernel/tsc.c
> > @@ -958,10 +958,13 @@ static int time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
> >         struct cpufreq_freqs *freq = data;
> >         unsigned long *lpj;
> >
> > +       if (WARN_ON_ONCE(cpumask_weight(freq->policy->related_cpus) != 1))
> > +               mark_tsc_unstable("cpufreq policy has more than CPU");
> 
> Also I would check policy->cpus here.  After all, we don't care about
> CPUs that are never online.

Because the CPU isn't in the policy->cpus mask, we can't say it was *never*
online. Just that it isn't online at that moment of time. I used related_cpus as
the code here should be robust against any corner cases and shouldn't have
different behavior based on value of policy->cpus.

If the cpufreq driver is probed after all but one CPUs of a policy are offlined,
then you won't see the warning if policy->cpus is used. But the warning will
appear if any other CPU is onlined. For me that is wrong, we should have got the
warning earlier as well as it was just wrong to not warn earlier.

> And the message could be something like "cpufreq changes: related CPUs
> affected".

Sure.

I also forgot to add a "return" statement here. We shouldn't continue in this
case, right ?

> > +
> >         lpj = &boot_cpu_data.loops_per_jiffy;
> >  #ifdef CONFIG_SMP
> >         if (!(freq->flags & CPUFREQ_CONST_LOOPS))
> > -               lpj = &cpu_data(freq->cpu).loops_per_jiffy;
> > +               lpj = &cpu_data(freq->policy->cpu).loops_per_jiffy;
> >  #endif
> >
> >         if (!ref_freq) {
> > @@ -977,7 +980,7 @@ static int time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
> >                 if (!(freq->flags & CPUFREQ_CONST_LOOPS))
> >                         mark_tsc_unstable("cpufreq changes");
> >
> > -               set_cyc2ns_scale(tsc_khz, freq->cpu, rdtsc());
> > +               set_cyc2ns_scale(tsc_khz, freq->policy->cpu, rdtsc());
> >         }
> >
> >         return 0;

-- 
viresh
