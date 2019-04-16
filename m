Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B78FC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36A2B20693
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbfDPNBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:01:31 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:50743 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfDPNBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:01:30 -0400
Received: from localhost (aaubervilliers-681-1-42-238.w90-88.abo.wanadoo.fr [90.88.160.238])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 84DE320002B;
        Tue, 16 Apr 2019 13:00:57 +0000 (UTC)
Date:   Tue, 16 Apr 2019 15:00:57 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Pablo =?utf-8?Q?Sebasti=C3=A1n?= Greco <pgreco@centosproject.org>
Cc:     linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] ARM: dts: sun8i: v40: bananapi-m2-berry: Enable
 GMAC ethernet controller
Message-ID: <20190416130057.bjaweorywikaa6ig@flea>
References: <1555065186-8154-1-git-send-email-pgreco@centosproject.org>
 <1555065186-8154-3-git-send-email-pgreco@centosproject.org>
 <20190415075309.p7pgj62mmtmxsnnr@flea>
 <eb80d64f-7355-071b-c1d1-04e0eb4475ce@centosproject.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2w42a2v2c5vbfesk"
Content-Disposition: inline
In-Reply-To: <eb80d64f-7355-071b-c1d1-04e0eb4475ce@centosproject.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2w42a2v2c5vbfesk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

65;5600;1c
On Tue, Apr 16, 2019 at 07:47:09AM -0300, Pablo Sebasti=E1n Greco wrote:
>
> El 15/4/19 a las 04:53, Maxime Ripard escribi=F3:
> > On Fri, Apr 12, 2019 at 07:33:01AM -0300, Pablo Greco wrote:
> > > Just like the Bananapi M2 Ultra, the Bananapi M2 Berry has a Realtek
> > > RTL8211E RGMII PHY tied to the GMAC.
> > > The PMIC's DC1SW output provides power for the PHY, while the ALDO2
> > > output provides I/O voltages on both sides.
> > >
> > > Signed-off-by: Pablo Greco <pgreco@centosproject.org>
> > > ---
> > >   arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts | 30 ++++++++++++=
+++++++++++
> > >   1 file changed, 30 insertions(+)
> > >
> > > diff --git a/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts b/arch=
/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
> > > index f05cabd..0d79e91 100644
> > > --- a/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
> > > +++ b/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
> > > @@ -50,6 +50,7 @@
> > >   	compatible =3D "sinovoip,bpi-m2-berry", "allwinner,sun8i-r40";
> > >
> > >   	aliases {
> > > +		ethernet0 =3D &gmac;
> > >   		serial0 =3D &uart0;
> > >   	};
> > >
> > > @@ -92,6 +93,22 @@
> > >   	status =3D "okay";
> > >   };
> > >
> > > +&gmac {
> > > +	pinctrl-names =3D "default";
> > > +	pinctrl-0 =3D <&gmac_rgmii_pins>;
> > > +	phy-handle =3D <&phy1>;
> > > +	phy-mode =3D "rgmii";
> > > +	phy-supply =3D <&reg_dc1sw>;
> > > +	status =3D "okay";
> > > +};
> > > +
> > > +&gmac_mdio {
> > > +	phy1: ethernet-phy@1 {
> > > +		compatible =3D "ethernet-phy-ieee802.3-c22";
> > > +		reg =3D <1>;
> > > +	};
> > > +};
> > > +
> > >   &i2c0 {
> > >   	status =3D "okay";
> > >
> > > @@ -123,6 +140,13 @@
> > >   	status =3D "okay";
> > >   };
> > >
> > > +&reg_aldo2 {
> > > +	regulator-always-on;
> > > +	regulator-min-microvolt =3D <2500000>;
> > > +	regulator-max-microvolt =3D <2500000>;
> > > +	regulator-name =3D "vcc-pa";
> > > +};
> > > +
> > If this one provides power to the pins, it should be tied to the PIO
> > node.
>
> In that case, I should fix the bananapi-m2-ultra the same way. Do you pre=
fer
> me to add those fixes to this series?

If you have that board, then please add that yep.

> Or is it better to apply this like it is, and I fix both together in a
> separated series?

No, please resend a new version.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--2w42a2v2c5vbfesk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXLXSCQAKCRDj7w1vZxhR
xSSuAQCQ/kkSRgvp8XeaTQsZFfcjmgEBvvtjYDzpMrPJdVpClwD/Q3IuzuS0sWoE
nYcAS9VzOQTUlt9QAbaD7EeaL/sdOQg=
=0e9z
-----END PGP SIGNATURE-----

--2w42a2v2c5vbfesk--
