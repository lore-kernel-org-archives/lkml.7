Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C93C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 07:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F752086A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 07:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="no2YBNHW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389341AbfHBHHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 03:07:10 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41298 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388184AbfHBHHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 03:07:10 -0400
Received: by mail-ot1-f66.google.com with SMTP id o101so77103562ota.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 00:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RK+20dzJviISNV+93NqcQswZxg+GA6BYaDL2+ThvHdo=;
        b=no2YBNHW/GBW+3zkl06td4ZCgKjOAclq31zEfcew3umEuTOHp+y3OkHj0zTVM7aidw
         KdmGFIJwKTrVJjKKmBPgtwqN/fjYzBiAum5/8x6lGM5DKiHPLhAoGYnwuD08sLd3DlXa
         c8tQor2wpWzik/ma0YaljlGnHaFElfvNCS3AM/5uaNAv9RnNG1/Py2U2iEtiTKSqU+fw
         c+ndr6PvcF98I5p1rfZgrZjVhuC1wYHtmSHU1/xR0wlECKO5NRZ+zDMejW2TnPHxrT9O
         w33Ymg9gztLH/rncYfEBsciVUElBQO4iISkC7hrLYbE0t2yINQYV+GoPs4AZv7l6jgrx
         KPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RK+20dzJviISNV+93NqcQswZxg+GA6BYaDL2+ThvHdo=;
        b=P6Lfbuu4UTlCTPskK/YdvogqGiOkT3Iiby+TFAZLBhQSXPm3V8xzJwm/CqnLjFefEB
         JAWIv4+HkTa1XJFyJ/PaowoVMJ6ypNQI3hTItsdRUfeOTMc5vQGE1x3H63URu7gpQSwm
         G9qbCI7h1wKmdHjSoEKwIEOS7mY4yn3wjc2Fppd2wFS32lp1NOjaKGGh4xhyE83E8rNW
         7Ul5iZ2mKTXBFTySNbjyiOhWomFtCP+Mf7ujMcGFKd3H734EColR/mxBu5qxrn/NmpBJ
         qLqnnxxduzoRRf+z2Tu6ct3+fdW7sB7+TUpp96kWwHSRjhgwIrRLTEr71sUgRYUg9ev5
         uE8Q==
X-Gm-Message-State: APjAAAU2nFuMUksJsUEv0Av6njKyglYCGI0A0SPQfYPiECTHW0+roWz1
        qADvhn5Ds9GYMq7WwjfDTDXEUu9gFxMDlQoztonU3g==
X-Google-Smtp-Source: APXvYqymEusuGsezVVEUq4vGKp+HswJHP14eULqqS4ucpm/aZEmphlSBMb3viH2nKCJEE61bSr1aBGJCJKKpV85tJXY=
X-Received: by 2002:a9d:7352:: with SMTP id l18mr37650695otk.292.1564729629450;
 Fri, 02 Aug 2019 00:07:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190801084439.36487-1-Anson.Huang@nxp.com>
In-Reply-To: <20190801084439.36487-1-Anson.Huang@nxp.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 2 Aug 2019 09:06:57 +0200
Message-ID: <CAMpxmJWdVx_guOGCb6aNoUmG_JBqWGui-qZmUCOuunOkxzTPFQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: mxc: Use devm_clk_get_optional instead of devm_clk_get
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dl-linux-imx <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 1 sie 2019 o 10:54 <Anson.Huang@nxp.com> napisa=C5=82(a):
>
> From: Anson Huang <Anson.Huang@nxp.com>
>
> i.MX SoC's GPIO clock is optional, so it is better to use
> devm_clk_get_optional instead of devm_clk_get.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/gpio/gpio-mxc.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
> index b281358..7907a87 100644
> --- a/drivers/gpio/gpio-mxc.c
> +++ b/drivers/gpio/gpio-mxc.c
> @@ -435,12 +435,9 @@ static int mxc_gpio_probe(struct platform_device *pd=
ev)
>                 return port->irq;
>
>         /* the controller clock is optional */
> -       port->clk =3D devm_clk_get(&pdev->dev, NULL);
> -       if (IS_ERR(port->clk)) {
> -               if (PTR_ERR(port->clk) =3D=3D -EPROBE_DEFER)
> -                       return -EPROBE_DEFER;
> -               port->clk =3D NULL;
> -       }
> +       port->clk =3D devm_clk_get_optional(&pdev->dev, NULL);
> +       if (IS_ERR(port->clk))
> +               return PTR_ERR(port->clk);
>
>         err =3D clk_prepare_enable(port->clk);
>         if (err) {
> --
> 2.7.4
>

Patch applied, thanks!

Bart
