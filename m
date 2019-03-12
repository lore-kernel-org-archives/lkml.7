Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A999C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A84217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfCLPhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:37:02 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:57793 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfCLPg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:36:59 -0400
X-Originating-IP: 90.88.22.102
Received: from localhost (aaubervilliers-681-1-80-102.w90-88.abo.wanadoo.fr [90.88.22.102])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id BF6E6FF80A;
        Tue, 12 Mar 2019 15:36:54 +0000 (UTC)
Date:   Tue, 12 Mar 2019 16:36:54 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 04/14] pinctrl: sunxi: v3: really introduce support for V3
Message-ID: <20190312153654.25r5orlw7qjtlhbt@flea>
References: <20190312152256.35574-1-icenowy@aosc.io>
 <20190312152256.35574-5-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="s44e46kj3dzvjmpr"
Content-Disposition: inline
In-Reply-To: <20190312152256.35574-5-icenowy@aosc.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s44e46kj3dzvjmpr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2019 at 11:22:46PM +0800, Icenowy Zheng wrote:
> Introduce the GPIO pins that is only available on V3 (not on V3s) to the
> V3 pinctrl driver.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  drivers/pinctrl/sunxi/pinctrl-sun8i-v3.c | 291 +++++++++++++++++++++--
>  drivers/pinctrl/sunxi/pinctrl-sunxi.h    |   2 +
>  2 files changed, 275 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sun8i-v3.c b/drivers/pinctrl/s=
unxi/pinctrl-sun8i-v3.c
> index 6704ce8e5e3d..54c210871a95 100644
> --- a/drivers/pinctrl/sunxi/pinctrl-sun8i-v3.c
> +++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-v3.c
> @@ -1,5 +1,5 @@
>  /*
> - * Allwinner V3s SoCs pinctrl driver.
> + * Allwinner V3/V3s SoCs pinctrl driver.
>   *
>   * Copyright (C) 2016 Icenowy Zheng <icenowy@aosc.xyz>
>   *
> @@ -23,7 +23,7 @@
> =20
>  #include "pinctrl-sunxi.h"
> =20
> -static const struct sunxi_desc_pin sun8i_v3s_pins[] =3D {
> +static const struct sunxi_desc_pin sun8i_v3_v3s_pins[] =3D {

I'm not sure all that remaining is worth it to be honest. It adds a
lot of noise for no particular reason (and the same goes for renaming
the file itself).

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--s44e46kj3dzvjmpr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXIfSFgAKCRDj7w1vZxhR
xeMoAP9cCIzeT8Xt0BOkFXCLT5N0x8WG+hu1LJdL68F4nFyYBwEAjKgt55dGpvYI
Ct/rlZuXdLVvzId1pYTvBgYdBH9H8QA=
=pRN9
-----END PGP SIGNATURE-----

--s44e46kj3dzvjmpr--
