Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F20C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 04:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F3162087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 04:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="K0yoKnbk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfCLEhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 00:37:51 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:30664 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfCLEhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 00:37:51 -0400
X-Greylist: delayed 2657 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Mar 2019 00:37:49 EDT
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x2C4bX7v022072;
        Tue, 12 Mar 2019 13:37:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x2C4bX7v022072
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1552365454;
        bh=gGqYPnNxjzKwejtPG0Lu8ls9pEA8iEN51XnZ6DbVJeI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K0yoKnbkC3gLrvMny9LThbAUIEgLw21+p39EXD6Gd2jlDY5eVkFxbr/YEnTmqvpea
         HGg0H3Zch7W/naUbiTUd8gyyJfn2HgGCvmYdFQGwBcPC3xO7eUb5iYGukApwS0WYOd
         jsbCMEJtZfB6kMEeWO2bN5AdMOs5IH5PWKNMF7IlRZODCyhrIUlBY2VmFiH3chT5Vo
         Ul+i4Fv4bz3XOvYJTuRNDuCIJbjlI3Ceh2jJkVUSOotwWb3nYC5gdT75DwHieDL3IB
         pWEo6tM9NTDhLkOpZEXMSMjYMqdOI77CEZYhJDY5afJaXAEHM8mAEqAyKd+Me1nWWS
         PsyxUKrb7BMow==
X-Nifty-SrcIP: [209.85.221.176]
Received: by mail-vk1-f176.google.com with SMTP id p190so20373vke.4;
        Mon, 11 Mar 2019 21:37:34 -0700 (PDT)
X-Gm-Message-State: APjAAAVKyfAfC87E+c7wt2GQ8rfk2mW5Vgp0v+OCbBjsWyZP2PmkeaYO
        Ydj4emSun+FvNOxQPLaThS4rjdXAMYJy6XW9x5E=
X-Google-Smtp-Source: APXvYqzAX7PjH9QFfqFbINq0LOrsZ3JLF8yyFkr/s1AW7/2KCimSi/YC5IWNtIDOGQ6CUvYXM097PpoEdOGOugtcF/U=
X-Received: by 2002:a1f:1d01:: with SMTP id d1mr4639902vkd.0.1552365453262;
 Mon, 11 Mar 2019 21:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1551598603.git.vilhelm.gray@gmail.com> <0840d55707dacd1121659723246fa9f55737f426.1551598603.git.vilhelm.gray@gmail.com>
In-Reply-To: <0840d55707dacd1121659723246fa9f55737f426.1551598603.git.vilhelm.gray@gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 12 Mar 2019 13:36:57 +0900
X-Gmail-Original-Message-ID: <CAK7LNARRqYb_ovO_ccQ8xTLTzNYyTEK8whT2r0cq_AqpWqeNXg@mail.gmail.com>
Message-ID: <CAK7LNARRqYb_ovO_ccQ8xTLTzNYyTEK8whT2r0cq_AqpWqeNXg@mail.gmail.com>
Subject: Re: [PATCH v9 9/9] gpio: uniphier: Utilize for_each_set_clump8 macro
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        bgolaszewski@baylibre.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 3, 2019 at 4:51 PM William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:
>
> Replace verbose implementation in set_multiple callback with
> for_each_set_clump8 macro to simplify code and improve clarity. An
> improvement in this case is that banks that are not masked will now be
> skipped.
>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  drivers/gpio/gpio-uniphier.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpio/gpio-uniphier.c b/drivers/gpio/gpio-uniphier.c
> index 0f662b297a95..df640cb29b9c 100644
> --- a/drivers/gpio/gpio-uniphier.c
> +++ b/drivers/gpio/gpio-uniphier.c
> @@ -15,9 +15,6 @@
>  #include <linux/spinlock.h>
>  #include <dt-bindings/gpio/uniphier-gpio.h>
>
> -#define UNIPHIER_GPIO_BANK_MASK                \
> -                               GENMASK((UNIPHIER_GPIO_LINES_PER_BANK) - 1, 0)
> -
>  #define UNIPHIER_GPIO_IRQ_MAX_NUM      24
>
>  #define UNIPHIER_GPIO_PORT_DATA                0x0     /* data */
> @@ -147,15 +144,14 @@ static void uniphier_gpio_set(struct gpio_chip *chip,
>  static void uniphier_gpio_set_multiple(struct gpio_chip *chip,
>                                        unsigned long *mask, unsigned long *bits)
>  {
> -       unsigned int bank, shift, bank_mask, bank_bits;
> -       int i;
> +       unsigned int i;
> +       unsigned long bank_mask;
> +       unsigned int bank;
> +       unsigned int bank_bits;
>
> -       for (i = 0; i < chip->ngpio; i += UNIPHIER_GPIO_LINES_PER_BANK) {
> +       for_each_set_clump8(i, bank_mask, mask, chip->ngpio) {
>                 bank = i / UNIPHIER_GPIO_LINES_PER_BANK;
> -               shift = i % BITS_PER_LONG;
> -               bank_mask = (mask[BIT_WORD(i)] >> shift) &
> -                                               UNIPHIER_GPIO_BANK_MASK;
> -               bank_bits = bits[BIT_WORD(i)] >> shift;
> +               bank_bits = bitmap_get_value8(bits, chip->ngpio, i);
>
>                 uniphier_gpio_bank_write(chip, bank, UNIPHIER_GPIO_PORT_DATA,
>                                          bank_mask, bank_bits);


Please do not do this.

Nothing in this driver says the GPIO width is 8-bit.

You are hard-coding '8-bit'.







> --
> 2.21.0
>


-- 
Best Regards
Masahiro Yamada
