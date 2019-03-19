Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BE0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 08:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B254920850
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 08:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="gkF4QX6U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfCSIPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 04:15:32 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53200 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbfCSIPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 04:15:32 -0400
Received: by mail-wm1-f68.google.com with SMTP id a184so1616594wma.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 01:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=CeBiXaWaPw51jk9FF1sgV8MKrjDP8W2jS7Qm//lRWuo=;
        b=gkF4QX6UxSYZUAfiwTeRDmXvQ+XYAD9CKT8OcJYMKOqGceUoagaQ8L9hm7mJHjoVgA
         4I0K+AsBKwCpzOwB2EcILYaUD7NK5R9PwDku6K4M9Mj3ikslHwRGueKirj+LWYGIYpDO
         ptGzP0SxrixVXMRU0bNnqigAz9iALbOHM/XgV9EaH+TfrK2rykOGqT6pDj7AN4tNJp/S
         89cb8EUauYgA5oODUSUltly5b9ppKCF2qAHVXLbNB6RXEi2cfA6ho9FwmyS+H3a1ZPn6
         nI0rfuS40xmlU9pHlCX9w1N6Ta41mimouVBePwhmqJvqfmNxSGrtEkA05ONKyzF5tZ1m
         SOWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=CeBiXaWaPw51jk9FF1sgV8MKrjDP8W2jS7Qm//lRWuo=;
        b=XR1nj/cfmc9nTeupjpLgqGjA7M8SUCZWdN2xoaNNzY67iIVsYsS94sXHSaCaj3ADaL
         ks/SFQiJl8ZtUtAkKiOGoYm+V58kQSC3eDorobPqZSxaA0hRGDA+TRx19xqdrQ9egBz8
         /FVBAfELgdCjmRkd+3sMYuwuBJS4O05dFrTfvLMM9RGlbXNxuab5tkQaas+iRAb/HlzF
         nH/z4T8IPb7RHOuIeLsMQzdGCbKNXwmfFq9j1S11tf6E8wwriye+qEfAF9fIEBJViGJ/
         w3pPyrVjeii1Bf74Fn9ExYbrwntCSIm8B1ZjHpWPs2zoKp6eDlqsOrRjkkhBD4iLeFO2
         ZwPg==
X-Gm-Message-State: APjAAAWAsTazI21/2LHUCDJo2GyFLWyVYrVEKz9L/6XhieGrx14RYjUd
        cESR/MZ91TlsKF0LFTvFgcQPMnD7L8pLxw==
X-Google-Smtp-Source: APXvYqzZu6DfbD7KaSQhDE5inIYDKytPV8InFVEficvpDKORyA6oDr4a1KuiyZY+Gd9C04cUMawPLQ==
X-Received: by 2002:a1c:1fcf:: with SMTP id f198mr2507296wmf.145.1552983329114;
        Tue, 19 Mar 2019 01:15:29 -0700 (PDT)
Received: from [192.168.1.62] (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id b3sm2344731wmj.15.2019.03.19.01.15.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 01:15:28 -0700 (PDT)
Subject: Re: [PATCH v3 8/8] usb: dwc3: Add Amlogic G12A DWC3 glue
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com, linux-amlogic@lists.infradead.org,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20190318101153.7531-1-narmstrong@baylibre.com>
 <20190318101153.7531-9-narmstrong@baylibre.com>
 <1552960676.10179.142.camel@mhfsdcap03>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <703e82ad-5e1e-a03d-796c-dc1ddde7d2dc@baylibre.com>
Date:   Tue, 19 Mar 2019 09:15:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1552960676.10179.142.camel@mhfsdcap03>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19/03/2019 02:57, Chunfeng Yun wrote:
> Hi Neil,
> On Mon, 2019-03-18 at 11:11 +0100, Neil Armstrong wrote:
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
>>  drivers/usb/dwc3/dwc3-meson-g12a.c | 602 +++++++++++++++++++++++++++++
>>  3 files changed, 613 insertions(+)
>>  create mode 100644 drivers/usb/dwc3/dwc3-meson-g12a.c
>>
>> diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
>> index 2b1494460d0c..d2ea9670563c 100644
>> --- a/drivers/usb/dwc3/Kconfig
>> +++ b/drivers/usb/dwc3/Kconfig
>> @@ -95,6 +95,16 @@ config USB_DWC3_KEYSTONE
>>  	  Support of USB2/3 functionality in TI Keystone2 and AM654 platforms.
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
>> index 000000000000..9f4554e8e6e7
>> --- /dev/null
>> +++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
>> @@ -0,0 +1,602 @@
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

[..]

>> +
>> +	ret = of_platform_populate(np, NULL, NULL, dev);
>> +	if (ret) {
>> +		clk_disable_unprepare(priv->clk);
>> +		clk_put(priv->clk);
> No need clk_put()

Exact

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
> you get phy by devm_phy_optional_get(), no need call phy_put(), 

Indeed, also forgot these

>> +
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
> here, and remove others if have.

This is the last one I hope

>> +	}
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
>> +		phy_exit(priv->phys[i]);
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
>> +		ret = phy_init(priv->phys[i]);
>> +		if (ret)
>> +			return ret;
>> +	}
> Do you need power on phys?

Regulators can be tied to the PHYs, should I disable power on suspend aswell ?

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

Thanks,
Neil
