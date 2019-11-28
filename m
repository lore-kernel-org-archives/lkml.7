Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB50C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 10:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63CA621741
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 10:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ulsUpUUe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfK1Kqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 05:46:32 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35234 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbfK1Kqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 05:46:31 -0500
Received: by mail-oi1-f196.google.com with SMTP id k196so6568879oib.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 02:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GQPDbYqNRXSh6PXhx4akn8aIavTIr5uskPQRjgpyFfM=;
        b=ulsUpUUeLrxyO7qJDpjeMfLgZ7felgad/9o65ulMzMSfCJXi362CB75AlAmIIKGN9e
         Pqt4YLmVeoEYaHUPDqyGzJGkyq33EPXwmhce31kVSamztL2pniW5LsuRGbBPCYfBbYB1
         ID1L77YEHHCI5PIhtLb2SW2CwTHuWfdmZvyNpi+pGfpoMSitLqV+u0IypsSMA5Co/ZzD
         2H/N8EnPxZMHvz+cCgoXvmgV707+s1DuDfkSAGrvlEt6I24tUzOwfu/q5/74d7dXg/8s
         7xrPw1MbkMYW9Tz+JGo6sZCBl8h//JMyctHR7TyMu5PpIeDG85b5PfPkJe4RQtZ0azkO
         ndvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GQPDbYqNRXSh6PXhx4akn8aIavTIr5uskPQRjgpyFfM=;
        b=BNJCKI9UpmKypyODEEKbdLzTTMqJNM3v8ewHz7JgnLELLiNngwuEq5OJABI78D/Ikt
         gU0Y14SisQI6msliPqYKySRnd2As7ArU3hG/fD/FB5XqtSEdJjScxJl2QyCiFYjOdYDA
         6CFGbmqPdUN9rfAuReDdTzlIo9iRT8oR/pMah52pWylRgxdFc4wV2KWNIvaqQ5wqe6sF
         YJnYJO13YGFkiUTY/RMiic+oyaj0sk0p4/KukS7ixTK73qPFWtG+LkZ/5KIH+EllbiYW
         TMp7xV+m7+VfFB4W6EZB3znkiINbK/CF7FC0m0xTQlzrOHRo/QdEPhWsaZ8tqWS3rXYy
         B3xQ==
X-Gm-Message-State: APjAAAXzohUL1sdEHZE09n+KcRGvV4/ciyHY8XsAVi4kNOC/ou4R7aR1
        RWJShJ5is2wBmf9B8KviaOEBmwNHR1AR/vEcj91LP2lA
X-Google-Smtp-Source: APXvYqwgKWuNM3AaDjBIBvZISOlC0kMprIi47NTQkQds/weaknlkiS0CWm8bJ/afikYUhzQgCjXdlqD4YK1bVJEH0Xo=
X-Received: by 2002:aca:4756:: with SMTP id u83mr8054092oia.147.1574937989831;
 Thu, 28 Nov 2019 02:46:29 -0800 (PST)
MIME-Version: 1.0
References: <20191127135932.7223-1-m.felsch@pengutronix.de> <20191127135932.7223-2-m.felsch@pengutronix.de>
In-Reply-To: <20191127135932.7223-2-m.felsch@pengutronix.de>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 28 Nov 2019 11:46:19 +0100
Message-ID: <CAMpxmJXzBphmW7SWD05wtLjSAR7VBzVAgnYJYd3Sd49Bp6AmgQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] gpio: add support to get local gpio number
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Adam.Thomson.Opensource@diasemi.com,
        linux-devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 27 lis 2019 o 14:59 Marco Felsch <m.felsch@pengutronix.de> napisa=
=C5=82(a):
>
> Sometimes consumers needs to know the gpio-chip local gpio number of a
> 'struct gpio_desc' for further configuration. This is often the case for
> mfd devices.
>

We already have this support. It's just a matter of exporting it, so
maybe adjust the commit message to not be confusing.

That being said: I'm not really a fan of this - the whole idea of gpio
descriptors was to make them opaque and their hardware offsets
irrelevant. :(

> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  drivers/gpio/gpiolib.c        |  6 ++++++
>  include/linux/gpio/consumer.h | 10 ++++++++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 104ed299d5ea..7709648313fc 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -4377,6 +4377,12 @@ int gpiod_count(struct device *dev, const char *co=
n_id)
>  }
>  EXPORT_SYMBOL_GPL(gpiod_count);
>
> +int gpiod_to_offset(struct gpio_desc *desc)

Maybe call it: gpiod_desc_to_offset()?

> +{
> +       return gpio_chip_hwgpio(desc);
> +}
> +EXPORT_SYMBOL_GPL(gpiod_to_offset);
> +
>  /**
>   * gpiod_get - obtain a GPIO for a given GPIO function
>   * @dev:       GPIO consumer, can be NULL for system-global GPIOs
> diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.=
h
> index b70af921c614..e2178c3bf7fd 100644
> --- a/include/linux/gpio/consumer.h
> +++ b/include/linux/gpio/consumer.h
> @@ -60,6 +60,9 @@ enum gpiod_flags {
>  /* Return the number of GPIOs associated with a device / function */
>  int gpiod_count(struct device *dev, const char *con_id);
>
> +/* Get the local chip offset from a global desc */
> +int gpiod_to_offset(struct gpio_desc *desc);
> +
>  /* Acquire and dispose GPIOs */
>  struct gpio_desc *__must_check gpiod_get(struct device *dev,
>                                          const char *con_id,
> @@ -189,6 +192,13 @@ static inline int gpiod_count(struct device *dev, co=
nst char *con_id)
>         return 0;
>  }
>
> +static inline int gpiod_to_offset(struct gpio_desc *desc)
> +{
> +       /* GPIO can never have been requested */
> +       WARN_ON(desc);
> +       return 0;
> +}
> +
>  static inline struct gpio_desc *__must_check gpiod_get(struct device *de=
v,
>                                                        const char *con_id=
,
>                                                        enum gpiod_flags f=
lags)
> --
> 2.20.1
>
