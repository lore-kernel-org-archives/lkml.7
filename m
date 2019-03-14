Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C450C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 068CB2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SFRcdqiV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfCNKSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 06:18:49 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35946 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbfCNKSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 06:18:48 -0400
Received: by mail-pg1-f195.google.com with SMTP id r124so3667802pgr.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 03:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ANLeUNhzxUv5KhstVY4TPE8Bh277AJYgjdhMVlSsOTM=;
        b=SFRcdqiVcfiMo4tGHSFXxYv9YwLbxKowZBeld4N5keOsA21F8ue3dzbfpOKbQUe7NG
         zxiqWJ3fgJMjIza62mGuq/Dtw8RD0LpVsVjIUwdzPcke5TPED0rPSXAzSjVvb7zQ9vg/
         na58EX7/QmT7pR09tNBgZFAwOSlyfq6jDZEBbAC/UMqSdNtOBKlLvxQ2GzCZTA4mH+0q
         JRTFOdwnxmYhB+M3YyT90N+Syt72aZdwG6TpVvrAx6HifJ2o3h/hA5wYBwAHaWmZEVnB
         jrvVsm9c6tbx5suzWEfAm4J6rTTGpiuOoKmBDzzW4Z4ub5w7zUKiquuERY1uj/qR29vD
         DLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ANLeUNhzxUv5KhstVY4TPE8Bh277AJYgjdhMVlSsOTM=;
        b=YOoDmFT4Bj42NJ3iUJbnzf5cozvvX2DF9R3jTnMutaKEf0YAppu/XGbfQiklHx/43D
         POe3GOUbrCzcB6Io6PtkpCzKJF6uh9wpazbL45VaZI5/PhP7WrOsJ9CgEQWJVs9cepii
         8jNK7vGCJER550nC+tGodHzWNS9ZuZHUuzxUuTqgvZjPdH4Mr640ZAQRFSB3WmhTyIss
         ehQJnmg63KV3hbzZaT2gh8HaLooCgBRbXwza+Un3I3iAGuG9R675CYgQEsltYrgwSR1F
         e2keLQGNV84JytYEVdlZ5vrgyXHc+MB+zg5e8PyyMGoMce5XMuxkIF4wGGquyt3kIsBS
         fCxw==
X-Gm-Message-State: APjAAAVVg+UyTlTh3NeB3tK9rXPFq7Vxzpf+N3RwyjTMwHiWK5YAlJrs
        49DB5mB8I5zj6y8z46dlsBfH0A==
X-Google-Smtp-Source: APXvYqwaKtU8EWWtkOXl9jmUjNuXMKff8g7OBcA7D8msqlFJLINjgPD1Uwq54W7Vcpi0eywzZViAxQ==
X-Received: by 2002:a62:5543:: with SMTP id j64mr48575497pfb.105.1552558727675;
        Thu, 14 Mar 2019 03:18:47 -0700 (PDT)
Received: from localhost ([122.166.134.37])
        by smtp.gmail.com with ESMTPSA id h126sm40427553pfc.135.2019.03.14.03.18.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 03:18:46 -0700 (PDT)
Date:   Thu, 14 Mar 2019 15:48:44 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kvm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH 0/7] cpufreq: Call transition notifier only once for each
 policy
Message-ID: <20190314101844.2q7nlxukxjyrwvv5@vireshk-i7>
References: <cover.1552545525.git.viresh.kumar@linaro.org>
 <CAJZ5v0gER+aJaQmk89VSVBtHgQ+WPDdAxUW6eJ4JCB=emC85dg@mail.gmail.com>
 <CAJZ5v0izRO4zmc-TovmZBjWa+Or0oN89Ny8rdxf=81ogMJM4oQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0izRO4zmc-TovmZBjWa+Or0oN89Ny8rdxf=81ogMJM4oQ@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-03-19, 10:40, Rafael J. Wysocki wrote:
> On Thu, Mar 14, 2019 at 10:28 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Mar 14, 2019 at 7:43 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > Currently we call the cpufreq transition notifiers once for each CPU of
> > > the policy->cpus cpumask, which isn't that efficient.
> >
> > Why isn't it efficient?
> >
> > Transitions are per-policy anyway, so if something needs to be done
> > for each CPU in the policy, it doesn't matter too much which part of
> > the code carries out the iteration.
> >
> > I guess some notifiers need to know what other CPUs there are in the
> > policy?  If so, then why?
> >
> > > This patchset tries to simplify that by adding another field in struct cpufreq_freqs,
> > > cpus, so the callback has all the information available with a single
> > > call for each policy.
> >
> > Well, you can argue that the core is simplified by it somewhat, but
> > the notifiers aren't.  They actually get more complex, conceptually
> > too, because they now need to worry about offline vs online CPUs etc.
> >
> > Also I wonder why you decided to pass a cpumask in freqs instead of
> > just passing a policy pointer.  If you change things from per-CPU to
> > per-policy, passing the whole policy seems more natural.
> 
> It also looks to me like all that needs to be one patch, or you have
> the ugly transition situation in which notifiers are still invoked for
> each CPU, but they assume to be invoked once per policy.

I assumed that calling something like set_cyc2ns_scale() in x86
multiple times for each CPU shouldn't be that bad even if the
frequency changes only once, but such things may actually have
side-effects. I should merged them all.

-- 
viresh
