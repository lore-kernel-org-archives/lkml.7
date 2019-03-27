Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08923C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 02:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF592075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 02:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ufweQqEo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732572AbfC0CwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 22:52:15 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35179 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731613AbfC0CwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 22:52:14 -0400
Received: by mail-io1-f65.google.com with SMTP id p16so12766083iod.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 19:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h0IJ+MH5OSuGxxK0D8lkmMDIBMpmeV0ZDi4PvtT4p5s=;
        b=ufweQqEosTQOEMsEL5slwmwgLqEfVYE9wFS5gd41yZFWNZuCwik6gjUJpl+ll+nB5l
         JHVAK2n+Msv9ATGhkbicwHG9yYCe5yTet3y2/+L460t0cI5IsknIL0bJh5O20doEcK6C
         YOckD8cXkC3ntBFqINX1fQq7y6WUqZz9ciYoD/mtw6D6V0TuqRGkaAUJinI1QpNDIoBd
         XRykmqi1VfjphRm12/I94tbFmNYqPwq99miA9aTnTzZytCQUqNy9V/OwwXnLLbUIwule
         sldvbcdtFPXrMjjwJiTImNGqRAlZIHyfTqqil7NCBri+9OIsbcNtg7vvMdBDsKYV/qXt
         OnWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h0IJ+MH5OSuGxxK0D8lkmMDIBMpmeV0ZDi4PvtT4p5s=;
        b=jPwpXaAUEfCsBOP/QQeDDc7mnE+GgTjj5zJdDT/3t07j8jEG3DUw5hhfsYdTfPr8HX
         U1bv8YntFmu1KiR11CT11npManx0V4IUs1jeE0bOMh3xxXic+rqFp4jrjxIcZljZLkrw
         0rcbxnFCb3k4ht/Tz9W5Wyxr7BKmOfHZZqgDBTlE2Yydbul1wxG9d9E4KO4YyhlpNSvV
         g1kPovDXYqBld3uIVUtWfdDtFD7fbrq65tzinP0etYN3h2Ul6L6K9KClHlFRJZ1OLiIs
         dx9xki/OuNhHcoElK5H4R5/VBHkrFzBaBygth488v2OsKeOYO0AdqSr3tHnBuLurIEvR
         n4rA==
X-Gm-Message-State: APjAAAVkgllSeFX6BIDlA6VJqfRNcw7fXZeKqaoPrQ3FAQO9WlUZa3h0
        ztFs+dgV1C5myR0eBZ6LwOt2yd1olV3cDqVdV4c=
X-Google-Smtp-Source: APXvYqwZbrvHRN0nJGtcVYt+726zrDWuLQRt00iSnk3RndSYOfl66VHmjVgwzgC5zYRpG/f9cpCzwQWvjLgE3TnMdfE=
X-Received: by 2002:a5d:8b97:: with SMTP id p23mr1374480iol.83.1553655133818;
 Tue, 26 Mar 2019 19:52:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190325050100.29517-1-andrew.smirnov@gmail.com> <CAOMZO5BOR2DS-w3oOHsT_hTttgK=OPQZYwUywXdZFLRzbrb6Zg@mail.gmail.com>
In-Reply-To: <CAOMZO5BOR2DS-w3oOHsT_hTttgK=OPQZYwUywXdZFLRzbrb6Zg@mail.gmail.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Tue, 26 Mar 2019 19:52:02 -0700
Message-ID: <CAHQ1cqHGgJMWMFx04fEzhzONPUrbjqD=3yPEyFsE=XGJDbJjmg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6qdl: Specify IMX6QDL_CLK_IPG as "ipg" clock
 for SDMA
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Angus Ainslie <angus@akkea.ca>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 3:49 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Andrey,
>
> On Mon, Mar 25, 2019 at 2:01 AM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>
> > diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> > index 9f9aa6e7ed0e..354feba077b2 100644
> > --- a/arch/arm/boot/dts/imx6qdl.dtsi
> > +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> > @@ -949,7 +949,7 @@
> >                                 compatible = "fsl,imx6q-sdma", "fsl,imx35-sdma";
> >                                 reg = <0x020ec000 0x4000>;
> >                                 interrupts = <0 2 IRQ_TYPE_LEVEL_HIGH>;
> > -                               clocks = <&clks IMX6QDL_CLK_SDMA>,
> > +                               clocks = <&clks IMX6QDL_CLK_IPG>,
>
> This problem affects other i.MX SoCs, such as i,MX6SX as originally
> reported here:
> https://patchwork.kernel.org/patch/10864867/
>
> So I think we need either a  dtsi fix for the other i.MX SoCs or maybe
> a fix in the SDMA driver?

I think it is worth fixing in DT, regardless if we do anything about
SDMA driver or not. I'll add fixes for 6SX and 7D in v2.

Thanks,
Andrey Smirnov
