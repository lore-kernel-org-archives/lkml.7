Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCFCC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 13:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E298D20643
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 13:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0Lm4QX0v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbgAHNHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 08:07:47 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39697 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgAHNHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 08:07:46 -0500
Received: by mail-qk1-f194.google.com with SMTP id c16so2513042qko.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 05:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=346qyklA3qDZU461htPaEWZ7KyGFJdr1eYBTQuGWWLw=;
        b=0Lm4QX0vpXdy7jqJW18R2UNFaGBSA9YgyYd+W+YjisYEd5UfNh+waopNJhq8pEmVpJ
         ZYk1woK3VfrEAL9gXGysYX7hbrFdMs1osMLatiaDV+AyNIr0SDv0BsA/ltyqe9R7Hf/f
         U1gA7P/kR4cteDWdVIEzd+j/G742RCNYbeTmMBzJG8TTH1EdpF7ZzrinMJEnZ+wnRgxj
         Hb9E9Q4Hxsxx2TdUGf3h6Ph+pDAiVFeAqHc1oS8HVX2sJoraWkA3FLQfQivgQz/KliwB
         7hIy4XK/AE+dxJ90I5hwyPMuqVvSxS8sMik7urKy88WgJe7zCX14ppu1LPNnL10VLOZG
         Skaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=346qyklA3qDZU461htPaEWZ7KyGFJdr1eYBTQuGWWLw=;
        b=EDzL8xI8qDayHuq9lkm6hoo8BBnupZ+0BaLH/oPOU+Tgspn8KoD5iHMlJ3O3rw/Xsw
         UcBRAJN2NfV+/JmAEUIg6nSWWhyhLm4RyMC1EwLqXnIeTMLIHmVVWF/93CDu5cuH1Nvd
         /Fdye1Sb+xO1s+rDYr74s388vwy/1h1eLtT/ETNlfwcOsZVRKD4bXVfXG1VoMN8j1QQC
         Gg0fjfa7K49eM+EcnB4tqfMakXI1mK/fygvx2olpAzeYlJHJB9dpsgwLz1CQeSWVJBDQ
         fO4R3X8XT6yAKobCfqskKUb7N1HWXUlQHisU3RJKbhJCPurrUaE/mvmmnqCwD1NpI+Z+
         fuxQ==
X-Gm-Message-State: APjAAAWCf4AsnG+XnEKkChT+8G8YYdt0oVjjC2LvAXksbVWlXR436QY2
        VxAQXjxRnIof9fhzXWW2jZXTAMTUXCZKF38nreBFTBCW
X-Google-Smtp-Source: APXvYqzdFYF4a74FYgNRam7LkkWroayazu4aWmKYjGmCth3u04VbHgmVr8XLcphpCceIy6E73inH7J9E9Qk/OsqsQg4=
X-Received: by 2002:a05:620a:136e:: with SMTP id d14mr3814511qkl.263.1578488864477;
 Wed, 08 Jan 2020 05:07:44 -0800 (PST)
MIME-Version: 1.0
References: <20200108121117.45060-1-yuehaibing@huawei.com>
In-Reply-To: <20200108121117.45060-1-yuehaibing@huawei.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 8 Jan 2020 14:07:33 +0100
Message-ID: <CAMpxmJWwcL9e6so=XrYmpjW1DF=7Vnq4UMvWE+j+sTbnXjd6Ww@mail.gmail.com>
Subject: Re: [PATCH -next] gpiolib: remove set but not used variable 'config'
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 8 sty 2020 o 13:11 YueHaibing <yuehaibing@huawei.com> napisa=C5=
=82(a):
>
> drivers/gpio/gpiolib.c: In function gpio_set_config:
> drivers/gpio/gpiolib.c:3053:16: warning:
>  variable config set but not used [-Wunused-but-set-variable]
>
> commit d90f36851d65 ("gpiolib: have a single place
> of calling set_config()") left behind this unused variable.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/gpio/gpiolib.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 9fd2dfb..aabf801 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -3050,7 +3050,6 @@ static int gpio_do_set_config(struct gpio_chip *gc,=
 unsigned int offset,
>  static int gpio_set_config(struct gpio_chip *gc, unsigned int offset,
>                            enum pin_config_param mode)
>  {
> -       unsigned long config;
>         unsigned arg;
>
>         switch (mode) {
> @@ -3064,7 +3063,6 @@ static int gpio_set_config(struct gpio_chip *gc, un=
signed int offset,
>                 arg =3D 0;
>         }
>
> -       config =3D PIN_CONF_PACKED(mode, arg);
>         return gpio_do_set_config(gc, offset, mode);
>  }
>

Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Thanks!
