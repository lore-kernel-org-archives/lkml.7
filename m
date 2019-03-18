Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924AFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B3E62084F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfCRLy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 07:54:56 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35195 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbfCRLyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 07:54:55 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id A4042804E2; Mon, 18 Mar 2019 12:54:45 +0100 (CET)
Date:   Mon, 18 Mar 2019 12:54:52 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 6/6] leds: netdev trigger: allow setting initial
 values in device tree
Message-ID: <20190318115452.GE6101@amd>
References: <20190313202615.22883-1-linux@rasmusvillemoes.dk>
 <20190314140619.3309-1-linux@rasmusvillemoes.dk>
 <20190314140619.3309-7-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="M/SuVGWktc5uNpra"
Content-Disposition: inline
In-Reply-To: <20190314140619.3309-7-linux@rasmusvillemoes.dk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M/SuVGWktc5uNpra
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2019-03-14 15:06:19, Rasmus Villemoes wrote:
> It can be quite convenient to initialize a netdev-triggered LED with a
> device name and setting the rx,tx,link properties from device tree,
> instead of having to do that in an init script (or udev rule) in
> userspace.
>=20
> My main motivation for this is to be able to switch away from the
> deprecated CONFIG_CAN_LEDS. The example added to common.txt
> corresponds to switching linux,default-trigger =3D "can0-rxtx" to
> "netdev" and adding the indicated netdev subnode.
>=20
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  .../devicetree/bindings/leds/common.txt       | 11 +++++++
>  drivers/leds/trigger/ledtrig-netdev.c         | 30 +++++++++++++++++++
>  2 files changed, 41 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/leds/common.txt b/Document=
ation/devicetree/bindings/leds/common.txt
> index 7cb88460a47c..f8078c4cf6f8 100644
> --- a/Documentation/devicetree/bindings/leds/common.txt
> +++ b/Documentation/devicetree/bindings/leds/common.txt
> @@ -43,6 +43,17 @@ Optional properties for child nodes:
>                  Documentation/ABI/testing/sysfs-class-led-trigger-netdev)
>                  to reflect the state and activity of a net device.
> =20
> +                The optional child node netdev can be used to
> +                configure initial values for the link, rx, tx and
> +                device_name properties. For example,
> +
> +                netdev {
> +                    rx;
> +                    tx;
> +                    link;
> +                    device-name =3D "can0";

Well, NAK, as explained before. Use phandle.

Alternatively, adding comment why CONFIG_CAN_LEDS can not be removed
just yet near the deprecation note would be acceptable.

									Pavel
								=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--M/SuVGWktc5uNpra
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyPhwwACgkQMOfwapXb+vK8nQCePbEAWGZFRuBgSYDvpKSHn2KM
DnwAn1L2nTdBbD2v+GKB8OK1hneu+wcI
=7BuZ
-----END PGP SIGNATURE-----

--M/SuVGWktc5uNpra--
