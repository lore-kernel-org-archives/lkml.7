Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013BBC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 15:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B7020661
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 15:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfLCP33 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 10:29:29 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36973 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfLCP33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 10:29:29 -0500
Received: by mail-ot1-f65.google.com with SMTP id k14so3259386otn.4;
        Tue, 03 Dec 2019 07:29:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hfLvVnQ8OaOqW5ONkxG90DK+rPeEKylMJL1PNCl8KZo=;
        b=XnBLtngm3reUfzZFbdZq4nsjJ3quv/KXvOmcchNWiqgGghM7+eCLxQoopW17FtNzH6
         0YMbo4N9W3PXeYGHF/D/WaP20BiRyZQhsCdsjatldQ18EGdntkAruQORDjQ2/LpfBe/e
         shVUWQqNZQoqAq+Fj7JVRxjntSJLVC3xXms/jxYe8IPz8Nu5o786hNOZV8J/kyRaW38M
         +xWv4tByS4/4OiBsZrBHm+dcATrJb2LMLhlZYP8zS0JB2Z2pOqrzcr9bC8Xk/5i1MqLc
         XBZntoWOoS0Ed8c5poDE8BxRSJlucWzJlPNWijntr1RVgouM3dUxJomk8dUseZ6YDP+r
         nquw==
X-Gm-Message-State: APjAAAX5VKOaketoLknwdGrtHJGeCA3xM0WP0RkRIc86KTkBrrDCzyFP
        7yvqFz3W4aILOWuifRO+8m8sI0qt7fW+RaeJIzHCIQ==
X-Google-Smtp-Source: APXvYqy8FPeBXmi8lyHhcGfNHeBjO1zuQiU7pD/x8qCJPDHEK7BFc18g7cx9mVxKZ6ROMQh9a1WCkXH4RS7xAN0W+XM=
X-Received: by 2002:a9d:3a37:: with SMTP id j52mr3623297otc.39.1575386968258;
 Tue, 03 Dec 2019 07:29:28 -0800 (PST)
MIME-Version: 1.0
References: <20191203144631.6629-1-linux@roeck-us.net>
In-Reply-To: <20191203144631.6629-1-linux@roeck-us.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 Dec 2019 16:29:17 +0100
Message-ID: <CAMuHMdWFpHsGk9V-nRaDOP-sjh5DWsGtHNGZ_jm3J3BFYd6KqA@mail.gmail.com>
Subject: Re: [PATCH] drivers: Fix boot problem on SuperH
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Günter,

On Tue, Dec 3, 2019 at 3:46 PM Guenter Roeck <linux@roeck-us.net> wrote:
> SuperH images crash too eearly to display any console output. Bisect
> points to commit 507fd01d5333 ("drivers: move the early platform device
> support to arch/sh"). An analysis of that patch suggests that
> early_platform_cleanup() is now called at the wrong time. Restoring its
> call point fixes the problem.
>
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Fixes: 507fd01d5333 ("drivers: move the early platform device support to arch/sh")
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

> --- a/arch/sh/drivers/platform_early.c
> +++ b/arch/sh/drivers/platform_early.c
> @@ -325,9 +325,9 @@ int __init sh_early_platform_driver_probe(char *class_str,
>  }
>
>  /**
> - * sh_early_platform_cleanup - clean up early platform code
> + * early_platform_cleanup - clean up early platform code
>   */
> -static int __init sh_early_platform_cleanup(void)
> +void early_platform_cleanup(void)

This function should be __init...

>  {
>         struct platform_device *pd, *pd2;
>
> @@ -337,11 +337,4 @@ static int __init sh_early_platform_cleanup(void)
>                 list_del(&pd->dev.devres_head);
>                 memset(&pd->dev.devres_head, 0, sizeof(pd->dev.devres_head));
>         }
> -
> -       return 0;
>  }
> -/*
> - * This must happen once after all early devices are probed but before probing
> - * real platform devices.
> - */
> -subsys_initcall(sh_early_platform_cleanup);
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 7c532548b0a6..3ba153e356ee 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -1325,10 +1325,14 @@ struct device *platform_find_device_by_driver(struct device *start,
>  }
>  EXPORT_SYMBOL_GPL(platform_find_device_by_driver);
>
> +void __weak early_platform_cleanup(void) { }

... and this one, too.

Sorry for failing to notice that before.
Back to fixing more SH...

> +
>  int __init platform_bus_init(void)
>  {
>         int error;
>
> +       early_platform_cleanup();
> +
>         error = device_register(&platform_bus);
>         if (error) {
>                 put_device(&platform_bus);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
