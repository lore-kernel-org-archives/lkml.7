Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05390C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE271233A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I5bjDMRq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403864AbfHWKAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 06:00:41 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45039 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730580AbfHWKAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:00:40 -0400
Received: by mail-lj1-f195.google.com with SMTP id e24so8294058ljg.11
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 03:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OYtHVFMQLzS9sJJeSyCBx/b59zqA2cgkZM6wKCYLhPI=;
        b=I5bjDMRqbnKWh8cuXJ/GOm4BEDe5Ka7HjlyevUJasXA+1BL8QDcTRTEXHHAa4aUv5P
         Gdot/lqksVt1ghCdyo7mL4ZDg8oT1BoRoAcikTQEEdvVTx59p920QplYZ5yQPyo5WjQN
         2M4W6+9UyBAhsxoe/Kg7V41jsWpyUchEl40nUbvDRT0rlOs72o13XTv7Js6tC3prUS36
         eTaE9nYa+TMFxMJslxm+EDV5Qivr9/G6sYeWePm85wGoPd3bOVRI/H6DLWYYZVYn9BjV
         of7rAZGIS4DOArycPxIYHPNE22i0cleDWKI5W1qS5VO0m7PFZvVPyBt/3l9wZMDaHss2
         qIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OYtHVFMQLzS9sJJeSyCBx/b59zqA2cgkZM6wKCYLhPI=;
        b=Si+b5rof+VwPPJRCueLsQgBLzkoctmvwuBogNMRvLDYRteQcqg4IOYfLIrjBF+2XC8
         14vAuv4HtUw9EMGTePq7/5qbGb9OrgUMxa+CAZhtqQR+i70Ikxb9vrGvawYsbKFkmFMM
         iR9ajKGIH4NP8oYpVy+KBl+XvMGiZpGqDMi2p1v1ZVJWwsKHxXYfDyBhkAVpWkBIEU0d
         59Zp1Kex8YAnXlfsNI1ZvtQoda1kCIFQfvrJK48+P9gZ6cZxKC+yfJmslU61bzAeW7uG
         YkOV9WMglyjGPGSwKsoJB7EXgd3hMSJGp5VSY0ijxO2voRTr1jqYlLCSHRV7XjIJjnBc
         wcxQ==
X-Gm-Message-State: APjAAAX2tPWIQ9yyN20qkdIh9uDBCy752GLZenXYgmFrKAvrL6IkfBuC
        EB7CWAF+s0B8v6w2fTOWgbMr9qI9DGzaAuRhwhlZsQ==
X-Google-Smtp-Source: APXvYqxasa3YtuvrkVLTdP/ist4WZrp/LNp2iWxGNuSbwN7+h1+l/xw0EVq25Uqj/p5fWzGHS9WejmrxgwOgHAuN/+8=
X-Received: by 2002:a2e:80da:: with SMTP id r26mr2301865ljg.62.1566554437819;
 Fri, 23 Aug 2019 03:00:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190822031817.32888-1-yuehaibing@huawei.com>
In-Reply-To: <20190822031817.32888-1-yuehaibing@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 23 Aug 2019 12:00:26 +0200
Message-ID: <CACRpkdapgDbkm3JjywtPv=5gYKQCCXzdabDumVukFv5Dn5pomA@mail.gmail.com>
Subject: Re: [PATCH] gpio: Move gpiochip_lock/unlock_as_irq to gpio/driver.h
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Alexandre Courbot <acourbot@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 5:19 AM YueHaibing <yuehaibing@huawei.com> wrote:

> If CONFIG_GPIOLIB is not, gpiochip_lock/unlock_as_irq will
> conflict as this:
>
> In file included from sound/soc/codecs/wm5100.c:18:0:
> ./include/linux/gpio.h:224:19: error: static declaration of gpiochip_lock_as_irq follows non-static declaration
>  static inline int gpiochip_lock_as_irq(struct gpio_chip *chip,
>                    ^~~~~~~~~~~~~~~~~~~~
> In file included from sound/soc/codecs/wm5100.c:17:0:
> ./include/linux/gpio/driver.h:494:5: note: previous declaration of gpiochip_lock_as_irq was here
>  int gpiochip_lock_as_irq(struct gpio_chip *chip, unsigned int offset);
>      ^~~~~~~~~~~~~~~~~~~~
> In file included from sound/soc/codecs/wm5100.c:18:0:
> ./include/linux/gpio.h:231:20: error: static declaration of gpiochip_unlock_as_irq follows non-static declaration
>  static inline void gpiochip_unlock_as_irq(struct gpio_chip *chip,
>                     ^~~~~~~~~~~~~~~~~~~~~~
> In file included from sound/soc/codecs/wm5100.c:17:0:
> ./include/linux/gpio/driver.h:495:6: note: previous declaration of gpiochip_unlock_as_irq was here
>  void gpiochip_unlock_as_irq(struct gpio_chip *chip, unsigned int offset);
>      ^~~~~~~~~~~~~~~~~~~~~~
>
> Move them to gpio/driver.h and use CONFIG_GPIOLIB guard this.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: d74be6dfea1b ("gpio: remove gpiod_lock/unlock_as_irq()")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Patch applied with some fuzzing.

Yours,
Linus Walleij
