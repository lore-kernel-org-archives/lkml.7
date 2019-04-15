Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F18DC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FAB720693
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rdlpL/P1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfDOMix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:38:53 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33026 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbfDOMix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:38:53 -0400
Received: by mail-pg1-f196.google.com with SMTP id k19so8538138pgh.0;
        Mon, 15 Apr 2019 05:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u2LVb7yT1wSOGDuoxT6KUq9UtfEF1iBOjVOoHUZS5kE=;
        b=rdlpL/P1fjH901/sBu8VQ/Ss2OGSB1r7vpTBPEDhlLUoqHv+VAf5p3MHwbrLJiS0vj
         QSq4zoxO6axAD1OcKFOieO3yw1SEBPmq02Y2Zs1NlMq9iRQHG6XJULqFixihJ7tRoGeA
         UIQwxSiSNZppYFDUoK9tj687SaFxh2l4tn3sP0+Ep//go4bjpgTQVmZnIdF1+jBUic6t
         1uvO+XI6HRkOpH9fIOihnHDSs9fp4AJMiRk8srU8C+2U5LjMI+I5UYGQ71wCVREvcjya
         zW0a1ZB04CHhphcwQmag6MbKQlR6Ff90re7BPAV2+5Chfb1KkgQCBv2yJ2b2AYsvAW3J
         zdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u2LVb7yT1wSOGDuoxT6KUq9UtfEF1iBOjVOoHUZS5kE=;
        b=lELWxdVi4dQwGauiRAJcomhQ0vopE+FHS9HoV3dLNWcO4jzTCd85hya0t838EU1YBB
         k4wPYy+R9yDddFBdoymgcurcdPTWVANvXDPQIldj+9+GO9i6hHsaSX2yidbXWxe/0y3s
         nUnpyjVtQrpGTy0uPtm12u5WTlaeSnbYj6U019/4sz2VovUurhMKZQVU8I81hjZ2pDSs
         ia1HNT03lNz9Z+de7dV7nRNqdLy5obFm0WPBgU7diD/2VlPZ2PIcI0DVzRFMu5UE5i09
         xnEJYYvyF87Lin3/0I5YfsuSyzZcfIESQ7gY5NquuTH4WPN/UbZthVZ27jfoB2JY+Z+g
         kyxg==
X-Gm-Message-State: APjAAAVnWn93e1XMd5gEXYqVRN71w8cCUL7mfl7aQAx2LuX4Abh2uf9l
        ub+j3KQZKqyD3ptSJIzPyr/FUMxcn/vVFO9y1dY=
X-Google-Smtp-Source: APXvYqwl90IRvvcYFnqEGB0t3IS3p4I5F3IDwV586IqSXuflvFDScbnWeExZkK+0qo+lMMbR93yD9fDHnk4pjtskXu8=
X-Received: by 2002:a62:448d:: with SMTP id m13mr75712858pfi.182.1555331932449;
 Mon, 15 Apr 2019 05:38:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190403124019.8947-1-wsa+renesas@sang-engineering.com> <20190403124019.8947-13-wsa+renesas@sang-engineering.com>
In-Reply-To: <20190403124019.8947-13-wsa+renesas@sang-engineering.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 15 Apr 2019 15:38:41 +0300
Message-ID: <CAHp75Vfh05KuXLrU+eVeBSFonBHQAemf8iyWFsRk4Oww-HbEvw@mail.gmail.com>
Subject: Re: [PATCH 12/12] i2c: gpio: flag atomic capability if possible
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c <linux-i2c@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Peter Rosin <peda@axentia.se>,
        Stefan Lengfeld <contact@stefanchrist.eu>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 3, 2019 at 3:42 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> If switching GPIOs does not sleep, then we can support atomic transfers.
>

Reviewed-by Andy Shevchenko <andriy.shevchenko@linux.intel.com>


> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/i2c/busses/i2c-gpio.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
> index bba5c4627de3..9684a0ac2a6d 100644
> --- a/drivers/i2c/busses/i2c-gpio.c
> +++ b/drivers/i2c/busses/i2c-gpio.c
> @@ -413,6 +413,8 @@ static int i2c_gpio_probe(struct platform_device *pdev)
>
>         if (gpiod_cansleep(priv->sda) || gpiod_cansleep(priv->scl))
>                 dev_warn(dev, "Slow GPIO pins might wreak havoc into I2C/SMBus bus timing");
> +       else
> +               bit_data->can_do_atomic = true;
>
>         bit_data->setsda = i2c_gpio_setsda_val;
>         bit_data->setscl = i2c_gpio_setscl_val;
> --
> 2.11.0
>


-- 
With Best Regards,
Andy Shevchenko
