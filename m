Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5052FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 08:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5250207FA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 08:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730184AbfKHI3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 03:29:11 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:43033 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbfKHI3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 03:29:11 -0500
Received: from aptenodytes (lfbn-tou-1-421-123.w86-206.abo.wanadoo.fr [86.206.246.123])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 8DD8924000F;
        Fri,  8 Nov 2019 08:29:07 +0000 (UTC)
Date:   Fri, 8 Nov 2019 09:29:07 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>, megous@megous.com,
        mark.rutland@arm.com, devicetree@vger.kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        mripard@kernel.org, kishon@ti.com, linux-sunxi@googlegroups.com,
        robh+dt@kernel.org, tglx@linutronix.de, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, icenowy@aosc.io
Subject: Re: [PATCH] phy: allwinner: Fix GENMASK misuse
Message-ID: <20191108082907.GA848664@aptenodytes>
References: <20191020134229.1216351-3-megous@megous.com>
 <20191107204645.13739-1-rikard.falkeborn@gmail.com>
 <20191107233914.GW25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <20191107233914.GW25745@shell.armlinux.org.uk>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu 07 Nov 19, 23:39, Russell King - ARM Linux admin wrote:
> On Thu, Nov 07, 2019 at 09:46:45PM +0100, Rikard Falkeborn wrote:
> > Arguments are supposed to be ordered high then low.
> >=20
> > Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> > ---
> > Spotted while trying to add compile time checks of GENMASK arguments.
> > Patch has only been compile tested.
>=20
> My feeling, personally, is that GENMASK() really isn't worth the pain
> it causes.  Can we instead get rid of this thing and just use easier
> to understand and less error-prone hex masks please?

One advantage it has is that is matches the order in which bit fields are
usually given in datasheets, so I personally found that it makes verificati=
on
of fields much more straightforward and immediate.

My 2 cents are that it makes sense for hardware registers.

Note that I have recently introduced a SHIFT_AND_MASK_BITS macro[0] for a V=
4L2
driver, that I (and Mauro) would like to move to linux/bits.h eventually.

> I don't care what anyone else says, personally I'm going to stick with
> using hex masks as I find them way easier to get right first time than
> a problematical opaque macro - and I really don't want the effort of
> finding out that I've got the arguments wrong when I build it.  It's
> just _way_ easier and less error prone to use a hex mask straight off.

I guess it's a matter of personal habit.

[0]: https://git.linuxtv.org/media_tree.git/commit/?id=3D06eff2150d4db991ca=
236f3d05a9dc0101475aea

Cheers,

Paul

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAl3FJ1MACgkQ3cLmz3+f
v9HD6QgAnn9qVrsChDkN0XT8+hfqz14mCavgmtmc/ATR+52Gp7hcnN1ADnJ1lK5D
Fg3+wdQMcs3sxpVFFPvfr1mNlGy1/OCSUerruFRSXwj+oMdv3E5foi7Y5GdrS5G2
bUFCVGT9h5MS7TrwHoiLV7I8ZgRg2/j1MyPWH4sgjSpres2BwU+0vkxh8DvJc+Hm
tJx1mzGPSFsA+RoRHdfRtSAE3iDcNibJXnct/qz6s+wtZRT/lTrAeoO2Cd6683dU
FbegbM5v+j7dhZpZ7bkbgaKrCd9EAfKYpu0WP1YOUEGes00K5J4fhvk9RpA/+l9p
l6BhN4YGDy1HqSdqxIzSiN4JXUNtag==
=aPHq
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
