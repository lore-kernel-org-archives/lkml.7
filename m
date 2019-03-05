Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822D7C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 01:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F38A206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 01:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfCEBmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 20:42:43 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:50861 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726783AbfCEBmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 20:42:43 -0500
X-UUID: 422404d3da5841b088ad13359443f0d2-20190305
X-UUID: 422404d3da5841b088ad13359443f0d2-20190305
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 285228643; Tue, 05 Mar 2019 09:42:30 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32N1.mediatek.inc
 (172.27.4.71) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 5 Mar
 2019 09:42:28 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 5 Mar 2019 09:42:26 +0800
Message-ID: <1551750146.2210.78.camel@mhfsdcap03>
Subject: RE: [PATCH v4 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Pawel Laszczak <pawell@cadence.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        "Suresh Punnoose" <sureshp@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Rahul Kumar <kurahul@cadence.com>
Date:   Tue, 5 Mar 2019 09:42:26 +0800
In-Reply-To: <BYAPR07MB470934C0D0C4EB4C5EE9411BDD710@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1550173514-23573-1-git-send-email-pawell@cadence.com>
         <1550173514-23573-6-git-send-email-pawell@cadence.com>
         <1550224667.2210.22.camel@mhfsdcap03>
         <BYAPR07MB470934C0D0C4EB4C5EE9411BDD710@BYAPR07MB4709.namprd07.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Mon, 2019-03-04 at 11:01 +0000, Pawel Laszczak wrote:
> Hi, 
> >
> >hi,
> >On Thu, 2019-02-14 at 19:45 +0000, Pawel Laszczak wrote:
> >> This patch introduce new Cadence USBSS DRD driver to linux kernel.
> >>
> >> The Cadence USBSS DRD Driver is a highly configurable IP Core whichi
> >> can be instantiated as Dual-Role Device (DRD), Peripheral Only and
> >> Host Only (XHCI)configurations.
> >>
> >> The current driver has been validated with FPGA burned. We have support
> >> for PCIe bus, which is used on FPGA prototyping.
> >>
> >> The host side of USBSS-DRD controller is compliance with XHCI
> >> specification, so it works with standard XHCI linux driver.
> >>
> >> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> >> ---
[...]
> >> diff --git a/drivers/usb/cdns3/Kconfig b/drivers/usb/cdns3/Kconfig
> >> new file mode 100644
> >> index 000000000000..27cb3d8dbe3d
> >> --- /dev/null
> >> +++ b/drivers/usb/cdns3/Kconfig
> >> @@ -0,0 +1,44 @@
> >> +config USB_CDNS3
> >> +	tristate "Cadence USB3 Dual-Role Controller"
> >> +	depends on USB_SUPPORT && (USB || USB_GADGET) && HAS_DMA
> >> +	help
> >> +	  Say Y here if your system has a cadence USB3 dual-role controller.
> >> +	  It supports: dual-role switch, Host-only, and Peripheral-only.
> >> +
> >> +	  If you choose to build this driver is a dynamically linked
> >> +	  as module, the module will be called cdns3.ko.
> >> +
> >> +if USB_CDNS3
> >> +
> >> +config USB_CDNS3_GADGET
> >> +        bool "Cadence USB3 device controller"
> >> +        depends on USB_GADGET
> >> +        help
> >> +          Say Y here to enable device controller functionality of the
> >> +          cadence USBSS-DEV driver.
> >> +
> >> +          This controller supports FF, HS and SS mode. It doesn't support
> >> +          LS and SSP mode.
> >> +
> >> +config USB_CDNS3_HOST
> >> +        bool "Cadence USB3 host controller"
> >> +        depends on USB_XHCI_HCD
> >> +        help
> >> +          Say Y here to enable host controller functionality of the
> >> +          cadence driver.
> >> +
> >> +          Host controller is compliant with XHCI so it will use
> >> +          standard XHCI driver.
> >> +
> >> +config USB_CDNS3_PCI_WRAP
> >> +	tristate "Cadence USB3 support on PCIe-based platforms"
> >> +	depends on USB_PCI && ACPI
> >> +	default USB_CDNS3
> >> +	help
> >> +	  If you're using the USBSS Core IP with a PCIe, please say
> >> +	  'Y' or 'M' here.
> >> +
> >> +	  If you choose to build this driver as module it will
> >> +	  be dynamically linked and module will be called cdns3-pci.ko
> >> +
> >> +endif
> >> diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
> >> new file mode 100644
> >> index 000000000000..8f9438593375
> >> --- /dev/null
> >> +++ b/drivers/usb/cdns3/Makefile
> >> @@ -0,0 +1,14 @@
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +# define_trace.h needs to know how to find our header
> >> +CFLAGS_trace.o				:= -I$(src)
> >> +
> >> +cdns3-y					:= core.o drd.o trace.o
> >> +
> >> +obj-$(CONFIG_USB_CDNS3)			+= cdns3.o
> >> +ifneq ($(CONFIG_DEBUG_FS),)
> >> +	cdns3-y				+= debugfs.o
> >> +endif
> >> +
> >> +cdns3-$(CONFIG_USB_CDNS3_GADGET)	+= gadget.o ep0.o
> >> +cdns3-$(CONFIG_USB_CDNS3_HOST)		+= host.o
> >> +obj-$(CONFIG_USB_CDNS3_PCI_WRAP)	+= cdns3-pci-wrap.o
> >when build as module:
> >CONFIG_USB_CDNS3=m
> >CONFIG_USB_CDNS3_GADGET=m
> >CONFIG_USB_CDNS3_HOST=m
> 
> How you set such configuration ? From make menuconfig it's impossible. 
I checked again, I changed it directly for easy test, sorry

> 
> >there is an error:
> >ERROR: "cdns3_handshake" [drivers/usb/cdns3/cdns3.ko] undefined!
> >
> >when only set:
> >CONFIG_USB_CDNS3=y
> >also encounter errors:
> >drivers/usb/cdns3/drd.o: In function `cdns3_drd_switch_gadget':
> >/drivers/usb/cdns3/drd.c:173: undefined reference to `cdns3_handshake'
> >drivers/usb/cdns3/drd.o: In function `cdns3_drd_switch_host':
> >drivers/usb/cdns3/drd.c:139: undefined reference to `cdns3_handshake'
> 
> I will check this. 
> Thanks. 
> 
> >
> >
> >
> >> diff --git a/drivers/usb/cdns3/cdns3-pci-wrap.c b/drivers/usb/cdns3/cdns3-pci-wrap.c
> >> new file mode 100644
> >> index 000000000000..d0b2d3d9b983
> >> --- /dev/null
> >> +++ b/drivers/usb/cdns3/cdns3-pci-wrap.c
> >> @@ -0,0 +1,155 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Cadence USBSS PCI Glue driver
> >> + *
> >> + * Copyright (C) 2018 Cadence.
> >> + *
> >> + * Author: Pawel Laszczak <pawell@cadence.com>
> >> + */
> >> +
> >> +#include <linux/kernel.h>
> >> +#include <linux/module.h>
> >> +#include <linux/pci.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/dma-mapping.h>
> >> +#include <linux/slab.h>
> >> +
> >> +struct cdns3_wrap {
> >> +	struct platform_device *plat_dev;
> >> +	struct pci_dev *hg_dev;
> >> +	struct resource dev_res[4];
> >> +};
> >> +
> >> +struct cdns3_wrap wrap;
> >not used in fact?
> 
> Yes, I forgot to remove it.  
> >
> >> +
> >> +#define RES_IRQ_ID		0
> >> +#define RES_HOST_ID		1
> >> +#define RES_DEV_ID		2
> >> +#define RES_DRD_ID		3
> >> +
> >> +#define PCI_BAR_HOST		0
> >> +#define PCI_BAR_DEV		2
> >> +#define PCI_BAR_OTG		4
> >> +
> >> +#define PCI_DEV_FN_HOST_DEVICE	0
> >> +#define PCI_DEV_FN_OTG		1
> >> +
> >> +#define PCI_DRIVER_NAME		"cdns3-pci-usbss"
> >> +#define PLAT_DRIVER_NAME	"cdns-usb3"
> >> +
> >> +#define CDNS_VENDOR_ID 0x17cd
> >> +#define CDNS_DEVICE_ID 0x0100
> >> +
> >> +/**
> >> + * cdns3_pci_probe - Probe function for Cadence USB wrapper driver
> >> + * @pdev: platform device object
> >> + * @id: pci device id
> >> + *
> >> + * Returns 0 on success otherwise negative errno
> >> + */
> >> +static int cdns3_pci_probe(struct pci_dev *pdev,
> >> +			   const struct pci_device_id *id)
> >> +{
> >> +	struct platform_device_info plat_info;
> >> +	struct cdns3_wrap *wrap;
> >> +	struct resource *res;
> >> +	int err;
> >> +
> >> +	/*
> >> +	 * for GADGET/HOST PCI (devfn) function number is 0,
> >> +	 * for OTG PCI (devfn) function number is 1
> >> +	 */
> >> +	if (!id || pdev->devfn != PCI_DEV_FN_HOST_DEVICE)
> >> +		return -EINVAL;
> >> +
> >> +	err = pcim_enable_device(pdev);
> >> +	if (err) {
> >> +		dev_err(&pdev->dev, "Enabling PCI device has failed %d\n", err);
> >> +		return err;
> >> +	}
> >> +
> >> +	pci_set_master(pdev);
> >> +	wrap = devm_kzalloc(&pdev->dev, sizeof(*wrap), GFP_KERNEL);
> >> +	if (!wrap) {
> >> +		dev_err(&pdev->dev, "Failed to allocate memory\n");
> >> +		return -ENOMEM;
> >> +	}
> >> +
> >> +	/* function 0: host(BAR_0) + device(BAR_1) + otg(BAR_2)). */
> >> +	memset(wrap->dev_res, 0x00,
> >> +	       sizeof(struct resource) * ARRAY_SIZE(wrap->dev_res));
> >Mabye not necessary, devm_kzalloc() already set them as 0;
> 
> Yes, it's not necessary. 
> >
> >> +	dev_dbg(&pdev->dev, "Initialize Device resources\n");
> >> +	res = wrap->dev_res;
> >> +
> >> +	res[RES_DEV_ID].start = pci_resource_start(pdev, PCI_BAR_DEV);
> >> +	res[RES_DEV_ID].end =   pci_resource_end(pdev, PCI_BAR_DEV);
> >> +	res[RES_DEV_ID].name = "dev";
> >> +	res[RES_DEV_ID].flags = IORESOURCE_MEM;
> >> +	dev_dbg(&pdev->dev, "USBSS-DEV physical base addr: %pa\n",
> >> +		&res[RES_DEV_ID].start);
> >> +
> >> +	res[RES_HOST_ID].start = pci_resource_start(pdev, PCI_BAR_HOST);
> >> +	res[RES_HOST_ID].end = pci_resource_end(pdev, PCI_BAR_HOST);
> >> +	res[RES_HOST_ID].name = "xhci";
> >> +	res[RES_HOST_ID].flags = IORESOURCE_MEM;
> >> +	dev_dbg(&pdev->dev, "USBSS-XHCI physical base addr: %pa\n",
> >> +		&res[RES_HOST_ID].start);
> >> +
> >> +	res[RES_DRD_ID].start = pci_resource_start(pdev, PCI_BAR_OTG);
> >> +	res[RES_DRD_ID].end =   pci_resource_end(pdev, PCI_BAR_OTG);
> >> +	res[RES_DRD_ID].name = "otg";
> >> +	res[RES_DRD_ID].flags = IORESOURCE_MEM;
> >> +	dev_dbg(&pdev->dev, "USBSS-DRD physical base addr: %pa\n",
> >> +		&res[RES_DRD_ID].start);
> >> +
> >> +	/* Interrupt common for both device and XHCI */
> >> +	wrap->dev_res[RES_IRQ_ID].start = pdev->irq;
> >> +	wrap->dev_res[RES_IRQ_ID].name = "cdns3-irq";
> >> +	wrap->dev_res[RES_IRQ_ID].flags = IORESOURCE_IRQ;
> >> +
> >> +	/* set up platform device info */
> >> +	memset(&plat_info, 0, sizeof(plat_info));
> >> +	plat_info.parent = &pdev->dev;
> >> +	plat_info.fwnode = pdev->dev.fwnode;
> >> +	plat_info.name = PLAT_DRIVER_NAME;
> >> +	plat_info.id = pdev->devfn;
> >> +	plat_info.res = wrap->dev_res;
> >> +	plat_info.num_res = ARRAY_SIZE(wrap->dev_res);
> >> +	plat_info.dma_mask = pdev->dma_mask;
> >> +
> >> +	/* register platform device */
> >> +	wrap->plat_dev = platform_device_register_full(&plat_info);
> >> +	if (IS_ERR(wrap->plat_dev))
> >> +		return PTR_ERR(wrap->plat_dev);
> >> +
> >> +	pci_set_drvdata(pdev, wrap);
> >> +
> >> +	return err;
> >> +}
> >> +
> >> +void cdns3_pci_remove(struct pci_dev *pdev)
> >> +{
> >> +	struct cdns3_wrap *wrap = (struct cdns3_wrap *)pci_get_drvdata(pdev);
> >> +
> >> +	platform_device_unregister(wrap->plat_dev);
> >> +}
> >> +
> >> +static const struct pci_device_id cdns3_pci_ids[] = {
> >> +	{ PCI_DEVICE(CDNS_VENDOR_ID, CDNS_DEVICE_ID), },
> >> +	{ 0, }
> >> +};
> >> +
> >> +static struct pci_driver cdns3_pci_driver = {
> >> +	.name = PCI_DRIVER_NAME,
> >> +	.id_table = cdns3_pci_ids,
> >> +	.probe = cdns3_pci_probe,
> >> +	.remove = cdns3_pci_remove,
> >> +};
> >> +
> >> +module_pci_driver(cdns3_pci_driver);
> >> +MODULE_DEVICE_TABLE(pci, cdns3_pci_ids);
> >> +
> >> +MODULE_AUTHOR("Pawel Laszczak <pawell@cadence.com>");
> >> +MODULE_LICENSE("GPL v2");
> >> +MODULE_DESCRIPTION("Cadence USBSS PCI wrapperr");
> >> +
> >> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> >> new file mode 100644
> >> index 000000000000..aa2f63241dab
> >> --- /dev/null
> >> +++ b/drivers/usb/cdns3/core.c
> >> @@ -0,0 +1,403 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Cadence USBSS DRD Driver.
> >> + *
> >> + * Copyright (C) 2018 Cadence.
> >> + * Copyright (C) 2017-2018 NXP
> >> + *
> >> + * Author: Peter Chen <peter.chen@nxp.com>
> >> + *         Pawel Laszczak <pawell@cadence.com>
> >> + */
> >> +
> >> +#include <linux/module.h>
> >> +#include <linux/kernel.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/interrupt.h>
> >> +#include <linux/io.h>
> >> +#include <linux/pm_runtime.h>
> >> +
> >> +#include "gadget.h"
> >> +#include "core.h"
> >> +#include "host-export.h"
> >> +#include "gadget-export.h"
> >> +#include "drd.h"
> >> +#include "debug.h"
> >> +
> >> +static inline
> >> +struct cdns3_role_driver *cdns3_get_current_role_driver(struct cdns3 *cdns)
> >> +{
> >> +	WARN_ON(cdns->role >= CDNS3_ROLE_END || !cdns->roles[cdns->role]);
> >> +	return cdns->roles[cdns->role];
> >> +}
> >> +
> >> +static int cdns3_role_start(struct cdns3 *cdns, enum cdns3_roles role)
> >> +{
> >> +	int ret;
> >> +
> >> +	if (WARN_ON(role >= CDNS3_ROLE_END))
> >> +		return 0;
> >> +
> >> +	if (!cdns->roles[role])
> >> +		return -ENXIO;
> >> +
> >> +	if (cdns->roles[role]->state == CDNS3_ROLE_STATE_ACTIVE)
> >> +		return 0;
> >> +
> >> +	mutex_lock(&cdns->mutex);
> >> +	cdns->role = role;
> >> +	ret = cdns->roles[role]->start(cdns);
> >> +	if (!ret)
> >> +		cdns->roles[role]->state = CDNS3_ROLE_STATE_ACTIVE;
> >> +	mutex_unlock(&cdns->mutex);
> >> +	return ret;
> >> +}
> >> +
> >> +void cdns3_role_stop(struct cdns3 *cdns)
> >> +{
> >> +	enum cdns3_roles role = cdns->role;
> >> +
> >> +	if (role >= CDNS3_ROLE_END) {
> >> +		WARN_ON(role > CDNS3_ROLE_END);
> >> +		return;
> >> +	}
> >> +
> >> +	if (cdns->roles[role]->state == CDNS3_ROLE_STATE_INACTIVE)
> >> +		return;
> >> +
> >> +	mutex_lock(&cdns->mutex);
> >> +	cdns->roles[role]->stop(cdns);
> >> +	cdns->roles[role]->state = CDNS3_ROLE_STATE_INACTIVE;
> >> +	mutex_unlock(&cdns->mutex);
> >> +}
> >> +
> >> +/*
[...]
> >> +/**
> >> + * cdsn3_get_real_role - get real role of controller based on hardware settings.
> >> + * @cdns: Pointer to cdns3 structure
> >> + *
> >> + * Returns role
> >> + */
> >> +enum cdns3_roles cdsn3_get_real_role(struct cdns3 *cdns)
> >> +{
> >> +	enum cdns3_roles role = CDNS3_ROLE_END;
> >> +
> >> +	if (cdns->current_dr_mode == USB_DR_MODE_OTG) {
> >> +		if (cdns3_get_id(cdns))
> >> +			role = CDNS3_ROLE_GADGET;
> >> +		else
> >> +			role = CDNS3_ROLE_HOST;
> >> +	} else {
> >> +		if (cdns3_is_host(cdns))
> >> +			role = CDNS3_ROLE_HOST;
> >> +		if (cdns3_is_device(cdns))
> >> +			role = CDNS3_ROLE_GADGET;
> >> +	}
> >> +
> >> +	return role;
> >> +}
> >> +
> >> +/**
> >> + * cdns3_role_switch - work queue handler for role switch
> >> + *
> >> + * @work: work queue item structure
> >> + *
> >> + * Handles below events:
> >> + * - Role switch for dual-role devices
> >> + * - CDNS3_ROLE_GADGET <--> CDNS3_ROLE_END for peripheral-only devices
> >> + */
> >> +static void cdns3_role_switch(struct work_struct *work)
> >> +{
> >> +	enum cdns3_roles role = CDNS3_ROLE_END;
> >> +	struct cdns3_role_driver *role_drv;
> >> +	enum cdns3_roles current_role;
> >> +	struct cdns3 *cdns;
> >> +	int ret = 0;
> >> +
> >> +	cdns = container_of(work, struct cdns3, role_switch_wq);
> >> +
> >> +	/* During switching cdns->role can be different then role */
> >> +	role = cdsn3_get_real_role(cdns);
> >> +
> >> +	role_drv = cdns3_get_current_role_driver(cdns);
> >> +
> >> +	pm_runtime_get_sync(cdns->dev);
> >> +
> >> +	/* Disable current role. This state can be forced from user space. */
> >> +	if (cdns->debug_disable && role_drv->state == CDNS3_ROLE_STATE_ACTIVE) {
> >> +		cdns3_role_stop(cdns);
> >> +		goto exit;
> >> +	}
> >> +
> >> +	/* Do nothing if nothing changed */
> >> +	if (cdns->role == role && role_drv->state == CDNS3_ROLE_STATE_ACTIVE)
> >> +		goto exit;
> >> +
> >> +	cdns3_role_stop(cdns);
> >> +
> >> +	role = cdsn3_get_real_role(cdns);
> >> +
> >> +	current_role = cdns->role;
> >> +	dev_dbg(cdns->dev, "Switching role");
> >> +
> >> +	ret = cdns3_role_start(cdns, role);
> >> +	if (ret) {
> >> +		/* Back to current role */
> >> +		dev_err(cdns->dev, "set %d has failed, back to %d\n",
> >> +			role, current_role);
> >> +		cdns3_role_start(cdns, current_role);
> >> +	}
> >> +exit:
> >> +	pm_runtime_put_sync(cdns->dev);
> >> +}
> >> +
> >> +/**
> >> + * cdns3_probe - probe for cdns3 core device
> >> + * @pdev: Pointer to cdns3 core platform device
> >> + *
> >> + * Returns 0 on success otherwise negative errno
> >> + */
> >> +static int cdns3_probe(struct platform_device *pdev)
> >> +{
> >> +	struct device *dev = &pdev->dev;
> >> +	struct resource	*res;
> >> +	struct cdns3 *cdns;
> >> +	void __iomem *regs;
> >> +	int ret;
> >> +
> >> +	cdns = devm_kzalloc(dev, sizeof(*cdns), GFP_KERNEL);
> >> +	if (!cdns)
> >> +		return -ENOMEM;
> >> +
> >> +	cdns->dev = dev;
> >> +
> >> +	platform_set_drvdata(pdev, cdns);
> >> +
> >> +	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> >> +	if (!res) {
> >> +		dev_err(dev, "missing IRQ\n");
> >> +		return -ENODEV;
> >> +	}
> >> +	cdns->irq = res->start;
> >> +
> >> +	cdns->xhci_res[0] = *res;
> >> +
> >> +	/*
> >> +	 * Request memory region
> >> +	 * region-0: xHCI
> >> +	 * region-1: Peripheral
> >> +	 * region-2: OTG registers
> >> +	 */
> >the comment should be modified or removed if not necessary when codes
> >changed.
> 
> Yes, now it's not necessary. 
> 
> >> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "xhci");
> >> +	if (!res)
> >> +		return -ENXIO;
> >> +
> >> +	cdns->xhci_res[1] = *res;
> >> +
> >> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dev");
> >> +	regs = devm_ioremap_resource(dev, res);
> >> +	if (IS_ERR(regs))
> >> +		return PTR_ERR(regs);
> >> +	cdns->dev_regs	= regs;
> >> +
> >> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "otg");
> >> +	if (!res)
> >> +		return -ENXIO;
> >> +
> >> +	cdns->otg_res = *res;
> >> +
> >> +	mutex_init(&cdns->mutex);
> >> +
> >> +	cdns->phy = devm_phy_optional_get(dev, "cdns3,usbphy");
> >> +	if (IS_ERR(cdns->phy))
> >> +		return PTR_ERR(cdns->phy);
> >> +
> >> +	phy_init(cdns->phy);
> >check the return value? and
> >It's better to call phy_power_on() here even if the phy driver doesn't
> >provide power_on()
> 
> Driver doesn't need to check return value in this case. It was discussed some time ago. 
Ok, I missed out something

