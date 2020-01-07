Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28CAC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F5D20848
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tuhkklja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbgAGKDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 05:03:07 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46662 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbgAGKDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 05:03:07 -0500
Received: by mail-lf1-f67.google.com with SMTP id f15so38413864lfl.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 02:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oKol1E5uFe81KlR9aKnDvrtZf1SzxED4CQaA/7Xrzzg=;
        b=tuhkkljaIaiJJmUSutuX9s49tqJJqqkeBY1ys9QSuul3nan94u8dWFgVt3mkhvDSL7
         EDUhKOUpqXWFMEnWjZbKjyfAI8UqHcUtDKq3ouBGxUTnWwieRa+yRkYhErpu/llu5eaN
         qkxjtVsp6ULjQmqaFBeFW9JN5YjEysKwOSox7x1yzuJZsuZSW19h6N2LLqtFBO3gf71a
         Fwb5Eq+c4UZ/4V64JiipmIfK4IO0154Od9v/4lGOP8UtsjUOAd/bT2TG+8JfueUtuaAe
         yFVZMyYKJ0Lm5NhUomnxkSePElrk45XMm5qnowkk175wim6tQxv6HsSpy3+OVK40ciyL
         XmgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oKol1E5uFe81KlR9aKnDvrtZf1SzxED4CQaA/7Xrzzg=;
        b=OxvyIS7UQdIKCTa1gqJnJhJpErMMMEuNVlTS0ou10jXwS67c1t7RDO0ij97wpfPWgy
         ygNT1f3r0JYENhhAd8S8zTO4ThpkbHuCiNI8Nm0Kj9gmicc21g42Rn2K1aojnOQuQi6e
         VQO2Ot8ApMFYgQli994ncE3/SG5vTlNvG/7OKwfI5xYSALqbPrxZBABC/LSJ65IEgBKa
         5KhH8p1gK4T3s/yHcGrc0+KBQXkbRbTA6v7p4JtnHbPj90FSo4u6LVWgmlnLlhTkTBoT
         LP8XcPUncL5pyuZdqGPuqP8RAL4WxbOxrhuLsj1KiPQ4w0WseI7ToGd4NVYem/j6KouB
         4UDQ==
X-Gm-Message-State: APjAAAUY+oeCsKLeUY/cWizbpo5YF9oUkws2nXquT0kR7VUGYj4ZpvWm
        evy6SuoldgwMqsL3J4bn5cE71rpWH5xgvEa1Y/OfaA==
X-Google-Smtp-Source: APXvYqyflFfe/fxFM4BmLdYxturyk1PQjv7lTfOtfJH89YmeXjrRU3ac0vEpHAQ+sVYd5gKsJQSyt7VB6pvdJtKdvNE=
X-Received: by 2002:ac2:55a8:: with SMTP id y8mr58521415lfg.117.1578391385288;
 Tue, 07 Jan 2020 02:03:05 -0800 (PST)
MIME-Version: 1.0
References: <20191224120709.18247-1-brgl@bgdev.pl> <20191224120709.18247-3-brgl@bgdev.pl>
In-Reply-To: <20191224120709.18247-3-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jan 2020 11:02:54 +0100
Message-ID: <CACRpkdZbehdStd2O_MKFLTWjfPaqCyM+Nimr16ZN9-UQOd+peA@mail.gmail.com>
Subject: Re: [PATCH v4 02/13] gpiolib: have a single place of calling set_config()
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 24, 2019 at 1:07 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Instead of calling the gpiochip's set_config() callback directly and
> checking its existence every time - just add a new routine that performs
> this check internally. Call it in gpio_set_config() and
> gpiod_set_transitory(). Also call it in gpiod_set_debounce() and drop
> the check for chip->set() as it's irrelevant to this config option.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
