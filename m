Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F72C433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 11:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84CAD2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 11:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LiCtSgpZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730994AbfHOLWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 07:22:46 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:39382 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729157AbfHOLWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 07:22:46 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7FBMd3f026074;
        Thu, 15 Aug 2019 06:22:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565868159;
        bh=wzHnUwzXaOeCSlGq80jahlM4LbU87kzZO/P428SlrFM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=LiCtSgpZjquP5Y2i98qI4chWz1ke/xFGSGXm1h9WJJ/q6Myj4gz8fRmfy2JI3IaAi
         GiFKW6nmlX9cfEek6da/dKyzwbZYkPGUvHGdremlr5SMF2sysqGniwU/hJWwK9HPgo
         dKNyFToxo9kbLGTzbgGU4RTnm2Mp/kMLyafKxQSo=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7FBMdde040521
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Aug 2019 06:22:39 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 15
 Aug 2019 06:22:38 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 15 Aug 2019 06:22:38 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7FBMZlO022664;
        Thu, 15 Aug 2019 06:22:36 -0500
Subject: Re: [PATCH v10 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
To:     Pawel Laszczak <pawell@cadence.com>, <felipe.balbi@linux.intel.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jbergsagel@ti.com>,
        <nsekhar@ti.com>, <nm@ti.com>, <sureshp@cadence.com>,
        <jpawar@cadence.com>, <kurahul@cadence.com>, <aniljoy@cadence.com>
References: <1563733939-21214-1-git-send-email-pawell@cadence.com>
 <1563733939-21214-6-git-send-email-pawell@cadence.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <61a14c20-c02c-776c-6ce1-3dd5d6abac8e@ti.com>
Date:   Thu, 15 Aug 2019 14:22:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1563733939-21214-6-git-send-email-pawell@cadence.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pawel,

On 21/07/2019 21:32, Pawel Laszczak wrote:
> This patch introduce new Cadence USBSS DRD driver to Linux kernel.
> 
> The Cadence USBSS DRD Controller is a highly configurable IP Core which
> can be instantiated as Dual-Role Device (DRD), Peripheral Only and
> Host Only (XHCI)configurations.
> 
> The current driver has been validated with FPGA platform. We have
> support for PCIe bus, which is used on FPGA prototyping.
> 
> The host side of USBSS-DRD controller is compliant with XHCI
> specification, so it works with standard XHCI Linux driver.
> 
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/Kconfig                |    2 +
>  drivers/usb/Makefile               |    2 +
>  drivers/usb/cdns3/Kconfig          |   46 +
>  drivers/usb/cdns3/Makefile         |   17 +
>  drivers/usb/cdns3/cdns3-pci-wrap.c |  203 +++
>  drivers/usb/cdns3/core.c           |  554 +++++++
>  drivers/usb/cdns3/core.h           |  109 ++
>  drivers/usb/cdns3/debug.h          |  171 ++
>  drivers/usb/cdns3/debugfs.c        |   87 ++
>  drivers/usb/cdns3/drd.c            |  390 +++++
>  drivers/usb/cdns3/drd.h            |  166 ++
>  drivers/usb/cdns3/ep0.c            |  914 +++++++++++
>  drivers/usb/cdns3/gadget-export.h  |   28 +
>  drivers/usb/cdns3/gadget.c         | 2338 ++++++++++++++++++++++++++++
>  drivers/usb/cdns3/gadget.h         | 1321 ++++++++++++++++
>  drivers/usb/cdns3/host-export.h    |   28 +
>  drivers/usb/cdns3/host.c           |   71 +
>  drivers/usb/cdns3/trace.c          |   11 +
>  drivers/usb/cdns3/trace.h          |  493 ++++++
>  19 files changed, 6951 insertions(+)
>  create mode 100644 drivers/usb/cdns3/Kconfig
>  create mode 100644 drivers/usb/cdns3/Makefile
>  create mode 100644 drivers/usb/cdns3/cdns3-pci-wrap.c
>  create mode 100644 drivers/usb/cdns3/core.c
>  create mode 100644 drivers/usb/cdns3/core.h
>  create mode 100644 drivers/usb/cdns3/debug.h
>  create mode 100644 drivers/usb/cdns3/debugfs.c
>  create mode 100644 drivers/usb/cdns3/drd.c
>  create mode 100644 drivers/usb/cdns3/drd.h
>  create mode 100644 drivers/usb/cdns3/ep0.c
>  create mode 100644 drivers/usb/cdns3/gadget-export.h
>  create mode 100644 drivers/usb/cdns3/gadget.c
>  create mode 100644 drivers/usb/cdns3/gadget.h
>  create mode 100644 drivers/usb/cdns3/host-export.h
>  create mode 100644 drivers/usb/cdns3/host.c
>  create mode 100644 drivers/usb/cdns3/trace.c
>  create mode 100644 drivers/usb/cdns3/trace.h
> 

<snip>

> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> new file mode 100644
> index 000000000000..900b2ce08162
> --- /dev/null
> +++ b/drivers/usb/cdns3/core.c
> @@ -0,0 +1,554 @@
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
> +static inline
> +struct cdns3_role_driver *cdns3_get_current_role_driver(struct cdns3 *cdns)
> +{
> +	WARN_ON(!cdns->roles[cdns->role]);
> +	return cdns->roles[cdns->role];
> +}
> +
> +static int cdns3_role_start(struct cdns3 *cdns, enum usb_role role)
> +{
> +	int ret;
> +
> +	if (WARN_ON(role > USB_ROLE_DEVICE))
> +		return 0;
> +
> +	mutex_lock(&cdns->mutex);
> +	cdns->role = role;
> +	mutex_unlock(&cdns->mutex);
> +
> +	if (role == USB_ROLE_NONE)
> +		return 0;

We will need to have a role driver for NONE case so we can deal with
type-C cable swap case. I will post a patch at the end about this.
You can squash the patches and use them in the next revision.

> +
> +	if (!cdns->roles[role])
> +		return -ENXIO;
> +
> +	if (cdns->roles[role]->state == CDNS3_ROLE_STATE_ACTIVE)
> +		return 0;
> +
> +	mutex_lock(&cdns->mutex);
> +	if (role == USB_ROLE_HOST)
> +		cdns3_drd_switch_host(cdns, 1);
> +	else
> +		cdns3_drd_switch_gadget(cdns, 1);

Please don't do this here. You can call them from the respective role
drivers at the start. i.e. __cdns3_host_init(), __cdns3_gadget_init()
> +
> +	ret = cdns->roles[role]->start(cdns);
> +	if (!ret)
> +		cdns->roles[role]->state = CDNS3_ROLE_STATE_ACTIVE;
> +	mutex_unlock(&cdns->mutex);
> +
> +	return ret;
> +}
> +
> +static void cdns3_role_stop(struct cdns3 *cdns)
> +{
> +	enum usb_role role = cdns->role;
> +
> +	if (WARN_ON(role > USB_ROLE_DEVICE))
> +		return;
> +
> +	if (role == USB_ROLE_NONE)
> +		return;
> +
> +	if (cdns->roles[role]->state == CDNS3_ROLE_STATE_INACTIVE)
> +		return;
> +
> +	mutex_lock(&cdns->mutex);
> +	cdns->roles[role]->stop(cdns);
> +	if (role == USB_ROLE_HOST)
> +		cdns3_drd_switch_host(cdns, 0);
> +	else
> +		cdns3_drd_switch_gadget(cdns, 0);

No need to do this here. They can be done at the respective role
drivers at the end. i.e. cdns3_host_exit(), cdns3_gadget_exit()

> +
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
> +enum usb_role cdsn3_real_role_switch_get(struct device *dev);
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
> +	cdns->role = USB_ROLE_NONE;
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
> +	cdns->role = cdsn3_real_role_switch_get(cdns->dev);
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
> + * cdsn3_real_role_switch_get - get real role of controller based on hardware
> + *   settings.
> + * @dev: Pointer to device structure
> + *
> + * Returns role
> + */
> +enum usb_role cdsn3_real_role_switch_get(struct device *dev)

let's not mix user space role_switch and HW based role swith.

This function is really the HW based state machine. Let's rename it to

 * cdsn3_hw_role_state_machine - role switch state machine based on hw events
 *
 * @cdns: Pointer to controller structure
 *
 * Returns next role to be entered based on hw events.
 */
static enum usb_role cdsn3_hw_role_state_machine(struct cdns3 *cdns)

> +{
> +	struct cdns3 *cdns = dev_get_drvdata(dev);
> +	enum usb_role role;
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
> +	case USB_ROLE_NONE:
> +		/*
> +		 * Driver treat USB_ROLE_NONE synonymous to IDLE state from

s/treat/treats

> +		 * controller specification.
> +		 */
> +		if (!id)
> +			role = USB_ROLE_HOST;
> +		else if (vbus)
> +			role = USB_ROLE_DEVICE;
> +		break;
> +	case USB_ROLE_HOST: /* from HOST, we can only change to NONE */
> +		if (id)
> +			role = USB_ROLE_NONE;
> +		break;
> +	case USB_ROLE_DEVICE: /* from GADGET, we can only change to NONE*/
> +		if (!vbus)
> +			role = USB_ROLE_NONE;
> +		break;
> +	}
> +
> +	dev_dbg(cdns->dev, "role %d -> %d\n", cdns->role, role);
> +
> +	return role;
> +
> +not_otg:
> +	if (cdns3_is_host(cdns))
> +		role = USB_ROLE_HOST;
> +	if (cdns3_is_device(cdns))
> +		role = USB_ROLE_DEVICE;
> +
> +	return role;
> +}
> +
> +/**
> + * cdns3_role_switch_set - work queue handler for role switch
> + *
> + * @dev: pointer to device object
> + * @role - the previous role
> + * Handles below events:
> + * - Role switch for dual-role devices
> + * - USB_ROLE_GADGET <--> USB_ROLE_NONE for peripheral-only devices
> + */
> +static int cdns3_role_switch_set(struct device *dev, enum usb_role role)

Let's not use this for user space role switch but just for HW based switching
How about calling it

int cdns3_hw_role_switch(struct cdns3 *cdns)

> +{
> +	struct cdns3 *cdns = dev_get_drvdata(dev);
> +	enum usb_role real_role = USB_ROLE_NONE;
> +	enum usb_role current_role;

enum usb_role real_role, current_role;

> +	int ret = 0;
> +
> +	/* Check if dr_mode was changed.*/
> +	ret = cdns3_drd_update_mode(cdns);

Why is this check required? Who is going to change dr_mode?

> +	if (ret)
> +		return ret;

I think here we need to check if user overrides the role
using role switch sysfs. If yes then we ned ignore HW events
and just return here.

> +
> +	pm_runtime_get_sync(cdns->dev);
> +
> +	real_role = cdsn3_real_role_switch_get(cdns->dev);

       current_role = cdns->role;
       real_role = cdsn3_hw_role_state_machine(cdns);

> +
> +	/* Do nothing if nothing changed */
> +	if (cdns->role == real_role)

	if (current_role == real_role)

> +		goto exit;
> +
> +	cdns3_role_stop(cdns);
> +
> +	real_role = cdsn3_real_role_switch_get(cdns->dev);
> +
> +	current_role = role;

Remove above 2 lines. Don't need to get real role again
here as it will break the state machine.
If HW state changes, we will deal with it in next interrupt
not here.

> +	dev_dbg(cdns->dev, "Switching role");

	dev_dbg(cdns->dev, "Switching role %d -> %d", current_role, real_role);

> +
> +	ret = cdns3_role_start(cdns, real_role);
> +	if (ret) {
> +		/* Back to current role */
> +		dev_err(cdns->dev, "set %d has failed, back to %d\n",
> +			role, current_role);

			real_role, current_role

> +		ret = cdns3_role_start(cdns, current_role);
> +		if (ret)
> +			dev_err(cdns->dev, "back to %d failed too\n",
> +				current_role);
> +	}
> +exit:
> +	pm_runtime_put_sync(cdns->dev);
> +	return ret;
> +}

How about the below 2 functions for user space role switch handling.

+/**
+ * cdsn3_role_get - get current role of controller.
+ *
+ * @dev: Pointer to device structure
+ *
+ * Returns role
+ */
+static enum usb_role cdns3_role_get(struct device *dev)
+{
+       struct cdns3 *cdns = dev_get_drvdata(dev);
+
+       return cdns->role;
+}
+
+/**
+ * cdns3_role_set - set current role of controller.
+ *
+ * @dev: pointer to device object
+ * @role - the previous role
+ * Handles below events:
+ * - Role switch for dual-role devices
+ * - USB_ROLE_GADGET <--> USB_ROLE_NONE for peripheral-only devices
+ */
+static int cdns3_role_set(struct device *dev, enum usb_role role)
+{
+       /* FIXME: doing nothing for now */

Here we need to implement the user space switching logic.

1) If called change to desired role and set a userspace override flag
2) How do we clear the userspace override flag so HW based switching can
continue? Need new API hook in struct usb_role_switch_desc?

