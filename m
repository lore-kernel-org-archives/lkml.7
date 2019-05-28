Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353E2C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E97ED216F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="MTfPdb6p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfE1PxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 11:53:11 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:38099 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfE1PxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 11:53:10 -0400
Received: by mail-it1-f195.google.com with SMTP id i63so4685906ita.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 08:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3yVdiZtGBSBGlDhvB9DOUwLNsyFEwKkKgPF73cZCVKg=;
        b=MTfPdb6pXHJ22ny1QjP9IcsZ6jIajezQz03fP5a1+DhtEyj+LcZNfl/lerD7qIvYSP
         +NTBFf/Oz1bqFosS83DKD81vdhlUu6Rgz1Jik50pMX4R+86cQIxxiG0mf29lJkOTPxYD
         WglGBl4seph3kXUxws4K9NyQ6xiI8px0/QdkWEZBKd/VQnXdxx7NOYg0Briq8ndmGs6U
         R8mic1lvMYtU8tN53jRHbJsyJrRaR6nbiMZMOCloJwaNIZ1hU/yIeJEHNPqRl6XnuNKx
         aUxLBsFYdoY/tJjkAM/Zl7O+UBoU+k7pIM8n16Po6XAeH2FYQucT/1aGU5rcAtkEYkkL
         FnVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3yVdiZtGBSBGlDhvB9DOUwLNsyFEwKkKgPF73cZCVKg=;
        b=Jh1AD4Bn8NKYO8ASEvFNWWfuEULYET5BklxNGfu9kQCCH3SqUnaBlMLqbkgaf3ptwK
         i4Esvr5JkH95VcHMYHjwJyhlptDracNb2O40UhlTq5Ng07GN2eIuWCepS0UbX2bVhD0C
         TRU6/u8Dj4QKsGV//I4gNIxvTj99ciq++r70MEsnsVByUph7eH11dtRzCCBFOrsswzGJ
         /UqVsXyyQjb3puk/ugxAeEZPQ9Y/s1f61ClKhF4YAYp59Ok8v0aaAyAOsO3faGHX+UBz
         QDMoPwjy+5fu54i5m3QUAvSVv2GCc2USl1y11hnp8fbzb3IDlt2StUPHp4si1z32A5Hp
         IbAg==
X-Gm-Message-State: APjAAAW9EYQvtzFI7S7yrV7pYtIkbcemaujGmGMPecElISk3q2y8OSjz
        qCVJ3hO9vY/DuOeIVJ2APR06nopyROqImlzTWALzFw==
X-Google-Smtp-Source: APXvYqyAR9Zt4qe/vlIFOhbxEirAD96v9PPrA79GaYHwcdMz6fZ1NH3FCjjhf21FaWW4P/xls31tGJG1dXDvkEy8Z5A=
X-Received: by 2002:a02:a1cd:: with SMTP id o13mr40365144jah.57.1559058789160;
 Tue, 28 May 2019 08:53:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190521090306.28113-1-brgl@bgdev.pl>
In-Reply-To: <20190521090306.28113-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 28 May 2019 17:52:58 +0200
Message-ID: <CAMRc=MdJoO602kLfP_Hw9-0pB25CeUMxfqBUYhC7CB3Aw+5O4A@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: max732x: use i2c_new_dummy_device()
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

wt., 21 maj 2019 o 11:03 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=82(a=
):
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> We now have a resource managed version of i2c_new_dummy_device() that
> also returns an actual error code instead of a NULL-pointer. Use it
> in the max732x GPIO driver and simplify code in the process.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

If there are no objections I'll apply it by the end of this week.

Bart

>  drivers/gpio/gpio-max732x.c | 37 ++++++++++++++-----------------------
>  1 file changed, 14 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpio/gpio-max732x.c b/drivers/gpio/gpio-max732x.c
> index f03cb0ba7726..7fd1bdfe00e5 100644
> --- a/drivers/gpio/gpio-max732x.c
> +++ b/drivers/gpio/gpio-max732x.c
> @@ -652,12 +652,12 @@ static int max732x_probe(struct i2c_client *client,
>         case 0x60:
>                 chip->client_group_a =3D client;
>                 if (nr_port > 8) {
> -                       c =3D i2c_new_dummy(client->adapter, addr_b);
> -                       if (!c) {
> +                       c =3D devm_i2c_new_dummy_device(&client->dev,
> +                                                     client->adapter, ad=
dr_b);
> +                       if (IS_ERR(c)) {
>                                 dev_err(&client->dev,
>                                         "Failed to allocate I2C device\n"=
);
> -                               ret =3D -ENODEV;
> -                               goto out_failed;
> +                               return PTR_ERR(c);
>                         }
>                         chip->client_group_b =3D chip->client_dummy =3D c=
;
>                 }
> @@ -665,12 +665,12 @@ static int max732x_probe(struct i2c_client *client,
>         case 0x50:
>                 chip->client_group_b =3D client;
>                 if (nr_port > 8) {
> -                       c =3D i2c_new_dummy(client->adapter, addr_a);
> -                       if (!c) {
> +                       c =3D devm_i2c_new_dummy_device(&client->dev,
> +                                                     client->adapter, ad=
dr_a);
> +                       if (IS_ERR(c)) {
>                                 dev_err(&client->dev,
>                                         "Failed to allocate I2C device\n"=
);
> -                               ret =3D -ENODEV;
> -                               goto out_failed;
> +                               return PTR_ERR(c);
>                         }
>                         chip->client_group_a =3D chip->client_dummy =3D c=
;
>                 }
> @@ -678,36 +678,34 @@ static int max732x_probe(struct i2c_client *client,
>         default:
>                 dev_err(&client->dev, "invalid I2C address specified %02x=
\n",
>                                 client->addr);
> -               ret =3D -EINVAL;
> -               goto out_failed;
> +               return -EINVAL;
>         }
>
>         if (nr_port > 8 && !chip->client_dummy) {
>                 dev_err(&client->dev,
>                         "Failed to allocate second group I2C device\n");
> -               ret =3D -ENODEV;
> -               goto out_failed;
> +               return -ENODEV;
>         }
>
>         mutex_init(&chip->lock);
>
>         ret =3D max732x_readb(chip, is_group_a(chip, 0), &chip->reg_out[0=
]);
>         if (ret)
> -               goto out_failed;
> +               return ret;
>         if (nr_port > 8) {
>                 ret =3D max732x_readb(chip, is_group_a(chip, 8), &chip->r=
eg_out[1]);
>                 if (ret)
> -                       goto out_failed;
> +                       return ret;
>         }
>
>         ret =3D gpiochip_add_data(&chip->gpio_chip, chip);
>         if (ret)
> -               goto out_failed;
> +               return ret;
>
>         ret =3D max732x_irq_setup(chip, id);
>         if (ret) {
>                 gpiochip_remove(&chip->gpio_chip);
> -               goto out_failed;
> +               return ret;
>         }
>
>         if (pdata && pdata->setup) {
> @@ -719,10 +717,6 @@ static int max732x_probe(struct i2c_client *client,
>
>         i2c_set_clientdata(client, chip);
>         return 0;
> -
> -out_failed:
> -       i2c_unregister_device(chip->client_dummy);
> -       return ret;
>  }
>
>  static int max732x_remove(struct i2c_client *client)
> @@ -744,9 +738,6 @@ static int max732x_remove(struct i2c_client *client)
>
>         gpiochip_remove(&chip->gpio_chip);
>
> -       /* unregister any dummy i2c_client */
> -       i2c_unregister_device(chip->client_dummy);
> -
>         return 0;
>  }
>
> --
> 2.21.0
>
