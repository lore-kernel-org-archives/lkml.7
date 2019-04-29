Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA70C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 07:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB37B2087B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 07:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Qx62XkIJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfD2Hxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 03:53:30 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33396 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbfD2Hxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 03:53:30 -0400
Received: by mail-oi1-f193.google.com with SMTP id l1so5721365oib.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 00:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lTE8ZUe/zLng+ZlAw7wli/wZIDmLwzaqTDPEWlKoyEA=;
        b=Qx62XkIJWMVhX1tTSZWgOrwz8HqepXlV4Z8D/gGYVWMMi3Fr7nKK6+vdKy+/pkZKQR
         +V9oTnF1Ly8xgazFAj7rw9JQYl/fZrD2f9Tp86WViZB2TPAp3ng40jFlm9coh/XWAF0u
         DrSvLYAd0KRFq7iMmeut7Hb5l52C2Zkg70OSuASvoSBQHh2TjoQeD2ieWNAHaLtf2HHu
         ytdoE8LdVTQ6oRu/1CuQeHRRtoiI3gsBuf5wTuZGmtRVTCin7OvAvRvYBxdxCISdByDa
         38oNq9pBe+IBCUUuNxTQ7S63ChjAVZ148iac6aVUHuBuz8kEkRvvajvtAGU5Fut5OmJ2
         iLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lTE8ZUe/zLng+ZlAw7wli/wZIDmLwzaqTDPEWlKoyEA=;
        b=Ps62lKCARRK7DdtLtGPZ8C3mTlprYn3o5UvIQH63hcutYiqKtwTl1VFmHbUiYiCSyY
         NkT65ATjR8DIqZX8SzMHG74+2ujk3mHiA8boNuT1bbUrAwNU94j5fia5AjBkv9iY5mRf
         CIMZnvdqHJwVUv+aGQHua21djfF2Nh5c3Zob6u/XMjuar3xFquKEBv24Y3bphwrZHkh+
         dYE6fcl7b/qcP4d4HcDGFOvSafZ87JHkloHxrg0IzfrwD2CHzgTde3HUrNjEw3uR3AIV
         Cz6hd+SoFqhszpeDg44F3addl3NXlOYZw2PzQgp4g++ItNbVlt6fUKfTjUtaeydSrnz5
         piLw==
X-Gm-Message-State: APjAAAUBrf55nyNL8VR1QU0K/PNoYx6rNsf1rqS4OmKzDf7g97AFTuYb
        MKAuYfDHIGwzQ/HbNAhe3VBRplKJDgL/qlSsYoJxxw==
X-Google-Smtp-Source: APXvYqyY1pL6kRZdPE6htYzE5BsCHj0A4NAoBg0naE/rczUfA/B7jwsFBoqxIDeKMTkoBUnW2oqw9qHLa5Is1D2s+uE=
X-Received: by 2002:aca:f2c2:: with SMTP id q185mr9556506oih.147.1556524409451;
 Mon, 29 Apr 2019 00:53:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190429054948.9185-1-andrew.smirnov@gmail.com>
In-Reply-To: <20190429054948.9185-1-andrew.smirnov@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 29 Apr 2019 09:53:18 +0200
Message-ID: <CAMpxmJVe2C1RSHq0xVDSdNEK0S06e2Q=tp5k5QJXdCTG2DzJbQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: vf610: Use devm_platform_ioremap_resource()
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chris Healy <cphealy@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 29 kwi 2019 o 07:50 Andrey Smirnov <andrew.smirnov@gmail.com> napisa=
=C5=82(a):
>
> Replace calls to platform_get_resource() and devm_ioremap_resource()
> with newly added devm_platform_ioremap_resource() for brevity. No
> functional change intended.
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/gpio/gpio-vf610.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
> index 6f6558715b88..30aef41e3b7e 100644
> --- a/drivers/gpio/gpio-vf610.c
> +++ b/drivers/gpio/gpio-vf610.c
> @@ -242,7 +242,6 @@ static int vf610_gpio_probe(struct platform_device *p=
dev)
>         struct device *dev =3D &pdev->dev;
>         struct device_node *np =3D dev->of_node;
>         struct vf610_gpio_port *port;
> -       struct resource *iores;
>         struct gpio_chip *gc;
>         struct irq_chip *ic;
>         int i;
> @@ -253,13 +252,11 @@ static int vf610_gpio_probe(struct platform_device =
*pdev)
>                 return -ENOMEM;
>
>         port->sdata =3D of_device_get_match_data(dev);
> -       iores =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       port->base =3D devm_ioremap_resource(dev, iores);
> +       port->base =3D devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(port->base))
>                 return PTR_ERR(port->base);
>
> -       iores =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -       port->gpio_base =3D devm_ioremap_resource(dev, iores);
> +       port->gpio_base =3D devm_platform_ioremap_resource(pdev, 1);
>         if (IS_ERR(port->gpio_base))
>                 return PTR_ERR(port->gpio_base);
>
> --
> 2.20.1
>

Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
