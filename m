Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1750C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2A55206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="tfr/uVyr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbfDPKHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:07:02 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:50218 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729021AbfDPKHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 06:07:01 -0400
Received: by mail-it1-f196.google.com with SMTP id q14so16996568itk.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 03:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JfxQpTeangtvJmLNkghjPnU5kjVKhb0JwW+LToQ2xBg=;
        b=tfr/uVyrVBNlvJx6haL1gHhA01QPEKTA7Q0s2+6QvoeCrAR8woRbyVnFYoL6KRLfO8
         WtCMNOGHTS242HbuaKRQdzgpXfu0Ne3IC47ssE1ChL9tOV2xp1YAy5sb9Dmk3JxWo9Gc
         PmdrCCyltvzliVbpq1sWTUeVyXBSbpVYIPV6YfVC9A/U7tt8mKPafv60PfS/6UJvHrzW
         2EvcptaZ4/Qn2SqF82XnRcZl28xJqj44gepa5kPwwyyUS0jrHfwAtbclYesNLM+WcE9Y
         ChVavP8Tv2vKD1dwlSWRp/LRX93BkB6QpJjnUNmCRZw+4iRuSAF2eKhcYoy5pJFlRWzn
         fhdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JfxQpTeangtvJmLNkghjPnU5kjVKhb0JwW+LToQ2xBg=;
        b=bDbhjVHM+tPy941Y2ACa6BAeh7zgsW3uk/3JwHPCzAI4Z1HFKO1MWaCa24huwsT0Lg
         Rf7uqkKoD8HtVaN/CXbhx6KcHaNnfOVxialCPSgWWbT9T1rff8nPFOdEDSLUvnKiXn5P
         rw9waviCdTIVD+0mP0iKHik/35QJOnirry3Mw7kbD0Y7THxKjFvP8sr58h+K+uLOGfPQ
         zYAY0NXy+W63ewVbRmWq6ACe1bPDYP0fl8GFxshZv8xf+O/lt7rmKXn1oNR0FVZdqfuL
         yRHGjyTmTyvAGsbqO4lNK2M7vTG3bHQRJ1GuQ+DxJ2Q+44mEkC45mRKejjlN04P27FqQ
         tfbg==
X-Gm-Message-State: APjAAAV1AgptgpgUf/u4vQQzbUu1Fo7jKhxawWpb2XA2KWwg/eo4C89I
        l+ufRi9EyQq805wlCnn2UFhBUrxZ7630TC9ltllcEw==
X-Google-Smtp-Source: APXvYqxXyOiwsO2JmYFGWBTzssC8YJdTLeOy/xhq0mBAcbJCZ1PtZBNfO/zaO8loERglkgLjfJN/GA2bkXnlN630oUI=
X-Received: by 2002:a24:ad2:: with SMTP id 201mr27583448itw.26.1555409220984;
 Tue, 16 Apr 2019 03:07:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190318122901.7231-1-brgl@bgdev.pl> <20190318122901.7231-2-brgl@bgdev.pl>
 <CAK8P3a0EhCRH7O87WSyfHujomQ_Dzz3=BT0SaXF-33Z9g0oSjA@mail.gmail.com>
 <c1fa9027-3f92-5edd-6e5b-be4889e5363c@ti.com> <CAK8P3a0xEpCQa=9=-oZDuRNmA7hexbub5k_BdO71Y7ycyV_Szg@mail.gmail.com>
 <CAMpxmJUjeLNrMsLXM4uXCX22Hytqcn9csGK4aFVGaEJwRJf9Nw@mail.gmail.com>
 <CAK8P3a2HC0PVd2iw5fVvXMedJp3PFG4zgkMqccabRGUzhddV6A@mail.gmail.com>
 <CAMpxmJVLhnEy+2hKutkeOWnPwdMJkOF5UV0pvrAk=8WVNpy8zw@mail.gmail.com> <CAK8P3a01n+Xmz_dBkAhFwGcFrpzukTAngO8DXOu2gc3SAYi4bg@mail.gmail.com>
