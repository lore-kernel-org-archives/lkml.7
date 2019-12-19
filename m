Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907F5C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 20:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AC082467E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 20:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wcs2hFZc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfLSUKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 15:10:15 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:33459 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfLSUKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 15:10:15 -0500
Received: by mail-qv1-f67.google.com with SMTP id z3so2752139qvn.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 12:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UMFhKuHlOVhgEaaeCe2yyMwI6vpRch0/oXdENcz2O5U=;
        b=Wcs2hFZcDJhVBXcnmKTUyc83ImGBQao9vo8CZUDsadAsXO0S8Ahfr05knkzAHe8ZPb
         W95fUn4szixbsV5avaZTSELPexgv/dpnjnnJrXQDrp0UMluB0rnKAawBVHx/feqK8eu2
         hFc0Vtw44tgNwgobI3Ke5K7pjqeIkz1dUAmcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UMFhKuHlOVhgEaaeCe2yyMwI6vpRch0/oXdENcz2O5U=;
        b=cGG4YAY/g/tFrsmSRT+mZV8/XOXLWATzFTBxCBZO+11MA9IFX3SQyinSfXo4AmsuiM
         9+8HKOaPA93dAyg6BwmumcILDyvU82FOY1v9oYGUK9OiiMud+8EdonRI410IY2vGCNx+
         9W+/yJF39eoPa4pXBfR3WaPxzwJOiDhCt6oj9rvk/qFcW+cECtcuC5R2i0u6d5m1WVeK
         aeWdfM4erYdPsu/6R0XdG0/srXuHeAs4pA2V2Kouag9TuuUV6gGuNuJJRaU91+pcGVP7
         AapEjdjgdRyFcwvrFpBjFw/hcXmMvFULYn7IDTtQxP6LT0A4jwTQYdTmhDqCY3hx3l9a
         fm6A==
X-Gm-Message-State: APjAAAWQE1szbvQfWg/TxA1te8UlLD06lWunGyAqH7ciFMP/G5o4egHC
        g+U7paSpgpRCk9zXMTteQcUVcWVxUyeA+iEJgMKLSw==
X-Google-Smtp-Source: APXvYqwXA3vmU63ZnZrNZ0f6HM3eWgDN4WzmuAGz1j+NO1xeyQU2USX42aJLl6HnTcxpwEBJYgctCUWeRewiXjqyDS8=
X-Received: by 2002:a05:6214:192f:: with SMTP id es15mr9152336qvb.219.1576786213896;
 Thu, 19 Dec 2019 12:10:13 -0800 (PST)
