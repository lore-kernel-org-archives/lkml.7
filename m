Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1C1C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92EA220818
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="SocTHFjf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbfDJImd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:42:33 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:47352 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbfDJImc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 04:42:32 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id EEF965C071C;
        Wed, 10 Apr 2019 10:42:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1554885750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7HuqGfOXUK8gw6tqvJtjPvBZ5uOETqKXHcsSaP+O4AE=;
        b=SocTHFjfIYX3ZHTDPmTe7yIRuSkL+dmj4gSX7CvcL6DB3zaMvFDKHCtxf00LVs3WS03lGF
        UEuvwatpIWGpW7ZX2E2ZDxdYL0HhlyLcqwaEcP5ceDaoBZskzo0USPc+MOE8BX8gyFRocA
        errzNE/KYdqvq5usVdv3FOyIOIvLy1U=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Wed, 10 Apr 2019 10:42:30 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Tony Lindgren <tony@atomide.com>
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
In-Reply-To: <20190409145042.GD2839@atomide.com>
References: <7b3b9d2150d491b5cb3761d96b215749ea63175f.1554757135.git.stefan@agner.ch>
 <20190409145042.GD2839@atomide.com>
Message-ID: <7798addc2c24a3a3bee2954a854335cf@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.04.2019 16:50, Tony Lindgren wrote:
> Hi,
> 
> * Stefan Agner <stefan@agner.ch> [190408 20:59]:
>> --- a/arch/arm/mach-omap2/Makefile
>> +++ b/arch/arm/mach-omap2/Makefile
>> @@ -41,11 +41,6 @@ obj-$(CONFIG_SOC_OMAP5)			+= $(omap-4-5-common) $(smp-y) sleep44xx.o
>>  obj-$(CONFIG_SOC_AM43XX)		+= $(omap-4-5-common)
>>  obj-$(CONFIG_SOC_DRA7XX)		+= $(omap-4-5-common) $(smp-y) sleep44xx.o
>>
>> -plus_sec := $(call as-instr,.arch_extension sec,+sec)
>> -AFLAGS_omap-headsmp.o			:=-Wa,-march=armv7-a$(plus_sec)
>> -AFLAGS_omap-smc.o			:=-Wa,-march=armv7-a$(plus_sec)
>> -AFLAGS_sleep44xx.o			:=-Wa,-march=armv7-a$(plus_sec)
>> -
>>  # Functions loaded to SRAM
>>  obj-$(CONFIG_SOC_OMAP2420)		+= sram242x.o
>>  obj-$(CONFIG_SOC_OMAP2430)		+= sram243x.o
>> @@ -95,9 +90,6 @@ obj-$(CONFIG_POWER_AVS_OMAP)		+= sr_device.o
>>  obj-$(CONFIG_POWER_AVS_OMAP_CLASS3)    += smartreflex-class3.o
>>
>>  AFLAGS_sleep24xx.o			:=-Wa,-march=armv6
>> -AFLAGS_sleep34xx.o			:=-Wa,-march=armv7-a$(plus_sec)
>> -AFLAGS_sleep33xx.o			:=-Wa,-march=armv7-a$(plus_sec)
>> -AFLAGS_sleep43xx.o			:=-Wa,-march=armv7-a$(plus_sec)
> 
> I think we should also change the AFLAGS_sleep24xx.o above the
> same way but with armv6 flags. This can be build tested with
> omap2plus_defconfig.

From what I can tell, since those do not add the sec extension they
should work fine for LLVM's integrated assembler. But I agree, for
consistency it would be nice to get rid of them the same way too.

A bit further up, there is also:
AFLAGS_sram242x.o                      :=-Wa,-march=armv6
AFLAGS_sram243x.o                      :=-Wa,-march=armv6

I think those explicit arch definitions are not even necessary since
ARCH_OMAP2 depends on ARCH_MULTI_V6, which cannot be built with pre v6
architecture. So the minimum architecture we build for will be armv6...

In a quick test omap2plus_defconfig builds fine without those AFLAGS. I
will put it through some more testing and drop those flags in v3.

--
Stefan


> 
> Regards,
> 
> Tony
