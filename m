Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31197C10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 09:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F87218D3
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 09:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbfDFJxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 05:53:45 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:49758 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfDFJxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 05:53:45 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id C5B1C805F7; Sat,  6 Apr 2019 11:53:34 +0200 (CEST)
Date:   Sat, 6 Apr 2019 11:53:46 +0200
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
Message-ID: <20190406095346.GB7546@amd>
References: <20190404200658.GD29984@amd>
 <CAE_wzQ8WcMCzYqvxA_JBZKNza7ca3QE-VShmMxv5++_4F8RR=g@mail.gmail.com>
 <20190404202042.GF29984@amd>
 <CAE_wzQ-8XwzptH7EqNrELxjBzY2+0oHJGB3Va=vZwwK3csu_aA@mail.gmail.com>
 <20190404204207.GH29984@amd>
 <CAE_wzQ8xe=x0uYcZkDRVKpUAQ_1vVdEPHU3XnEV1=_WN1-AMfw@mail.gmail.com>
 <20190404220509.GA14690@amd>
 <CABXOdTeQgjd2-T+eZCMdTDWBGLHEk6kvnYR0DjJYR7zuvVTMsQ@mail.gmail.com>
 <df9577fd-c526-77e9-c11c-5416387121db@collabora.com>
 <469dfb68-a7ab-668d-15cb-9e021c0d3f0c@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="hHWLQfXTYDoKhP50"
Content-Disposition: inline
In-Reply-To: <469dfb68-a7ab-668d-15cb-9e021c0d3f0c@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hHWLQfXTYDoKhP50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The patch set introduces also a set of predefined LED_FUNCTION
> names to be used in DT bindings. This along with the removal
> of devicename section from LED naming pattern will help to keep
> LED sysfs interface more uniform and not varying depending on
> underlaying hardware driving the LEDs.
>=20
> Regarding the problem discussed in this thread - I would not necessarily
> go for "platform" in place of devicename LED name section in the
> cros_kbd_led_backlight driver. If we change it (should we at all - it is
> already in 5.0 AFAICS?), then I would opt for dropping the "chromeos:"
> part. It believe it will be possible to retrieve this name with
> get_led_device_info.sh script. It would be good exercise to check
> it out.

I am not sure about existing driver. Important thing for me is that
new drivers use consistent naming.

> In cases like above:
>=20
>     keyboardist::kbd_backlight
>     tclnumpad::kbd_backlight
>=20
> we could do with the following:
>=20
>     :kbd-backlight
>     :numpad-backlight
>=20
> I used hyphens instead of underscores since we will have this convention
> in the LED_FUNCTION names, which is more common for Device Tree, and
> some of existing LED triggers.

Existing userspace already searches for *:kbd_backlight", AFAICT, so
we probably want to keep the "_".

I don't care much if we use "platform:" or no prefix at all for
backlight of internal keyboard, as long as it is consistent across all
devices.

We certainly want to use some prefix (probably inputX:) for backlight
on USB keyboards.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--hHWLQfXTYDoKhP50
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyodyoACgkQMOfwapXb+vL5oQCcCFra/9cmt+6pqBH7En0ogzC/
8gcAoLamY/jmw88Z2vDKZI9Jtyw0MeaG
=7wli
-----END PGP SIGNATURE-----

--hHWLQfXTYDoKhP50--
