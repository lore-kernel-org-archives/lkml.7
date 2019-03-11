Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38CBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7577214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbfCKVw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 17:52:27 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42844 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfCKVw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 17:52:27 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id B3A7580730; Mon, 11 Mar 2019 22:52:17 +0100 (CET)
Date:   Mon, 11 Mar 2019 22:52:24 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Nick Crews <ncrews@chromium.org>
Cc:     kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/chrome: Add Wilco EC keyboard backlight LEDs
 support
Message-ID: <20190311215224.GA11869@amd>
References: <20190308203801.57920-1-ncrews@chromium.org>
 <CAE_wzQ-Ds5a9iPuLTpV5mBHBtoUUh_-fRw66s0Su7eOifygqKQ@mail.gmail.com>
 <20190308221307.GB16125@amd>
 <CAHX4x84pgHeseVphBUq0HLJ70KU-Fz1TQtaq1=iz=mFCDZuJkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <CAHX4x84pgHeseVphBUq0HLJ70KU-Fz1TQtaq1=iz=mFCDZuJkw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-03-11 09:36:20, Nick Crews wrote:
> On Fri, Mar 8, 2019 at 3:13 PM Pavel Machek <pavel@ucw.cz> wrote:
> >
> > Hi!
> >
> > > > This patch is meant to be applied on top of the for-next
> > > > branch of the platform/chrome repository, as it uses some of
> > > > the code staged there.
> > > >
> > > > The EC is in charge of controlling the keyboard backlight on
> > > > the Wilco platform. We expose a standard LED class device at
> > > > /sys/class/leds/wilco::kbd_backlight. This driver is modeled
> > > > after the standard Chrome OS keyboard backlight driver at
> > > > drivers/platform/chrome/cros_kbd_led_backlight.c
> > > >
> > > > Some Wilco devices do not support a keyboard backlight. This
> > > > is checked in probe(), and in this case the sysfs entry will
> > > > not appear, and everything will behave normally.
> > >
> > > It would be even better if we did not register platform device if EC
> > > does not support backlight.
>=20
> Good point Dmitry. That would require making the core driver
> dependent upon this keyboard backlight driver, though. Do you
> think that added complexity is worth it? I don't see performance
> concerns with adding one unused platform device, so is your rationale
> that it would just be cleaner code?
>=20

You probably wanted to mail dmitry. You should have probably cc-ed
Dmitry and the lists.

> > > > +       data->led.brightness_set =3D keyboard_led_set_brightness;
> > > > +       data->led.brightness_get =3D keyboard_led_get_brightness;
> > >
> > > wilco_ec_mailbox() may sleep, so you need to assign it to
> > > led.brightness_set_blocking.
> >
> > Hmm. Seeing get method there... can the EC change the brightness
> > without command from kernel?
>=20
> No, the EC won't change the brightness without getting told to by
> the kernel. Do you think that means that we could get away with just
> caching the brightness from the previous set_brightness(), and not
> actually sending a mailbox) command to the EC on get_brightness()?

Something like that. Even better ... don't implement brightness_get at
all, and check that core does the right thing checking it.
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyG2JgACgkQMOfwapXb+vKCUACfRRJXyEh2d0B2t/ryZkDRBJxh
2YcAniWQXISxY4P7uJzbqygouUX7zPfR
=Ucwz
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
