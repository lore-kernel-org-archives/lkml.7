Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31BCC4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 14:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A981214D9
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 14:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="QLlMUHsy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436894AbfIYO0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 10:26:08 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:45266 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727775AbfIYO0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 10:26:07 -0400
Received: by mail-vk1-f195.google.com with SMTP id u192so642180vkb.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 07:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KExLbRsWWdPJsnH8bWIgRX1rh2usgvEjHrntBDpiVfQ=;
        b=QLlMUHsyDnd1j2CjnjpAE1eW4QYRhi5HeYN+Iw3SYZeZVvx5xLoFqKRU9yAPN7JxJh
         zvOjWoZZx95Dcnt7EOYc+Iug732Ed/91u0nklQRdOhfGDdCxHQWdjsgy7afc81haGUWa
         hRCt0MuhkIUsGxLO1xZlGsBbcn3cM4abpMr2sQbnb42mVHCNStm8FMePwmTQkmklrcL3
         vZ6n8Gtg9b6dsSnxeT1rkNqz3/UxGqUVxkzsTUnLwRMgKYC4aAvx1BvzIk4XeDBcbFFw
         lGXxR+8P7lfj5u63RAunafFF7p47dCqn/bWULcODSxyNiZ+HwQESM+s3O9/SduZM8Kxy
         5HuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KExLbRsWWdPJsnH8bWIgRX1rh2usgvEjHrntBDpiVfQ=;
        b=QyS4xYpRJ9thUE0HSu3Aoc0ufkoV+p33UDiJcvCNB1uCBLfIdYxzDk40EdVsO3RB+T
         yVr3mue1QB/m2iNYNsIUvXYzn8HWOgf2YyHXXyl9PeZkiacxwsQnsuaYApMnQUqXGmQK
         WPBuQapS+xkqkK+aTCCBymQY3/JlBRpiZaE/R8KBruvFrD+NLrnIreXAAPALVxbX3Qhw
         UnAVFamDbV4UzfWF78CfgJT7SvEDqxbfKeBlISfMzXUEU/3zv+o6I6OhIKgIEyG6q5n6
         gOqhDZ9ZNSFx7BniFBxLI9i/x0ay5cZGEcvjRsUclHvmGWwQulrAlkr61BU7rDlAXuhz
         vgAA==
X-Gm-Message-State: APjAAAWY8sekDuKropjqgFKOxIfIqslpjQAtoY1FhAOKN5MFAhPvQUWq
        1MlH535yUMlltD1RSBKxJZ67K+ydaNrjgJyPPjIRPA==
X-Google-Smtp-Source: APXvYqzGhoJpw7mxlMBhe3QOzlZ1DLZ8DVq7bG68xo8A7/FbgrR8bGCceM1K0y1gdVvTojaWCrWYtpk7WDFmxksLlJI=
X-Received: by 2002:ac5:cd4a:: with SMTP id n10mr2575096vkm.82.1569421566287;
 Wed, 25 Sep 2019 07:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <27c67867-d39e-a5c1-12aa-a1e6ba6e7c32@web.de>
In-Reply-To: <27c67867-d39e-a5c1-12aa-a1e6ba6e7c32@web.de>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Wed, 25 Sep 2019 07:25:53 -0700
Message-ID: <CAHLCerNQ4G43O0PM71V6tFSS11oxAGNJEkR0A44CCgRjWfgaag@mail.gmail.com>
Subject: Re: [PATCH] thermal: st: Use devm_platform_ioremap_resource() in st_mmap_regmap_init()
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Allison Randal <allison@lohutok.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Himanshu Jha <himanshujha199640@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 12:43 PM Markus Elfring <Markus.Elfring@web.de> wrote:
>
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 18 Sep 2019 21:32:14 +0200
>
> Simplify this function implementation by using a known wrapper function.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  drivers/thermal/st/st_thermal_memmap.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/drivers/thermal/st/st_thermal_memmap.c b/drivers/thermal/st/st_thermal_memmap.c
> index a824b78dabf8..d8ff46abd8eb 100644
> --- a/drivers/thermal/st/st_thermal_memmap.c
> +++ b/drivers/thermal/st/st_thermal_memmap.c
> @@ -121,15 +121,8 @@ static int st_mmap_regmap_init(struct st_thermal_sensor *sensor)
>  {
>         struct device *dev = sensor->dev;
>         struct platform_device *pdev = to_platform_device(dev);
> -       struct resource *res;
>
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       if (!res) {
> -               dev_err(dev, "no memory resources defined\n");
> -               return -ENODEV;
> -       }
> -
> -       sensor->mmio_base = devm_ioremap_resource(dev, res);
> +       sensor->mmio_base = devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(sensor->mmio_base)) {
>                 dev_err(dev, "failed to remap IO\n");
>                 return PTR_ERR(sensor->mmio_base);
> --
> 2.23.0
>
