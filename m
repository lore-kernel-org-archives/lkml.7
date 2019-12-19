Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E484C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 09:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5062A24679
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 09:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfLSJoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 04:44:14 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43942 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbfLSJoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 04:44:14 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id AE60D292BB0
Subject: Re: [PATCH v2] platform: chrome: Add cros-ec-pd-notify driver
To:     Prashant Malani <pmalani@chromium.org>, groeck@chromium.org,
        bleung@chromium.org, lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jon Flatley <jflat@chromium.org>
References: <20191218230701.59166-1-pmalani@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <d9aea1f0-1b5d-44bc-7fcc-eb0b8f9634fd@collabora.com>
Date:   Thu, 19 Dec 2019 10:44:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191218230701.59166-1-pmalani@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Prashant and Jon,

Thank you for the patch.

On 19/12/19 0:07, Prashant Malani wrote:
> From: Jon Flatley <jflat@chromium.org>
> 
> ChromiumOS uses ACPI device with HID "GOOG0003" for power delivery
> related events. The existing cros-usbpd-charger driver relies on these
> events without ever actually receiving them on ACPI platforms. This is
> because in the ChromeOS kernel trees, the GOOG0003 device is owned by an
> ACPI driver that offers firmware updates to USB-C chargers.
> 
> Introduce a new platform driver under cros-ec, the ChromeOS embedded
> controller, that handles these PD events and dispatches them
> appropriately over a notifier chain to all drivers that use them.
> 
> On non-ACPI platforms, the driver gets instantiated for ECs which
> support the EC_FEATURE_USB_PD feature bit, and on such platforms, the
> notification events will get delivered using the MKBP event handling
> mechanism.
> 
> Signed-off-by: Jon Flatley <jflat@chromium.org>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
> 
> Changes in v2 (pmalani@chromium.org):
> - Removed dependency on DT entry; instead, we will instantiate the
>   driver on detecting EC_FEATURE_USB_PD for non-ACPI platforms.
> - Modified the cros-ec-pd-notify device to be an mfd_cell under
>   usbpdcharger for non-ACPI platforms. Altered the platform_probe() call
>   to derive the cros EC structs appropriately.
> - Replaced "usbpd_notify" with "pd_notify" in functions and structures.
> - Addressed comments from upstream maintainer.
> 
>  drivers/mfd/cros_ec_dev.c                     |   3 +

Please use a different patch for this. That way Lee can pick this patch
independently and I can pick the chrome/platform bits.


