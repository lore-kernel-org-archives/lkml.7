Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF7FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B2B20657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfCKOmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:42:31 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52044 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfCKOma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 10:42:30 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 4D5A080615; Mon, 11 Mar 2019 15:42:21 +0100 (CET)
Date:   Mon, 11 Mar 2019 15:42:28 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Per N. Christensen" <pnc@deif.com>, Thomas Winding <twi@deif.com>
Subject: Re: replacement for CAN_LEDS
Message-ID: <20190311144227.GA4404@amd>
References: <729bdb48-8253-282a-2e0b-860ec5ff345c@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
In-Reply-To: <729bdb48-8253-282a-2e0b-860ec5ff345c@prevas.dk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I'm in the process of upgrading an old BSP to a 4.19 kernel, and noticed
> that CAN_LEDS has been marked broken. The comments say that the netdev
> trigger can do everything, but doesn't provide much guidance on how to
> actually do the transition.

Seems like something to be improved.

> In my case, I used to have a device tree node
>=20
>                 canb {
>                         label =3D "canb:green:activity";
>                         gpios =3D <&gpio0 5 0>;
>                         default-state =3D "off";
>                         linux,default-trigger =3D "can1-rxtx";
>                 };
>=20
> and if I change the default-trigger to netdev, I get sysfs files in
> /sys/class/leds/canb:green:activity ; if I then echo can1 to device_name
> and 1 to rx,tx, and link, I get the behaviour I used to have.
>=20
> Questions: must this setup be done in userspace like this? Is there some
> udev rule template I could copy? I can also just hardcode the above
> dance in some init script.
>=20
> I'd actually prefer keeping the entire setup in device tree. So would it
> be possible to have netdev_trig_activate() look for some properties in
> the DT node for the led_classdev and populate ->device_name and ->mode
> based on them?

Sounds like good idea. Patch would be welcome...
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyGc9MACgkQMOfwapXb+vJ9mgCgu8Nk/irs2oazbXlwdhbJ8tWK
jbIAn3YBob59JCCPDWOCuzuFHK6aRsxb
=XRTd
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
