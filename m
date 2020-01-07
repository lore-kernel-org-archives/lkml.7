Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B56C33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 818E920848
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ac4Fp/2J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbgAGJ5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 04:57:24 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33252 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgAGJ5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 04:57:23 -0500
Received: by mail-lj1-f194.google.com with SMTP id y6so46029549lji.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 01:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DqETa3KopmnqhBmKQkCkl339vUoTL40Ury4Oh30NJ/A=;
        b=Ac4Fp/2JiwxQnvSwiDOmhTdurlLEWHHCzqzuyfwkcBsclNUL5vfxkoJNCevMGeTHnG
         7XLr11elYPvivRsMhdIrZJWmkdb9AoEi77x8akM3w3dD17AI9da8Inmn7WasOJObO8Cz
         FG/UF2v8VM7gkk+YH5uSuCkYVjvQGeBNnPeQVHUrkHwdxzMh6Efntgn8lVj02p71KgQ1
         ROG0OMpjtcl+fsUQ9Sy2tMB9OrxyC2Gz+Ucw7iv5YhkgRC/v811RahDekBZ945xoj59q
         qDVCCYHsFk4BBpi0FFrSv+s0kwkMtSzN6EpdByzHJnGd1Ws/60dhLVfxhYjVRXY5ewXk
         iL2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DqETa3KopmnqhBmKQkCkl339vUoTL40Ury4Oh30NJ/A=;
        b=cxcbppaUAsposSzvMOQS6ECMvUTU3NWpLMbdp+X952aLaNsN8mkWQbQLT3ipE+DPmR
         GK8NXOFiLDfTQ14pYhSJkywVo0EK+mgW/8cI9f5fb6RiJVST1mZtwgPHjSYF0wcIn9bl
         9WZeGzpawQ/wZfali7csOopQahE0iVL+8TK/KVfNp2qvVU4rP8Q/KaXwdUcyRhrhKQKx
         X+tU7GVYVlT2szK8PqC92+9b2NOROUIlvUpYKGI0DYsMZGatdikxqg27RJsqvxIAtDGw
         fK8LDCXpnuZf+ZPKYjqTHy+/zDMiioI9fJJtz+/utWWPcrB3DVy2WqXWxhlWnry+68I6
         C94A==
X-Gm-Message-State: APjAAAU7Q/8r4L6D01DJYTNXNjxE20o6Epn+hc7ejVAYjhrOyF69gQOO
        Dzyp/e0aUNfEBC2llbgtPqLTJL63NVMvsvTXbbNJ82dZxg2HcQ==
X-Google-Smtp-Source: APXvYqw3FYN0uI4aImFcJ5taMInCUjiIIQMXZbeTsXdgGvHxycERpns4e+a3FYoFe4c64LOaTaRAaZ+9U5MhrFwiIOc=
X-Received: by 2002:a2e:85cd:: with SMTP id h13mr61158833ljj.191.1578391041640;
 Tue, 07 Jan 2020 01:57:21 -0800 (PST)
MIME-Version: 1.0
References: <20191204231931.21378-1-linus.walleij@linaro.org> <20191219170409.GH35479@atomide.com>
In-Reply-To: <20191219170409.GH35479@atomide.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jan 2020 10:57:10 +0100
Message-ID: <CACRpkdYm2b7G6dvmY5VCSSQCK6DMEYMYRqnoMpH6jaumkQL3Xg@mail.gmail.com>
Subject: Re: [PATCH] mfd: motorola-cpcap: Do not hardcode SPI mode flags
To:     Tony Lindgren <tony@atomide.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 6:04 PM Tony Lindgren <tony@atomide.com> wrote:

> * Linus Walleij <linus.walleij@linaro.org> [700101 00:00]:
> > The current use of mode flags to us SPI_MODE_0 and
> > SPI_CS_HIGH is fragile: it overwrites anything already
> > assigned by the SPI core. Change it thusly:
> >
> > - Just |= the SPI_MODE_0 so we keep other flags
> > - Assign ^= SPI_CS_HIGH since we might be active high
> >   already, and that is usually the case with GPIOs used
> >   for chip select, even if they are in practice active low.
> >
> > Add a comment clarifying why ^= SPI_CS_HIGH is the right
> > choice here.
>
> Looks like this breaks booting for droid4 with a cpcap
> PMIC, probably as regulators won't work. There's no GPIO
> controller involved in this case for the chip select, the
> pins are directly controlled by the spi-omap2-mcspi.c
> driver.
>
> From the pin muxing setup we see there's a pull-down on
> mcspi1_cs0 pin meaning it's active high:
>
> /* 0x4a100138 mcspi1_cs0.mcspi1_cs0 ae23 */
> OMAP4_IOPAD(0x138, PIN_INPUT_PULLDOWN | MUX_MODE0)
>
> My guess a similar issue is with similar patches for
> all non-gpio spi controllers?
>
> Let me know if you want me to test some other changes,
> or if this patch depends on some other changes.

So this must mean that something else is setting SPI_CS_HIGH
for this driver, such as the device tree, right?

And the |= SPI_CS_HIGH assignment in the driver is just
surplus and we should just delete this code instead.

Would that be right?

Yours,
Linus Walleij
