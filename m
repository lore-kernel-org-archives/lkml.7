Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7668FC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7A72084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfDLN1L convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:27:11 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46795 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfDLN1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 09:27:10 -0400
Received: by mail-qt1-f194.google.com with SMTP id z17so11095728qts.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 06:27:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Y0MQBCXjRKqOX8mzyvzy70aQn3oGWXRaq00CKnP7vE8=;
        b=SbU70tgc763U49QdGVivzFIKKZUkyWKujwJBbLflp6y8DEYildzDJ1t3THmlAF31e+
         2Y/c4QgoV4A0NPn2qVddvFjlAbifkRYAxOWIwMa7Wrm1Bub9BIyuGqRDsl1mGzqGnODF
         Tc4ztHSdNOUD+qBAWuL8u84GyQ8hmz7poOFkTCmjxuhBz29IHDF+cZ0RQked/SF6gXoA
         LSuYl35zNrA0awEQETUAVIL0qkDbamwfxt7yov6ADcN7NULkhzUCud9XOGcBBwAik/v8
         dczaYnHBZ5Z6w3Mx36WmrWoT2Aq3Y+QAernaIwWGbhEfbIqtJ6sCd0lCJOni+4jlKup2
         /oFQ==
X-Gm-Message-State: APjAAAWc6PuKP/H+S6O7vhnerk31eTa2rr5WDkyfnWBw6pai+2NrgshD
        TaDghL583RNZSG12RliZAwGKD4P6vfiF4Q8HmDg=
X-Google-Smtp-Source: APXvYqwF0u1nZJOma3CAYwkGXCm4/dQy3Xy1UfodHPVBTlr1/eSAatPJ7AxRTV01xjo72JIFFS+w4gzahqWR0qP5otw=
X-Received: by 2002:ac8:3fbc:: with SMTP id d57mr45572170qtk.96.1555075629582;
 Fri, 12 Apr 2019 06:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190318122901.7231-1-brgl@bgdev.pl> <20190318122901.7231-2-brgl@bgdev.pl>
 <CAK8P3a0EhCRH7O87WSyfHujomQ_Dzz3=BT0SaXF-33Z9g0oSjA@mail.gmail.com>
 <c1fa9027-3f92-5edd-6e5b-be4889e5363c@ti.com> <CAK8P3a0xEpCQa=9=-oZDuRNmA7hexbub5k_BdO71Y7ycyV_Szg@mail.gmail.com>
 <CAMpxmJUjeLNrMsLXM4uXCX22Hytqcn9csGK4aFVGaEJwRJf9Nw@mail.gmail.com>
In-Reply-To: <CAMpxmJUjeLNrMsLXM4uXCX22Hytqcn9csGK4aFVGaEJwRJf9Nw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 12 Apr 2019 15:26:53 +0200
Message-ID: <CAK8P3a2HC0PVd2iw5fVvXMedJp3PFG4zgkMqccabRGUzhddV6A@mail.gmail.com>
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

On Fri, Apr 12, 2019 at 3:22 PM Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:
> pt., 12 kwi 2019 o 15:16 Arnd Bergmann <arnd@arndb.de> napisał(a):
> > On Tue, Apr 2, 2019 at 1:03 PM Sekhar Nori <nsekhar@ti.com> wrote:
> > > On 25/03/19 6:38 PM, Arnd Bergmann wrote:
> > > > On Mon, Mar 18, 2019 at 1:29 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > >
> > > The timer conversion patches are pending review/rework. Will queue once
> > > those are cleared.
> >
> > Unfortunately, after doing some more randconfig testing, I ended up with
> > three build issues:
> >
> > 1. vpbe:
> > drivers/media/platform/davinci/vpbe_osd.c:29:10: fatal error:
> > 'mach/cputype.h' file not found
> > #include <mach/cputype.h>
> >          ^~~~~~~~~~~~~~~~
> > drivers/media/platform/davinci/vpbe_venc.c:26:10: fatal error:
> > 'mach/hardware.h' file not found
> > #include <mach/hardware.h>
> >          ^~~~~~~~~~~~~~~~~
> > drivers/media/platform/davinci/vpbe_display.c:31:10: fatal error:
> > 'mach/cputype.h' file not found
> >
> > 2. staging/vpfe:
> > In file included from
> > /git/arm-soc/drivers/staging/media/davinci_vpfe/dm365_isif.c:20:
> > drivers/staging/media/davinci_vpfe/dm365_isif.h:24:10: fatal error:
> > 'mach/mux.h' file not found
> >
> > 3.
> >     davinci: fix sleep.S build error on ARMv4
> >
> >     When building a multiplatform kernel that includes armv4 support,
> >     the default target CPU does not support the blx instruction,
> >     which leads to a build failure:
> >
> >     arch/arm/mach-davinci/sleep.S: Assembler messages:
> >     arch/arm/mach-davinci/sleep.S:56: Error: selected processor does
> > not support `blx ip' in ARM mode
> >
>
> Hi Arnd,
>
> are the generated configs available somewhere for download?

No, I only keep them locally, but I would hope they are easy enough to
reproduce. If you can't figure out the problem right away, I can send
you the config files of course.

Just noticed another issue in my logs:

4. ARCH_DAVINCI no longer selects RESET_CONTROLLER
drivers/clk/davinci/psc.o: In function `__davinci_psc_register_clocks':
psc.c:(.text+0x3f8): undefined reference to `devm_reset_controller_register'
drivers/clk/davinci/psc-da850.o: In function `da850_psc0_init':
psc-da850.c:(.text+0x14): undefined reference to `reset_controller_add_lookup'

      Arnd
