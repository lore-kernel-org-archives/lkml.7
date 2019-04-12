Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A716C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FEF32054F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="thWBybmG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfDLNWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:22:04 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34343 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbfDLNWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 09:22:04 -0400
Received: by mail-ot1-f67.google.com with SMTP id k21so8366775otf.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 06:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/XLB03AAKlRNeBcxwq+CIWKQa+/qNoi/gnhWbxOeHIQ=;
        b=thWBybmGi81WY4d3jBz2c6mxDs6sILZqnE6YmDLqF0VnXnqyBlEMmwAYqWnRPQNT73
         LBQLrsI83OVfIayq4giYtY9xIU4GmnT6r18BApP9H5+OQ3wF1r0UbzDcmXTm1UGcslLQ
         PDDYEKNFS2nTBYd6fXkuefztmcqtwqZgzIrIPwu88kWtURUjikuisTzRRBFv4K6v7i1p
         W+dWCaroEHi5bxEIOCua+CoowGjCmLdSaAyh8zHCGfnQz1LxNk9H5TKT9jwsVcUnP8Dp
         AunaudDn7BRxoteoLzly+VvjeKxH8u2DJRYOoP3dI6dVHIZx6arJN75RvpQ8rjNlXa+F
         s/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/XLB03AAKlRNeBcxwq+CIWKQa+/qNoi/gnhWbxOeHIQ=;
        b=kiAc0314/xyw11UGjQsyKUQjdj91NefgKM4xNRlmAryXEGJVEAzisxQM4w2tkM8kcE
         XqaO+0VP9RBlybNsblL2tD/EmCPQVtCTXDELC98AQTz3PUTVuy40K6uTc6HMUzP4EXna
         6uGjEHHn5GbClaUUoWbfbpjIYZQx80uLrhtTKsdfap/ULdGD1pFeU0yg6M4eqpEsyxL8
         T4xxyXq8it5i3cCEiHGmucOlJTKoyU51DqOvX64sb+v+eUoWEDmf3NXPehipic9R3c7n
         eBVmIqOokYFFq1V3XGxQfY1DSfdf5/17GKjQJGFqETkmFzEWlFnpdQVAN4iPjfr6JTyk
         qHdQ==
X-Gm-Message-State: APjAAAVKTSzeqQ6aVQ0ys4HQrvEIcUTm5bLaShwIae4GCBdkcj7sRtHE
        m8G0H0Hi6zgRMluDhkGRK2UbmmBx2dakQAUzKeXkPw==
X-Google-Smtp-Source: APXvYqyr1uxnsi7YQrljcr/pjEcvGMn2DTo+2Av7pq2rZUQAa2f8OEsqUAjKp0LQC0HgCMmzMloXkJFOfbZIhlblb2w=
X-Received: by 2002:a9d:3988:: with SMTP id y8mr37299267otb.231.1555075323648;
 Fri, 12 Apr 2019 06:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190318122901.7231-1-brgl@bgdev.pl> <20190318122901.7231-2-brgl@bgdev.pl>
 <CAK8P3a0EhCRH7O87WSyfHujomQ_Dzz3=BT0SaXF-33Z9g0oSjA@mail.gmail.com>
 <c1fa9027-3f92-5edd-6e5b-be4889e5363c@ti.com> <CAK8P3a0xEpCQa=9=-oZDuRNmA7hexbub5k_BdO71Y7ycyV_Szg@mail.gmail.com>
In-Reply-To: <CAK8P3a0xEpCQa=9=-oZDuRNmA7hexbub5k_BdO71Y7ycyV_Szg@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 12 Apr 2019 15:21:52 +0200
Message-ID: <CAMpxmJUjeLNrMsLXM4uXCX22Hytqcn9csGK4aFVGaEJwRJf9Nw@mail.gmail.com>
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

pt., 12 kwi 2019 o 15:16 Arnd Bergmann <arnd@arndb.de> napisa=C5=82(a):
>
> On Tue, Apr 2, 2019 at 1:03 PM Sekhar Nori <nsekhar@ti.com> wrote:
> >
> > On 25/03/19 6:38 PM, Arnd Bergmann wrote:
> > > On Mon, Mar 18, 2019 at 1:29 PM Bartosz Golaszewski <brgl@bgdev.pl> w=
rote:
> > >>
> > >> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >>
> > >> Add modifications necessary to make davinci part of the ARM v5
> > >> multiplatform build.
> > >>
> > >> Move the arch-specific configuration out of arch/arm/Kconfig and
> > >> into mach-davinci/Kconfig. Remove the sub-menu for DaVinci
> > >> implementations (they'll be visible directly under the system type.
> > >> Select all necessary options not already selected by ARCH_MULTI_V5.
> > >> Update davinci_all_defconfig. Explicitly include the mach-specific
> > >> headers in mach-davinci/Makefile.
> > >>
> > >> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >
> > > I like this a lot, it gives me some hope that we can eventually
> > > do the same for the remaining ARMv5 platforms that are
> > > not multiplatform yet (s3c24xx, ks8695, w90x900, lpc32xx,
> > > omap1, ep93xx, and maybe even the xscale based ones).
> > >
> > > I have done a lot of randconfig testing with this patch appled now
> > > and not found any issues, great work!
> >
> > Thanks Arnd. Will take this as your Acked-by:
> >
> > The timer conversion patches are pending review/rework. Will queue once
> > those are cleared.
>
> Unfortunately, after doing some more randconfig testing, I ended up with
> three build issues:
>
> 1. vpbe:
> drivers/media/platform/davinci/vpbe_osd.c:29:10: fatal error:
> 'mach/cputype.h' file not found
> #include <mach/cputype.h>
>          ^~~~~~~~~~~~~~~~
> drivers/media/platform/davinci/vpbe_venc.c:26:10: fatal error:
> 'mach/hardware.h' file not found
> #include <mach/hardware.h>
>          ^~~~~~~~~~~~~~~~~
> drivers/media/platform/davinci/vpbe_display.c:31:10: fatal error:
> 'mach/cputype.h' file not found
>
> 2. staging/vpfe:
> In file included from
> /git/arm-soc/drivers/staging/media/davinci_vpfe/dm365_isif.c:20:
> drivers/staging/media/davinci_vpfe/dm365_isif.h:24:10: fatal error:
> 'mach/mux.h' file not found
>
> 3.
>     davinci: fix sleep.S build error on ARMv4
>
>     When building a multiplatform kernel that includes armv4 support,
>     the default target CPU does not support the blx instruction,
>     which leads to a build failure:
>
>     arch/arm/mach-davinci/sleep.S: Assembler messages:
>     arch/arm/mach-davinci/sleep.S:56: Error: selected processor does
> not support `blx ip' in ARM mode
>

Hi Arnd,

are the generated configs available somewhere for download?

Bart

>     Add a .arch statement in the sources to make this file build.
>
>     Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> diff --git a/arch/arm/mach-davinci/sleep.S b/arch/arm/mach-davinci/sleep.=
S
> index cd350dee4df3..efcd400b2abb 100644
> --- a/arch/arm/mach-davinci/sleep.S
> +++ b/arch/arm/mach-davinci/sleep.S
> @@ -37,6 +37,7 @@
>  #define DEEPSLEEP_SLEEPENABLE_BIT      BIT(31)
>
>         .text
> +       .arch   armv5te
>  /*
>   * Move DaVinci into deep sleep state
>   *
>
>
>       Arnd
