Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5721C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A5320651
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730648AbfDDULD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 16:11:03 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33631 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729497AbfDDULD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 16:11:03 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id E142F802F6; Thu,  4 Apr 2019 22:10:52 +0200 (CEST)
Date:   Thu, 4 Apr 2019 22:11:03 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dmitry Torokhov <dtor@google.com>
Cc:     Nick Crews <ncrews@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>, linux-leds@vger.kernel.org,
        jacek.anaszewski@gmail.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Daniel Erat <derat@google.com>,
        Guenter Roeck <groeck@google.com>
Subject: Re: [PATCH] platform/chrome: Add Wilco EC keyboard backlight LEDs
 support
Message-ID: <20190404201103.GE29984@amd>
References: <20190308203801.57920-1-ncrews@chromium.org>
 <20190308210843.GA16125@amd>
 <CAHX4x85=_76=Kyepf3Nw++4yVKOZujhLsonzaicZOnY5fi-Pfw@mail.gmail.com>
 <20190404112415.GB18653@amd>
 <CAE_wzQ96MkKb7uSoVBNkOZexevUKPf4jHyQZneg7YNCEs7SHfQ@mail.gmail.com>
 <20190404190326.GC27340@amd>
 <CAE_wzQ8mr1OMKB+ASfsCdGcs70YrzEMN4Htfg1+O51=ByhXchw@mail.gmail.com>
 <20190404192331.GB29984@amd>
 <CAE_wzQ_4Jb+4dDTFGQ7+sbQ-M8Qm8U_k7ug2DoZKKjTbf6pPTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Oiv9uiLrevHtW1RS"
Content-Disposition: inline
In-Reply-To: <CAE_wzQ_4Jb+4dDTFGQ7+sbQ-M8Qm8U_k7ug2DoZKKjTbf6pPTQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Oiv9uiLrevHtW1RS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2019-04-04 13:07:39, Dmitry Torokhov wrote:
> On Thu, Apr 4, 2019 at 12:23 PM Pavel Machek <pavel@ucw.cz> wrote:
> >
> > Hi!
> >
> > > > > > Yeah, well, we not let the cros_kbd_led_backlight.c use chromeo=
s:: in
> > > > > > the first place. But it happened. We want all backlights for the
> > > > > > system keyboard to use common name, and "chromeos" is not really
> > > > > > suitable for that. "platform" is.
> > > > >
> > > > > Pavel, who exactly wants this and why? Looking at today's -next I=
 see:
> > > > >
> > > > > dtor@dtor-ws:~/kernel/linux-next ((next-20190404))$ git grep
> > > > > "::kbd_backlight" | wc -l
> > > > > 18
> > > > > dtor@dtor-ws:~/kernel/linux-next ((next-20190404))$ git grep
> > > > > "platform::kbd_backlight" | wc -l
> > > > > 0
> > > > >
> > > > > so there isn't a single instance of "platform::kbd_backlight" and=
 we
> > > > > definitely not changing existing names.
> > > >
> > > > Yeah, we made mistakes in the past. We _don't_ want userspace to ha=
ve
> > > > ever growing list of names for userspace to follow.
> > > >
> > > > Backlight of internal keyboard is pretty common concept and there
> > > > should be one name for it.
> > >
> > > It is the *function* that is interesting to userspace, not full name,
> > > and we have proper standardization there.
> >
> > Well, if full name is not interesting, as you argue, why do we have
> > this discussion?
>=20
> Because I need to understand why you believe that device name for
> kbd_backlight matters, and having wilco::kbd_backlight is a bad idea,
> but, for example, having max77650::kbd_backlight is perfectly fine if
> somebody decided to wire it in this way.

max77650::kbd_backlight is not fine and we'll try to prevent that in
future.

We want one name for internal keyboard backlight. What exactly that
name is is not _that_ important, but platform::kbd_backlight seems
like reasonable choice.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Oiv9uiLrevHtW1RS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlymZNcACgkQMOfwapXb+vJMuQCgtpXHKiya8+IaL3HEtsjJ0nwK
vB0An3F53T4uI6dDdvkfyntFVdX6tY5Y
=Ex99
-----END PGP SIGNATURE-----

--Oiv9uiLrevHtW1RS--
