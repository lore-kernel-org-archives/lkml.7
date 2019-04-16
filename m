Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D6DC282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 22:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E9FB20880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 22:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730269AbfDPWRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 18:17:05 -0400
Received: from sauhun.de ([88.99.104.3]:53092 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbfDPWRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 18:17:05 -0400
Received: from localhost (p54B332D3.dip0.t-ipconnect.de [84.179.50.211])
        by pokefinder.org (Postfix) with ESMTPSA id 0701F2C3637;
        Wed, 17 Apr 2019 00:17:03 +0200 (CEST)
Date:   Wed, 17 Apr 2019 00:17:02 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jerry Hoemann <jerry.hoemann@hpe.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/16] watchdog: hpwdt: drop warning after calling
 watchdog_init_timeout
Message-ID: <20190416221702.GC8268@kunai>
References: <20190416102515.12269-1-wsa+renesas@sang-engineering.com>
 <20190416102515.12269-7-wsa+renesas@sang-engineering.com>
 <20190416203431.GA20072@anatevka>
 <20190416204814.GA26442@roeck-us.net>
 <20190416205533.GB8268@kunai>
 <20190416212046.GC26442@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vOmOzSkFvhd7u8Ms"
Content-Disposition: inline
In-Reply-To: <20190416212046.GC26442@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vOmOzSkFvhd7u8Ms
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2019 at 02:20:46PM -0700, Guenter Roeck wrote:
> On Tue, Apr 16, 2019 at 10:55:33PM +0200, Wolfram Sang wrote:
> >=20
> > > That is indeed a problem: the pointer will be NULL if there is no par=
ent
> > > device (such as in softdog.c). Otherwise it should never be NULL.
> >=20
> > Okay, this spoils my err_dev solution. So, we probably go this route
> > then:
> >=20
> > 	pr_<errlvl>("watchdog%d: <err_msg>\n", wdd->id);
> >=20
>=20
> I don't like it because it doesn't show the driver name, and watchdog%d
> can change with each reboot. How about something like this ?
>=20
> static void pr_wdt_err(struct watchdog_device *wdd, char *text, int err)
> {
> 	if (wdd->parent)
> 		dev_err(wdd->parent, "%s: %d\n", text, err);
> 	else
> 		pr_err("%s: %s: %d\n", wdd->info->identity, text, err);
> }
>=20
> We could then use the same mechanism to generate error messages for
> watchdog_register_device().

'text' is a constant string then. Supporting a format string will make
this much more complicated. Yet, printing out the wrong timeout is
useful, I think.

What about:

	dev_str =3D wdd->parent ? dev_name(wdd->parent) : wdd->info->identity;
	pr_<errlvl>("%s: <errstr>\n", dev_str, ...);

?

This can be easily copied for watchdog_register_device, not much
overhead there.


--vOmOzSkFvhd7u8Ms
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAly2VFoACgkQFA3kzBSg
KbaGnw/9F9XO0CYfMiVIwwVdhfJsvc8MoBorDqPl3PS/ACP69cHggqOZzYaevvVy
B/xn5VPyD/faVIAZcnXE8Kds7qT2QLWkYAG5hWK67b7YwtDrJ0G8RHy/5xuWo3Ve
NaVaDUOdN2fjWKub/d6e9bZQF2302MdTrmo4QMDjzccuaLbXh8ORE7EHxg8BIeIY
fUZ8GKXNTb8oOux/KziP5y54X7o3TpiN5bstFSZXcY9hQPq3+V+Go3BrRaSBOnOF
5UZwfNO+FidGN835E5Zv1GI0aL+sDZ0QFxWgQPS1cR7imlclbd7myq2RJsh9f1Ms
7/jj/kUCgBePfgCfa2EcClndXLoVg4STrvKudyfM+s79taPNDLmNIK6DhJ/xNCn8
Ttm1Ocjfq3SIB3LaioXUyBKoNffnivmDTWNlqbarzikT3KJRwtxe33yQm9nDsKz4
N7XST11JHHwfAOysnVStrEy6oGBkHLOnrEeDSinBSmqNX0EqWG9cK74bei74gaPj
bHGSr3Y03ZZWb5wU+jCTlQsVARzYieMWIi8JxXmSRd4/orTY+twME8Rja5vAaJja
4nkigTPZI4ov1cpX/AkhJm9qYmUWhGF2aeNKC/Xi/P1qDRRR5SDwNTin1ZoQaesx
xaSS8p1Y36nfWjJERPXqmmAmyKBuKOIO/27CCafI7sNXcCUdrPg=
=bXh2
-----END PGP SIGNATURE-----

--vOmOzSkFvhd7u8Ms--
