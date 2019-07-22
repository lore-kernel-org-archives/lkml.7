Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1F4C76194
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E85B1217F9
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="fGNAYXME"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730668AbfGVNxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 09:53:46 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46307 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729750AbfGVNxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 09:53:46 -0400
Received: by mail-oi1-f193.google.com with SMTP id 65so29589436oid.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 06:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g1UMNJz38FJKA8VfoTulETIw691BfDACZOimxcCXK/o=;
        b=fGNAYXMEMQLi61dS/BX669E7XdeJVBqAP/po6W0f/plWm3Ag7TmVrwhbmZteGpcd42
         D08dufbOML0rLUeOodYQgaMv6jyBh3tRkFtbIrhsgt0Pje6GSJvRC6YIRDUmhOrSwonZ
         hlBbBHEI9nH4H80aLinD09Y8JniQTngsNyPoRegNf1LVnXJlUHGlTn0o03A7pO40X4vo
         TCR7+RH68UxHyyUDH0unVSP8nfWKTOneUMziMoYbIx9Yc2p89+n/4H7ehB1TOCq3BkS6
         oM04WZJRb4UlHU+AIKfU0Fb76AB7ykQjASxlCvXNRYN5lJH790D8mZV1SO+IgWOEsk7P
         eV4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g1UMNJz38FJKA8VfoTulETIw691BfDACZOimxcCXK/o=;
        b=BidUNyGWBKI9wCV2HkKnteoMVxKDmrf8rFvc7O9IwLGI4shjE8PTv7RRhEh6EqVZKJ
         goZ6uFE40WZ8D79ZHBrOql/PqQu96VKl1MG1eqlBpj5qrof/1jxpRDFO5/pOK5xtjImR
         3dul6pa/pmyvHvFi9tl6mhsXj6WFAoOjX0wHu64M78grmRK7N32+wZYuOqS6Ot1xY17m
         nBVsxW2csFjD3JVl4CPwqqNjPpB7MLRkVk+SIQtXFxBZYr0snYE3QmfJWIaVaTpJ8R7q
         +5xwZnZ9ZVRSOXLbGIr8mZhNDCQz7opQC3vvl5NL7FfoaVpvJ9Ak6LlAKDNpLwrsh/in
         RQOA==
X-Gm-Message-State: APjAAAXsGjaljGJfsu18eV5Y/9h/jzVX20KIPhpg3hShac/ziLZOuL1y
        re9KTVhHcyrgT9f7oOwftmIF1yvf7GjXoSGrk9cBEg==
X-Google-Smtp-Source: APXvYqwhbUEk+tIJupY1mSA2+5y37L/UfPZ1TUPnGPBXdX0IN0j3vyiGWacxFaSuSqrMBogc4X9YCsSdXEY2kVKjlrA=
X-Received: by 2002:aca:450:: with SMTP id 77mr35802547oie.114.1563803625135;
 Mon, 22 Jul 2019 06:53:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190708052308.27802-1-michael.wu@vatics.com>
In-Reply-To: <20190708052308.27802-1-michael.wu@vatics.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 22 Jul 2019 15:53:34 +0200
Message-ID: <CAMpxmJVks=teMX1T3pUOO4zomhyhEPWedoiChW00whi40v-VQw@mail.gmail.com>
Subject: Re: [PATCH v2] gpiolib: fix incorrect IRQ requesting of an active-low lineevent
To:     Michael Wu <michael.wu@vatics.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, morgan.chang@vatics.com,
        "Stable # 4 . 20+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 8 lip 2019 o 07:23 Michael Wu <michael.wu@vatics.com> napisa=C5=82(a)=
:
>
> When a pin is active-low, logical trigger edge should be inverted to matc=
h
> the same interrupt opportunity.
>
> For example, a button pushed triggers falling edge in ACTIVE_HIGH case; i=
n
> ACTIVE_LOW case, the button pushed triggers rising edge. For user space t=
he
> IRQ requesting doesn't need to do any modification except to configuring
> GPIOHANDLE_REQUEST_ACTIVE_LOW.
>
> For example, we want to catch the event when the button is pushed. The
> button on the original board drives level to be low when it is pushed, an=
d
> drives level to be high when it is released.
>
> In user space we can do:
>
>         req.handleflags =3D GPIOHANDLE_REQUEST_INPUT;
>         req.eventflags =3D GPIOEVENT_REQUEST_FALLING_EDGE;
>
>         while (1) {
>                 read(fd, &dat, sizeof(dat));
>                 if (dat.id =3D=3D GPIOEVENT_EVENT_FALLING_EDGE)
>                         printf("button pushed\n");
>         }
>
> Run the same logic on another board which the polarity of the button is
> inverted; it drives level to be high when pushed, and level to be low whe=
n
> released. For this inversion we add flag GPIOHANDLE_REQUEST_ACTIVE_LOW:
>
>         req.handleflags =3D GPIOHANDLE_REQUEST_INPUT |
>                 GPIOHANDLE_REQUEST_ACTIVE_LOW;
>         req.eventflags =3D GPIOEVENT_REQUEST_FALLING_EDGE;
>
> At the result, there are no any events caught when the button is pushed.
> By the way, button releasing will emit a "falling" event. The timing of
> "falling" catching is not expected.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael Wu <michael.wu@vatics.com>
> ---
> Changes from v1:
> - Correct undeclared 'IRQ_TRIGGER_RISING'
> - Add an example to descibe the issue
> ---
>  drivers/gpio/gpiolib.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index e013d417a936..9c9597f929d7 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -956,9 +956,11 @@ static int lineevent_create(struct gpio_device *gdev=
, void __user *ip)
>         }
>
>         if (eflags & GPIOEVENT_REQUEST_RISING_EDGE)
> -               irqflags |=3D IRQF_TRIGGER_RISING;
> +               irqflags |=3D test_bit(FLAG_ACTIVE_LOW, &desc->flags) ?
> +                       IRQF_TRIGGER_FALLING : IRQF_TRIGGER_RISING;
>         if (eflags & GPIOEVENT_REQUEST_FALLING_EDGE)
> -               irqflags |=3D IRQF_TRIGGER_FALLING;
> +               irqflags |=3D test_bit(FLAG_ACTIVE_LOW, &desc->flags) ?
> +                       IRQF_TRIGGER_RISING : IRQF_TRIGGER_FALLING;
>         irqflags |=3D IRQF_ONESHOT;
>
>         INIT_KFIFO(le->events);
> --
> 2.17.1
>

Applied to fixes.

Bart
