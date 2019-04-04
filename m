Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65660C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 22:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33ADE217D4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 22:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbfDDWFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 18:05:11 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:36317 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbfDDWFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 18:05:10 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 0DE46802F8; Fri,  5 Apr 2019 00:04:58 +0200 (CEST)
Date:   Fri, 5 Apr 2019 00:05:09 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dmitry Torokhov <dtor@google.com>
Cc:     Nick Crews <ncrews@chromium.org>,
        Guenter Roeck <groeck@google.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>, linux-leds@vger.kernel.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Simon Glass <sjg@google.com>
Subject: Re: [PATCH v5 3/3] platform/chrome: Standardize Chrome OS keyboard
 backlight name
Message-ID: <20190404220509.GA14690@amd>
References: <20190404185919.GB27340@amd>
 <CAE_wzQ-XuK7WOyPm6yXsmjp7z0=T92mMrfn1TVaavaLejcYVGA@mail.gmail.com>
 <20190404191931.GA29984@amd>
 <CAE_wzQ8y8i7C+_tv0CdnbUw0r21g1ggv2YUuzCog1xABivEvWA@mail.gmail.com>
 <20190404200658.GD29984@amd>
 <CAE_wzQ8WcMCzYqvxA_JBZKNza7ca3QE-VShmMxv5++_4F8RR=g@mail.gmail.com>
 <20190404202042.GF29984@amd>
 <CAE_wzQ-8XwzptH7EqNrELxjBzY2+0oHJGB3Va=vZwwK3csu_aA@mail.gmail.com>
 <20190404204207.GH29984@amd>
 <CAE_wzQ8xe=x0uYcZkDRVKpUAQ_1vVdEPHU3XnEV1=_WN1-AMfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <CAE_wzQ8xe=x0uYcZkDRVKpUAQ_1vVdEPHU3XnEV1=_WN1-AMfw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2019-04-04 14:48:35, Dmitry Torokhov wrote:
> On Thu, Apr 4, 2019 at 1:42 PM Pavel Machek <pavel@ucw.cz> wrote:
> >
> > Hi!
> >
> > > > > And what to do if internal keyboard is not platform but USB? Like
> > > > > Google "Whiskers"? (I am not sure why you decided to drop my ment=
ion
> > > > > of internal USB keyboards completely off your reply).
> > > >
> > > > I don't have answers for everything. Even if you have USB keyboard,=
 you'll
> > > > likely still have backlight connected to embedded controller. If no=
t,
> > > > then maybe you have exception userland needs to know about.
> > > >
> > > > Still better than making everything an exception.
> > >
> > > You do not need to make everything exception. You just need to look
> > > beyond the name, and see how the device is connected. And then apply
> > > your exceptions for "weird" devices.
> >
> > "Where it is connected" is not interesting to the userland. "Is it
> > backlight for internal keyboard" is the right question. It may be
> > connected to embedded controller or some kind of controller over
> > i2c... my shell scripts should not need to know about architecture of
> > every notebook out there.
>=20
> Then your scripts will be failing for some setups.

Well, yes. Do you want to guess what "lp5523:kb3" is?

> > But I don't see why I should do additional work when its trivial for
> > kernel to just name the LED in an useful way.
> >
> > "platform::kbd_backlight" has no disadvantages compared to
> > "wilco::kbd_backlight" ... so lets just use it.
>=20
> It has disadvantages because it promises more than it can deliver IMO.
> If device name !=3D "platform::kbd_backlight" it does not mean that it
> is not internal keyboard.

My promise is if "platform::kbd_backlight" exists, it is backlight for
internal keyboard. (And second half is "if it is easy for kernel, we
name backlight for internal keyboard platform::kbd_backlight").

> And you still have not resolved how you will
> handle cases when there is more than one deice that can be considered
> internal and may have a backlight.

Is that realistic? How would that device look like?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlymf5UACgkQMOfwapXb+vKzcACglDFnvuW4ng5jw2GcgyELfmD0
JQ8AoKvpn9D+y5a1b5az/OPzOxCidpsH
=o1lt
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
