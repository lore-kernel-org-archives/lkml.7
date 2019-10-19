Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A098CA9EAC
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 14:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28E302082F
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 14:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1tP4sHwY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfJSOaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 10:30:04 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41046 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfJSOaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 10:30:03 -0400
Received: by mail-oi1-f195.google.com with SMTP id g81so7587461oib.8
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2019 07:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ghDSQm39Jlx5gmXnVANSIgsOJIuDnV4Wo+ABz1BaRQU=;
        b=1tP4sHwYNnpUfkWS3qnr2mj9w0eS2pve2ZqGcA7RzVnVzMz+noVDjBSoCquw3GTUSk
         f++M1+Rc6MGqcbC/TbG/SmndF5rQSjKZTrOEuHH9ie83u+6B1tSC005RK6D1DxL2ZlTh
         Xllcir1nEKTJ7o0C8pxtRmkgEUBu9uehNb45RopqUyZIfHkcbzhZ9BGJiD8F8x7R1eBZ
         FZwAgKrK8ZE1SNh4s3+j78KnVFNduRwTearMxrg3K2DGSzMocmiDQicDO/JE+c+fa5jV
         /G6KTl3E1eIIPgv0if1LsVYBbc6ru8l7X979qo6qXHCDcLrtYbAYwp6XQ0LZYec+SXHg
         B43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ghDSQm39Jlx5gmXnVANSIgsOJIuDnV4Wo+ABz1BaRQU=;
        b=a8rZnGjLIo0CPNxfFOsy889xihLRHj5yfDGdgbQDV1xuujks+8xi0J/r36Xa9niyF0
         LRhDoFg82pZKZNUwEMVGtU/Qm51vChj1vwaBDCIym5RapV0AorUDenq2l8L2ZHMqhdKz
         w342i2fFu1uSwiZ5HHM7zpjzpfuhsaySk0AljUMFXloylE3RT/XaJtB16JXcz4pTOeT/
         ihZz3wwxrjyW/8MwxiCAvxN7MbPIbKgZKYr7xZBQbEqmCvCQqzeKDLizsDrLH+RTD68a
         j6W2SavRmcfKyRprS3h6NtRshFAm2o3Uu6SgDR7mHSHQ+2dZOxXRfrbExtVMSBtREhV1
         8IaQ==
X-Gm-Message-State: APjAAAUEe55Qr/JypvYS0oH/r5gx8T7HNAwOQW5OB1H4/wzLvfpOKmyJ
        m41Pwe9GqNm0khYMqeQ4caAA4jzAzHoUqa6ujK4zSg==
X-Google-Smtp-Source: APXvYqy7kFGbeJUVk96O4myEcxmRrSHyTc66p9xYDDub/LBqYgX2CKrxiG35GXcyGwr8n6C75UtxLrayLoJT/v4Zxsk=
X-Received: by 2002:a54:4e83:: with SMTP id c3mr12411782oiy.170.1571495400968;
 Sat, 19 Oct 2019 07:30:00 -0700 (PDT)
MIME-Version: 1.0
References: <20191017142237.9734-1-alexandre.belloni@bootlin.com>
 <81269cd6-e26d-b8aa-cf17-3a2285851564@web.de> <20191019120941.GL3125@piout.net>
In-Reply-To: <20191019120941.GL3125@piout.net>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Sat, 19 Oct 2019 16:29:49 +0200
Message-ID: <CAMpxmJVEXubtBhQs5wH00wvK=yp8nr0cZ04x9t8eCTLVU=O1JA@mail.gmail.com>
Subject: Re: [PATCH] coccinelle: api/devm_platform_ioremap_resource: remove
 useless script
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        kernel-janitors@vger.kernel.org,
        Coccinelle <cocci@systeme.lip6.fr>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sob., 19 pa=C5=BA 2019 o 14:09 Alexandre Belloni
<alexandre.belloni@bootlin.com> napisa=C5=82(a):
>
> On 19/10/2019 11:00:47+0200, Markus Elfring wrote:
> > > While it is useful for new drivers to use devm_platform_ioremap_resou=
rce,
> >
> > This is nice.
> >
> >
> > > this script is currently used to spam maintainers,
> >
> > This view is unfortunate.
> >
> > Do we stumble on a target conflict again?
> >
> >
> > > often updating very old drivers.
> >
> > This can also happen.
> >
> >
> > > The net benefit is the removal of 2 lines of code in the driver
> >
> > Additional effects can be reconsidered, can't they?
> >
>
> What are the additional effects? What is the end goal of converting all
> the existing drivers to devm_platform_ioremap_resource? The existing
> code is currently always correct and it is difficult to see how this
> would lead to any bug avoidance in the long term.
>
> > > but the review load for the maintainers is huge.
> >
> > Does collateral evolution trigger a remarkable amount of changes occasi=
onally?
> >
>
> This is not an evolution, it is unnecessary churn. Those patches have no
> benefit and eat up very valuable reviewer time.
>
> >
> > How will such feedback influence the development and integration of
> > further scripts for the semantic patch language (Coccinelle software)?
> >
>
> There are a few other scripts that have no added value when applied to
> existing code, like ptr_ret.cocci.
>
> --
> Alexandre Belloni, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

Hi Alexandre,

Markus has been black-listed by several core maintainers already, I
think you're wasting your time arguing. WRT the patch: when
introducing this wrapper, I definitely didn't expect people to send
hundreds of often wrong patches based on coccinelle reports, so I
guess removing the script is correct.

Bart