+       return -EPERM;
+}
+

> +
> +static const struct usb_role_switch_desc cdns3_switch_desc = {
> +	.set = cdns3_role_switch_set,
> +	.get = cdsn3_real_role_switch_get,

       .set = cdns3_role_set,
       .get = cdns3_role_get,

> +	.allow_userspace_control = true,
> +};
> +

<snip>

> diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
> new file mode 100644
> index 000000000000..77f8a1516140
> --- /dev/null
> +++ b/drivers/usb/cdns3/drd.c
> @@ -0,0 +1,390 @@
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
> +#include <linux/iopoll.h>
> +#include <linux/usb/otg.h>
> +
> +#include "gadget.h"
> +#include "drd.h"
> +#include "core.h"
> +

<snip>

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
> +static irqreturn_t cdns3_drd_thread_irq(int irq, void *data)
> +{
> +	struct cdns3 *cdns = data;
> +
> +	usb_role_switch_set_role(cdns->role_sw, cdns->role);
> +
	This is HW based event. Don't mix this with user space role switch.
	So,

	cdns3_hw_role_switch(cdns);

> +	return IRQ_HANDLED;
> +}
> +

<snip>

The below 2 patches address the above comments and introduce
a IDLE role driver so we can deal with Type-C lane swap.

Please squash them into this patch, if they look OK. Thanks.

