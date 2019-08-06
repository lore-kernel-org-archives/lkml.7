Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45935C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BC7E20C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HlpTB3Af"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731379AbfHFNLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 09:11:41 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41128 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfHFNLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 09:11:41 -0400
Received: by mail-lf1-f65.google.com with SMTP id 62so56203546lfa.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 06:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H0vagFQ3739JrCrLPS29VGkKplJ4eh9USrRRP/YZnBk=;
        b=HlpTB3AfoXubHmbOTwFI+0OzaGP1Nl1VLy/JFzh9Njx8wGbwMJFMbtKjx9/NUZsNaK
         K/cLL+pL8bOt2yI5TdoHessmfhPymfIpULOlpiELbAQV2MYtjGGiAjnUE6YRw4FlPO64
         9tKJjn34YL8ZdybMMzgV6I4LdPJTgRfmD+p/tD1aysDuEBmMjul2DGFEuaKOPTXGSW0n
         iq7NUCiBTtqdbjRhhsTQ562D8Qk8cNr2L2+/gsV6e8pkg5zv70zLhylKA0pk3b1h9/EY
         ghVnyeP6tnoQCfvqcyRXCanw6EEjd5sa6qQlf4xbpSiWcwpUhdYlUkzkU6VLdqhWOU1G
         a7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H0vagFQ3739JrCrLPS29VGkKplJ4eh9USrRRP/YZnBk=;
        b=kdI1a2Amh/iwTIHmq0EHIKW2d61sJuvUpdpWnWjqYx5yHtaRXhsfR6tuUnhgsz+bUJ
         PXbETI/MuEOepk6RNUh0EgraT3kEk4Bv+J+Vr0bwvfk3uCHRFM3UK+lSlcP3AwmOucXJ
         L/iqkWV6D1iWlPEiZjmN2DxcZBzP/l6JBo+aTGoRqwoBAR4coxwoDkA//nmsQGwyJ23s
         L3erslqcRw1l8IuR0HwyrNgvdOl2z9sA61tRhrRrvRjKkw0T1JHHrNLVdZu7Zfxwfvlm
         4tsg9+Ed3Eo6Fkxvh/IVsyFbpwjRSFFcw33oCCn44RM9NBPr2LqZQHVwChMx/USqQRdi
         +1PA==
X-Gm-Message-State: APjAAAVHDba9gzr6xQ2uvQx6vpsY0QppimJyNWyVJswuNOxkS+pvSy4u
        hl++fYp+cmMeJoyfEjJ+CnmK24EeUxJf4wKIUh6Aog==
X-Google-Smtp-Source: APXvYqzf6iu18R7AJxDTK2zthx5LMRLAJUY6nOomob8YHK0YdoAPZzSyuo4h4xrvBPHV8bSSRkMHbrL2d8wZnkPasUw=
X-Received: by 2002:ac2:5c42:: with SMTP id s2mr2536999lfp.61.1565097098965;
 Tue, 06 Aug 2019 06:11:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190803133436.15016-1-rfried.dev@gmail.com> <CACRpkdYEdQdk62bWJ2=i2Mbvpz3kwL=9bnMoxksFsTgAHRh68w@mail.gmail.com>
In-Reply-To: <CACRpkdYEdQdk62bWJ2=i2Mbvpz3kwL=9bnMoxksFsTgAHRh68w@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 6 Aug 2019 15:11:27 +0200
Message-ID: <CACRpkdaTmxQn2Z=vD6nyqk-iXCFrnCG1xpkXwO3-+sazOhGBvw@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: Take MUX usage into account
To:     Ramon Fried <rfried.dev@gmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 6, 2019 at 3:04 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Sat, Aug 3, 2019 at 3:34 PM Ramon Fried <rfried.dev@gmail.com> wrote:
>
> > From: Stefan Wahren <stefan.wahren@i2se.com>
> >
> > The user space like gpioinfo only see the GPIO usage but not the
> > MUX usage (e.g. I2C or SPI usage) of a pin. As a user we want to know which
> > pin is free/safe to use. So take the MUX usage of strict pinmux controllers
> > into account to get a more realistic view for ioctl GPIO_GET_LINEINFO_IOCTL.
> >
> > Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> > Tested-By: Ramon Fried <rfried.dev@gmail.com>
> > Signed-off-by: Ramon Fried <rfried.dev@gmail.com>
> > ---
> > Sending Stefan's RFC as patch, as I tested it and it seems to work,
> > additionally, an accompanying fix was made by me to gpiolibd to fix a
> > display error of the actual result:
> > https://patchwork.ozlabs.org/patch/1139923/
>
> This is mostly fine, some style nits so I fixed it up when
> applying.

Ooops no. It needs a deeper rework in accordance to my comments
last time it was posted. Please read this reply to Stefan's patch
and address the comments:

https://lore.kernel.org/linux-gpio/CACRpkdb5DjAMRYkT+b0U6HVk7E6ccLT79-LB=QGQWWtE17aPUg@mail.gmail.com/

Yours,
Linus Walleij
