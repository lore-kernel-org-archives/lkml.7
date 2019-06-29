Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31E4C4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 13:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A89BB2054F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 13:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfatlPzW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfF2NQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 09:16:07 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41523 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbfF2NQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 09:16:07 -0400
Received: by mail-pl1-f195.google.com with SMTP id m7so4770252pls.8;
        Sat, 29 Jun 2019 06:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oZH7srH293GzXaPIhoiVN9XL4MTAYK6bMjRqUu3n++g=;
        b=lfatlPzW+wGWhcBiY5YcUE8n9XAVbRoxujyUdMfgMkXNyuIzJ/owsC7OuW382PWtSQ
         CzUUSKt5UuV+XqwuhEn7p0TUTzrYS8TardBVza4UKysmEtcZ+ZQa7r9RETI8tjDYWXRG
         i0D9Hz9JUqpxD6lWEReM+wi34sVh2YuCedp5UJesa4B3m4gv5Lx6J3JOBIEvjBKQe+2v
         SePJscnW1x6fCqVxUG5SnZVnPlgG4XazX8evJePfBt6Ddye3Qx5l0bJMLfxxUZNizxuT
         ffCXkRwvUf6ra2GUjRbfBAd7rdiP0OA+/eoiJWfj493PQT+24Ue1RtD8qUpzB9Q2qoW6
         MFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oZH7srH293GzXaPIhoiVN9XL4MTAYK6bMjRqUu3n++g=;
        b=kQPlLqOUIXEhlzYBtk/k9NA/HdDHDkEnnhn//ZWktcYdcvbyu5nhp/Zpnw/0QT393H
         nsF3kdHiaajJpJNCjjuMd6VbxoX2slJO0qCWVvoP5RaHJhortGZt1BsGJPaI6/BCcrIV
         fl+zU8gkdjUjx3NDCEd9dQoGJ9LRlIXOmEfIchn0OHl/KQNyvz2AWblnqdLywkMwGB89
         EqMoiP8XVgWtMVgsYoT2SbcSb4GNZLhFXc+qsN//OP8SiAvuqzwb7ky1KZeOoacnXdAC
         A6EyPpSHbMO2mYRQ3yot7HlhCf5ItK0VhKheP3vhdpfAo7N7f/cEELMvyTq8GL26FmYu
         Zbug==
X-Gm-Message-State: APjAAAVAYIk39c1VLuJJ/6MS9g4HAqHpgjeWNaed8rNxgbXZcGPjCEd/
        kcmENXdbXrcTmEaDlMKUhUAFIg5GYIPX3cCN0cfIzO+pESs=
X-Google-Smtp-Source: APXvYqyuK+3WEiL/OHaUVZapvgUmTBt62blpxoWv+cvkZ1Jytrjvgvm/1aujnuc0dGgb4IzSQFAxHvO0fPNqBHutQfI=
X-Received: by 2002:a17:902:ab90:: with SMTP id f16mr17338532plr.262.1561814166287;
 Sat, 29 Jun 2019 06:16:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1558968964.git.2pi@mok.nu> <eb57957045495464539c8b4896a8d83b5d87377b.1558968964.git.2pi@mok.nu>
In-Reply-To: <eb57957045495464539c8b4896a8d83b5d87377b.1558968964.git.2pi@mok.nu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 29 Jun 2019 16:15:55 +0300
Message-ID: <CAHp75VewdbB7xStMOaomf2FVKrTeZVVhFyrBWYL=MJ4HOYKTWQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] platform/x86: wmi: add Xiaomi WMI key driver
To:     Mattias Jacobsson <2pi@mok.nu>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 7:22 PM Mattias Jacobsson <2pi@mok.nu> wrote:
>
> Some function keys on the built in keyboard on Xiaomi's notebooks does
> not produce any key events when pressed in combination with the function
> key. Some of these keys do report that they are being pressed via WMI
> events.
>
> This driver reports key events for Fn+F7 and double tap on Fn.
>
> Other WMI events that are reported by the hardware but not utilized by
> this driver are Caps Lock(which already work) and Fn lock/unlock.
>

Pushed to my review and testing queue, thanks!

