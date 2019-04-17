Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7FBC10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 06:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A59C02176F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 06:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DPzqPAkR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730968AbfDQGoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 02:44:17 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:45554 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbfDQGoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 02:44:17 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3H6hrcB129964;
        Wed, 17 Apr 2019 01:43:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555483434;
        bh=B9udiJEFVdCwzscsnoTaJCICTdb9Kfq7kh6gipjWYO4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=DPzqPAkR8Oq13IG3p0qdFJyorIwIk6xil6z3hk3sI7zdm47EjWwKZwcgl7q1bHstk
         h9bpeTVVRz49O1QGHRCm565DDXg/BaQqHrPDsV1kDORloo0P/82eMZm0kta8lrJB8H
         VwAahFzG0+4GxtoqsWnT/X+j+X4ei69RVe8ipgPc=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3H6hrIf092578
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 17 Apr 2019 01:43:53 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 17
 Apr 2019 01:43:53 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 17 Apr 2019 01:43:53 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3H6hg03078831;
        Wed, 17 Apr 2019 01:43:43 -0500
Subject: Re: [PATCH v5 07/13] phy: Add usb phy support for hi3660 Soc of
 Hisilicon
To:     Yu Chen <chenyu56@huawei.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <john.stultz@linaro.org>, <suzhuangluan@hisilicon.com>,
        <kongfei@hisilicon.com>, <liuyu712@hisilicon.com>,
        <wanghu17@hisilicon.com>, <butao@hisilicon.com>,
        <chenyao11@huawei.com>, <fangshengzhou@hisilicon.com>,
        <lipengcheng8@huawei.com>, <songxiaowei@hisilicon.com>,
        <xuyiping@hisilicon.com>, <xuyoujun4@huawei.com>,
        <yudongbin@hisilicon.com>, <zangleigang@hisilicon.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        Pengcheng Li <lpc.li@hisilicon.com>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jiancheng Xue <xuejiancheng@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>
References: <20190329041409.70138-1-chenyu56@huawei.com>
 <20190329041409.70138-8-chenyu56@huawei.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <2be3f2cf-ce16-d4b4-0d07-dda2a25c76d8@ti.com>
Date:   Wed, 17 Apr 2019 12:12:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190329041409.70138-8-chenyu56@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 29/03/19 9:44 AM, Yu Chen wrote:
> This driver handles usb phy power on and shutdown for hi3660 Soc of
> Hisilicon.
> 
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Pengcheng Li <lpc.li@hisilicon.com>
> Cc: Jianguo Sun <sunjianguo1@huawei.com>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Jiancheng Xue <xuejiancheng@hisilicon.com>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Binghui Wang <wangbinghui@hisilicon.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Yu Chen <chenyu56@huawei.com>
> ---
> v1:
> * Remove unused code and add comment for time delay as suggested by
> Kishon Vijay Abraham I.
> v2:
> * Fix license declaration.
> * Remove redundant parens.
> * Remove unused member variables in struct hi3660_priv.
> v4:
> * Add comments for HI3660_USB_DEFAULT_PHY_PARAM.
> * Add margin for usleep_range.
> * Get regmap of otg_bc from parent's of_node.
> ---
> ---
>  MAINTAINERS                             |   8 ++
>  drivers/phy/hisilicon/Kconfig           |  10 ++
>  drivers/phy/hisilicon/Makefile          |   1 +
>  drivers/phy/hisilicon/phy-hi3660-usb3.c | 233 ++++++++++++++++++++++++++++++++
>  4 files changed, 252 insertions(+)
>  create mode 100644 drivers/phy/hisilicon/phy-hi3660-usb3.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3e5a5d263f29..c0057dd82dbd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16084,6 +16084,14 @@ L:	linux-usb@vger.kernel.org
>  S:	Maintained
>  F:	drivers/usb/roles/intel-xhci-usb-role-switch.c
>  
> +USB IP DRIVER FOR HISILICON KIRIN
> +M:	Yu Chen <chenyu56@huawei.com>
> +M:	Binghui Wang <wangbinghui@hisilicon.com>
> +L:	linux-usb@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt

