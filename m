Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A0CC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8747820675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="z+x8qGnD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfCGJqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 04:46:02 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36880 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfCGJqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 04:46:01 -0500
Received: by mail-wr1-f66.google.com with SMTP id w6so16608462wrs.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 01:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Ve7V2yCQOjpTGdtJ5sMOFtR2Kned9l6VanYo0E1+O4A=;
        b=z+x8qGnDW49OZa9udojJcrkxslsvSK+7uJfF8iLuLra7YksLRO/SEZ7GzbvQTiK/JB
         AQ1AiK70vujSlfS/8936kqbq7+InRm3kqu05YW/GLNlK9Axn0mKSXdJISZpzLBm/8pZw
         cE3fwdDCxL7DJjRAV2qBViX06tZ0edYlCpNnyFZcsIlGXTXVmogE1n9rWw6vhVNerBJb
         lHYNVMQtr5g3gp4vZ3XcBdHUNh2PinIVGIBDY2u15wz+eL4p0sWao34J9GWVNKsqKSX7
         CBnFlGSrRbFcRiYg9PHEGPues/oWzci792GbgAervU4YcGKTmkCZ52MKo2TVjWFEeJYl
         XWGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Ve7V2yCQOjpTGdtJ5sMOFtR2Kned9l6VanYo0E1+O4A=;
        b=qBoirUJYW6hGlRc0UnaCK5kpVt1rnHEtKPlwYcOZlnRrzJ7dQyWAjO7gg9Cs7zhPhh
         S67vIl0qy67FrhQyeGhujeNvb6U3LKTOhD/M/Hzn1XUilZvQCZCuAhfpMOVyRCh/1Aax
         bs5syn1gMSvyXMQnG9HhNRUQm+HiqVIy/W3+c9TYLruaTbSIQ8SfbGY1YMbYzvlxiLt/
         ArftDFNjzvbqrK+sniS//eP0BvLX5aLETTRVAxEIUXDNR5IIFL037YmrjURTski0j0fL
         jRWD1uvztnCIuHchqKRxuzpK4fX+kxRwQLBJD5Nt0USGSdzzMCZr2LEJsI9ap8lCyg37
         EW7Q==
X-Gm-Message-State: APjAAAU1+z2920BmeBi1oYFDPr2rq2txMOv6eDaXhXMPOeaXhK6ihARi
        1vl2XEyofWZZBiyezIiWIdQrh1GWqOtq0A==
X-Google-Smtp-Source: APXvYqzx0OojWRbjI+xBZ+LV2wYthhIKkc3/nqnYRCqDytTWj86OEcp1jO/TmJnBARRn9xvmBro/qg==
X-Received: by 2002:a5d:458b:: with SMTP id p11mr6330064wrq.22.1551951957996;
        Thu, 07 Mar 2019 01:45:57 -0800 (PST)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c12sm1399847wrt.68.2019.03.07.01.45.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 01:45:57 -0800 (PST)
Subject: Re: [PATCH v2 8/8] usb: dwc3: Add Amlogic G12A DWC3 glue
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com, linux-amlogic@lists.infradead.org,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20190304103846.2060-1-narmstrong@baylibre.com>
 <20190304103846.2060-9-narmstrong@baylibre.com>
 <1551924176.2210.104.camel@mhfsdcap03>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <6eaff413-d2c7-125a-f165-e4226c7a153e@baylibre.com>
