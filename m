Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17437C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 09:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C12B820C01
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 09:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="vLuu+xnl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbfGOJ6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 05:58:34 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36691 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729541AbfGOJ6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 05:58:34 -0400
Received: by mail-io1-f68.google.com with SMTP id o9so33154183iom.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 02:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p/gHZTm5E1jRrM1Q0YzsIPwWIMyzzrdFihto25L6y0Q=;
        b=vLuu+xnlAvrfnOPZ7Ws5ws81JJMxeS9DSqYkxD8kNS0Pnkr6SLk6GPGSPxY227zlB8
         FkYxdfzwU/ROjnPQQrnaGae8Gu8yzjfq4AqNjVO/H+c3HGr2eXFLdTFGqG/qFnsTWv76
         oRX2204Ft/Ho08qetqCvZ02zeKydaxg97GPwD2zDskglidipT8/U9LdY6o79e6oWlX3G
         ajXqHI696+18e2GxHxN/7A5KjampTMEe+UvlIYxhFr4yJJDeu03Y35PdYLA+5Unku/Ti
         nn7hC+UUcIJXt+8b7+PhdgFVsVQq8fGGD6u6zVIoFvi11HLw3AU9sWmgfzcatsRnziE3
         PDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p/gHZTm5E1jRrM1Q0YzsIPwWIMyzzrdFihto25L6y0Q=;
        b=YRZ/d+YLsxt6xLAo13TaddLBObJHLvct2FT0pXyAuwK7v7/hWxjBrwBRusanLqq7Gw
         b2ZhBDG5RzNvS7W9jc7psu5/nILj8P6mN21MCQPruo1rAYcRJnhKts1/m15zf4Vf1/So
         xhZCqNZZLA+pst8TgD8Uv/XhoXlY3NCz4dtjxNdlXa/bZcddqc0lRKSoNeSpF8Gg6Ccq
         p6nhlbKJiUdSwykEJTdDPwnq4bOi/fsGggYvrPpu34u5TLTj/+2F73qiN3GgfKb++I4w
         57TfUE46ZAIRNpPNBbaSTEE8zOEl0RuyRRKEwf0RI0vMaQTg2izvD5sVIIPL1DQC063B
         HbCw==
X-Gm-Message-State: APjAAAVP5DLNWkOaI5Cw7qQlju7CUSVm2P520iLERU1aWweKu/j7ncle
        +dqjXC/kZnH5nGULKUP8ewFnWoIt8x/bIwVARuo=
X-Google-Smtp-Source: APXvYqz8XA8SyBauZiqhPQcHgICCCe4cjZsBXQ40JhwvG2PORL6EtWr3AMfb1j++pGaSUYkkBZ4yqtBGa+WKT1X4QHA=
X-Received: by 2002:a6b:f80b:: with SMTP id o11mr17231256ioh.40.1563184713317;
 Mon, 15 Jul 2019 02:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190711082936.8706-1-brgl@bgdev.pl> <CAMuHMdWzEOVLUZM_rFfMKqF_G_gZXBpV7TC-OXmN8YKw6_occQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWzEOVLUZM_rFfMKqF_G_gZXBpV7TC-OXmN8YKw6_occQ@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 15 Jul 2019 11:58:22 +0200
Message-ID: <CAMRc=MdD=JPerECFAeXW+FG=gsRLLR8X3AxfyCxfqFeOATQA9w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] gpio: em: remove the gpiochip before removing the
 irq domain
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Phil Reid <preid@electromag.com.au>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable <stable@vger.kernel.org>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 11 lip 2019 o 10:47 Geert Uytterhoeven <geert@linux-m68k.org> napisa=
=C5=82(a):
>
> CC Niklas, who has the hardware
>
> On Thu, Jul 11, 2019 at 10:29 AM Bartosz Golaszewski <brgl@bgdev.pl> wrot=
e:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > In commit 8764c4ca5049 ("gpio: em: use the managed version of
> > gpiochip_add_data()") we implicitly altered the ordering of resource
> > freeing: since gpiochip_remove() calls gpiochip_irqchip_remove()
> > internally, we now can potentially use the irq_domain after it was
> > destroyed in the remove() callback (as devm resources are freed after
> > remove() has returned).
> >
> > Use devm_add_action_or_reset() to keep the ordering right and entirely
> > kill the remove() callback in the driver.
> >
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Fixes: 8764c4ca5049 ("gpio: em: use the managed version of gpiochip_add=
_data()")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds

Patch applied.
