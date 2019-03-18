Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36FDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F7BF2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gP0WtdT7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfCRKTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:19:51 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:57808 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbfCRKTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 06:19:51 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2IAJfBw031022;
        Mon, 18 Mar 2019 05:19:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1552904381;
        bh=6+j+kqzqo1HGfZTudS2meYG+2rbederFln7vA7aDkTY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=gP0WtdT7meXhvdf+pq/54B4LOhYJhqX7RE5l86w4kZ+1Vo52dci5qYaa9brb2gxjH
         d8E5sW6Dhlhbw3Buqcgqa9b7CXkEwi89dhufGdB1jBSLqqyvDTdacwQTTQ6W8qRwNs
         37q1kduW8F6h7nrhKx5LKvm2KYFNismytuo1R4AI=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2IAJfxm073482
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 Mar 2019 05:19:41 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 18
 Mar 2019 05:19:40 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Mon, 18 Mar 2019 05:19:40 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2IAJbjI007571;
        Mon, 18 Mar 2019 05:19:38 -0500
Subject: Re: [PATCH v3 5/8] phy: amlogic: add Amlogic G12A USB2 PHY Driver
To:     Neil Armstrong <narmstrong@baylibre.com>,
        <gregkh@linuxfoundation.org>, <hminas@synopsys.com>,
        <balbi@kernel.org>
CC:     <linux-amlogic@lists.infradead.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20190318101153.7531-1-narmstrong@baylibre.com>
 <20190318101153.7531-6-narmstrong@baylibre.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <a0001535-350a-6f3b-a8f4-3b853e4bc990@ti.com>
