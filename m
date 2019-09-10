Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E111AC49ED6
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 08:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B80F620863
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 08:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="FP63dxnY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbfIJIvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 04:51:07 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34986 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbfIJIvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 04:51:07 -0400
Received: by mail-ot1-f66.google.com with SMTP id t6so4079005otp.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 01:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TORtZiXw+gviBY1uqojNwtzUG5Du45WnPV4wu8nw43A=;
        b=FP63dxnYbqidnXC5M+glimtjNBKD/siLT23X23yuuOER2/9MRjpqdmr17EYxW/s6p0
         E+BlJ699H7VMsfwq2N1wqcggLYV4SabdWzY7R+9yPxtI/5t3nmNf5ca2zAEhu1LnVkuB
         djYTbLY1JIMnBRApHzAxKwnWqjP+nN1qESTU3SbZUvPgE9If19AaeeYRC/e77mGKGlHs
         Z8ZBwXsPYqqQJgcLf6S0grCdZJQsRslVL3vSrRDO2qTE8+rlRH1udar3q0c+ncpOXXIv
         4GVPY8w0RyJ4klXWtdtrKObo3MRhX8E73WYW7kEYXbu2xbXOjxHEltwsAL090sa9hSiJ
         ROuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TORtZiXw+gviBY1uqojNwtzUG5Du45WnPV4wu8nw43A=;
        b=a49iuQ4bJBIEhqP97Tfl3feFiL49KfbKKaO2tlrklioSJOapHYIiPOntjD4SNlNrSu
         z47CKoC/0O0wOmQBJ/AXJ4cs2QSCVNTzCVBSeDpvCKkoFvXntlveJRAg4Xz8Dx1VwLxz
         Pwhh50gEGvfTkBMq3pFNwe2eG8SOGAt4A6J5IoBNc2v3t8W3UoZZSeO1ZV3WDiyYootY
         yefodFRl2LVoBsBr1BBR/A+HuqCjrNhkXB+4AvFCYJjEOOYsEgGsd7nJczp5LBdEKjK/
         uiV8063LFNvs6qLKfJYaY+GIvgdDyfRWL0zNG9YQaAlUhch2ezwbZj6TbmYGi0Gbo1lF
         jm9w==
X-Gm-Message-State: APjAAAWRbhlYNut+Y0p44kqdIjnWu2y8t8CRBE+MOltRBauGpv1PAv5g
        FE7B7DS9yUgH5G9hCQMQAICkuKF7ez6pTfD14gsvAw==
X-Google-Smtp-Source: APXvYqxAsq9CF/Si2rdwo5vSZgIzEMUPMsKHEsRblYndhdS59/hlsoR7x+5MiowCWiAhLmrRORnRA4H2pVT8BZGTtxI=
X-Received: by 2002:a05:6830:1d4e:: with SMTP id p14mr1451146oth.292.1568105466197;
 Tue, 10 Sep 2019 01:51:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190906084539.21838-1-geert+renesas@glider.be>
In-Reply-To: <20190906084539.21838-1-geert+renesas@glider.be>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 10 Sep 2019 10:50:55 +0200
Message-ID: <CAMpxmJVrQ92+ULRrzyN52LwEcdPTuK7OZssZjUcRPRSTBQ=fwg@mail.gmail.com>
Subject: Re: [PATCH 0/4] gpio: API boundary cleanups
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 6 wrz 2019 o 10:45 Geert Uytterhoeven <geert+renesas@glider.be> napisa=
=C5=82(a):
>
>         Hi Linus, Bartosz,
>
> This patch series contains various API boundary cleanups for gpiolib:
>   - The first two patches make two functions private,
>   - The last two patches switch the remaining gpiolib exported functions
>     from EXPORT_SYMBOL() to EXPORT_SYMBOL_GPL().
>
> After this there is only a single GPIO driver function exported with
> EXPORT_SYMBOL();
>
>     drivers/gpio/gpio-htc-egpio.c:EXPORT_SYMBOL(htc_egpio_get_wakeup_irq)=
;
>
> I believe this symbol was never used upstream, and may be a relic of the
> original out-of-tree code the htc-egpio was based on.  I don't know if
> there (still) exist out-of-tree users of the symbol.
>
> Thanks for your comments!

All looks good to me. Are you fine with this being picked up after the
v5.4 merge window?

Bart

>
> Geert Uytterhoeven (4):
>   gpio: of: Make of_get_named_gpiod_flags() private
>   gpio: of: Make of_gpio_simple_xlate() private
>   gpio: of: Switch to EXPORT_SYMBOL_GPL()
>   gpio: devres: Switch to EXPORT_SYMBOL_GPL()
>
>  drivers/gpio/gpiolib-devres.c | 28 ++++++++++++++--------------
>  drivers/gpio/gpiolib-of.c     | 16 ++++++++--------
>  drivers/gpio/gpiolib-of.h     |  7 -------
>  include/linux/of_gpio.h       | 11 -----------
>  4 files changed, 22 insertions(+), 40 deletions(-)
>
> --
> 2.17.1
>
> Gr{oetje,eeting}s,
>
>                                                 Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                                             -- Linus Torv=
alds