cheers,
-roger
--

From 228da29ea47d0000f2bab49377fce8f3f0e97b63 Mon Sep 17 00:00:00 2001
From: Roger Quadros <rogerq@ti.com>
Date: Thu, 15 Aug 2019 11:11:02 +0300
Subject: [PATCH 1/2] usb: cdns3: Fix hw based role switch

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/cdns3/core.c | 76 ++++++++++++++++++++++++++--------------
 drivers/usb/cdns3/core.h |  2 ++
 drivers/usb/cdns3/drd.c  |  2 +-
 3 files changed, 52 insertions(+), 28 deletions(-)

diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index b132acca60f1..07f8d8f23930 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -97,7 +97,7 @@ static void cdns3_exit_roles(struct cdns3 *cdns)
 	cdns3_drd_exit(cdns);
 }
 
-enum usb_role cdsn3_real_role_switch_get(struct device *dev);
+static enum usb_role cdsn3_hw_role_state_machine(struct cdns3 *cdns);
 
 /**
  * cdns3_core_init_role - initialize role of operation
@@ -176,7 +176,7 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
 	if (ret)
 		goto err;
 
-	cdns->role = cdsn3_real_role_switch_get(cdns->dev);
+	cdns->role = cdsn3_hw_role_state_machine(cdns);
 
 	ret = cdns3_role_start(cdns, cdns->role);
 	if (ret) {
@@ -192,15 +192,14 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
 }
 
 /**
- * cdsn3_real_role_switch_get - get real role of controller based on hardware
- *   settings.
- * @dev: Pointer to device structure
+ * cdsn3_hw_role_state_machine - role switch state machine based on hw events
  *
- * Returns role
+ * @cdns: Pointer to controller structure
+ *
+ * Returns next role to be entered based on hw events.
  */
