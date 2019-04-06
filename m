Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE94C282DD
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 22:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D74213A2
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 22:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfDFWR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 18:17:56 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:37110 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfDFWRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 18:17:55 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id F415F80378; Sun,  7 Apr 2019 00:17:44 +0200 (CEST)
Date:   Sun, 7 Apr 2019 00:17:56 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Nick Crews <ncrews@chromium.org>,
        Benson Leung <bleung@chromium.org>, linux-leds@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Simon Glass <sjg@google.com>
Subject: Re: [PATCH v5 3/3] platform/chrome: Standardize Chrome OS keyboard
 backlight name
Message-ID: <20190406221756.GA4472@amd>
References: <20190404202042.GF29984@amd>
 <CAE_wzQ-8XwzptH7EqNrELxjBzY2+0oHJGB3Va=vZwwK3csu_aA@mail.gmail.com>
 <20190404204207.GH29984@amd>
 <CAE_wzQ8xe=x0uYcZkDRVKpUAQ_1vVdEPHU3XnEV1=_WN1-AMfw@mail.gmail.com>
 <20190404220509.GA14690@amd>
 <CABXOdTeQgjd2-T+eZCMdTDWBGLHEk6kvnYR0DjJYR7zuvVTMsQ@mail.gmail.com>
 <df9577fd-c526-77e9-c11c-5416387121db@collabora.com>
 <469dfb68-a7ab-668d-15cb-9e021c0d3f0c@gmail.com>
 <20190406095346.GB7546@amd>
 <1b45b4e8-18b6-62d5-7d42-0feed57c2c73@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <1b45b4e8-18b6-62d5-7d42-0feed57c2c73@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >I am not sure about existing driver. Important thing for me is that
> >new drivers use consistent naming.
> >
> >>In cases like above:
> >>
> >>     keyboardist::kbd_backlight
> >>     tclnumpad::kbd_backlight
> >>
> >>we could do with the following:
> >>
> >>     :kbd-backlight
> >>     :numpad-backlight
> >>
> >>I used hyphens instead of underscores since we will have this convention
> >>in the LED_FUNCTION names, which is more common for Device Tree, and
> >>some of existing LED triggers.
> >
> >Existing userspace already searches for *:kbd_backlight", AFAICT, so
> >we probably want to keep the "_".
>=20
> OK, but it should be an exception but not a rule.
> This "kbd-*" naming is used in input and tty subsystems which register
> keyboard triggers with this style:
>=20
> ~/kernel$ git grep  ".*[\":]kbd-" -- "*.c"
> drivers/input/input-leds.c:     [LED_NUML]      =3D { "numlock",
> VT_TRIGGER("kbd-numlock") },

> "kbd_" naming is used only in case of backlight LEDs:
>=20
> ~/kernel$ git grep  ".*[\":]kbd_" -- "*.c"
> drivers/hid/hid-asus.c: drvdata->kbd_backlight->cdev.name =3D
> "asus::kbd_backlight";

Yes, but userland already knows about kbd_backlight, so we really can
not change this.

> With LEDs in platform drivers is that problem that we have the name
> compiled into the kernel. Maybe to make it more flexible we could
> use kernel config to choose between new "kbd-" and legacy "kbd_"
> naming.

No, I don't think that is suitable use for config option.

> >I don't care much if we use "platform:" or no prefix at all for
> >backlight of internal keyboard, as long as it is consistent across all
> >devices.
> >
> >We certainly want to use some prefix (probably inputX:) for backlight
> >on USB keyboards.
>=20
> For LEDs exposed through the input-LED bridge my get_led_device_info.sh
> script nicely reports:
>=20
> associated input node: input1
>=20
> It just does:
>=20
> readlink input1\:\:numlock/device
>=20
> which prints: "../../input1 "

Yes, that will probably work for USB keyboards. (But not for internal
keyboards on phones, etc).


									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlypJZQACgkQMOfwapXb+vJtUACcDprz07bWGG7owVUANpYCh1Dn
nncAn3OE1uj6KGpEPmzK7C18vf/0BB89
=6fQc
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
