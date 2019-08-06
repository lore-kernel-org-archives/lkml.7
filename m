Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84709C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 12:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A36620B1F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 12:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ORNp8Po4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731773AbfHFMpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 08:45:32 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37353 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729506AbfHFMpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 08:45:31 -0400
Received: by mail-lj1-f195.google.com with SMTP id z28so27914485ljn.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 05:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4/lcexmvHJxJRySjQLCY7ZSg7px+Zsdzgbj2vRh55qM=;
        b=ORNp8Po4jlU1yF5zQNBY9xOsg3dWFJsndVntCldzZfwE2dvd1gQAGIeb0ALvShYKcl
         PlQCtw4LUOADJYv4uW6LycNlGXGBQg6+gsH3SUWpLItFJ7IxdE3TrvfBfGXAYTQmOCag
         IJcOdeOCr8JwQGBvc5fW0zLZJEt/JZiy2r9i/U1vb4s7++axVma0KhqV7PrcdX9XxH1B
         dHiq7A4TuZhkQdqp4tP9mNLKW8VmzEH4zFr4H7Hg3GmMBONaYOh7I85gmG/oBp4WWC4z
         DcxsH65QoGDbTQLvRqVoL1IVpiDLHkWdSQ58RqL5bYH2uDHuD6hal8ha0KBDCpa6OWsZ
         OQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4/lcexmvHJxJRySjQLCY7ZSg7px+Zsdzgbj2vRh55qM=;
        b=pobml791IUm5RU6Weqbf1Aa8vRQJk0E7r/Rlh8jksnX0kdN5EdpK8IGqHDuTvbhbJp
         sYgG+NpOIc74sF3m+hFVhZT4Bvkv83Xw6hHarTnZy6vI6HOFSlguQ9w2hSxAvWtCKBIV
         aZ7/43MuAQEXm3atCYzgXate2e4bE0+h1zb9mXlkvHsoeQo7+DxilsmByVwPoEJiD1El
         mmRWWvM5Vnhxvh8C7PZVG577zXNW1taVGwJwUGCmNl2+USBiTA2PKqudfHDciH0fkA/r
         Q41Vxs0mC5qWpWEdOi92VfvQIXytJQJQVWp2Ywvw1wQWZBcufYlVVQ5+JvbvwC8RKzeu
         gD2A==
X-Gm-Message-State: APjAAAWgIh2nvmjvZm3HnC4j0eFxq1lniQqzpJqWOvjUwNezza7jK0j1
        d9GBBvcJCnllkfCagw5aBb1QbwgMdIcrRIKRFGQ0Qg==
X-Google-Smtp-Source: APXvYqyJB6V5f6X4ZYTw/Dx96rRsmFRZ8lQ78ZU+eRN4u7Jr+fYSV9bRsgd9LYigvv9O3QXhRfadXQjQILbPAtIBTCA=
X-Received: by 2002:a2e:8195:: with SMTP id e21mr1619698ljg.62.1565095529681;
 Tue, 06 Aug 2019 05:45:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190731123814.46624-1-yuehaibing@huawei.com>
In-Reply-To: <20190731123814.46624-1-yuehaibing@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 6 Aug 2019 14:45:17 +0200
Message-ID: <CACRpkdYoCXP=LaGSFhAuTZJUB6p=YVRpBhsqCp9S67yJZiChVg@mail.gmail.com>
Subject: Re: [PATCH] gpio: Fix build error of function redefinition
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 2:39 PM YueHaibing <yuehaibing@huawei.com> wrote:

> when do randbuilding, I got this error:
>
> In file included from drivers/hwmon/pmbus/ucd9000.c:19:0:
> ./include/linux/gpio/driver.h:576:1: error: redefinition of gpiochip_add_pin_range
>  gpiochip_add_pin_range(struct gpio_chip *chip, const char *pinctl_name,
>  ^~~~~~~~~~~~~~~~~~~~~~
> In file included from drivers/hwmon/pmbus/ucd9000.c:18:0:
> ./include/linux/gpio.h:245:1: note: previous definition of gpiochip_add_pin_range was here
>  gpiochip_add_pin_range(struct gpio_chip *chip, const char *pinctl_name,
>  ^~~~~~~~~~~~~~~~~~~~~~
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 964cb341882f ("gpio: move pincontrol calls to <linux/gpio/driver.h>")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Yeah those get covered twice these days I suppose.

Patch applied, good catch.

Yours,
Linus Walleij
