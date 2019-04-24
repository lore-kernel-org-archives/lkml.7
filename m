Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B404C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19B4220656
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556090825;
	bh=KaDBoJJjYnObOploCwYXMgY0kxZJHH/0nJJXTWbCmsc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dZH9TyOWAPWGxtHbPzl+R1nAPkFfcJRk/5GNXkSzZ/reCWfewI/iwtTMk+eQtNxs1
	 3YDSFIRBnc1PG6+djFmp3Dt6vVG0hgMfozVB71xHFTxOV/j8cpjb1YSBZgSdjS5PlK
	 RcWrtPbvMKPVTUG4usW2LegJqxModRw1rSX7PPow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbfDXH1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 03:27:04 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39876 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbfDXH1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 03:27:03 -0400
Received: by mail-ot1-f66.google.com with SMTP id o39so2148100ota.6;
        Wed, 24 Apr 2019 00:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uLNO+ALEpjn7XZDs/HjjZU+KRBu1qko3HM25uVzxfDc=;
        b=JeU2jpjdH39HRV65RHPbmDfp+dSthy++iJVk9q+eBh/E9V2cLNQoCtQzWeZAxdWbYI
         5aJD3fvbdBaSrjKu2ptCCBXDsgnfrZS7sGrFGgXKofM3Z5qNnKUQepiv7fPGnaoIddKK
         hoBsPS3AfEXkQDCCa8lo+R1kmHPMcQC80odliONjzpFHGH3GubRwTW3rb6Aiqpkoac4k
         HaTP8N5FNqYM1pv7idT6hw9hMrf9MWBaLYaoplzXKgjomf7ZLcmxzNRnAqbSnublWgjw
         Rnox7H7aoWflwARusVRTva0WA3qsj7KbhgHeVtn/e9Y6XExi4iTSTef4Q1iH38Xpsa3q
         FDSA==
X-Gm-Message-State: APjAAAWHnwDB5VaBYQVU5aURJmoW8d1/AVMwoX2CwuMCN0YmYdv/NQZ+
        hLAjtrAGU1lod4LldLVJzkwh1IRmvTBewVEOFVwmqQ==
X-Google-Smtp-Source: APXvYqxyJrPNyV1aF82bL58Ait5kA70e7vPVXRilnf06niz6tAVSDHy39L3jZG3x8lr63UeZyYjasO/vFmrE+ISSHf4=
X-Received: by 2002:a9d:7a50:: with SMTP id z16mr17331301otm.363.1556090822516;
 Wed, 24 Apr 2019 00:27:02 -0700 (PDT)
MIME-Version: 1.0
References: <1eb27e3bbcbb2c67e6eadc0893c9b41e5d76894b.1553057341.git.viresh.kumar@linaro.org>
 <20190321114535.GM6058@hirez.programming.kicks-ass.net> <20190322061957.hzhnlbmnkpuqviiv@vireshk-i7>
 <20190424064753.lwfsdeodncaai5oz@vireshk-i7>
In-Reply-To: <20190424064753.lwfsdeodncaai5oz@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 Apr 2019 09:26:50 +0200
Message-ID: <CAJZ5v0jGofnUFKaM5-pRsZAiiQFumGGij8TE=SyX8DT8CUatQg@mail.gmail.com>
Subject: Re: [PATCH V3] cpufreq: Call transition notifier only once for each policy
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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

On Wed, Apr 24, 2019 at 8:48 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 22-03-19, 11:49, Viresh Kumar wrote:
> > On 21-03-19, 12:45, Peter Zijlstra wrote:
> > > On Wed, Mar 20, 2019 at 10:22:23AM +0530, Viresh Kumar wrote:
>
> > > > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > > > index 65e4559eef2f..1ac8c710cccc 100644
> > > > --- a/arch/x86/kvm/x86.c
> > > > +++ b/arch/x86/kvm/x86.c
> > > > @@ -6649,10 +6649,8 @@ static void kvm_hyperv_tsc_notifier(void)
> > > >  }
> > > >  #endif
> > > >
> > > > -static int kvmclock_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
> > > > -                              void *data)
> > > > +static void __kvmclock_cpufreq_notifier(struct cpufreq_freqs *freq, int cpu)
> > > >  {
> > > > - struct cpufreq_freqs *freq = data;
> > > >   struct kvm *kvm;
> > > >   struct kvm_vcpu *vcpu;
> > > >   int i, send_ipi = 0;
> > > > @@ -6696,17 +6694,12 @@ static int kvmclock_cpufreq_notifier(struct notifier_block *nb, unsigned long va
> > > >    *
> > > >    */
> > > >
> > > > - if (val == CPUFREQ_PRECHANGE && freq->old > freq->new)
> > > > -         return 0;
> > > > - if (val == CPUFREQ_POSTCHANGE && freq->old < freq->new)
> > > > -         return 0;
> > > > -
> > > > - smp_call_function_single(freq->cpu, tsc_khz_changed, freq, 1);
> > > > + smp_call_function_single(cpu, tsc_khz_changed, freq, 1);
> > > >
> > > >   spin_lock(&kvm_lock);
> > > >   list_for_each_entry(kvm, &vm_list, vm_list) {
> > > >           kvm_for_each_vcpu(i, vcpu, kvm) {
> > > > -                 if (vcpu->cpu != freq->cpu)
> > > > +                 if (vcpu->cpu != cpu)
> > > >                           continue;
> > > >                   kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
> > > >                   if (vcpu->cpu != smp_processor_id())
> > > > @@ -6728,8 +6721,24 @@ static int kvmclock_cpufreq_notifier(struct notifier_block *nb, unsigned long va
> > > >            * guest context is entered kvmclock will be updated,
> > > >            * so the guest will not see stale values.
> > > >            */
> > > > -         smp_call_function_single(freq->cpu, tsc_khz_changed, freq, 1);
> > > > +         smp_call_function_single(cpu, tsc_khz_changed, freq, 1);
> > > >   }
> > > > +}
> > > > +
> > > > +static int kvmclock_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
> > > > +                              void *data)
> > > > +{
> > > > + struct cpufreq_freqs *freq = data;
> > > > + int cpu;
> > > > +
> > > > + if (val == CPUFREQ_PRECHANGE && freq->old > freq->new)
> > > > +         return 0;
> > > > + if (val == CPUFREQ_POSTCHANGE && freq->old < freq->new)
> > > > +         return 0;
> > > > +
> > > > + for_each_cpu(cpu, freq->policy->cpus)
> > > > +         __kvmclock_cpufreq_notifier(freq, cpu);
> > > > +
> > > >   return 0;
> > > >  }
> > > >
> > >
> > > Then why to we pretend otherwise here?
> >
> > My intention was to not add any bug here because of lack of my
> > knowledge of the architecture in question and so I tried to be safe.
> >
> > If you guys think the behavior should be same here as of the tsc, then
> > we can add similar checks here.
>
> I am rebasing this patch over Rafael's patch [1] and wondering if I
> should change anything here.

I guess please repost when my patch makes it into linux-next.

> [1] https://lore.kernel.org/lkml/38900622.ao2n2t5aPS@kreacher/
