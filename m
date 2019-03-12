Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2987C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 822A32147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POqBjfSp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfCLH23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 03:28:29 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:54717 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfCLH22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 03:28:28 -0400
Received: by mail-it1-f195.google.com with SMTP id w18so2800214itj.4;
        Tue, 12 Mar 2019 00:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pGH9hXHyWER1pzm+u0uu4GolUUMTfbEFKb7Hx7Ab1a0=;
        b=POqBjfSpw237O6zafNWy3TXebdvmelN33JuEv5KOCALT9ol+B/rxb4LDXQuYaMJGlC
         xZgePmcPsyMY0bYQGexZjA9D1iVHXUnnWuOHrPbCAQ10zrWvVl0Ty4nfnQCVaAXELYOh
         gm0oT1hkqUrz1vBdkh/lVSCcAQnSHn0PbBPK7/6ZajJXipCxRgX16tVwT4eH882nOg5s
         GRB526Q82bw/W0Hr2zF9SiLHr5Z+GX94caJXdFhRJOXX7awyBZD9byQb4kS+LbB9qxbW
         hAyxHE/KRmQ4LQ+9E9bosXTYrlagNZ5Rc8rgb3+/B+aFc2SGAPy4pWHnxlh7Nfb/e9di
         6WMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pGH9hXHyWER1pzm+u0uu4GolUUMTfbEFKb7Hx7Ab1a0=;
        b=UWxfZTipuWcaeIWRS1NU7KsKYRHC3//c+pAbLPi/Z40ghNUeKDj+aWpcTkNGcT99vh
         wjss9ys66gRvKb1QPevP9Vf83ezNfS23CqC6O4HMmViaOobIDqMTb0SZfw9iFFXw4v8N
         9Fp3lBdpG78vweR47qsFPi7dk2tZZVDbkJ6JAcFnygOr3LaH+YT04nQd+nzm0LM7vOYa
         8dSJPhQ/up2t75g7Zoye4lt+2uBOeedARBuIyUhlGzszJNaKib9K19R1NF6kYtvCQJ1l
         EhE5C02PgVHwhrgQXqYnpKOWv81hBObTdxoYm/hWNCDkqugLW0kI06JqO9O+lHCtwJwL
         nAnA==
X-Gm-Message-State: APjAAAVjSr9NtvyokSZy5puzcB0J4STKf7foo1Jh0gH3OoD8utCgCOup
        AfPjSNmRqsTF39PPreXdOXs=
X-Google-Smtp-Source: APXvYqxHmJIesELkAUVHhYJBu7fCXcjUEEHHegnqY/1JirI+FJjFiyvRjFogljWslviP9cCxbj3Lnw==
X-Received: by 2002:a24:7d94:: with SMTP id b142mr1223093itc.136.1552375707571;
        Tue, 12 Mar 2019 00:28:27 -0700 (PDT)
Received: from icarus ([2001:268:c0a3:c255:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id q133sm934219itb.19.2019.03.12.00.28.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 00:28:26 -0700 (PDT)
Date:   Tue, 12 Mar 2019 16:29:23 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        bgolaszewski@baylibre.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v9 9/9] gpio: uniphier: Utilize for_each_set_clump8 macro
Message-ID: <20190312072923.GB2898@icarus>
References: <cover.1551598603.git.vilhelm.gray@gmail.com>
 <0840d55707dacd1121659723246fa9f55737f426.1551598603.git.vilhelm.gray@gmail.com>
 <CAK7LNARRqYb_ovO_ccQ8xTLTzNYyTEK8whT2r0cq_AqpWqeNXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK7LNARRqYb_ovO_ccQ8xTLTzNYyTEK8whT2r0cq_AqpWqeNXg@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 01:36:57PM +0900, Masahiro Yamada wrote:
> On Sun, Mar 3, 2019 at 4:51 PM William Breathitt Gray
> <vilhelm.gray@gmail.com> wrote:
> >
> > Replace verbose implementation in set_multiple callback with
> > for_each_set_clump8 macro to simplify code and improve clarity. An
> > improvement in this case is that banks that are not masked will now be
> > skipped.
> >
> > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > ---
> >  drivers/gpio/gpio-uniphier.c | 16 ++++++----------
> >  1 file changed, 6 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-uniphier.c b/drivers/gpio/gpio-uniphier.c
> > index 0f662b297a95..df640cb29b9c 100644
> > --- a/drivers/gpio/gpio-uniphier.c
> > +++ b/drivers/gpio/gpio-uniphier.c
> > @@ -15,9 +15,6 @@
> >  #include <linux/spinlock.h>
> >  #include <dt-bindings/gpio/uniphier-gpio.h>
> >
> > -#define UNIPHIER_GPIO_BANK_MASK                \
> > -                               GENMASK((UNIPHIER_GPIO_LINES_PER_BANK) - 1, 0)
> > -
> >  #define UNIPHIER_GPIO_IRQ_MAX_NUM      24
> >
> >  #define UNIPHIER_GPIO_PORT_DATA                0x0     /* data */
> > @@ -147,15 +144,14 @@ static void uniphier_gpio_set(struct gpio_chip *chip,
> >  static void uniphier_gpio_set_multiple(struct gpio_chip *chip,
> >                                        unsigned long *mask, unsigned long *bits)
> >  {
> > -       unsigned int bank, shift, bank_mask, bank_bits;
> > -       int i;
> > +       unsigned int i;
> > +       unsigned long bank_mask;
> > +       unsigned int bank;
> > +       unsigned int bank_bits;
> >
> > -       for (i = 0; i < chip->ngpio; i += UNIPHIER_GPIO_LINES_PER_BANK) {
> > +       for_each_set_clump8(i, bank_mask, mask, chip->ngpio) {
> >                 bank = i / UNIPHIER_GPIO_LINES_PER_BANK;
> > -               shift = i % BITS_PER_LONG;
> > -               bank_mask = (mask[BIT_WORD(i)] >> shift) &
> > -                                               UNIPHIER_GPIO_BANK_MASK;
> > -               bank_bits = bits[BIT_WORD(i)] >> shift;
> > +               bank_bits = bitmap_get_value8(bits, chip->ngpio, i);
> >
> >                 uniphier_gpio_bank_write(chip, bank, UNIPHIER_GPIO_PORT_DATA,
> >                                          bank_mask, bank_bits);
> 
> 
> Please do not do this.
> 
> Nothing in this driver says the GPIO width is 8-bit.
> 
> You are hard-coding '8-bit'.

The for_each_set_clump8 macro is hardcoded to 8-bit clumps because the
current drivers utilizing this functionality are only updating their
GPIO ports 8-bits at a time.

However, if this driver updates more or less GPIO at a time, we can
easily update the macro by replacing the hardcoded '8' value with a
variable, thus giving us the generic for_each_set_clump macro.

How many GPIO can be updated at a time for this device?

William Breathitt Gray

> 
> 
> 
> 
> 
> 
> 
> > --
> > 2.21.0
> >
> 
> 
> -- 
> Best Regards
> Masahiro Yamada
