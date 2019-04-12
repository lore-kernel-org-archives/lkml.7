Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE19C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6027B2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfDLNpL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:45:11 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43493 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbfDLNpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 09:45:08 -0400
Received: by mail-qt1-f194.google.com with SMTP id v32so11183344qtc.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 06:45:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4UYcWaw/Vuq96Zopo/n3GnMdHrUtkEFJ+5Ai+qip8G4=;
        b=IGPqbcUFZYmEaJkRkb/soOOQZc1XqMxe7AkJestUlEszKtCmOhn6zmnNwheNXDNeBe
         j0LzJuy/XYKZISsQiAm6o93DS9/ojO/g6wuh1W4RxQPK2fDvd3s2OmOJ2M9p+saM160Y
         kiXlPcPgetxgpJpb32GujNkCbr/WK/gZpm7hyRLoNRJzQVxtVQn48wUNSm+I6xAKSP1X
         FGt7F/ALIAJ7LO98A5RLzqvWBpFrZcXgoTIdW6gIjNy0Jft5KfhAumAPn+puye8oImqq
         QIylbP/NYc1CpffcIXOQDGZ+6XFC/+lDhhamkvY8DOuQl1iK1K+fesX90uYK6E8LpDx6
         44VQ==
X-Gm-Message-State: APjAAAWQODjDczdJG9dL1CbCrve1UEP54iXRsVJkwfeknz8ebWYdB8EG
        4WuG2HMDRzubUZouXlJiahH3cXWWW11CAJIWPGY=
X-Google-Smtp-Source: APXvYqzmNe2FoNP85KGg2Y8wrEU8H7sR0JNGCV7kz5gRVD1bSCEiOOk7noxjcpuGUkGYud8Urf835kvgNjkaT9GxXlY=
X-Received: by 2002:ac8:8b9:: with SMTP id v54mr48851898qth.64.1555076707144;
 Fri, 12 Apr 2019 06:45:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190318122901.7231-1-brgl@bgdev.pl> <20190318122901.7231-2-brgl@bgdev.pl>
 <CAK8P3a0EhCRH7O87WSyfHujomQ_Dzz3=BT0SaXF-33Z9g0oSjA@mail.gmail.com>
 <c1fa9027-3f92-5edd-6e5b-be4889e5363c@ti.com> <CAK8P3a0xEpCQa=9=-oZDuRNmA7hexbub5k_BdO71Y7ycyV_Szg@mail.gmail.com>
 <CAMpxmJUjeLNrMsLXM4uXCX22Hytqcn9csGK4aFVGaEJwRJf9Nw@mail.gmail.com>
 <CAK8P3a2HC0PVd2iw5fVvXMedJp3PFG4zgkMqccabRGUzhddV6A@mail.gmail.com> <CAMpxmJVLhnEy+2hKutkeOWnPwdMJkOF5UV0pvrAk=8WVNpy8zw@mail.gmail.com>
In-Reply-To: <CAMpxmJVLhnEy+2hKutkeOWnPwdMJkOF5UV0pvrAk=8WVNpy8zw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 12 Apr 2019 15:44:48 +0200
Message-ID: <CAK8P3a01n+Xmz_dBkAhFwGcFrpzukTAngO8DXOu2gc3SAYi4bg@mail.gmail.com>
Subject: Re: [RESEND PATCH 1/2] ARM: davinci: support multiplatform build for
 ARM v5
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Sekhar Nori <nsekhar@ti.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 3:32 PM Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:
> pt., 12 kwi 2019 o 15:27 Arnd Bergmann <arnd@arndb.de> napisał(a):
> >
> > On Fri, Apr 12, 2019 at 3:22 PM Bartosz Golaszewski
> > <bgolaszewski@baylibre.com> wrote:
> > > pt., 12 kwi 2019 o 15:16 Arnd Bergmann <arnd@arndb.de> napisał(a):
> > > > On Tue, Apr 2, 2019 at 1:03 PM Sekhar Nori <nsekhar@ti.com> wrote:
> > > > > On 25/03/19 6:38 PM, Arnd Bergmann wrote:
> > > > > > On Mon, Mar 18, 2019 at 1:29 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > > > >
> > > > > The timer conversion patches are pending review/rework. Will queue once
> > > > > those are cleared.
> > > >
> > > > Unfortunately, after doing some more randconfig testing, I ended up with
> > > > three build issues:
> > > >
> > > > 1. vpbe:
> > > > drivers/media/platform/davinci/vpbe_osd.c:29:10: fatal error:
> > > > 'mach/cputype.h' file not found
> > > > #include <mach/cputype.h>
> > > >          ^~~~~~~~~~~~~~~~
> > > > drivers/media/platform/davinci/vpbe_venc.c:26:10: fatal error:
> > > > 'mach/hardware.h' file not found
> > > > #include <mach/hardware.h>
> > > >          ^~~~~~~~~~~~~~~~~
> > > > drivers/media/platform/davinci/vpbe_display.c:31:10: fatal error:
> > > > 'mach/cputype.h' file not found
> > > >
> > > > 2. staging/vpfe:
> > > > In file included from
> > > > /git/arm-soc/drivers/staging/media/davinci_vpfe/dm365_isif.c:20:
> > > > drivers/staging/media/davinci_vpfe/dm365_isif.h:24:10: fatal error:
> > > > 'mach/mux.h' file not found
> > > >
> > > > 3.
> > > >     davinci: fix sleep.S build error on ARMv4
> > > >
> > > >     When building a multiplatform kernel that includes armv4 support,
> > > >     the default target CPU does not support the blx instruction,
> > > >     which leads to a build failure:
> > > >
> > > >     arch/arm/mach-davinci/sleep.S: Assembler messages:
> > > >     arch/arm/mach-davinci/sleep.S:56: Error: selected processor does
> > > > not support `blx ip' in ARM mode
> > > >
> > >
> > > Hi Arnd,
> > >
> > > are the generated configs available somewhere for download?
> >
> > No, I only keep them locally, but I would hope they are easy enough to
> > reproduce. If you can't figure out the problem right away, I can send
> > you the config files of course.
> >
> > Just noticed another issue in my logs:
> >
> > 4. ARCH_DAVINCI no longer selects RESET_CONTROLLER
> > drivers/clk/davinci/psc.o: In function `__davinci_psc_register_clocks':
> > psc.c:(.text+0x3f8): undefined reference to `devm_reset_controller_register'
> > drivers/clk/davinci/psc-da850.o: In function `da850_psc0_init':
> > psc-da850.c:(.text+0x14): undefined reference to `reset_controller_add_lookup'
> >
> >       Arnd
>
> Thanks. Another issue that I already fixed locally is missing select
> for REGMAP_MMIO. Just FYI.
>
> This series is blocked by the clocksource series anyway, but I'll work
> towards fixing it.

Ok, sounds good. I have sent you whatever I had to work around the
issue locally now, as private messages. See if you can use them, or
ignore if you have a better fix.

      Arnd
