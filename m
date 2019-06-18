Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A2AC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 889B92080C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="XKjYYHX0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfFRH27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 03:28:59 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:36932 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfFRH27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 03:28:59 -0400
Received: by mail-ua1-f68.google.com with SMTP id z13so4912029uaa.4;
        Tue, 18 Jun 2019 00:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qOD2hWQ4hLfEoUkY4XaGcmIUYemTQFmmpTAme6ZUYVA=;
        b=XKjYYHX0gkF2PEsaolwgUkagN2M9ZssAtyWQbYKvUoNho98eab32MZdSfq7libnvLd
         BNFxQA+lfQPGkmPZofU8iiJJ+j6gpgJXOdBduNRHHJPlgPfnGaALeRdHC9n8fjtG3dBB
         8nW8S4j+RQJqRJhRo7r0twpxqyRAQJMPhyh53Imh2VTS0zX6T/3iQRAjEthM4PC5ztp2
         ZJ+nqWj/6c57N7t6FQ36HZ7Qx2eB7SxL9cWo9G+XPfRvrkeXrfCJHllZQX1N0BKwykho
         be75RH1YgX0KBQyDneDzgx4L8y3PM3lqVYG3E/ckeSvHMWzFOdniqnBdM3oDRrlAfiLX
         gbqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qOD2hWQ4hLfEoUkY4XaGcmIUYemTQFmmpTAme6ZUYVA=;
        b=X9ehnxEuz6M+T2mlj3NvPcvXukv+hl6LYxh/cciwRoQN9a8XZyZzJHagK313A16vZL
         e2b3t/7i36QerMRjSldg+SlmvovzYzfdmgbz5VJuldiSetqZs9sq8WmcbOGqm17wBeGE
         gaqeUMMJlPXoD6gQCPjrIOnLarEm5nXP3mDwjU0FlFMx8eJr0MzCOBkpKENAeLgdjjJQ
         FDX542nNZbHdo78gJTpuX8Zk0shbqVGTRO+nvkuRDeHxYhZmnw1OqkUBHwi9m306/SBJ
         QzVpqknTrh3f0Hkg6liA6sYs/Tz24ZUXhjU3TTk8dyLEHEFk5rj8bCZFEOFaFjzFdTnk
         twRQ==
X-Gm-Message-State: APjAAAXUEmf0X9iCXegKRctOm8mIffsmM5HWINNlN93GwA55y+uj0aoD
        KMpr6kKLng0F0/6AK2Atl7yEQlCebe32omanWHc=
X-Google-Smtp-Source: APXvYqxCer6aSDF2BPCJT2TdGTGbkctvf0/TY9WKrGSU1oiKlZvTEfyy0fuRgNw3SQcBw6TMQZasLN1y6Q+zB8U0oLo=
X-Received: by 2002:ab0:7006:: with SMTP id k6mr41299765ual.42.1560842938130;
 Tue, 18 Jun 2019 00:28:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190617145952.4848-1-sr@denx.de>
In-Reply-To: <20190617145952.4848-1-sr@denx.de>
From:   Yegor Yefremov <yegorslists@googlemail.com>
Date:   Tue, 18 Jun 2019 09:28:32 +0200
Message-ID: <CAGm1_ks=2pisMnR9gx89UyiYTAO_kAzaXOBJsuorjV+9vfu3mA@mail.gmail.com>
Subject: Re: [PATCH 1/3 v7] serial: mctrl_gpio: Check if GPIO property exisits
 before requesting it
