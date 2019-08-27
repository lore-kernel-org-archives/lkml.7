Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4846C3A5A6
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B7B206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbfH0MSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 08:18:22 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45940 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfH0MSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 08:18:21 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id AE47A8196C; Tue, 27 Aug 2019 14:18:05 +0200 (CEST)
Date:   Tue, 27 Aug 2019 14:18:18 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Dan Murphy <dmurphy@ti.com>, jacek.anaszewski@gmail.com,
        sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net,
        merlijn@wizzup.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] leds: lm3532: Fix brightness control for i2c mode
Message-ID: <20190827121818.GB19927@amd>
References: <20190820195307.27590-1-dmurphy@ti.com>
 <20190826215822.GY52127@atomide.com>
 <20190826221413.GA19124@amd>
 <20190826224437.GZ52127@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="NMuMz9nt05w80d4+"
Content-Disposition: inline
In-Reply-To: <20190826224437.GZ52127@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-08-26 15:44:37, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [190826 22:14]:
> > On Mon 2019-08-26 14:58:22, Tony Lindgren wrote:
> > > Hi,
> > >=20
> > > * Dan Murphy <dmurphy@ti.com> [190820 19:53]:
> > > > Fix the brightness control for I2C mode.  Instead of
> > > > changing the full scale current register update the ALS target
> > > > register for the appropriate banks.
> > > >=20
> > > > In addition clean up some code errors and random misspellings found
> > > > during coding.
> > > >=20
> > > > Tested on Droid4 as well as LM3532 EVM connected to a BeagleBoneBla=
ck
> > > >=20
> > > > Fixes: e37a7f8d77e1 ("leds: lm3532: Introduce the lm3532 LED driver=
")
> > > > Reported-by: Pavel Machek <pavel@ucw.cz>
> > > > Signed-off-by: Dan Murphy <dmurphy@ti.com>
> > > > ---
> > > >=20
> > > > v3 - Removed register define updates - https://lore.kernel.org/patc=
hwork/patch/1114542/
> > >=20
> > > Looks like starting with this patch in Linux next the LCD on droid4
> > > is so dim it's unreadable even with brightness set to 255. Setting
> > > brightness to 0 does blank it completely though.
> > >=20
> > > Did something maybe break with the various patch revisions or are
> > > we now missing some dts patch?
> >=20
> > Maybe missing dts patch. We should provide maximum current the LED can
> > handle...=20
>=20
> Or i2c control is somehow broken and only als control now works?

Well, max current led is obviously missing. Plus code does not check
the return from reading led-max-microamp.

ret =3D fwnode_property_read_u32(child, "led-max-microamp",
                                               &led->full_scale_current);

Untested, but something like this is neccessary according to code
review.

Signed-off-by: Pavel Machek <pavel@ucw.cz>
								Pavel

diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/o=
map4-droid4-xt894.dts
index 4454449..b883b84 100644
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -395,6 +395,7 @@
 			ti,led-mode =3D <0>;
 			label =3D ":backlight";
 			linux,default-trigger =3D "backlight";
+			led-max-microamp =3D 29800;
 		};
=20
 		led@1 {
@@ -402,6 +403,7 @@
 			led-sources =3D <1>;
 			ti,led-mode =3D <0>;
 			label =3D ":kbd_backlight";
+			led-max-microamp =3D 29800;
 		};
 	};
 };


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--NMuMz9nt05w80d4+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl1lH4oACgkQMOfwapXb+vKiWACgkkLvRG/5tM1SVIfFQ7w05Apv
53UAni7bPkRZj0eZxJdMWmfyWuPcaUKE
=vVUm
-----END PGP SIGNATURE-----

--NMuMz9nt05w80d4+--
