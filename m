Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34305C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 09:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F108E20989
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 09:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552988497;
	bh=IWgfJhtmXu89m2VV1DlT8t+9XksMtLGX6Nh13up6jek=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=geM4exFGMyz7why5V1c7MOT+U5hldhwp0KviP0mpO5mZLzPc+DAvLcznaqeghpCg9
	 ZaC+nFH2KyRL6ituiElWDGmgrX0gVD+wGpLa9o1BSq6NCWZ6ns1wBCsCRvrBEQPBeO
	 ZXUuUEJmYl2DVlwocM8Borv8Gy6rKqrjlRriLPhE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfCSJlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 05:41:36 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:32991 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfCSJlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 05:41:35 -0400
Received: by mail-ot1-f67.google.com with SMTP id q24so17091308otk.0;
        Tue, 19 Mar 2019 02:41:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UCGF2xOD+NEND1ehISwTO16Inhr1l0uZYguh3CuY84E=;
        b=T1YP6A81LbIfC0CCIWCWodyPOYAl+1uKZ7jOkTC1cDDe/49cXnlOJTu8hnF00nvSH3
         KXd7GUoxWkIrS75K1dSR9Hxd5TCOLbwlgHTo/rIAz+iskbCeVZBdABD6lrMGP5gMInHD
         U2h1JAm8r91/pI8Su+UZtTPTkKwqpgWKyU23w2wG3NsStU4Ufv/RyAAX8SvqX4U+6X57
         scvCaOZmBswNyM6ZfmVmrjATbvKFcbba2FZeZSf7fFteVMUCSm034ey7ZgECirxVIxzx
         LhN2EwwpBgt5zpOUUuH6yi3TXdSUBKIvg9CLun16PGBkumalT2y7XOUe5EekN0pkvuG9
         BDOA==
X-Gm-Message-State: APjAAAX5keTvjZh26E0fplXUnGjXg8/av5Hqzry1+OsmLBuCH5Q7pqXV
        4iLZdsPayrmh8rUo1XTD1MBfweAT6Ud26BHChGo=
X-Google-Smtp-Source: APXvYqzpUOGxZuzdzNSkBXTfBzIb6yRjx+CkhGPexEbZrs4GBOVKX24TJMBbmcyohmQ9FfY3uZTYPgTuFu3BfGyf+PY=
X-Received: by 2002:a9d:7cd3:: with SMTP id r19mr959831otn.139.1552988494216;
 Tue, 19 Mar 2019 02:41:34 -0700 (PDT)
MIME-Version: 1.0
References: <e2b56be446eeb67f1905d2ac6f8d82dd4389d0c5.1552640968.git.viresh.kumar@linaro.org>
 <CAJZ5v0jr-XJ6VbNf3ipYQuycah-GNZKLgGe5wGknkWF7bKSY2w@mail.gmail.com> <20190319055044.xbxr6ph5hl4zcucb@vireshk-i7>
In-Reply-To: <20190319055044.xbxr6ph5hl4zcucb@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 19 Mar 2019 10:41:23 +0100
Message-ID: <CAJZ5v0gzjXNizE=e+AdqMdJvE_-wYCq0kvzB-thE=SufKfyRrQ@mail.gmail.com>
Subject: Re: [PATCH V2] cpufreq: Call transition notifier only once for each policy
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        sparclinux@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 6:50 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 18-03-19, 12:49, Rafael J. Wysocki wrote:
> > To summarize, I think that it would be sufficient to do this just for
> > policy->cpu and, as Peter said, warn once if there are more CPUs in
> > the policy or policy->cpu is not the CPU running this code.  And mark
> > the TSC as unstable in both of these cases.
>
> How about this ?

We guarantee that this will always run on policy->cpu IIRC, so it LGTM
overall, but the new message is missing "one".

> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index 3fae23834069..4d3681cfb6e0 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -958,10 +958,13 @@ static int time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
>         struct cpufreq_freqs *freq = data;
>         unsigned long *lpj;
>
> +       if (WARN_ON_ONCE(cpumask_weight(freq->policy->related_cpus) != 1))
> +               mark_tsc_unstable("cpufreq policy has more than CPU");

Also I would check policy->cpus here.  After all, we don't care about
CPUs that are never online.

And the message could be something like "cpufreq changes: related CPUs
affected".

> +
>         lpj = &boot_cpu_data.loops_per_jiffy;
>  #ifdef CONFIG_SMP
>         if (!(freq->flags & CPUFREQ_CONST_LOOPS))
> -               lpj = &cpu_data(freq->cpu).loops_per_jiffy;
> +               lpj = &cpu_data(freq->policy->cpu).loops_per_jiffy;
>  #endif
>
>         if (!ref_freq) {
> @@ -977,7 +980,7 @@ static int time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
>                 if (!(freq->flags & CPUFREQ_CONST_LOOPS))
>                         mark_tsc_unstable("cpufreq changes");
>
> -               set_cyc2ns_scale(tsc_khz, freq->cpu, rdtsc());
> +               set_cyc2ns_scale(tsc_khz, freq->policy->cpu, rdtsc());
>         }
>
>         return 0;
