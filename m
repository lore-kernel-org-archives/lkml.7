Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F3DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 09:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B7A2190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 09:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553248572;
	bh=afa2nvnyHWP8+3FySA0JVnwQVrQ+UqIMEl/R1ucrSAE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=q9GYDFU7OqfjOQ8Vo5/HdHj/9c9mP35hxXGOvGSe4Cj85jfWVYunT4gsM8xwmcX1G
	 +rrWWknV2Ja0Jose8nVnU2qDIBWZ8e9uDXFop+auUsEqrAPIKcOkVMuwkF3XlhL63N
	 kVpGQiP4qEWIXNLwfxJjtMFGw0RKtXhHhpZRGShQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbfCVJ4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 05:56:11 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43505 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbfCVJ4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 05:56:11 -0400
Received: by mail-oi1-f193.google.com with SMTP id 67so1242296oif.10;
        Fri, 22 Mar 2019 02:56:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R769lZEppttus9KqpwL+hUjXXVn/tU1JC7ZECyzBamc=;
        b=tccTtVworl4Kduy/7XS93kLHH1cxVaa0wGCNH30p4Ne0JWVoMBavBVvIam/SmbwoIv
         9LRjBzJ8CcnEjYCL5KD5QPqrhrDAu9+4FrohqiVq5NHf4t/exyJ3ND/BibDFgK2CDucN
         gZVBZ1bQxgNsUEMjkmXj8DQB923XI2W4Zu9+rf7wYZ4dm0nx8E64nbm0Zvf54lw3FnVM
         HG4ztqkstVc7PU7/fTR7/KM7VPLnyKaVV4PKUcyfZeGANvqZpBe7lfqvzjC21u7LMb1O
         ftNGikxBK44KE9wbHg1g217zlMGeJ3jXKyGMVqwufsmBfhXKWfbFqQ7yq3oERN2q/U3T
         zD+A==
X-Gm-Message-State: APjAAAXyP2hBS0lUHn+o1zl1B+anO7S644UIKibBBAxE5Jj7majnyQot
        6lUgaBm2/ppyvN6F1LMSpguKcZ2qLzfsHjPLXK8=
X-Google-Smtp-Source: APXvYqzfYWEJ9k1BlLeuYHyhGI8XIj2c5DvqpphS6zVQFJIHX5sO4ZexCNDvS1JR5BgncxePxdpvZwhzD60J6/IIFOE=
X-Received: by 2002:aca:8d3:: with SMTP id 202mr1242844oii.76.1553248570097;
 Fri, 22 Mar 2019 02:56:10 -0700 (PDT)
MIME-Version: 1.0
References: <1eb27e3bbcbb2c67e6eadc0893c9b41e5d76894b.1553057341.git.viresh.kumar@linaro.org>
 <alpine.DEB.2.21.1903211645100.1784@nanos.tec.linutronix.de> <20190322062744.efpl4itnqtny7txf@vireshk-i7>
In-Reply-To: <20190322062744.efpl4itnqtny7txf@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Mar 2019 10:55:59 +0100
Message-ID: <CAJZ5v0jN-TqFSXRweqhv8rnJni1r8awMjiAVNbn3RuBhLS1yvA@mail.gmail.com>
Subject: Re: [PATCH V3] cpufreq: Call transition notifier only once for each policy
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
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

On Fri, Mar 22, 2019 at 7:28 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 21-03-19, 16:49, Thomas Gleixner wrote:
> > On Wed, 20 Mar 2019, Viresh Kumar wrote:
> > >
> > > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > > index 3fae23834069..b2fe665878f7 100644
> > > --- a/arch/x86/kernel/tsc.c
> > > +++ b/arch/x86/kernel/tsc.c
> > > @@ -958,10 +958,15 @@ static int time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
> > >     struct cpufreq_freqs *freq = data;
> > >     unsigned long *lpj;
> > >
> > > +   if (WARN_ON_ONCE(cpumask_weight(freq->policy->related_cpus) != 1)) {
> > > +           mark_tsc_unstable("cpufreq changes: related CPUs affected");
> > > +           return 0;
> > > +   }
> >
> > You might add a check which ensures that policy->cpu == smp_processor_id()
> > because if this is not the case ....
>
> How about something like this ?
>
>         if (WARN_ON_ONCE(cpumask_weight(freq->policy->related_cpus) != 1 ||
>                          freq->policy->cpu != smp_processor_id())) {
>                 mark_tsc_unstable("cpufreq changes: related CPUs affected");
>                 return 0;
>         }
>
>
> Thanks for your feedback.

Peter suggested something like this IIRC.

Anyway, I'm still concerned that this approach in general
fundamentally doesn't work on SMP with frequency synchronization,
which is the case for the platforms affected by the problem it
attempts to overcome.

The frequency has just been changed on one CPU, presumably to the
requested value (so this cannot work when turbo is enabled anyway),
but then it also has changed for all of the other CPUs in the system
(or at least in the package), so it is not sufficient to update the
single CPU here as it is only a messenger, so to speak.  However,
updating the other CPUs from here would be fundamentally racy AFAICS.
