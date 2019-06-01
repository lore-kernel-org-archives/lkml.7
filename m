Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C884BC28CC3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 21:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9476A277C5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 21:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v5Rg1RqE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfFAV6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 17:58:00 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:40112 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfFAV57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 17:57:59 -0400
Received: by mail-lf1-f44.google.com with SMTP id a9so9280246lff.7
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2019 14:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iX4aUvP8mUEVM8HdWg49o9RU01eQ7XewzcFBTY3Bx24=;
        b=v5Rg1RqEiQjot+YKwJ+PhDGLJoCQJd8cYJq7XmjmWMf2QH01fGW4x/Z5ORituEhHJs
         uiKgOIIGIk1S+p+Ass+7N5+tZd89QzUbJTE6k48A3Q7qJCcFOQqjQnsJTpzox6RyPGxs
         +tqoa7EbDvSNfVsjq/Gqoeht11e4W1EerkKbVIyOXXkAeZwj9DTl1iT5jFOuX4o/53yT
         kQ8zzjlohBzeR90fAbuL9SAXXZix82l6hVNabjHnRL9CRR975mtb0s64+kmGCaxDSAoQ
         xa0StwixDXdTJRxnWe2jUMxiC+ao9SqvpWi5v/Wmrq6unOGvktH7uTy7K39zHyXXQZ/4
         RKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iX4aUvP8mUEVM8HdWg49o9RU01eQ7XewzcFBTY3Bx24=;
        b=snJH8odevD/sdqRsZhlwyO74wWtTqo2ys0QG32mcjS1sCpt7/g9wG9qEZTBk20INz6
         nMGzhQmOlA4yfSSIDR64PQLxIx8vGIY1xtUFvLC8hPM4IzX0Uk6iG3Okk2GpDdvtOysO
         MDNB0zfy8QX3GMI2Glr9pSmBqjEygYleXCTbSjhShHJ1DRFxCYlp/t25Gsv4Cqy2xhaN
         iNt0cBiVqhvbAPCGkCjlQkAI6oDBeFYvnhT5o9Alh/d5vdYteqppO2eIpXCnttWxwG/q
         ia5KQXB3mJBYD8oj5KN5pbe1L7dzoWVpyD6cETg4qdgMmh5WlBbuS4ck53OvR3pkfdTv
         iYfA==
X-Gm-Message-State: APjAAAUcKPN6szKzMDXL5CJWB9RD45XnRu6JzgbPDzbJC/Gv5OS1VsCF
        sSJxS4JuPpDebuXZUTrNzr9S2nmfcjFEH1FHvdUbeg==
X-Google-Smtp-Source: APXvYqw0XTvysBl/m/dr9Q5wGY5haXlZTXPgYUORtBrHw14mtkac6rnJP8Fn/UKwu14kYqlIb9d/EVQ/Ux/B6/DDXgM=
X-Received: by 2002:a19:6a01:: with SMTP id u1mr7878184lfu.141.1559426277981;
 Sat, 01 Jun 2019 14:57:57 -0700 (PDT)
MIME-Version: 1.0
References: <F29452FD-AFA4-422B-992C-D348FEEAE0E2@goldelico.com>
In-Reply-To: <F29452FD-AFA4-422B-992C-D348FEEAE0E2@goldelico.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 1 Jun 2019 23:57:46 +0200
Message-ID: <CACRpkdajVu2H-9zX4gAEnHHR8gd=4jseabLGsHB=0CF1BKH-JA@mail.gmail.com>
Subject: Re: BUG: gpio: pca953x: 24 bit expanders broken since v5.2-rc1
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Nandor Han <nandor.han@vaisala.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 7:06 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:

> Now, this was not a (visible) problem until patch
>
>         8b9f9d4dc511 regmap: verify if register is writeable before writing operations
>
> enforces to check the register number before invoking the
> callback pca953x_writeable_register(). pca953x_writeable_register()
> seems to know about REG_ADDR_AI (through reg & REG_ADDR_MASK) and
> accepts 0x88 as a valid register number.
>
> After the regmap patch the register is checked against
> pca953x_i2c_regmap.max_register before applying REG_ADDR_MASK
> and 0x88 is obviously beyond, explaining the symptom.

Can we simply bump the .max_register in
pca953x_i2c_regmap to 0xff for a quick fix with a comment
FIXME to figure it out the right way?

Yours,
Linus Walleij
