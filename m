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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C55C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 21:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73F2D206CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 21:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tFR9JxRu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfKNVyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 16:54:31 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:35131 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfKNVyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 16:54:31 -0500
Received: by mail-qv1-f67.google.com with SMTP id y18so3024048qve.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 13:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9TQxPEhJ1QpedI2fdAYdmTWIf385KUzKuDuP9UXKDbw=;
        b=tFR9JxRuB2005f/p1gQKTsGFJfT0C6h+RJFiPWI6h6v2v7oa4P48Xv+rkwZ+WJqqLi
         f8Apio/Gt2QaaEysuTW7Vi5TNOjSw2s1uhNfV3JU+RzGHsOwY2FlBnMx1Mjk+c7MNz0V
         43lxWmZOLxaiQr0OQCMKceh8Nv3cdITAtI7XeO/cgAn5nFJfizHr5Sw6RgXH0jkkxmtB
         cEsB7DOX86xt0J9FKG8jfqZTNaIv0ZxY8JlSpHnqM3srfFmWGxyfaZSZKtGsVwJHqOyZ
         eBgXalrQpj8puWtFFe2zPVUOAe7UWq0CaHOdo/uKI2txZwoVIVcrRudw4LfIgfnxi/jV
         mcGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9TQxPEhJ1QpedI2fdAYdmTWIf385KUzKuDuP9UXKDbw=;
        b=ZFHeHLaoEbYX1HRGKJmyrEgeIW/udkJmoA/cxj9S3zu0403b2wfL0KWBaJqSUTqdu5
         OJyXr5JyeYc/JMRrGITNuppm3VAlAa6XdHZ3eFT9XnEm70D3IxqrhB/17hiNpbb1DnkN
         ebanOOcY5FwreILkcKKX3e6v8Tw76olVOCIli3wAj6qpHSX/GXNh1B9IwsuEJMxhBAY+
         POjlkPUdwSxlREQyjeN+qrf761P0jgeBcFD85Jm179VBD3BCdF0pYfO8ZwXGqgIq/0zF
         qqnnz/LcugpOeejF9tOoimqCUF2jLFhkdO/2MTcqlUgNjiTcDvZdjgkchMbTP3tbMhY0
         +muw==
X-Gm-Message-State: APjAAAXLf2qBTzqdlL8YgCFPeskUQ3xHoJ03+rO4ZlDgeQxX+tu+sWNC
        Tj4SyzSBnSnB0US9WDQcDXilODsy3ejnMiMo6rggyw==
X-Google-Smtp-Source: APXvYqyO2TFn5IwRoUN2d3CEJBj6soP1oIB4RoiGkLUpEc00Fr2+Lp81ksGESQEb6KIXZo5/bSr/bucJKEmkHq7X1ns=
X-Received: by 2002:ad4:4e6b:: with SMTP id ec11mr10497224qvb.121.1573768469560;
 Thu, 14 Nov 2019 13:54:29 -0800 (PST)
MIME-Version: 1.0
References: <20191113031044.136232-1-jflat@chromium.org> <20191113031044.136232-3-jflat@chromium.org>
In-Reply-To: <20191113031044.136232-3-jflat@chromium.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 14 Nov 2019 22:53:51 +0100
Message-ID: <CAFqH_50LoD_gu3XhvRNk4EjyCNpgJaCW_CqF2GNAWguk-AB0dA@mail.gmail.com>
Subject: Re: [PATCH 2/3] power: supply: cros-ec-usbpd-charger: Fix host events
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

Some comments below.

