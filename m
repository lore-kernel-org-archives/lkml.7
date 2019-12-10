Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C75C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 23:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 539CF20663
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 23:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hAbRMVrs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfLJXzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 18:55:06 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43887 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfLJXzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 18:55:06 -0500
Received: by mail-lf1-f67.google.com with SMTP id 9so15183670lfq.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 15:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KNrohwDsHeZAs+ReIm2Q7EwJ5Hy4Jj8HAR5cu/mtLgY=;
        b=hAbRMVrsm1W4JYpKwlAZvEdT933tVqy6w6wMCc7wU8/Lzg2mVB1osVcU1cB1VPIwef
         /CJ1Z+GY10xo0IaUThsb3JldrQHfnpRtZ+VnPK7s3az7eI6tLGGac3UF6CMi+x8B/A/1
         8+qpg93GpxCpp1pUX4fIrdIuGw4RKwqJ8QFN70tRaGYx3wAqVnCknrRCklxxZ39x2+Sf
         YDS5h08LVLC1Bz4+lYzG2wPIQ//3LBMqGB4aSpxRJxEGo7cfDj8zA4SPv6LQrdn4zTsA
         VHZQaf+j3+knILNMuVh6kZ5BZX6O6cnqzRPCFIPpaNnTzSJnNse3mOlmdzQONBiyngEE
         dC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KNrohwDsHeZAs+ReIm2Q7EwJ5Hy4Jj8HAR5cu/mtLgY=;
        b=FBPNG5xqyssiSevE/DSmJCfeuTbG997KPwPcgNrmDvaNs0WGw3UTqbQg7B2IDxUlyA
         XZt1egOaZ8pS1OFNRJBEjdrkw+jtF8NcoK9tqTs8N3NGSyWxHoSTmgO3GKxm4SrzYSjz
         gDRxnB57kXr/xD78WtdbJmQwM68XGjiTPJJtavue692I5rJIhmVUuUFd6mDJjqGv5mt7
         v1nazQ5BmCk1W7BmDZLx7nIWhXDBNsgckdU1TZSqP3UWmm9J9A6WXvK93VfkbCLd+6TC
         5z20uvRzBPOS63gE2fB0jpExf1oJVf033BkV+hCMlQDzSqwwdkWGhvDd9zz6BsRZa7Fn
         Wvkg==
X-Gm-Message-State: APjAAAVqbkrNZU1oIzQnOG5XAAmwRZSvorGPmoPIJGJWlhqg/xgtMzko
        fJz85maX5XKZsLpUcHjxtd5HeUzdOOqQ6zYa/4MxDw==
X-Google-Smtp-Source: APXvYqwx5LuKLDN3XiVpf1hl60Rh8HBmOKd1FntsXqq8U8VXeEmmPKwaFk+urFzUVIAbBMMQifWAms3QKp/FaSKlGkM=
X-Received: by 2002:a19:c648:: with SMTP id w69mr325542lff.44.1576022103954;
 Tue, 10 Dec 2019 15:55:03 -0800 (PST)
MIME-Version: 1.0
References: <20191120133409.9217-1-peter.ujfalusi@ti.com> <20191120133409.9217-2-peter.ujfalusi@ti.com>
 <CACRpkdbXX3=1EGpGRf6NgwUfY2Q0AKbGM8gJvVpY+BRAo5MQvQ@mail.gmail.com>
 <d423bc53-31df-b1b4-37da-932b7208a29e@ti.com> <CACRpkdafEdsN6i16SA175wE4J_4+EhS5Uw4Qsg=cZ=EuDYHmgg@mail.gmail.com>
 <20191203235113.GA12929@bogus>
In-Reply-To: <20191203235113.GA12929@bogus>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Dec 2019 00:54:52 +0100
Message-ID: <CACRpkdZOn8vGjxCUBd9c-SQSkmwxpS+bbRk7TiOWJcpTz9BsBQ@mail.gmail.com>
Subject: Re: [RFC 1/2] dt-bindings: gpio: Document shared GPIO line usage
To:     Rob Herring <robh@kernel.org>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 4, 2019 at 12:51 AM Rob Herring <robh@kernel.org> wrote:
> On Thu, Nov 28, 2019 at 11:06:35AM +0100, Linus Walleij wrote:

> > The ambition to use refcounted GPIOs to solve this
> > usecase is probably wrong, I would say try to go for a
> > GPIO-based reset controller instead.
>
> Yes, but I think we can have that AND use the existing binding.
>
> > The fact that some Linux drivers are already using explicit
> > GPIO's for their reset handling is maybe unfortunate,
> > they will simply have to grow code to deal with a reset
> > alternatively to GPIO, like first try to grab a reset
> > handle and if that doesn't fall back to use a GPIO.
>
> I think this could just be all handled within the reset subsystem given
> that we've been consistent in using 'reset-gpios' (GPIO regulators are
> similar, but we never had such consistency with GPIO names for
> regulators). We can implement a reset driver for the 'reset-gpios'
> property that deals with the sharing. Drivers to DT nodes doesn't have
> to be 1:1. It's convenient when they are, but that's encoding the OS's
> (current) driver structure into DT.

This seems like a good approach if it can be made to work.
reset-gpios should have the right polarity flags (else drivers
and/or device trees need to be fixed...) so the driver can simply
scan over them and try to build a consensus on how to assert
or deassert a shared reset-gpios line.

It is also a natural placeholder for the connection to device
core that will inevitably need to happen the day the device
hierarchy needs to be torn up/down for a reset on some
random device.

Peter, will you have a go at it?

Yours,
Linus Walleij
