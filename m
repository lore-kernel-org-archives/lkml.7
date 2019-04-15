Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2A1C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF8F720833
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfDOHxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 03:53:16 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:43837 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfDOHxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 03:53:16 -0400
X-Originating-IP: 90.88.18.121
Received: from localhost (aaubervilliers-681-1-63-121.w90-88.abo.wanadoo.fr [90.88.18.121])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id F05041BF20C;
        Mon, 15 Apr 2019 07:53:09 +0000 (UTC)
Date:   Mon, 15 Apr 2019 09:53:09 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Pablo Greco <pgreco@centosproject.org>
Cc:     linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] ARM: dts: sun8i: v40: bananapi-m2-berry: Enable
 GMAC ethernet controller
Message-ID: <20190415075309.p7pgj62mmtmxsnnr@flea>
References: <1555065186-8154-1-git-send-email-pgreco@centosproject.org>
 <1555065186-8154-3-git-send-email-pgreco@centosproject.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tjisfipvq5kg6xrt"
Content-Disposition: inline
In-Reply-To: <1555065186-8154-3-git-send-email-pgreco@centosproject.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tjisfipvq5kg6xrt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 12, 2019 at 07:33:01AM -0300, Pablo Greco wrote:
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
> +};
> +

If this one provides power to the pins, it should be tied to the PIO
node.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--tjisfipvq5kg6xrt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXLQ4ZQAKCRDj7w1vZxhR
xdz4AP4jMVZj59cnymFUR2ZwiQDpO5JWncdeKZAmj3ZK6Z67fgD/a0hw/unD2EE+
EHb1zlIz9mKXtVXL3kjTfP40wW7Uuwk=
=r1tW
-----END PGP SIGNATURE-----

--tjisfipvq5kg6xrt--
