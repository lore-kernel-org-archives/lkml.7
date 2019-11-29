Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C93C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 09:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD8B21774
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 09:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WOk8dlVM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfK2JdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 04:33:06 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45641 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfK2JdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 04:33:06 -0500
Received: by mail-lf1-f68.google.com with SMTP id 203so22084656lfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 01:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H/Od6kVrXI87O4KN/Z/H7nofcItikhLmOLU1xinq+0o=;
        b=WOk8dlVMR/QLVPtqElvHr+0adH/0ak6x3Ek5lWCQvsvbZdrw2XhrM1EuzzJgz51GHX
         vD5/azUjcuyK6flVMNJfglKVkr0cdABA1K9P8bCzgk4dsP+69qixQyMIttJ2FtL5r82k
         pY2/42xk4ditN95qjoRlqrufFZoIS26RWd/KGELpFvgf5ZTGMUhmzX86JmIflatOI2Vb
         mlXd8v4CpNaaPF6fu3lKHXrEOTopZEtlVuU0Ca73zkpcNh/2XJaF9HNRieLGKJfLu50t
         GeBTBxDVfDylh0i/orThzdQ3hREAzZTxWQZAVf6OV9me8/MHTTXzFDz78tV+tWZedXto
         Gf/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H/Od6kVrXI87O4KN/Z/H7nofcItikhLmOLU1xinq+0o=;
        b=kdLRN3/ArEbMFRLiDrj8FxOkcaK8fcdpsMccddNMFy/yrABawXKKJQKbqO65R8Xyy8
         UDkyEMaEuf5nhGnh0Z37ipXAtsCkiMGYUFDmy/i2lZudC8/9NbsHW4DpvZ7hkOGODmQu
         a0gug8kzeSyv75hyiW9d+SIwx5RWZWEFT3bYzWprz463ymz7zLnjjLQXjSs8mca62VmM
         Id2Ki8L+k/kEECyLwSbNzv/Ca3r3E9m0OOz5LGMg53yMHr5/IoS7nKilhzI41mgELTyq
         FG6oRd6sOiQGKZuOjNJUY72wMufe0AIgprFWOanTgBfhdGeKDOPGKqIzevPywWI+NQg5
         tsLQ==
X-Gm-Message-State: APjAAAWX5uoP8NN5Jdh9MN0TXKA1oXO38s0OEj2kW7UchwL5GEKYyH94
        z7+lWWtUKYiWuZgxI51FvJ0cQI/iOx5B743yq5HXjw==
X-Google-Smtp-Source: APXvYqx5uTey2rEFuGI2JxeLrjghoyWWEsx0pJUzBXBm9m+sNFbMNKzsj1UJL7ckQkpZjRuMiLHWc9xiMRqzdmQz7LQ=
X-Received: by 2002:a19:f701:: with SMTP id z1mr29467397lfe.133.1575019983038;
 Fri, 29 Nov 2019 01:33:03 -0800 (PST)
MIME-Version: 1.0
References: <20191127135932.7223-1-m.felsch@pengutronix.de> <20191127135932.7223-2-m.felsch@pengutronix.de>
In-Reply-To: <20191127135932.7223-2-m.felsch@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 29 Nov 2019 10:32:51 +0100
Message-ID: <CACRpkdbG=XiQHNZa+zBqdyTDRhyXD5rLxbLjp3qqGbcQeTX26Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] gpio: add support to get local gpio number
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, stwiss.opensource@diasemi.com,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

thanks for your patch!

On Wed, Nov 27, 2019 at 2:59 PM Marco Felsch <m.felsch@pengutronix.de> wrote:

> Sometimes consumers needs to know the gpio-chip local gpio number of a
> 'struct gpio_desc' for further configuration. This is often the case for
> mfd devices.
>
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
(...)
> +int gpiod_to_offset(struct gpio_desc *desc)
> +{
> +       return gpio_chip_hwgpio(desc);
> +}
> +EXPORT_SYMBOL_GPL(gpiod_to_offset);

That seems like an unnecessary wrapper.

What about renaming gpio_chip_hwgpio() everywhere
to gpiod_to_offet(), remove it from drivers/gpio/gpiolib.h
and export it in <linux/gpio/consumer.h> instead?

I suppose this is what Bartosz is indicating, not sure though.

Indeed it is a bit of a worrysome thing to export and we need
to be very specific about its usecase, so I'd also like some
nice to-the-point kerneldoc on the export site so that it is
clear what corner cases this function is for. (Like in this
specific driver.)

Yours,
Linus Walleij
