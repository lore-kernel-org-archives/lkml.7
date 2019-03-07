Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C575EC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 843FA20835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfCGLB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 06:01:27 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:29926 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726015AbfCGLB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 06:01:26 -0500
X-UUID: 21e6450e66574924876e6ee4e5f001cd-20190307
X-UUID: 21e6450e66574924876e6ee4e5f001cd-20190307
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1750926682; Thu, 07 Mar 2019 19:01:14 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 7 Mar
 2019 19:01:12 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 7 Mar 2019 19:01:12 +0800
Message-ID: <1551956472.2210.106.camel@mhfsdcap03>
Subject: Re: [PATCH v2 8/8] usb: dwc3: Add Amlogic G12A DWC3 glue
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
CC:     <gregkh@linuxfoundation.org>, <hminas@synopsys.com>,
        <balbi@kernel.org>, <kishon@ti.com>,
        <linux-amlogic@lists.infradead.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Thu, 7 Mar 2019 19:01:12 +0800
In-Reply-To: <6eaff413-d2c7-125a-f165-e4226c7a153e@baylibre.com>
References: <20190304103846.2060-1-narmstrong@baylibre.com>
         <20190304103846.2060-9-narmstrong@baylibre.com>
         <1551924176.2210.104.camel@mhfsdcap03>
         <6eaff413-d2c7-125a-f165-e4226c7a153e@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-03-07 at 10:45 +0100, Neil Armstrong wrote:
