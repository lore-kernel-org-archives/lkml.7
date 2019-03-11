Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7984C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82EB42075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfCKJLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:11:33 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:38624 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbfCKJLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 05:11:32 -0400
Received: by mail-vk1-f194.google.com with SMTP id x140so874736vke.5;
        Mon, 11 Mar 2019 02:11:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gOMBFuAg6tGQpyMxinJOfKtYIWVXdAzkWOfCg4L0Ncg=;
        b=bL+rcaf8AgD131lOznNNkdRUadAAy6DHXrdhQr5jZwPIbKqW8PEpcani5vPv+z3hsn
         KFGEg6Bcy5aiUlQ/qLqNFw3bJuOE3K9sWNOJxG9rfbEbcS9a/vTBcF+o8VBzhVhiASoI
         SH+yBDU0ZZqQr5OTS4fEgWy8iYpa+8G6gM5nrT+4ob2O4Lthuaye5HyZaqsu+hbEGsLU
         xbQvEUA0ELU+1r3B2KDvign7H4LXt156XibRlfaxZA8PY6fXgLYa35W3BKWpT7veT4s2
         sN6iIWdAhGD9ygI7B7/zeP2Mk1+ec3g545KAa0ozLOYk1wIRqDq/NmY2SMPjAtd0+Ukr
         DbFw==
X-Gm-Message-State: APjAAAXvIWx5Ewrqe8EzIwwjfhQs++qTVYJCBHfXt2pFTVXcLR2YTYkR
        FP4lLdhubECrB/U7uGqFEvxEQsZ7gWfsMq6UoOc4bJg0
X-Google-Smtp-Source: APXvYqzjQeyKxRrYLrf8cn4Wcuu2w3hLi89RgbE3rX114BuJ9Jz+NZvocV3mY8j5lxDHBJtLVIlPyFj7o/IpIUFp4Dc=
X-Received: by 2002:a1f:be81:: with SMTP id o123mr16212939vkf.83.1552295491299;
 Mon, 11 Mar 2019 02:11:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190307155506.2993868-1-arnd@arndb.de>
In-Reply-To: <20190307155506.2993868-1-arnd@arndb.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 11 Mar 2019 10:11:19 +0100
Message-ID: <CAMuHMdWv3On3w9hqJUZ7oKNHxphhNZNN8JhN4oUgfyvu7C9XRg@mail.gmail.com>
Subject: Re: [PATCH] [v3] spi: work around clang bug in SPI_BPW_RANGE_MASK()
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Thu, Mar 7, 2019 at 4:55 PM Arnd Bergmann <arnd@arndb.de> wrote:
> Clang-8 evaluates both sides of a ?: expression to check for
> valid arithmetic even in the side that is never taken. This
> results in a build warning:
>
> drivers/spi/spi-sh-msiof.c:1052:24: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
>         .bits_per_word_mask = SPI_BPW_RANGE_MASK(8, 32),
>                               ^~~~~~~~~~~~~~~~~~~~~~~~~
>
> Change the implementation to use the GENMASK() macro that does
> what we want here but does not have a problem with the shift
> count overflow.
>
> Link: https://bugs.llvm.org/show_bug.cgi?id=38789
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for your patch!

> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -444,8 +444,7 @@ struct spi_controller {
>         /* bitmask of supported bits_per_word for transfers */
>         u32                     bits_per_word_mask;
>  #define SPI_BPW_MASK(bits) BIT((bits) - 1)
> -#define SPI_BIT_MASK(bits) (((bits) == 32) ? ~0U : (BIT(bits) - 1))
> -#define SPI_BPW_RANGE_MASK(min, max) (SPI_BIT_MASK(max) - SPI_BIT_MASK(min - 1))
> +#define SPI_BPW_RANGE_MASK(min, max) GENMASK((min) - 1, (max) - 1)

Shouldn't that be GENMASK((max) - 1, (min) - 1)?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