MIME-Version: 1.0
References: <20191218230701.59166-1-pmalani@chromium.org> <d9aea1f0-1b5d-44bc-7fcc-eb0b8f9634fd@collabora.com>
In-Reply-To: <d9aea1f0-1b5d-44bc-7fcc-eb0b8f9634fd@collabora.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Thu, 19 Dec 2019 12:10:03 -0800
Message-ID: <CACeCKacA=w+D8W4uPwX6cf+2M7N=CfENR5B0d_=vtBxdJv8jnQ@mail.gmail.com>
Subject: Re: [PATCH v2] platform: chrome: Add cros-ec-pd-notify driver
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jon Flatley <jflat@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your review Enric. I've noted the addressed comments inline
(my apologies if I've trimmed the quoted text too aggressively).

On Thu, Dec 19, 2019 at 1:44 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hello Prashant and Jon,
>
> Thank you for the patch.
>
> On 19/12/19 0:07, Prashant Malani wrote:
> > From: Jon Flatley <jflat@chromium.org>
> >
> > ChromiumOS uses ACPI device with HID "GOOG0003" for power delivery
> > related events. The existing cros-usbpd-charger driver relies on these
> > events without ever actually receiving them on ACPI platforms. This is
> > because in the ChromeOS kernel trees, the GOOG0003 device is owned by an
> > ACPI driver that offers firmware updates to USB-C chargers.
> >
> > +++ b/drivers/mfd/cros_ec_dev.c
> > @@ -85,6 +85,9 @@ static const struct mfd_cell cros_ec_sensorhub_cells[] = {
> >  static const struct mfd_cell cros_usbpd_charger_cells[] = {
> >       { .name = "cros-usbpd-charger", },
> >       { .name = "cros-usbpd-logger", },
> > +#ifndef CONFIG_ACPI
> > +     { .name = "cros-ec-pd-notify", },
>
> Could make sense name as cros-usbpd-notify to be coherent with the other drivers
> names?
Done.
>
> > +#endif
> >  };
> >
> >  static const struct cros_feature_to_cells cros_subdevices[] = {
> > diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
> > index 5f57282a28da0..972c129b7b7ba 100644
> > --- a/drivers/platform/chrome/Kconfig
> > +++ b/drivers/platform/chrome/Kconfig
> > @@ -131,6 +131,15 @@ config CROS_EC_LPC
> >         To compile this driver as a module, choose M here: the
> >         module will be called cros_ec_lpcs.
> >
> > +config CROS_EC_PD_NOTIFY
>
> CROS_USBPD_NOTIFY ?
Done
>
> > +     tristate "ChromeOS Type-C power delivery event notifier"
> > +     depends on CROS_EC
> > +     help
> > +       If you say Y here, you get support for Type-C PD event notifications
> > +       from the ChromeOS EC. On ACPI platorms this driver will bind to the
> > +       GOOG0003 ACPI device, and on non-ACPI platforms this driver will get
> > +       initialized on ECs which support the feature EC_FEATURE_USB_PD.
> > +
>
> Add all this below CROS_USBPD_LOGGER
Done
>
> >  config CROS_EC_PROTO
> >       bool
> >       help
> > diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
> > index aacd5920d8a18..6070baa8320ca 100644
> > --- a/drivers/platform/chrome/Makefile
> > +++ b/drivers/platform/chrome/Makefile

> > +
> > +#include <linux/acpi.h>
> > +#include <linux/module.h>
> > +#include <linux/mfd/cros_ec.h>
>
> No need to worry about this for now, but just to let you know, this include will
> be unnecessary after https://lkml.org/lkml/2019/12/3/530
>
> It is fine for now, I'll remove the include when I pick up the patch.
>
Ack.
> > diff --git a/include/linux/platform_data/cros_ec_pd_notify.h b/include/linux/platform_data/cros_ec_pd_notify.h
> > new file mode 100644
> > index 0000000000000..907be5a130d60
> > --- /dev/null
> > +++ b/include/linux/platform_data/cros_ec_pd_notify.h
>
> cros_usbpd_notify.h?
Done.
>
> > @@ -0,0 +1,17 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * ChromeOS EC Power Delivery Notifier Driver
> > + *
> > + * Copyright 2019 Google LLC
> > + */
> > +
> > +#ifndef __LINUX_PLATFORM_DATA_CROS_EC_PD_NOTIFY_H
> > +#define __LINUX_PLATFORM_DATA_CROS_EC_PD_NOTIFY_H
> > +
> > +#include <linux/notifier.h>
> > +
> > +int cros_ec_pd_register_notify(struct notifier_block *nb);
> > +
> > +void cros_ec_pd_unregister_notify(struct notifier_block *nb);
> > +
> > +#endif  /* __LINUX_PLATFORM_DATA_CROS_EC_PD_NOTIFY_H */
> >
>
> The driver looks good to me, the only real complain is split the patch in two,
> one for the MFD subsystem and another one for chrome/platform.
Done. WIll split into two patches.

>Also, my
> preference is rename cros_ec_pd_notify to cros_usbpd_notify to be coherent with
> previous related drivera, but is not a must.
>
> Thanks,
>  Enric
>
>
>
>
