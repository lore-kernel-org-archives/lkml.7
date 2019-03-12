Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6110C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BF0B2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="x8+JA5GC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfCLNpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 09:45:14 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34227 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfCLNpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 09:45:14 -0400
Received: by mail-ot1-f66.google.com with SMTP id r19so2524600otn.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 06:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7tCQ4cCXOyvwuYzH7M5bEOmVDuY2wMmX5oUwXlTGw0k=;
        b=x8+JA5GCWKmesTtncgXxYdRADk2orsN/HoHyKaKJ4eA1ZKbR/Ja/VoC6z3UmXIm//5
         o8P2gpaSENFD85BDDcuGcFm1hGbwGxaEHilQyXLvRVI1EEMfek8eusQFABOf2ABAtxNr
         Sm7Xv+4Ts66Ye/w0/iCHUAs3DVQ8r0ytU2BpvITeJaQKzFohhXtkNDuCoB/8ovPbOksl
         y3VcPhennx/5s83X1TWE+juqyiUK+Z3AZi7TtJMUBY62Z7gYB4nTvK+5EVnmSdowaFMA
         r7j4/GBjMHIxOzAWoa9I33jeARF+4ou/GuhVYc/3Qg8ojhbVoqQLyM0bzwM91s56KCaa
         C5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7tCQ4cCXOyvwuYzH7M5bEOmVDuY2wMmX5oUwXlTGw0k=;
        b=c4NAYHPRv1UWmPOyiM2s5MkmZDZXRrwfG5Oysu+nqYqI6K1eZIqTvjUxCaN1fesSba
         1khK8HzI0ONQ2NC+JDZ9F3OaOecilpRM6MJTygu7ZqzZ+rMor9SGkvOdYmd9bRrDSObV
         PsNTmrHRPpsl6D+2AIXnr63QenBYtTTfjs5NBxGB/J+rIewzGe+5FsqTQIgF+Xx6i7xy
         AOhqdHXQljyOmOuH2vYp0GsmaRGC0IDvowKTvwKwozpoyt2oMcmTGHQuwK7jc9b+ZIxd
         TRUkKm35KqBD8U2H7mwuHcj/CXGaBjmpf8eDVt7couDSHMsZqJ8LZappTCXaTzVn6+Su
         6QRg==
X-Gm-Message-State: APjAAAVsoGPpC8igug9YfuayOWf/R9fQZcwCy+NL7kvhlOGcILWRZCSo
        HFx2mGO/UYW9r9L3WTpbfBlw02Ccfq5QUgh7Q/XuUw==
X-Google-Smtp-Source: APXvYqzZKjYYJt2P9auk/7hDbivJePBrkNATC7s7t1riXLX5O1tpAVlcBocPNcfMSBk2PInGnSXaA0kkXZyguIRKbW8=
X-Received: by 2002:a9d:65c2:: with SMTP id z2mr22424809oth.301.1552398313120;
 Tue, 12 Mar 2019 06:45:13 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-23-git-send-email-info@metux.net> <1552333701-22712-1-git-send-email-info@metux.net>
In-Reply-To: <1552333701-22712-1-git-send-email-info@metux.net>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 12 Mar 2019 14:45:01 +0100
Message-ID: <CAMpxmJWCpfm0E15k0vAcxOKFTGdaFkmqK-VXD+orVE65H1Uk2g@mail.gmail.com>
Subject: Re: [PATCH] drivers: gpio: octeon: use devm_platform_ioremap_resource()
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 11 mar 2019 o 20:48 Enrico Weigelt, metux IT consult
<info@metux.net> napisa=C5=82(a):
>
> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  drivers/gpio/gpio-octeon.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpio/gpio-octeon.c b/drivers/gpio/gpio-octeon.c
> index 1b19c88..afb0e8a 100644
> --- a/drivers/gpio/gpio-octeon.c
> +++ b/drivers/gpio/gpio-octeon.c
> @@ -82,7 +82,6 @@ static int octeon_gpio_probe(struct platform_device *pd=
ev)
>  {
>         struct octeon_gpio *gpio;
>         struct gpio_chip *chip;
> -       struct resource *res_mem;
>         void __iomem *reg_base;
>         int err =3D 0;
>
> @@ -91,8 +90,7 @@ static int octeon_gpio_probe(struct platform_device *pd=
ev)
>                 return -ENOMEM;
>         chip =3D &gpio->chip;
>
> -       res_mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       reg_base =3D devm_ioremap_resource(&pdev->dev, res_mem);
> +       reg_base =3D devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(reg_base))
>                 return PTR_ERR(reg_base);
>
> --
> 1.9.1
>

Can you make this a part of the bigger series and resend together with
subject line fixes?

Also: maybe consider adding a coccinelle script for that. When I added
that function I noticed there are 1200+ instances in the kernel that
need fixing. I think we'll be better off automating it.

Bart
