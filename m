Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CC2C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 05:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF1F82084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 05:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="BonsgYrA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfDIFI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 01:08:28 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:61154 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfDIFI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 01:08:28 -0400
X-Greylist: delayed 76353 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Apr 2019 01:08:26 EDT
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x3958KJu030592;
        Tue, 9 Apr 2019 14:08:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x3958KJu030592
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1554786501;
        bh=+tLjWixVEmMfw5ZbjJe2/nYWA3NiTpUWkJvBadLWyco=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BonsgYrAUbcA0M3lEW4itblRN3LeJOwImaYixpeeDGrq3nJC0SteATYWJqbOaiU+i
         ujAuU+F7BTgZIPCrDHbaq1utIPWwUk5tKZ8J8yPz9KqTSJ7cv3DQA/HfiEWIBeGMo/
         R/4BBkBxUHZumUn/ySFMApsaToriEccujR9Fj02aV0to2LWV2QK4pmrzti3kMjeiGk
         iOSFce+oXZB4Ri9wPweYM5sOQQESgaKqfnxLfMeF21VJTox1wT4RetPAVKDyJTatkV
         Uk1NatFOJt12L/HrV/uqDBMg7qcmyY+2Lr4u8PG+kLhGPqQKuZYm4PmC4723BIYeCc
         FXvM7xK44X0XQ==
X-Nifty-SrcIP: [209.85.221.181]
Received: by mail-vk1-f181.google.com with SMTP id w140so3573937vkd.3;
        Mon, 08 Apr 2019 22:08:21 -0700 (PDT)
X-Gm-Message-State: APjAAAU9gq27EA6yaoEBXer7TTJx23yPHkeLDULZJdGo6zhzU00c+pB1
        NawgD8YvtT8MY2/NSvUVnJcWV/9DPy3Z50Vh7Rw=
X-Google-Smtp-Source: APXvYqwSJzhZpWNvmI592VjP6WuINhFLbW/w/3RfT4Z2A5JdBgIJPh9OzAMqqHku+IYb7lMPOEZnY2JsxMpkklkwL+g=
X-Received: by 2002:a1f:860c:: with SMTP id i12mr19524700vkd.46.1554786499684;
 Mon, 08 Apr 2019 22:08:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190408075427.6052-1-yamada.masahiro@socionext.com>
 <20190408075427.6052-3-yamada.masahiro@socionext.com> <20190408161802.GI49658@atomide.com>
 <6308904e-443a-46ff-9633-2ccb3b03bef9@ti.com>
In-Reply-To: <6308904e-443a-46ff-9633-2ccb3b03bef9@ti.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 9 Apr 2019 14:07:43 +0900
X-Gmail-Original-Message-ID: <CAK7LNASYqkhW_W6K5Y9NvmqnZ2aSCbGZNw0ZFrBB3Dd2FRN8yg@mail.gmail.com>
Message-ID: <CAK7LNASYqkhW_W6K5Y9NvmqnZ2aSCbGZNw0ZFrBB3Dd2FRN8yg@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: omap2: move platform-specific asm-offset.h to arch/arm/mach-omap2
To:     Keerthy <j-keerthy@ti.com>, Tony Lindgren <tony@atomide.com>,
        arm-soc <arm@kernel.org>, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 2:00 PM Keerthy <j-keerthy@ti.com> wrote:
>
>
>
> On 08/04/19 9:48 PM, Tony Lindgren wrote:
> > Hi,
> >
> > * Masahiro Yamada <yamada.masahiro@socionext.com> [190408 07:56]:
> >> <generated/ti-pm-asm-offsets.h> is only generated and included
> >> by arch/arm/mach-omap2/, so it does not need to reside in the
> >> globally visible include/generated/.
> >>
> >> I moved and renamed it to arch/arm/mach-omap2/pm-asm-offsets.h
> >> since the prefix 'omap2-' is just redundant in mach-omap2/.
> >>
> >> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> >> ---
> >>
> >> Can this be applied to ARM-SOC tree in a series?
> >> (with Ack from the platform sub-maintainer.)
> >>
> >> ti-pm-asm-offsets.h does not need to reside in include/generated/,
> >> but you may ask "Why must it get out of include/generated/?"
> >>
> >> My main motivation is to avoid a race condition in the currently
> >> proposed patch:
> >>
> >> https://lore.kernel.org/patchwork/patch/1052763/
> >>
> >> This patch tries to embed some build artifacts into the kernel.
> >>
> >> If arch/arm/mach-omap2/ and kernel/ are built at the same time,
> >> it may embed a truncated file.
> >
> > Looks like a nice improvment to me, adding Keerthy and Dave to Cc.
> >
> > Keerthy and Dave, can you please test this series with am3 and am4
> > PM code?
>
> Tested for Deep Sleep0 on AM33xx Beaglebone-black.
> Tested for Deep Sleep0 on AM437x-gp-evm.
>
> Applied this on top of Tony's for-next with the gpio patch
> required for RTC+DDR mode on am437x-gp-evm.

