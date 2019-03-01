Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCABC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 251DF20675
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388739AbfCAOnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 09:43:52 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:52959 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbfCAOnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 09:43:52 -0500
X-Originating-IP: 90.88.147.150
Received: from localhost (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr [90.88.147.150])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id C944240011;
        Fri,  1 Mar 2019 14:43:48 +0000 (UTC)
Date:   Fri, 1 Mar 2019 15:43:48 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Bin Liu <b-liu@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH] soc: sunxi: Fix missing dependency on REGMAP_MMIO
Message-ID: <20190301144348.titicfsmukd3kogj@flea>
References: <20190301022044.24431-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ycvxxw73xemms6qw"
Content-Disposition: inline
In-Reply-To: <20190301022044.24431-1-samuel@sholland.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ycvxxw73xemms6qw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 28, 2019 at 08:20:44PM -0600, Samuel Holland wrote:
> When enabling ARCH_SUNXI from allnoconfig, SUNXI_SRAM is enabled, but
> not REGMAP_MMIO, so the kernel fails to link with an undefined reference
> to __devm_regmap_init_mmio_clk. Select REGMAP_MMIO, as suggested in
> drivers/base/regmap/Kconfig.
>=20
> This creates the following dependency loop:
>=20
>   drivers/of/Kconfig:68:                symbol OF_IRQ depends on IRQ_DOMA=
IN
>   kernel/irq/Kconfig:63:                symbol IRQ_DOMAIN is selected by =
REGMAP
>   drivers/base/regmap/Kconfig:7:        symbol REGMAP default is visible =
depending on REGMAP_MMIO
>   drivers/base/regmap/Kconfig:39:       symbol REGMAP_MMIO is selected by=
 SUNXI_SRAM
>   drivers/soc/sunxi/Kconfig:4:          symbol SUNXI_SRAM is selected by =
USB_MUSB_SUNXI
>   drivers/usb/musb/Kconfig:63:          symbol USB_MUSB_SUNXI depends on =
GENERIC_PHY
>   drivers/phy/Kconfig:7:                symbol GENERIC_PHY is selected by=
 PHY_BCM_NS_USB3
>   drivers/phy/broadcom/Kconfig:29:      symbol PHY_BCM_NS_USB3 depends on=
 MDIO_BUS
>   drivers/net/phy/Kconfig:12:           symbol MDIO_BUS default is visibl=
e depending on PHYLIB
>   drivers/net/phy/Kconfig:181:          symbol PHYLIB is selected by ARC_=
EMAC_CORE
>   drivers/net/ethernet/arc/Kconfig:18:  symbol ARC_EMAC_CORE is selected =
by ARC_EMAC
>   drivers/net/ethernet/arc/Kconfig:24:  symbol ARC_EMAC depends on OF_IRQ
>=20
> To fix the circular dependency, make USB_MUSB_SUNXI select GENERIC_PHY
> instead of depending on it. This matches the use of GENERIC_PHY by all
> but two other drivers.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

I assume it would go through the USB tree.

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ycvxxw73xemms6qw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXHlFJAAKCRDj7w1vZxhR
xVjGAP94coZdopPFdqzQRv+JETzy+KzY1RokBAcmEDJWBUTH8wEAmdE+nzNgGH4d
sqt3arc0yBSd9m0BqlKM2bC48M2fBgo=
=O6Rf
-----END PGP SIGNATURE-----

--ycvxxw73xemms6qw--
