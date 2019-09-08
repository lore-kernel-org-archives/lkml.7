Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA2AC4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 08:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 688BB20854
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 08:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfIHIDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 04:03:09 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:53214 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfIHIDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 04:03:09 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id A619C80534; Sun,  8 Sep 2019 10:02:52 +0200 (CEST)
Date:   Sun, 8 Sep 2019 10:03:05 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        kernel list <linux-kernel@vger.kernel.org>, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org,
        Dan Murphy <dmurphy@ti.com>, linux-leds@vger.kernel.org
Subject: Re: [FYI] lm3532: right registration to work with LED-backlight
Message-ID: <20190908080305.GC25459@amd>
References: <20190827215205.59677-1-tony@atomide.com>
 <20190828085339.GB2923@amd>
 <c3ac1863-9cdb-1ba6-d5a4-df1c4cfecbe1@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3siQDZowHQqNOShm"
Content-Disposition: inline
In-Reply-To: <c3ac1863-9cdb-1ba6-d5a4-df1c4cfecbe1@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3siQDZowHQqNOShm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2019-08-28 22:32:57, Jacek Anaszewski wrote:
> On 8/28/19 10:53 AM, Pavel Machek wrote:
> > Hi!
> >=20
> > Eventually, these will be needed.
> >=20
> > Best regards,
> > 								Pavel
> >=20
> > commit 38d956977a7d6cbdc811676f9b4033da7487e045
> > Author: Pavel <pavel@ucw.cz>
> > Date:   Wed Aug 7 12:43:52 2019 +0200
> >=20
> >     d4: lm3532 needs to use right register function for backlight to wo=
rk.
> >=20
> > diff --git a/drivers/leds/leds-lm3532.c b/drivers/leds/leds-lm3532.c
> > index 365a22a5..f98e657 100644
> > --- a/drivers/leds/leds-lm3532.c
> > +++ b/drivers/leds/leds-lm3532.c
> > @@ -629,7 +629,7 @@ static int lm3532_parse_node(struct lm3532_data *pr=
iv)
> > =20
> >  		lm3532_init_registers(led);
> > =20
> > -		ret =3D devm_led_classdev_register(priv->dev, &led->led_dev);
> > +		ret =3D devm_of_led_classdev_register(priv->dev, to_of_node(child), =
&led->led_dev);
>=20
> We no longer have devm_of_led_classdev_register(). You must use
> devm_led_classdev_register_ext().

Something like this (untested)?

								Pavel

diff --git a/drivers/leds/leds-lm3532.c b/drivers/leds/leds-lm3532.c
index 62ace66..6340d5b 100644
--- a/drivers/leds/leds-lm3532.c
+++ b/drivers/leds/leds-lm3532.c
@@ -577,6 +577,11 @@ static int lm3532_parse_node(struct lm3532_data *priv)
 		priv->runtime_ramp_down =3D lm3532_get_ramp_index(ramp_time);
=20
 	device_for_each_child_node(priv->dev, child) {
+		struct led_init_data idata =3D {
+			.fwnode =3D child,
+			.default_label =3D "backlight",
+		};
+
 		led =3D &priv->leds[i];
=20
 		ret =3D fwnode_property_read_u32(child, "reg", &control_bank);
@@ -648,7 +653,7 @@ static int lm3532_parse_node(struct lm3532_data *priv)
 		led->led_dev.name =3D led->label;
 		led->led_dev.brightness_set_blocking =3D lm3532_brightness_set;
=20
-		ret =3D devm_led_classdev_register(priv->dev, &led->led_dev);
+		ret =3D devm_led_classdev_register_ext(priv->dev, &led->led_dev, &idata);
 		if (ret) {
 			dev_err(&priv->client->dev, "led register err: %d\n",
 				ret);


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--3siQDZowHQqNOShm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl10tbgACgkQMOfwapXb+vLbkACfVHJPljIY8z+7ENHAWo1e8ar3
CakAni8uQLaz+4Y9a4FODGqVon8Q8B5n
=DZYk
-----END PGP SIGNATURE-----

--3siQDZowHQqNOShm--