Was it applied to TI tree?

If so ...

Arnd, Olof,
Please just ignore this patch
since it looks it was already applied to TI tree.

Thanks.
Masahiro Yamada




> Tested-by: Keerthy <j-keerthy@ti.com>
>
> >
> > Regards,
> >
> > Tony
> >
> >>   arch/arm/mach-omap2/.gitignore  | 1 +
> >>   arch/arm/mach-omap2/Makefile    | 5 +++--
> >>   arch/arm/mach-omap2/sleep33xx.S | 2 +-
> >>   arch/arm/mach-omap2/sleep43xx.S | 2 +-
> >>   4 files changed, 6 insertions(+), 4 deletions(-)
> >>   create mode 100644 arch/arm/mach-omap2/.gitignore
> >>
> >> diff --git a/arch/arm/mach-omap2/.gitignore b/arch/arm/mach-omap2/.gitignore
> >> new file mode 100644
> >> index 000000000000..79a8d6ea7152
> >> --- /dev/null
> >> +++ b/arch/arm/mach-omap2/.gitignore
> >> @@ -0,0 +1 @@
> >> +pm-asm-offsets.h
> >> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> >> index 85d1b13c9215..26baeb6477af 100644
> >> --- a/arch/arm/mach-omap2/Makefile
> >> +++ b/arch/arm/mach-omap2/Makefile
> >> @@ -236,9 +236,10 @@ obj-y                                   += omap_phy_internal.o
> >>
> >>   obj-$(CONFIG_MACH_OMAP2_TUSB6010)  += usb-tusb6010.o
> >>
> >> -include/generated/ti-pm-asm-offsets.h: arch/arm/mach-omap2/pm-asm-offsets.s FORCE
> >> +$(obj)/pm-asm-offsets.h: $(obj)/pm-asm-offsets.s FORCE
> >>      $(call filechk,offsets,__TI_PM_ASM_OFFSETS_H__)
> >>
> >> -$(obj)/sleep33xx.o $(obj)/sleep43xx.o: include/generated/ti-pm-asm-offsets.h
> >> +$(obj)/sleep33xx.o $(obj)/sleep43xx.o: $(obj)/pm-asm-offsets.h
> >>
> >>   targets += pm-asm-offsets.s
> >> +clean-files += pm-asm-offsets.h
> >> diff --git a/arch/arm/mach-omap2/sleep33xx.S b/arch/arm/mach-omap2/sleep33xx.S
> >> index 47a816468cdb..a003769121aa 100644
> >> --- a/arch/arm/mach-omap2/sleep33xx.S
> >> +++ b/arch/arm/mach-omap2/sleep33xx.S
> >> @@ -6,7 +6,6 @@
> >>    * Dave Gerlach, Vaibhav Bedia
> >>    */
> >>
> >> -#include <generated/ti-pm-asm-offsets.h>
> >>   #include <linux/linkage.h>
> >>   #include <linux/platform_data/pm33xx.h>
> >>   #include <linux/ti-emif-sram.h>
> >> @@ -15,6 +14,7 @@
> >>
> >>   #include "iomap.h"
> >>   #include "cm33xx.h"
> >> +#include "pm-asm-offsets.h"
> >>
> >>   #define AM33XX_CM_CLKCTRL_MODULESTATE_DISABLED                     0x00030000
> >>   #define AM33XX_CM_CLKCTRL_MODULEMODE_DISABLE                       0x0003
> >> diff --git a/arch/arm/mach-omap2/sleep43xx.S b/arch/arm/mach-omap2/sleep43xx.S
> >> index 5b9343b58fc7..aa288f361c5e 100644
> >> --- a/arch/arm/mach-omap2/sleep43xx.S
> >> +++ b/arch/arm/mach-omap2/sleep43xx.S
> >> @@ -6,7 +6,6 @@
> >>    * Dave Gerlach, Vaibhav Bedia
> >>    */
> >>
> >> -#include <generated/ti-pm-asm-offsets.h>
> >>   #include <linux/linkage.h>
> >>   #include <linux/ti-emif-sram.h>
> >>   #include <linux/platform_data/pm33xx.h>
> >> @@ -19,6 +18,7 @@
> >>   #include "iomap.h"
> >>   #include "omap-secure.h"
> >>   #include "omap44xx.h"
> >> +#include "pm-asm-offsets.h"
> >>   #include "prm33xx.h"
> >>   #include "prcm43xx.h"
> >>
> >> --
> >> 2.17.1
> >>



--
Best Regards
Masahiro Yamada
