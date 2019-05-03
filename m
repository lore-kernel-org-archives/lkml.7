Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E17C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 14:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F272087F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 14:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbfECOyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 10:54:44 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:46505 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbfECOyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 10:54:44 -0400
X-Originating-IP: 90.88.149.145
Received: from localhost (aaubervilliers-681-1-29-145.w90-88.abo.wanadoo.fr [90.88.149.145])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id C246D1BF20C;
        Fri,  3 May 2019 14:54:35 +0000 (UTC)
Date:   Fri, 3 May 2019 16:54:35 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [PATCH v2 2/5] ASoC: sun4i-spdif: Add support for H6 SoC
Message-ID: <20190503145435.jziomr3sqxp6jbpd@flea>
References: <20190419191730.9437-1-peron.clem@gmail.com>
 <20190419191730.9437-3-peron.clem@gmail.com>
 <20190502082526.c5zo4uzceqzizbxo@flea>
 <CAJiuCcdFUPBsXfKtDLt-p6Edx-7JrST9d0C=ofCU4CL8ZxwcsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f5z2x6ysmbssgmgl"
Content-Disposition: inline
In-Reply-To: <CAJiuCcdFUPBsXfKtDLt-p6Edx-7JrST9d0C=ofCU4CL8ZxwcsA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f5z2x6ysmbssgmgl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 02, 2019 at 11:39:24AM +0200, Cl=E9ment P=E9ron wrote:
> > > @@ -169,16 +181,25 @@ struct sun4i_spdif_dev {
> > >       struct snd_soc_dai_driver cpu_dai_drv;
> > >       struct regmap *regmap;
> > >       struct snd_dmaengine_dai_dma_data dma_params_tx;
> > > +     const struct sun4i_spdif_quirks *quirks;
> >
> > I guess this will generate a warning since the structure hasn't been
> > defined yet?
>
> It's a pointer to a structure so no warning from the compiler.

Damn, I was convinced just declaring a pointer to a structure would
result to a gcc warning. Nevermind then.

> > > @@ -405,22 +426,26 @@ static struct snd_soc_dai_driver sun4i_spdif_da=
i =3D {
> > >       .name =3D "spdif",
> > >  };
> > >
> > > -struct sun4i_spdif_quirks {
> > > -     unsigned int reg_dac_txdata;    /* TX FIFO offset for DMA confi=
g */
> > > -     bool has_reset;
> > > -};
> > > -
> > >  static const struct sun4i_spdif_quirks sun4i_a10_spdif_quirks =3D {
> > >       .reg_dac_txdata =3D SUN4I_SPDIF_TXFIFO,
> > > +     .reg_fctl_ftx   =3D SUN4I_SPDIF_FCTL_FTX,
> > >  };
> > >
> > >  static const struct sun4i_spdif_quirks sun6i_a31_spdif_quirks =3D {
> > >       .reg_dac_txdata =3D SUN4I_SPDIF_TXFIFO,
> > > +     .reg_fctl_ftx   =3D SUN4I_SPDIF_FCTL_FTX,
> > >       .has_reset      =3D true,
> > >  };
> > >
> > >  static const struct sun4i_spdif_quirks sun8i_h3_spdif_quirks =3D {
> > >       .reg_dac_txdata =3D SUN8I_SPDIF_TXFIFO,
> > > +     .reg_fctl_ftx   =3D SUN4I_SPDIF_FCTL_FTX,
> > > +     .has_reset      =3D true,
> > > +};
> > >
> > > +static const struct sun4i_spdif_quirks sun50i_h6_spdif_quirks =3D {
> > > +     .reg_dac_txdata =3D SUN8I_SPDIF_TXFIFO,
> > > +     .reg_fctl_ftx   =3D SUN50I_H6_SPDIF_FCTL_FTX,
> > >       .has_reset      =3D true,
> >
> > The reg_dac_txdata and reg_fctl_ftx changes here should also be part
> > of a separate patch.
>
> You mean the reg_fctl_ftx quirk and the H6 introduction should be split ?

Yep

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--f5z2x6ysmbssgmgl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXMxWKwAKCRDj7w1vZxhR
xTheAQD9sE7A0WEHij5Wf1qBjNLpFuz3ZidjjR2KW3BxB9EWSgD/fmxUP0w8djKy
bpfpawxYsCpDiDgb1b2tfBSFbXO87wE=
=ry69
-----END PGP SIGNATURE-----

--f5z2x6ysmbssgmgl--
