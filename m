Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E5AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B7EE2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="JekMKGsD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbfCYI2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 04:28:55 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43736 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729996AbfCYI2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 04:28:55 -0400
Received: by mail-oi1-f194.google.com with SMTP id 67so6232354oif.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 01:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ecGgX+LbPvNCaAYSs9hBPUcbOvj8ceUZoKLvcir46Cc=;
        b=JekMKGsDKBnwF7R557EwpWL6K0Cy7hNriZlc2wQr5holrXMm+uB2b37fYcyERgYLY8
         u7/xcN0xM30WET2e2csQn2+ctnyM+x9XeqiQorkC1HZ2aL0QRN1tXko4ec1uKevio5CT
         ObdxbrLDVjDqbFX68G/BySoxDAaJPTxiybLrLFRuaLj8voKHFGUc2fuNjwGkK4Dh/e0R
         HMfE8xc8MOSsiLJNp6aDem4a5tku1/N3rZ6cobjN0aB3wX73Vdd5kVc0iw5arnArUOrp
         WUh7gK9O564ZfzI0OI+n9x5X9adO61zI3l5gpTK1wE7KiMCxtQOWyOQTVWHddrMev3SI
         RJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ecGgX+LbPvNCaAYSs9hBPUcbOvj8ceUZoKLvcir46Cc=;
        b=ZZlAu5+xg8mg6qv43tiRAibLiZjp1sx8UcwI9UIY33RwlnbQi5rp6+OLIN56w4llOO
         XfwR55U10iQ9p8tgZgenRFWYimPPRb6/hD1Nc8C39XBkK+ip2ThB2Zoa8VPYTc+o/3VP
         8r57jslcgK8sTygdibl+gVMQbE53T7+Bl6+PdF2tI0JZCZ9dmb8/agLtdqGGOkuUJso6
         OlAUTMDpVU/EDudyJXfEktHifr/G7SE73+x7rucKs+hWt7i4RWU13H33JXmuGedRm9z8
         9mEitsha80f1syqE24cDEGIUvrMB3/mkwpQDY+U+l+SClMt2hjP83PM92RPgFjQOjt47
         Jb+Q==
X-Gm-Message-State: APjAAAWm30UeOlWGBiyC5UZP8NA1YNmvB6taSGCP86Tvnv6TzrLaXjSi
        G768DlO8iacCle8c1+qPKS9Z9uEC9cCVb/YSvg39lA==
X-Google-Smtp-Source: APXvYqwJO1v4eB0EC8Sv6ncT6b1IZgRVwDYXm/v+JJdyU6QHjRi7utYVSuu83T3N6amjjokkceN9C4ItjCKKNbtNy3I=
X-Received: by 2002:aca:4b03:: with SMTP id y3mr10895187oia.21.1553502534785;
 Mon, 25 Mar 2019 01:28:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190324231002.2106-1-kjlu@umn.edu> <f4d27985-376a-42bb-b781-bdc96c0cef21@www.fastmail.com>
In-Reply-To: <f4d27985-376a-42bb-b781-bdc96c0cef21@www.fastmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 25 Mar 2019 09:28:43 +0100
Message-ID: <CAMpxmJU+Uh_oBqmCWmdpVQv52Duu6A3c+RGiL=tOYkqFUoX0ag@mail.gmail.com>
Subject: Re: [PATCH] gpio: fix a potential NULL pointer dereference
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     Kangjie Lu <kjlu@umn.edu>, pakki001@umn.edu,
        Linus Walleij <linus.walleij@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 25 mar 2019 o 00:12 Andrew Jeffery <andrew@aj.id.au> napisa=C5=82(a):
>
>
>
> On Mon, 25 Mar 2019, at 09:40, Kangjie Lu wrote:
> > In case devm_kzalloc, the patch returns ENOMEM to avoid potential
> > NULL pointer dereference.
> >
> > Signed-off-by: Kangjie Lu <kjlu@umn.edu>
>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
>
> > ---
> >  drivers/gpio/gpio-aspeed.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
> > index 854bce4fb9e7..217507002dbc 100644
> > --- a/drivers/gpio/gpio-aspeed.c
> > +++ b/drivers/gpio/gpio-aspeed.c
> > @@ -1224,6 +1224,8 @@ static int __init aspeed_gpio_probe(struct
> > platform_device *pdev)
> >
> >       gpio->offset_timer =3D
> >               devm_kzalloc(&pdev->dev, gpio->chip.ngpio, GFP_KERNEL);
> > +     if (!gpio->offset_timer)
> > +             return -ENOMEM;
> >
> >       return aspeed_gpio_setup_irqs(gpio, pdev);
> >  }
> > --
> > 2.17.1
> >
> >

Applied to fixes.

Bart
