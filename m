Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7757DC0650F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A95A20843
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cUmVYG8U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfHNI2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 04:28:25 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36297 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbfHNI2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 04:28:24 -0400
Received: by mail-lf1-f68.google.com with SMTP id j17so24707065lfp.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 01:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J83KZGJM1H+25Ep5nDkozma8SkGK+OcDZldJ6QzwaH0=;
        b=cUmVYG8UsBSWCZJv2pd/lU/PNItzi2UNLiW0TfIkMtuhz/f0dnCZQBVRRPzmjzbDU1
         rdC1UiKranq4PCx9s8pGLDdNWlc7JTJqMhRBsGlJk7PTqFNy1P03hYYsmPkCfCPrboHE
         0D/9A510sxkFeysavEIqfp66pVKT46ihtgpDP36P8Z3A4hJbbaT/WITBlrYDFwxlDNcN
         zLMkVCuS8HXPJzOiNrSXY8IyUTRz7gMllIMp1c64kuJZOjJK6HczBxJ2Av8+QOz7gA+0
         T4EXfGOohdgKCjLCVyIixyz3hWalVsJruTGIoJAsFUhUGYsjdb9sJ/UEHSaA2BoPhqiD
         jY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J83KZGJM1H+25Ep5nDkozma8SkGK+OcDZldJ6QzwaH0=;
        b=U73fVdvjkryU2d4GOqv5+We8TZVLWW80EGSRNc+NcnM1p0CX5bUGZLEr0kKWcqfoHF
         H3Kl4aRQwgt1lZXnUu4lMI51u/IFiCzIqgDc7GSgz5xlw/sZ+7uTIZvQ/4wRP6eyf8uk
         yi4zqQHb3HhG6lDJB9KiytZfQpZwc5cBMLx5+TovuR+Cp+fb506jlglCMT0au2cXdACN
         Y4roLKnIrYg99xfpa8swfywQMYczgixd/GIUijh+iuvgccxZH8+PY/xgKr/DSJb1mmrO
         RMvOAnNcHBymwQhhadCOk5N4jlIwlzcNJo1J2nBv0Y6BGI82GUPK0/gWZwzYEkdhhA5p
         A5sg==
X-Gm-Message-State: APjAAAXbn89v28d5pjZLsbG9wEe6BtE7UjC9J+UPxX3HJ4GOnkvb7a0y
        8zhOKwcUuiEXwV1XBAFm4Xw4DX5KtnMIX252w/XEMw==
X-Google-Smtp-Source: APXvYqx/pKIYf3ADrbaWtwPl1LapITMRPkDGA7rLXKcmW0V2qmaOIyExXYgPPecgdSpyox9WXnP5n7P2WaFpzCnXOK0=
X-Received: by 2002:ac2:59d0:: with SMTP id x16mr26028436lfn.60.1565771302470;
 Wed, 14 Aug 2019 01:28:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190812073020.19109-1-geert@linux-m68k.org>
In-Reply-To: <20190812073020.19109-1-geert@linux-m68k.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 14 Aug 2019 10:28:10 +0200
Message-ID: <CACRpkdZAA8N6igrNaXcT5m62Fz2irRL-tyRZnjWgsxfacB2aow@mail.gmail.com>
Subject: Re: [PATCH] m68k: atari: Rename shifter to shifter_st to avoid conflict
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        kbuild test robot <lkp@intel.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 9:30 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> When test-compiling the BCM2835 pin control driver on m68k:
>
>     In file included from arch/m68k/include/asm/io_mm.h:32:0,
>                      from arch/m68k/include/asm/io.h:8,
>                      from include/linux/io.h:13,
>                      from include/linux/irq.h:20,
>                      from include/linux/gpio/driver.h:7,
>                      from drivers/pinctrl/bcm/pinctrl-bcm2835.c:17:
>     drivers/pinctrl/bcm/pinctrl-bcm2835.c: In function 'bcm2711_pull_config_set':
>     arch/m68k/include/asm/atarihw.h:190:22: error: expected identifier or '(' before 'volatile'
>      # define shifter ((*(volatile struct SHIFTER *)SHF_BAS))
>
> "shifter" is a too generic name for a global definition.
>
> As the corresponding definition for Atari TT is already called
> "shifter_tt", fix this by renaming the definition for Atari ST to
> "shifter_st".
>
> Reported-by: kbuild test robot <lkp@intel.com>
> Suggested-by: Michael Schmitz <schmitzmic@gmail.com>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Finally we can use the sh pfc pin controller on our m68k Atari.

Now if I can only resolder the capacitors on my Atari TT ST
before the board self-destructs I will one day test this.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
