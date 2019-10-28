Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DD7CA9EC1
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 14:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5AD3208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 14:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JStZEYnc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390191AbfJ1Ogt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 10:36:49 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33669 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729377AbfJ1Ogs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 10:36:48 -0400
Received: by mail-pg1-f196.google.com with SMTP id u23so7022796pgo.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 07:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PmRx5dALyuiFb1deH7EkGB+5sMkPmmG95+n7Hin0SRc=;
        b=JStZEYncHmSdREz0qBlxsDMFN2uBP6Q3CK4+XyqH64qAjgci/VtW+3PsD91H7B3UE/
         KoLSTTBstOKiOJkqOaHfcCmZJse26kwFYl8QtItcNqRKfNCbGfzEd095Rg7Z+kBD55NQ
         5zb5IFoZBg2afshGXtCP1cYhZJRGnCnckRCci0EYOBnu7uGUQ40hdDDd/7Dp2oOLgx3O
         sAud2YpY3yXziHjE39cWlPPIJlpguBVvOzLSuam7jQVEC86eC5iUVNvjZF46B0xSgRkc
         f5wQnT5Tw+FReSu+dsA6PB9o7hSJpAHJYMmx/DMJtYkdOLjhAAeKYGfIAk9r6iJMzDxJ
         QKkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PmRx5dALyuiFb1deH7EkGB+5sMkPmmG95+n7Hin0SRc=;
        b=XL20U3c7mmdBtsTWogAg8tEVAvDBSWjNPrNIx3CUYvgS7n/n+k5qlZrXrVHrOTVCYi
         ki1jAYY8sNcK1bzhrioYOPOoMgnE3LISCUmS2KaPDrdo/+OGEccsVgo2FSBycuCRliIN
         OcroNfkornZzPZ08nV18aCXoC7yAQmxmZcRh11J0fdAh/nwmGZ+55cdvwmBGjLkrNL3M
         IwXkDr2W4izfKy+c0/uZ9QFA0rtCsXq9PGxLjzy23luq52W8IdPl59KyBeorORoLt9tZ
         xRlgXTr1Qg+x0AMv7CRl/hHYLRFXwC+N0/78y0C1p9Yf/eQ2fXCNGNUTEc7MRAfnTq3Z
         ALpg==
X-Gm-Message-State: APjAAAXnhdDVH95DmcNdYypIG+IZv0YleVrZmiLAmS7BAnhr3mUsfyD4
        UZSu+mKxG8YRb4t3fvrulUcl
X-Google-Smtp-Source: APXvYqzACd6bDvccTM4kU0yF1t/3ns8eVeICep9JeWWjs1NcRgEF8ewe5gp5jxsSj987hN2Vymssuw==
X-Received: by 2002:a17:90a:d588:: with SMTP id v8mr356542pju.51.1572273407017;
        Mon, 28 Oct 2019 07:36:47 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6004:d1fe:706d:952a:57bd:23b6])
        by smtp.gmail.com with ESMTPSA id w6sm10947901pfw.84.2019.10.28.07.36.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Oct 2019 07:36:46 -0700 (PDT)
Date:   Mon, 28 Oct 2019 20:06:38 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     s.hauer@pengutronix.de, robh+dt@kernel.org, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        darshak.patel@einfochips.com, prajose.john@einfochips.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, pavel@ucw.cz,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: freescale: Add devicetree support for
 Thor96 board
Message-ID: <20191028143638.GA29832@Mani-XPS-13-9360>
References: <20191024144235.3182-1-manivannan.sadhasivam@linaro.org>
 <20191024144235.3182-3-manivannan.sadhasivam@linaro.org>
 <20191028115110.GE16985@dragon>
 <20191028142732.GA29312@Mani-XPS-13-9360>
 <20191028143240.GO16985@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028143240.GO16985@dragon>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

