Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF20CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62ACB20663
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="l4T7eKbt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502204AbfJYLqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 07:46:45 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:38454 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730727AbfJYLqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 07:46:44 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9PBk0uX092059;
        Fri, 25 Oct 2019 06:46:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1572003960;
        bh=gipLVgrX2XvJaGiONhXv6tXJVahdjiAPKwWbGchh4eE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=l4T7eKbtrPl8WPLWtvgXYBxbPq69m9YNnxDLyDkSgbLDCelIyUzFUOucKMsGVWK0V
         KGLjWoXCvcSTwCI/HfGyYuA/BjiMhcXOkfeDkdMHzds+s61L9TR1xJwVmJE7dE53Pt
         Nd4KFvobxMjsHHNsrr15z6mUbKGU121x2FhEc4Jg=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9PBk0VY051064;
        Fri, 25 Oct 2019 06:46:00 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 25
 Oct 2019 06:46:00 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 25 Oct 2019 06:45:49 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9PBjt0R102018;
        Fri, 25 Oct 2019 06:45:56 -0500
Subject: Re: [PATCH v2 2/4] phy: allwinner: add phy driver for USB3 PHY on
 Allwinner H6 SoC
To:     Ondrej Jirman <megous@megous.com>, <linux-sunxi@googlegroups.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
References: <20191024105500.2252707-1-megous@megous.com>
 <20191024105500.2252707-3-megous@megous.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <a1ec53c4-7dc9-3bb3-8193-cfa5baad378e@ti.com>
Date:   Fri, 25 Oct 2019 17:15:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191024105500.2252707-3-megous@megous.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 24/10/19 4:24 PM, Ondrej Jirman wrote:
> From: Icenowy Zheng <icenowy@aosc.io>
> 
> Allwinner H6 SoC contains a USB3 PHY (with USB2 DP/DM lines also
> controlled).
> 
> Add a driver for it.
> 
> The register operations in this driver is mainly extracted from the BSP
> USB3 driver.
> 
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> Acked-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/phy/allwinner/Kconfig           |  12 ++
>  drivers/phy/allwinner/Makefile          |   1 +
>  drivers/phy/allwinner/phy-sun50i-usb3.c | 195 ++++++++++++++++++++++++
>  3 files changed, 208 insertions(+)
>  create mode 100644 drivers/phy/allwinner/phy-sun50i-usb3.c
> 
> diff --git a/drivers/phy/allwinner/Kconfig b/drivers/phy/allwinner/Kconfig
> index 215425296c77..fcae35ddd430 100644
> --- a/drivers/phy/allwinner/Kconfig
> +++ b/drivers/phy/allwinner/Kconfig
> @@ -45,3 +45,15 @@ config PHY_SUN9I_USB
>  	  sun9i SoCs.
>  
>  	  This driver controls each individual USB 2 host PHY.
> +
> +config PHY_SUN50I_USB3
> +	tristate "Allwinner sun50i SoC USB3 PHY driver"
> +	depends on ARCH_SUNXI && HAS_IOMEM && OF
> +	depends on RESET_CONTROLLER
> +	select USB_COMMON

Looks like USB_COMMON is not required here.
> +	select GENERIC_PHY
> +	help
> +	  Enable this to support the USB3.0-capable transceiver that is
> +	  part of some Allwinner sun50i SoCs.
> +
> +	  This driver controls each individual USB 2+3 host PHY combo.
> diff --git a/drivers/phy/allwinner/Makefile b/drivers/phy/allwinner/Makefile
> index 799a65c0b58d..bd74901a1255 100644
> --- a/drivers/phy/allwinner/Makefile
> +++ b/drivers/phy/allwinner/Makefile
> @@ -2,3 +2,4 @@
>  obj-$(CONFIG_PHY_SUN4I_USB)		+= phy-sun4i-usb.o
>  obj-$(CONFIG_PHY_SUN6I_MIPI_DPHY)	+= phy-sun6i-mipi-dphy.o
>  obj-$(CONFIG_PHY_SUN9I_USB)		+= phy-sun9i-usb.o
> +obj-$(CONFIG_PHY_SUN50I_USB3)		+= phy-sun50i-usb3.o
> diff --git a/drivers/phy/allwinner/phy-sun50i-usb3.c b/drivers/phy/allwinner/phy-sun50i-usb3.c
> new file mode 100644
> index 000000000000..8e170a4d0a11
> --- /dev/null
> +++ b/drivers/phy/allwinner/phy-sun50i-usb3.c
> @@ -0,0 +1,195 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Allwinner sun50i(H6) USB 3.0 phy driver
> + *
> + * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
> + *
> + * Based on phy-sun9i-usb.c, which is:
> + *
> + * Copyright (C) 2014-2015 Chen-Yu Tsai <wens@csie.org>
> + *
> + * Based on code from Allwinner BSP, which is:
> + *
> + * Copyright (c) 2010-2015 Allwinner Technology Co., Ltd.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/phy/phy.h>
> +#include <linux/usb/of.h>

this too..

Thanks
Kishon