>  drivers/platform/chrome/Kconfig               |   9 ++
>  drivers/platform/chrome/Makefile              |   1 +
>  drivers/platform/chrome/cros_ec_pd_notify.c   | 151 ++++++++++++++++++
>  .../linux/platform_data/cros_ec_pd_notify.h   |  17 ++
>  5 files changed, 181 insertions(+)
>  create mode 100644 drivers/platform/chrome/cros_ec_pd_notify.c
>  create mode 100644 include/linux/platform_data/cros_ec_pd_notify.h
> 
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index c4b977a5dd966..cc6a6788cd5c2 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -85,6 +85,9 @@ static const struct mfd_cell cros_ec_sensorhub_cells[] = {
>  static const struct mfd_cell cros_usbpd_charger_cells[] = {
>  	{ .name = "cros-usbpd-charger", },
>  	{ .name = "cros-usbpd-logger", },
> +#ifndef CONFIG_ACPI
> +	{ .name = "cros-ec-pd-notify", },

Could make sense name as cros-usbpd-notify to be coherent with the other drivers
names?

> +#endif
>  };
>  
>  static const struct cros_feature_to_cells cros_subdevices[] = {
> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
> index 5f57282a28da0..972c129b7b7ba 100644
> --- a/drivers/platform/chrome/Kconfig
> +++ b/drivers/platform/chrome/Kconfig
> @@ -131,6 +131,15 @@ config CROS_EC_LPC
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called cros_ec_lpcs.
>  
> +config CROS_EC_PD_NOTIFY

CROS_USBPD_NOTIFY ?

> +	tristate "ChromeOS Type-C power delivery event notifier"
> +	depends on CROS_EC
> +	help
> +	  If you say Y here, you get support for Type-C PD event notifications
> +	  from the ChromeOS EC. On ACPI platorms this driver will bind to the
> +	  GOOG0003 ACPI device, and on non-ACPI platforms this driver will get
> +	  initialized on ECs which support the feature EC_FEATURE_USB_PD.
> +

Add all this below CROS_USBPD_LOGGER

>  config CROS_EC_PROTO
>  	bool
>  	help
> diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
> index aacd5920d8a18..6070baa8320ca 100644
> --- a/drivers/platform/chrome/Makefile
> +++ b/drivers/platform/chrome/Makefile
> @@ -22,5 +22,6 @@ obj-$(CONFIG_CROS_EC_DEBUGFS)		+= cros_ec_debugfs.o
>  obj-$(CONFIG_CROS_EC_SENSORHUB)		+= cros_ec_sensorhub.o
>  obj-$(CONFIG_CROS_EC_SYSFS)		+= cros_ec_sysfs.o
>  obj-$(CONFIG_CROS_USBPD_LOGGER)		+= cros_usbpd_logger.o
> +obj-$(CONFIG_CROS_EC_PD_NOTIFY)		+= cros_ec_pd_notify.o
>  
>  obj-$(CONFIG_WILCO_EC)			+= wilco_ec/
> diff --git a/drivers/platform/chrome/cros_ec_pd_notify.c b/drivers/platform/chrome/cros_ec_pd_notify.c
> new file mode 100644
> index 0000000000000..b1d98a171cff5
> --- /dev/null
> +++ b/drivers/platform/chrome/cros_ec_pd_notify.c
> @@ -0,0 +1,151 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2019 Google LLC
> + *
> + * This driver serves as the receiver of cros_ec PD host events.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/module.h>
> +#include <linux/mfd/cros_ec.h>

No need to worry about this for now, but just to let you know, this include will
be unnecessary after https://lkml.org/lkml/2019/12/3/530

It is fine for now, I'll remove the include when I pick up the patch.

> +#include <linux/platform_data/cros_ec_commands.h>
> +#include <linux/platform_data/cros_ec_pd_notify.h>
> +#include <linux/platform_data/cros_ec_proto.h>
> +#include <linux/platform_device.h>
> +
> +#define DRV_NAME "cros-ec-pd-notify"
> +#define ACPI_DRV_NAME "GOOG0003"
> +
> +static BLOCKING_NOTIFIER_HEAD(cros_ec_pd_notifier_list);
> +
> +/**
> + * cros_ec_pd_register_notify - Register a notifier callback for PD events.
> + * @nb: Notifier block pointer to register
> + *
> + * On ACPI platforms this corresponds to host events on the ECPD
> + * "GOOG0003" ACPI device. On non-ACPI platforms this will filter mkbp events
> + * for USB PD events.
> + *
> + * Return: 0 on success or negative error code.
> + */
> +int cros_ec_pd_register_notify(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_register(
> +			&cros_ec_pd_notifier_list, nb);
> +}
> +EXPORT_SYMBOL_GPL(cros_ec_pd_register_notify);
> +
> +
> +/**
> + * cros_ec_pd_unregister_notify - Unregister notifier callback for PD events.
> + * @nb: Notifier block pointer to unregister
> + *
> + * Unregister a notifier callback that was previously registered with
> + * cros_ec_pd_register_notify().
> + */
> +void cros_ec_pd_unregister_notify(struct notifier_block *nb)
> +{
> +	blocking_notifier_chain_unregister(&cros_ec_pd_notifier_list, nb);
> +}
> +EXPORT_SYMBOL_GPL(cros_ec_pd_unregister_notify);
> +
> +#ifdef CONFIG_ACPI
> +
> +static int cros_ec_pd_notify_add_acpi(struct acpi_device *adev)
> +{
> +	return 0;
> +}
> +
> +static void cros_ec_pd_notify_acpi(struct acpi_device *adev, u32 event)
> +{
> +	blocking_notifier_call_chain(&cros_ec_pd_notifier_list, event, NULL);
> +}
> +
> +static const struct acpi_device_id cros_ec_pd_acpi_device_ids[] = {
> +	{ ACPI_DRV_NAME, 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, cros_ec_pd_acpi_device_ids);
> +
> +static struct acpi_driver cros_ec_pd_notify_driver = {
> +	.name = DRV_NAME,
> +	.class = DRV_NAME,
> +	.ids = cros_ec_pd_acpi_device_ids,
> +	.ops = {
> +		.add = cros_ec_pd_notify_add_acpi,
> +		.notify = cros_ec_pd_notify_acpi,
> +	},
> +};
> +module_acpi_driver(cros_ec_pd_notify_driver);
> +
> +#else /* CONFIG_ACPI */
> +
> +static int cros_ec_pd_notify_plat(struct notifier_block *nb,
> +		unsigned long queued_during_suspend, void *data)
> +{
> +	struct cros_ec_device *ec_dev = (struct cros_ec_device *)data;
> +	u32 host_event = cros_ec_get_host_event(ec_dev);
> +
> +	if (!host_event)
> +		return NOTIFY_BAD;
> +
> +	if (host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_PD_MCU)) {
> +		blocking_notifier_call_chain(&cros_ec_pd_notifier_list,
> +				host_event, NULL);
> +		return NOTIFY_OK;
> +	}
> +	return NOTIFY_DONE;
> +}
> +
> +static int cros_ec_pd_notify_probe_plat(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct cros_ec_dev *ecdev = dev_get_drvdata(dev->parent);
> +	struct notifier_block *nb;
> +	int ret;
> +
> +	nb = devm_kzalloc(dev, sizeof(*nb), GFP_KERNEL);
> +	if (!nb)
> +		return -ENOMEM;
> +
> +	nb->notifier_call = cros_ec_pd_notify_plat;
> +	dev_set_drvdata(dev, nb);
> +
> +	ret = blocking_notifier_chain_register(&ecdev->ec_dev->event_notifier,
> +						nb);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to register notifier\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cros_ec_pd_notify_remove_plat(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct cros_ec_dev *ecdev = dev_get_drvdata(dev->parent);
> +	struct notifier_block *nb =
> +		(struct notifier_block *)dev_get_drvdata(dev);
> +
> +	blocking_notifier_chain_unregister(&ecdev->ec_dev->event_notifier,
> +			nb);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver cros_ec_pd_notify_driver = {
> +	.driver = {
> +		.name = DRV_NAME,
> +	},
> +	.probe = cros_ec_pd_notify_probe_plat,
> +	.remove = cros_ec_pd_notify_remove_plat,
> +};
> +module_platform_driver(cros_ec_pd_notify_driver);
> +
> +#endif /* CONFIG_ACPI */
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("ChromeOS power delivery notifier device");
> +MODULE_AUTHOR("Jon Flatley <jflat@chromium.org>");
> +MODULE_ALIAS("platform:" DRV_NAME);
> diff --git a/include/linux/platform_data/cros_ec_pd_notify.h b/include/linux/platform_data/cros_ec_pd_notify.h
> new file mode 100644
> index 0000000000000..907be5a130d60
> --- /dev/null
> +++ b/include/linux/platform_data/cros_ec_pd_notify.h

cros_usbpd_notify.h?

> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ChromeOS EC Power Delivery Notifier Driver
> + *
> + * Copyright 2019 Google LLC
> + */
> +
> +#ifndef __LINUX_PLATFORM_DATA_CROS_EC_PD_NOTIFY_H
> +#define __LINUX_PLATFORM_DATA_CROS_EC_PD_NOTIFY_H
> +
> +#include <linux/notifier.h>
> +
> +int cros_ec_pd_register_notify(struct notifier_block *nb);
> +
> +void cros_ec_pd_unregister_notify(struct notifier_block *nb);
> +
> +#endif  /* __LINUX_PLATFORM_DATA_CROS_EC_PD_NOTIFY_H */
> 

The driver looks good to me, the only real complain is split the patch in two,
one for the MFD subsystem and another one for chrome/platform. Also, my
preference is rename cros_ec_pd_notify to cros_usbpd_notify to be coherent with
previous related drivera, but is not a must.

Thanks,
 Enric




