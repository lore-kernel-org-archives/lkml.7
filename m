Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4129C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 10:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 903B9204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 10:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbfH0K2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 06:28:34 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44950 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfH0K2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 06:28:34 -0400
Received: by mail-ed1-f66.google.com with SMTP id a21so30684217edt.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 03:28:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hpmMfEcW04e4wPdBKLOA6yCkiTAFKCBRUZkT3TMGsjY=;
        b=c6byvNcwbhIrNve7LC3shQH9cUbZdUoI4/jFQJVsXz4gQ/OJQ5YiTsuZLnSmDczGNn
         iW4BdFD6Md0soOOQIgWQ1zHJIODbswJr+DVw2RnueHiAwToTneg9EPK4KkTCAdh12752
         a8xh/piIoIJVZIW7rLQDp3qnC43Bx5dOsvS720iEhj4aASzVY/aDoZetOeFoYd+8Ff6s
         1iBJCsoyRTo7RvcSvJf01b004DYuIX6EL1GeZJesDS2PAtOg8RdiyYqFt+yPZE3EGw2C
         wJW42sU2hLZac5xOKWDMB7QN5sEERJMfgQ/pKOymT4Q8ZSNMmPzceNOAMNkWPYKSxeX7
         dDZg==
X-Gm-Message-State: APjAAAUp6sGHG3CY4isCbMNn4hGYq9e8sPoO+q12xhjy98hMqY5+mOjc
        DtrQR+0Y/2y5ofDOXrAufxCjp9JSuxc=
X-Google-Smtp-Source: APXvYqwTIO98FLtgwyZYWR/qAucg2+h3Ub2mgLNHZsQeimbhBTqtZTDG0m+pPjfqBSWUmUPkRsNopg==
X-Received: by 2002:a17:906:ecfb:: with SMTP id qt27mr21404030ejb.275.1566901711746;
        Tue, 27 Aug 2019 03:28:31 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id y19sm1877777edu.90.2019.08.27.03.28.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2019 03:28:31 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id i63so2425443wmg.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 03:28:31 -0700 (PDT)
X-Received: by 2002:a1c:eb0a:: with SMTP id j10mr28275617wmh.125.1566901711153;
 Tue, 27 Aug 2019 03:28:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190826180734.15801-1-codekipper@gmail.com> <20190826180734.15801-2-codekipper@gmail.com>
 <CAGb2v651jVp+J2eyWh7vw-yHmFTVy4eaMjHV0FvOF17C5_Hswg@mail.gmail.com>
 <CAEKpxBmCg4AkqKM-O3C76gto+mPWyEdDbviAmRJ8PxLOOMTJ7w@mail.gmail.com>
 <CAGb2v64VNZ0oyD_760uNccwJb7MKngSooWB72M+d1DfT4-djog@mail.gmail.com> <CAEKpxBn3g2hFaei6thAnAHX4nemrs9c_xWp1GheMfMS6+TJ7gQ@mail.gmail.com>
In-Reply-To: <CAEKpxBn3g2hFaei6thAnAHX4nemrs9c_xWp1GheMfMS6+TJ7gQ@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 27 Aug 2019 18:28:16 +0800
X-Gmail-Original-Message-ID: <CAGb2v67MOE0bUrxO6NrObOCUO9ErknC0CNGYuk_Bs_iBwvU_DQ@mail.gmail.com>
Message-ID: <CAGb2v67MOE0bUrxO6NrObOCUO9ErknC0CNGYuk_Bs_iBwvU_DQ@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v6 1/3] ASoC: sun4i-i2s: incorrect regmap
 for A83T
