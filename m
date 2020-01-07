Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBECCC33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 18:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B53AE2187F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 18:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I6zlPrD4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgAGSHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 13:07:46 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:34338 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbgAGSHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 13:07:45 -0500
Received: by mail-qv1-f68.google.com with SMTP id o18so265266qvf.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 10:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dP5czesNzw6P8fHcA46o9UFuFChn3Z+OqlopJLLBhyI=;
        b=I6zlPrD481SUe53RuUSqRc0c3q5uJQd1KSCYoYsKYlTYEf1QiX0UZKdJAENCo7b5dY
         PKZz4dD05+mrrhPRGJpJ0JLKUf9TTUeKcH+2TrXg387JRwgj7oge0cio8B3jWh7a+zFd
         GiaSoUtLyd9xd1AiEZyZxY2o6ZzKXcKAeavJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dP5czesNzw6P8fHcA46o9UFuFChn3Z+OqlopJLLBhyI=;
        b=bZCYnbt409x4YCsn78pRLQpj8zmYGJJ2I9bGfw/2xFsSpY5NYFKf20F5prSEBbwuLr
         QPbwWaL170L8HuZ6sAxUjvivMZP9foMRn7d7+RoYHSW5Q/r9R0Jx3UfRtXGRecYriyfJ
         nMybmjk20mpU6cFeNl6LG6q9CTVLiEBc1pC9cnjpYY+lHR1+hcYRcD67yG5WCgqUlh9B
         r/cW+Y4xJ81KmrayyoY8By3suzDw6XIW4peiZhH/T9FIe9TjT5seluGvTtFwke85nDEl
         ObiYttV5Eyjackchd7IbsxVwb/FXT9ZNzpynQaVd+wCEPm8GullSM8uDTDl7ff0ZTfRo
         J6dA==
X-Gm-Message-State: APjAAAX4gpJt8856k1p2g4hdTa+AlEUQxD2l8tbAFdGKmWGP2iJ/kNjN
        jV1sRo1TB6RuZCMxHRrYH+GRz+3Y8CueGEP//fiJ5g==
X-Google-Smtp-Source: APXvYqyVFqjiJLXErTMpXmV+uYLxAUIgRpi0WXfZfLDzRl+PTZDgrNyD7hmA4CXJ9M86p7LQtvG5sDakjb62JnyFjCQ=
X-Received: by 2002:a0c:a563:: with SMTP id y90mr634772qvy.78.1578420464177;
 Tue, 07 Jan 2020 10:07:44 -0800 (PST)
MIME-Version: 1.0
References: <20191220193843.47182-1-pmalani@chromium.org> <9bcb4671-f421-c639-f8c8-a02f62bfc7ee@collabora.com>
 <a632243b-92b0-20a3-3eff-9c7347e0e5bf@collabora.com>
In-Reply-To: <a632243b-92b0-20a3-3eff-9c7347e0e5bf@collabora.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Tue, 7 Jan 2020 10:07:32 -0800
Message-ID: <CACeCKadvhhARxSWeb88Ny4BoRiy8opp+o0Zrzc-fQiRH6dH==A@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] platform: chrome: Add cros-usbpd-notify driver
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jon Flatley <jflat@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

