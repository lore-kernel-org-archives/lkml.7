Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EF5C10F05
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 19:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAFAF20872
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 19:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfCQTLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 15:11:54 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:36421 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfCQTLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 15:11:53 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 9803580744; Sun, 17 Mar 2019 20:11:43 +0100 (CET)
Date:   Sun, 17 Mar 2019 20:11:50 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-can@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH 4/4] leds: netdev trigger: allow setting initial values
 in device tree
Message-ID: <20190317191150.GA31285@amd>
References: <20190311144227.GA4404@amd>
 <20190313202615.22883-1-linux@rasmusvillemoes.dk>
 <20190313202615.22883-5-linux@rasmusvillemoes.dk>
 <20190314102911.GA15173@amd>
 <6fb71b90-1ae3-9d93-6e0c-c95e441ced7a@rasmusvillemoes.dk>
 <20190314120047.GA19072@amd>
 <2cd9c42c-1056-979f-568e-c7e387bf90c6@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <2cd9c42c-1056-979f-568e-c7e387bf90c6@rasmusvillemoes.dk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2019-03-14 14:19:42, Rasmus Villemoes wrote:
> On 14/03/2019 13.00, Pavel Machek wrote:
> linux,default-trigger from
> >=20
> > Yeah and now insert the modules for the can devices in different
> > order... May not happen in your case but will be fairly common for
> > ethernets.
>=20
> Unpredictable device names is not a problem I'm trying to solve, nor one
> that actually occurs on embedded systems. And even if one has such a
> system, one is likely running udev or similar to rename devices to
> something sane and predictable, in which case a fixed string _still_
> works fine. Or one uses udev rules to munge the netdev trigger sysfs
> files, and has applications dealing with devices appearing as banana457.
>=20
> OK, so there's of_find_net_device_by_node, so a phandle solution might
> also be possible, and might work just as well for my case. But I still
> think initializing with a fixed string is the simplest and sanest thing
> to do.

Simplest, yes. Mergeable, no. Sorry.

Udev will not help with renaming -- it runs after kernel boot, while
udev parsing is usually done before userland starts.

Plus, device tree should really describe hardware, and be usable with
other operating systems. Of course, there are exceptions, but "can0"
is unneccessarily linux-specific.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyOm/YACgkQMOfwapXb+vK53QCeIdu8vu9Fai0AxUL3FZQMEO2k
r5QAoKxdUdhvcbLSBdfF+dFwQEtFyYK5
=JKhN
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
