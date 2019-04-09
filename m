Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02617C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C31A12064B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfDIOut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 10:50:49 -0400
Received: from muru.com ([72.249.23.125]:45040 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726396AbfDIOus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 10:50:48 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id A674D8027;
        Tue,  9 Apr 2019 14:51:00 +0000 (UTC)
Date:   Tue, 9 Apr 2019 07:50:42 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Stefan Agner <stefan@agner.ch>
Cc:     arm@kernel.org, linux@armlinux.org.uk, arnd@arndb.de,
        ard.biesheuvel@linaro.org, robin.murphy@arm.com,
        nicolas.pitre@linaro.org, f.fainelli@gmail.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        kgene@kernel.org, krzk@kernel.org, robh@kernel.org,
        ssantosh@kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        marc.w.gonzalez@free.fr, mans@mansr.com, ndesaulniers@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] ARM: use arch_extension directive instead of arch
 argument
Message-ID: <20190409145042.GD2839@atomide.com>
References: <7b3b9d2150d491b5cb3761d96b215749ea63175f.1554757135.git.stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b3b9d2150d491b5cb3761d96b215749ea63175f.1554757135.git.stefan@agner.ch>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Stefan Agner <stefan@agner.ch> [190408 20:59]:
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -41,11 +41,6 @@ obj-$(CONFIG_SOC_OMAP5)			+= $(omap-4-5-common) $(smp-y) sleep44xx.o
>  obj-$(CONFIG_SOC_AM43XX)		+= $(omap-4-5-common)
>  obj-$(CONFIG_SOC_DRA7XX)		+= $(omap-4-5-common) $(smp-y) sleep44xx.o
>  
> -plus_sec := $(call as-instr,.arch_extension sec,+sec)
> -AFLAGS_omap-headsmp.o			:=-Wa,-march=armv7-a$(plus_sec)
> -AFLAGS_omap-smc.o			:=-Wa,-march=armv7-a$(plus_sec)
> -AFLAGS_sleep44xx.o			:=-Wa,-march=armv7-a$(plus_sec)
> -
>  # Functions loaded to SRAM
>  obj-$(CONFIG_SOC_OMAP2420)		+= sram242x.o
>  obj-$(CONFIG_SOC_OMAP2430)		+= sram243x.o
> @@ -95,9 +90,6 @@ obj-$(CONFIG_POWER_AVS_OMAP)		+= sr_device.o
>  obj-$(CONFIG_POWER_AVS_OMAP_CLASS3)    += smartreflex-class3.o
>  
>  AFLAGS_sleep24xx.o			:=-Wa,-march=armv6
> -AFLAGS_sleep34xx.o			:=-Wa,-march=armv7-a$(plus_sec)
> -AFLAGS_sleep33xx.o			:=-Wa,-march=armv7-a$(plus_sec)
> -AFLAGS_sleep43xx.o			:=-Wa,-march=armv7-a$(plus_sec)

I think we should also change the AFLAGS_sleep24xx.o above the
same way but with armv6 flags. This can be build tested with
omap2plus_defconfig.

Regards,

Tony