On Sun, Dec 22, 2019 at 11:40 PM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Prashant,
>
> On 23/12/19 8:18, Enric Balletbo i Serra wrote:
> > Hi Prashant,
> >
> > On 20/12/19 20:38, Prashant Malani wrote:
> >> From: Jon Flatley <jflat@chromium.org>
> >>
> >> ChromiumOS uses ACPI device with HID "GOOG0003" for power delivery
> >> related events. The existing cros-usbpd-charger driver relies on these
> >> events without ever actually receiving them on ACPI platforms. This is
> >> because in the ChromeOS kernel trees, the GOOG0003 device is owned by an
> >> ACPI driver that offers firmware updates to USB-C chargers.
> >>
> >> Introduce a new platform driver under cros-ec, the ChromeOS embedded
> >> controller, that handles these PD events and dispatches them
> >> appropriately over a notifier chain to all drivers that use them.
> >>
> >> On non-ACPI platforms, the driver gets instantiated for ECs which
> >> support the EC_FEATURE_USB_PD feature bit, and on such platforms, the
> >> notification events will get delivered using the MKBP event handling
> >> mechanism.
> >>
> >> Co-Developed-by: Prashant Malani <pmalani@chromium.org>
> >> Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> >> Signed-off-by: Jon Flatley <jflat@chromium.org>
> >> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> >
> > For my own reference:
> >
> > Acked-for-chrome-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >
>
> Sorry, too much rush acking this patch, here applies the same comment as patch 2
>
> >> ---
> >>
> >> Changes in v4(pmalani@chromium.org):
> >> - No code changes, but added new version so that versioning is
> >>   consistent with the next patch in the series.
> >>
> >> Changes in v3 (pmalani@chromium.org):
> >> - Renamed driver and files from "cros_ec_pd_notify" to
> >>   "cros_usbpd_notify" to be more consistent with other naming.
> >> - Moved the change to include cros-usbpd-notify in the charger MFD into
> >>   a separate follow-on patch.
> >>
> >> Changes in v2 (pmalani@chromium.org):
> >> - Removed dependency on DT entry; instead, we will instantiate the
> >>   driver on detecting EC_FEATURE_USB_PD for non-ACPI platforms.
> >> - Modified the cros-ec-pd-notify device to be an mfd_cell under
> >>   usbpdcharger for non-ACPI platforms. Altered the platform_probe() call
> >>   to derive the cros EC structs appropriately.
> >> - Replaced "usbpd_notify" with "pd_notify" in functions and structures.
> >> - Addressed comments from upstream maintainer.
> >>
> >>  drivers/platform/chrome/Kconfig               |   9 ++
> >>  drivers/platform/chrome/Makefile              |   1 +
> >>  drivers/platform/chrome/cros_usbpd_notify.c   | 151 ++++++++++++++++++
> >>  .../linux/platform_data/cros_usbpd_notify.h   |  17 ++
> >>  4 files changed, 178 insertions(+)
> >>  create mode 100644 drivers/platform/chrome/cros_usbpd_notify.c
> >>  create mode 100644 include/linux/platform_data/cros_usbpd_notify.h
> >>
> >> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
> >> index 5f57282a28da0..3a8a98f2fb4d1 100644
> >> --- a/drivers/platform/chrome/Kconfig
> >> +++ b/drivers/platform/chrome/Kconfig
> >> @@ -226,6 +226,15 @@ config CROS_USBPD_LOGGER
> >>        To compile this driver as a module, choose M here: the
> >>        module will be called cros_usbpd_logger.
> >>
> >> +config CROS_USBPD_NOTIFY
> >> +    tristate "ChromeOS Type-C power delivery event notifier"
> >> +    depends on CROS_EC
> >> +    help
> >> +      If you say Y here, you get support for Type-C PD event notifications
> >> +      from the ChromeOS EC. On ACPI platorms this driver will bind to the
> >> +      GOOG0003 ACPI device, and on non-ACPI platforms this driver will get
> >> +      initialized on ECs which support the feature EC_FEATURE_USB_PD.
> >> +
> >>  source "drivers/platform/chrome/wilco_ec/Kconfig"
> >>
> >>  endif # CHROMEOS_PLATFORMS
> >> diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
> >> index aacd5920d8a18..f6465f8ef0b5e 100644
> >> --- a/drivers/platform/chrome/Makefile
> >> +++ b/drivers/platform/chrome/Makefile
> >> @@ -22,5 +22,6 @@ obj-$(CONFIG_CROS_EC_DEBUGFS)              += cros_ec_debugfs.o
> >>  obj-$(CONFIG_CROS_EC_SENSORHUB)             += cros_ec_sensorhub.o
> >>  obj-$(CONFIG_CROS_EC_SYSFS)         += cros_ec_sysfs.o
> >>  obj-$(CONFIG_CROS_USBPD_LOGGER)             += cros_usbpd_logger.o
> >> +obj-$(CONFIG_CROS_USBPD_NOTIFY)             += cros_usbpd_notify.o
> >>
> >>  obj-$(CONFIG_WILCO_EC)                      += wilco_ec/
> >> diff --git a/drivers/platform/chrome/cros_usbpd_notify.c b/drivers/platform/chrome/cros_usbpd_notify.c
> >> new file mode 100644
> >> index 0000000000000..05a7db834d2e0
> >> --- /dev/null
> >> +++ b/drivers/platform/chrome/cros_usbpd_notify.c
> >> @@ -0,0 +1,151 @@
> >> +// SPDX-License-Identifier: GPL-2.0-only
> >> +/*
> >> + * Copyright 2019 Google LLC
> >> + *
> >> + * This driver serves as the receiver of cros_ec PD host events.
> >> + */
> >> +
> >> +#include <linux/acpi.h>
> >> +#include <linux/module.h>
> >> +#include <linux/mfd/cros_ec.h>
> >> +#include <linux/platform_data/cros_ec_commands.h>
> >> +#include <linux/platform_data/cros_usbpd_notify.h>
> >> +#include <linux/platform_data/cros_ec_proto.h>
> >> +#include <linux/platform_device.h>
> >> +
> >> +#define DRV_NAME "cros-usbpd-notify"
> >> +#define ACPI_DRV_NAME "GOOG0003"
> >> +
> >> +static BLOCKING_NOTIFIER_HEAD(cros_usbpd_notifier_list);
> >> +
> >> +/**
> >> + * cros_usbpd_register_notify - Register a notifier callback for PD events.
> >> + * @nb: Notifier block pointer to register
> >> + *
> >> + * On ACPI platforms this corresponds to host events on the ECPD
> >> + * "GOOG0003" ACPI device. On non-ACPI platforms this will filter mkbp events
> >> + * for USB PD events.
> >> + *
> >> + * Return: 0 on success or negative error code.
> >> + */
> >> +int cros_usbpd_register_notify(struct notifier_block *nb)
> >> +{
> >> +    return blocking_notifier_chain_register(
> >> +                    &cros_usbpd_notifier_list, nb);
> >> +}
> >> +EXPORT_SYMBOL_GPL(cros_usbpd_register_notify);
> >> +
> >> +
> >> +/**
> >> + * cros_usbpd_unregister_notify - Unregister notifier callback for PD events.
> >> + * @nb: Notifier block pointer to unregister
> >> + *
> >> + * Unregister a notifier callback that was previously registered with
> >> + * cros_usbpd_register_notify().
> >> + */
> >> +void cros_usbpd_unregister_notify(struct notifier_block *nb)
> >> +{
> >> +    blocking_notifier_chain_unregister(&cros_usbpd_notifier_list, nb);
> >> +}
> >> +EXPORT_SYMBOL_GPL(cros_usbpd_unregister_notify);
> >> +
> >> +#ifdef CONFIG_ACPI
> >> +
>
> For arm64 will follow this path, and this is not what we want, right?

(Following on from your latest email in Patch 2/2 in this series): I
agree it would (follow this path) if arm64 defconfig enables ACPI in
the mainline (side note: Chrome OS's kevin build leaves this config
disabled).
To ensure I make the right update to the patch, is the suggestion for
this patch that we use #ifndef CONFIG_OF instead of #ifdef CONFIG_ACPI
?
I think that may also be problematic since !CONFIG_OF doesn't
necessarily imply CONFIG_ACPI.

Perhaps we should just make them two separate ifdef blocks, i.e #ifdef
CONFIG_OF, and then #ifdef CONFIG_ACPI? Would be great to hear your
recommendation here.

Thanks again!