Date:   Thu, 7 Mar 2019 10:45:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1551924176.2210.104.camel@mhfsdcap03>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2019 03:02, Chunfeng Yun wrote:
> Hi,
> On Mon, 2019-03-04 at 11:38 +0100, Neil Armstrong wrote:
>> Adds support for Amlogic G12A USB Control Glue HW.
>>
>> The Amlogic G12A SoC Family embeds 2 USB Controllers :
>> - a DWC3 IP configured as Host for USB2 and USB3
>> - a DWC2 IP configured as Peripheral USB2 Only
>>
>> A glue connects these both controllers to 2 USB2 PHYs, and optionnally
>> to an USB3+PCIE Combo PHY shared with the PCIE controller.
>>
>> The Glue configures the UTMI 8bit interfaces for the USB2 PHYs, including
>> routing of the OTG PHY between the DWC3 and DWC2 controllers, and
>> setups the on-chip OTG mode selection for this PHY.
>>
>> This drivers supports the on-probe setup of the OTG mode, and manually
>> via a debugfs interface. The IRQ mode change detect is yet to be added
>> in a future patchset, mainly due to lack of hardware to validate on.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/usb/dwc3/Kconfig           |  10 +
>>  drivers/usb/dwc3/Makefile          |   1 +
>>  drivers/usb/dwc3/dwc3-meson-g12a.c | 601 +++++++++++++++++++++++++++++
>>  3 files changed, 612 insertions(+)
>>  create mode 100644 drivers/usb/dwc3/dwc3-meson-g12a.c
>>
>> diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
>> index 1a0404fda596..21ce7368d325 100644
>> --- a/drivers/usb/dwc3/Kconfig
>> +++ b/drivers/usb/dwc3/Kconfig
>> @@ -93,6 +93,16 @@ config USB_DWC3_KEYSTONE
>>  	  Support of USB2/3 functionality in TI Keystone2 platforms.
>>  	  Say 'Y' or 'M' here if you have one such device
>>  
>> +config USB_DWC3_MESON_G12A
>> +       tristate "Amlogic Meson G12A Platforms"
>> +       depends on OF && COMMON_CLK
>> +       depends on ARCH_MESON || COMPILE_TEST
>> +       default USB_DWC3
>> +       select USB_ROLE_SWITCH
>> +       help
>> +         Support USB2/3 functionality in Amlogic G12A platforms.
>> +	 Say 'Y' or 'M' if you have one such device.
>> +
>>  config USB_DWC3_OF_SIMPLE
>>         tristate "Generic OF Simple Glue Layer"
>>         depends on OF && COMMON_CLK
>> diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
>> index 6e3ef6144e5d..ae86da0dc5bd 100644
>> --- a/drivers/usb/dwc3/Makefile
>> +++ b/drivers/usb/dwc3/Makefile
>> @@ -47,6 +47,7 @@ obj-$(CONFIG_USB_DWC3_EXYNOS)		+= dwc3-exynos.o
>>  obj-$(CONFIG_USB_DWC3_PCI)		+= dwc3-pci.o
>>  obj-$(CONFIG_USB_DWC3_HAPS)		+= dwc3-haps.o
>>  obj-$(CONFIG_USB_DWC3_KEYSTONE)		+= dwc3-keystone.o
>> +obj-$(CONFIG_USB_DWC3_MESON_G12A)	+= dwc3-meson-g12a.o
>>  obj-$(CONFIG_USB_DWC3_OF_SIMPLE)	+= dwc3-of-simple.o
>>  obj-$(CONFIG_USB_DWC3_ST)		+= dwc3-st.o
>>  obj-$(CONFIG_USB_DWC3_QCOM)		+= dwc3-qcom.o
>> diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
>> new file mode 100644
>> index 000000000000..75942614a034
>> --- /dev/null
>> +++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
>> @@ -0,0 +1,601 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * USB Glue for Amlogic G12A SoCs
>> + *
>> + * Copyright (c) 2019 BayLibre, SAS
>> + * Author: Neil Armstrong <narmstrong@baylibre.com>
>> + */
>> +
>> +/*
>> + * The USB is organized with a glue around the DWC3 Controller IP as :
>> + * - Control registers for each USB2 Ports
>> + * - Control registers for the USB PHY layer
>> + * - SuperSpeed PHY can be enabled only if port is used
>> + *
>> + * TOFIX:
>> + * - Add dynamic OTG switching with ID change interrupt
>> + */
>> +
> [...]
>> +
>> +static int dwc3_meson_g12a_probe(struct platform_device *pdev)
>> +{
>> +	struct dwc3_meson_g12a	*priv;
>> +	struct device		*dev = &pdev->dev;
>> +	struct device_node	*np = dev->of_node;
>> +	void __iomem *base;
>> +	struct resource *res;
>> +	enum phy_mode otg_id;
>> +	int ret, i;
>> +
>> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	base = devm_ioremap_resource(dev, res);
>> +	if (IS_ERR(base))
>> +		return PTR_ERR(base);
>> +
>> +	priv->regmap = devm_regmap_init_mmio(dev, base,
>> +					     &phy_meson_g12a_usb3_regmap_conf);
>> +	if (IS_ERR(priv->regmap))
>> +		return PTR_ERR(priv->regmap);
>> +
>> +	priv->vbus = devm_regulator_get_optional(dev, "vbus");
>> +	if (IS_ERR(priv->vbus)) {
>> +		if (PTR_ERR(priv->vbus) == -EPROBE_DEFER)
>> +			return PTR_ERR(priv->vbus);
>> +		priv->vbus = NULL;
>> +	}
>> +
>> +	priv->clk = devm_clk_get(dev, NULL);
>> +	if (IS_ERR(priv->clk))
>> +		return PTR_ERR(priv->clk);
>> +
>> +	ret = clk_prepare_enable(priv->clk);
>> +	if (ret)
>> +		return ret;
>> +
>> +	platform_set_drvdata(pdev, priv);
>> +	priv->dev = dev;
>> +
>> +	priv->reset = devm_reset_control_get(dev, NULL);
>> +	if (IS_ERR(priv->reset)) {
>> +		ret = PTR_ERR(priv->reset);
>> +		dev_err(dev, "failed to get device reset, err=%d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = reset_control_reset(priv->reset);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = dwc3_meson_g12a_get_phys(priv);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = regulator_enable(priv->vbus);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Get dr_mode */
>> +	priv->otg_mode = usb_get_dr_mode(dev);
>> +
>> +	dwc3_meson_g12a_usb_init(priv);
>> +
>> +	/* Set PHY Power */
>> +	for (i = 0 ; i < PHY_COUNT ; ++i) {
>> +		ret = phy_power_on(priv->phys[i]);
>> +		if (ret)
>> +			goto err_phys_put;
>> +	}
>> +
>> +	/* Init PHYs */
>> +	for (i = 0 ; i < PHY_COUNT ; ++i) {
>> +		ret = phy_init(priv->phys[i]);
>> +		if (ret)
>> +			goto err_phys_power;
>> +	}
> usually phy_init() first

OK, i usually saw power_on before, but I'll swap them.

> 
>> +
>> +	ret = of_platform_populate(np, NULL, NULL, dev);
>> +	if (ret) {
>> +		clk_disable_unprepare(priv->clk);
>> +		clk_put(priv->clk);
>> +
>> +		goto err_phys_exit;
>> +	}
>> +
>> +	/* Setup OTG mode corresponding to the ID pin */
>> +	if (priv->otg_mode == USB_DR_MODE_OTG) {
>> +		/* TOFIX Handle ID mode toggling via IRQ */
>> +		otg_id = dwc3_meson_g12a_get_id(priv);
>> +		if (otg_id != priv->otg_phy_mode) {
>> +			if (dwc3_meson_g12a_otg_mode_set(priv, otg_id))
>> +				dev_warn(dev, "Failed to switch OTG mode\n");
>> +		}
>> +	}
>> +
>> +	/* Setup role switcher */
>> +	priv->switch_desc.usb2_port = dwc3_meson_g12_find_child(dev,
>> +								"snps,dwc3");
>> +	priv->switch_desc.udc = dwc3_meson_g12_find_child(dev, "snps,dwc2");
>> +	priv->switch_desc.allow_userspace_control = true;
>> +	priv->switch_desc.set = dwc3_meson_g12a_role_set;
>> +	priv->switch_desc.get = dwc3_meson_g12a_role_get;
> to me, use a local variable for switch_desc

I'm never fan of changing a local global variable for a driver instance,
is it strictly required ?

> 
>> +
>> +	priv->role_switch = usb_role_switch_register(dev, &priv->switch_desc);
>> +	if (IS_ERR(priv->role_switch))
>> +		dev_warn(dev, "Unable to register Role Switch\n");
>> +
>> +	pm_runtime_set_active(dev);
>> +	pm_runtime_enable(dev);
>> +	pm_runtime_get_sync(dev);
>> +
>> +	return 0;
>> +
>> +err_phys_exit:
>> +	for (i = 0 ; i < PHY_COUNT ; ++i)
>> +		phy_exit(priv->phys[i]);
>> +
>> +err_phys_power:
>> +	for (i = 0 ; i < PHY_COUNT ; ++i)
>> +		phy_power_off(priv->phys[i]);
>> +
>> +err_phys_put:
>> +	for (i = 0 ; i < PHY_COUNT ; ++i)
>> +		phy_put(priv->phys[i]);
>> +
> The phys are got by devm_phy_optional_get(), no need call phy_put()

You are right, this is a leftover from v1.

>> +	return ret;
>> +}
>> +
>> +static int dwc3_meson_g12a_remove(struct platform_device *pdev)
>> +{
>> +	struct dwc3_meson_g12a *priv = platform_get_drvdata(pdev);
>> +	struct device *dev = &pdev->dev;
>> +	int i;
>> +
>> +	usb_role_switch_unregister(priv->role_switch);
>> +
>> +	of_platform_depopulate(dev);
>> +
>> +	for (i = 0 ; i < PHY_COUNT ; ++i) {
>> +		phy_power_off(priv->phys[i]);
>> +		phy_exit(priv->phys[i]);
>> +		phy_put(priv->phys[i]);
> ditto

Thanks for the review,
Neil

>> +	}
>> +
>> +	clk_disable_unprepare(priv->clk);
>> +	clk_put(priv->clk);
>> +
>> +	pm_runtime_disable(dev);
>> +	pm_runtime_put_noidle(dev);
>> +	pm_runtime_set_suspended(dev);
>> +
>> +	return 0;
>> +}
>> +
>> +static int __maybe_unused dwc3_meson_g12a_runtime_suspend(struct device *dev)
>> +{
>> +	struct dwc3_meson_g12a	*priv = dev_get_drvdata(dev);
>> +
>> +	clk_disable(priv->clk);
>> +
>> +	return 0;
>> +}
>> +
>> +static int __maybe_unused dwc3_meson_g12a_runtime_resume(struct device *dev)
>> +{
>> +	struct dwc3_meson_g12a	*priv = dev_get_drvdata(dev);
>> +
>> +	return clk_enable(priv->clk);
>> +}
>> +
>> +static int __maybe_unused dwc3_meson_g12a_suspend(struct device *dev)
>> +{
>> +	struct dwc3_meson_g12a *priv = dev_get_drvdata(dev);
>> +	int i;
>> +
>> +	for (i = 0 ; i < PHY_COUNT ; ++i)
>> +		if (priv->phys[i])
>> +			phy_exit(priv->phys[i]);
>> +
>> +	reset_control_assert(priv->reset);
>> +
>> +	return 0;
>> +}
>> +
>> +static int __maybe_unused dwc3_meson_g12a_resume(struct device *dev)
>> +{
>> +	struct dwc3_meson_g12a *priv = dev_get_drvdata(dev);
>> +	int i, ret;
>> +
>> +	reset_control_deassert(priv->reset);
>> +
>> +	dwc3_meson_g12a_usb_init(priv);
>> +
>> +	/* Init PHYs */
>> +	for (i = 0 ; i < PHY_COUNT ; ++i) {
>> +		if (priv->phys[i]) {
>> +			ret = phy_init(priv->phys[i]);
>> +			if (ret)
>> +				return ret;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct dev_pm_ops dwc3_meson_g12a_dev_pm_ops = {
>> +	SET_SYSTEM_SLEEP_PM_OPS(dwc3_meson_g12a_suspend, dwc3_meson_g12a_resume)
>> +	SET_RUNTIME_PM_OPS(dwc3_meson_g12a_runtime_suspend,
>> +			dwc3_meson_g12a_runtime_resume, NULL)
>> +};
>> +
>> +static const struct of_device_id dwc3_meson_g12a_match[] = {
>> +	{ .compatible = "amlogic,meson-g12a-usb-ctrl" },
>> +	{ /* Sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, dwc3_meson_g12a_match);
>> +
>> +static struct platform_driver dwc3_meson_g12a_driver = {
>> +	.probe		= dwc3_meson_g12a_probe,
>> +	.remove		= dwc3_meson_g12a_remove,
>> +	.driver		= {
>> +		.name	= "dwc3-meson-g12a",
>> +		.of_match_table = dwc3_meson_g12a_match,
>> +		.pm	= &dwc3_meson_g12a_dev_pm_ops,
>> +	},
>> +};
>> +
>> +module_platform_driver(dwc3_meson_g12a_driver);
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_DESCRIPTION("Amlogic Meson G12A USB Glue Layer");
>> +MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
> 
> 

