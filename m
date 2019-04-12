Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CA9C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 926DD2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="dPclzyIi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfDLNcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:32:42 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45838 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfDLNcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 09:32:42 -0400
Received: by mail-ot1-f66.google.com with SMTP id e5so8348597otk.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 06:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gOdULEPlzl5LQJxiJ0mTb3fWmRZn/8zDhhVB6XecHoA=;
        b=dPclzyIiIf2ERYMnVScHR8eoHldLbuFsfUl0fIfwOAWYB2EDlT5pmNKqJfjFDwaqpz
         XvaUUYFA9Z04+gDRvXt7D7SERPoWalBWIAI2ZcMwtjyyalri9xdo97XAzl30dpPuDDCN
         fHdOyWowl1EvBQ0ZXo8sRjrNEzw4mQCHi3m00X2h+DUIZDJPEXuHLD9x40DsX/knOrpZ
         HZwZbfCy5NI8qbv/xsm6mV39ZZarlOqkE4obGTcxy9iOR8hhZNt1SfVbg1t2PMSrzVO4
         SS1hpHcIs/Lt8RirvZOkmymmIlvZKaNUBN5YAtVcpnZmouyPJA2Yy80BaC+tYaLafdIK
         sCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gOdULEPlzl5LQJxiJ0mTb3fWmRZn/8zDhhVB6XecHoA=;
        b=lWRYMzbKbkbcu3dbEyT3T8j+k8nj+82wBWSllClMB+h4wx3yhH434AB55+5fjwnLJC
         3fIR8gEwgS1VB66su3no0EPwwTx8crYA9W1qK0Rzevw55UuQhSc68IQK48dDFhuBNi/Y
         vFLTvW6+LMerMH6j/DPY+cB23lvkjjTmIZdB3hqklB9Xx6h203z016H8nr26rfHuRQIM
         yKkhiClXykcziIEuh42CRCahpe6CMqoOURU74+/45qfyqb8nvV7F2SSmp5QhQYjkaB3b
         8ZDMZk4easDE7/QoDFA+2ne+nnIjwEVVPcudktDFdFLhfwMmstPM5IxwIfGDq71psKv8
         GlnQ==
X-Gm-Message-State: APjAAAXR3OVt8zId+aTftiRzoW88IpFddaerikIYm2nKiY1nSP692xkv
        u5MK9JvAEji9KHFkT+th0bSmaTPHMgBu8yVDRFJY/A==
X-Google-Smtp-Source: APXvYqxDaQnfVMGKsETzedOclSNHggWx7g7G/kOKiGkApIvN8GZsHFXtvQy41AaDEfMgEheb/JphFzkjxYzZzICGAtw=
X-Received: by 2002:a9d:4804:: with SMTP id c4mr37424443otf.0.1555075961613;
 Fri, 12 Apr 2019 06:32:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190318122901.7231-1-brgl@bgdev.pl> <20190318122901.7231-2-brgl@bgdev.pl>
 <CAK8P3a0EhCRH7O87WSyfHujomQ_Dzz3=BT0SaXF-33Z9g0oSjA@mail.gmail.com>
 <c1fa9027-3f92-5edd-6e5b-be4889e5363c@ti.com> <CAK8P3a0xEpCQa=9=-oZDuRNmA7hexbub5k_BdO71Y7ycyV_Szg@mail.gmail.com>
 <CAMpxmJUjeLNrMsLXM4uXCX22Hytqcn9csGK4aFVGaEJwRJf9Nw@mail.gmail.com> <CAK8P3a2HC0PVd2iw5fVvXMedJp3PFG4zgkMqccabRGUzhddV6A@mail.gmail.com>
In-Reply-To: <CAK8P3a2HC0PVd2iw5fVvXMedJp3PFG4zgkMqccabRGUzhddV6A@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 12 Apr 2019 15:32:30 +0200
Message-ID: <CAMpxmJVLhnEy+2hKutkeOWnPwdMJkOF5UV0pvrAk=8WVNpy8zw@mail.gmail.com>
Subject: Re: [RESEND PATCH 1/2] ARM: davinci: support multiplatform build for
 ARM v5
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Sekhar Nori <nsekhar@ti.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
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

pt., 12 kwi 2019 o 15:27 Arnd Bergmann <arnd@arndb.de> napisa=C5=82(a):
>
> On Fri, Apr 12, 2019 at 3:22 PM Bartosz Golaszewski
> <bgolaszewski@baylibre.com> wrote:
> > pt., 12 kwi 2019 o 15:16 Arnd Bergmann <arnd@arndb.de> napisa=C5=82(a):
> > > On Tue, Apr 2, 2019 at 1:03 PM Sekhar Nori <nsekhar@ti.com> wrote:
> > > > On 25/03/19 6:38 PM, Arnd Bergmann wrote:
> > > > > On Mon, Mar 18, 2019 at 1:29 PM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
> > > >
> > > > The timer conversion patches are pending review/rework. Will queue =
once
> > > > those are cleared.
> > >
> > > Unfortunately, after doing some more randconfig testing, I ended up w=
ith
> > > three build issues:
> > >
> > > 1. vpbe:
> > > drivers/media/platform/davinci/vpbe_osd.c:29:10: fatal error:
> > > 'mach/cputype.h' file not found
> > > #include <mach/cputype.h>
> > >          ^~~~~~~~~~~~~~~~
> > > drivers/media/platform/davinci/vpbe_venc.c:26:10: fatal error:
> > > 'mach/hardware.h' file not found
> > > #include <mach/hardware.h>
> > >          ^~~~~~~~~~~~~~~~~
> > > drivers/media/platform/davinci/vpbe_display.c:31:10: fatal error:
> > > 'mach/cputype.h' file not found
> > >
> > > 2. staging/vpfe:
> > > In file included from
> > > /git/arm-soc/drivers/staging/media/davinci_vpfe/dm365_isif.c:20:
> > > drivers/staging/media/davinci_vpfe/dm365_isif.h:24:10: fatal error:
> > > 'mach/mux.h' file not found
> > >
> > > 3.
> > >     davinci: fix sleep.S build error on ARMv4
> > >
> > >     When building a multiplatform kernel that includes armv4 support,
> > >     the default target CPU does not support the blx instruction,
> > >     which leads to a build failure:
> > >
> > >     arch/arm/mach-davinci/sleep.S: Assembler messages:
> > >     arch/arm/mach-davinci/sleep.S:56: Error: selected processor does
> > > not support `blx ip' in ARM mode
> > >
> >
> > Hi Arnd,
> >
> > are the generated configs available somewhere for download?
>
> No, I only keep them locally, but I would hope they are easy enough to
> reproduce. If you can't figure out the problem right away, I can send
> you the config files of course.
>
> Just noticed another issue in my logs:
>
> 4. ARCH_DAVINCI no longer selects RESET_CONTROLLER
> drivers/clk/davinci/psc.o: In function `__davinci_psc_register_clocks':
> psc.c:(.text+0x3f8): undefined reference to `devm_reset_controller_regist=
er'
> drivers/clk/davinci/psc-da850.o: In function `da850_psc0_init':
> psc-da850.c:(.text+0x14): undefined reference to `reset_controller_add_lo=
okup'
>
>       Arnd

Thanks. Another issue that I already fixed locally is missing select
for REGMAP_MMIO. Just FYI.

This series is blocked by the clocksource series anyway, but I'll work
towards fixing it.

Bart
