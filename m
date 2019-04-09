Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F49C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 07:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C030F20857
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 07:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="WiPLHisM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbfDIHGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 03:06:31 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:22796 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfDIHGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 03:06:31 -0400
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x3976If2018583;
        Tue, 9 Apr 2019 16:06:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x3976If2018583
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1554793579;
        bh=KAxjHSs77HgHMF8yn1xIgefgEIAQ2wmiGIkkKkEE8x4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WiPLHisM16Tn2IOcWtbGYceOvoLXo3zvHw0YIfbqTboxIotj3QwRch+54nXxh+deJ
         mFCYXRO/EVbigM5klmwdV49tKXzuki0bJrCXDLz5otOviUex7/4fcOm+2xOC+5ipN8
         T5Z0BNePjTsQFPwqBIyBDMJOD1c3SAew5JTBxFx60gYJ1MnGhgAkVKgNucSTM+JMug
         KN1nLpdJmNBPHfelJTfKJwvTco17x1U2/3bpiixtGW1aS8aMXw5OUftC1kM7FMNQQA
         eIcMSE1vj4AXRXUaCahPa0qPAp/fvEq+/1Y9QHkRMMk00qB0fotGL20B1J3He/5ZHT
         ntEH6qwNERGUQ==
X-Nifty-SrcIP: [209.85.222.48]
Received: by mail-ua1-f48.google.com with SMTP id c13so5139614uao.12;
        Tue, 09 Apr 2019 00:06:19 -0700 (PDT)
X-Gm-Message-State: APjAAAV+raAHbX6jPyM0dimQ1gVU/c0Nlre3QEyeWze8w1EA6PruYCLX
        B1cgZPYcRSH76Y7Lp0CBTjQFdKezq5JAyAzOdAA=
X-Google-Smtp-Source: APXvYqwfjQUpWsYYPe2SZTy4BhMJ8FF5YXoRgZs0BvxcHj8Z1gpVBFy4IRxZqrtG+hFCPflITFM9rycvsg7JueOa/ls=
X-Received: by 2002:ab0:348a:: with SMTP id c10mr12894893uar.79.1554793577884;
 Tue, 09 Apr 2019 00:06:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190408075427.6052-1-yamada.masahiro@socionext.com>
 <20190408075427.6052-3-yamada.masahiro@socionext.com> <20190408161802.GI49658@atomide.com>
 <6308904e-443a-46ff-9633-2ccb3b03bef9@ti.com> <CAK7LNASYqkhW_W6K5Y9NvmqnZ2aSCbGZNw0ZFrBB3Dd2FRN8yg@mail.gmail.com>
 <39d9cc92-ef2f-993c-3abd-99b134e1c22e@ti.com>
In-Reply-To: <39d9cc92-ef2f-993c-3abd-99b134e1c22e@ti.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 9 Apr 2019 16:05:41 +0900
X-Gmail-Original-Message-ID: <CAK7LNARKW94j=sOdUd24mNMOcunu9TYXjPMeo_y_kHv7xqnE2Q@mail.gmail.com>
Message-ID: <CAK7LNARKW94j=sOdUd24mNMOcunu9TYXjPMeo_y_kHv7xqnE2Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: omap2: move platform-specific asm-offset.h to arch/arm/mach-omap2
To:     Keerthy <j-keerthy@ti.com>
Cc:     Tony Lindgren <tony@atomide.com>, arm-soc <arm@kernel.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 2:17 PM Keerthy <j-keerthy@ti.com> wrote:
>
>
>
> On 09/04/19 10:37 AM, Masahiro Yamada wrote:
> > On Tue, Apr 9, 2019 at 2:00 PM Keerthy <j-keerthy@ti.com> wrote:
> >>
> >>
> >>
> >> On 08/04/19 9:48 PM, Tony Lindgren wrote:
> >>> Hi,
> >>>
> >>> * Masahiro Yamada <yamada.masahiro@socionext.com> [190408 07:56]:
> >>>> <generated/ti-pm-asm-offsets.h> is only generated and included
> >>>> by arch/arm/mach-omap2/, so it does not need to reside in the
> >>>> globally visible include/generated/.
> >>>>
> >>>> I moved and renamed it to arch/arm/mach-omap2/pm-asm-offsets.h
> >>>> since the prefix 'omap2-' is just redundant in mach-omap2/.
> >>>>
> >>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> >>>> ---
> >>>>
> >>>> Can this be applied to ARM-SOC tree in a series?
> >>>> (with Ack from the platform sub-maintainer.)
> >>>>
> >>>> ti-pm-asm-offsets.h does not need to reside in include/generated/,
> >>>> but you may ask "Why must it get out of include/generated/?"
> >>>>
> >>>> My main motivation is to avoid a race condition in the currently
> >>>> proposed patch:
> >>>>
> >>>> https://lore.kernel.org/patchwork/patch/1052763/
> >>>>
> >>>> This patch tries to embed some build artifacts into the kernel.
> >>>>
> >>>> If arch/arm/mach-omap2/ and kernel/ are built at the same time,
> >>>> it may embed a truncated file.
> >>>
> >>> Looks like a nice improvment to me, adding Keerthy and Dave to Cc.
> >>>
> >>> Keerthy and Dave, can you please test this series with am3 and am4
> >>> PM code?
> >>
> >> Tested for Deep Sleep0 on AM33xx Beaglebone-black.
> >> Tested for Deep Sleep0 on AM437x-gp-evm.
> >>
> >> Applied this on top of Tony's for-next with the gpio patch
> >> required for RTC+DDR mode on am437x-gp-evm.
> >
> > Was it applied to TI tree?
> >
> > If so ...
> >
> > Arnd, Olof,
> > Please just ignore this patch
> > since it looks it was already applied to TI tree.
>
> Masahiro Yamada,
>
> No i manually applied this on top.
>
> Regards,
> Keerthy