To:     Stefan Roese <sr@denx.de>
Cc:     linux-serial@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 5:00 PM Stefan Roese <sr@denx.de> wrote:
>
> This patch adds a check for the GPIOs property existence, before the
> GPIO is requested. This fixes an issue seen when the 8250 mctrl_gpio
> support is added (2nd patch in this patch series) on x86 platforms using
> ACPI.
>
> Here Mika's comments from 2016-08-09:
>
> "
> I noticed that with v4.8-rc1 serial console of some of our Broxton
> systems does not work properly anymore. I'm able to see output but input
> does not work.
>
> I bisected it down to commit 4ef03d328769eddbfeca1f1c958fdb181a69c341
> ("tty/serial/8250: use mctrl_gpio helpers").
>
> The reason why it fails is that in ACPI we do not have names for GPIOs
> (except when _DSD is used) so we use the "idx" to index into _CRS GPIO
> resources. Now mctrl_gpio_init_noauto() goes through a list of GPIOs
> calling devm_gpiod_get_index_optional() passing "idx" of 0 for each. The
> UART device in Broxton has following (simplified) ACPI description:
>
>     Device (URT4)
>     {
>         ...
>         Name (_CRS, ResourceTemplate () {
>             GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestrictionOutputOnly,
>                     "\\_SB.GPO0", 0x00, ResourceConsumer)
>             {
>                 0x003A
>             }
>             GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestrictionOutputOnly,
>                     "\\_SB.GPO0", 0x00, ResourceConsumer)
>             {
>                 0x003D
>             }
>         })
>
> In this case it finds the first GPIO (0x003A which happens to be RX pin
> for that UART), turns it into GPIO which then breaks input for the UART
> device. This also breaks systems with bluetooth connected to UART (those
> typically have some GPIOs in their _CRS).
>
> Any ideas how to fix this?
>
> We cannot just drop the _CRS index lookup fallback because that would
> break many existing machines out there so maybe we can limit this to
> only DT enabled machines. Or alternatively probe if the property first
> exists before trying to acquire the GPIOs (using
> device_property_present()).
> "
>
> This patch implements the fix suggested by Mika in his statement above.
>
> Signed-off-by: Stefan Roese <sr@denx.de>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Yegor Yefremov <yegorslists@googlemail.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Giulio Benetti <giulio.benetti@micronovasrl.com>

Tested-by: Yegor Yefremov <yegorslists@googlemail.com>

> ---
> v7:
> - Include <linux/property.h> to fix compile breakage on OMAP
>
> v6:
> - No change
>
> v5:
> - Simplified the code a bit (Andy)
> - Added gpio_str == NULL handling (Andy)
>
> v4:
> - Add missing free() calls (Johan)
> - Added Mika's reviewed by tag
> - Added Johan to Cc
>
> v3:
> - No change
>
> v2:
> - Include the problem description and analysis from Mika into the commit
>   text, as suggested by Greg.
>
>  drivers/tty/serial/serial_mctrl_gpio.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
> index 39ed56214cd3..2b400189be91 100644
> --- a/drivers/tty/serial/serial_mctrl_gpio.c
> +++ b/drivers/tty/serial/serial_mctrl_gpio.c
> @@ -12,6 +12,7 @@
>  #include <linux/termios.h>
>  #include <linux/serial_core.h>
>  #include <linux/module.h>
> +#include <linux/property.h>
>
>  #include "serial_mctrl_gpio.h"
>
> @@ -116,6 +117,19 @@ struct mctrl_gpios *mctrl_gpio_init_noauto(struct device *dev, unsigned int idx)
>
>         for (i = 0; i < UART_GPIO_MAX; i++) {
>                 enum gpiod_flags flags;
> +               char *gpio_str;
> +               bool present;
> +
> +               /* Check if GPIO property exists and continue if not */
> +               gpio_str = kasprintf(GFP_KERNEL, "%s-gpios",
> +                                    mctrl_gpios_desc[i].name);
> +               if (!gpio_str)
> +                       continue;
> +
> +               present = device_property_present(dev, gpio_str);
> +               kfree(gpio_str);
> +               if (!present)
> +                       continue;
>
>                 if (mctrl_gpios_desc[i].dir_out)
>                         flags = GPIOD_OUT_LOW;
> --
> 2.22.0
>