I don't seem to have received the dt-binding patch. Can you please resend with
updated tags?

Thanks
Kishon

> +F:	drivers/phy/hisilicon/phy-hi3660-usb3.c
> +
>  USB ISP116X DRIVER
>  M:	Olav Kongas <ok@artecdesign.ee>
>  L:	linux-usb@vger.kernel.org
> diff --git a/drivers/phy/hisilicon/Kconfig b/drivers/phy/hisilicon/Kconfig
> index b40ee54a1a50..3c142f08987c 100644
> --- a/drivers/phy/hisilicon/Kconfig
> +++ b/drivers/phy/hisilicon/Kconfig
> @@ -12,6 +12,16 @@ config PHY_HI6220_USB
>  
>  	  To compile this driver as a module, choose M here.
>  
> +config PHY_HI3660_USB
> +	tristate "hi3660 USB PHY support"
> +	depends on (ARCH_HISI && ARM64) || COMPILE_TEST
> +	select GENERIC_PHY
> +	select MFD_SYSCON
> +	help
> +	  Enable this to support the HISILICON HI3660 USB PHY.
> +
> +	  To compile this driver as a module, choose M here.
> +
>  config PHY_HISTB_COMBPHY
>  	tristate "HiSilicon STB SoCs COMBPHY support"
>  	depends on (ARCH_HISI && ARM64) || COMPILE_TEST
> diff --git a/drivers/phy/hisilicon/Makefile b/drivers/phy/hisilicon/Makefile
> index f662a4fe18d8..75ba64e2faf8 100644
> --- a/drivers/phy/hisilicon/Makefile
> +++ b/drivers/phy/hisilicon/Makefile
> @@ -1,4 +1,5 @@
>  obj-$(CONFIG_PHY_HI6220_USB)		+= phy-hi6220-usb.o
> +obj-$(CONFIG_PHY_HI3660_USB)		+= phy-hi3660-usb3.o
>  obj-$(CONFIG_PHY_HISTB_COMBPHY)		+= phy-histb-combphy.o
>  obj-$(CONFIG_PHY_HISI_INNO_USB2)	+= phy-hisi-inno-usb2.o
>  obj-$(CONFIG_PHY_HIX5HD2_SATA)		+= phy-hix5hd2-sata.o
> diff --git a/drivers/phy/hisilicon/phy-hi3660-usb3.c b/drivers/phy/hisilicon/phy-hi3660-usb3.c
> new file mode 100644
> index 000000000000..cc0af2c044d0
> --- /dev/null
> +++ b/drivers/phy/hisilicon/phy-hi3660-usb3.c
> @@ -0,0 +1,233 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Phy provider for USB 3.0 controller on HiSilicon 3660 platform
> + *
> + * Copyright (C) 2017-2018 Hilisicon Electronics Co., Ltd.
> + *		http://www.huawei.com
> + *
> + * Authors: Yu Chen <chenyu56@huawei.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#define PERI_CRG_CLK_EN4			0x40
> +#define PERI_CRG_CLK_DIS4			0x44
> +#define GT_CLK_USB3OTG_REF			BIT(0)
> +#define GT_ACLK_USB3OTG				BIT(1)
> +
> +#define PERI_CRG_RSTEN4				0x90
> +#define PERI_CRG_RSTDIS4			0x94
> +#define IP_RST_USB3OTGPHY_POR			BIT(3)
> +#define IP_RST_USB3OTG				BIT(5)
> +
> +#define PERI_CRG_ISODIS				0x148
> +#define USB_REFCLK_ISO_EN			BIT(25)
> +
> +#define PCTRL_PERI_CTRL3			0x10
> +#define PCTRL_PERI_CTRL3_MSK_START		16
> +#define USB_TCXO_EN				BIT(1)
> +
> +#define PCTRL_PERI_CTRL24			0x64
> +#define SC_CLK_USB3PHY_3MUX1_SEL		BIT(25)
> +
> +#define USBOTG3_CTRL0				0x00
> +#define SC_USB3PHY_ABB_GT_EN			BIT(15)
> +
> +#define USBOTG3_CTRL2				0x08
> +#define USBOTG3CTRL2_POWERDOWN_HSP		BIT(0)
> +#define USBOTG3CTRL2_POWERDOWN_SSP		BIT(1)
> +
> +#define USBOTG3_CTRL3				0x0C
> +#define USBOTG3_CTRL3_VBUSVLDEXT		BIT(6)
> +#define USBOTG3_CTRL3_VBUSVLDEXTSEL		BIT(5)
> +
> +#define USBOTG3_CTRL4				0x10
> +
> +#define USBOTG3_CTRL7				0x1c
> +#define REF_SSP_EN				BIT(16)
> +
> +/* This value config the default txtune parameter of the usb 2.0 phy */
> +#define HI3660_USB_DEFAULT_PHY_PARAM		0x1c466e3
> +
> +struct hi3660_priv {
> +	struct device *dev;
> +	struct regmap *peri_crg;
> +	struct regmap *pctrl;
> +	struct regmap *otg_bc;
> +	u32 eye_diagram_param;
> +};
> +
> +static int hi3660_phy_init(struct phy *phy)
> +{
> +	struct hi3660_priv *priv = phy_get_drvdata(phy);
> +	u32 val, mask;
> +	int ret;
> +
> +	/* usb refclk iso disable */
> +	ret = regmap_write(priv->peri_crg, PERI_CRG_ISODIS, USB_REFCLK_ISO_EN);
> +	if (ret)
> +		goto out;
> +
> +	/* enable usb_tcxo_en */
> +	val = USB_TCXO_EN | (USB_TCXO_EN << PCTRL_PERI_CTRL3_MSK_START);
> +	ret = regmap_write(priv->pctrl, PCTRL_PERI_CTRL3, val);
> +	if (ret)
> +		goto out;
> +
> +	/* assert phy */
> +	val = IP_RST_USB3OTGPHY_POR | IP_RST_USB3OTG;
> +	ret = regmap_write(priv->peri_crg, PERI_CRG_RSTEN4, val);
> +	if (ret)
> +		goto out;
> +
> +	/* enable phy ref clk */
> +	val = SC_USB3PHY_ABB_GT_EN;
> +	mask = val;
> +	ret = regmap_update_bits(priv->otg_bc, USBOTG3_CTRL0, mask, val);
> +	if (ret)
> +		goto out;
> +
> +	val = REF_SSP_EN;
> +	mask = val;
> +	ret = regmap_update_bits(priv->otg_bc, USBOTG3_CTRL7, mask, val);
> +	if (ret)
> +		goto out;
> +
> +	/* exit from IDDQ mode */
> +	mask = USBOTG3CTRL2_POWERDOWN_HSP | USBOTG3CTRL2_POWERDOWN_SSP;
> +	ret = regmap_update_bits(priv->otg_bc, USBOTG3_CTRL2, mask, 0);
> +	if (ret)
> +		goto out;
> +
> +	/* delay for exit from IDDQ mode */
> +	usleep_range(100, 120);
> +
> +	/* deassert phy */
> +	val = IP_RST_USB3OTGPHY_POR | IP_RST_USB3OTG;
> +	ret = regmap_write(priv->peri_crg, PERI_CRG_RSTDIS4, val);
> +	if (ret)
> +		goto out;
> +
> +	/* delay for phy deasserted */
> +	usleep_range(10000, 15000);
> +
> +	/* fake vbus valid signal */
> +	val = USBOTG3_CTRL3_VBUSVLDEXT | USBOTG3_CTRL3_VBUSVLDEXTSEL;
> +	mask = val;
> +	ret = regmap_update_bits(priv->otg_bc, USBOTG3_CTRL3, mask, val);
> +	if (ret)
> +		goto out;
> +
> +	/* delay for vbus valid */
> +	usleep_range(100, 120);
> +
> +	ret = regmap_write(priv->otg_bc, USBOTG3_CTRL4,
> +			priv->eye_diagram_param);
> +	if (ret)
> +		goto out;
> +
> +	return 0;
> +out:
> +	dev_err(priv->dev, "failed to init phy ret: %d\n", ret);
> +	return ret;
> +}
> +
> +static int hi3660_phy_exit(struct phy *phy)
> +{
> +	struct hi3660_priv *priv = phy_get_drvdata(phy);
> +	u32 val;
> +	int ret;
> +
> +	/* assert phy */
> +	val = IP_RST_USB3OTGPHY_POR;
> +	ret = regmap_write(priv->peri_crg, PERI_CRG_RSTEN4, val);
> +	if (ret)
> +		goto out;
> +
> +	/* disable usb_tcxo_en */
> +	val = USB_TCXO_EN << PCTRL_PERI_CTRL3_MSK_START;
> +	ret = regmap_write(priv->pctrl, PCTRL_PERI_CTRL3, val);
> +	if (ret)
> +		goto out;
> +
> +	return 0;
> +out:
> +	dev_err(priv->dev, "failed to exit phy ret: %d\n", ret);
> +	return ret;
> +}
> +
> +static struct phy_ops hi3660_phy_ops = {
> +	.init		= hi3660_phy_init,
> +	.exit		= hi3660_phy_exit,
> +	.owner		= THIS_MODULE,
> +};
> +
> +static int hi3660_phy_probe(struct platform_device *pdev)
> +{
> +	struct phy_provider *phy_provider;
> +	struct device *dev = &pdev->dev;
> +	struct phy *phy;
> +	struct hi3660_priv *priv;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->dev = dev;
> +	priv->peri_crg = syscon_regmap_lookup_by_phandle(dev->of_node,
> +					"hisilicon,pericrg-syscon");
> +	if (IS_ERR(priv->peri_crg)) {
> +		dev_err(dev, "no hisilicon,pericrg-syscon\n");
> +		return PTR_ERR(priv->peri_crg);
> +	}
> +
> +	priv->pctrl = syscon_regmap_lookup_by_phandle(dev->of_node,
> +					"hisilicon,pctrl-syscon");
> +	if (IS_ERR(priv->pctrl)) {
> +		dev_err(dev, "no hisilicon,pctrl-syscon\n");
> +		return PTR_ERR(priv->pctrl);
> +	}
> +
> +	/* node of hi3660 phy is a sub-node of usb3_otg_bc */
> +	priv->otg_bc = syscon_node_to_regmap(dev->parent->of_node);
> +	if (IS_ERR(priv->otg_bc)) {
> +		dev_err(dev, "no hisilicon,usb3-otg-bc-syscon\n");
> +		return PTR_ERR(priv->otg_bc);
> +	}
> +
> +	if (of_property_read_u32(dev->of_node, "hisilicon,eye-diagram-param",
> +		&(priv->eye_diagram_param)))
> +		priv->eye_diagram_param = HI3660_USB_DEFAULT_PHY_PARAM;
> +
> +	phy = devm_phy_create(dev, NULL, &hi3660_phy_ops);
> +	if (IS_ERR(phy))
> +		return PTR_ERR(phy);
> +
> +	phy_set_drvdata(phy, priv);
> +	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> +	return PTR_ERR_OR_ZERO(phy_provider);
> +}
> +
> +static const struct of_device_id hi3660_phy_of_match[] = {
> +	{.compatible = "hisilicon,hi3660-usb-phy",},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, hi3660_phy_of_match);
> +
> +static struct platform_driver hi3660_phy_driver = {
> +	.probe	= hi3660_phy_probe,
> +	.driver = {
> +		.name	= "hi3660-usb-phy",
> +		.of_match_table	= hi3660_phy_of_match,
> +	}
> +};
> +module_platform_driver(hi3660_phy_driver);
> +
> +MODULE_AUTHOR("Yu Chen <chenyu56@huawei.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Hilisicon Hi3660 USB3 PHY Driver");
> 