Missatge de Jon Flatley <jflat@chromium.org> del dia dc., 13 de nov.
2019 a les 4:19:
>
> There's a bug on ACPI platforms where host events from the ECPD ACPI
> device never make their way to the cros-ec-usbpd-charger driver. This
> makes it so the only time the charger driver updates its state is when
> user space accesses its sysfs attributes.
>
> Now that these events have been unified into a single notifier chain on
> both ACPI and non-ACPI platforms the charger driver can just be updated
> to use this new notifer.
>
> Signed-off-by: Jon Flatley <jflat@chromium.org>
> ---
>  drivers/power/supply/Kconfig              |  2 +-
>  drivers/power/supply/cros_usbpd-charger.c | 45 ++++++++---------------
>  2 files changed, 17 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index c84a7b1caeb6..7664849d7680 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -659,7 +659,7 @@ config CHARGER_RT9455
>
>  config CHARGER_CROS_USBPD
>         tristate "ChromeOS EC based USBPD charger"
> -       depends on CROS_EC
> +       depends on CROS_EC_USBPD_NOTIFY
>         default n
>         help
>           Say Y here to enable ChromeOS EC based USBPD charger
> diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/supply/cros_usbpd-charger.c
> index 6cc7c3910e09..58cf51b51179 100644
> --- a/drivers/power/supply/cros_usbpd-charger.c
> +++ b/drivers/power/supply/cros_usbpd-charger.c
> @@ -8,6 +8,7 @@
>  #include <linux/mfd/cros_ec.h>
>  #include <linux/module.h>
>  #include <linux/platform_data/cros_ec_commands.h>
> +#include <linux/platform_data/cros_ec_usbpd_notify.h>
>  #include <linux/platform_data/cros_ec_proto.h>
>  #include <linux/platform_device.h>
>  #include <linux/power_supply.h>
> @@ -524,32 +525,22 @@ static int cros_usbpd_charger_property_is_writeable(struct power_supply *psy,
>  }
>
>  static int cros_usbpd_charger_ec_event(struct notifier_block *nb,
> -                                      unsigned long queued_during_suspend,
> +                                      unsigned long host_event,
>                                        void *_notify)
>  {
> -       struct cros_ec_device *ec_device;
>         struct charger_data *charger;
> -       u32 host_event;
>
>         charger = container_of(nb, struct charger_data, notifier);
> -       ec_device = charger->ec_device;
>
> -       host_event = cros_ec_get_host_event(ec_device);
> -       if (host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_PD_MCU)) {
> -               cros_usbpd_charger_power_changed(charger->ports[0]->psy);
> -               return NOTIFY_OK;
> -       } else {
> -               return NOTIFY_DONE;
> -       }
> +       cros_usbpd_charger_power_changed(charger->ports[0]->psy);
> +       return NOTIFY_OK;
>  }
>
>  static void cros_usbpd_charger_unregister_notifier(void *data)
>  {
>         struct charger_data *charger = data;
> -       struct cros_ec_device *ec_device = charger->ec_device;
>
> -       blocking_notifier_chain_unregister(&ec_device->event_notifier,
> -                                          &charger->notifier);
> +       cros_ec_usbpd_unregister_notify(&charger->notifier);
>  }
>

Can we get rid of this function and call directly
cros_ec_usbpd_unregister_notify where the function is used?

>  static int cros_usbpd_charger_probe(struct platform_device *pd)
> @@ -683,21 +674,17 @@ static int cros_usbpd_charger_probe(struct platform_device *pd)
>                 goto fail;
>         }
>
> -       if (ec_device->mkbp_event_supported) {
> -               /* Get PD events from the EC */
> -               charger->notifier.notifier_call = cros_usbpd_charger_ec_event;
> -               ret = blocking_notifier_chain_register(
> -                                               &ec_device->event_notifier,
> -                                               &charger->notifier);
> -               if (ret < 0) {
> -                       dev_warn(dev, "failed to register notifier\n");
> -               } else {
> -                       ret = devm_add_action_or_reset(dev,
> -                                       cros_usbpd_charger_unregister_notifier,
> -                                       charger);
> -                       if (ret < 0)
> -                               goto fail;
> -               }
> +       /* Get PD events from the EC */
> +       charger->notifier.notifier_call = cros_usbpd_charger_ec_event;
> +       ret = cros_ec_usbpd_register_notify(&charger->notifier);
> +       if (ret < 0) {
> +               dev_warn(dev, "failed to register notifier\n");

Hmm, now I am wondering if should we only warn and continue or fail.
Makes sense have this without the notifier?

> +       } else {
> +               ret = devm_add_action_or_reset(dev,
> +                               cros_usbpd_charger_unregister_notifier,
> +                               charger);
> +               if (ret < 0)
> +                       goto fail;
>         }
>
>         return 0;
> --
> 2.24.0.432.g9d3f5f5b63-goog
>

Thanks,
 Enric
