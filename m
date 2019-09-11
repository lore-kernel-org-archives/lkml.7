Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B44ECDE27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 08:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDEED21A4C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 08:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfIKIRM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 04:17:12 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33616 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbfIKIRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 04:17:11 -0400
Received: by mail-qt1-f193.google.com with SMTP id r5so24249660qtd.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 01:17:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sSX4It+UYh+SclLrqRYTuJcNxBVNhdLE6sMCo8UKYag=;
        b=odps4wedpHvykTEEpCP7BgBlMXQhWcBKuQaJ/BZI/OtolWazZZSfRod1coAZN5Miyu
         92qu3ihv5bzSPrT1+c14iAki4Tvm9jAMjXula/a7CbmV9mlkliNXNoiynrBuJC+Y8fcV
         /XiBssc2T/h4jNgnnqUoAUT6f6DF8IslUVuKpGoV6f51F/LNy2FdN6jPpL9/W2m3c+Co
         /lbEbeK2I0f8NRddzp1PsTWgY5Uhxm48Atflhyx6HJphd9DuHpUl6+HCYqSTDlxGAjOX
         ZYCLnSXXVR64c8Q5OyJccBJPrais8BRGi+SjWBPyjxtxJzKA8tspc4cMVSMlx3V3q3lN
         XWHA==
X-Gm-Message-State: APjAAAWZaOByvphZ7rpqFMKSx+sEMGJmxRHi7/d/7k7pGU1QcGqcxUb3
        LfvpnSRCeFRW2ufvhoFnyV2uspsPcK9BXYs0SFQ=
X-Google-Smtp-Source: APXvYqz45pgoTmTVL0lx/QE8rf/L0T6m/MIjRIXLqE3v8w3FYXI3PhfhiwrwjKmjULONteqaD1CGPmWyYRZFxNBlgK4=
X-Received: by 2002:ac8:342a:: with SMTP id u39mr33940011qtb.7.1568189830279;
 Wed, 11 Sep 2019 01:17:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190905054647.1235-1-james.tai@realtek.com> <CAK8P3a13=VBZnj6E=s7mZk0o7Q3XkMHgcsL12s-3psuOWsfOtQ@mail.gmail.com>
 <43B123F21A8CFE44A9641C099E4196FFCF8DA1D0@RTITMBSVM04.realtek.com.tw>
In-Reply-To: <43B123F21A8CFE44A9641C099E4196FFCF8DA1D0@RTITMBSVM04.realtek.com.tw>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 11 Sep 2019 10:16:53 +0200
Message-ID: <CAK8P3a39VrC1Xn+HZc5gvh1-nUYKywDGjTfO9WPCqim89WtGAg@mail.gmail.com>
Subject: Re: [PATCH] ARM: Add support for Realtek SOC
To:     =?UTF-8?B?SmFtZXMgVGFpW+aItOW/l+WzsF0=?= <james.tai@realtek.com>
Cc:     "jamestai.sky@gmail.com" <jamestai.sky@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Burton <paul.burton@mips.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Doug Anderson <armlinux@m.disordat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stefan Agner <stefan@agner.ch>,
        Nicolas Pitre <nico@fluxnic.net>,
        Thierry Reding <treding@nvidia.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?B?Q1lfSHVhbmdb6buD6Ymm5pmPXQ==?= <cy.huang@realtek.com>,
        Phinex Hung <phinex@realtek.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 9:46 AM James Tai[戴志峰] <james.tai@realtek.com> wrote:
> > Subject: Re: [PATCH] ARM: Add support for Realtek SOC

> > > @@ -148,6 +148,7 @@ endif
> > >  textofs-$(CONFIG_ARCH_MSM8X60) := 0x00208000
> > >  textofs-$(CONFIG_ARCH_MSM8960) := 0x00208000
> > >  textofs-$(CONFIG_ARCH_MESON) := 0x00208000
> > > +textofs-$(CONFIG_ARCH_REALTEK) := 0x00208000
> > >  textofs-$(CONFIG_ARCH_AXXIA) := 0x00308000
> >
> > Can you explain why this is needed for your platform?
> >
> We need to reserve memory (0x00000000 ~ 0x001B0000) for rom and boot code.

Ok.

> > > +config ARCH_RTD16XX
> > > +       bool "Enable support for RTD1619"
> > > +       depends on ARCH_REALTEK
> > > +       select ARM_GIC_V3
> > > +       select ARM_PSCI
> >
> > As I understand, this chip uses a Cortex-A55. What is the reason for adding
> > support only to the 32-bit ARM architecture rather than 64-bit?
>
> The RTD16XX platform also support the 64-bit ARM architecture.
> I will add the 64-bit ARM architecture in new version patch.
>
> > Most 64-bit SoCs are only supported with arch/arm64, but generally speaking
> > that is not a requirement. My rule of thumb is that on systems with 1GB of
> > RAM or more, one would want to run a 64-bit kernel, while systems with less
> > than that are better off with a 32-bit one, but that is clearly not the only reason
> > for picking one over the other.
> >
> Support 32-bit ARM architecture is for application compatibility.

Generally speaking, a 64-bit kernel should work better on 64-bit hardware
even when you are running mostly 32-bit applications. However, you may
have device drivers that do not correctly set compat_ioctl handlers.

As I said, it's no problem to allow both, just explain this in the
changelog text for the driver, along with the need for the textofs
setting.

> > It's very unusual to see custom smp operations on an ARMv8 system, as we
> > normally use PSCI here. Can you explain what is going on here? Are you able to
> > use a boot wrapper that implements these in psci instead?
> >
> The smp operations is porting form other Realtek platform.
>
> Currently, The RTD16XX platform can use the PSCI method.
> I will add PSCI method in new version patch.

Ok, perfect!

> > > +       timer_probe();
> > > +       tick_setup_hrtimer_broadcast(); }
> >
> > What do you need tick_setup_hrtimer_broadcast() for? I don't see any other
> > platform calling this.
> >
> I want to initialize the HR timer.

I'm still unsure about this one. My feeling is that it should not be
in the platform
code, but I don't quite understand which hardware needs it. I see that
Lorenzo Pieralisi added the same code to arm64 in commit 9358d755bd5c
("arm64: kernel: initialize broadcast hrtimer based clock event device"),
but nothing ever calls it on 32-bit arch/arm even though the code does
get built in to the kernel.

My feeling is that either you don't really need it, or this is something
that other platforms should really do as well, and it should be called from
the generic time_init() function in arch/arm/kernel/time.c instead.

Can you try to find out more of the background here, and then
move the call to time_init() assuming it is indeed useful?

       Arnd
