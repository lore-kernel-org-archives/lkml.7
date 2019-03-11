Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08481C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D13FD214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbfCKU7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:59:15 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36634 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfCKU7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 16:59:14 -0400
Received: by mail-qt1-f196.google.com with SMTP id b3so216514qtj.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 13:59:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=joFaR78DHCL1tgJBLek+bVJOh7TncAG/dejcR7SsEV8=;
        b=KYiKOjMiKfJl8oyOc5AfRW2Q9QAc7wF1yfAYDk82JG/29xCDi4tkdzrOf4Wk3M15ap
         tCO0CgIG/arV2TG0Vut2dho8CwdT+2KUSuQ3FHKg7F34FdJf2jhe6W+0LSyyPYG04UtN
         vQpgjqJ/qvUnySM+XBztKfScFtd13AmnOYfPkcuevhXGKOedNHLE1Kx+LuHg4NKqN/oS
         n6lfijkQYrDvyYQMabgfPeIklKBr3b88BPGmYtUNVEIeMKu5VmNZXP3ErDbDI0kqicSB
         xpNK/55p/kZdfcmGEeUCBHkN5OTWURigW1yZzMLyziRoxBzFBn+vqgX5AR478EkW/py3
         iVZQ==
X-Gm-Message-State: APjAAAU6Ha4ND55JH7cROtKGuTncluT6n5okzkg0DJcnxhQcOTKw36Ve
        ttjDYDhbM0i3nw7PWt3j1GKz2T6KPYA4xvdS/is=
X-Google-Smtp-Source: APXvYqxHPmSH3YNUPm92hk7m0r5Ew58SFKfmughZBfCE8Jyeut2w3Ec+a+hL/xE/MZ2RuWEV9XBM0cuMWZ+ttqgJuCQ=
X-Received: by 2002:ac8:2bcf:: with SMTP id n15mr26261515qtn.96.1552337953350;
 Mon, 11 Mar 2019 13:59:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190307091514.2489338-1-arnd@arndb.de> <20190307091514.2489338-2-arnd@arndb.de>
 <CAKwvOdk=9j2HvtWOpdOEw9sm0Nh2oU3c1c6+hJJ5WMweAM=4EQ@mail.gmail.com>
 <20190307234850.nsbpkfcit3lnmytu@shell.armlinux.org.uk> <CAKv+Gu9VM2Vs3Q8+bPLsnt08dOmba6j54gnhiHkk=AHRzG8tVA@mail.gmail.com>
 <20190308095308.hjjrzdp4fzbbtnnv@shell.armlinux.org.uk> <CAKv+Gu_szWgw-KJASLYGJ6hJXh5K8WxnUn+UQkm7jUup=rqG6w@mail.gmail.com>
 <20190308103429.ycasmpt6tcpsoqps@shell.armlinux.org.uk> <CAKv+Gu_9=G3U6Yaw8fLfTP3QT38WdwrFaC-BqLTCr2NihWA2ZA@mail.gmail.com>
 <20190308105835.tovswk5rwxusmxdu@shell.armlinux.org.uk> <CAKv+Gu-Od+hBosThTWFooz9FMKnu3g0oNh_2hmidetbB-_YyjQ@mail.gmail.com>
 <CAK8P3a1ECw_g1AqsVavD8hhVEGqNk6Kcx_U0L=0d29eu561NhA@mail.gmail.com>
 <CAKv+Gu8qgsnPV=uWR2jkJ5bsYihekkEvWNuw4whLdLrbBa7gnA@mail.gmail.com>
 <CAK8P3a0QCgLbXpztUQXAhWLp=ArJUqmtcuXNZUeXZBH+N1QeaA@mail.gmail.com> <CAKv+Gu__jgnm00ou+3FsqRBZWeDFy5Qi+1eiXeMKqc+hVSXomg@mail.gmail.com>
In-Reply-To: <CAKv+Gu__jgnm00ou+3FsqRBZWeDFy5Qi+1eiXeMKqc+hVSXomg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 11 Mar 2019 21:58:55 +0100
Message-ID: <CAK8P3a2Rr1_+m245cBhS6EkKm9-ZgfVDNB0x-=RNJ3KrGEWBpQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: futex: make futex_detect_cmpxchg more reliable
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Mikael Pettersson <mikpelinux@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Martin <Dave.Martin@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 5:36 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Mon, 11 Mar 2019 at 17:30, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Mon, Mar 11, 2019 at 3:36 PM Ard Biesheuvel
> > <ard.biesheuvel@linaro.org> wrote:
> > > On Mon, 11 Mar 2019 at 15:34, Arnd Bergmann <arnd@arndb.de> wrote:
> > > > On Fri, Mar 8, 2019 at 12:56 PM Ard Biesheuvel
> > > > <ard.biesheuvel@linaro.org> wrote:
> > > > > On Fri, 8 Mar 2019 at 11:58, Russell King - ARM Linux admin <linux@armlinux.org.uk> wrote:
> > > > > > On Fri, Mar 08, 2019 at 11:45:21AM +0100, Ard Biesheuvel wrote:
> > > >
> > > > My first attempt (before finding the original patch from Mikael Pettersson)
> > > > was to change the probe to pass '1' as the value instead of '0', that
> > > > worked fine.
> > > >
> > >
> > > Which probe is that?
> >
> > diff --git a/kernel/futex.c b/kernel/futex.c
> > index c3b73b0311bc..19615ad3c4f7 100644
> > --- a/kernel/futex.c
> > +++ b/kernel/futex.c
> > @@ -3864,7 +3864,7 @@ static void __init futex_detect_cmpxchg(void)
> >          * implementation, the non-functional ones will return
> >          * -ENOSYS.
> >          */
> > -       if (cmpxchg_futex_value_locked(&curval, NULL, 0, 0) == -EFAULT)
> > +       if (cmpxchg_futex_value_locked(&curval, NULL, 1, 1) == -EFAULT)
> >                 futex_cmpxchg_enabled = 1;
> >  #endif
> >  }
> >
>
> Ah ok.
>
> That explains a lot.
>
> Can't we just return -EFAULT if uaddr is NULL? Or does that defeat this check?

I think that would work here, it would just create a tiny overhead
for each call to futex_atomic_cmpxchg_inatomic().

Semi-related side note:
After I looked at access_ok() for a bit too long, I tried replacing it with

#define access_ok(addr, size) \
       (((u64)(uintptr_t)addr + (u64)(size_t)size) >=
current_thread_info()->addr_limit)

which interestingly seemed to improve the output with clang (it lets it
combine multiple access_ok() checks and schedule the instructions better,
compared to our inline asm implementation), but it unfortunately creates
horrible code with gcc.

      Arnd
