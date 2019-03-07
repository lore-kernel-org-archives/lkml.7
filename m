Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF1CC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 13:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E7E2081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 13:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbfCGNXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 08:23:17 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35628 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfCGNXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 08:23:17 -0500
Received: by mail-qk1-f194.google.com with SMTP id z13so8967975qki.2;
        Thu, 07 Mar 2019 05:23:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VcXqOWQd/ONUAyrrvLnGtQjvlVul55HUUMGqVY9zkpw=;
        b=C/si3cdwKrr2VsKTiKtlsf1TkSPdKX6alLFl1VXX2kjVmoE+fKQXNG1JZOf5nFZL0a
         msi3v4zrOH2IkcTl5vtM2fRomeZvORqpgPS1HhVuCYu6qHjXVV9gyfqOFsM+J06fhD6b
         HMWKnDNdsSNVCc4GjwheFQd5JjX61U7867EuO0wvfvlSVNlXcNaTpZBMqBiKmlffJRQ2
         7aDhBNmjznHnIxfXnzQLqczhldgJuE7MbX1VzcTPZvQimdKa42vF3Rj85OtvE9r3vsCy
         1uhEX59p5RUgE5w095wkgrVB64JCw6AoomTuU9v9OfmhFnqWscPo9I1UfI7Y3YktCpVf
         ib5w==
X-Gm-Message-State: APjAAAWw56wndU08sqRJHvL3A8xOfa+IX8p2Viu+C6r0/4D5bvfP/eU9
        JzetnVcbwZhc16h3iGxCXkfn6nfjG7sX/1b7vCY=
X-Google-Smtp-Source: APXvYqx/4De5+WruhE/8WJPWFNNY0IBsASjOIl3fCbZqeMLJsLLPiYZq2zeT/7YGURr5RsnhtHfAAIoP3g57zH0pzbA=
X-Received: by 2002:a05:620a:1478:: with SMTP id j24mr9279941qkl.343.1551964996081;
 Thu, 07 Mar 2019 05:23:16 -0800 (PST)
MIME-Version: 1.0
References: <20190307105619.2780591-1-arnd@arndb.de> <bc0e18db-9606-6f11-facf-2ca593118ef1@rasmusvillemoes.dk>
In-Reply-To: <bc0e18db-9606-6f11-facf-2ca593118ef1@rasmusvillemoes.dk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 7 Mar 2019 14:22:59 +0100
Message-ID: <CAK8P3a1B7PakyYxT88v5Du+5CQZNCiA5xJ_Q4DtSSsGaM7FCnA@mail.gmail.com>
Subject: Re: [PATCH] spi: work around clang bug in SPI_BPW_RANGE_MASK()
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Mark Brown <broonie@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 2:09 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 07/03/2019 11.56, Arnd Bergmann wrote:
> > Clang-8 evaluates both sides of a ?: expression to check for
> > valid arithmetic even in the side that is never taken. This
> > results in a build warning:
> >
> > drivers/spi/spi-sh-msiof.c:1052:24: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
> >         .bits_per_word_mask = SPI_BPW_RANGE_MASK(8, 32),
> >                               ^~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > Change it to shift one less than we want, and then shift one
> > more bit afterwards. This should give the correct result for
> > all valid input, since it has to be in the range 1..32 anyway.
>
> Why not use GENMASK which is provided by the same header that #defines BIT?

It might be an options, but

- I had not thought of it
- It looks like it would have the same problem with shifting right by
32 bits (?)
- it seems to have slightly different semantics from SPI_BPW_RANGE_MASK(),
  counting the bits from 0 instead of 1.

I tried this version now, which doesn't produce any warnings as far as I can
tell, but I'm not convinced that it's actually correct. Can you have a look?

#define SPI_BPW_RANGE_MASK(min, max) GENMASK((min) - 1, (max) - 1)

       Arnd
