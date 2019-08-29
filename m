Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C21C3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 21:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73F432189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 21:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbfH2VWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 17:22:52 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40022 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfH2VWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 17:22:51 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 206A0813B1; Thu, 29 Aug 2019 23:22:35 +0200 (CEST)
Date:   Thu, 29 Aug 2019 23:22:48 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Dan Murphy <dmurphy@ti.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: lm3532: Fix optional led-max-microamp prop error
 handling
Message-ID: <20190829212247.GB32254@amd>
References: <20190829191836.9648-1-dmurphy@ti.com>
 <ff3a0662-a71b-79d5-6d28-a882f9f77f89@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="JP+T4n/bALQSJXh8"
Content-Disposition: inline
In-Reply-To: <ff3a0662-a71b-79d5-6d28-a882f9f77f89@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2019-08-29 22:04:18, Jacek Anaszewski wrote:
> Hi Dan,
>=20
> Thanks for the update.
>=20
> On 8/29/19 9:18 PM, Dan Murphy wrote:
> > Fix the error handling for the led-max-microamp property.
> > Need to check if the property is present and then if it is
> > retrieve the setting and its max boundary
> >=20
> > Reported-by: Pavel Machek <pavel@ucw.cz>
> > Signed-off-by: Dan Murphy <dmurphy@ti.com>
> > ---
> >  drivers/leds/leds-lm3532.c | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/leds/leds-lm3532.c b/drivers/leds/leds-lm3532.c
> > index c5cfd8e3f15f..13b4265fb85a 100644
> > --- a/drivers/leds/leds-lm3532.c
> > +++ b/drivers/leds/leds-lm3532.c
> > @@ -601,11 +601,15 @@ static int lm3532_parse_node(struct lm3532_data *=
priv)
> >  			goto child_out;
> >  		}
> > =20
> > -		ret =3D fwnode_property_read_u32(child, "led-max-microamp",
> > -					       &led->full_scale_current);
> > -
> > -		if (led->full_scale_current > LM3532_FS_CURR_MAX)
> > -			led->full_scale_current =3D LM3532_FS_CURR_MAX;
> > +		if (fwnode_property_present(child, "led-max-microamp")) {
> > +			if (fwnode_property_read_u32(child, "led-max-microamp",
> > +						     &led->full_scale_current))
> > +				dev_err(&priv->client->dev,
> > +					"Failed getting led-max-microamp\n");
> > +
> > +			if (led->full_scale_current > LM3532_FS_CURR_MAX)
> > +				led->full_scale_current =3D LM3532_FS_CURR_MAX;
>=20
> One more nit: we have min() macro in kernel.h for such things.

Actually, I believe this one is okay. min() would be also good, but
improvement is not that big, as it still duplicates the argument.

led->full_scale_current =3D min(led->full_scale_current, LM3532_FS_CURR_MAX)

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--JP+T4n/bALQSJXh8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl1oQicACgkQMOfwapXb+vLL0ACcCBhnti0Tj6RaCErhjosQccHu
1wgAn2LJseuLFr6KxEU60hGF0abLzOIV
=dlY+
-----END PGP SIGNATURE-----

--JP+T4n/bALQSJXh8--
