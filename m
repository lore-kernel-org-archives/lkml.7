Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4741C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 10:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87FE62070A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 10:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ggKnvTb3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfK0KnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 05:43:02 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46189 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfK0KnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 05:43:02 -0500
Received: by mail-lf1-f68.google.com with SMTP id a17so16715684lfi.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 02:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4bSZtYSKRzzSpgbvHLlRlvm4/VSvnoysG6GlVXihnl0=;
        b=ggKnvTb3rsJToKxbuhyxwAbfRBemmGkw8JZt/E9J/1dva2aqZ56jv3tvhwXZI/lTDT
         5f6wo5LpHRqnMAejwyytGjAdGro3Cq2DWfIJWELdiBbag2RHMjmZqhl3kDypKRaBPnqM
         Y/f6UBfRriLjYDBLpmql0qGv/rDbQfWjp7BJg9bgwQeF/jMHPwXEa4GWTnYiPAwhPb5e
         XD7b98K1+F/mjCoL4AWYXhzzo03som5qUjjmDPIcZMy4w8Vou9qns3GllacfRtdsQKPt
         nDWvssfwI5q+Ay/+b6l+10d/cA3oC9alMPeAj31Wd8lTnp1uiRm7OmJOUySUV3n1Z8BF
         n7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4bSZtYSKRzzSpgbvHLlRlvm4/VSvnoysG6GlVXihnl0=;
        b=ev2QW/1IJsrucn6RAU6EHRW7clxG5aqfXDQkSuM3yyR21inFTioWNuwRPP53hWb9Qr
         TLrFSpe6l1l3DC4HdPa0jRp9pw4As57o6v1ToRg+BQNg2/GiycaaNAwm0VfrTxFv5wms
         BuFxPX5GJ0sNOkVgkaEME4uveVXaxB7Dls8P24O4Qj0ef2+Kg6//9KvW2ILeevOgocul
         5W49Poyn1JSOPgwONyMUNLH49I0+Bas4C9YtNgDUpWBF1XKp7Ihx0GJq2ks64iNi4J9n
         TmQILsOSEnBeHWRzuYRmSo8nNRthfEhLHGHxEHw/NRZpnpFxpMAQFGbhJ6bjTGFggs7O
         Y9mw==
X-Gm-Message-State: APjAAAWhCRcmaNCvmbFG3l6VgT6kzf00t4gvjjURCpzcIiqBMCllbX44
        5G3+30zMUvkW79VdaebmvpzoMeFn2D4UOlMQu4VGuw==
X-Google-Smtp-Source: APXvYqw0axWlyE9Xf7qKCdQKDA51b0gvm1OnGchTmMmRVTBeWX1iAOF60Ns4IfePT38SeObuWmaWludZTP46LMj/Nog=
X-Received: by 2002:a19:7d02:: with SMTP id y2mr26825678lfc.86.1574851379646;
 Wed, 27 Nov 2019 02:42:59 -0800 (PST)
MIME-Version: 1.0
References: <20191126164140.6240-1-ckeepax@opensource.cirrus.com>
In-Reply-To: <20191126164140.6240-1-ckeepax@opensource.cirrus.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 27 Nov 2019 11:42:47 +0100
Message-ID: <CACRpkdYc=2vWte+gFp0m6RvWSu=+qT=WWUzag0N1FUBmbSCOOw@mail.gmail.com>
Subject: Re: [PATCH] spi: cadence: Correct handling of native chipselect
To:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Gregory Clement <gregory.clement@bootlin.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Charles!

Thanks for finding this!

On Tue, Nov 26, 2019 at 5:41 PM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:

> To fix a regression on the Cadence SPI driver, this patch reverts
> commit 6046f5407ff0 ("spi: cadence: Fix default polarity of native
> chipselect").
>
> This patch was not the correct fix for the issue. The SPI framework
> calls the set_cs line with the logic level it desires on the chip select
> line, as such the old is_high handling was correct. However, this was
> broken by the fact that before commit 3e5ec1db8bfe ("spi: Fix SPI_CS_HIGH
> setting when using native and GPIO CS") all controllers that offered
> the use of a GPIO chip select had SPI_CS_HIGH applied, even for hardware
> chip selects. This caused the value passed into the driver to be inverted.
> Which unfortunately makes it look like a logical enable the chip select
> value.
>
> Since the core was corrected to not unconditionally apply SPI_CS_HIGH,
> the Cadence driver, whilst using the hardware chip select, will deselect
> the chip select every time we attempt to communicate with the device,
> which results in failed communications.
>
> Fixes: 3e5ec1db8bfe ("spi: Fix SPI_CS_HIGH setting when using native and GPIO CS")
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>

I kind of get it... I think.

I see it fixes a patch that I was not CC:ed on, which is a bit unfortunate
as it tries to fix something I wrote, but such things happen.

The original patch
f3186dd87669 ("spi: Optionally use GPIO descriptors for CS GPIOs")
came with the assumption that native chip select handler needed
was to be converted to always expect a true (1) value to their
->set_cs() callbacks for asserting chip select, and this was one of
the drivers augmented to expect that.

As
3e5ec1db8bfe ("spi: Fix SPI_CS_HIGH setting when using native and GPIO CS")
essentially undo that semantic change and switches back to
the old semantic, all the drivers that were converted to expect
a high input to their ->set_cs() callbacks for asserting CS need
to be reverted back as well, but that didn't happen.

So we need to fix not just cadence but also any other driver setting
->use_gpio_descriptors() and also supplying their own
->set_cs() callback and expecting this behaviour, or the fix
will have fixed broken a bunch of drivers.

But we are lucky: there aren't many of them.
In addition to spi-cadence.c this seems to affect only spi-dw.c
and I suppose that is what Gregory was using? Or
something else?

Yours,
Linus Walleij
