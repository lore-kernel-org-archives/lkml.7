Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09417C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 11:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D032D206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 11:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DoDl/MEa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfK0L7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 06:59:48 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44259 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfK0L7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 06:59:48 -0500
Received: by mail-lj1-f193.google.com with SMTP id g3so24126591ljl.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 03:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dLCduunuHSXGNUTQhWaOufnCLY7lqNqBFiB4mZ4JNs8=;
        b=DoDl/MEaINjRQjtZnw6j+sllNqlFQ2Ud3V4/8nhZS9c9EyqJ/1xeIVHnSsCPsI4Dfi
         y88vKb4l6iyCaIltTH1vCXx5aYw7cYBEFc87bNdXFiQlMUeKz89sYEZPpwKVH0VYOQRY
         pVG4oIJEO8+l653O0drH+vT5RKIgL0SHyN5IrlbKSdcHSzfi2lITCO3IbvStUrx7m4fV
         uBrag4rRI5vMht+Biw8n76OXpYU7Bp4CyNtTrovEcwi06lgT3hy3oZ5RqCX0T4Dw4yx1
         TYR7x7dysu/6aDOD3P+j3ttjsDI6mNLtixA9zA840AjdpOBA7l4pkqJxBgp6+XlwqcN5
         Y0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dLCduunuHSXGNUTQhWaOufnCLY7lqNqBFiB4mZ4JNs8=;
        b=BtPYIBVGFS5eAKLvKJugtpKjIxShBQFofqoiIT3339mbiEBOX2lmSApEgvYha1/LKH
         2F5sLWtpHEN803V7sVJWhiOj/YSCloiAJff9kQcgcN7dZJauQcMFZSBLODkyjmjekxL5
         Y/rXf0za5XJi2KwYl0k4SXpdeSYan1Skqy1QuuQhtRgR8/zNamgizxVALZzUXjn2I9+3
         kBO1iXfcerlxHs/RMsJWo/ubE5imDqrr2bY4iYf2UnifhOMoa6WwZK2FdFzHmBf4dYE+
         dxXmjkxpUOE9PA7/XXNwpWOxjwGWEhK3BlTgBGh7qd5b6E8FKAj7QSJUhEWg/C4UWhgH
         C/jg==
X-Gm-Message-State: APjAAAXyziTmBlcKpzsDNxOYv1mpPCaP4KQ5umLZSrorm+P8kMkJVOgR
        US4YovE7m6xAkz9KYnR9obGajfTfDK1S6UeghsIuSA==
X-Google-Smtp-Source: APXvYqyMH0ydSTB52zgCfl0ResjKY0F4jVlS0I0pF+C9gPsaStffZYckjWw+tuMq3O7qFPPgN6T3H0Qm/Jbm/6HHtZU=
X-Received: by 2002:a2e:b4f6:: with SMTP id s22mr18080062ljm.218.1574855986167;
 Wed, 27 Nov 2019 03:59:46 -0800 (PST)
MIME-Version: 1.0
References: <20191126164140.6240-1-ckeepax@opensource.cirrus.com>
 <CACRpkdYc=2vWte+gFp0m6RvWSu=+qT=WWUzag0N1FUBmbSCOOw@mail.gmail.com> <20191127115419.GA10451@ediswmail.ad.cirrus.com>
In-Reply-To: <20191127115419.GA10451@ediswmail.ad.cirrus.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 27 Nov 2019 12:59:34 +0100
Message-ID: <CACRpkdah5V7jDMUkDtdOb3RbR6mTsj5zs6g=Sb6KBZFRfme0rQ@mail.gmail.com>
Subject: Re: [PATCH] spi: cadence: Correct handling of native chipselect
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 12:54 PM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
> On Wed, Nov 27, 2019 at 11:42:47AM +0100, Linus Walleij wrote:
> > On Tue, Nov 26, 2019 at 5:41 PM Charles Keepax
> > <ckeepax@opensource.cirrus.com> wrote:
> > The original patch
> > f3186dd87669 ("spi: Optionally use GPIO descriptors for CS GPIOs")
> > came with the assumption that native chip select handler needed
> > was to be converted to always expect a true (1) value to their
> > ->set_cs() callbacks for asserting chip select, and this was one of
> > the drivers augmented to expect that.
> >
>
> Which is fine, I am not greatly invested in either symantics
> of the set_cs callback although if we were changing that we
> should have probably updated the kerneldoc comments for it.
>
> Although I do have a question if that is that case what is the
> expected way to handle the polarity of the chip select? Because
> it seems to me you would end up with each driver checking the
> SPI_CS_HIGH flag in set_cs and doing the invert locally, whereas
> with the pass the logic level system the core can centralise that
> inversion.

I guess I thought it was logical (hah!) that the core provide
a signal that is true if a condition is asserted, and then the
driver decides whether that drives the line low or high.

But just saying that the callback sets the physical level out
to the device works too, so the patch as-is:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

> > As
> > 3e5ec1db8bfe ("spi: Fix SPI_CS_HIGH setting when using native and GPIO CS")
> > essentially undo that semantic change and switches back to
> > the old semantic, all the drivers that were converted to expect
> > a high input to their ->set_cs() callbacks for asserting CS need
> > to be reverted back as well, but that didn't happen.
> >
> > So we need to fix not just cadence but also any other driver setting
> > ->use_gpio_descriptors() and also supplying their own
> > ->set_cs() callback and expecting this behaviour, or the fix
> > will have fixed broken a bunch of drivers.
> >
> > But we are lucky: there aren't many of them.
> > In addition to spi-cadence.c this seems to affect only spi-dw.c
> > and I suppose that is what Gregory was using? Or
> > something else?
> >
>
> I will go do some digging and see what I can find.

Thanks.

Yours,
Linus Walleij