> On 07/03/2019 03:02, Chunfeng Yun wrote:
> > Hi,
> > On Mon, 2019-03-04 at 11:38 +0100, Neil Armstrong wrote:
> >> Adds support for Amlogic G12A USB Control Glue HW.
> >>
> >> The Amlogic G12A SoC Family embeds 2 USB Controllers :
> >> - a DWC3 IP configured as Host for USB2 and USB3
> >> - a DWC2 IP configured as Peripheral USB2 Only
> >>
> >> A glue connects these both controllers to 2 USB2 PHYs, and optionnally
> >> to an USB3+PCIE Combo PHY shared with the PCIE controller.
> >>
> >> The Glue configures the UTMI 8bit interfaces for the USB2 PHYs, including
> >> routing of the OTG PHY between the DWC3 and DWC2 controllers, and
> >> setups the on-chip OTG mode selection for this PHY.
> >>
> >> This drivers supports the on-probe setup of the OTG mode, and manually
> >> via a debugfs interface. The IRQ mode change detect is yet to be added
> >> in a future patchset, mainly due to lack of hardware to validate on.
> >>
> >> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> >> ---
> >>  drivers/usb/dwc3/Kconfig           |  10 +
> >>  drivers/usb/dwc3/Makefile          |   1 +
> >>  drivers/usb/dwc3/dwc3-meson-g12a.c | 601 +++++++++++++++++++++++++++++
> >>  3 files changed, 612 insertions(+)
> >>  create mode 100644 drivers/usb/dwc3/dwc3-meson-g12a.c
> >>
> >> diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
> >> index 1a0404fda596..21ce7368d325 100644
> >> --- a/drivers/usb/dwc3/Kconfig
> >> +++ b/drivers/usb/dwc3/Kconfig
> >> @@ -93,6 +93,16 @@ config USB_DWC3_KEYSTONE
> >>  	  Support of USB2/3 functionality in TI Keystone2 platforms.
> >>  	  Say 'Y' or 'M' here if you have one such device
> >>  
> >> +config USB_DWC3_MESON_G12A
> >> +       tristate "Amlogic Meson G12A Platforms"
> >> +       depends on OF && COMMON_CLK
> >> +       depends on ARCH_MESON || COMPILE_TEST
> >> +       default USB_DWC3
> >> +       select USB_ROLE_SWITCH
> >> +       help
> >> +         Support USB2/3 functionality in Amlogic G12A platforms.
> >> +	 Say 'Y' or 'M' if you have one such device.
> >> +
> >>  config USB_DWC3_OF_SIMPLE
> >>         tristate "Generic OF Simple Glue Layer"
> >>         depends on OF && COMMON_CLK
> >> diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
> >> index 6e3ef6144e5d..ae86da0dc5bd 100644
> >> --- a/drivers/usb/dwc3/Makefile
> >> +++ b/drivers/usb/dwc3/Makefile
> >> @@ -47,6 +47,7 @@ obj-$(CONFIG_USB_DWC3_EXYNOS)		+= dwc3-exynos.o
> >>  obj-$(CONFIG_USB_DWC3_PCI)		+= dwc3-pci.o
> >>  obj-$(CONFIG_USB_DWC3_HAPS)		+= dwc3-haps.o
> >>  obj-$(CONFIG_USB_DWC3_KEYSTONE)		+= dwc3-keystone.o
> >> +obj-$(CONFIG_USB_DWC3_MESON_G12A)	+= dwc3-meson-g12a.o
> >>  obj-$(CONFIG_USB_DWC3_OF_SIMPLE)	+= dwc3-of-simple.o
> >>  obj-$(CONFIG_USB_DWC3_ST)		+= dwc3-st.o
> >>  obj-$(CONFIG_USB_DWC3_QCOM)		+= dwc3-qcom.o
> >> diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
> >> new file mode 100644
> >> index 000000000000..75942614a034
> >> --- /dev/null
> >> +++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
> >> @@ -0,0 +1,601 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * USB Glue for Amlogic G12A SoCs
> >> + *
> >> + * Copyright (c) 2019 BayLibre, SAS
> >> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> >> + */
> >> +
> >> +/*
> >> + * The USB is organized with a glue around the DWC3 Controller IP as :
> >> + * - Control registers for each USB2 Ports
> >> + * - Control registers for the USB PHY layer
> >> + * - SuperSpeed PHY can be enabled only if port is used
> >> + *
> >> + * TOFIX:
> >> + * - Add dynamic OTG switching with ID change interrupt
> >> + */
> >> +
> > [...]
> >> +
> >> +static int dwc3_meson_g12a_probe(struct platform_device *pdev)
> >> +{
> >> +	struct dwc3_meson_g12a	*priv;
> >> +	struct device		*dev = &pdev->dev;
> >> +	struct device_node	*np = dev->of_node;
> >> +	void __iomem *base;
> >> +	struct resource *res;
> >> +	enum phy_mode otg_id;
> >> +	int ret, i;
> >> +
> >> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> >> +	if (!priv)
> >> +		return -ENOMEM;
> >> +
> >> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >> +	base = devm_ioremap_resource(dev, res);
> >> +	if (IS_ERR(base))
> >> +		return PTR_ERR(base);
> >> +
> >> +	priv->regmap = devm_regmap_init_mmio(dev, base,
> >> +					     &phy_meson_g12a_usb3_regmap_conf);
> >> +	if (IS_ERR(priv->regmap))
> >> +		return PTR_ERR(priv->regmap);
> >> +
> >> +	priv->vbus = devm_regulator_get_optional(dev, "vbus");
> >> +	if (IS_ERR(priv->vbus)) {
> >> +		if (PTR_ERR(priv->vbus) == -EPROBE_DEFER)
> >> +			return PTR_ERR(priv->vbus);
> >> +		priv->vbus = NULL;
> >> +	}
> >> +
> >> +	priv->clk = devm_clk_get(dev, NULL);
> >> +	if (IS_ERR(priv->clk))
> >> +		return PTR_ERR(priv->clk);
> >> +
> >> +	ret = clk_prepare_enable(priv->clk);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	platform_set_drvdata(pdev, priv);
> >> +	priv->dev = dev;
> >> +
> >> +	priv->reset = devm_reset_control_get(dev, NULL);
> >> +	if (IS_ERR(priv->reset)) {
> >> +		ret = PTR_ERR(priv->reset);
> >> +		dev_err(dev, "failed to get device reset, err=%d\n", ret);
> >> +		return ret;
> >> +	}
> >> +
> >> +	ret = reset_control_reset(priv->reset);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	ret = dwc3_meson_g12a_get_phys(priv);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	ret = regulator_enable(priv->vbus);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	/* Get dr_mode */
> >> +	priv->otg_mode = usb_get_dr_mode(dev);
> >> +
> >> +	dwc3_meson_g12a_usb_init(priv);
> >> +
> >> +	/* Set PHY Power */
> >> +	for (i = 0 ; i < PHY_COUNT ; ++i) {
> >> +		ret = phy_power_on(priv->phys[i]);
> >> +		if (ret)
> >> +			goto err_phys_put;
> >> +	}
> >> +
> >> +	/* Init PHYs */
> >> +	for (i = 0 ; i < PHY_COUNT ; ++i) {
> >> +		ret = phy_init(priv->phys[i]);
> >> +		if (ret)
> >> +			goto err_phys_power;
> >> +	}
> > usually phy_init() first
> 
> OK, i usually saw power_on before, but I'll swap them.
> 
> > 
> >> +
> >> +	ret = of_platform_populate(np, NULL, NULL, dev);
> >> +	if (ret) {
> >> +		clk_disable_unprepare(priv->clk);
> >> +		clk_put(priv->clk);
> >> +
> >> +		goto err_phys_exit;
> >> +	}
> >> +
> >> +	/* Setup OTG mode corresponding to the ID pin */
> >> +	if (priv->otg_mode == USB_DR_MODE_OTG) {
> >> +		/* TOFIX Handle ID mode toggling via IRQ */
> >> +		otg_id = dwc3_meson_g12a_get_id(priv);
> >> +		if (otg_id != priv->otg_phy_mode) {
> >> +			if (dwc3_meson_g12a_otg_mode_set(priv, otg_id))
> >> +				dev_warn(dev, "Failed to switch OTG mode\n");
> >> +		}
> >> +	}
> >> +
> >> +	/* Setup role switcher */
> >> +	priv->switch_desc.usb2_port = dwc3_meson_g12_find_child(dev,
> >> +								"snps,dwc3");
> >> +	priv->switch_desc.udc = dwc3_meson_g12_find_child(dev, "snps,dwc2");
> >> +	priv->switch_desc.allow_userspace_control = true;
> >> +	priv->switch_desc.set = dwc3_meson_g12a_role_set;
> >> +	priv->switch_desc.get = dwc3_meson_g12a_role_get;
> > to me, use a local variable for switch_desc
> 
> I'm never fan of changing a local global variable for a driver instance,
> is it strictly required ?
No :)
> 
> > 
> >> +
> >> +	priv->role_switch = usb_role_switch_register(dev, &priv->switch_desc);
> >> +	if (IS_ERR(priv->role_switch))
> >> +		dev_warn(dev, "Unable to register Role Switch\n");
> >> +
> >> +	pm_runtime_set_active(dev);
> >> +	pm_runtime_enable(dev);
> >> +	pm_runtime_get_sync(dev);
> >> +
> >> +	return 0;
> >> +
> >> +err_phys_exit:
> >> +	for (i = 0 ; i < PHY_COUNT ; ++i)
> >> +		phy_exit(priv->phys[i]);
> >> +
> >> +err_phys_power:
> >> +	for (i = 0 ; i < PHY_COUNT ; ++i)
> >> +		phy_power_off(priv->phys[i]);
> >> +
> >> +err_phys_put:
> >> +	for (i = 0 ; i < PHY_COUNT ; ++i)
> >> +		phy_put(priv->phys[i]);
> >> +
> > The phys are got by devm_phy_optional_get(), no need call phy_put()
> 
> You are right, this is a leftover from v1.
> 
> >> +	return ret;
> >> +}
> >> +
> >> +static int dwc3_meson_g12a_remove(struct platform_device *pdev)
> >> +{
> >> +	struct dwc3_meson_g12a *priv = platform_get_drvdata(pdev);
> >> +	struct device *dev = &pdev->dev;
> >> +	int i;
> >> +
> >> +	usb_role_switch_unregister(priv->role_switch);
> >> +
> >> +	of_platform_depopulate(dev);
> >> +
> >> +	for (i = 0 ; i < PHY_COUNT ; ++i) {
> >> +		phy_power_off(priv->phys[i]);
> >> +		phy_exit(priv->phys[i]);
> >> +		phy_put(priv->phys[i]);
> > ditto
> 
> Thanks for the review,
> Neil
> 
> >> +	}
> >> +
> >> +	clk_disable_unprepare(priv->clk);
> >> +	clk_put(priv->clk);
> >> +
> >> +	pm_runtime_disable(dev);
> >> +	pm_runtime_put_noidle(dev);
> >> +	pm_runtime_set_suspended(dev);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int __maybe_unused dwc3_meson_g12a_runtime_suspend(struct device *dev)
> >> +{
> >> +	struct dwc3_meson_g12a	*priv = dev_get_drvdata(dev);
> >> +
> >> +	clk_disable(priv->clk);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int __maybe_unused dwc3_meson_g12a_runtime_resume(struct device *dev)
> >> +{
> >> +	struct dwc3_meson_g12a	*priv = dev_get_drvdata(dev);
> >> +
> >> +	return clk_enable(priv->clk);
> >> +}
> >> +
> >> +static int __maybe_unused dwc3_meson_g12a_suspend(struct device *dev)
> >> +{
> >> +	struct dwc3_meson_g12a *priv = dev_get_drvdata(dev);
> >> +	int i;
> >> +
> >> +	for (i = 0 ; i < PHY_COUNT ; ++i)
> >> +		if (priv->phys[i])
> >> +			phy_exit(priv->phys[i]);
> >> +
> >> +	reset_control_assert(priv->reset);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int __maybe_unused dwc3_meson_g12a_resume(struct device *dev)
> >> +{
> >> +	struct dwc3_meson_g12a *priv = dev_get_drvdata(dev);
> >> +	int i, ret;
> >> +
> >> +	reset_control_deassert(priv->reset);
> >> +
> >> +	dwc3_meson_g12a_usb_init(priv);
> >> +
> >> +	/* Init PHYs */
> >> +	for (i = 0 ; i < PHY_COUNT ; ++i) {
> >> +		if (priv->phys[i]) {
> >> +			ret = phy_init(priv->phys[i]);
> >> +			if (ret)
> >> +				return ret;
> >> +		}
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static const struct dev_pm_ops dwc3_meson_g12a_dev_pm_ops = {
> >> +	SET_SYSTEM_SLEEP_PM_OPS(dwc3_meson_g12a_suspend, dwc3_meson_g12a_resume)
> >> +	SET_RUNTIME_PM_OPS(dwc3_meson_g12a_runtime_suspend,
> >> +			dwc3_meson_g12a_runtime_resume, NULL)
> >> +};
> >> +
> >> +static const struct of_device_id dwc3_meson_g12a_match[] = {
> >> +	{ .compatible = "amlogic,meson-g12a-usb-ctrl" },
> >> +	{ /* Sentinel */ }
> >> +};
> >> +MODULE_DEVICE_TABLE(of, dwc3_meson_g12a_match);
> >> +
> >> +static struct platform_driver dwc3_meson_g12a_driver = {
> >> +	.probe		= dwc3_meson_g12a_probe,
> >> +	.remove		= dwc3_meson_g12a_remove,
> >> +	.driver		= {
> >> +		.name	= "dwc3-meson-g12a",
> >> +		.of_match_table = dwc3_meson_g12a_match,
> >> +		.pm	= &dwc3_meson_g12a_dev_pm_ops,
> >> +	},
> >> +};
> >> +
> >> +module_platform_driver(dwc3_meson_g12a_driver);
> >> +MODULE_LICENSE("GPL v2");
> >> +MODULE_DESCRIPTION("Amlogic Meson G12A USB Glue Layer");
> >> +MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
> > 
> > 
> 


