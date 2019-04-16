Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937EEC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 702972075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730195AbfDPUuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 16:50:07 -0400
Received: from sauhun.de ([88.99.104.3]:52604 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728000AbfDPUuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 16:50:06 -0400
Received: from localhost (p54B332D3.dip0.t-ipconnect.de [84.179.50.211])
        by pokefinder.org (Postfix) with ESMTPSA id D5ABD2C3637;
        Tue, 16 Apr 2019 22:50:03 +0200 (CEST)
Date:   Tue, 16 Apr 2019 22:50:03 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Jerry Hoemann <jerry.hoemann@hpe.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/16] watchdog: hpwdt: drop warning after calling
 watchdog_init_timeout
Message-ID: <20190416205003.GA8268@kunai>
References: <20190416102515.12269-1-wsa+renesas@sang-engineering.com>
 <20190416102515.12269-7-wsa+renesas@sang-engineering.com>
 <20190416203431.GA20072@anatevka>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <20190416203431.GA20072@anatevka>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jerry,

> I applied patches 1,2 & 6 in testing.
>=20
> Note, that hpwdt is passing NULL as the third parameter to watchdog_init_=
timeout().
>=20
> The second patch in this series is using "dev" as input to dev_err and de=
v_warn.
>=20
> This results in the following in dmesg when trying to load hpwdt w/ an in=
valid soft_margin:
>=20
>=20
> [   80.848160] (NULL device *): driver supplied timeout (4294967295) out =
of range
> [   80.855429] (NULL device *): falling back to default timeout (30)

Thank you for this report. Yes, using 'dev' blindly is a bug.

> if the call in hpwdt driver is changed to:
>=20
> 	if (watchdog_init_timeout(&hpwdt_dev, soft_margin, &dev->dev))
>=20
>=20
> We see the message like we'd desire:
>=20
> [ 2061.167100] hpwdt 0000:01:00.0: driver supplied timeout (4294967295) o=
ut of range
> [ 2061.174633] hpwdt 0000:01:00.0: falling back to default timeout (30)

The above observation makes sense, but I think we should fix the core
code and not the hpwdt driver. My suggestion would be to add something
like this to watchdog_init_timeout():

	struct device *err_dev =3D dev ?: wdd->parent;

And then use err_dev for all the printing. Guenter?

Regards,

   Wolfram


--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAly2P/cACgkQFA3kzBSg
Kba5QRAAsCrgIJWS6eg2cA75jqiE2VtTWnfb4b1dQB1HtNSdE78SMuVoap75g5PS
JAgLewDV9qw0OYl392InLSHjy7UV1TGT9WXhTHbLGW5QTqyUM99EgdwbJwQgcROG
FvkXFNXLO3QJTiXsPpVJbJZsKXHlItC7RweTha6Q6MQ9pEEs9Vh6zpKB3JxmlWHQ
SuunJu+xl3SepuP9HIkVD8opHqRIwO7pLsehlHMkGzBTeVynYW22w9THkaqJZkK5
9Ze4Ctj8V+5ItmgY8rRSetlRuYksP4likMAAKdFkB6JitpawR3JQGuRpC/7namEo
sMT1n9gVC6yOax4WsGLaCNFmmrXsmxsrsUvwt2h8/5Q3LvixGzHlNZOzbA829xUD
ai6i9T+EE/J7B7wN7/XToHSimqpEoru4Qq6BaGXQ4MDY30gFdNPKMx8Og0F/jl/I
umXT2+IGXihmrQuH7VAn33SwJLgxmplO6dAGVBJQwWNspkvPgdyQ963oSVhnnsfA
BWgxoZB/PCiOVxEkD0iShSzbQKP+xuEmD9k0aVSGtLPANMPRYj8gHFdU9q5Px+XM
OxXvYh35c3fxWCGplca+8K9Ihol1+pz3kfkEO8VEKpyFINhi7n7j0v/vwg71iLK4
1RB+bWXSHN3sKI4z6B6vR56jx2wP8GrEbIKNSBbW5/zb1uQBQ7g=
=qbKk
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
