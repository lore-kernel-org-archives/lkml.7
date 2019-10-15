Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B68C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 08:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA3A22064B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 08:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dMv5o/28"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbfJOIkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 04:40:08 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:39215 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfJOIkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 04:40:08 -0400
Received: by mail-yw1-f67.google.com with SMTP id n11so7052107ywn.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 01:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AqJilFgL4FnU7FTEYnrwYFbssjg64wIXPF6xmLsOmPw=;
        b=dMv5o/28lV5eqQ6bsstF+8kQTU23HpHM7uGA1mQx9OL8DufixiTQBhQczwb9OZFYYd
         7W3cA2GyJed1k6hXVr/2rwc3AX6DJgZ3fQkDiaw+7l1yVgu2ZIXaPzA9kX08sm87OeAM
         FHNxHoazD5b78yRw0zB7eEiE82F/JskUc7JsqDiXies4CyeBbO2EKG4DTSl32NqdhIfx
         6h7ICpf2yVbyT4NB4KWkpjk22CMGUG0adfxOhwVuaxE/drTDYt2FMC9CvUWdvcJPn64q
         H5oj5wSKb/hqXX3KhJalYdybL5MxH3ZboqDcmr0V8yvqmkIGQIMxj1j2P4/8zTvqfjOb
         zHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AqJilFgL4FnU7FTEYnrwYFbssjg64wIXPF6xmLsOmPw=;
        b=SsR7UMR26cTNVLa4Yh5ajcmLjDoNVS31qfYX55XMs+OZDJyMwVo2yhQfcm2aOOIMV1
         XWQEtJC/B5G7kgPic9LusRjkQ6Yjqp0vAIX6afvmFQzwkStR1VuF10BvDyItNSXdurdy
         gFe3gIMtYUC+vRp45PtDskuP97PujX+FkvhghFnnXFFwvi8xyfLVvqQtxlgXGJJO4xrc
         8z1X6lfBB6exvGyT9neW2XMlzkVgbEja+Bali+oxX+s1EvQn6C+xuCGfMbUSEG+E6wC8
         ASNLx4eeo+2S1tX1oLdH+IlmqlKbgL0b3RTOMkG074geKBfIAuXsaBSyl6EOlzKiVnYE
         Vgqw==
X-Gm-Message-State: APjAAAVbFqOJHXV6TldleN2+0XGsvYncZN5kDVFVlBfiJDfOev14gJ4v
        7HJLXZM+3GwbOIGA4QDytS6V3ZUTbw4PRJ2qrUTwCA==
X-Google-Smtp-Source: APXvYqzu3fgAZn0e8gU0Hx3m9VF7LBh6xTjczQQEqITtlLvVTjf0aPPLvwy/C+DdGBt9KgMh8hPRtceTv89bTUbMWlA=
X-Received: by 2002:a81:996:: with SMTP id 144mr16495099ywj.57.1571128807207;
 Tue, 15 Oct 2019 01:40:07 -0700 (PDT)
MIME-Version: 1.0
References: <20191010073055.183635-1-suleiman@google.com> <20191010073055.183635-3-suleiman@google.com>
 <2e6e5b14-fa68-67bd-1436-293659c8d92c@redhat.com>
In-Reply-To: <2e6e5b14-fa68-67bd-1436-293659c8d92c@redhat.com>
From:   Suleiman Souhlal <suleiman@google.com>
Date:   Tue, 15 Oct 2019 17:39:55 +0900
Message-ID: <CABCjUKAsO9bOW9-VW1gk0O_U=9V6Zhft8LjpcqXVbDVTvWJ5Hw@mail.gmail.com>
Subject: Re: [RFC v2 2/2] x86/kvmclock: Introduce kvm-hostclock clocksource.
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     rkrcmar@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>, sboyd@kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        kvm@vger.kernel.org, Suleiman Souhlal <ssouhlal@freebsd.org>,
        tfiga@chromium.org, Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 7:55 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 10/10/19 09:30, Suleiman Souhlal wrote:
> > +kvm_hostclock_enable(struct clocksource *cs)
> > +{
> > +     pv_timekeeper_enabled = 1;
> > +
> > +     old_vclock_mode = kvm_clock.archdata.vclock_mode;
> > +     kvm_clock.archdata.vclock_mode = VCLOCK_TSC;
> > +     return 0;
> > +}
> > +
> > +static void
> > +kvm_hostclock_disable(struct clocksource *cs)
> > +{
> > +     pv_timekeeper_enabled = 0;
> > +     kvm_clock.archdata.vclock_mode = old_vclock_mode;
> > +}
> > +
>
> Why do you poke at kvm_clock?  Instead you should add
>
>         .archdata               = { .vclock_mode = VCLOCK_TSC },
>
> to the kvm_hostclock declaration.

Yeah, what I was doing does not make sense.

> Please also check that the invariant TSC CPUID bit
> CPUID[0x80000007].EDX[8] is set before enabling this feature.

Will do.

>
> Paolo
>
> > +     pvtk = &pv_timekeeper;
> > +     do {
> > +             gen = pvtk_read_begin(pvtk);
> > +             if (!(pv_timekeeper.flags & PVCLOCK_TIMEKEEPER_ENABLED))
> > +                     return;
> > +
> > +             pvclock_copy_into_read_base(pvtk, &tk->tkr_mono,
> > +                 &pvtk->tkr_mono);
> > +             pvclock_copy_into_read_base(pvtk, &tk->tkr_raw, &pvtk->tkr_raw);
> > +
> > +             tk->xtime_sec = pvtk->xtime_sec;
> > +             tk->ktime_sec = pvtk->ktime_sec;
> > +             tk->wall_to_monotonic.tv_sec = pvtk->wall_to_monotonic_sec;
> > +             tk->wall_to_monotonic.tv_nsec = pvtk->wall_to_monotonic_nsec;
> > +             tk->offs_real = pvtk->offs_real;
> > +             tk->offs_boot = pvtk->offs_boot;
> > +             tk->offs_tai = pvtk->offs_tai;
> > +             tk->raw_sec = pvtk->raw_sec;
> > +     } while (pvtk_read_retry(pvtk, gen));
> > +}
> > +
>
> Should you write an "enabled value" (basically the flags) into pvtk as well?

I think we have that already (pvtk->flags).
I'll change the if statement above to use pvtk instead of pv_timekeeper.

> > +kvm_hostclock_init(void)
> > +{
> > +     unsigned long pa;
> > +
> > +     pa = __pa(&pv_timekeeper);
> > +     wrmsrl(MSR_KVM_TIMEKEEPER_EN, pa);
>
>
> As Vitaly said, a new CPUID bit must be defined in
> Documentation/virt/kvm/cpuid.txt, and used here.  Also please make bit 0
> an enable bit.

I think I might not be able to move the enable bit to 0 because we
need the generation count (pvclock_timekeeper.gen) to be the first
word of the struct due to the way we copy the data to userspace,
similarly to how kvm_setup_pvclock_page() does it.

I also noticed the comment in kvm_copy_into_pvtk() references the
wrong function, which I will fix in the next revision.

Thanks for the feedback.

-- Suleiman
