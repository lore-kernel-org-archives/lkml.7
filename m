Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AEBC10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A36F2084F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfCRL5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 07:57:39 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:44185 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfCRL5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 07:57:38 -0400
X-Originating-IP: 90.88.22.102
Received: from localhost (aaubervilliers-681-1-80-102.w90-88.abo.wanadoo.fr [90.88.22.102])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 7368DC0006;
        Mon, 18 Mar 2019 11:57:34 +0000 (UTC)
Date:   Mon, 18 Mar 2019 12:57:33 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     icenowy@aosc.io, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        linux-clk@vger.kernel.org
Subject: Re: [linux-sunxi] Re: [PATCH 04/14] pinctrl: sunxi: v3: really
 introduce support for V3
Message-ID: <20190318115733.4onedngeaqbm4txp@flea>
References: <20190312152256.35574-1-icenowy@aosc.io>
 <20190312152256.35574-5-icenowy@aosc.io>
 <20190312153654.25r5orlw7qjtlhbt@flea>
 <7B6C1341-BAB5-48C5-9E60-11BCEAC3D0CD@aosc.io>
 <ef0c3061986b7456605a61f835f2a2003cf4c678.camel@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kfiqbz764gzlm462"
Content-Disposition: inline
In-Reply-To: <ef0c3061986b7456605a61f835f2a2003cf4c678.camel@bootlin.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kfiqbz764gzlm462
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2019 at 12:05:12PM +0100, Paul Kocialkowski wrote:
> Hi,
>
> Le mardi 12 mars 2019 =C3=A0 23:45 +0800, Icenowy Zheng a =C3=A9crit :
> >
> > =E4=BA=8E 2019=E5=B9=B43=E6=9C=8812=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=
=8811:36:54, Maxime Ripard <maxime.ripard@bootlin.com> =E5=86=99=E5=88=B0:
> > > On Tue, Mar 12, 2019 at 11:22:46PM +0800, Icenowy Zheng wrote:
> > > > Introduce the GPIO pins that is only available on V3 (not on V3s) to
> > > the
> > > > V3 pinctrl driver.
> > > >
> > > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > > > ---
> > > >  drivers/pinctrl/sunxi/pinctrl-sun8i-v3.c | 291
> > > +++++++++++++++++++++--
> > > >  drivers/pinctrl/sunxi/pinctrl-sunxi.h    |   2 +
> > > >  2 files changed, 275 insertions(+), 18 deletions(-)
> > > >
> > > > diff --git a/drivers/pinctrl/sunxi/pinctrl-sun8i-v3.c
> > > b/drivers/pinctrl/sunxi/pinctrl-sun8i-v3.c
> > > > index 6704ce8e5e3d..54c210871a95 100644
> > > > --- a/drivers/pinctrl/sunxi/pinctrl-sun8i-v3.c
> > > > +++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-v3.c
> > > > @@ -1,5 +1,5 @@
> > > >  /*
> > > > - * Allwinner V3s SoCs pinctrl driver.
> > > > + * Allwinner V3/V3s SoCs pinctrl driver.
> > > >   *
> > > >   * Copyright (C) 2016 Icenowy Zheng <icenowy@aosc.xyz>
> > > >   *
> > > > @@ -23,7 +23,7 @@
> > > >
> > > >  #include "pinctrl-sunxi.h"
> > > >
> > > > -static const struct sunxi_desc_pin sun8i_v3s_pins[] =3D {
> > > > +static const struct sunxi_desc_pin sun8i_v3_v3s_pins[] =3D {
> > >
> > > I'm not sure all that remaining is worth it to be honest. It adds a
> > > lot of noise for no particular reason (and the same goes for renaming
> > > the file itself)
> >
> > Maybe keeping names is okay "for historial reasons".
> >
> > In fact I want to keep them.
>
> My two cents about this: kernel development is plagued by the unability
> to rename and rework things as soon as backward compatibility is
> involved. I believe that renaming and reworking things is quite a good
> thing to do when it leads to a situation that is easier to understand
> and makes more sense.
>
> In this case, I don't see any blockers that would prevent us from doing
> this, so I am strongly in favor of it. I really don't see how increased
> noise and "historical reasons" make up for better clarity.

It simplifies the git history, for once, which has the side effect of
reducing conflicts too.

A second one is: Do you prefer to review patches that have some
significant value (like a new feature, a bugfix, a new SoC support,
etc) or one that renames files and / or symbols?

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--kfiqbz764gzlm462
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXI+HnwAKCRDj7w1vZxhR
xfbaAP4tTPJsX9kjGgO2E96g98P/Y+TcQb27RkXk4LjnteSexAEAw1P3kGgeQQ04
LmZksUSSEkd+Gy4cLhehmv11w/aPWAo=
=CCMo
-----END PGP SIGNATURE-----

--kfiqbz764gzlm462--
