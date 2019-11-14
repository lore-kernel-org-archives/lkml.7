Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB07C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 21:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA43420709
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 21:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+GDHeA/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfKNVn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 16:43:56 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:45835 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbfKNVnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 16:43:55 -0500
Received: by mail-qv1-f65.google.com with SMTP id g12so2990503qvy.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 13:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1sL2rOw+oNJOZEyqWF8wUhUeQa+2CC13ejQhkFt2T+Y=;
        b=d+GDHeA/oM7HHxQIFrcfWnHwqIi6lkUrr8UiXTsYn4PIkbMnNvsT6XCL452TV1k9pl
         pnh+j7ZzwDeABH9a/ORbq2q8erF9JZmW1N444HqOxYcDgD27iN0Cs4d9WucMatevsP8h
         bKblmIY86yXUBKbN4ETWlFg3p79mb2ZaXGT29Czct31aC2t2oBgZESinZj8dAaBlYhBw
         bz/wLLi0ARFiiY4J5vekNqqfkEx4g0ExSW4rYyjq4AyTJk0ZIp3qrs9RW6IbW4iJwUz7
         U/Zd1cDEiWEeX915X10ihapHxCFnmGW07Ki5Ra3FHBoERkYvjEbl5iSv4JBtQMiGIM9F
         g1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1sL2rOw+oNJOZEyqWF8wUhUeQa+2CC13ejQhkFt2T+Y=;
        b=MbF6jR9ksbtwHQkvprAfwXhAtVOKpzqodq4EVAW2iMt6Xd+kHGrSLMGzv8nbxbDAx2
         rZiiUNYih5LMP+xBkmABtBEHM7/ooTwUYS5JZrPn5Uh9NYgOqfAwfog+Ofa825NnION+
         mvYwHEC/ZDGA87xxblTjaldpQfBo79GNJer3Cfwz9NJeYnuoDB5j5nlNVgPFyLemhnKC
         Uo3LNDfYot94dCZdw4sraDmX35by8XM6gcYPTvbmBdmKvAA0kIGsPUFjo6n4CllLZI7F
         fNg/vus5nfrQ+C1EGrYme/URVVz5sbxJKxwb7s+FSHFQsXkqcOr7iWULqWsAVPKD/Qdh
         AEoQ==
X-Gm-Message-State: APjAAAWV5aZajx68UbqVMDi3ot50HAmVZ6xRNsS1UJ9jt/xL7a6rBfmI
        Cjx+hrZz9bwa67RIeajQgS/inEmkX9Z9eviJOpg=
X-Google-Smtp-Source: APXvYqy8hySbK6BMoPd6HW39LtsAeAbBeUWseezc5pcyWwLsOUwwFWQEMXaBW/S0YPRhb8WlFEEhw/j0kZTBe7dCFaM=
X-Received: by 2002:a0c:f911:: with SMTP id v17mr10282678qvn.94.1573767833897;
 Thu, 14 Nov 2019 13:43:53 -0800 (PST)
MIME-Version: 1.0
References: <20191113031044.136232-1-jflat@chromium.org> <20191113031044.136232-2-jflat@chromium.org>
In-Reply-To: <20191113031044.136232-2-jflat@chromium.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 14 Nov 2019 22:43:42 +0100
Message-ID: <CAFqH_52LcpXbt-85fFje4-7tDoqvg8r2vg9DRbYAWKKnkkcESg@mail.gmail.com>
Subject: Re: [PATCH 1/3] platform: chrome: Add cros-ec-usbpd-notify driver
To:     Jon Flatley <jflat@chromium.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Sebastian Reichel <sre@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

Many thanks for working on this and push it upstream. Some comments below

