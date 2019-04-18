Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_RHS_DOB,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EA4C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E49AF2148D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389596AbfDRPzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 11:55:19 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:46255 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733067AbfDRPzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 11:55:19 -0400
X-Originating-IP: 90.89.68.76
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 3EC2BE0002;
        Thu, 18 Apr 2019 15:55:16 +0000 (UTC)
Date:   Thu, 18 Apr 2019 17:55:15 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Pablo Greco <pgreco@centosproject.org>
Cc:     linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/7] ARM: dts: sun8i: v40: bananapi-m2-berry: Enable
 GMAC ethernet controller
Message-ID: <20190418155515.cb2saxlvthzhaozq@flea>
References: <1555600282-9405-1-git-send-email-pgreco@centosproject.org>
 <1555600282-9405-2-git-send-email-pgreco@centosproject.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zbzvrvpxfhwci4pw"
Content-Disposition: inline
In-Reply-To: <1555600282-9405-2-git-send-email-pgreco@centosproject.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zbzvrvpxfhwci4pw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 18, 2019 at 12:11:16PM -0300, Pablo Greco wrote:
> Just like the Bananapi M2 Ultra, the Bananapi M2 Berry has a Realtek
> RTL8211E RGMII PHY tied to the GMAC.
> The PMIC's DC1SW output provides power for the PHY, while the ALDO2
> output provides I/O voltages on both sides.
>
> Signed-off-by: Pablo Greco <pgreco@centosproject.org>
> ---
>  arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts | 30 +++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts b/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
> index f05cabd..0d79e91 100644
> --- a/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
> +++ b/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
> @@ -50,6 +50,7 @@
>  	compatible = "sinovoip,bpi-m2-berry", "allwinner,sun8i-r40";
>
>  	aliases {
> +		ethernet0 = &gmac;
>  		serial0 = &uart0;
>  	};
>
> @@ -92,6 +93,22 @@
>  	status = "okay";
>  };
>
> +&gmac {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&gmac_rgmii_pins>;
> +	phy-handle = <&phy1>;
> +	phy-mode = "rgmii";
> +	phy-supply = <&reg_dc1sw>;
> +	status = "okay";
> +};
> +
> +&gmac_mdio {
> +	phy1: ethernet-phy@1 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <1>;
> +	};
> +};
> +
>  &i2c0 {
>  	status = "okay";
>
> @@ -123,6 +140,13 @@
>  	status = "okay";
>  };
>
> +&reg_aldo2 {
> +	regulator-always-on;
> +	regulator-min-microvolt = <2500000>;
> +	regulator-max-microvolt = <2500000>;
> +	regulator-name = "vcc-pa";

And if patches 6 and 7 become the first one, you can drop the
always-on here.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--zbzvrvpxfhwci4pw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXLid4wAKCRDj7w1vZxhR
xQ0QAQDSqU5QZpnYtQOpyxf6WF1r2eoIBEj7/e2Ls7IM67vjWgEAn8WmjUblSOev
QQsoVS1lz+iER6wyKQR8sMIuwXRgiQQ=
=fC1u
-----END PGP SIGNATURE-----

--zbzvrvpxfhwci4pw--
