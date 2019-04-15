Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBAEC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93879206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5ChPBE5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfDOILv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 04:11:51 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:41843 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfDOILv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 04:11:51 -0400
Received: by mail-yb1-f194.google.com with SMTP id a13so3114874ybl.8;
        Mon, 15 Apr 2019 01:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u1XZE73tZD/pQnKVYQTbqH9e5x6SoTO9CAWo5zHYJ14=;
        b=B5ChPBE5M8JwD754egxMPrbTDuc77w6mwRHbc78vZZ9iAMOlW4TJMBqWNUgRYnCbjP
         1XEoZYqYRZP/gZlg6+CmoAain7wHYr9urHiTRdRFPmh7HDvCvubi/lTkJb5aYTaJVs+L
         DkP4cLM83qK23Mzm3uJAxxPlplCN/vapxzAAZy1fhaNGk24RdLw1M9Hi6OotuzkIjm25
         wlwuio9Yf6vscvlkeZhQaL6M+uTuzqHF7lcmej55GmgW0AdGD6UbElNooaITve/+9yHZ
         D9SWv567NpeAwvhI9d3Xc2ZSRTVrc9KzKU9F4SmCqWyZmn/0GR+LY4ah5/AAdNjeTLwl
         iU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u1XZE73tZD/pQnKVYQTbqH9e5x6SoTO9CAWo5zHYJ14=;
        b=g2v0ysNJBG9whzkcd+Ba+2W7obOycJWjuJcQmLIz6mUxftr8cN4hlctJy3jdjjYqFc
         ZC8JU80BZfJX1cEf4HfdEUr8jDKku+ZOtGyzI2Pa0ah47aaZn8xHjEPl0JP6HqTKzeba
         gFndIY8PeelYwsGN8KUyc7xdxWxV36/BrBuK38AOLeR6i06Sejglsqj3Ke6tyC29ETfF
         6fwNyu7dFDO2za2tcn0EpV3nYvKnHNNokmqRyAGOTs/r3O9yAwdUzwtqBO8Wq6icSfdJ
         5mwfXgEeYLQSo1I/Hbe59gWxhcnCNOx+8HLvOXKqE0sHFkbanG0HioQBLh8SUaDtAm8e
         Yp+g==
X-Gm-Message-State: APjAAAXauEQetEHpPcAt6HxrxiaXaHmHCwhgikNkYH7wv7aGm+aD5cDs
        uLxy7DT8ie/iNrQnzN2pCXlBC6tHk3UtdqD9VVg=
X-Google-Smtp-Source: APXvYqxX7S4JpXuPFz31xhNEso/fghnMJz6nRca0KzARERBEC3qICHVn2fh2sXAACfh11r0Zi3AoHAw0chfG/v75ke4=
X-Received: by 2002:a25:c9c7:: with SMTP id z190mr59797546ybf.234.1555315910039;
 Mon, 15 Apr 2019 01:11:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190411214422.2267-1-peron.clem@gmail.com> <20190411214422.2267-2-peron.clem@gmail.com>
 <20190415080443.frubh4ln4agrdsfe@flea> <CAJiuCcc0Q8rh8u_30gKi8o07k0+e35UR99ZBHtCjx-DPkJEtdw@mail.gmail.com>
In-Reply-To: <CAJiuCcc0Q8rh8u_30gKi8o07k0+e35UR99ZBHtCjx-DPkJEtdw@mail.gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 15 Apr 2019 10:11:38 +0200
Message-ID: <CAJiuCceTS=+PM9CLiU6JrfxpPNC5m3XB+j46K6efuM6tYG45Cw@mail.gmail.com>
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

On Mon, 15 Apr 2019 at 10:09, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com=
> wrote:
>
> Hi,
>
> On Mon, 15 Apr 2019 at 10:04, Maxime Ripard <maxime.ripard@bootlin.com> w=
rote:
> >
> > Hi,
> >
> > On Thu, Apr 11, 2019 at 11:44:19PM +0200, Cl=C3=A9ment P=C3=A9ron wrote=
:
> > > Allwinner H6 has a SPDIF controller with an increase of the fifo
> > > size and the possibility to output the master clock.
> > > However it's still compatible with the already existing driver for
> > > Allwiner H3.
> > >
> > > Add this compatible in the device-tree bindings documentation.
> >
> > How was this tested?
>
> Using Alsa utils on a Beelink GS1 and I check correct output sound on
> my home cinema.
> >
> > After looking at the datasheet, it looks like it's still significantly
> > different. In particular:
> >
> >   - The MCLK divider isn't at the same offset
> We don't use the MCLK
> >   - The bits to flush the FIFO aren't at the same offset
> >   - The FIFO trigger levels aren't at the same offset
> >   - The FIFO status register layout is almost entirely different
> We use DMA not FIFO

And also only SPDIF Tx has been tested.

>
> Clement
> >
> > So it doesn't really look compatible to me
> >
> > Maxime
> >
> > --
> > Maxime Ripard, Bootlin
> > Embedded Linux and Kernel engineering
> > https://bootlin.com
