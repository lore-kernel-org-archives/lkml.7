Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D63DC46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 11:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E812A218CA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 11:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbfGELzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 07:55:23 -0400
Received: from mga14.intel.com ([192.55.52.115]:2694 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728186AbfGELzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 07:55:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jul 2019 04:55:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,454,1557212400"; 
   d="scan'208";a="363579489"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by fmsmga006.fm.intel.com with ESMTP; 05 Jul 2019 04:55:15 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Pawel Laszczak <pawell@cadence.com>, devicetree@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        hdegoede@redhat.com, heikki.krogerus@linux.intel.com,
        robh+dt@kernel.org, rogerq@ti.com, linux-kernel@vger.kernel.org,
        jbergsagel@ti.com, nsekhar@ti.com, nm@ti.com, sureshp@cadence.com,
        peter.chen@nxp.com, jpawar@cadence.com, kurahul@cadence.com,
        Pawel Laszczak <pawell@cadence.com>
Subject: Re: [PATCH v9 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
In-Reply-To: <1562324238-16655-6-git-send-email-pawell@cadence.com>
References: <1562324238-16655-1-git-send-email-pawell@cadence.com> <1562324238-16655-6-git-send-email-pawell@cadence.com>
Date:   Fri, 05 Jul 2019 14:55:15 +0300
Message-ID: <87r274lmqk.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Pawel Laszczak <pawell@cadence.com> writes:
> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> new file mode 100644
> index 000000000000..ddc73f1c87c5
> --- /dev/null
> +++ b/drivers/usb/cdns3/core.c
> @@ -0,0 +1,543 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cadence USBSS DRD Driver.
> + *
> + * Copyright (C) 2018-2019 Cadence.
> + * Copyright (C) 2017-2018 NXP
> + * Copyright (C) 2019 Texas Instruments
> + *
> + * Author: Peter Chen <peter.chen@nxp.com>
> + *         Pawel Laszczak <pawell@cadence.com>
> + *         Roger Quadros <rogerq@ti.com>
> + */
> +
> +#include <linux/dma-mapping.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/pm_runtime.h>
> +
> +#include "gadget.h"
> +#include "core.h"
> +#include "host-export.h"
> +#include "gadget-export.h"
> +#include "drd.h"
> +#include "debug.h"
> +
> +/**
> + * cdns3_handshake - spin reading  until handshake completes or fails
> + * @ptr: address of device controller register to be read
> + * @mask: bits to look at in result of read
> + * @done: value of those bits when handshake succeeds
> + * @usec: timeout in microseconds
> + *
> + * Returns negative errno, or zero on success
> + *
> + * Success happens when the "mask" bits have the specified value (hardware
> + * handshake done). There are two failure modes: "usec" have passed (major
> + * hardware flakeout), or the register reads as all-ones (hardware removed).
> + */
> +int cdns3_handshake(void __iomem *ptr, u32 mask, u32 done, int usec)
> +{
> +	u32 result;
> +
> +	do {
> +		result = readl(ptr);
> +		if (result == ~(u32)0)  /* card removed */
> +			return -ENODEV;
> +
> +		result &= mask;
> +		if (result == done)
> +			return 0;
> +
> +		udelay(1);
> +		usec--;
> +	} while (usec > 0);
> +
> +	return -ETIMEDOUT;

looks like readl_poll_timeout_atomic() would handle this.

> +}
> +
> +static inline
> +struct cdns3_role_driver *cdns3_get_current_role_driver(struct cdns3 *cdns)
> +{
> +	WARN_ON(cdns->role >= CDNS3_ROLE_END || !cdns->roles[cdns->role]);
> +	return cdns->roles[cdns->role];
> +}
> +
> +static int cdns3_role_start(struct cdns3 *cdns, enum cdns3_roles role)
> +{
> +	int ret;
> +
> +	if (WARN_ON(role >= CDNS3_ROLE_END))
> +		return 0;
> +
> +	if (!cdns->roles[role])
> +		return -ENXIO;
> +
> +	if (cdns->roles[role]->state == CDNS3_ROLE_STATE_ACTIVE)
> +		return 0;
> +
> +	mutex_lock(&cdns->mutex);
> +	cdns->role = role;
> +	ret = cdns->roles[role]->start(cdns);
> +	if (!ret)
> +		cdns->roles[role]->state = CDNS3_ROLE_STATE_ACTIVE;
> +	mutex_unlock(&cdns->mutex);
> +	return ret;
> +}
> +
> +void cdns3_role_stop(struct cdns3 *cdns)

not static? Why is it so that _start() is static but _stop() is not?
Looks fishy

> +{
> +	enum cdns3_roles role = cdns->role;
> +
> +	if (role >= CDNS3_ROLE_END) {
> +		WARN_ON(role > CDNS3_ROLE_END);
> +		return;
> +	}
> +
> +	if (cdns->roles[role]->state == CDNS3_ROLE_STATE_INACTIVE)
> +		return;
> +
> +	mutex_lock(&cdns->mutex);
> +	cdns->roles[role]->stop(cdns);
> +	cdns->roles[role]->state = CDNS3_ROLE_STATE_INACTIVE;
> +	mutex_unlock(&cdns->mutex);
> +}
> +
> +static void cdns3_exit_roles(struct cdns3 *cdns)
> +{
> +	cdns3_role_stop(cdns);
> +	cdns3_drd_exit(cdns);
> +}
> +
> +enum cdns3_roles cdsn3_get_real_role(struct cdns3 *cdns);
> +
> +static int cdns3_idle_role_start(struct cdns3 *cnds)
> +{	/* Hold PHY in RESET */

huh?

> +	return 0;
> +}
> +
> +static void cdns3_idle_role_stop(struct cdns3 *cnds)
> +{
> +	/* Program Lane swap and bring PHY out of RESET */

double huh?

> +}
> +
> +static int cdns3_idle_init(struct cdns3 *cdns)
> +{
> +	struct cdns3_role_driver *rdrv;
> +
> +	rdrv = devm_kzalloc(cdns->dev, sizeof(*rdrv), GFP_KERNEL);
> +	if (!rdrv)
> +		return -ENOMEM;
> +
> +	rdrv->start = cdns3_idle_role_start;
> +	rdrv->stop = cdns3_idle_role_stop;
> +	rdrv->state = CDNS3_ROLE_STATE_INACTIVE;
> +	rdrv->suspend = NULL;
> +	rdrv->resume = NULL;
> +	rdrv->name = "idle";

why don't you use the mux framework for this? This looks a bit fishy
too. Why do you have your own driver registration structure for your
driver only?

> +
> +	cdns->roles[CDNS3_ROLE_IDLE] = rdrv;
> +
> +	return 0;
> +}
> +
> +/**
> + * cdns3_core_init_role - initialize role of operation
> + * @cdns: Pointer to cdns3 structure
> + *
> + * Returns 0 on success otherwise negative errno
> + */
> +static int cdns3_core_init_role(struct cdns3 *cdns)
> +{
> +	struct device *dev = cdns->dev;
> +	enum usb_dr_mode best_dr_mode;
> +	enum usb_dr_mode dr_mode;
> +	int ret = 0;
> +
> +	dr_mode = usb_get_dr_mode(dev);
> +	cdns->role = CDNS3_ROLE_END;
> +
> +	/*
> +	 * If driver can't read mode by means of usb_get_dr_mode function then
> +	 * chooses mode according with Kernel configuration. This setting
> +	 * can be restricted later depending on strap pin configuration.
> +	 */
> +	if (dr_mode == USB_DR_MODE_UNKNOWN) {
> +		if (IS_ENABLED(CONFIG_USB_CDNS3_HOST) &&
> +		    IS_ENABLED(CONFIG_USB_CDNS3_GADGET))
> +			dr_mode = USB_DR_MODE_OTG;
> +		else if (IS_ENABLED(CONFIG_USB_CDNS3_HOST))
> +			dr_mode = USB_DR_MODE_HOST;
> +		else if (IS_ENABLED(CONFIG_USB_CDNS3_GADGET))
> +			dr_mode = USB_DR_MODE_PERIPHERAL;
> +	}
> +
> +	/*
> +	 * At this point cdns->dr_mode contains strap configuration.
> +	 * Driver try update this setting considering kernel configuration
> +	 */
> +	best_dr_mode = cdns->dr_mode;
> +
> +	ret = cdns3_idle_init(cdns);
> +	if (ret)
> +		return ret;
> +
> +	if (dr_mode == USB_DR_MODE_OTG) {
> +		best_dr_mode = cdns->dr_mode;
> +	} else if (cdns->dr_mode == USB_DR_MODE_OTG) {
> +		best_dr_mode = dr_mode;
> +	} else if (cdns->dr_mode != dr_mode) {
> +		dev_err(dev, "Incorrect DRD configuration\n");
> +		return -EINVAL;
> +	}
> +
> +	dr_mode = best_dr_mode;
> +
> +	if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_HOST) {
> +		ret = cdns3_host_init(cdns);
> +		if (ret) {
> +			dev_err(dev, "Host initialization failed with %d\n",
> +				ret);
> +			goto err;
> +		}
> +	}
> +
> +	if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_PERIPHERAL) {
> +		ret = cdns3_gadget_init(cdns);
> +		if (ret) {
> +			dev_err(dev, "Device initialization failed with %d\n",
> +				ret);
> +			goto err;
> +		}
> +	}
> +
> +	cdns->desired_dr_mode = dr_mode;
> +	cdns->dr_mode = dr_mode;
> +
> +	/*
> +	 * desired_dr_mode might have changed so we need to update
> +	 * the controller configuration"?
> +	 */
> +	ret = cdns3_drd_update_mode(cdns);
> +	if (ret)
> +		goto err;
> +
> +	cdns->role = cdsn3_get_real_role(cdns);
> +
> +	ret = cdns3_role_start(cdns, cdns->role);
> +	if (ret) {
> +		dev_err(dev, "can't start %s role\n",
> +			cdns3_get_current_role_driver(cdns)->name);
> +		goto err;
> +	}
> +
> +	return ret;
> +err:
> +	cdns3_exit_roles(cdns);
> +	return ret;
> +}
> +
> +/**
> + * cdsn3_get_real_role - get real role of controller based on hardware settings.
> + * @cdns: Pointer to cdns3 structure
> + *
> + * Returns role
> + */
> +enum cdns3_roles cdsn3_get_real_role(struct cdns3 *cdns)
> +{
> +	enum cdns3_roles role;
> +	int id, vbus;
> +
> +	if (cdns->current_dr_mode != USB_DR_MODE_OTG)
> +		goto not_otg;
> +
> +	id = cdns3_get_id(cdns);
> +	vbus = cdns3_get_vbus(cdns);
> +
> +	/*
> +	 * Role change state machine
> +	 * Inputs: ID, VBUS
> +	 * Previous state: cdns->role
> +	 * Next state: role
> +	 */
> +	role = cdns->role;
> +
> +	switch (role) {
> +	case CDNS3_ROLE_IDLE: /* from IDLE, we can change to HOST or GADGET */
> +		if (!id)
> +			role = CDNS3_ROLE_HOST;
> +		else if (vbus)
> +			role = CDNS3_ROLE_GADGET;
> +		break;
> +	case CDNS3_ROLE_HOST: /* from HOST, we can only change to IDLE */
> +		if (id)
> +			role = CDNS3_ROLE_IDLE;
> +		break;
> +	case CDNS3_ROLE_GADGET: /* from GADGET, we can only change to IDLE */
> +		if (!vbus)
> +			role = CDNS3_ROLE_IDLE;
> +		break;
> +	case CDNS3_ROLE_END: /* only at initialization, move to IDLE */
> +		role = CDNS3_ROLE_IDLE;
> +		break;
> +	}
> +
> +	dev_dbg(cdns->dev, "role %d -> %d\n", cdns->role, role);
> +
> +	return role;
> +
> +not_otg:
> +	if (cdns3_is_host(cdns))
> +		role = CDNS3_ROLE_HOST;
> +	if (cdns3_is_device(cdns))
> +		role = CDNS3_ROLE_GADGET;
> +
> +	return role;
> +}
> +
> +/**
> + * cdns3_role_switch - work queue handler for role switch
> + *
> + * @work: work queue item structure
> + *
> + * Handles below events:
> + * - Role switch for dual-role devices
> + * - CDNS3_ROLE_GADGET <--> CDNS3_ROLE_END for peripheral-only devices
> + */
> +static void cdns3_role_switch(struct work_struct *work)
> +{
> +	enum cdns3_roles role = CDNS3_ROLE_END;
> +	struct cdns3_role_driver *role_drv;
> +	enum cdns3_roles current_role;
> +	struct cdns3 *cdns;
> +	int ret = 0;
> +
> +	cdns = container_of(work, struct cdns3, role_switch_wq);
> +
> +	pm_runtime_get_sync(cdns->dev);
> +
> +	role = cdsn3_get_real_role(cdns);
> +
> +	role_drv = cdns3_get_current_role_driver(cdns);
> +
> +	/* Disable current role if requested from debugfs */
> +	if (cdns->debug_disable && role_drv->state == CDNS3_ROLE_STATE_ACTIVE) {
> +		cdns3_role_stop(cdns);
> +		goto exit;
> +	}
> +
> +	/* Do nothing if nothing changed */
> +	if (cdns->role == role && role_drv->state == CDNS3_ROLE_STATE_ACTIVE)
> +		goto exit;
> +
> +	cdns3_role_stop(cdns);
> +
> +	role = cdsn3_get_real_role(cdns);
> +
> +	current_role = cdns->role;
> +	dev_dbg(cdns->dev, "Switching role");
> +
> +	ret = cdns3_role_start(cdns, role);
> +	if (ret) {
> +		/* Back to current role */
> +		dev_err(cdns->dev, "set %d has failed, back to %d\n",
> +			role, current_role);
> +		ret = cdns3_role_start(cdns, current_role);
> +		if (ret)
> +			dev_err(cdns->dev, "back to %d failed too\n",
> +				current_role);
> +	}
> +exit:
> +	pm_runtime_put_sync(cdns->dev);
> +}
> +
> +/**
> + * cdns3_probe - probe for cdns3 core device
> + * @pdev: Pointer to cdns3 core platform device
> + *
> + * Returns 0 on success otherwise negative errno
> + */
> +static int cdns3_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct resource	*res;
> +	struct cdns3 *cdns;
> +	void __iomem *regs;
> +	int ret;
> +
> +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> +	if (ret) {
> +		dev_err(dev, "error setting dma mask: %d\n", ret);
> +		return -ENODEV;
> +	}
> +
> +	cdns = devm_kzalloc(dev, sizeof(*cdns), GFP_KERNEL);
> +	if (!cdns)
> +		return -ENOMEM;
> +
> +	cdns->dev = dev;
> +
> +	platform_set_drvdata(pdev, cdns);
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_IRQ, "host");
> +	if (!res) {
> +		dev_err(dev, "missing host IRQ\n");
> +		return -ENODEV;
> +	}
> +
> +	cdns->xhci_res[0] = *res;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "xhci");
> +	if (!res) {
> +		dev_err(dev, "couldn't get xhci resource\n");
> +		return -ENXIO;
> +	}
> +
> +	cdns->xhci_res[1] = *res;
> +
> +	cdns->dev_irq = platform_get_irq_byname(pdev, "peripheral");
> +	if (cdns->dev_irq == -EPROBE_DEFER)
> +		return cdns->dev_irq;
> +
> +	if (cdns->dev_irq < 0)
> +		dev_err(dev, "couldn't get peripheral irq\n");
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dev");
> +	regs = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(regs)) {
> +		dev_err(dev, "couldn't iomap dev resource\n");
> +		return PTR_ERR(regs);
> +	}
> +	cdns->dev_regs	= regs;
> +
> +	cdns->otg_irq = platform_get_irq_byname(pdev, "otg");
> +	if (cdns->otg_irq == -EPROBE_DEFER)
> +		return cdns->otg_irq;
> +
> +	if (cdns->otg_irq < 0) {
> +		dev_err(dev, "couldn't get otg irq\n");
> +		return cdns->otg_irq;
> +	}
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "otg");
> +	if (!res) {
> +		dev_err(dev, "couldn't get otg resource\n");
> +		return -ENXIO;
> +	}
> +
> +	cdns->otg_res = *res;
> +
> +	mutex_init(&cdns->mutex);
> +
> +	cdns->usb2_phy = devm_phy_optional_get(dev, "cdns3,usb2-phy");
> +	if (IS_ERR(cdns->usb2_phy))
> +		return PTR_ERR(cdns->usb2_phy);
> +
> +	phy_init(cdns->usb2_phy);
> +	ret = phy_init(cdns->usb2_phy);
> +	if (ret)
> +		return ret;
> +
> +	cdns->usb3_phy = devm_phy_optional_get(dev, "cdns3,usb3-phy");
> +	if (IS_ERR(cdns->usb3_phy))
> +		return PTR_ERR(cdns->usb3_phy);
> +
> +	phy_init(cdns->usb3_phy);
> +	ret = phy_init(cdns->usb3_phy);
> +	if (ret)
> +		return ret;
> +
> +	ret = phy_power_on(cdns->usb2_phy);
> +	if (ret)
> +		return ret;
> +
> +	ret = phy_power_on(cdns->usb3_phy);
> +	if (ret)
> +		goto err1;
> +
> +	INIT_WORK(&cdns->role_switch_wq, cdns3_role_switch);
> +
> +	ret = cdns3_drd_init(cdns);
> +	if (ret)
> +		goto err2;
> +
> +	ret = cdns3_core_init_role(cdns);
> +	if (ret)
> +		goto err2;
> +
> +	cdns3_debugfs_init(cdns);
> +	device_set_wakeup_capable(dev, true);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +
> +	/*
> +	 * The controller needs less time between bus and controller suspend,
> +	 * and we also needs a small delay to avoid frequently entering low
> +	 * power mode.
> +	 */
> +	pm_runtime_set_autosuspend_delay(dev, 20);
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_use_autosuspend(dev);
> +	dev_dbg(dev, "Cadence USB3 core: probe succeed\n");
> +
> +	return 0;
> +
> +err2:
> +	phy_power_off(cdns->usb3_phy);
> +
> +err1:
> +	phy_power_off(cdns->usb2_phy);
> +	phy_exit(cdns->usb2_phy);
> +	phy_exit(cdns->usb3_phy);
> +
> +	return ret;
> +}
> +
> +/**
> + * cdns3_remove - unbind drd driver and clean up
> + * @pdev: Pointer to Linux platform device
> + *
> + * Returns 0 on success otherwise negative errno
> + */
> +static int cdns3_remove(struct platform_device *pdev)
> +{
> +	struct cdns3 *cdns = platform_get_drvdata(pdev);
> +
> +	pm_runtime_get_sync(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
> +	pm_runtime_put_noidle(&pdev->dev);
> +	cdns3_debugfs_exit(cdns);
> +	cdns3_exit_roles(cdns);
> +	phy_power_off(cdns->usb2_phy);
> +	phy_power_off(cdns->usb3_phy);
> +	phy_exit(cdns->usb2_phy);
> +	phy_exit(cdns->usb3_phy);
> +	return 0;
> +}
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id of_cdns3_match[] = {
> +	{ .compatible = "cdns,usb3" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, of_cdns3_match);
> +#endif
> +
> +static struct platform_driver cdns3_driver = {
> +	.probe		= cdns3_probe,
> +	.remove		= cdns3_remove,
> +	.driver		= {
> +		.name	= "cdns-usb3",
> +		.of_match_table	= of_match_ptr(of_cdns3_match),
> +	},
> +};
> +
> +module_platform_driver(cdns3_driver);
> +
> +MODULE_ALIAS("platform:cdns3");
> +MODULE_AUTHOR("Pawel Laszczak <pawell@cadence.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Cadence USB3 DRD Controller Driver");
> diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
> new file mode 100644
> index 000000000000..be95696ab17e
> --- /dev/null
> +++ b/drivers/usb/cdns3/core.h
> @@ -0,0 +1,121 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Cadence USBSS DRD Header File.
> + *
> + * Copyright (C) 2017-2018 NXP
> + * Copyright (C) 2018-2019 Cadence.
> + *
> + * Authors: Peter Chen <peter.chen@nxp.com>
> + *          Pawel Laszczak <pawell@cadence.com>
> + */
> +#include <linux/usb/otg.h>
> +
> +#ifndef __LINUX_CDNS3_CORE_H
> +#define __LINUX_CDNS3_CORE_H
> +
> +struct cdns3;
> +enum cdns3_roles {
> +	CDNS3_ROLE_IDLE = 0,
> +	CDNS3_ROLE_HOST,
> +	CDNS3_ROLE_GADGET,
> +	CDNS3_ROLE_END,
> +};
> +
> +/**
> + * struct cdns3_role_driver - host/gadget role driver
> + * @start: start this role
> + * @stop: stop this role
> + * @suspend: suspend callback for this role
> + * @resume: resume callback for this role
> + * @irq: irq handler for this role
> + * @name: role name string (host/gadget)
> + * @state: current state
> + */
> +struct cdns3_role_driver {
> +	int (*start)(struct cdns3 *cdns);
> +	void (*stop)(struct cdns3 *cdns);
> +	int (*suspend)(struct cdns3 *cdns, bool do_wakeup);
> +	int (*resume)(struct cdns3 *cdns, bool hibernated);
> +	const char *name;
> +#define CDNS3_ROLE_STATE_INACTIVE	0
> +#define CDNS3_ROLE_STATE_ACTIVE		1
> +	int state;
> +};
> +
> +#define CDNS3_XHCI_RESOURCES_NUM	2
> +/**
> + * struct cdns3 - Representation of Cadence USB3 DRD controller.
> + * @dev: pointer to Cadence device struct
> + * @xhci_regs: pointer to base of xhci registers
> + * @xhci_res: the resource for xhci
> + * @dev_regs: pointer to base of dev registers
> + * @otg_res: the resource for otg
> + * @otg_v0_regs: pointer to base of v0 otg registers
> + * @otg_v1_regs: pointer to base of v1 otg registers
> + * @otg_regs: pointer to base of otg registers
> + * @otg_irq: irq number for otg controller
> + * @dev_irq: irq number for device controller
> + * @roles: array of supported roles for this controller
> + * @role: current role
> + * @host_dev: the child host device pointer for cdns3 core
> + * @gadget_dev: the child gadget device pointer for cdns3 core
> + * @usb2_phy: pointer to USB2 PHY
> + * @usb3_phy: pointer to USB3 PHY
> + * @role_switch_wq: work queue item for role switch
> + * @wakeup_int: the wakeup interrupt
> + * @mutex: the mutex for concurrent code at driver
> + * @dr_mode: supported mode of operation it can be only Host, only Device
> + *           or OTG mode that allow to switch between Device and Host mode.
> + *           This field based on firmware setting, kernel configuration
> + *           and hardware configuration.
> + * @current_dr_mode: current mode of operation when in dual-role mode
> + * @desired_dr_mode: desired mode of operation when in dual-role mode.
> + *           This value can be changed during runtime.
> + *           Available options depends on  dr_mode:
> + *           dr_mode                 |  desired_dr_mode and current_dr_mode
> + *           ----------------------------------------------------------------
> + *           USB_DR_MODE_HOST        | only USB_DR_MODE_HOST
> + *           USB_DR_MODE_PERIPHERAL  | only USB_DR_MODE_PERIPHERAL
> + *           USB_DR_MODE_OTG         | USB_DR_MODE_OTG or USB_DR_MODE_HOST or
> + *                                   | USB_DR_MODE_PERIPHERAL
> + *           Desired_dr_role can be changed by means of debugfs.
> + * @root: debugfs root folder pointer
> + * @debug_disable:
> + */
> +struct cdns3 {
> +	struct device			*dev;
> +	void __iomem			*xhci_regs;
> +	struct resource			xhci_res[CDNS3_XHCI_RESOURCES_NUM];
> +	struct cdns3_usb_regs __iomem	*dev_regs;
> +
> +	struct resource			otg_res;
> +	struct cdns3_otg_legacy_regs	*otg_v0_regs;
> +	struct cdns3_otg_regs		*otg_v1_regs;
> +	struct cdns3_otg_common_regs	*otg_regs;
> +#define CDNS3_CONTROLLER_V0	0
> +#define CDNS3_CONTROLLER_V1	1
> +	u32				version;
> +
> +	int				otg_irq;
> +	int				dev_irq;
> +	struct cdns3_role_driver	*roles[CDNS3_ROLE_END];
> +	enum cdns3_roles		role;
> +	struct platform_device		*host_dev;
> +	struct cdns3_device		*gadget_dev;
> +	struct phy			*usb2_phy;
> +	struct phy			*usb3_phy;
> +	struct work_struct		role_switch_wq;
> +	int				wakeup_int:1;
> +	/* mutext used in workqueue*/
> +	struct mutex			mutex;
> +	enum usb_dr_mode		dr_mode;
> +	enum usb_dr_mode		current_dr_mode;
> +	enum usb_dr_mode		desired_dr_mode;
> +	struct dentry			*root;
> +	int				debug_disable:1;
> +};
> +
> +void cdns3_role_stop(struct cdns3 *cdns);
> +int cdns3_handshake(void __iomem *ptr, u32 mask, u32 done, int usec);
> +
> +#endif /* __LINUX_CDNS3_CORE_H */
> diff --git a/drivers/usb/cdns3/debug.h b/drivers/usb/cdns3/debug.h
> new file mode 100644
> index 000000000000..65c3d8a6cd62
> --- /dev/null
> +++ b/drivers/usb/cdns3/debug.h
> @@ -0,0 +1,173 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Cadence USBSS DRD Driver.
> + * Debug header file.
> + *
> + * Copyright (C) 2018-2019 Cadence.
> + *
> + * Author: Pawel Laszczak <pawell@cadence.com>
> + */
> +#ifndef __LINUX_CDNS3_DEBUG
> +#define __LINUX_CDNS3_DEBUG
> +
> +#include "core.h"
> +
> +static inline char *cdns3_decode_usb_irq(char *str,
> +					 enum usb_device_speed speed,
> +					 u32 usb_ists)
> +{
> +	int ret;
> +
> +	ret = sprintf(str, "IRQ %08x = ", usb_ists);
> +
> +	if (usb_ists & (USB_ISTS_CON2I | USB_ISTS_CONI)) {
> +		ret += sprintf(str + ret, "Connection %s\n",
> +			       usb_speed_string(speed));
> +	}
> +	if (usb_ists & USB_ISTS_DIS2I || usb_ists & USB_ISTS_DISI)
> +		ret += sprintf(str + ret, "Disconnection ");
> +	if (usb_ists & USB_ISTS_L2ENTI)
> +		ret += sprintf(str + ret, "suspended ");
> +	if (usb_ists & USB_ISTS_L1ENTI)
> +		ret += sprintf(str + ret, "L1 enter ");
> +	if (usb_ists & USB_ISTS_L1EXTI)
> +		ret += sprintf(str + ret, "L1 exit ");
> +	if (usb_ists & USB_ISTS_L2ENTI)
> +		ret += sprintf(str + ret, "L2 enter ");
> +	if (usb_ists & USB_ISTS_L2EXTI)
> +		ret += sprintf(str + ret, "L2 exit ");
> +	if (usb_ists & USB_ISTS_U3EXTI)
> +		ret += sprintf(str + ret, "U3 exit ");
> +	if (usb_ists & USB_ISTS_UWRESI)
> +		ret += sprintf(str + ret, "Warm Reset ");
> +	if (usb_ists & USB_ISTS_UHRESI)
> +		ret += sprintf(str + ret, "Hot Reset ");
> +	if (usb_ists & USB_ISTS_U2RESI)
> +		ret += sprintf(str + ret, "Reset");
> +
> +	return str;
> +}
> +
> +static inline  char *cdns3_decode_ep_irq(char *str,
> +					 u32 ep_sts,
> +					 const char *ep_name)
> +{
> +	int ret;
> +
> +	ret = sprintf(str, "IRQ for %s: %08x ", ep_name, ep_sts);
> +
> +	if (ep_sts & EP_STS_SETUP)
> +		ret += sprintf(str + ret, "SETUP ");
> +	if (ep_sts & EP_STS_IOC)
> +		ret += sprintf(str + ret, "IOC ");
> +	if (ep_sts & EP_STS_ISP)
> +		ret += sprintf(str + ret, "ISP ");
> +	if (ep_sts & EP_STS_DESCMIS)
> +		ret += sprintf(str + ret, "DESCMIS ");
> +	if (ep_sts & EP_STS_STREAMR)
> +		ret += sprintf(str + ret, "STREAMR ");
> +	if (ep_sts & EP_STS_MD_EXIT)
> +		ret += sprintf(str + ret, "MD_EXIT ");
> +	if (ep_sts & EP_STS_TRBERR)
> +		ret += sprintf(str + ret, "TRBERR ");
> +	if (ep_sts & EP_STS_NRDY)
> +		ret += sprintf(str + ret, "NRDY ");
> +	if (ep_sts & EP_STS_PRIME)
> +		ret += sprintf(str + ret, "PRIME ");
> +	if (ep_sts & EP_STS_SIDERR)
> +		ret += sprintf(str + ret, "SIDERRT ");
> +	if (ep_sts & EP_STS_OUTSMM)
> +		ret += sprintf(str + ret, "OUTSMM ");
> +	if (ep_sts & EP_STS_ISOERR)
> +		ret += sprintf(str + ret, "ISOERR ");
> +	if (ep_sts & EP_STS_IOT)
> +		ret += sprintf(str + ret, "IOT ");
> +
> +	return str;
> +}
> +
> +static inline char *cdns3_decode_epx_irq(char *str,
> +					 char *ep_name,
> +					 u32 ep_sts)
> +{
> +	return cdns3_decode_ep_irq(str, ep_sts, ep_name);
> +}
> +
> +static inline char *cdns3_decode_ep0_irq(char *str,
> +					 int dir,
> +					 u32 ep_sts)
> +{
> +	return cdns3_decode_ep_irq(str, ep_sts,
> +				   dir ? "ep0IN" : "ep0OUT");
> +}
> +
> +/**
> + * Debug a transfer ring.
> + *
> + * Prints out all TRBs in the endpoint ring, even those after the Link TRB.
> + *.
> + */
> +static inline char *cdns3_dbg_ring(struct cdns3_endpoint *priv_ep,
> +				   struct cdns3_trb *ring, char *str)
> +{
> +	dma_addr_t addr = priv_ep->trb_pool_dma;
> +	struct cdns3_trb *trb;
> +	int trb_per_sector;
> +	int ret = 0;
> +	int i;
> +
> +	trb_per_sector = GET_TRBS_PER_SEGMENT(priv_ep->type);
> +
> +	trb = &priv_ep->trb_pool[priv_ep->dequeue];
> +	ret += sprintf(str + ret, "\n\t\tRing contents for %s:", priv_ep->name);
> +
> +	ret += sprintf(str + ret,
> +		       "\n\t\tRing deq index: %d, trb: %p (virt), 0x%llx (dma)\n",
> +		       priv_ep->dequeue, trb,
> +		       (unsigned long long)cdns3_trb_virt_to_dma(priv_ep, trb));
> +
> +	trb = &priv_ep->trb_pool[priv_ep->enqueue];
> +	ret += sprintf(str + ret,
> +		       "\t\tRing enq index: %d, trb: %p (virt), 0x%llx (dma)\n",
> +		       priv_ep->enqueue, trb,
> +		       (unsigned long long)cdns3_trb_virt_to_dma(priv_ep, trb));
> +
> +	ret += sprintf(str + ret,
> +		       "\t\tfree trbs: %d, CCS=%d, PCS=%d\n",
> +		       priv_ep->free_trbs, priv_ep->ccs, priv_ep->pcs);
> +
> +	if (trb_per_sector > TRBS_PER_SEGMENT)
> +		trb_per_sector = TRBS_PER_SEGMENT;
> +
> +	if (trb_per_sector > TRBS_PER_SEGMENT) {
> +		sprintf(str + ret, "\t\tTo big transfer ring %d\n",
> +			trb_per_sector);
> +		return str;
> +	}
> +
> +	for (i = 0; i < trb_per_sector; ++i) {
> +		trb = &ring[i];
> +		ret += sprintf(str + ret,
> +			"\t\t@%pad %08x %08x %08x\n", &addr,
> +			le32_to_cpu(trb->buffer),
> +			le32_to_cpu(trb->length),
> +			le32_to_cpu(trb->control));
> +		addr += sizeof(*trb);
> +	}
> +
> +	return str;
> +}
> +
> +void cdns3_dbg(struct cdns3_device *priv_dev, const char *fmt, ...);
> +
> +#ifdef CONFIG_DEBUG_FS
> +void cdns3_debugfs_init(struct cdns3 *cdns);
> +void cdns3_debugfs_exit(struct cdns3 *cdns);
> +#else
> +void cdns3_debugfs_init(struct cdns3 *cdns);
> +{  }
> +void cdns3_debugfs_exit(struct cdns3 *cdns);
> +{  }
> +#endif
> +
> +#endif /*__LINUX_CDNS3_DEBUG*/
> diff --git a/drivers/usb/cdns3/debugfs.c b/drivers/usb/cdns3/debugfs.c
> new file mode 100644
> index 000000000000..44ee78a10eb8
> --- /dev/null
> +++ b/drivers/usb/cdns3/debugfs.c
> @@ -0,0 +1,153 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cadence USBSS DRD Controller DebugFS filer.
> + *
> + * Copyright (C) 2018-2019 Cadence.
> + *
> + * Author: Pawel Laszczak <pawell@cadence.com>
> + */
> +
> +#include <linux/types.h>
> +#include <linux/debugfs.h>
> +#include <linux/seq_file.h>
> +#include <linux/uaccess.h>
> +
> +#include "core.h"
> +#include "gadget.h"
> +#include "drd.h"
> +
> +static const char *const cdns3_mode[] = {
> +	[USB_DR_MODE_UNKNOWN]		= "unknown",
> +	[USB_DR_MODE_OTG]		= "otg",
> +	[USB_DR_MODE_HOST]		= "host",
> +	[USB_DR_MODE_PERIPHERAL]	= "device",
> +};

don't we have a generic version of this under usb/common ?

> +static int cdns3_mode_show(struct seq_file *s, void *unused)
> +{
> +	struct cdns3 *cdns = s->private;
> +
> +	seq_puts(s, cdns3_mode[cdns->current_dr_mode]);
> +
> +	return 0;
> +}
> +
> +static int cdns3_mode_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, cdns3_mode_show, inode->i_private);
> +}
> +
> +static ssize_t cdns3_mode_write(struct file *file,
> +				const char __user *ubuf,
> +				size_t count, loff_t *ppos)
> +{
> +	struct seq_file	 *s = file->private_data;
> +	struct cdns3 *cdns = s->private;
> +	char buf[32];
> +	int ret;
> +
> +	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
> +		return -EFAULT;
> +
> +	if (cdns->debug_disable) {
> +		dev_err(cdns->dev,
> +			"Mode can't be changed when disable is set\n");
> +		return -EPERM;
> +	}
> +
> +	ret = match_string(cdns3_mode, ARRAY_SIZE(cdns3_mode), buf);
> +	if (ret < 0 || ret == USB_DR_MODE_UNKNOWN) {
> +		dev_err(cdns->dev, "Failed: incorrect mode setting\n");
> +		return -EINVAL;
> +	}
> +
> +	if (cdns->current_dr_mode != ret) {
> +		cdns->desired_dr_mode = ret;
> +		cdns3_role_stop(cdns);
> +		ret = cdns3_drd_update_mode(cdns);
> +		if (ret)
> +			return ret;
> +
> +		queue_work(system_freezable_wq, &cdns->role_switch_wq);
> +	}
> +
> +	return count;
> +}
> +
> +static const struct file_operations cdns3_mode_fops = {
> +	.open			= cdns3_mode_open,
> +	.write			= cdns3_mode_write,
> +	.read			= seq_read,
> +	.llseek			= seq_lseek,
> +	.release		= single_release,
> +};
> +
> +static int cdns3_disable_show(struct seq_file *s, void *unused)
> +{
> +	struct cdns3 *cdns = s->private;
> +
> +	if (!cdns->debug_disable)
> +		seq_puts(s, "0\n");
> +	else
> +		seq_puts(s, "1\n");
> +
> +	return 0;
> +}
> +
> +static ssize_t cdns3_disable_write(struct file *file,
> +				   const char __user *ubuf,
> +				   size_t count, loff_t *ppos)
> +{
> +	struct seq_file	 *s = file->private_data;
> +	struct cdns3 *cdns = s->private;
> +	bool disable;
> +	char buf[16];
> +
> +	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
> +		return -EFAULT;
> +
> +	if (kstrtobool(buf, &disable)) {
> +		dev_err(cdns->dev, "wrong setting\n");
> +		return -EINVAL;
> +	}
> +
> +	if (disable != cdns->debug_disable) {
> +		cdns->debug_disable = disable;
> +		queue_work(system_freezable_wq, &cdns->role_switch_wq);
> +	}
> +
> +	return count;
> +}
> +
> +static int cdns3_disable_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, cdns3_disable_show, inode->i_private);
> +}
> +
> +static const struct file_operations cdns3_disable_fops = {
> +	.open			= cdns3_disable_open,
> +	.write			= cdns3_disable_write,
> +	.read			= seq_read,
> +	.llseek			= seq_lseek,
> +	.release		= single_release,
> +};
> +
> +void cdns3_debugfs_init(struct cdns3 *cdns)
> +{
> +	struct dentry *root;
> +
> +	root = debugfs_create_dir(dev_name(cdns->dev), NULL);

put this under usb root. I should move dwc3 there too.

> +	cdns->root = root;
> +	if (IS_ENABLED(CONFIG_USB_CDNS3_GADGET) &&
> +	    IS_ENABLED(CONFIG_USB_CDNS3_HOST))
> +		debugfs_create_file("mode", 0644, root, cdns,
> +				    &cdns3_mode_fops);
> +
> +	debugfs_create_file("disable", 0644, root, cdns,
> +			    &cdns3_disable_fops);
> +}
> +
> +void cdns3_debugfs_exit(struct cdns3 *cdns)
> +{
> +	debugfs_remove_recursive(cdns->root);
> +}
> diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
> new file mode 100644
> index 000000000000..b06929fe1175
> --- /dev/null
> +++ b/drivers/usb/cdns3/drd.c
> @@ -0,0 +1,379 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cadence USBSS DRD Driver.
> + *
> + * Copyright (C) 2018-2019 Cadence.
> + * Copyright (C) 2019 Texas Instruments
> + *
> + * Author: Pawel Laszczak <pawell@cadence.com>
> + *         Roger Quadros <rogerq@ti.com>
> + *
> + *
> + */
> +#include <linux/kernel.h>
> +#include <linux/interrupt.h>
> +#include <linux/delay.h>
> +#include <linux/usb/otg.h>
> +
> +#include "gadget.h"
> +#include "drd.h"
> +#include "core.h"
> +
> +/**
> + * cdns3_set_mode - change mode of OTG Core
> + * @cdns: pointer to context structure
> + * @mode: selected mode from cdns_role
> + *
> + * Returns 0 on success otherwise negative errno
> + */
> +int cdns3_set_mode(struct cdns3 *cdns, enum usb_dr_mode mode)
> +{
> +	int ret = 0;
> +	u32 reg;
> +
> +	cdns->current_dr_mode = mode;
> +
> +	switch (mode) {
> +	case USB_DR_MODE_PERIPHERAL:
> +		break;
> +	case USB_DR_MODE_HOST:
> +		break;
> +	case USB_DR_MODE_OTG:
> +		dev_dbg(cdns->dev, "Set controller to OTG mode\n");
> +		if (cdns->version == CDNS3_CONTROLLER_V1) {
> +			reg = readl(&cdns->otg_v1_regs->override);
> +			reg |= OVERRIDE_IDPULLUP;
> +			writel(reg, &cdns->otg_v1_regs->override);
> +		} else {
> +			reg = readl(&cdns->otg_v0_regs->ctrl1);
> +			reg |= OVERRIDE_IDPULLUP_V0;
> +			writel(reg, &cdns->otg_v0_regs->ctrl1);
> +		}
> +
> +		/*
> +		 * Hardware specification says: "ID_VALUE must be valid within
> +		 * 50ms after idpullup is set to '1" so driver must wait
> +		 * 50ms before reading this pin.
> +		 */
> +		usleep_range(50000, 60000);
> +		break;
> +	default:
> +		cdns->current_dr_mode = USB_DR_MODE_UNKNOWN;
> +		dev_err(cdns->dev, "Unsupported mode of operation %d\n", mode);
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +int cdns3_get_id(struct cdns3 *cdns)
> +{
> +	int id;
> +
> +	id = readl(&cdns->otg_regs->sts) & OTGSTS_ID_VALUE;
> +	dev_dbg(cdns->dev, "OTG ID: %d", id);
> +
> +	return id;
> +}
> +
> +int cdns3_get_vbus(struct cdns3 *cdns)
> +{
> +	int vbus;
> +
> +	vbus = !!(readl(&cdns->otg_regs->sts) & OTGSTS_VBUS_VALID);
> +	dev_dbg(cdns->dev, "OTG VBUS: %d", vbus);
> +	return vbus;
> +}
> +
> +int cdns3_is_host(struct cdns3 *cdns)
> +{
> +	if (cdns->current_dr_mode == USB_DR_MODE_HOST)
> +		return 1;
> +	else if (!cdns3_get_id(cdns))
> +		return 1;
> +
> +	return 0;
> +}
> +
> +int cdns3_is_device(struct cdns3 *cdns)
> +{
> +	if (cdns->current_dr_mode == USB_DR_MODE_PERIPHERAL)
> +		return 1;
> +	else if (cdns->current_dr_mode == USB_DR_MODE_OTG)
> +		if (cdns3_get_id(cdns))
> +			return 1;
> +
> +	return 0;
> +}
> +
> +/**
> + * cdns3_otg_disable_irq - Disable all OTG interrupts
> + * @cdns: Pointer to controller context structure
> + */
> +static void cdns3_otg_disable_irq(struct cdns3 *cdns)
> +{
> +	writel(0, &cdns->otg_regs->ien);
> +}
> +
> +/**
> + * cdns3_otg_enable_irq - enable id and sess_valid interrupts
> + * @cdns: Pointer to controller context structure
> + */
> +static void cdns3_otg_enable_irq(struct cdns3 *cdns)
> +{
> +	writel(OTGIEN_ID_CHANGE_INT | OTGIEN_VBUSVALID_RISE_INT |
> +	       OTGIEN_VBUSVALID_FALL_INT, &cdns->otg_regs->ien);
> +}
> +
> +/**
> + * cdns3_drd_switch_host - start/stop host
> + * @cdns: Pointer to controller context structure
> + * @on: 1 for start, 0 for stop
> + *
> + * Returns 0 on success otherwise negative errno
> + */
> +int cdns3_drd_switch_host(struct cdns3 *cdns, int on)
> +{
> +	int ret;
> +	u32 reg = OTGCMD_OTG_DIS;
> +
> +	/* switch OTG core */
> +	if (on) {
> +		writel(OTGCMD_HOST_BUS_REQ | reg, &cdns->otg_regs->cmd);
> +
> +		dev_dbg(cdns->dev, "Waiting till Host mode is turned on\n");
> +		ret = cdns3_handshake(&cdns->otg_regs->sts, OTGSTS_XHCI_READY,
> +				      OTGSTS_XHCI_READY, 100000);
> +
> +		if (ret) {
> +			dev_err(cdns->dev, "timeout waiting for xhci_ready\n");
> +			return ret;
> +		}
> +	} else {
> +		writel(OTGCMD_HOST_BUS_DROP | OTGCMD_DEV_BUS_DROP |
> +		       OTGCMD_DEV_POWER_OFF | OTGCMD_HOST_POWER_OFF,
> +		       &cdns->otg_regs->cmd);
> +		/* Waiting till H_IDLE state.*/
> +		cdns3_handshake(&cdns->otg_regs->state,
> +				OTGSTATE_HOST_STATE_MASK,
> +				0, 2000000);
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * cdns3_drd_switch_gadget - start/stop gadget
> + * @cdns: Pointer to controller context structure
> + * @on: 1 for start, 0 for stop
> + *
> + * Returns 0 on success otherwise negative errno
> + */
> +int cdns3_drd_switch_gadget(struct cdns3 *cdns, int on)
> +{
> +	int ret;
> +	u32 reg = OTGCMD_OTG_DIS;
> +
> +	/* switch OTG core */
> +	if (on) {
> +		writel(OTGCMD_DEV_BUS_REQ | reg, &cdns->otg_regs->cmd);
> +
> +		dev_dbg(cdns->dev, "Waiting till Device mode is turned on\n");
> +
> +		ret = cdns3_handshake(&cdns->otg_regs->sts, OTGSTS_DEV_READY,
> +				      OTGSTS_DEV_READY, 100000);
> +
> +		if (ret) {
> +			dev_err(cdns->dev, "timeout waiting for dev_ready\n");
> +			return ret;
> +		}
> +	} else {
> +		/*
> +		 * driver should wait at least 10us after disabling Device
> +		 * before turning-off Device (DEV_BUS_DROP)
> +		 */
> +		usleep_range(20, 30);
> +		writel(OTGCMD_HOST_BUS_DROP | OTGCMD_DEV_BUS_DROP |
> +		       OTGCMD_DEV_POWER_OFF | OTGCMD_HOST_POWER_OFF,
> +		       &cdns->otg_regs->cmd);
> +		/* Waiting till DEV_IDLE state.*/
> +		cdns3_handshake(&cdns->otg_regs->state, OTGSTATE_DEV_STATE_MASK,
> +				0, 2000000);
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * cdns3_init_otg_mode - initialize drd controller
> + * @cdns: Pointer to controller context structure
> + *
> + * Returns 0 on success otherwise negative errno
> + */
> +static int cdns3_init_otg_mode(struct cdns3 *cdns)
> +{
> +	int ret = 0;
> +
> +	cdns3_otg_disable_irq(cdns);
> +	/* clear all interrupts */
> +	writel(~0, &cdns->otg_regs->ivect);
> +
> +	ret = cdns3_set_mode(cdns, USB_DR_MODE_OTG);
> +	if (ret)
> +		return ret;
> +
> +	cdns3_otg_enable_irq(cdns);
> +	return ret;
> +}
> +
> +/**
> + * cdns3_drd_update_mode - initialize mode of operation
> + * @cdns: Pointer to controller context structure
> + *
> + * Returns 0 on success otherwise negative errno
> + */
> +int cdns3_drd_update_mode(struct cdns3 *cdns)
> +{
> +	int ret = 0;
> +
> +	if (cdns->desired_dr_mode == cdns->current_dr_mode)
> +		return ret;
> +
> +	switch (cdns->desired_dr_mode) {
> +	case USB_DR_MODE_PERIPHERAL:
> +		ret = cdns3_set_mode(cdns, USB_DR_MODE_PERIPHERAL);
> +		break;
> +	case USB_DR_MODE_HOST:
> +		ret = cdns3_set_mode(cdns, USB_DR_MODE_HOST);
> +		break;
> +	case USB_DR_MODE_OTG:
> +		ret = cdns3_init_otg_mode(cdns);
> +		break;
> +	default:
> +		dev_err(cdns->dev, "Unsupported mode of operation %d\n",
> +			cdns->dr_mode);
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + * cdns3_drd_irq - interrupt handler for OTG events
> + *
> + * @irq: irq number for cdns3 core device
> + * @data: structure of cdns3
> + *
> + * Returns IRQ_HANDLED or IRQ_NONE
> + */
> +static irqreturn_t cdns3_drd_irq(int irq, void *data)
> +{
> +	irqreturn_t ret = IRQ_NONE;
> +	struct cdns3 *cdns = data;
> +	u32 reg;
> +
> +	if (cdns->dr_mode != USB_DR_MODE_OTG)
> +		return ret;
> +
> +	reg = readl(&cdns->otg_regs->ivect);
> +
> +	if (!reg)
> +		return ret;
> +
> +	if (reg & OTGIEN_ID_CHANGE_INT) {
> +		dev_dbg(cdns->dev, "OTG IRQ: new ID: %d\n",
> +			cdns3_get_id(cdns));
> +
> +		ret = IRQ_HANDLED;
> +	}
> +
> +	if (reg & (OTGIEN_VBUSVALID_RISE_INT | OTGIEN_VBUSVALID_FALL_INT)) {
> +		dev_dbg(cdns->dev, "OTG IRQ: new VBUS: %d\n",
> +			cdns3_get_vbus(cdns));
> +
> +		ret = IRQ_HANDLED;
> +	}
> +
> +	if (ret == IRQ_HANDLED)
> +		queue_work(system_freezable_wq, &cdns->role_switch_wq);
> +
> +	writel(~0, &cdns->otg_regs->ivect);
> +	return ret;
> +}

seems like you could use threaded irq to avoid this workqueue.

> +int cdns3_drd_init(struct cdns3 *cdns)
> +{
> +	void __iomem *regs;
> +	int ret = 0;
> +	u32 state;
> +
> +	regs = devm_ioremap_resource(cdns->dev, &cdns->otg_res);
> +	if (IS_ERR(regs))
> +		return PTR_ERR(regs);
> +
> +	/* Detection of DRD version. Controller has been released
> +	 * in two versions. Both are similar, but they have same changes
> +	 * in register maps.
> +	 * The first register in old version is command register and it's read
> +	 * only, so driver should read 0 from it. On the other hand, in v1
> +	 * the first register contains device ID number which is not set to 0.
> +	 * Driver uses this fact to detect the proper version of
> +	 * controller.
> +	 */
> +	cdns->otg_v0_regs = regs;
> +	if (!readl(&cdns->otg_v0_regs->cmd)) {
> +		cdns->version  = CDNS3_CONTROLLER_V0;
> +		cdns->otg_v1_regs = NULL;
> +		cdns->otg_regs = regs;
> +		writel(1, &cdns->otg_v0_regs->simulate);
> +		dev_info(cdns->dev, "DRD version v0 (%08x)\n",
> +			 readl(&cdns->otg_v0_regs->version));
> +	} else {
> +		cdns->otg_v0_regs = NULL;
> +		cdns->otg_v1_regs = regs;
> +		cdns->otg_regs = (void *)&cdns->otg_v1_regs->cmd;
> +		cdns->version  = CDNS3_CONTROLLER_V1;
> +		writel(1, &cdns->otg_v1_regs->simulate);
> +		dev_info(cdns->dev, "DRD version v1 (ID: %08x, rev: %08x)\n",
> +			 readl(&cdns->otg_v1_regs->did),
> +			 readl(&cdns->otg_v1_regs->rid));
> +	}
> +
> +	state = OTGSTS_STRAP(readl(&cdns->otg_regs->sts));
> +
> +	/* Update dr_mode according to STRAP configuration. */
> +	cdns->dr_mode = USB_DR_MODE_OTG;
> +	if (state == OTGSTS_STRAP_HOST) {
> +		dev_dbg(cdns->dev, "Controller strapped to HOST\n");
> +		cdns->dr_mode = USB_DR_MODE_HOST;
> +	} else if (state == OTGSTS_STRAP_GADGET) {
> +		dev_dbg(cdns->dev, "Controller strapped to PERIPHERAL\n");
> +		cdns->dr_mode = USB_DR_MODE_PERIPHERAL;
> +	}
> +
> +	cdns->desired_dr_mode = cdns->dr_mode;
> +	cdns->current_dr_mode = USB_DR_MODE_UNKNOWN;
> +
> +	ret = devm_request_threaded_irq(cdns->dev, cdns->otg_irq,
> +					cdns3_drd_irq,
> +					NULL, IRQF_SHARED,

if you don't have a threaded handler, you should set IRQF_ONESHOT. I
would prefer if you implement a threaded handler that doesn't require
IRQF_ONESHOT, though.

> +					dev_name(cdns->dev), cdns);
> +
> +	if (ret) {
> +		dev_err(cdns->dev, "couldn't get otg_irq\n");
> +		return ret;
> +	}
> +
> +	state = readl(&cdns->otg_regs->sts);
> +	if (OTGSTS_OTG_NRDY(state) != 0) {
> +		dev_err(cdns->dev, "Cadence USB3 OTG device not ready\n");
> +		return -ENODEV;
> +	}
> +
> +	return ret;
> +}
> +
> +int cdns3_drd_exit(struct cdns3 *cdns)
> +{
> +	return 0;
> +}
> diff --git a/drivers/usb/cdns3/drd.h b/drivers/usb/cdns3/drd.h
> new file mode 100644
> index 000000000000..bf6c7bc41b58
> --- /dev/null
> +++ b/drivers/usb/cdns3/drd.h
> @@ -0,0 +1,166 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Cadence USB3 DRD header file.
> + *
> + * Copyright (C) 2018-2019 Cadence.
> + *
> + * Author: Pawel Laszczak <pawell@cadence.com>
> + */
> +#ifndef __LINUX_CDNS3_DRD
> +#define __LINUX_CDNS3_DRD
> +
> +#include <linux/usb/otg.h>
> +#include <linux/phy/phy.h>
> +#include "core.h"
> +
> +/*  DRD register interface for version v1. */
> +struct cdns3_otg_regs {
> +	__le32 did;
> +	__le32 rid;
> +	__le32 capabilities;
> +	__le32 reserved1;
> +	__le32 cmd;
> +	__le32 sts;
> +	__le32 state;
> +	__le32 reserved2;
> +	__le32 ien;
> +	__le32 ivect;
> +	__le32 refclk;
> +	__le32 tmr;
> +	__le32 reserved3[4];
> +	__le32 simulate;
> +	__le32 override;
> +	__le32 susp_ctrl;
> +	__le32 reserved4;
> +	__le32 anasts;
> +	__le32 adp_ramp_time;
> +	__le32 ctrl1;
> +	__le32 ctrl2;
> +};
> +
> +/*  DRD register interface for version v0. */
> +struct cdns3_otg_legacy_regs {
> +	__le32 cmd;
> +	__le32 sts;
> +	__le32 state;
> +	__le32 refclk;
> +	__le32 ien;
> +	__le32 ivect;
> +	__le32 reserved1[3];
> +	__le32 tmr;
> +	__le32 reserved2[2];
> +	__le32 version;
> +	__le32 capabilities;
> +	__le32 reserved3[2];
> +	__le32 simulate;
> +	__le32 reserved4[5];
> +	__le32 ctrl1;
> +};
> +
> +/*
> + * Common registers interface for both version of DRD.
> + */
> +struct cdns3_otg_common_regs {
> +	__le32 cmd;
> +	__le32 sts;
> +	__le32 state;
> +	__le32 different1;
> +	__le32 ien;
> +	__le32 ivect;
> +};
> +
> +/* CDNS_RID - bitmasks */
> +#define CDNS_RID(p)			((p) & GENMASK(15, 0))
> +
> +/* CDNS_VID - bitmasks */
> +#define CDNS_DID(p)			((p) & GENMASK(31, 0))
> +
> +/* OTGCMD - bitmasks */
> +/* "Request the bus for Device mode. */
> +#define OTGCMD_DEV_BUS_REQ		BIT(0)
> +/* Request the bus for Host mode */
> +#define OTGCMD_HOST_BUS_REQ		BIT(1)
> +/* Enable OTG mode. */
> +#define OTGCMD_OTG_EN			BIT(2)
> +/* Disable OTG mode */
> +#define OTGCMD_OTG_DIS			BIT(3)
> +/*"Configure OTG as A-Device. */
> +#define OTGCMD_A_DEV_EN			BIT(4)
> +/*"Configure OTG as A-Device. */
> +#define OTGCMD_A_DEV_DIS		BIT(5)
> +/* Drop the bus for Device mod	e. */
> +#define OTGCMD_DEV_BUS_DROP		BIT(8)
> +/* Drop the bus for Host mode*/
> +#define OTGCMD_HOST_BUS_DROP		BIT(9)
> +/* Power Down USBSS-DEV. */
> +#define OTGCMD_DEV_POWER_OFF		BIT(11)
> +/* Power Down CDNSXHCI. */
> +#define OTGCMD_HOST_POWER_OFF		BIT(12)
> +
> +/* OTGIEN - bitmasks */
> +/* ID change interrupt enable */
> +#define OTGIEN_ID_CHANGE_INT		BIT(0)
> +/* Vbusvalid fall detected interrupt enable.*/
> +#define OTGIEN_VBUSVALID_RISE_INT	BIT(4)
> +/* Vbusvalid fall detected interrupt enable */
> +#define OTGIEN_VBUSVALID_FALL_INT	BIT(5)
> +
> +/* OTGSTS - bitmasks */
> +/*
> + * Current value of the ID pin. It is only valid when idpullup in
> + *  OTGCTRL1_TYPE register is set to '1'.
> + */
> +#define OTGSTS_ID_VALUE			BIT(0)
> +/* Current value of the vbus_valid */
> +#define OTGSTS_VBUS_VALID		BIT(1)
> +/* Current value of the b_sess_vld */
> +#define OTGSTS_SESSION_VALID		BIT(2)
> +/*Device mode is active*/
> +#define OTGSTS_DEV_ACTIVE		BIT(3)
> +/* Host mode is active. */
> +#define OTGSTS_HOST_ACTIVE		BIT(4)
> +/* OTG Controller not ready. */
> +#define OTGSTS_OTG_NRDY_MASK		BIT(11)
> +#define OTGSTS_OTG_NRDY(p)		((p) & OTGSTS_OTG_NRDY_MASK)
> +/*
> + * Value of the strap pins.
> + * 000 - no default configuration
> + * 010 - Controller initiall configured as Host
> + * 100 - Controller initially configured as Device
> + */
> +#define OTGSTS_STRAP(p)			(((p) & GENMASK(14, 12)) >> 12)
> +#define OTGSTS_STRAP_NO_DEFAULT_CFG	0x00
> +#define OTGSTS_STRAP_HOST_OTG		0x01
> +#define OTGSTS_STRAP_HOST		0x02
> +#define OTGSTS_STRAP_GADGET		0x04
> +/* Host mode is turned on. */
> +#define OTGSTS_XHCI_READY		BIT(26)
> +/* "Device mode is turned on .*/
> +#define OTGSTS_DEV_READY		BIT(27)
> +
> +/* OTGSTATE- bitmasks */
> +#define OTGSTATE_DEV_STATE_MASK		GENMASK(2, 0)
> +#define OTGSTATE_HOST_STATE_MASK	GENMASK(5, 3)
> +#define OTGSTATE_HOST_STATE_IDLE	0x0
> +#define OTGSTATE_HOST_STATE_VBUS_FALL	0x7
> +#define OTGSTATE_HOST_STATE(p)		(((p) & OTGSTATE_HOST_STATE_MASK) >> 3)
> +
> +/* OTGREFCLK - bitmasks */
> +#define OTGREFCLK_STB_CLK_SWITCH_EN	BIT(31)
> +
> +/* OVERRIDE - bitmasks */
> +#define OVERRIDE_IDPULLUP		BIT(0)
> +/* Only for CDNS3_CONTROLLER_V0 version */
> +#define OVERRIDE_IDPULLUP_V0		BIT(24)
> +
> +int cdns3_is_host(struct cdns3 *cdns);
> +int cdns3_is_device(struct cdns3 *cdns);
> +int cdns3_get_id(struct cdns3 *cdns);
> +int cdns3_get_vbus(struct cdns3 *cdns);
> +int cdns3_drd_init(struct cdns3 *cdns);
> +int cdns3_drd_exit(struct cdns3 *cdns);
> +int cdns3_drd_update_mode(struct cdns3 *cdns);
> +int cdns3_drd_switch_gadget(struct cdns3 *cdns, int on);
> +int cdns3_drd_switch_host(struct cdns3 *cdns, int on);
> +
> +#endif /* __LINUX_CDNS3_DRD */
> diff --git a/drivers/usb/cdns3/ep0.c b/drivers/usb/cdns3/ep0.c
> new file mode 100644
> index 000000000000..6fa711ead6d0
> --- /dev/null
> +++ b/drivers/usb/cdns3/ep0.c
> @@ -0,0 +1,920 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cadence USBSS DRD Driver - gadget side.
> + *
> + * Copyright (C) 2018 Cadence Design Systems.
> + * Copyright (C) 2017-2018 NXP
> + *
> + * Authors: Pawel Jez <pjez@cadence.com>,
> + *          Pawel Laszczak <pawell@cadence.com>
> + *          Peter Chen <peter.chen@nxp.com>
> + */
> +
> +#include <linux/usb/composite.h>
> +
> +#include "gadget.h"
> +#include "trace.h"
> +
> +static struct usb_endpoint_descriptor cdns3_gadget_ep0_desc = {
> +	.bLength = USB_DT_ENDPOINT_SIZE,
> +	.bDescriptorType = USB_DT_ENDPOINT,
> +	.bmAttributes =	USB_ENDPOINT_XFER_CONTROL,
> +};
> +
> +/**
> + * cdns3_ep0_run_transfer - Do transfer on default endpoint hardware
> + * @priv_dev: extended gadget object
> + * @dma_addr: physical address where data is/will be stored
> + * @length: data length
> + * @erdy: set it to 1 when ERDY packet should be sent -
> + *        exit from flow control state
> + */
> +static void cdns3_ep0_run_transfer(struct cdns3_device *priv_dev,
> +				   dma_addr_t dma_addr,
> +				   unsigned int length, int erdy, int zlp)
> +{
> +	struct cdns3_usb_regs __iomem *regs = priv_dev->regs;
> +	struct cdns3_endpoint *priv_ep = priv_dev->eps[0];
> +
> +	priv_ep->trb_pool[0].buffer = TRB_BUFFER(dma_addr);
> +	priv_ep->trb_pool[0].length = TRB_LEN(length);
> +
> +	if (zlp) {
> +		priv_ep->trb_pool[0].control = TRB_CYCLE | TRB_TYPE(TRB_NORMAL);
> +		priv_ep->trb_pool[1].buffer = TRB_BUFFER(dma_addr);
> +		priv_ep->trb_pool[1].length = TRB_LEN(0);
> +		priv_ep->trb_pool[1].control = TRB_CYCLE | TRB_IOC |
> +		    TRB_TYPE(TRB_NORMAL);
> +	} else {
> +		priv_ep->trb_pool[0].control = TRB_CYCLE | TRB_IOC |
> +		    TRB_TYPE(TRB_NORMAL);
> +		priv_ep->trb_pool[1].control = 0;
> +	}
> +
> +	trace_cdns3_prepare_trb(priv_ep, priv_ep->trb_pool);
> +
> +	cdns3_select_ep(priv_dev, priv_dev->ep0_data_dir);
> +
> +	writel(EP_STS_TRBERR, &regs->ep_sts);
> +	writel(EP_TRADDR_TRADDR(priv_ep->trb_pool_dma), &regs->ep_traddr);
> +	trace_cdns3_doorbell_ep0(priv_dev->ep0_data_dir ? "ep0in" : "ep0out",
> +				 readl(&regs->ep_traddr));
> +
> +	/* TRB should be prepared before starting transfer. */
> +	writel(EP_CMD_DRDY, &regs->ep_cmd);
> +
> +	/* Resume controller before arming transfer. */
> +	__cdns3_gadget_wakeup(priv_dev);
> +
> +	if (erdy)
> +		writel(EP_CMD_ERDY, &priv_dev->regs->ep_cmd);
> +}
> +
> +/**
> + * cdns3_ep0_delegate_req - Returns status of handling setup packet
> + * Setup is handled by gadget driver
> + * @priv_dev: extended gadget object
> + * @ctrl_req: pointer to received setup packet
> + *
> + * Returns zero on success or negative value on failure
> + */
> +static int cdns3_ep0_delegate_req(struct cdns3_device *priv_dev,
> +				  struct usb_ctrlrequest *ctrl_req)
> +{
> +	int ret;
> +
> +	spin_unlock(&priv_dev->lock);
> +	priv_dev->setup_pending = 1;
> +	ret = priv_dev->gadget_driver->setup(&priv_dev->gadget, ctrl_req);
> +	priv_dev->setup_pending = 0;
> +	spin_lock(&priv_dev->lock);
> +	return ret;
> +}
> +
> +static void cdns3_prepare_setup_packet(struct cdns3_device *priv_dev)
> +{
> +	priv_dev->ep0_data_dir = 0;
> +	priv_dev->ep0_stage = CDNS3_SETUP_STAGE;
> +	cdns3_ep0_run_transfer(priv_dev, priv_dev->setup_dma,
> +			       sizeof(struct usb_ctrlrequest), 0, 0);
> +}
> +
> +static void cdns3_ep0_complete_setup(struct cdns3_device *priv_dev,
> +				     u8 send_stall, u8 send_erdy)
> +{
> +	struct cdns3_endpoint *priv_ep = priv_dev->eps[0];
> +	struct usb_request *request;
> +
> +	request = cdns3_next_request(&priv_ep->pending_req_list);
> +	if (request)
> +		list_del_init(&request->list);
> +
> +	if (send_stall) {
> +		cdns3_dbg(priv_ep->cdns3_dev, "STALL for ep0\n");
> +		/* set_stall on ep0 */
> +		cdns3_select_ep(priv_dev, 0x00);
> +		writel(EP_CMD_SSTALL, &priv_dev->regs->ep_cmd);
> +	} else {
> +		cdns3_prepare_setup_packet(priv_dev);
> +	}
> +
> +	priv_dev->ep0_stage = CDNS3_SETUP_STAGE;
> +	writel((send_erdy ? EP_CMD_ERDY : 0) | EP_CMD_REQ_CMPL,
> +	       &priv_dev->regs->ep_cmd);
> +
> +	cdns3_allow_enable_l1(priv_dev, 1);
> +}
> +
> +/**
> + * cdns3_req_ep0_set_configuration - Handling of SET_CONFIG standard USB request
> + * @priv_dev: extended gadget object
> + * @ctrl_req: pointer to received setup packet
> + *
> + * Returns 0 if success, USB_GADGET_DELAYED_STATUS on deferred status stage,
> + * error code on error
> + */
> +static int cdns3_req_ep0_set_configuration(struct cdns3_device *priv_dev,
> +					   struct usb_ctrlrequest *ctrl_req)
> +{
> +	enum usb_device_state device_state = priv_dev->gadget.state;
> +	struct cdns3_endpoint *priv_ep;
> +	u32 config = le16_to_cpu(ctrl_req->wValue);
> +	int result = 0;
> +	int i;
> +
> +	switch (device_state) {
> +	case USB_STATE_ADDRESS:
> +		/* Configure non-control EPs */
> +		for (i = 0; i < CDNS3_ENDPOINTS_MAX_COUNT; i++) {
> +			priv_ep = priv_dev->eps[i];
> +			if (!priv_ep)
> +				continue;
> +
> +			if (priv_ep->flags & EP_CLAIMED)
> +				cdns3_ep_config(priv_ep);
> +		}
> +
> +		result = cdns3_ep0_delegate_req(priv_dev, ctrl_req);
> +
> +		if (result)
> +			return result;
> +
> +		if (config) {
> +			cdns3_set_hw_configuration(priv_dev);
> +		} else {
> +			cdns3_hw_reset_eps_config(priv_dev);
> +			usb_gadget_set_state(&priv_dev->gadget,
> +					     USB_STATE_ADDRESS);
> +		}
> +		break;
> +	case USB_STATE_CONFIGURED:
> +		result = cdns3_ep0_delegate_req(priv_dev, ctrl_req);
> +
> +		if (!config && !result) {
> +			cdns3_hw_reset_eps_config(priv_dev);
> +			usb_gadget_set_state(&priv_dev->gadget,
> +					     USB_STATE_ADDRESS);
> +		}
> +		break;
> +	default:
> +		result = -EINVAL;
> +	}
> +
> +	return result;
> +}
> +
> +/**
> + * cdns3_req_ep0_set_address - Handling of SET_ADDRESS standard USB request
> + * @priv_dev: extended gadget object
> + * @ctrl_req: pointer to received setup packet
> + *
> + * Returns 0 if success, error code on error
> + */
> +static int cdns3_req_ep0_set_address(struct cdns3_device *priv_dev,
> +				     struct usb_ctrlrequest *ctrl_req)
> +{
> +	enum usb_device_state device_state = priv_dev->gadget.state;
> +	u32 reg;
> +	u32 addr;
> +
> +	addr = le16_to_cpu(ctrl_req->wValue);
> +
> +	if (addr > USB_DEVICE_MAX_ADDRESS) {
> +		dev_err(priv_dev->dev,
> +			"Device address (%d) cannot be greater than %d\n",
> +			addr, USB_DEVICE_MAX_ADDRESS);
> +		return -EINVAL;
> +	}
> +
> +	if (device_state == USB_STATE_CONFIGURED) {
> +		dev_err(priv_dev->dev,
> +			"can't set_address from configured state\n");
> +		return -EINVAL;
> +	}
> +
> +	reg = readl(&priv_dev->regs->usb_cmd);
> +
> +	writel(reg | USB_CMD_FADDR(addr) | USB_CMD_SET_ADDR,
> +	       &priv_dev->regs->usb_cmd);
> +
> +	usb_gadget_set_state(&priv_dev->gadget,
> +			     (addr ? USB_STATE_ADDRESS : USB_STATE_DEFAULT));
> +
> +	return 0;
> +}
> +
> +/**
> + * cdns3_req_ep0_get_status - Handling of GET_STATUS standard USB request
> + * @priv_dev: extended gadget object
> + * @ctrl_req: pointer to received setup packet
> + *
> + * Returns 0 if success, error code on error
> + */
> +static int cdns3_req_ep0_get_status(struct cdns3_device *priv_dev,
> +				    struct usb_ctrlrequest *ctrl)
> +{
> +	__le16 *response_pkt;
> +	u16 usb_status = 0;
> +	u32 recip;
> +	u32 reg;
> +
> +	recip = ctrl->bRequestType & USB_RECIP_MASK;
> +
> +	switch (recip) {
> +	case USB_RECIP_DEVICE:
> +		/* self powered */
> +		if (priv_dev->is_selfpowered)
> +			usb_status = BIT(USB_DEVICE_SELF_POWERED);
> +
> +		if (priv_dev->wake_up_flag)
> +			usb_status |= BIT(USB_DEVICE_REMOTE_WAKEUP);
> +
> +		if (priv_dev->gadget.speed != USB_SPEED_SUPER)
> +			break;
> +
> +		reg = readl(&priv_dev->regs->usb_sts);
> +
> +		if (priv_dev->u1_allowed)
> +			usb_status |= BIT(USB_DEV_STAT_U1_ENABLED);
> +
> +		if (priv_dev->u2_allowed)
> +			usb_status |= BIT(USB_DEV_STAT_U2_ENABLED);
> +
> +		break;
> +	case USB_RECIP_INTERFACE:
> +		return cdns3_ep0_delegate_req(priv_dev, ctrl);
> +	case USB_RECIP_ENDPOINT:
> +		/* check if endpoint is stalled */
> +		cdns3_select_ep(priv_dev, ctrl->wIndex);
> +		if (EP_STS_STALL(readl(&priv_dev->regs->ep_sts)))
> +			usb_status =  BIT(USB_ENDPOINT_HALT);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	response_pkt = (__le16 *)priv_dev->setup_buf;
> +	*response_pkt = cpu_to_le16(usb_status);
> +
> +	cdns3_ep0_run_transfer(priv_dev, priv_dev->setup_dma,
> +			       sizeof(*response_pkt), 1, 0);
> +	return 0;
> +}
> +
> +static int cdns3_ep0_feature_handle_device(struct cdns3_device *priv_dev,
> +					   struct usb_ctrlrequest *ctrl,
> +					   int set)
> +{
> +	enum usb_device_state state;
> +	enum usb_device_speed speed;
> +	int ret = 0;
> +	u32 wValue;
> +	u32 wIndex;
> +	u16 tmode;
> +
> +	wValue = le16_to_cpu(ctrl->wValue);
> +	wIndex = le16_to_cpu(ctrl->wIndex);
> +	state = priv_dev->gadget.state;
> +	speed = priv_dev->gadget.speed;
> +
> +	switch (ctrl->wValue) {
> +	case USB_DEVICE_REMOTE_WAKEUP:
> +		priv_dev->wake_up_flag = !!set;
> +		break;
> +	case USB_DEVICE_U1_ENABLE:
> +		if (state != USB_STATE_CONFIGURED || speed != USB_SPEED_SUPER)
> +			return -EINVAL;
> +
> +		priv_dev->u1_allowed = !!set;
> +		break;
> +	case USB_DEVICE_U2_ENABLE:
> +		if (state != USB_STATE_CONFIGURED || speed != USB_SPEED_SUPER)
> +			return -EINVAL;
> +
> +		priv_dev->u2_allowed = !!set;
> +		break;
> +	case USB_DEVICE_LTM_ENABLE:
> +		ret = -EINVAL;
> +		break;
> +	case USB_DEVICE_TEST_MODE:
> +		if (state != USB_STATE_CONFIGURED || speed > USB_SPEED_HIGH)
> +			return -EINVAL;
> +
> +		tmode = le16_to_cpu(ctrl->wIndex);
> +
> +		if (!set || (tmode & 0xff) != 0)
> +			return -EINVAL;
> +
> +		switch (tmode >> 8) {
> +		case TEST_J:
> +		case TEST_K:
> +		case TEST_SE0_NAK:
> +		case TEST_PACKET:
> +			cdns3_ep0_complete_setup(priv_dev, 0, 1);
> +			/**
> +			 *  Little delay to give the controller some time
> +			 * for sending status stage.
> +			 * This time should be less then 3ms.
> +			 */
> +			usleep_range(1000, 2000);
> +			cdns3_set_register_bit(&priv_dev->regs->usb_cmd,
> +					       USB_CMD_STMODE |
> +					       USB_STS_TMODE_SEL(tmode - 1));

I could bet this doesn't work. You're entering test mode before status
stage. Make sure to run your driver against USB CV chapter 9 tests. You
can use g_zero for testing.

> +			break;
> +		default:
> +			ret = -EINVAL;
> +		}
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int cdns3_ep0_feature_handle_intf(struct cdns3_device *priv_dev,
> +					 struct usb_ctrlrequest *ctrl,
> +					 int set)
> +{
> +	u32 wValue;
> +	int ret = 0;
> +
> +	wValue = le16_to_cpu(ctrl->wValue);
> +
> +	switch (wValue) {
> +	case USB_INTRF_FUNC_SUSPEND:
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int cdns3_ep0_feature_handle_endpoint(struct cdns3_device *priv_dev,
> +					     struct usb_ctrlrequest *ctrl,
> +					     int set)
> +{
> +	struct cdns3_endpoint *priv_ep;
> +	int ret = 0;
> +	u8 index;
> +
> +	if (le16_to_cpu(ctrl->wValue) != USB_ENDPOINT_HALT)
> +		return -EINVAL;
> +
> +	if (!(ctrl->wIndex & ~USB_DIR_IN))
> +		return 0;
> +
> +	index = cdns3_ep_addr_to_index(ctrl->wIndex);
> +	priv_ep = priv_dev->eps[index];
> +
> +	cdns3_select_ep(priv_dev, ctrl->wIndex);
> +
> +	if (set) {
> +		cdns3_dbg(priv_ep->cdns3_dev, "Stall endpoint %s\n",
> +			  priv_ep->name);
> +		writel(EP_CMD_SSTALL, &priv_dev->regs->ep_cmd);
> +		priv_ep->flags |= EP_STALL;
> +	} else {
> +		struct usb_request *request;
> +
> +		if (priv_dev->eps[index]->flags & EP_WEDGE) {
> +			cdns3_select_ep(priv_dev, 0x00);
> +			return 0;
> +		}
> +
> +		cdns3_dbg(priv_ep->cdns3_dev, "Clear Stalled endpoint %s\n",
> +			  priv_ep->name);

why do you need your own wrapper around dev_dbg()? This looks quite unnecessary.

I'll stop here and review more at a later moment. Now that I had a look,
this doesn't look ready for prime time yet.

-- 
balbi