On Mon, Oct 28, 2019 at 10:32:42PM +0800, Shawn Guo wrote:
> On Mon, Oct 28, 2019 at 07:57:32PM +0530, Manivannan Sadhasivam wrote:
> > Hi Shawn,
> > 
> > On Mon, Oct 28, 2019 at 07:51:12PM +0800, Shawn Guo wrote:
> > > On Thu, Oct 24, 2019 at 08:12:34PM +0530, Manivannan Sadhasivam wrote:
> > > > Add devicetree support for Thor96 board from Einfochips. This board is
> > > > one of the 96Boards Consumer Edition platform powered by the NXP
> > > > i.MX8MQ SoC.
> > > > 
> > > > Following are the features supported currently:
> > > > 
> > > > 1. uSD
> > > > 2. WiFi/BT
> > > > 3. Ethernet
> > > > 4. EEPROM (M24256)
> > > > 5. NOR Flash (W25Q256JW)
> > > > 6. 2xUSB3.0 ports and 1xUSB2.0 port at HS expansion
> > > > 
> > > > More information about this board can be found in Arrow website:
> > > > https://www.arrow.com/en/products/i.imx8-thor96/arrow-development-tools
> > > > 
> > > > Link to 96Boards CE Specification: https://linaro.co/ce-specification
> > > > 
> > > > Signed-off-by: Darshak Patel <darshak.patel@einfochips.com>
> > > > [Mani: cleaned up for upstream]
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > ---
> > > >  arch/arm64/boot/dts/freescale/Makefile        |   1 +
> > > >  .../boot/dts/freescale/imx8mq-thor96.dts      | 581 ++++++++++++++++++
> > > >  2 files changed, 582 insertions(+)
> > > >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-thor96.dts
> > > > 
> > > > diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> > > > index 93fce8f0c66d..dec1662019be 100644
> > > > --- a/arch/arm64/boot/dts/freescale/Makefile
> > > > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > > > @@ -28,6 +28,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mq-hummingboard-pulse.dtb
> > > >  dtb-$(CONFIG_ARCH_MXC) += imx8mq-librem5-devkit.dtb
> > > >  dtb-$(CONFIG_ARCH_MXC) += imx8mq-nitrogen.dtb
> > > >  dtb-$(CONFIG_ARCH_MXC) += imx8mq-pico-pi.dtb
> > > > +dtb-$(CONFIG_ARCH_MXC) += imx8mq-thor96.dtb
> > > >  dtb-$(CONFIG_ARCH_MXC) += imx8mq-zii-ultra-rmb3.dtb
> > > >  dtb-$(CONFIG_ARCH_MXC) += imx8mq-zii-ultra-zest.dtb
> > > >  dtb-$(CONFIG_ARCH_MXC) += imx8qxp-ai_ml.dtb
> > > > diff --git a/arch/arm64/boot/dts/freescale/imx8mq-thor96.dts b/arch/arm64/boot/dts/freescale/imx8mq-thor96.dts
> > > > new file mode 100644
> > > > index 000000000000..e1adf24c2602
> > > > --- /dev/null
> > > > +++ b/arch/arm64/boot/dts/freescale/imx8mq-thor96.dts
> > > > @@ -0,0 +1,581 @@
> > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > +/*
> > > > + * Copyright 2019 Einfochips
> > > > + * Copyright 2019 Linaro Ltd.
> > > > + */
> > > > +
> > > > +/dts-v1/;
> > > > +
> > > > +#include "imx8mq.dtsi"
> > > > +
> > > > +/ {
> > > > +	model = "Einfochips i.MX8MQ Thor96";
> > > > +	compatible = "einfochips,imx8mq-thor96", "fsl,imx8mq";
> > > > +
> > > > +	chosen {
> > > > +		stdout-path = &uart1;
> > > > +	};
> > > > +
> > > > +	memory@40000000 {
> > > > +		device_type = "memory";
> > > > +		reg = <0x00000000 0x40000000 0 0x80000000>;
> > > > +	};
> > > > +
> > > > +	leds {
> > > > +		compatible = "gpio-leds";
> > > > +		pinctrl-names = "default";
> > > > +		pinctrl-0 = <&pinctrl_leds>;
> > > > +
> > > > +		user-led1 {
> > > > +			label = "green:user1";
> > > > +			gpios = <&gpio4 21 GPIO_ACTIVE_HIGH>;
> > > > +			linux,default-trigger = "heartbeat";
> > > > +		};
> > > > +
> > > > +		user-led2 {
> > > > +			label = "green:user2";
> > > > +			gpios = <&gpio4 22 GPIO_ACTIVE_HIGH>;
> > > > +			linux,default-trigger = "none";
> > > 
> > > I see linux,default-trigger is defined in Documentation/devicetree/bindings/leds/common.txt
> > > with given string values. "none" and the following ones are not there.
> > > I'm not sure how this works.
> > > 
> > 
> > The devicetree binding is not updated. I think folks just added triggers
> > to the respective places but didn't bother to update the binding.
> 
> Can you please bring the bindings up to date?  It will help people like
> me a lot.
> 

Sure thing. It will help everyone :) If Pavel has no objections on this (incase
if someone did/working on it), I'll add a patch to next iteration.

Thanks,
Mani

> Shawn
> 
> > 
> > For instance, mmc* trigger is registered here:
> > https://elixir.bootlin.com/linux/v5.4-rc2/source/drivers/mmc/core/host.c#L476
> > 
> > For `none`, it is like removing the trigger. This is the default mode if the
> > trigger property is not present:
> > https://elixir.bootlin.com/linux/v5.4-rc2/source/drivers/leds/led-triggers.c#L113
> > 
> > You can see the list of LED triggers by `cat`ing this file:
> > /sys/class/leds/<led>/trigger
> > 
> > Copied Pavel and LED list for reference.