> Signed-off-by: Mattias Jacobsson <2pi@mok.nu>
> ---
>  drivers/platform/x86/Kconfig      | 10 ++++
>  drivers/platform/x86/Makefile     |  1 +
>  drivers/platform/x86/xiaomi-wmi.c | 94 +++++++++++++++++++++++++++++++
>  3 files changed, 105 insertions(+)
>  create mode 100644 drivers/platform/x86/xiaomi-wmi.c
>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 5d5cc6111081..257a99134b64 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -781,6 +781,16 @@ config INTEL_WMI_THUNDERBOLT
>           To compile this driver as a module, choose M here: the module will
>           be called intel-wmi-thunderbolt.
>
> +config XIAOMI_WMI
> +         tristate "Xiaomi WMI key driver"
> +         depends on ACPI_WMI
> +         depends on INPUT
> +         help
> +         Say Y here if you want to support WMI-based keys on Xiaomi notebooks.
> +
> +         To compile this driver as a module, choose M here: the module will
> +         be called xiaomi-wmi.
> +
>  config MSI_WMI
>         tristate "MSI WMI extras"
>         depends on ACPI_WMI
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index 87b0069bd781..f64445d69f99 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -51,6 +51,7 @@ obj-$(CONFIG_SURFACE3_WMI)    += surface3-wmi.o
>  obj-$(CONFIG_TOPSTAR_LAPTOP)   += topstar-laptop.o
>  obj-$(CONFIG_WMI_BMOF)         += wmi-bmof.o
>  obj-$(CONFIG_INTEL_WMI_THUNDERBOLT)    += intel-wmi-thunderbolt.o
> +obj-$(CONFIG_XIAOMI_WMI)       += xiaomi-wmi.o
>
>  # toshiba_acpi must link after wmi to ensure that wmi devices are found
>  # before toshiba_acpi initializes
> diff --git a/drivers/platform/x86/xiaomi-wmi.c b/drivers/platform/x86/xiaomi-wmi.c
> new file mode 100644
> index 000000000000..4ff9df5eb88f
> --- /dev/null
> +++ b/drivers/platform/x86/xiaomi-wmi.c
> @@ -0,0 +1,94 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * WMI driver for Xiaomi Laptops
> + *
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/input.h>
> +#include <linux/module.h>
> +#include <linux/wmi.h>
> +#include <uapi/linux/input-event-codes.h>
> +
> +#define XIAOMI_KEY_FN_ESC_0    "A2095CCE-0491-44E7-BA27-F8ED8F88AA86"
> +#define XIAOMI_KEY_FN_ESC_1    "7BBE8E39-B486-473D-BA13-66F75C5805CD"
> +#define XIAOMI_KEY_FN_FN       "409B028D-F06B-4C7C-8BBB-EE133A6BD87E"
> +#define XIAOMI_KEY_CAPSLOCK    "83FE7607-053A-4644-822A-21532C621FC7"
> +#define XIAOMI_KEY_FN_F7       "76E9027C-95D0-4180-8692-DA6747DD1C2D"
> +
> +#define XIAOMI_DEVICE(guid, key)               \
> +       .guid_string = (guid),                  \
> +       .context = &(const unsigned int){key}
> +
> +struct xiaomi_wmi {
> +       struct input_dev *input_dev;
> +       unsigned int key_code;
> +};
> +
> +int xiaomi_wmi_probe(struct wmi_device *wdev, const void *context)
> +{
> +       struct xiaomi_wmi *data;
> +
> +       if (wdev == NULL || context == NULL)
> +               return -EINVAL;
> +
> +       data = devm_kzalloc(&wdev->dev, sizeof(struct xiaomi_wmi), GFP_KERNEL);
> +       if (data == NULL)
> +               return -ENOMEM;
> +       dev_set_drvdata(&wdev->dev, data);
> +
> +       data->input_dev = devm_input_allocate_device(&wdev->dev);
> +       if (data->input_dev == NULL)
> +               return -ENOMEM;
> +       data->input_dev->name = "Xiaomi WMI keys";
> +       data->input_dev->phys = "wmi/input0";
> +
> +       data->key_code = *((const unsigned int *)context);
> +       set_bit(EV_KEY, data->input_dev->evbit);
> +       set_bit(data->key_code, data->input_dev->keybit);
> +
> +       return input_register_device(data->input_dev);
> +}
> +
> +void xiaomi_wmi_notify(struct wmi_device *wdev, union acpi_object *_)
> +{
> +       struct xiaomi_wmi *data;
> +
> +       if (wdev == NULL)
> +               return;
> +
> +       data = dev_get_drvdata(&wdev->dev);
> +       if (data == NULL)
> +               return;
> +
> +       input_report_key(data->input_dev, data->key_code, 1);
> +       input_sync(data->input_dev);
> +       input_report_key(data->input_dev, data->key_code, 0);
> +       input_sync(data->input_dev);
> +}
> +
> +static const struct wmi_device_id xiaomi_wmi_id_table[] = {
> +       // { XIAOMI_DEVICE(XIAOMI_KEY_FN_ESC_0, KEY_FN_ESC) },
> +       // { XIAOMI_DEVICE(XIAOMI_KEY_FN_ESC_1, KEY_FN_ESC) },
> +       { XIAOMI_DEVICE(XIAOMI_KEY_FN_FN, KEY_PROG1) },
> +       // { XIAOMI_DEVICE(XIAOMI_KEY_CAPSLOCK, KEY_CAPSLOCK) },
> +       { XIAOMI_DEVICE(XIAOMI_KEY_FN_F7, KEY_CUT) },
> +
> +       /* Terminating entry */
> +       { }
> +};
> +
> +static struct wmi_driver xiaomi_wmi_driver = {
> +       .driver = {
> +               .name = "xiaomi-wmi",
> +       },
> +       .id_table = xiaomi_wmi_id_table,
> +       .probe = xiaomi_wmi_probe,
> +       .notify = xiaomi_wmi_notify,
> +};
> +module_wmi_driver(xiaomi_wmi_driver);
> +
> +MODULE_DEVICE_TABLE(wmi, xiaomi_wmi_id_table);
> +MODULE_AUTHOR("Mattias Jacobsson");
> +MODULE_DESCRIPTION("Xiaomi WMI driver");
> +MODULE_LICENSE("GPL v2");
> --
> 2.21.0
>


-- 
With Best Regards,
Andy Shevchenko
