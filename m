Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EABEC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 22:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 127CE20840
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 22:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="la+kAQw+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731825AbfFGWid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 18:38:33 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43328 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731777AbfFGWiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 18:38:21 -0400
Received: by mail-lf1-f66.google.com with SMTP id j29so2730099lfk.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 15:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ET3CFvRFkI0MF/L2BngZV7pHB0kqkmb+NPPDszDMmzE=;
        b=la+kAQw+qsaiVBk6+KatB7XKgUOQshyAywGFIAIvLnyWbM44AQD3zDX3pKapxSYt4a
         u3GUBtfj6P/Oxxl9QWxXPWRsdxguE7S0o4s8Giuqu9SGAndIJjiOwd5ua0slHTTM79z7
         dAcF+wCHd8q02R92tR4Yq0NCf8O479vhO78iKhl2OrWl2Y1o5XqX+/GXiYb2D1b8dmuo
         H9tcj2OjLjotzInGGsDpWbD9WBl6JAipNBNP8VhjZVU8eFX5ucB5BFad8ny5ZpIjgz8x
         ZZvgDibFSGEH9KqtYipA4wh+CJFtECjt2WUaZDyqwHr95wNMA8xxcd+iBLre6Wf5gTAq
         El2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ET3CFvRFkI0MF/L2BngZV7pHB0kqkmb+NPPDszDMmzE=;
        b=baoSTlvLpZnn+Cx48tZPqGPWWpsunjM31TgcZxtq8iPDX5SOVSR0LW3vtRLl73o4S2
         gAAV5uZsSyeYihiuuM4woXiCWx2K/7xCr2UCpTj8sMYP1uwKxnsMFfcet+ga7odAbLqY
         ueceYN2nqI4cnSiTNpyAXt3u79Z6SgNWpUfCMoBzgB0bDov8Y4L6KBiI90/f8hSiDNP9
         NioseqQXqEceTppkKZlXXSJ0nLu7mY+1xedgZch6mQXCJXfTq1INw2FP4PaNv/m2YTG9
         sonXOVWf9N39dmeNFVqABu9kC8GzhI41RkdgrXC3NXb5nHRbbdngo+O6NO0X/n07qlA8
         3Bcg==
X-Gm-Message-State: APjAAAUdU4FXEWifCcH5mk33j9kNoO4ZD+TH3ExoRLSFKA/0OiVh7VQp
        6pHT8pTpUTj7ARBI4xIiDRpCSvC7qaLzNdQ6BNgA0Q==
X-Google-Smtp-Source: APXvYqwU6tE2vqZEcO3A/q6LuYfqSxDoBrcVt4WBoMI4WPwbOyt15dI+odVEiKCLsZ0yFS2STPMXWyGJ1aaCxj2Iziw=
X-Received: by 2002:ac2:4891:: with SMTP id x17mr16073289lfc.60.1559947100366;
 Fri, 07 Jun 2019 15:38:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190605080259.2462-1-j-keerthy@ti.com> <20190605080259.2462-3-j-keerthy@ti.com>
 <CAMpxmJXjMX20TAEsfEa7pqZx5-aW_rMKwS+6g9NTvRNEfuAyeA@mail.gmail.com>
 <96dbfd50-2a45-e3dc-3928-47fbc52f9269@ti.com> <CAMRc=Mfe+K=s4OZp7VWRik7JtSU6Fpufx0yDZtYCMNh5+LSJuQ@mail.gmail.com>
In-Reply-To: <CAMRc=Mfe+K=s4OZp7VWRik7JtSU6Fpufx0yDZtYCMNh5+LSJuQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 8 Jun 2019 00:38:12 +0200
Message-ID: <CACRpkda_YmWoatVEt6OO+enYVfbZ6wvP5gmRG5+h5k=DVbPi+A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] gpio: davinci: Add new compatible for K3 AM654 SoCs
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Keerthy <j-keerthy@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Tero Kristo <t-kristo@ti.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 6, 2019 at 9:49 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> =C5=9Br., 5 cze 2019 o 17:12 Keerthy <j-keerthy@ti.com> napisa=C5=82(a):

> > >>   static const struct of_device_id davinci_gpio_ids[] =3D {
> > >>          { .compatible =3D "ti,keystone-gpio", keystone_gpio_get_irq=
_chip},
> > >> +       { .compatible =3D "ti,am654-gpio", keystone_gpio_get_irq_chi=
p},
> > >
> > > Please add a patch adding this compatible to the binding document as =
well.
> >
> > https://patchwork.kernel.org/patch/10976445/
> >
> > Posted but did not add you in Cc. Sorry about that.
>
> I don't see it on GPIO patchwork either. Please resend it as part of
> this series.

I see the whole other series got resent as RFC, I'll just apply these
three and the binding patch so we don't have to pingpong these
patches too much around :)

Yours,
Linus Walleij
