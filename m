Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D5CC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 08:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9BDF2145D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 08:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404746AbfFKI2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 04:28:10 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:51675 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404567AbfFKI2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 04:28:09 -0400
X-Originating-IP: 90.88.159.246
Received: from localhost (aaubervilliers-681-1-40-246.w90-88.abo.wanadoo.fr [90.88.159.246])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 9B65EFF80D;
        Tue, 11 Jun 2019 08:27:58 +0000 (UTC)
Date:   Tue, 11 Jun 2019 10:27:58 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH v3 6/7] arm64: dts: allwinner: h6: Add DMA node
Message-ID: <20190611082758.raznfgrshvbc7lh4@flea>
References: <20190527201459.20130-1-peron.clem@gmail.com>
 <20190527201459.20130-7-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hgbw2pta2w7pzljd"
Content-Disposition: inline
In-Reply-To: <20190527201459.20130-7-peron.clem@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hgbw2pta2w7pzljd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I tried applying this patch, and it conflicts.

There's also a minor issue that sohuld be fixed

On Mon, May 27, 2019 at 10:14:58PM +0200, Cl=E9ment P=E9ron wrote:
> From: Jernej Skrabec <jernej.skrabec@siol.net>
>
> H6 has DMA controller which supports 16 channels.
>
> Add a node for it.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/bo=
ot/dts/allwinner/sun50i-h6.dtsi
> index 16c5c3d0fd81..f4ea596c82ce 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -208,6 +208,18 @@
>  			reg =3D <0x03006000 0x400>;
>  		};
>
> +		dma: dma-controller@3002000 {
> +			compatible =3D "allwinner,sun50i-h6-dma";
> +			reg =3D <0x03002000 0x1000>;
> +			interrupts =3D <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&ccu CLK_BUS_DMA>, <&ccu CLK_MBUS_DMA>;
> +			clock-names =3D "bus", "mbus";
> +			dma-channels =3D <16>;
> +			dma-requests =3D <46>;
> +			resets =3D <&ccu RST_BUS_DMA>;
> +			#dma-cells =3D <1>;
> +		};
> +
>  		pio: pinctrl@300b000 {
>  			compatible =3D "allwinner,sun50i-h6-pinctrl";
>  			reg =3D <0x0300b000 0x400>;

DT nodes are ordered by increasing physical addresses, so this node
shouldn't be there.

Thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--hgbw2pta2w7pzljd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXP9mDgAKCRDj7w1vZxhR
xeglAPwIW36bLSAE8g46D6JILsJk6w6C0BIIbR0gS4UHeOmtswEAnm9PNial2hiQ
BhIQ8CM9gowudS/CZB7KUSMsrInbXAo=
=PF9a
-----END PGP SIGNATURE-----

--hgbw2pta2w7pzljd--