To:     Code Kipper <codekipper@gmail.com>
Cc:     Maxime Ripard <mripard@kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "Andrea Venturi (pers)" <be17068@iperbole.bo.it>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 4:35 PM Code Kipper <codekipper@gmail.com> wrote:
>
> On Tue, 27 Aug 2019 at 10:01, Chen-Yu Tsai <wens@csie.org> wrote:
> >
> > On Tue, Aug 27, 2019 at 1:55 PM Code Kipper <codekipper@gmail.com> wrote:
> > >
> > > On Tue, 27 Aug 2019 at 06:13, Chen-Yu Tsai <wens@csie.org> wrote:
> > > >
> > > > On Tue, Aug 27, 2019 at 2:07 AM <codekipper@gmail.com> wrote:
> > > > >
> > > > > From: Marcus Cooper <codekipper@gmail.com>
> > > > >
> > > > > The regmap configuration is set up for the legacy block on the
> > > > > A83T whereas it uses the new block with a larger register map.
> > > >
> > > > Looking at the code Allwinner previously released [1], that doesn't seem to be
> > > > the case. Keep in mind that the register map shown in the user manual is for
> > > > the TDM interface, which we don't actually support right now.
> > >
> > > Should it matter what we support right now?, the block according to the user
> > > manual shows the bigger range. I don't have a A83T device and from what I
> >
> > There are a total of four I2S controllers on the A83T. Currently three of them
> > are listed in the dtsi file, which are _not_ the one shown in the user manual.
> > The one shown is the fourth one, which is the TDM controller.
>
> The configuration for the A83T suggests that it's a mixture of old and
> new which I don't
> think is the case considering it was released around the same time as
> the H3. There
> is enough similarity between the blocks for it to still work. For
> example on the H6
> we referenced by mistake the H3 block and we still got audio (with
> only slight distortion).

The difference with the A83T here is large enough that if you play anything
it will simply stall. I already reported it as broken and Maxime has sent
fixes.

> I would suggest to validate all of the i2s blocks we need to test
> using the internal loopback
> as that will also cover capture.
>
> >
> > It's not like we haven't seen this before. IIRC the A64 also had two variants
> > of the I2S interface. The one coupled with the audio codec was different from
> > the others.
>
> Yes...but the i2s of the audio codec was documented in the audio codec
> section. I've used
> this device to ensure that I've not broken anything in the old block
> with these new changes.
>
> >
> > > gather not many users do. But the compatible for the H3 has been removed
> > > and replaced with the settings for the A83T which also has default settings in
> > > registers further up than SUNXI_RXCHMAP.
> >
> > I'll sync up with Maxime on this.
> >
> > > >
> > > > The file shows the base address as 0x01c22800, and the last defined register
> > > > is SUNXI_RXCHMAP at 0x3c.
> > > >
> > > > The I2S driver [2] also shows that it is the old register map size, but with
> > > > TX_FIFO and INT_STA swapped around. This might mean that it would need a
> > > > separate regmap_config, as the read/write callbacks need to be changed to
> > > > fit the swapped registers.
> > > >
> > > > Finally, the TDM driver [3], which matches the TDM section in the manual, shows
> > > > a larger register map.
> > > >
> > > > A83T is SUN8IW6, while SUN8IW7 refers to the H3.
> > >
> > > Since when have we trusted Allwinner code?, the TDM labelled block
> > > clearly supports
> >
> > Since they haven't listed the I2S block in the user manual, so that is what we
> > have to go by.
> >
> > The TDM section in the user manual only lists the block at 0x1c23000. The memory
> > map says DAUDIO-[012] for addresses 0x1c22000, 0x1c22400, 0x1c22800, and TDM for
> > address 0x1c23000. One would assume this meant these are somewhat different.
> >
> > > I2S. The biggest use case for this block is getting HDMI audio working
> > > on the newer
> >
> > I understand that.
> >
> > > devices(LibreELEC nightlies has a user base of over 300) and I've tested this on
> > > numerous set ups over the last couple of years.
> >
> > Tested on the H3, correct?
>
> Yes....but only with the additional changes for multi-channel with my
> LibreELEC build.
> These changes I tested on my pine64 before pushing upstream.
>
> >
> > > Failing that reverting (3e9acd7ac693: "ASoC: sun4i-i2s: Remove
> > > duplicated quirks structure")
> > > would help.
> >
> > I'll take a look. IIRC it worked with the old layout, with the two registers
> > swapped, playing standard 48 KHz / 16 bit audio when I added supported for
> > the A83T. Then again maybe the stars were perfectly aligned. At the very least
> > we could separate A83T and H3 as you suggested.

Maxime has sent a patch reverting the merger.

ChenYu