Missatge de Jon Flatley <jflat@chromium.org> del dia dc., 13 de nov.
2019 a les 4:13:
>
> ChromiumOS uses ACPI device with HID "GOOG0003" for power delivery
> related events. The existing cros-usbpd-charger driver relies on these
> events without ever actually receiving them on ACPI platforms. This is
> because in the ChromeOS kernel trees, the GOOG0003 device is owned by an
> ACPI driver that offers firmware updates to USB-C chargers.
>
> Let's introduce a new platform driver under cros-ec, the ChromeOS
> embedded controller, that handles these PD events and dispatches them
> appropriately over a notifier chain to all drivers that use them.
>
> Signed-off-by: Jon Flatley <jflat@chromium.org>
> ---
>  drivers/platform/chrome/Kconfig               |   9 +
>  drivers/platform/chrome/Makefile              |   1 +
>  .../platform/chrome/cros_ec_usbpd_notify.c    | 156 ++++++++++++++++++
>  .../platform_data/cros_ec_usbpd_notify.h      |  40 +++++
>  4 files changed, 206 insertions(+)
>  create mode 100644 drivers/platform/chrome/cros_ec_usbpd_notify.c
>  create mode 100644 include/linux/platform_data/cros_ec_usbpd_notify.h
>
> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
> index ee5f08ea57b6..d4a55b64bc29 100644
> --- a/drivers/platform/chrome/Kconfig
> +++ b/drivers/platform/chrome/Kconfig
> @@ -118,6 +118,15 @@ config CROS_EC_SPI
>           response time cannot be guaranteed, we support ignoring
>           'pre-amble' bytes before the response actually starts.
>
> +config CROS_EC_USBPD_NOTIFY
> +       tristate "ChromeOS USB-C power delivery event notifier"
> +       depends on CROS_EC
> +       help
> +         If you say Y here, you get support for USB-C PD event notifications
> +         from the ChromeOS EC. On ACPI platorms this driver will bind to the
> +         GOOG0003 ACPI device, and on non-ACPI platform this driver will match
> +         "google,cros-ec-pd-update" in device tree.
> +
>  config CROS_EC_LPC
>         tristate "ChromeOS Embedded Controller (LPC)"
>         depends on CROS_EC && ACPI && (X86 || COMPILE_TEST)
> diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
> index 477ec3d1d1c9..efa355ab526f 100644
> --- a/drivers/platform/chrome/Makefile
> +++ b/drivers/platform/chrome/Makefile
> @@ -21,5 +21,6 @@ obj-$(CONFIG_CROS_EC_VBC)             += cros_ec_vbc.o
>  obj-$(CONFIG_CROS_EC_DEBUGFS)          += cros_ec_debugfs.o
>  obj-$(CONFIG_CROS_EC_SYSFS)            += cros_ec_sysfs.o
>  obj-$(CONFIG_CROS_USBPD_LOGGER)                += cros_usbpd_logger.o
> +obj-$(CONFIG_CROS_EC_USBPD_NOTIFY)      += cros_ec_usbpd_notify.o
>
>  obj-$(CONFIG_WILCO_EC)                 += wilco_ec/
> diff --git a/drivers/platform/chrome/cros_ec_usbpd_notify.c b/drivers/platform/chrome/cros_ec_usbpd_notify.c
> new file mode 100644
> index 000000000000..f654586dea2a
> --- /dev/null
> +++ b/drivers/platform/chrome/cros_ec_usbpd_notify.c
> @@ -0,0 +1,156 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * cros_ec_usbpd - ChromeOS EC Power Delivery Driver

Please remove 'cros_ec_usbpd -'

> + *
> + * Copyright (C) 2019 Google, Inc
> + *

I think it should be

Copyright 2019 Google LLC

> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *

Remove the license boilerplate, with the SPDX identifier, is enough.

> + * This driver serves as the receiver of cros_ec PD host events.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/mfd/cros_ec.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_data/cros_ec_commands.h>
> +#include <linux/platform_data/cros_ec_usbpd_notify.h>
> +#include <linux/platform_data/cros_ec_proto.h>
> +#include <linux/platform_device.h>
> +
> +#define DRV_NAME "cros-ec-usbpd-notify"
> +#define ACPI_DRV_NAME "GOOG0003"
> +
> +static BLOCKING_NOTIFIER_HEAD(cros_ec_usbpd_notifier_list);
> +
> +int cros_ec_usbpd_register_notify(struct notifier_block *nb)
> +{
> +       return blocking_notifier_chain_register(
> +                       &cros_ec_usbpd_notifier_list, nb);
> +}
> +EXPORT_SYMBOL_GPL(cros_ec_usbpd_register_notify);
> +
> +void cros_ec_usbpd_unregister_notify(struct notifier_block *nb)
> +{
> +       blocking_notifier_chain_unregister(&cros_ec_usbpd_notifier_list, nb);
> +}
> +EXPORT_SYMBOL_GPL(cros_ec_usbpd_unregister_notify);
> +
> +static void cros_ec_usbpd_notify(u32 event)
> +{
> +       blocking_notifier_call_chain(&cros_ec_usbpd_notifier_list, event, NULL);
> +}

That function is not needed, just call directly blocking_notifier_call_chain.

> +
> +#ifdef CONFIG_ACPI
> +

I think you can create a single platform_driver ACPI and non-ACPI
compatible and get rid of this ifdef

> +static int cros_ec_usbpd_add_acpi(struct acpi_device *adev)
> +{
> +       return 0;
> +}
> +
Could be probably be removed

> +static int cros_ec_usbpd_remove_acpi(struct acpi_device *adev)
> +{
> +       return 0;
> +}
Could be probably be removed

