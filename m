Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B07EC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 13:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 566B920693
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 13:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4po0CFr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfDONMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 09:12:13 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:55742 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfDONMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 09:12:12 -0400
Received: by mail-it1-f193.google.com with SMTP id y134so26817645itc.5;
        Mon, 15 Apr 2019 06:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0e9K0Gw5A5BMZlba2rGxcgVoWDajYpsyy7t0cixtbLo=;
        b=e4po0CFru+ntdphh3yX5Dj6vtrnKfop3S0o61mx8e6k2AUPLMh9GbZHCqm9WxTtoNt
         ETnt0q8tG++zhV4mBMnuSKcLF6sL/bFoEmz4QoJZUOuCHeDlOK16Vfo/q1SyXR8HkQ9i
         MRKsvIAyD4YnMCIVq+M5ura0f4YQtVvzNCih3r8NNGCd1BHucG/5t833nKrw9ukPzGsR
         nHQPw+8T4Ff8Rl0YuRkFpGYKJ4LNnucX53MlCfO9NBUsAH9Lds1XUJeA3yUAw57LD5yd
         CIe4Hyo78Rgwo2xO9+U8jqSgBwY71rall7iabGoMQwOaDBdSDs8BP4zrpP87gVQ5TAgm
         LT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0e9K0Gw5A5BMZlba2rGxcgVoWDajYpsyy7t0cixtbLo=;
        b=maw3AkNUX3l6/hb+706wW2sZ+qkvUf4fEZDGoqlMBERP5yd2aw2lO1Yx1gNOrdgPjm
         KTUdoKqg9OGBg9ubDrVlB8P+ZH22+9gcV99hG62mCJRR0a7cXgZTcwqxlGHZwgIFLSE8
         4j06st9BHN17pPNxiBAD/0TSOkG8QyofIpf8DIqqa+t9IPAmkSJ+m5FpMtqGg2NFdtXi
         vPYoSX1DGa732bH30oXvINo6oF9ckRsv+6Wd0HJKyujJSfRb9IvDQfevl1zUVcxmvG1P
         UBPHW8aGkBMYAOBezcUGUpf3LxUgVSPXTirMTl/FyP1HDDn0CADt18VPBBKc06xQlUWM
         gHKw==
X-Gm-Message-State: APjAAAVHhLmQhM83/sptVi2NI2w7bCZpBOHHGujGVifn3wQ1Vs6cbQv5
        0mc2rgeJcg9SbyPj4v3a4vfD8E2wCsLH7nxAYlE=
X-Google-Smtp-Source: APXvYqzYtQWgRI5Uu9HsBVWSiEfUOBGuUcE0rAa75FjO0B4ZVckYMdaFe7Or9BkFX4WRRPhFhsRj03rTKyGTXumcFB4=
X-Received: by 2002:a05:660c:350:: with SMTP id b16mr26891344itl.29.1555333931677;
 Mon, 15 Apr 2019 06:12:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190410103926.8781-1-alexandre.belloni@bootlin.com>
 <20190410103926.8781-3-alexandre.belloni@bootlin.com> <CACRpkdY2Znvf0h5KiMqqq7J9r3uKU+Uss2Rteaw8a687BetV6A@mail.gmail.com>
In-Reply-To: <CACRpkdY2Znvf0h5KiMqqq7J9r3uKU+Uss2Rteaw8a687BetV6A@mail.gmail.com>
From:   Sylvain Lemieux <slemieux.tyco@gmail.com>
Date:   Mon, 15 Apr 2019 09:12:00 -0400
Message-ID: <CA+rxa6o9+MJBJy4hTkPukXhkCSvqnRokjT5FNsdm_hbdUjPJQw@mail.gmail.com>
Subject: Re: [PATCH 2/3] gpio: lpc32xx: enable interrupt lookup for port 3
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 9:55 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Wed, Apr 10, 2019 at 12:39 PM Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
>
> > Interrupt support was disabled "temporarily" in commit 320a6480ef24 ("gpio:
> > lpc32xx: disable broken to_irq support").
> >
> > Reenable to_irq for port 3 as they are directly connected to an interrupt
> > controller and a simple lookup is working.
> >
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
>
> Unfortunately this seems to be one of these hacks for
> hierarchical interrupts that does not quite cut it.
>
> > +static int lpc32xx_gpio_to_irq_p3(struct gpio_chip *chip, unsigned int offset)
> > +       return of_irq_get_byname(chip->of_node, chip->names[offset]);
>
> This works as long as consuming drivers pick a GPIO first
> using gpiod_get() (and variants) and then convert it to an
> IRQ using gpiod_to_irq().
>
> But it doesn't work when some consumer is just picking an
> IRQ off of the node without picking the GPIO first.
> And in DT that is OK, this DT node is definately an interrupt
> controller. (Leaving out the attribute for interrupt controller
> as is currently the case doesn't really fix the issue, it is
> just inconsistent.)
>
> Look at Brian Masney's series for the qualcomm pin controller
> chips for inspiration on how to do things right, see:
> commit 9d2b563bc23acfa93e7716b3396fd2f79fa8f0cd
> and down.
>
> Also:
> https://marc.info/?l=linux-gpio&m=154959228527643&w=2
>
> Especially note how he removes the kind of hack you are
> adding in e.g.
> commit a796fab2c605d6340512c51c6c3fa1c581357993
>
> Yours,
> Linus Walleij
>

Hi Alexandre,

you can also look at the original attempt, in 2015, to replace
this driver by a new version:
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/386708.html

Regards,
Sylvain

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
