Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B02EC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 08:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEBB92158A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 08:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bZEuPxzn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfK1IkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 03:40:19 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39450 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbfK1IkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 03:40:18 -0500
Received: by mail-lf1-f68.google.com with SMTP id f18so19367613lfj.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 00:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+JqMG1d/lOL1srD0/KuAfIZSpr9D48XI4hlM2DvA188=;
        b=bZEuPxznYkkUMn6qZgpnuvM4gNag52WWCk/RUTwcK007r3a7ezGpkJ+hXLG8VnipQe
         tbqFGhp2tyCkXFj1Pc4BF0pO+lQGc6wCc9gWTYbSBR2qvBv0i0wuv5FMBkVuA79+Hawi
         Czl2kNrVhM7xEMRkSFc81ooawACro7k2n2UQ9WJWwY9UD/2G0s78VvjqKXtCUXSCIZ3+
         GYcFYDf5b/9VDnpfUz0w2lj14wRRLGGbkcnb32aAXQdgNww0u+ALp9B7mlDguNXxtU41
         pEZnCG7TjEIE32fOOYuqPLkxo4JrV9w+FakvpbwfTFutOZFAgRyS9fDItvfyWCrtnmKo
         pw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+JqMG1d/lOL1srD0/KuAfIZSpr9D48XI4hlM2DvA188=;
        b=dJzoIKwUyrNyae5iDmwOLv3lLVxPDl74MM9VVq7Y/1ON6DwbK2RmlLBrrU4OXIuSSa
         MbEwhR1UX3zQuIQj+N7qMP8W7wUvcqlIgQm3oH9IEsBfvYHy/WI8GQLk+lWu2EIrU8jg
         fWKftLqS9IazxOD7pAo6Kl9PMNVJ5xKlSl865Vh9N+R7LzhjXz7t2HM8e+0V8aq9LdPx
         aa0woO1qm4u4l+ibS4Wk/fMLdITl2kFYOQZ7a1pAdGRzFz+RupZ5hIbAIaShYgSu0pJN
         mEvPpBhH3Lb27gfHUdzX9Cgi1l5z9qY+i9z1t+fgcAcCxup1AjETJmUThhyZBT8+qZtC
         GWxA==
X-Gm-Message-State: APjAAAU0hBlyKRK6JLU055PWepC1BHlG1thrF5jHlcP4iuklHOLnSgYa
        wRPXxdVYe7NSTttuW+E/GguDGj0udHh0CuVFS42iwQ==
X-Google-Smtp-Source: APXvYqxtG/gdvoyr7WyQ5q4Y0yE5V49M3E8UCbzdSLCahQX17AzyxDGbF9OSSPKMuehEM57zKAoKWOxxW5wSb1klq2c=
X-Received: by 2002:ac2:410a:: with SMTP id b10mr4280450lfi.135.1574930415765;
 Thu, 28 Nov 2019 00:40:15 -0800 (PST)
MIME-Version: 1.0
References: <20191127153936.29719-1-ckeepax@opensource.cirrus.com>
In-Reply-To: <20191127153936.29719-1-ckeepax@opensource.cirrus.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 28 Nov 2019 09:40:04 +0100
Message-ID: <CACRpkdbSmk0iDBbfCWpsT6FnU6mzynCknfJ8K95VNRqK6=_XyQ@mail.gmail.com>
Subject: Re: [PATCH] spi: dw: Correct handling of native chipselect
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 4:39 PM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:

> This patch reverts commit 6e0a32d6f376 ("spi: dw: Fix default polarity
> of native chipselect").
>
> The SPI framework always called the set_cs callback with the logic
> level it desired on the chip select line, which is what the drivers
> original handling supported. commit f3186dd87669 ("spi: Optionally
> use GPIO descriptors for CS GPIOs") changed these symantics, but only
> in the case of drivers that also support GPIO chip selects, to true
> meaning apply slave select rather than logic high. This left things in
> an odd state where a driver that only supports hardware chip selects,
> the core would handle polarity but if the driver supported GPIOs as
> well the driver should handle polarity.  At this point the reverted
> change was applied to change the logic in the driver to match new
> system.
>
> This was then broken by commit 3e5ec1db8bfe ("spi: Fix SPI_CS_HIGH
> setting when using native and GPIO CS") which reverted the core back
> to consistently calling set_cs with a logic level.
>
> This fix reverts the driver code back to its original state to match
> the current core code. This is probably a better fix as a) the set_cs
> callback is always called with consistent symantics and b) the
> inversion for SPI_CS_HIGH can be handled in the core and doesn't need
> to be coded in each driver supporting it.
>
> Fixes: 3e5ec1db8bfe ("spi: Fix SPI_CS_HIGH setting when using native and GPIO CS")
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks for looking into this Charles!!
Acked-by: Linus Walleij <linus.walleij@linaro.org>

I think we should have all regressions covered with
these two patches.

Yours,
Linus Walleij
