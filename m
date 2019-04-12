Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE43C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B1E02054F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbfDLNQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:16:37 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35868 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfDLNQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 09:16:36 -0400
Received: by mail-qk1-f193.google.com with SMTP id k130so5593280qke.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 06:16:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rv7MVICsaxHe7v4HuQI9mAqFB8+mbi20S9Zrx2UdNno=;
        b=tXMD4A13b6wxNXcpfDAWAjfmlR1NV1Sv6I0ekTztYE+7dakC//V/VRBUNcpIthKdBr
         T2UI4077KyoKiOKWnunmVHQ7I6Ae6rRlo1mofRNBLMkvhdiyeAYx3+HwDUsUYU7YL2MU
         PXpOylMzMxmTEy/b6UlAT9EzZeeq/zMRqtaBaZAnn1kUUhiB0M+UqAUzwpO4SVFOYJoQ
         P1LMBnTcU7/aoAkuOctE1OcWBsXttHPHBaKuQ/mMc5zCCLV3giMHN6Jhyx9g3KOoY1Dq
         Yrm5WMIUSaLeZaqD9oKIUExTrJJC4GlUZ3+RL8+TGzELqQdeahUJxzHLEX0twPfu6Ks+
         14/w==
X-Gm-Message-State: APjAAAVIBzBURcebVmH/FUpFX+V7J0mPPcXpBFZKLXFq1wLw14LR0y1Z
        sMIj3dYi48uroyp8Qtjhpk3aFCvu1r/Dd9T9isI=
X-Google-Smtp-Source: APXvYqwD4Be7cRFcGuRr2ojK6lE8ZDJRK05dW0xORM0tgqTl5inG6HsfGHrUpF0lVXYWcasR63Tw276OF2zxBlP3yFw=
X-Received: by 2002:ae9:f442:: with SMTP id z2mr43096377qkl.172.1555074995289;
 Fri, 12 Apr 2019 06:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190318122901.7231-1-brgl@bgdev.pl> <20190318122901.7231-2-brgl@bgdev.pl>
 <CAK8P3a0EhCRH7O87WSyfHujomQ_Dzz3=BT0SaXF-33Z9g0oSjA@mail.gmail.com> <c1fa9027-3f92-5edd-6e5b-be4889e5363c@ti.com>
In-Reply-To: <c1fa9027-3f92-5edd-6e5b-be4889e5363c@ti.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 12 Apr 2019 15:16:18 +0200
Message-ID: <CAK8P3a0xEpCQa=9=-oZDuRNmA7hexbub5k_BdO71Y7ycyV_Szg@mail.gmail.com>
Subject: Re: [RESEND PATCH 1/2] ARM: davinci: support multiplatform build for
 ARM v5
To:     Sekhar Nori <nsekhar@ti.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 2, 2019 at 1:03 PM Sekhar Nori <nsekhar@ti.com> wrote:
>
> On 25/03/19 6:38 PM, Arnd Bergmann wrote:
> > On Mon, Mar 18, 2019 at 1:29 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >>
> >> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >>
> >> Add modifications necessary to make davinci part of the ARM v5
> >> multiplatform build.
> >>
> >> Move the arch-specific configuration out of arch/arm/Kconfig and
> >> into mach-davinci/Kconfig. Remove the sub-menu for DaVinci
> >> implementations (they'll be visible directly under the system type.
> >> Select all necessary options not already selected by ARCH_MULTI_V5.
> >> Update davinci_all_defconfig. Explicitly include the mach-specific
> >> headers in mach-davinci/Makefile.
> >>
> >> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > I like this a lot, it gives me some hope that we can eventually
> > do the same for the remaining ARMv5 platforms that are
> > not multiplatform yet (s3c24xx, ks8695, w90x900, lpc32xx,
> > omap1, ep93xx, and maybe even the xscale based ones).
> >
> > I have done a lot of randconfig testing with this patch appled now
> > and not found any issues, great work!
>
> Thanks Arnd. Will take this as your Acked-by:
>
> The timer conversion patches are pending review/rework. Will queue once
> those are cleared.

Unfortunately, after doing some more randconfig testing, I ended up with
three build issues:

1. vpbe:
drivers/media/platform/davinci/vpbe_osd.c:29:10: fatal error:
'mach/cputype.h' file not found
#include <mach/cputype.h>
         ^~~~~~~~~~~~~~~~
drivers/media/platform/davinci/vpbe_venc.c:26:10: fatal error:
'mach/hardware.h' file not found
#include <mach/hardware.h>
         ^~~~~~~~~~~~~~~~~
drivers/media/platform/davinci/vpbe_display.c:31:10: fatal error:
'mach/cputype.h' file not found

2. staging/vpfe:
In file included from
/git/arm-soc/drivers/staging/media/davinci_vpfe/dm365_isif.c:20:
drivers/staging/media/davinci_vpfe/dm365_isif.h:24:10: fatal error:
'mach/mux.h' file not found

3.
    davinci: fix sleep.S build error on ARMv4

    When building a multiplatform kernel that includes armv4 support,
    the default target CPU does not support the blx instruction,
    which leads to a build failure:

    arch/arm/mach-davinci/sleep.S: Assembler messages:
    arch/arm/mach-davinci/sleep.S:56: Error: selected processor does
not support `blx ip' in ARM mode

    Add a .arch statement in the sources to make this file build.

    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/mach-davinci/sleep.S b/arch/arm/mach-davinci/sleep.S
index cd350dee4df3..efcd400b2abb 100644
--- a/arch/arm/mach-davinci/sleep.S
+++ b/arch/arm/mach-davinci/sleep.S
@@ -37,6 +37,7 @@
 #define DEEPSLEEP_SLEEPENABLE_BIT      BIT(31)

        .text
+       .arch   armv5te
 /*
  * Move DaVinci into deep sleep state
  *


      Arnd