> +static void cros_ec_usbpd_notify_acpi(struct acpi_device *adev, u32 event)
> +{
> +       cros_ec_usbpd_notify(event);
> +}
> +
> +static const struct acpi_device_id cros_ec_usbpd_acpi_device_ids[] = {
> +       { ACPI_DRV_NAME, 0 },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(acpi, cros_ec_usbpd_acpi_device_ids);
> +
> +static struct acpi_driver cros_ec_usbpd_driver = {
> +       .name = DRV_NAME,
> +       .class = DRV_NAME,
> +       .ids = cros_ec_usbpd_acpi_device_ids,
> +       .ops = {
> +               .add = cros_ec_usbpd_add_acpi,
> +               .remove = cros_ec_usbpd_remove_acpi,
> +               .notify = cros_ec_usbpd_notify_acpi,
> +       },
> +};
> +module_acpi_driver(cros_ec_usbpd_driver);
> +
> +#else /* CONFIG_ACPI */
> +
> +static int cros_ec_usbpd_notify_plat(struct notifier_block *nb,
> +               unsigned long queued_during_suspend, void *data)
> +{
> +       struct cros_ec_device *ec_dev = (struct cros_ec_device *)data;
> +       u32 host_event = cros_ec_get_host_event(ec_dev);
> +
> +       if (host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_PD_MCU)) {
> +               cros_ec_usbpd_notify(host_event);
> +               return NOTIFY_OK;
> +       } else {

Remove the else and just return NOTIFY_DONE

> +               return NOTIFY_DONE;
> +       }
> +

Remove the extra blank line.

> +}
> +
> +static int cros_ec_usbpd_probe_plat(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct cros_ec_device *ec_dev = dev_get_drvdata(dev->parent);
> +       struct notifier_block *nb;
> +       int ret;
> +
> +       nb = devm_kzalloc(dev, sizeof(*nb), GFP_KERNEL);
> +       if (!nb)
> +               return -ENOMEM;
> +
> +       nb->notifier_call = cros_ec_usbpd_notify_plat;
> +       dev_set_drvdata(dev, nb);
> +       ret = blocking_notifier_chain_register(&ec_dev->event_notifier, nb);
> +

Remove the extra blank line

> +       if (ret < 0)
> +               dev_warn(dev, "Failed to register notifier\n");

Only a warning? shouldn't you return an error?

> +
> +       return 0;
> +}
> +
> +static int cros_ec_usbpd_remove_plat(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct cros_ec_device *ec_dev = dev_get_drvdata(dev->parent);
> +       struct notifier_block *nb =
> +               (struct notifier_block *)dev_get_drvdata(dev);
> +
> +       blocking_notifier_chain_unregister(&ec_dev->event_notifier, nb);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id cros_ec_usbpd_of_match[] = {
> +       { .compatible = "google,cros-ec-pd-update" },

This should be documented in Documentation/devicetree/bindings

> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, cros_ec_usbpd_of_match);
> +
> +static struct platform_driver cros_ec_usbpd_driver = {
> +       .driver = {
> +               .name = DRV_NAME,
> +               .of_match_table = of_match_ptr(cros_ec_usbpd_of_match),
> +       },
> +       .probe = cros_ec_usbpd_probe_plat,
> +       .remove = cros_ec_usbpd_remove_plat,
> +};
> +module_platform_driver(cros_ec_usbpd_driver);
> +
> +#endif /* CONFIG_ACPI */
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("ChromeOS power delivery device");
> +MODULE_AUTHOR("Jon Flatley <jflat@chromium.org>");
> +MODULE_ALIAS("platform:" DRV_NAME);
> diff --git a/include/linux/platform_data/cros_ec_usbpd_notify.h b/include/linux/platform_data/cros_ec_usbpd_notify.h
> new file mode 100644
> index 000000000000..fdcea146b7c4
> --- /dev/null
> +++ b/include/linux/platform_data/cros_ec_usbpd_notify.h
> @@ -0,0 +1,40 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * cros_ec_usbpd - ChromeOS EC Power Delivery Driver
> + *

Remove 'cros_ec_usbpd -'

> + * Copyright (C) 2019 Google, Inc
> + *

Copyright 2019 Google LLC

> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.

Remove the license boiler plate

> + */
> +
> +#ifndef __LINUX_PLATFORM_DATA_CROS_EC_USBPD_NOTIFY_H
> +#define __LINUX_PLATFORM_DATA_CROS_EC_USBPD_NOTIFY_H
> +
> +#include <linux/notifier.h>
> +
> +/**
> + * cros_ec_usbpd_register_notify - register a notifier callback for USB PD
> + * events. On ACPI platforms this corrisponds to to host events on the ECPD
> + * "GOOG0003" ACPI device. On non-ACPI platforms this will filter mkbp events
> + * for USB PD events.
> + *
> + * @nb: Notifier block pointer to register
> + */

I don't think this is kernel-doc compliant, please check running kernel-doc -v

> +int cros_ec_usbpd_register_notify(struct notifier_block *nb);
> +
> +/**
> + * cros_ec_usbpd_unregister_notify - unregister a notifier callback that was
> + * previously registered with cros_ec_usbpd_register_notify().
> + *
> + * @nb: Notifier block pointer to unregister
> + */

Same here

> +void cros_ec_usbpd_unregister_notify(struct notifier_block *nb);
> +
> +#endif  /* __LINUX_PLATFORM_DATA_CROS_EC_USBPD_NOTIFY_H */
> --
> 2.24.0.432.g9d3f5f5b63-goog
>

Thanks,
 Enric
