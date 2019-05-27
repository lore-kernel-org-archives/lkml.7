Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AFCC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D8121530
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfE0M3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 08:29:05 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:55307 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfE0M3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 08:29:05 -0400
X-Originating-IP: 90.88.147.134
Received: from localhost (aaubervilliers-681-1-27-134.w90-88.abo.wanadoo.fr [90.88.147.134])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id B5136C0003;
        Mon, 27 May 2019 12:28:57 +0000 (UTC)
Date:   Mon, 27 May 2019 14:28:57 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/7] ASoC: sun4i-spdif: Add TX fifo bit flush quirks
Message-ID: <20190527122857.lphlgr7dc5z4f5o3@flea>
References: <20190525162323.20216-1-peron.clem@gmail.com>
 <20190525162323.20216-4-peron.clem@gmail.com>
 <20190526182410.soqb6bne6w66d5j6@flea>
 <CAJiuCce8UNbA+Ljkbw92ZJu3Ni6N9ciFKGsLtBYJ0_J8E1Gi2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5fgdhizk55u3fsr6"
Content-Disposition: inline
In-Reply-To: <CAJiuCce8UNbA+Ljkbw92ZJu3Ni6N9ciFKGsLtBYJ0_J8E1Gi2g@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5fgdhizk55u3fsr6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 26, 2019 at 09:00:30PM +0200, Cl=E9ment P=E9ron wrote:
> Hi Maxime,
>
> On Sun, 26 May 2019 at 20:24, Maxime Ripard <maxime.ripard@bootlin.com> w=
rote:
> >
> > On Sat, May 25, 2019 at 06:23:19PM +0200, Cl=E9ment P=E9ron wrote:
> > > Allwinner H6 has a different bit to flush the TX FIFO.
> > >
> > > Add a quirks to prepare introduction of H6 SoC.
> > >
> > > Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>
> > > ---
> > >  sound/soc/sunxi/sun4i-spdif.c | 11 ++++++++++-
> > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-sp=
dif.c
> > > index b6c66a62e915..8317bbee0712 100644
> > > --- a/sound/soc/sunxi/sun4i-spdif.c
> > > +++ b/sound/soc/sunxi/sun4i-spdif.c
> > > @@ -166,10 +166,12 @@
> > >   *
> > >   * @reg_dac_tx_data: TX FIFO offset for DMA config.
> > >   * @has_reset: SoC needs reset deasserted.
> > > + * @reg_fctl_ftx: TX FIFO flush bitmask.
> >
> > It's a bit weird to use the same prefix for a register offset
> > (reg_dac_tx_data) and a value (reg_fctl_ftx).
>
> I just look at sun4i-codec and they use a regmap, But I think it's a
> bit overkill no?

For a single value, yeah

> What do you think about val_fctl_ftx ?

Looks good, thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--5fgdhizk55u3fsr6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXOvYCQAKCRDj7w1vZxhR
xWpYAQDonSAGR8IIIJfCwN6P7pyQ5D2rskJl7lfFfD4Mo5WZ8QD/aAaog6/za5ta
r3GfRL559CHukEIi7he29P416ycIjw0=
=3d9d
-----END PGP SIGNATURE-----

--5fgdhizk55u3fsr6--
