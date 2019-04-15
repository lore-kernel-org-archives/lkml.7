Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35927C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF7A20833
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgdU9brQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfDOIau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 04:30:50 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:41709 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbfDOIau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 04:30:50 -0400
Received: by mail-yb1-f194.google.com with SMTP id a13so3130927ybl.8;
        Mon, 15 Apr 2019 01:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YZQ0fktRX58H0NhtEKSqJXi8xc/s3VWkbaKd8PJvbh4=;
        b=LgdU9brQknv1g1UjS228vI6A8UudAMMys2ppz5q9Xt4K6o49CZqwgnEIXWv1aAUae0
         VRGiIrb9WqsVQtqfaOUtwYYuimBUx0rnWgxYPvgL51v/sef75/POfXfS2D/dL1JlfPNB
         XthG2C//RVtXtNFmdJKImpwF4jQ6mMZ0gkpuHQuiiRsUZMEE19Jx1Y1nG8YjjrK+ZaiY
         NfgIXmxd1h1uTWTyfiQmNm4HVlWTEulXqVOZwRsfkTWNW+4N2KXgqbSkAfG/5TjVg3Ju
         bNbNNoDfH1UqsryW1r/OtzRi6RUskO5n6yrIoa81/qFu5Db5Q84bmZ8/ssmcBCWzLJDV
         jzCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YZQ0fktRX58H0NhtEKSqJXi8xc/s3VWkbaKd8PJvbh4=;
        b=lflS022P9p5Ngxn39BuPoF78NP9KVIaG+IsUy5CPkpu4kemDKoyuBEneuPFegqRPMo
         gxRN5ehnNO9GL7bAysUpFLrND9R9nLZsJ8AcaP5khhMLKe3vWQRuaLTSoN1naXQnvn2u
         mARLzCi5c/FY6kQc5xUO81etchcoGnXlkyfiPxjIpW8AUaFEloS3nf7gE11NxpCCJkCM
         slpAQw55co2BRoIEsY9nKMIA6d/Ur5K8LkMOVaPNXX4nEsTlvTVfM+afzpQsbPHND5ye
         b3Mut0QleudVr3P3Spbc1Rs3/hVxJGGhVhSkyNMmVRznNjkwwnUrc+YgaNhHDKnYjxq1
         C8zw==
X-Gm-Message-State: APjAAAXmB+7AImI4JOxkgJt3PJVmyVFPkQXzbE77kunEhU8RUbFtjEX/
        Sw6bOSIMuv7kTrciFU4lCQsX8h8oehK2oyMUDzY=
X-Google-Smtp-Source: APXvYqyj0JBokUHfVrJQmM9A98AVN6COWS3xkEP7FVek/62tPGZDkWxk4FLloxyhjCpBU6Cjmvrz2ROdBaIJEQxW6K4=
X-Received: by 2002:a25:2b87:: with SMTP id r129mr41332684ybr.23.1555317049408;
 Mon, 15 Apr 2019 01:30:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190411214422.2267-1-peron.clem@gmail.com> <20190411214422.2267-2-peron.clem@gmail.com>
 <20190415080443.frubh4ln4agrdsfe@flea> <CAJiuCcc0Q8rh8u_30gKi8o07k0+e35UR99ZBHtCjx-DPkJEtdw@mail.gmail.com>
 <20190415081816.2pay4pioc5d4mojf@flea>
In-Reply-To: <20190415081816.2pay4pioc5d4mojf@flea>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 15 Apr 2019 10:30:38 +0200
Message-ID: <CAJiuCcedNF0xYSa_+Zfwj-vqYsbjfEpRqisOhEvuitYALMsyjw@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: sound: sun4i-spdif: Add Allwinner H6 compatible
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Apr 2019 at 10:18, Maxime Ripard <maxime.ripard@bootlin.com> wro=
te:
>
> On Mon, Apr 15, 2019 at 10:09:11AM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > Hi,
> >
> > On Mon, 15 Apr 2019 at 10:04, Maxime Ripard <maxime.ripard@bootlin.com>=
 wrote:
> > >
> > > Hi,
> > >
> > > On Thu, Apr 11, 2019 at 11:44:19PM +0200, Cl=C3=A9ment P=C3=A9ron wro=
te:
> > > > Allwinner H6 has a SPDIF controller with an increase of the fifo
> > > > size and the possibility to output the master clock.
> > > > However it's still compatible with the already existing driver for
> > > > Allwiner H3.
> > > >
> > > > Add this compatible in the device-tree bindings documentation.
> > >
> > > How was this tested?
> >
> > Using Alsa utils on a Beelink GS1 and I check correct output sound on
> > my home cinema.
> >
> > > After looking at the datasheet, it looks like it's still significantl=
y
> > > different. In particular:
> > >
> > >   - The MCLK divider isn't at the same offset
> >
> > We don't use the MCLK
> >
> > >   - The bits to flush the FIFO aren't at the same offset
> > >   - The FIFO trigger levels aren't at the same offset
> > >   - The FIFO status register layout is almost entirely different
> >
> > We use DMA not FIFO
>
> Well, DMA still uses the FIFOs. And even then, you're kind of missing
> the point. The device tree's compatible is about whether a particular
> device can be used as another one. How you are using it in the driver
> is completely irrelevant.

Sorry I meant " We use DMA not PIO".

I didn't change the driver and the SPDIF is working what's irrelevant
in declaring the driver as compatible ?

If some feature are missing they can be introduce later as there is a
special binding for H6 no ?

Clement

>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