-enum usb_role cdsn3_real_role_switch_get(struct device *dev)
+static enum usb_role cdsn3_hw_role_state_machine(struct cdns3 *cdns)
 {
-	struct cdns3 *cdns = dev_get_drvdata(dev);
 	enum usb_role role;
 	int id, vbus;
 
@@ -253,46 +252,40 @@ enum usb_role cdsn3_real_role_switch_get(struct device *dev)
 }
 
 /**
- * cdns3_role_switch_set - work queue handler for role switch
+ * cdns3_hw_role_switch - switch roles based on HW state
  *
- * @dev: pointer to device object
- * @role - the previous role
- * Handles below events:
- * - Role switch for dual-role devices
- * - USB_ROLE_GADGET <--> USB_ROLE_NONE for peripheral-only devices
+ * @cdns: controller
  */
-static int cdns3_role_switch_set(struct device *dev, enum usb_role role)
+int cdns3_hw_role_switch(struct cdns3 *cdns)
 {
-	struct cdns3 *cdns = dev_get_drvdata(dev);
-	enum usb_role real_role = USB_ROLE_NONE;
-	enum usb_role current_role;
+	enum usb_role real_role, current_role;
 	int ret = 0;
 
 	/* Check if dr_mode was changed.*/
+	/* FIXME: why do we need this call? */
 	ret = cdns3_drd_update_mode(cdns);
 	if (ret)
 		return ret;
 
+	/* FIXME: don't do anything if userspace role switch has override */
 	pm_runtime_get_sync(cdns->dev);
 
-	real_role = cdsn3_real_role_switch_get(cdns->dev);
+	current_role = cdns->role;
+	real_role = cdsn3_hw_role_state_machine(cdns);
 
 	/* Do nothing if nothing changed */
-	if (cdns->role == real_role)
+	if (current_role == real_role)
 		goto exit;
 
 	cdns3_role_stop(cdns);
 
-	real_role = cdsn3_real_role_switch_get(cdns->dev);
-
-	current_role = role;
-	dev_dbg(cdns->dev, "Switching role");
+	dev_dbg(cdns->dev, "Switching role %d -> %d", current_role, real_role);
 
 	ret = cdns3_role_start(cdns, real_role);
 	if (ret) {
 		/* Back to current role */
 		dev_err(cdns->dev, "set %d has failed, back to %d\n",
-			role, current_role);
+			real_role, current_role);
 		ret = cdns3_role_start(cdns, current_role);
 		if (ret)
 			dev_err(cdns->dev, "back to %d failed too\n",
@@ -303,9 +296,38 @@ static int cdns3_role_switch_set(struct device *dev, enum usb_role role)
 	return ret;
 }
 
+/**
+ * cdsn3_role_get - get current role of controller.
+ *
+ * @dev: Pointer to device structure
+ *
+ * Returns role
+ */
+static enum usb_role cdns3_role_get(struct device *dev)
+{
+	struct cdns3 *cdns = dev_get_drvdata(dev);
+
+	return cdns->role;
+}
+
+/**
+ * cdns3_role_set - set current role of controller.
+ *
+ * @dev: pointer to device object
+ * @role - the previous role
+ * Handles below events:
+ * - Role switch for dual-role devices
+ * - USB_ROLE_GADGET <--> USB_ROLE_NONE for peripheral-only devices
+ */
+static int cdns3_role_set(struct device *dev, enum usb_role role)
+{
+	/* FIXME: doing nothing for now */
+	return -EPERM;
+}
+
 static const struct usb_role_switch_desc cdns3_switch_desc = {
-	.set = cdns3_role_switch_set,
-	.get = cdsn3_real_role_switch_get,
+	.set = cdns3_role_set,
+	.get = cdns3_role_get,
 	.allow_userspace_control = true,
 };
 
diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
index 2a35f025b0a5..e0d23f2934bb 100644
--- a/drivers/usb/cdns3/core.h
+++ b/drivers/usb/cdns3/core.h
@@ -103,4 +103,6 @@ struct cdns3 {
 	struct usb_role_switch		*role_sw;
 };
 
+int cdns3_hw_role_switch(struct cdns3 *cdns);
+
 #endif /* __LINUX_CDNS3_CORE_H */
diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
index 77f8a1516140..780fc7d59932 100644
--- a/drivers/usb/cdns3/drd.c
+++ b/drivers/usb/cdns3/drd.c
@@ -265,7 +265,7 @@ static irqreturn_t cdns3_drd_thread_irq(int irq, void *data)
 {
 	struct cdns3 *cdns = data;
 
-	usb_role_switch_set_role(cdns->role_sw, cdns->role);
+	cdns3_hw_role_switch(cdns);
 
 	return IRQ_HANDLED;
 }


From 701277afb2c1087d327be5387b239d507f0abf6e Mon Sep 17 00:00:00 2001
From: Roger Quadros <rogerq@ti.com>
Date: Thu, 15 Aug 2019 11:39:38 +0300
Subject: [PATCH 2/2] usb: cdns3: fix type-c lane swap

We need to have a discrete IDLE state so that
we know type-C cable is disconnected.

On exting IDLE state we can program lane swap
via a PHY reset.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/cdns3/core.c   | 49 +++++++++++++++++++++++++++-----------
 drivers/usb/cdns3/gadget.c |  2 ++
 drivers/usb/cdns3/host.c   |  3 +++
 3 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index 07f8d8f23930..3c42ee347836 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -44,9 +44,6 @@ static int cdns3_role_start(struct cdns3 *cdns, enum usb_role role)
 	cdns->role = role;
 	mutex_unlock(&cdns->mutex);
 
-	if (role == USB_ROLE_NONE)
-		return 0;
-
 	if (!cdns->roles[role])
 		return -ENXIO;
 
@@ -54,10 +51,6 @@ static int cdns3_role_start(struct cdns3 *cdns, enum usb_role role)
 		return 0;
 
 	mutex_lock(&cdns->mutex);
-	if (role == USB_ROLE_HOST)
-		cdns3_drd_switch_host(cdns, 1);
-	else
-		cdns3_drd_switch_gadget(cdns, 1);
 
 	ret = cdns->roles[role]->start(cdns);
 	if (!ret)
@@ -74,18 +67,11 @@ static void cdns3_role_stop(struct cdns3 *cdns)
 	if (WARN_ON(role > USB_ROLE_DEVICE))
 		return;
 
-	if (role == USB_ROLE_NONE)
-		return;
-
 	if (cdns->roles[role]->state == CDNS3_ROLE_STATE_INACTIVE)
 		return;
 
 	mutex_lock(&cdns->mutex);
 	cdns->roles[role]->stop(cdns);
-	if (role == USB_ROLE_HOST)
-		cdns3_drd_switch_host(cdns, 0);
-	else
-		cdns3_drd_switch_gadget(cdns, 0);
 
 	cdns->roles[role]->state = CDNS3_ROLE_STATE_INACTIVE;
 	mutex_unlock(&cdns->mutex);
@@ -99,6 +85,37 @@ static void cdns3_exit_roles(struct cdns3 *cdns)
 
 static enum usb_role cdsn3_hw_role_state_machine(struct cdns3 *cdns);
 
+static int cdns3_idle_role_start(struct cdns3 *cdns)
+{
+	return 0;
+}
+
+static void cdns3_idle_role_stop(struct cdns3 *cdns)
+{
+	/* Program Lane swap and bring PHY out of RESET */
+	phy_reset(cdns->usb3_phy);
+}
+
+static int cdns3_idle_init(struct cdns3 *cdns)
+{
+	struct cdns3_role_driver *rdrv;
+
+	rdrv = devm_kzalloc(cdns->dev, sizeof(*rdrv), GFP_KERNEL);
+	if (!rdrv)
+		return -ENOMEM;
+
+	rdrv->start = cdns3_idle_role_start;
+	rdrv->stop = cdns3_idle_role_stop;
+	rdrv->state = CDNS3_ROLE_STATE_INACTIVE;
+	rdrv->suspend = NULL;
+	rdrv->resume = NULL;
+	rdrv->name = "idle";
+
+	cdns->roles[USB_ROLE_NONE] = rdrv;
+
+	return 0;
+}
+
 /**
  * cdns3_core_init_role - initialize role of operation
  * @cdns: Pointer to cdns3 structure
@@ -136,6 +153,10 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
 	 */
 	best_dr_mode = cdns->dr_mode;
 
+	ret = cdns3_idle_init(cdns);
+	if (ret)
+		return ret;
+
 	if (dr_mode == USB_DR_MODE_OTG) {
 		best_dr_mode = cdns->dr_mode;
 	} else if (cdns->dr_mode == USB_DR_MODE_OTG) {
diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index a42e832b3c6a..2ac2eba284c7 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -2475,6 +2475,7 @@ void cdns3_gadget_exit(struct cdns3 *cdns)
 	kfree(priv_dev->zlp_buf);
 	kfree(priv_dev);
 	cdns->gadget_dev = NULL;
+	cdns3_drd_switch_gadget(cdns, 0);
 }
 
 static int cdns3_gadget_start(struct cdns3 *cdns)
@@ -2594,6 +2595,7 @@ static int __cdns3_gadget_init(struct cdns3 *cdns)
 	struct cdns3_device *priv_dev;
 	int ret = 0;
 
+	cdns3_drd_switch_gadget(cdns, 1);
 	pm_runtime_get_sync(cdns->dev);
 
 	ret = cdns3_gadget_start(cdns);
diff --git a/drivers/usb/cdns3/host.c b/drivers/usb/cdns3/host.c
index a7629ab2c20c..2733a8f71fcd 100644
--- a/drivers/usb/cdns3/host.c
+++ b/drivers/usb/cdns3/host.c
@@ -18,6 +18,8 @@ static int __cdns3_host_init(struct cdns3 *cdns)
 	struct platform_device *xhci;
 	int ret;
 
+	cdns3_drd_switch_host(cdns, 1);
+
 	xhci = platform_device_alloc("xhci-hcd", PLATFORM_DEVID_AUTO);
 	if (!xhci) {
 		dev_err(cdns->dev, "couldn't allocate xHCI device\n");
@@ -50,6 +52,7 @@ static void cdns3_host_exit(struct cdns3 *cdns)
 {
 	platform_device_unregister(cdns->host_dev);
 	cdns->host_dev = NULL;
+	cdns3_drd_switch_host(cdns, 0);
 }
 
 int cdns3_host_init(struct cdns3 *cdns)

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
