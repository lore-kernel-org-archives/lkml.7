Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1551C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 08:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9502522312
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 08:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbfKTIaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 03:30:04 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53265 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727910AbfKTIaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 03:30:04 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1iXLN6-0004qS-8S; Wed, 20 Nov 2019 09:29:56 +0100
Received: from mgr by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mgr@pengutronix.de>)
        id 1iXLN5-0006AT-7N; Wed, 20 Nov 2019 09:29:55 +0100
Date:   Wed, 20 Nov 2019 09:29:55 +0100
From:   Michael Grzeschik <mgr@pengutronix.de>
To:     Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: imx25: fix usbhost1 node
Message-ID: <20191120082955.3ovsoziurntmv7by@pengutronix.de>
References: <20191111114655.9583-1-m.grzeschik@pengutronix.de>
 <20191115083415.28976-1-m.grzeschik@pengutronix.de>
 <20191115201409.5ztt7vrhf2btpoed@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="m7xzwwcaqk6e4zvj"
Content-Disposition: inline
In-Reply-To: <20191115201409.5ztt7vrhf2btpoed@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:28:09 up 135 days, 14:38, 138 users,  load average: 0.22, 0.21,
 0.18
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--m7xzwwcaqk6e4zvj
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2019 at 09:14:09PM +0100, Uwe Kleine-K=F6nig wrote:
> Hello Michael,
>=20
> On Fri, Nov 15, 2019 at 09:34:15AM +0100, Michael Grzeschik wrote:
> > The usb port represented by &usbhost1 uses an USB phy internal to the
> > SoC. We add the phy_type to the base dtsi so the board dts only have to
> > overwrite it if they use a different configuration. While at it we also
> > pin the usbhost port to host mode and limit the speed of the phy to
> > full-speed only, which it is only capable of.
>=20
> The subject line suggests this is a fix but the commit log and the
> actual change don't support this. Maybe better:
>=20
> 	ARM: dts: imx25: consolidate properties of usbhost1 in dtsi file
>=20

Will send a new series with this suggestion.

> ?=20
>=20
> > diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
> > index 9a097ef014af5..40b95a290bd6b 100644
> > --- a/arch/arm/boot/dts/imx25.dtsi
> > +++ b/arch/arm/boot/dts/imx25.dtsi
> > @@ -570,6 +570,9 @@
> >  				clock-names =3D "ipg", "ahb", "per";
> >  				fsl,usbmisc =3D <&usbmisc 1>;
> >  				fsl,usbphy =3D <&usbphy1>;
> > +				maximum-speed =3D "full-speed";
> > +				phy_type =3D "serial";
> > +				dr_mode =3D "host";
>=20
> Would it make sense to split this patch in two? One that moves phy_type
> and dr_mode from the dts files using imx25.dtsi (which has no effects on
> the resulting dtb files). And another that adds maximum-speed.

And a second patch including the speed limitation change.

Thanks,
Michael

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--m7xzwwcaqk6e4zvj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAl3U+YMACgkQC+njFXoe
LGRtixAAlyFKmJgYeg6duQVqKdTinYouh9xcyRKXQ/8qMcGtZm3pad0+qZozdycj
AjWhY3F8fJdQxMUAZN6lTgpNuGuBpTCJ+scLv9VnU+lYKS85UBCAJ9VXIZ4f0yQ+
VolO+AkD5oLf5gv6ZU1opnpTMRam2KptGqEyRLfxoniuHGEJf046H3nrdy8hx4n6
JxRZsgzKe3abM1T205elQSzZFy6fsDDVYZfdVwpVvs+9p/GytwHl3TKucNuWb4Qe
4JDdIiMAS3B7Rf4RNMKHKVGBr7puibkcGAfL5lUEfG9Ta/utiFMYH7I9Php0d8Bn
n2ZgaGwRoAoj1x7xqn6RQFgRlCaecR2Glqwko9cLwVfMzUZJGCBafaYTQgVBRTar
7mq/BAVDSPJssowJrkaQ929NjgkUzdhcbD7avWt3OQA2ije1Syfa5aCp8RPh4RAn
VUNqIS7i27bTOkSXa8FZaTo6C2/zqDlQIWJ7/2VlSgTqD5zrDEp7RP14Ykbgdj3M
Au0IoymMMVbo3chEbA+1FH6bbnWY1MY2tBGPXyc3EgzufbXOK4/MiTIz26qNGnpj
+9S42DkuOijLKLV+au22M3VCVyD0sfSfQsj1qZY1QJqIEp2GPQLSo86YcqH1sZIJ
DnBzv3mYDN5OmhvWZ4qoBLjCIB1+Ws+5EX21NkpNCn7ehQTDMH0=
=OvER
-----END PGP SIGNATURE-----

--m7xzwwcaqk6e4zvj--
