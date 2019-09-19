Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967A2C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 14:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C1F320882
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 14:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="z+2qSOa3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389503AbfISOQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 10:16:50 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43688 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388712AbfISOQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 10:16:50 -0400
Received: by mail-oi1-f195.google.com with SMTP id t84so2806238oih.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 07:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qaeMCYjZPRaH9Ju9SgkSov7Ze/8oIWs13QEihdDThJ8=;
        b=z+2qSOa3cyfelEyS2Tc7A9vemu+IwUiJQqeEP2gEj3gSL1xNk+m7ZN8QluhyS5bXfA
         I8vH6Zhm8sg5ohv6KRmQicpAHf95W+eBHjtmirVWhc7uSQIokMbjxkyHSipMh+zJ7uav
         g3TZR0TxEX1iedciFW5eFGEwtEFlpF1n2VMEW4f+MlUH334eb9jav1XI8ouU3mpXzrwJ
         W+3gCxXBF47XY2HQON0XxJLnNkHzgQTsmW5j4rTpDTRpowEFjPSV9LxZ3YwN8n658w/r
         t780vK5wrh8QDRjJNbdN63IJzBv1Rh2ItXdhYnVdXxlC0VmaJ+7QAzBMBvenefk5pMU+
         YvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qaeMCYjZPRaH9Ju9SgkSov7Ze/8oIWs13QEihdDThJ8=;
        b=ArFaUDxKh8X2gdZZ/5wOS89D60SBzauGWwSTvtrNxQVxOjsJRHlBPzwxL7/jeC37Zf
         7Y4Kb2acu6b5ABE5u9kK9JHSlHkuVZsTZFZtShU0SvP2r0bFRU329xK3m8qc2zmMJHeU
         m9pUwEdFPp8b32FqZZ64v6ikxzwUPvls9JQ9S+cwAP83G7j3rJKuUMKX8dF5oq3RbabI
         DTdnUH8Y94J8PWbifkzYg3g7mXO/VYRfYxeHYjr9wQLkTeq6NGeyfpxaDITZbLH039NT
         M92xa9IRNVbaoJDjfF8EMX09U5w2joX6rfU6ANgD2ZKBXjiqWP2XGrdu2gnokCOopu5/
         JAUg==
X-Gm-Message-State: APjAAAVWR/lFiA7lssL3GJwPoMo/JyCo8Zr9W34q197anZxizDsMnuRA
        jnb59DlVYJRgLsUC97Ult12ozOIKB95JV/fvvbXMKw==
X-Google-Smtp-Source: APXvYqwXltbLynYwpGAPcFo116M4pb5TeU6PcSlbflTdA2waTF273hEyMScZ1wWzwpDkltR4r+LG+7VVFEkP7Odi6Ik=
X-Received: by 2002:aca:ad09:: with SMTP id w9mr2447606oie.114.1568902609135;
 Thu, 19 Sep 2019 07:16:49 -0700 (PDT)
MIME-Version: 1.0
References: <1568885957-2968-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1568885957-2968-1-git-send-email-Anson.Huang@nxp.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 19 Sep 2019 16:16:38 +0200
Message-ID: <CAMpxmJW1Z2WAAcCByPM=MS+PZdo-xxBjsVraHdnftwx-WzRA_A@mail.gmail.com>
Subject: Re: [PATCH V2] gpio: mxc: Only getting second IRQ when there is more
 than one IRQ
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

czw., 19 wrz 2019 o 11:40 Anson Huang <Anson.Huang@nxp.com> napisa=C5=82(a)=
:
>
> On some of i.MX SoCs like i.MX8QXP, there is ONLY one IRQ for each
> GPIO bank, so it is better to check the IRQ count before getting
> second IRQ to avoid below error message during probe:
>
> [    1.070908] gpio-mxc 5d080000.gpio: IRQ index 1 not found
> [    1.077420] gpio-mxc 5d090000.gpio: IRQ index 1 not found
> [    1.083766] gpio-mxc 5d0a0000.gpio: IRQ index 1 not found
> [    1.090122] gpio-mxc 5d0b0000.gpio: IRQ index 1 not found
> [    1.096470] gpio-mxc 5d0c0000.gpio: IRQ index 1 not found
> [    1.102804] gpio-mxc 5d0d0000.gpio: IRQ index 1 not found
> [    1.109144] gpio-mxc 5d0e0000.gpio: IRQ index 1 not found
> [    1.115475] gpio-mxc 5d0f0000.gpio: IRQ index 1 not found
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V1:
>         - use local variable irq_count instead or err to avoid confusion.
> ---
>  drivers/gpio/gpio-mxc.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
> index 7907a87..c77d474 100644
> --- a/drivers/gpio/gpio-mxc.c
> +++ b/drivers/gpio/gpio-mxc.c
> @@ -411,6 +411,7 @@ static int mxc_gpio_probe(struct platform_device *pde=
v)
>  {
>         struct device_node *np =3D pdev->dev.of_node;
>         struct mxc_gpio_port *port;
> +       int irq_count;
>         int irq_base;
>         int err;
>
> @@ -426,9 +427,15 @@ static int mxc_gpio_probe(struct platform_device *pd=
ev)
>         if (IS_ERR(port->base))
>                 return PTR_ERR(port->base);
>
> -       port->irq_high =3D platform_get_irq(pdev, 1);
> -       if (port->irq_high < 0)
> -               port->irq_high =3D 0;
> +       irq_count =3D platform_irq_count(pdev);
> +       if (irq_count < 0)
> +               return irq_count;
> +
> +       if (irq_count > 1) {
> +               port->irq_high =3D platform_get_irq(pdev, 1);
> +               if (port->irq_high < 0)
> +                       port->irq_high =3D 0;
> +       }
>
>         port->irq =3D platform_get_irq(pdev, 0);
>         if (port->irq < 0)
> --
> 2.7.4
>

Applied, thanks.

Bart
