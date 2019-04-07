Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38997C10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 22:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 080AC20863
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 22:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfDGWRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 18:17:40 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46960 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfDGWRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 18:17:40 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 6A96080365; Mon,  8 Apr 2019 00:17:29 +0200 (CEST)
Date:   Mon, 8 Apr 2019 00:17:40 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>, robh@kernel.org,
        dmurphy@ti.com
Cc:     lee.jones@linaro.org, tony@atomide.com, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL v2] LM3532 backlight support improvements and
 relocation
Message-ID: <20190407221740.GA6327@amd>
References: <20190407190951.27288-1-jacek.anaszewski@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <20190407190951.27288-1-jacek.anaszewski@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Changes since v1:
>=20
> - synchronized DT label properties in DT bindings with what has been agre=
ed
>   for the patch "ARM: dts: omap4-droid4: Update backlight dt properties"
>=20
> The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa23=
1b:
>=20
>   Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)
>=20
> are available in the git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/j.anaszewski/linux-leds.g=
it tags/lm3532-driver-improvements
>=20
> for you to fetch changes up to bc1b8492c764fea940fc66206047e37a7f8d77e1:
>=20
>   leds: lm3532: Introduce the lm3532 LED driver (2019-04-07 20:45:49 +020=
0)
>=20
> Thanks,
> Jacek Anaszewski
>=20
> ----------------------------------------------------------------
> LM3532 backlight driver improvements and relocation
> ----------------------------------------------------------------
> Dan Murphy (4):
>       dt: lm3532: Add lm3532 dt doc and update ti_lmu doc

Sorry, this one will need more work.

When did Rob acknowledge this? I do not remember that mail & quick
google does not find it.

I still don't like the fact that it is using different binding from
other similar chips. It for example replaces "ramp-up-msec" with
"ramp-up-us".

This is certainly wrong:

+Optional properties if ALS mode is used:
+	  - ti,als-vmin - Minimum ALS voltage defined in Volts
+	  - ti,als-vmax - Maximum ALS voltage defined in Volts
+	  Per the data sheet the max ALS voltage is 2V and the min is
0V

=2E..but milivolts (or microvolts?) make sense there, and clearly
milivolts are used because 2000V is way out of range.:

+	  ti,als-vmin =3D <0>;
+	  ti,als-vmax =3D <2000>;

Plus:

+Required child properties:
=2E..
+	- ti,led-mode : Defines if the LED strings are manually controlled or
+			if the LED strings are controlled by the ALS.
+			       0x00 - LED strings are I2C controlled via full scale brightness =
control register
+        		  	  0x01 - LED strings are ALS controlled

Dunno. Normally we'd have "ti,automatic-led-mode", and if it was not
present, we'd default to manual, no? (Also "led-mode" is a bit too
generic. ti,als-enabled would be better description).

Plus, I'd kind of expect ALS enabled/disabled to be runtime controled,
not from the device tree.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyqdwQACgkQMOfwapXb+vLaxACgsFFWomoCI5PIWeZLAY7mJVpr
Oj0Anirsd9tos3fXoMjxEZCQbApj0MWy
=Lrel
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