In-Reply-To: <CAK8P3a01n+Xmz_dBkAhFwGcFrpzukTAngO8DXOu2gc3SAYi4bg@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 16 Apr 2019 12:06:50 +0200
Message-ID: <CAMRc=MfEHbC53EpbDmpq_odrFoB6=M_CMm-4SPNFR3BH-ODEtg@mail.gmail.com>
Subject: Re: [RESEND PATCH 1/2] ARM: davinci: support multiplatform build for
 ARM v5
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 12 kwi 2019 o 15:45 Arnd Bergmann <arnd@arndb.de> napisa=C5=82(a):
>
> On Fri, Apr 12, 2019 at 3:32 PM Bartosz Golaszewski
> <bgolaszewski@baylibre.com> wrote:
> > pt., 12 kwi 2019 o 15:27 Arnd Bergmann <arnd@arndb.de> napisa=C5=82(a):
> > >
> > > On Fri, Apr 12, 2019 at 3:22 PM Bartosz Golaszewski
> > > <bgolaszewski@baylibre.com> wrote:
> > > > pt., 12 kwi 2019 o 15:16 Arnd Bergmann <arnd@arndb.de> napisa=C5=82=
(a):
> > > > > On Tue, Apr 2, 2019 at 1:03 PM Sekhar Nori <nsekhar@ti.com> wrote=
:
> > > > > > On 25/03/19 6:38 PM, Arnd Bergmann wrote:
> > > > > > > On Mon, Mar 18, 2019 at 1:29 PM Bartosz Golaszewski <brgl@bgd=
ev.pl> wrote:
> > > > > >
> > > > > > The timer conversion patches are pending review/rework. Will qu=
eue once
> > > > > > those are cleared.
> > > > >
> > > > > Unfortunately, after doing some more randconfig testing, I ended =
up with
> > > > > three build issues:
> > > > >
> > > > > 1. vpbe:
> > > > > drivers/media/platform/davinci/vpbe_osd.c:29:10: fatal error:
> > > > > 'mach/cputype.h' file not found
> > > > > #include <mach/cputype.h>
> > > > >          ^~~~~~~~~~~~~~~~
> > > > > drivers/media/platform/davinci/vpbe_venc.c:26:10: fatal error:
> > > > > 'mach/hardware.h' file not found
> > > > > #include <mach/hardware.h>
> > > > >          ^~~~~~~~~~~~~~~~~
> > > > > drivers/media/platform/davinci/vpbe_display.c:31:10: fatal error:
> > > > > 'mach/cputype.h' file not found
> > > > >
> > > > > 2. staging/vpfe:
> > > > > In file included from
> > > > > /git/arm-soc/drivers/staging/media/davinci_vpfe/dm365_isif.c:20:
> > > > > drivers/staging/media/davinci_vpfe/dm365_isif.h:24:10: fatal erro=
r:
> > > > > 'mach/mux.h' file not found
> > > > >
> > > > > 3.
> > > > >     davinci: fix sleep.S build error on ARMv4
> > > > >
> > > > >     When building a multiplatform kernel that includes armv4 supp=
ort,
> > > > >     the default target CPU does not support the blx instruction,
> > > > >     which leads to a build failure:
> > > > >
> > > > >     arch/arm/mach-davinci/sleep.S: Assembler messages:
> > > > >     arch/arm/mach-davinci/sleep.S:56: Error: selected processor d=
oes
> > > > > not support `blx ip' in ARM mode
> > > > >
> > > >
> > > > Hi Arnd,
> > > >
> > > > are the generated configs available somewhere for download?
> > >
> > > No, I only keep them locally, but I would hope they are easy enough t=
o
> > > reproduce. If you can't figure out the problem right away, I can send
> > > you the config files of course.
> > >
> > > Just noticed another issue in my logs:
> > >
> > > 4. ARCH_DAVINCI no longer selects RESET_CONTROLLER
> > > drivers/clk/davinci/psc.o: In function `__davinci_psc_register_clocks=
':
> > > psc.c:(.text+0x3f8): undefined reference to `devm_reset_controller_re=
gister'
> > > drivers/clk/davinci/psc-da850.o: In function `da850_psc0_init':
> > > psc-da850.c:(.text+0x14): undefined reference to `reset_controller_ad=
d_lookup'
> > >
> > >       Arnd
> >
> > Thanks. Another issue that I already fixed locally is missing select
> > for REGMAP_MMIO. Just FYI.
> >
> > This series is blocked by the clocksource series anyway, but I'll work
> > towards fixing it.
>
> Ok, sounds good. I have sent you whatever I had to work around the
> issue locally now, as private messages. See if you can use them, or
> ignore if you have a better fix.
>
>       Arnd

Will do, thanks!

Bart
