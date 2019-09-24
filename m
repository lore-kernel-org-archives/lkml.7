Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AADBC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 11:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2730C214D9
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 11:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409581AbfIXLOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 07:14:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44972 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408253AbfIXLOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 07:14:39 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2B58B3DE0F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 11:14:38 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id o188so786242wmo.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 04:14:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ZdoM44ufwDkWEhL4uEThga8TobA9sHKPa7iHd5/kxt0=;
        b=OgBO5NVF7F/lzy2csv9dDN3oeIgYC1z+DEK5mlW1aQIDPN31yz5Y+EpFIBGAcPv9nI
         DAp0bYEwqXw99FLjNnHS9fDuxFuM8QUlIp+6yyKqAOxaUL92PWGTrGEHkiy9Xq44f8qG
         vsbfl3Bd5RXfwOw+yUlzgPvNxWbRS4/RVgw+jANPxw0/ELDaA4CDY1xoApkPYSL9c/xj
         HL1mUThmSGXOhp6WJjHEQ/4psps5kDR5DgpJUJnSHKrIy5yuQiZ9MoFT6hRXvVENc62H
         AQzYx+P6P8gQ/9fOGP0fLRmtmj4LcPq/xqcJsdwF9hKmHFWIix6awDo1wB6pN+fBTAVA
         2A+Q==
X-Gm-Message-State: APjAAAUZzS2nWnXOeTeiqv6mVzRAmwAslO7GNxQVriyh9TAKhpA10MkO
        AwGhkWM9hIQyG4P8x6LRVPmsmFgrycHFlmUX5XRvCMnSal1GJF305693qYELHWutJnQwUMvN5S4
        JVHFfegNC9M87EjeiZpfp1bGt
X-Received: by 2002:adf:8444:: with SMTP id 62mr1828114wrf.202.1569323676842;
        Tue, 24 Sep 2019 04:14:36 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwJh41RD/VBo8haBgTH86yUTbGiVKEXV1JDna/o+beXlpMs9ip/EXIL9i2ajRjTs5I33Y5p/g==
X-Received: by 2002:adf:8444:: with SMTP id 62mr1828095wrf.202.1569323676581;
        Tue, 24 Sep 2019 04:14:36 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id s9sm1073218wme.36.2019.09.24.04.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 04:14:35 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Suleiman Souhlal <suleiman@google.com>
Cc:     John Stultz <john.stultz@linaro.org>, sboyd@kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        rkrcmar@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        Tomasz Figa <tfiga@google.com>
Subject: Re: [RFC 2/2] x86/kvmclock: Use host timekeeping.
In-Reply-To: <CABCjUKDPa1wrvp5zrjCa0tAQUO5UuFNgc00Z5kt_7rgakjApDw@mail.gmail.com>
References: <20190920062713.78503-1-suleiman@google.com> <20190920062713.78503-3-suleiman@google.com> <87woe38538.fsf@vitty.brq.redhat.com> <CABCjUKDPa1wrvp5zrjCa0tAQUO5UuFNgc00Z5kt_7rgakjApDw@mail.gmail.com>
Date:   Tue, 24 Sep 2019 13:14:35 +0200
Message-ID: <87ftkm7xpg.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suleiman Souhlal <suleiman@google.com> writes:

> On Fri, Sep 20, 2019 at 10:33 PM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>>
>> Suleiman Souhlal <suleiman@google.com> writes:
>>
>> > When CONFIG_KVMCLOCK_HOST_TIMEKEEPING is enabled, and the host
>> > supports it, update our timekeeping parameters to be the same as
>> > the host. This lets us have our time synchronized with the host's,
>> > even in the presence of host NTP or suspend.
>> >
>> > When enabled, kvmclock uses raw tsc instead of pvclock.
>> >
>> > When enabled, syscalls that can change time, such as settimeofday(2)
>> > or adj_timex(2) are disabled in the guest.
>> >
>> > Signed-off-by: Suleiman Souhlal <suleiman@google.com>
>> > ---
>> >  arch/x86/Kconfig                |   9 +++
>> >  arch/x86/include/asm/kvmclock.h |   2 +
>> >  arch/x86/kernel/kvmclock.c      | 127 +++++++++++++++++++++++++++++++-
>> >  kernel/time/timekeeping.c       |  21 ++++++
>> >  4 files changed, 155 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> > index 4195f44c6a09..37299377d9d7 100644
>> > --- a/arch/x86/Kconfig
>> > +++ b/arch/x86/Kconfig
>> > @@ -837,6 +837,15 @@ config PARAVIRT_TIME_ACCOUNTING
>> >  config PARAVIRT_CLOCK
>> >       bool
>> >
>> > +config KVMCLOCK_HOST_TIMEKEEPING
>> > +     bool "kvmclock uses host timekeeping"
>> > +     depends on KVM_GUEST
>> > +     ---help---
>> > +       Select this option to make the guest use the same timekeeping
>> > +       parameters as the host. This means that time will be almost
>> > +       exactly the same between the two. Only works if the host uses "tsc"
>> > +       clocksource.
>> > +
>>
>> I'd also like to speak up against this config, it is confusing. In case
>> the goal is to come up with a TSC-based clock for guests which will
>> return the same as clock_gettime() on the host (or, is the goal to just
>> have the same reading for all guests on the host?) I'd suggest we create
>> a separate (from KVMCLOCK) clocksource (mirroring host timekeeper) and
>> guests will be free to pick the one they like.
>
> Fair enough. I'll do that in the next version of the patch.
>
> The goal is to have a guest clock that gives the same
> clock_gettime(CLOCK_MONOTONIC) as the host.
>

KVMCLOCK has lots of legacy derived from times when TSC synchronization
was not a given (I heard that this is still sometimes problematic with
multi-socket systems but oh well). If I was to design a new clock I'd
probably mirror Hyper-V's TSC page clocksource invalidating the page
when host timekeeper values are updated (and making guest spin).

The tricky part with this approach is probably tsc scaling/tsc
offsetting which is still going to be controlled by kvmclock (so the
guest has no option to read 'pure TSC'). As an alternative, you can make
kvmclock un-pluggable so when it's not enabled TSC frequency/offset can
remain intact. You can, of course, try to update timekeeper values to
match the new frequency/offset every time they change but rounding
errors may bite.

-- 
Vitaly
