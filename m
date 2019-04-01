Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536DDC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150CD20828
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="cUX1DF/t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732014AbfDAII0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:08:26 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44107 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfDAIIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:08:25 -0400
Received: by mail-ot1-f67.google.com with SMTP id d24so7687667otl.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 01:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aGpLH0jnZGOCZ2iVQFE0tEUQhm4JpKAfaUCfb6GRHGM=;
        b=cUX1DF/tSl7jFC20RlrfsSdyAV/r5dPhBonQhuUQbgtG/KUprsPbdCLYNeWMKv6NDY
         hhm4JpxiMs02as2Z2l6UlNBHIeu7QurhHAUkWBID29uRO5VXsLNjvcPGrE78QqT7HMME
         Ihj8qGCTThm1KnQm+U5dOWBTfVbdpFlSe5IOHiQbJh63TGPmMuxYVxh7klFd19p8gwQ5
         Ux9KSAiihuZB6LdClco80iugA8jEHjJ9Kzj9qF7Aqd6TBTQsS7czWjD9/rpRp6l1pENj
         N/1Wxy4N10kwgEYSkovmMhSAG6uPKyBQfZEqnD1nTFPFqMbjNv0YfFDCH2Aji0Zx/vQc
         9p9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aGpLH0jnZGOCZ2iVQFE0tEUQhm4JpKAfaUCfb6GRHGM=;
        b=MnywvsrJX8WrZ7PV+lTFmxAMkaP/It4FXzetVx0ozKQtVkoNmHfq/zk0w3F+Pw6W1E
         MfRdiZFWuqRMWEugILJQIo40k2WtYMSYPSjzr5cpK1W3LGUr6xyYemyjpyP1RXWGChPB
         xAZkzOaco5dAxBe+sjSwc8TYmBWwJw09RrZflvBuOUAol9H+RyyuJ9Bg7OdBo4cVnrii
         iOrFcLtfNI6TXk74lTgSe87Z8WEqWm841xctLLaicCBl/FbM8sKvE67HplKivq/6rVLG
         R1AZiIwWI3m2CcOJTh5K4x3yZ0B1s2xX5oPYENZNl3aVHwuFOMcH0vz37DgoIHf8V9gL
         Qn5A==
X-Gm-Message-State: APjAAAXeJKfCfM6d4SOQUEezhVOCUn0sXwehfG6pXGhsQGbAbT0HOxsL
        U9I/WTNxUgAy2ZYcmvP2N8OpNCYNQI0HS/lKmCB64w==
X-Google-Smtp-Source: APXvYqwSsB3u7Y1ptl8Npr2k39TGO5gVodVbwA3BgbZb5fF9jdjrF8UUIJa7ps6nFZpcXzurOSvFfKnX6jCIy5sIrrI=
X-Received: by 2002:a9d:3635:: with SMTP id w50mr41678392otb.301.1554106104997;
 Mon, 01 Apr 2019 01:08:24 -0700 (PDT)
MIME-Version: 1.0
References: <1554095107-15003-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1554095107-15003-1-git-send-email-Anson.Huang@nxp.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 1 Apr 2019 10:08:13 +0200
Message-ID: <CAMpxmJUgyP59dkZYessbjvNV=vSH+xEkHz+KD++d6Gq-wX5VwA@mail.gmail.com>
Subject: Re: [PATCH] gpio: mxc: use devm_platform_ioremap_resource() to
 simplify code
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 1 kwi 2019 o 07:09 Anson Huang <anson.huang@nxp.com> napisa=C5=82(a):
>
> Use the new helper devm_platform_ioremap_resource() which wraps the
> platform_get_resource() and devm_ioremap_resource() together, to
> simplify the code.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/gpio/gpio-mxc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
> index e86e61d..b281358 100644
> --- a/drivers/gpio/gpio-mxc.c
> +++ b/drivers/gpio/gpio-mxc.c
> @@ -411,7 +411,6 @@ static int mxc_gpio_probe(struct platform_device *pde=
v)
>  {
>         struct device_node *np =3D pdev->dev.of_node;
>         struct mxc_gpio_port *port;
> -       struct resource *iores;
>         int irq_base;
>         int err;
>
> @@ -423,8 +422,7 @@ static int mxc_gpio_probe(struct platform_device *pde=
v)
>
>         port->dev =3D &pdev->dev;
>
> -       iores =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       port->base =3D devm_ioremap_resource(&pdev->dev, iores);
> +       port->base =3D devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(port->base))
>                 return PTR_ERR(port->base);
>
> --
> 2.7.4
>

Patch is trivial, so applied right away. Thanks!

Bart