Date:   Mon, 18 Mar 2019 15:48:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190318101153.7531-6-narmstrong@baylibre.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18/03/19 3:41 PM, Neil Armstrong wrote:
> This adds support for the USB2 PHY found in the Amlogic G12A SoC Family.
> 
> It supports Host and/or Peripheral mode, depending on it's position.
> The first PHY is only used as Host, but the second supports Dual modes
> defined by the USB Control Glue HW in front of the USB Controllers.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/phy/amlogic/Kconfig               |  11 ++
>  drivers/phy/amlogic/Makefile              |   1 +
>  drivers/phy/amlogic/phy-meson-g12a-usb2.c | 189 ++++++++++++++++++++++
>  3 files changed, 201 insertions(+)
>  create mode 100644 drivers/phy/amlogic/phy-meson-g12a-usb2.c
> 
> diff --git a/drivers/phy/amlogic/Kconfig b/drivers/phy/amlogic/Kconfig
> index 23fe1cda2f70..560ff0f1ed4c 100644
> --- a/drivers/phy/amlogic/Kconfig
> +++ b/drivers/phy/amlogic/Kconfig
> @@ -36,3 +36,14 @@ config PHY_MESON_GXL_USB3
>  	  Enable this to support the Meson USB3 PHY and OTG detection
>  	  IP block found in Meson GXL and GXM SoCs.
>  	  If unsure, say N.
> +
> +config PHY_MESON_G12A_USB2
> +	tristate "Meson G12A USB2 PHY driver"
> +	default ARCH_MESON
> +	depends on OF && (ARCH_MESON || COMPILE_TEST)
> +	select GENERIC_PHY
> +	select REGMAP_MMIO
> +	help
> +	  Enable this to support the Meson USB2 PHYs found in Meson
> +	  G12A SoCs.
> +	  If unsure, say N.
> diff --git a/drivers/phy/amlogic/Makefile b/drivers/phy/amlogic/Makefile
> index 4fd8848c194d..7d4d10f5a6b3 100644
> --- a/drivers/phy/amlogic/Makefile
> +++ b/drivers/phy/amlogic/Makefile
> @@ -1,3 +1,4 @@
>  obj-$(CONFIG_PHY_MESON8B_USB2)		+= phy-meson8b-usb2.o
>  obj-$(CONFIG_PHY_MESON_GXL_USB2)	+= phy-meson-gxl-usb2.o
> +obj-$(CONFIG_PHY_MESON_G12A_USB2)	+= phy-meson-g12a-usb2.o
>  obj-$(CONFIG_PHY_MESON_GXL_USB3)	+= phy-meson-gxl-usb3.o
> diff --git a/drivers/phy/amlogic/phy-meson-g12a-usb2.c b/drivers/phy/amlogic/phy-meson-g12a-usb2.c
> new file mode 100644
> index 000000000000..9f35259f237f
> --- /dev/null
> +++ b/drivers/phy/amlogic/phy-meson-g12a-usb2.c
> @@ -0,0 +1,189 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Meson G12A USB2 PHY driver
> + *
> + * Copyright (C) 2017 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> + * Copyright (C) 2017 Amlogic, Inc. All rights reserved
> + * Copyright (C) 2019 BayLibre, SAS
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +
> +#define PHY_CTRL_R0						0x0
> +#define PHY_CTRL_R1						0x4
> +#define PHY_CTRL_R2						0x8
> +#define PHY_CTRL_R3						0xc
> +#define PHY_CTRL_R4						0x10
> +#define PHY_CTRL_R5						0x14
> +#define PHY_CTRL_R6						0x18
> +#define PHY_CTRL_R7						0x1c
> +#define PHY_CTRL_R8						0x20
> +#define PHY_CTRL_R9						0x24
> +#define PHY_CTRL_R10						0x28
> +#define PHY_CTRL_R11						0x2c
> +#define PHY_CTRL_R12						0x30
> +#define PHY_CTRL_R13						0x34
> +#define PHY_CTRL_R14						0x38
> +#define PHY_CTRL_R15						0x3c
> +#define PHY_CTRL_R16						0x40
> +#define PHY_CTRL_R17						0x44
> +#define PHY_CTRL_R18						0x48
> +#define PHY_CTRL_R19						0x4c
> +#define PHY_CTRL_R20						0x50
> +#define PHY_CTRL_R21						0x54
> +#define PHY_CTRL_R22						0x58
> +#define PHY_CTRL_R23						0x5c
> +
> +#define RESET_COMPLETE_TIME					1000
> +#define PLL_RESET_COMPLETE_TIME					100
> +
> +struct phy_meson_g12a_usb2_priv {
> +	struct device		*dev;
> +	struct regmap		*regmap;
> +	struct clk		*clk;
> +	struct reset_control	*reset;
> +};
> +
> +static const struct regmap_config phy_meson_g12a_usb2_regmap_conf = {
> +	.reg_bits = 8,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.max_register = PHY_CTRL_R23,
> +};
> +
> +static int phy_meson_g12a_usb2_init(struct phy *phy)
> +{
> +	struct phy_meson_g12a_usb2_priv *priv = phy_get_drvdata(phy);
> +	int ret;
> +
> +	ret = reset_control_reset(priv->reset);
> +	if (ret)
> +		return ret;
> +
> +	udelay(RESET_COMPLETE_TIME);
> +
> +	/* usb2_otg_aca_en == 0 */
> +	regmap_update_bits(priv->regmap, PHY_CTRL_R21, BIT(2), 0);
> +
> +	/* PLL Setup : 24MHz * 20 / 1 = 480MHz */
> +	regmap_write(priv->regmap, PHY_CTRL_R16, 0x39400414);
> +	regmap_write(priv->regmap, PHY_CTRL_R17, 0x927e0000);
> +	regmap_write(priv->regmap, PHY_CTRL_R18, 0xac5f49e5);

Please add macros for each of the individual bit-fields.
> +
> +	udelay(PLL_RESET_COMPLETE_TIME);
> +
> +	/* UnReset PLL */
> +	regmap_write(priv->regmap, PHY_CTRL_R16, 0x19400414);

Here too..

Thanks
Kishon
