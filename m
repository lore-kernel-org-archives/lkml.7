Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53153C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 05:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF4B20872
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 05:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aC1xBBc8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbfCSFuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 01:50:50 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33353 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbfCSFut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 01:50:49 -0400
Received: by mail-pf1-f194.google.com with SMTP id i19so12958283pfd.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 22:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yRdBJSsbu9gpObquf84dsO5r/9Yrt9/YGDE1F1daw2c=;
        b=aC1xBBc8ycwCbq44zqcAw/FVdSS40KJXJS/ZgieN3Ahygzu6Q3zW1J8wY12K5MFD2t
         o/CdMKSY1G4+zCS5J+gr5VetgTDrwG/vWohcoCiO6DhGFmgPMvRloBGmy8i9l8rGZd9R
         /FAMyXUX71xn1C0GT5da+bIHU0O0rTIo6ftUYwrOnY2si42spIERZdgdiwq1ZwVQDnSj
         r+W5Xj6Pw+ggF86QPpXi6Vxwpm8FxX2ROKrPP+iildEcnutyyqL2l+fbSCKbqL9IIx//
         O3OElKGi4v4ZuJ5qm/DGJWtfI+z7Wp9LXnvm8/qwaIFGi7h2f1p3QcttBRK3VSmNrcZN
         Becg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yRdBJSsbu9gpObquf84dsO5r/9Yrt9/YGDE1F1daw2c=;
        b=V8uGc7Hz3COjBOk1uG6/OHP+YWMTjmaw97uro6jkqLDJNAjVVp0LSVJNr8v3P8SG1B
         HzZ44qSRIBPkn0HpwkrRTm3aNAJ8VUps4/rwiMgcNjfDoqfwl8oMZ5CLh5sKe9svKv3j
         3OHllJEn4Pt8ZL9/dpdnwbDjw5msM8BVO9XN/diN0I2+s83SJvU9IAAVDUKd41Hctx4V
         Bvs62eqGhUamCdxSY+gDcsKu1sUgYlwtjc9X2IXnClRzoYK51Gt16+kATIzIXRjsyG4/
         zemkhqmcLLpLl0sK5rBDNSCtv+DOLuOOdx4DjYCXB0LyTbyTYlV9xbzUJH7RE78h3VAG
         N6qA==
X-Gm-Message-State: APjAAAXi2CGdBxYnfrpw4G8ajZx/ho3q0yVi1sOg4mVEYk+qsnbw6wWb
        C02QFVNm0lqmrQlxihiTZZTWfQ==
X-Google-Smtp-Source: APXvYqzqNTakOkEnPsoegopX/B3iovgnIMRncKLxDpArAOPt2vt2u1MLYKUYkbyxu/l1WdiIgmcRMw==
X-Received: by 2002:a62:5a42:: with SMTP id o63mr7378913pfb.170.1552974649099;
        Mon, 18 Mar 2019 22:50:49 -0700 (PDT)
Received: from localhost ([122.166.134.37])
        by smtp.gmail.com with ESMTPSA id 10sm18321177pft.83.2019.03.18.22.50.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 22:50:47 -0700 (PDT)
Date:   Tue, 19 Mar 2019 11:20:44 +0530
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
Message-ID: <20190319055044.xbxr6ph5hl4zcucb@vireshk-i7>
References: <e2b56be446eeb67f1905d2ac6f8d82dd4389d0c5.1552640968.git.viresh.kumar@linaro.org>
 <CAJZ5v0jr-XJ6VbNf3ipYQuycah-GNZKLgGe5wGknkWF7bKSY2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jr-XJ6VbNf3ipYQuycah-GNZKLgGe5wGknkWF7bKSY2w@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-03-19, 12:49, Rafael J. Wysocki wrote:
> To summarize, I think that it would be sufficient to do this just for
> policy->cpu and, as Peter said, warn once if there are more CPUs in
> the policy or policy->cpu is not the CPU running this code.  And mark
> the TSC as unstable in both of these cases.

How about this ?

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 3fae23834069..4d3681cfb6e0 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -958,10 +958,13 @@ static int time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
        struct cpufreq_freqs *freq = data;
        unsigned long *lpj;
 
+       if (WARN_ON_ONCE(cpumask_weight(freq->policy->related_cpus) != 1))
+               mark_tsc_unstable("cpufreq policy has more than CPU");
+
        lpj = &boot_cpu_data.loops_per_jiffy;
 #ifdef CONFIG_SMP
        if (!(freq->flags & CPUFREQ_CONST_LOOPS))
-               lpj = &cpu_data(freq->cpu).loops_per_jiffy;
+               lpj = &cpu_data(freq->policy->cpu).loops_per_jiffy;
 #endif
 
        if (!ref_freq) {
@@ -977,7 +980,7 @@ static int time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
                if (!(freq->flags & CPUFREQ_CONST_LOOPS))
                        mark_tsc_unstable("cpufreq changes");
 
-               set_cyc2ns_scale(tsc_khz, freq->cpu, rdtsc());
+               set_cyc2ns_scale(tsc_khz, freq->policy->cpu, rdtsc());
        }
 
        return 0;