> 
> >
> >> +
> >> +	INIT_WORK(&cdns->role_switch_wq, cdns3_role_switch);
> >> +
> >> +	ret = cdns3_drd_init(cdns);
> >> +	if (ret)
> >> +		goto err;
> >> +
> >> +	ret = cdns3_core_init_role(cdns);
> >> +	if (ret)
> >> +		goto err;
> >> +
> >> +	cdns3_debugfs_init(cdns);
> >> +	device_set_wakeup_capable(dev, true);
> >> +	pm_runtime_set_active(dev);
> >> +	pm_runtime_enable(dev);
> >> +
> >> +	/*
> >> +	 * The controller needs less time between bus and controller suspend,
> >> +	 * and we also needs a small delay to avoid frequently entering low
> >> +	 * power mode.
> >> +	 */
> >> +	pm_runtime_set_autosuspend_delay(dev, 20);
> >> +	pm_runtime_mark_last_busy(dev);
> >> +	pm_runtime_use_autosuspend(dev);
> >> +	dev_dbg(dev, "Cadence USB3 core: probe succeed\n");
> >> +
> >> +	return 0;
> >> +
> >> +err:
> >> +	phy_exit(cdns->phy);
> >> +	return ret;
> >> +}
> >> +
> >> +/**
> >> + * cdns3_remove - unbind drd driver and clean up
> >> + * @pdev: Pointer to Linux platform device
> >> + *
> >> + * Returns 0 on success otherwise negative errno
> >> + */
> >> +static int cdns3_remove(struct platform_device *pdev)
> >> +{
> >> +	struct cdns3 *cdns = platform_get_drvdata(pdev);
> >> +
> >> +	pm_runtime_get_sync(&pdev->dev);
> >> +	pm_runtime_disable(&pdev->dev);
> >> +	pm_runtime_put_noidle(&pdev->dev);
> >> +	cdns3_debugfs_exit(cdns);
> >> +	cdns3_exit_roles(cdns);
> >> +	phy_exit(cdns->phy);
> >> +	return 0;
> >> +}
> >> +
> >> +#ifdef CONFIG_OF
> >> +static const struct of_device_id of_cdns3_match[] = {
> >> +	{ .compatible = "cdns,usb3-1.0.0" },
> >> +	{ .compatible = "cdns,usb3-1.0.1" },
> >> +	{ },
> >> +};
> >> +MODULE_DEVICE_TABLE(of, of_cdns3_match);
> >> +#endif
> >> +
> >> +static struct platform_driver cdns3_driver = {
> >> +	.probe		= cdns3_probe,
> >> +	.remove		= cdns3_remove,
> >> +	.driver		= {
> >> +		.name	= "cdns-usb3",
> >> +		.of_match_table	= of_match_ptr(of_cdns3_match),
> >> +	},
> >> +};
> >> +
> >> +module_platform_driver(cdns3_driver);
> >> +
> >> +MODULE_ALIAS("platform:cdns3");
> >> +MODULE_AUTHOR("Pawel Laszczak <pawell@cadence.com>");
> >> +MODULE_LICENSE("GPL v2");
> >> +MODULE_DESCRIPTION("Cadence USB3 DRD Controller Driver");
> >> diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
> >> new file mode 100644
> >> index 000000000000..fb4b39206158
> >> --- /dev/null
> >> +++ b/drivers/usb/cdns3/core.h
> >> @@ -0,0 +1,116 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +/*
> >> + * Cadence USBSS DRD Header File.
> >> + *
> >> + * Copyright (C) 2017-2018 NXP
> >> + * Copyright (C) 2018 Cadence.
> >> + *
> >> + * Authors: Peter Chen <peter.chen@nxp.com>
> >> + *          Pawel Laszczak <pawell@cadence.com>
> >> + */
> >> +#include <linux/usb/otg.h>
> >> +
> >> +#ifndef __LINUX_CDNS3_CORE_H
> >> +#define __LINUX_CDNS3_CORE_H
> >> +
> >> +struct cdns3;
> >> +enum cdns3_roles {
> >> +	CDNS3_ROLE_HOST = 0,
> >> +	CDNS3_ROLE_GADGET,
> >> +	CDNS3_ROLE_END,
> >> +};
> >> +
> >> +/**
> >> + * struct cdns3_role_driver - host/gadget role driver
> >> + * @start: start this role
> >> + * @stop: stop this role
> >> + * @suspend: suspend callback for this role
> >> + * @resume: resume callback for this role
> >> + * @irq: irq handler for this role
> >no irq member,
> >> + * @name: role name string (host/gadget)
> >> + * @state: current state
> >> + */
> >> +struct cdns3_role_driver {
> >> +	int (*start)(struct cdns3 *cdns);
> >> +	void (*stop)(struct cdns3 *cdns);
> >> +	int (*suspend)(struct cdns3 *cdns, bool do_wakeup);
> >> +	int (*resume)(struct cdns3 *cdns, bool hibernated);
> >> +	const char *name;
> >> +#define CDNS3_ROLE_STATE_INACTIVE	0
> >> +#define CDNS3_ROLE_STATE_ACTIVE		1
> >> +	int state;
> >> +};
> >> +
> >> +#define CDNS3_XHCI_RESOURCES_NUM	2
> >> +/**
> >> + * struct cdns3 - Representation of Cadence USB3 DRD controller.
> >> + * @dev: pointer to Cadence device struct
> >> + * @xhci_regs: pointer to base of xhci registers
> >> + * @xhci_res: the resource for xhci
> >> + * @dev_regs: pointer to base of dev registers
> >> + * @otg_regs: pointer to base of otg registers
> >not pointer
> 
> Why ? 
> struct cdns3_otg_common_regs	*otg_regs;
Sorry, I may see otg_res as otg_regs

> 
> But I forgot:
>  * @otg_res: the resource for otg
>  * @otg_v0_regs: pointer to base of v0 otg registers
>  * @otg_v1_regs: pointer to base of v1 otg registers
> 
> >> + * @irq: irq number for controller
> >> + * @roles: array of supported roles for this controller
> >> + * @role: current role
> >> + * @host_dev: the child host device pointer for cdns3 core
> >> + * @gadget_dev: the child gadget device pointer for cdns3 core
> >> + * @usb: phy for this controller
> >> + * @role_switch_wq: work queue item for role switch
> >> + * @in_lpm: the controller in low power mode
> >> + * @wakeup_int: the wakeup interrupt
> >> + * @mutex: the mutex for concurrent code at driver
> >> + * @dr_mode: supported mode of operation it can be only Host, only Device
> >> + *           or OTG mode that allow to switch between Device and Host mode.
> >> + *           This field based on firmware setting, kernel configuration
> >> + *           and hardware configuration.
> >> + * @current_dr_mode: current mode of operation when in dual-role mode
> >> + * @desired_dr_mode: desired mode of operation when in dual-role mode.
> >> + *           This value can be changed during runtime.
> >> + *           Available options depends on  dr_mode:
> >> + *           dr_mode                 |  desired_dr_mode and current_dr_mode
> >> + *           ----------------------------------------------------------------
> >> + *           USB_DR_MODE_HOST        | only USB_DR_MODE_HOST
> >> + *           USB_DR_MODE_PERIPHERAL  | only USB_DR_MODE_PERIPHERAL
> >> + *           USB_DR_MODE_OTG         | only USB_DR_MODE_HOST
> >> + *           USB_DR_MODE_OTG         | only USB_DR_MODE_PERIPHERAL
> >> + *           USB_DR_MODE_OTG         | USB_DR_MODE_OTG
> >> + *
> >> + *           Desired_dr_role can be changed by means of debugfs.
> >> + * @root: debugfs root folder pointer
> >> + * @debug_disable:
> >> + */
> >> +struct cdns3 {
> >> +	struct device			*dev;
> >> +	void __iomem			*xhci_regs;
> >> +	struct resource			xhci_res[CDNS3_XHCI_RESOURCES_NUM];
> >> +	struct cdns3_usb_regs __iomem	*dev_regs;
> >> +
> >> +	struct resource			otg_res;
> >> +	struct cdns3_otg_legacy_regs	*otg_v0_regs;
> >> +	struct cdns3_otg_regs		*otg_v1_regs;
> >> +	struct cdns3_otg_common_regs	*otg_regs;
> >> +#define CDNS3_CONTROLLER_V0	0
> >> +#define CDNS3_CONTROLLER_V1	1
> >> +	u32				version;
> >> +
> >> +	int				irq;
> >> +	struct cdns3_role_driver	*roles[CDNS3_ROLE_END];
> >> +	enum cdns3_roles		role;
> >> +	struct platform_device		*host_dev;
> >> +	struct cdns3_device		*gadget_dev;
> >> +	struct phy			*phy;
> >Does the single phy support both HS and SS?
> >> +	struct work_struct		role_switch_wq;
> >> +	int				in_lpm:1;
> >> +	int				wakeup_int:1;
> >> +	/* mutext used in workqueue*/
> >> +	struct mutex			mutex;
> >> +	enum usb_dr_mode		dr_mode;
> >> +	enum usb_dr_mode		current_dr_mode;
> >> +	enum usb_dr_mode		desired_dr_mode;
> >> +	struct dentry			*root;
> >> +	int				debug_disable:1;
> >> +};
> >> +

> [...]

> >
> Thanks, 
> Pawel


