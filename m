Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67232C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A422085A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Si0j31Od"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfCNMwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 08:52:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46147 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbfCNMwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 08:52:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id a22so3886400pgg.13;
        Thu, 14 Mar 2019 05:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gHnxiEWi8bAx6whmXpEGa6h2OxzdSKhrCI9EyjEHDVQ=;
        b=Si0j31OdnVGkGZG1omMwaclv+pt74KatVoxcrkwptRbyiPkkjalPWgS1tu2InB3WIS
         9kL82SQHGxMJZuOfMJxAjnfTuxhG1vCYNAX5JAawXFFOQ7IA3uWeH/cgYac82wcvDyUG
         8vWnlneNv8dqDaXN+w+1s1AGe44LN1IrAInKrjQEirn9s9/1qU9SVaUNe7I3aphsNT0q
         D9aydInnkTTY/Xkojj5fabsaow3MWma8bAzS9+cq9Tpbrj2jb/x4wjKZ2KnaIWTmwxgZ
         On7Eoa57wQX6MTVefa5U/OJZCvZ7g+MWjoHGMMsqoROB7Yq4I0/62jGsvR1ty2l59ctq
         B9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gHnxiEWi8bAx6whmXpEGa6h2OxzdSKhrCI9EyjEHDVQ=;
        b=qZ3vJv8n1kA2ApscYrrYCKm44azjkst5j5mOplcnofPgvEiGVYWrhy3kKCilSaoKkd
         lIgBzrmjxKzZiwQQutC8wKRY+T/LuNyC/w7BUcvJetS7iwTnyg7IUJZM4ihHcs3loETB
         yMgk+pufmq7PjVUd7l8DHHa3qP46UGW2PtvTw+vNnzGtQ4ei/8UGUAtqXYVBxUYGTKNB
         5msq1d+SzBVFTHa+a+EJyoDLpg1A5yklYWOE6pfodsqvpWx8Rwm0oLA+F42JhqBwJHhj
         5simxCQIZjCLY+s7711R8bQMxwXGKpMXCbDXVKUMHVqcbEykTkT5De1jXkqxmoJEW/vK
         wb2w==
X-Gm-Message-State: APjAAAUzDpapRHmiXSC0WjNTtoFkcYIKqZv96KQ0eNZARHVyLJbStxlH
        ZMxqtSLHDfSBmynNkeKaytM=
X-Google-Smtp-Source: APXvYqzPdoKhJWHaoErLZ0GwHdF3SRV/GcKv0NwGOK6Lm8dmo6DaXudbKD2gRcRKhsJxQADvGmA3Rg==
X-Received: by 2002:a62:b801:: with SMTP id p1mr49183833pfe.25.1552567943592;
        Thu, 14 Mar 2019 05:52:23 -0700 (PDT)
Received: from icarus ([2001:268:c0a4:3974:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id f3sm21565821pfn.100.2019.03.14.05.52.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Mar 2019 05:52:22 -0700 (PDT)
Date:   Thu, 14 Mar 2019 21:53:08 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     yamada.masahiro@socionext.com
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v10 09/10] gpio: uniphier: Utilize for_each_set_clump8
 macro
Message-ID: <20190314125308.GA7400@icarus>
References: <cover.1552566113.git.vilhelm.gray@gmail.com>
 <9487b6bd8f9c2242448729f5f8fc9534f724b221.1552566114.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9487b6bd8f9c2242448729f5f8fc9534f724b221.1552566114.git.vilhelm.gray@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 09:32:37PM +0900, William Breathitt Gray wrote:
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
> -#define UNIPHIER_GPIO_BANK_MASK		\
> -				GENMASK((UNIPHIER_GPIO_LINES_PER_BANK) - 1, 0)
> -
>  #define UNIPHIER_GPIO_IRQ_MAX_NUM	24
>  
>  #define UNIPHIER_GPIO_PORT_DATA		0x0	/* data */
> @@ -147,15 +144,14 @@ static void uniphier_gpio_set(struct gpio_chip *chip,
>  static void uniphier_gpio_set_multiple(struct gpio_chip *chip,
>  				       unsigned long *mask, unsigned long *bits)
>  {
> -	unsigned int bank, shift, bank_mask, bank_bits;
> -	int i;
> +	unsigned int i;
> +	unsigned long bank_mask;
> +	unsigned int bank;
> +	unsigned int bank_bits;
>  
> -	for (i = 0; i < chip->ngpio; i += UNIPHIER_GPIO_LINES_PER_BANK) {
> +	for_each_set_clump8(i, bank_mask, mask, chip->ngpio) {
>  		bank = i / UNIPHIER_GPIO_LINES_PER_BANK;
> -		shift = i % BITS_PER_LONG;
> -		bank_mask = (mask[BIT_WORD(i)] >> shift) &
> -						UNIPHIER_GPIO_BANK_MASK;
> -		bank_bits = bits[BIT_WORD(i)] >> shift;
> +		bank_bits = bitmap_get_value8(bits, chip->ngpio, i);
>  
>  		uniphier_gpio_bank_write(chip, bank, UNIPHIER_GPIO_PORT_DATA,
>  					 bank_mask, bank_bits);
> -- 
> 2.21.0

Masahiro,

I noticed this loops per GPIO bank and uniphier_gpio_bank_write is
called each time to update the respective bank. The
uniphier_gpio_reg_update function however is calling writel to update
the registers; yet only 8 bits (UNIPHIER_GPIO_LINES_PER_BANK) are
updated at a time via the uniphier_gpio_bank_write call in the
uniphier_gpio_set_multiple function.

Can more than one bank be updated at a time via writel (e.g. 4 banks at
8 bits per bank via a single 32-bit writel call)? If so, instead of
using the for_each_set_clump8 macro, it may be more efficient to loop
through 4 banks at a time.

William Breathitt Gray