Keerthy,
Sorry, I misunderstood.

You just applied it to your local tree for testing.

Then, I still think it is better to
apply this series in a correct order.

The reason I sent this in a series was
to make sure asm-offset headers are correctly
cleaned up.


Thank you.



> >
> > Thanks.
> > Masahiro Yamada
> >
> >
> >
> >
> >> Tested-by: Keerthy <j-keerthy@ti.com>
> >>
> >>>
> >>> Regards,
> >>>
> >>> Tony
> >>>
> >>>>    arch/arm/mach-omap2/.gitignore  | 1 +
> >>>>    arch/arm/mach-omap2/Makefile    | 5 +++--
> >>>>    arch/arm/mach-omap2/sleep33xx.S | 2 +-
> >>>>    arch/arm/mach-omap2/sleep43xx.S | 2 +-
> >>>>    4 files changed, 6 insertions(+), 4 deletions(-)
> >>>>    create mode 100644 arch/arm/mach-omap2/.gitignore
> >>>>
> >>>> diff --git a/arch/arm/mach-omap2/.gitignore b/arch/arm/mach-omap2/.gitignore
> >>>> new file mode 100644
> >>>> index 000000000000..79a8d6ea7152
> >>>> --- /dev/null
> >>>> +++ b/arch/arm/mach-omap2/.gitignore
> >>>> @@ -0,0 +1 @@
> >>>> +pm-asm-offsets.h
> >>>> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> >>>> index 85d1b13c9215..26baeb6477af 100644
> >>>> --- a/arch/arm/mach-omap2/Makefile
> >>>> +++ b/arch/arm/mach-omap2/Makefile
> >>>> @@ -236,9 +236,10 @@ obj-y                                   += omap_phy_internal.o
> >>>>
> >>>>    obj-$(CONFIG_MACH_OMAP2_TUSB6010)  += usb-tusb6010.o
> >>>>
> >>>> -include/generated/ti-pm-asm-offsets.h: arch/arm/mach-omap2/pm-asm-offsets.s FORCE
> >>>> +$(obj)/pm-asm-offsets.h: $(obj)/pm-asm-offsets.s FORCE
> >>>>       $(call filechk,offsets,__TI_PM_ASM_OFFSETS_H__)
> >>>>
> >>>> -$(obj)/sleep33xx.o $(obj)/sleep43xx.o: include/generated/ti-pm-asm-offsets.h
> >>>> +$(obj)/sleep33xx.o $(obj)/sleep43xx.o: $(obj)/pm-asm-offsets.h
> >>>>
> >>>>    targets += pm-asm-offsets.s
> >>>> +clean-files += pm-asm-offsets.h
> >>>> diff --git a/arch/arm/mach-omap2/sleep33xx.S b/arch/arm/mach-omap2/sleep33xx.S
> >>>> index 47a816468cdb..a003769121aa 100644
> >>>> --- a/arch/arm/mach-omap2/sleep33xx.S
> >>>> +++ b/arch/arm/mach-omap2/sleep33xx.S
> >>>> @@ -6,7 +6,6 @@
> >>>>     * Dave Gerlach, Vaibhav Bedia
> >>>>     */
> >>>>
> >>>> -#include <generated/ti-pm-asm-offsets.h>
> >>>>    #include <linux/linkage.h>
> >>>>    #include <linux/platform_data/pm33xx.h>
> >>>>    #include <linux/ti-emif-sram.h>
> >>>> @@ -15,6 +14,7 @@
> >>>>
> >>>>    #include "iomap.h"
> >>>>    #include "cm33xx.h"
> >>>> +#include "pm-asm-offsets.h"
> >>>>
> >>>>    #define AM33XX_CM_CLKCTRL_MODULESTATE_DISABLED                     0x00030000
> >>>>    #define AM33XX_CM_CLKCTRL_MODULEMODE_DISABLE                       0x0003
> >>>> diff --git a/arch/arm/mach-omap2/sleep43xx.S b/arch/arm/mach-omap2/sleep43xx.S
> >>>> index 5b9343b58fc7..aa288f361c5e 100644
> >>>> --- a/arch/arm/mach-omap2/sleep43xx.S
> >>>> +++ b/arch/arm/mach-omap2/sleep43xx.S
> >>>> @@ -6,7 +6,6 @@
> >>>>     * Dave Gerlach, Vaibhav Bedia
> >>>>     */
> >>>>
> >>>> -#include <generated/ti-pm-asm-offsets.h>
> >>>>    #include <linux/linkage.h>
> >>>>    #include <linux/ti-emif-sram.h>
> >>>>    #include <linux/platform_data/pm33xx.h>
> >>>> @@ -19,6 +18,7 @@
> >>>>    #include "iomap.h"
> >>>>    #include "omap-secure.h"
> >>>>    #include "omap44xx.h"
> >>>> +#include "pm-asm-offsets.h"
> >>>>    #include "prm33xx.h"
> >>>>    #include "prcm43xx.h"
> >>>>
> >>>> --
> >>>> 2.17.1
> >>>>
> >
> >
> >
> > --
> > Best Regards
> > Masahiro Yamada
> >



-- 
Best Regards
Masahiro Yamada
