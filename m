Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038D2C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 12:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD502067B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 12:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbfIQMkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 08:40:37 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60546 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727534AbfIQMkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 08:40:36 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id DDC0B815FC; Tue, 17 Sep 2019 14:40:18 +0200 (CEST)
Date:   Tue, 17 Sep 2019 14:40:32 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        kernel list <linux-kernel@vger.kernel.org>, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org,
        Dan Murphy <dmurphy@ti.com>, linux-leds@vger.kernel.org
Subject: [PATCH] lm3532: right registration to work with LED-backlight
Message-ID: <20190917124032.GA27465@amd>
References: <20190827215205.59677-1-tony@atomide.com>
 <20190828085339.GB2923@amd>
 <c3ac1863-9cdb-1ba6-d5a4-df1c4cfecbe1@gmail.com>
 <20190908080305.GC25459@amd>
 <390760c1-de39-9328-bb23-cbf791094718@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
In-Reply-To: <390760c1-de39-9328-bb23-cbf791094718@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Use new registration support, which will eventually be needed for
proper backlight support.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/drivers/leds/leds-lm3532.c b/drivers/leds/leds-lm3532.c
index 0507c65..23f49b6 100644
--- a/drivers/leds/leds-lm3532.c
+++ b/drivers/leds/leds-lm3532.c
@@ -577,6 +577,12 @@ static int lm3532_parse_node(struct lm3532_data *priv)
 		priv->runtime_ramp_down =3D lm3532_get_ramp_index(ramp_time);
=20
 	device_for_each_child_node(priv->dev, child) {
+		struct led_init_data idata =3D {
+			.fwnode =3D child,
+			.default_label =3D ":",
+			.devicename =3D priv->client->name,
+		};
+
 		led =3D &priv->leds[i];
=20
 		ret =3D fwnode_property_read_u32(child, "reg", &control_bank);
@@ -651,7 +657,7 @@ static int lm3532_parse_node(struct lm3532_data *priv)
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

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl2A1EAACgkQMOfwapXb+vLYdwCfSLlhnzn7hr2yN10xNmOpBaJw
Xt0An35whtquNKSSQXbwCZ+T/OSVXTft
=zZ8+
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
