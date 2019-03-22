Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B53C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A083F21900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="DozC8ZIx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbfCVPzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:55:44 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:36057 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbfCVPzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:55:44 -0400
Received: by mail-it1-f195.google.com with SMTP id h9so4043690itl.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 08:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kuNFebrvuvhDNkeq1URNY0PxqLf0kAGYrm5ttz6CLZs=;
        b=DozC8ZIxnNU6BelTWIc8plKoXTmrpucWCr9bvoXZqUjqom7tBpgHr5qwt7CH3ACcnt
         6yX6yS2bGG14nFijakxxXZvYSVi9aXfRgkQ6UwRPvvGlwgoakdQC9sGvB44a8ceeYXh2
         tnwyftrC42wAPnHxusgI6h4dEC5u9ku1+GWD+/Y1iAOxWGX4bxAqiIkYyLYD7dMaNTfu
         VkC/hHQGnjX7Me7Ii3R4XcMbDrXTTn1jqu43rvqmXmuivVS1b1Ts5dLYWQ9+BneWLgPW
         jVwBFc1XJfAdzLuRtwdk+ChZfDkzEVn9Hf8TSMZW0Mh9eTSt/jhjYsfFQvb9ou6GX3eE
         KmLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kuNFebrvuvhDNkeq1URNY0PxqLf0kAGYrm5ttz6CLZs=;
        b=mTBPvKUDLD+rFqf8mwBE3irGxBdXR2yLhYx/VNfTD1GgAd6mixIazsNqa0hXZD+pOR
         XxqlrJpZLnR8aMBJlxourml9N1jRwd6BwwxknCW9u3MDkXZUGiRxvSjJtOCj9U9oa4o2
         y9dBehtiVHwKf6GC2nRdIDfvUaHEKrj/ptugK1RV1el6565gRczrEX+kUl4S3md6UjdV
         +RQ8xQwJSjv9aSyVxhNpQyNHsZMrSxJft8LjXbQlD9rM/O/eXg/97DYk3VeiZ7b5qjhP
         o/QGAjM8tg9QgyJVypz/DgX5oAkNH0vgFcoaCGdpqf6yks6axOaCwWPAeP5DNyTExGRB
         YHiw==
X-Gm-Message-State: APjAAAXaQChIEFQgXbHRD2rEqZOBNjwBRthrXYGnK6o+SugnwxIrt30z
        3V4cJXjSfT2fvjqBiK2grAfdfok6TwkF5zlC3LQj8Q==
X-Google-Smtp-Source: APXvYqwjRi4hwSelfPVgen4leNuimiHrRaQS0snHR0t2oEitK83Wl9PvMfwgri+A9jaFN4G3wojEYDE+zQsuAyxMV0g=
X-Received: by 2002:a24:3d8f:: with SMTP id n137mr2005791itn.96.1553270143137;
 Fri, 22 Mar 2019 08:55:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190314150750.9371-1-brgl@bgdev.pl>
In-Reply-To: <20190314150750.9371-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 22 Mar 2019 16:55:32 +0100
Message-ID: <CAMRc=MfeJSN9Nza4rMmaA6eARUzUvq46YEmq4+GhVxjYSiuorQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: mockup: drop unneeded dependencies from Kconfig
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 14 mar 2019 o 16:08 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=82(=
a):
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> The testing module doesn't need GPIO irqchip nor does it depend on
> sysfs. Remove unnecessary dependencies from Kconfig.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/gpio/Kconfig | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 3f50526a771f..e9473e968d9a 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -332,9 +332,7 @@ config GPIO_MM_LANTIQ
>
>  config GPIO_MOCKUP
>         tristate "GPIO Testing Driver"
> -       depends on GPIOLIB && SYSFS
> -       select GPIO_SYSFS
> -       select GPIOLIB_IRQCHIP
> +       depends on GPIOLIB
>         select IRQ_SIM
>         help
>           This enables GPIO Testing driver, which provides a way to test =
GPIO
> --
> 2.20.1
>

Both applied to for-next.

Bart
