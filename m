Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA282C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 11:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB63E20857
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 11:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfCKLVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 07:21:18 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58878 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbfCKLVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 07:21:17 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 619318024A; Mon, 11 Mar 2019 12:21:08 +0100 (CET)
Date:   Mon, 11 Mar 2019 12:21:14 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Johan Hovold <johan@kernel.org>
Cc:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        Loys Ollivier <lollivier@baylibre.com>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 4/4] gnss: add driver for mediatek receivers
Message-ID: <20190311112114.GD14118@amd>
References: <1550070569-18588-1-git-send-email-lollivier@baylibre.com>
 <1550070569-18588-5-git-send-email-lollivier@baylibre.com>
 <20190214100019.GA4197@Red>
 <20190214101212.GJ28278@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="/unnNtmY43mpUSKx"
Content-Disposition: inline
In-Reply-To: <20190214101212.GJ28278@localhost>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/unnNtmY43mpUSKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2019-02-14 11:12:12, Johan Hovold wrote:
> On Thu, Feb 14, 2019 at 11:00:19AM +0100, Corentin Labbe wrote:
> > On Wed, Feb 13, 2019 at 04:09:29PM +0100, Loys Ollivier wrote:
> > > Add driver for serial-connected Mediatek-based GNSS receivers.
> > >=20
> > > These devices typically boot transmitting vendor specific NMEA output
> > > sequences. The serial port bit rate is read from the device tree
> > > "current-speed".
> > >=20
> > > Note that the driver uses the generic GNSS serial implementation and
> > > therefore essentially only manages power abstracted into three power
> > > states: ACTIVE, STANDBY, and OFF.
> > >=20
> > > For mediatek receivers with a main supply and no enable-gpios, this s=
imply
> > > means that the main supply is disabled in STANDBY and OFF (the option=
al
> > > backup supply is kept enabled while the driver is bound).
> > >=20
> > > Note that the timepulse-support is left unimplemented.
> > >=20
> > > Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
>=20
> > > +static int mtk_set_active(struct gnss_serial *gserial)
> > > +{
> > > +	struct mtk_data *data =3D gnss_serial_get_drvdata(gserial);
> > > +	int ret;
> > > +
> > > +	ret =3D regulator_enable(data->vcc);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	return 0;
> > > +}
> >=20
> > Hello
> >=20
> > This could be simplified to return regulator_enable(data->vcc);
>=20
> Indeed, but I prefer this style which clearly separates the error path
> from the success path while making the success return value explicit.

What is clear about useless code? That function can be two lines, this
only leads people to wonder "what is going on here?".
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--/unnNtmY43mpUSKx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyGRKoACgkQMOfwapXb+vJqAwCfScGhWTgpO+dfu2CFL1ZJgSkD
N6AAoIRtpiQeraSW32y0NcjTq66hwSeP
=o1Tv
-----END PGP SIGNATURE-----

--/unnNtmY43mpUSKx--
