Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DC8C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C612321849
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391204AbfGRTIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 15:08:52 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40444 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfGRTIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 15:08:52 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id B0487802B0; Thu, 18 Jul 2019 21:08:38 +0200 (CEST)
Date:   Thu, 18 Jul 2019 21:08:49 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org,
        jacek.anaszewski@gmail.com, linux-leds@vger.kernel.org,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: [PATCH] Enable backlight when trigger is activated
Message-ID: <20190718190849.GA11409@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Configuring backlight trigger from dts results in backlight off during
boot. Machine looks dead upon boot, which is not good.

Fix that by enabling LED on trigger activation.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/drivers/leds/trigger/ledtrig-backlight.c b/drivers/leds/trigge=
r/ledtrig-backlight.c
index 487577d..6e6bc78 100644
--- a/drivers/leds/trigger/ledtrig-backlight.c
+++ b/drivers/leds/trigger/ledtrig-backlight.c
@@ -114,6 +114,8 @@ static int bl_trig_activate(struct led_classdev *led)
 	n->old_status =3D UNBLANK;
 	n->notifier.notifier_call =3D fb_notifier_callback;
=20
+	led_set_brightness(led, LED_ON);
+
 	ret =3D fb_register_client(&n->notifier);
 	if (ret)
 		dev_err(led->dev, "unable to register backlight trigger\n");
@@ -126,6 +128,7 @@ static void bl_trig_deactivate(struct led_classdev *led)
 	struct bl_trig_notifier *n =3D led_get_trigger_data(led);
=20
 	fb_unregister_client(&n->notifier);
+	led_set_brightness(led, LED_OFF);
 	kfree(n);
 }
=20

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0ww8EACgkQMOfwapXb+vI/hQCeO9FNCL2TmO9oZ8A7L2jg1y1R
jvQAn1C6VabsEY2RJJWCWLOK9CshUbyu
=aKee
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
