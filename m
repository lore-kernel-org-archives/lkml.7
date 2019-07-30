Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFE2C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 08:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2360020882
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 08:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="pIzDyP8+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730281AbfG3IUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 04:20:07 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38017 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbfG3IUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 04:20:07 -0400
Received: by mail-oi1-f193.google.com with SMTP id v186so47299195oie.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 01:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ztB3Q8DLzhhcyvyMNVMzNK6NebfDHAUbgflc/UJwuNo=;
        b=pIzDyP8+aLF6N+tvz+qRREtMKOxN8h9OLXktM72vNNuq0cwNn7ePJ87Oh3Bp7mcvK5
         e0LVy1Y/VpmFkZoEcUcJHJtqQO9N9lnl5L4JDyncWSS4z5CiFZK6u4oqT0gdUZenQlGs
         0U0QsWw6vyHM+mxKVCmcZQ5jiqWlSUvxoqz5Xmd9W/7hBJkZrjKZ+vBYH7ZpCisvDvBA
         KJ0pQ6DJ16a+ycW5MmGcFgEuVG2/HJM4tvyM1tGZljdhT5nA1nzYaJqpGSrzuLYEExWd
         Q53RlmbAlThY5R90DRzNBnbQEOFmcf4U6+zE/1fhY+kHnP/g+RAgRtugKnIEDfKYCJYW
         T7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ztB3Q8DLzhhcyvyMNVMzNK6NebfDHAUbgflc/UJwuNo=;
        b=eGZ0o3amd1LG7v8mS3te7dxoV9Rer7W5BhikDYc5GW9npoYatWn/S3AYQ04xK5hnDH
         BMgbK3G1rWyIsq5j2NzklQDPEJkTpmOMIfjbH5lmLh61TMRKYvCvWVXjqUxx6nUoI/v5
         FMJ3oXsfHSYgoCiOZ0Rq3Od8ZnEgGopazNbca0IQAO6Fj7KG5/uv0cuDGR2K0IPprFqm
         lx87omwzM/+3Sg/BDn7KfCdJMG1BJwg/WqwXlOarLPBiWpE0DEPUAKdFEw6CyBJO8SF2
         gdXbxtVxX3TlCLlsmYpzBbJ+aUNG1+n/KVV4/4WHw1h3yR18vmh0VUt0rKKbw9lWjYdQ
         tVXA==
X-Gm-Message-State: APjAAAWKC6/646wp7ELDseiWYoZ8ON3hgddheXgcRsfO0pz5BmzKxBK8
        edo3E+Ul05xefpGzjeyYIyzDoHD5yGvq3Ak41dhDeoAB
X-Google-Smtp-Source: APXvYqz+RixEWvkgIcYBCD7zC6WxuWv9SMmWyrq8EWEOxamd2YuP+D7WpHGAgjYXRXEneSmklCfHPPgwVMla8A43xk0=
X-Received: by 2002:aca:450:: with SMTP id 77mr21728053oie.114.1564474806601;
 Tue, 30 Jul 2019 01:20:06 -0700 (PDT)
MIME-Version: 1.0
References: <1564410993-22101-1-git-send-email-info@metux.net>
In-Reply-To: <1564410993-22101-1-git-send-email-info@metux.net>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 30 Jul 2019 10:19:55 +0200
Message-ID: <CAMpxmJX6M38-q7-TuM_T9u+bTYLLs3RuoGhVXFF-zyh-Y7TUUw@mail.gmail.com>
Subject: Re: [PATCH] gpio: just plain warning when nonexisting gpio requested
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 29 lip 2019 o 16:41 Enrico Weigelt, metux IT consult
<info@metux.net> napisa=C5=82(a):
>
> From: Enrico Weigelt <info@metux.net>
>
> When trying to export an nonexisting gpio ID, the kernel prints
> outs a big warning w/ stacktrace, sounding like a huge problem.
> In fact it's a pretty normal situation, like file or device not
> found.
>
> So, just print a more relaxed warning instead.
>
> Signed-off-by: Enrico Weigelt <info@metux.net>
> ---
>  drivers/gpio/gpiolib.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 3ee99d0..06eeedd 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -1,4 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +

While adding pr_fmt would make sense for gpiolib in general, it
changes all the already existing pr_* log messages in gpiolib.c. This
has nothing to do with this patch. Please use a regular pr_warn() and
then we can think about simplifying the messages in general.

Bart

>  #include <linux/bitmap.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> @@ -121,7 +124,7 @@ struct gpio_desc *gpio_to_desc(unsigned gpio)
>         spin_unlock_irqrestore(&gpio_lock, flags);
>
>         if (!gpio_is_valid(gpio))
> -               WARN(1, "invalid GPIO %d\n", gpio);
> +               pr_warn("invalid GPIO %d\n", gpio);
>
>         return NULL;
>  }
> --
> 1.9.1
>
