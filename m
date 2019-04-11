Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D32C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B67C2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfDKIKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 04:10:01 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:49343 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfDKIKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 04:10:00 -0400
X-Originating-IP: 90.88.18.121
Received: from localhost (aaubervilliers-681-1-63-121.w90-88.abo.wanadoo.fr [90.88.18.121])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 9E98720007;
        Thu, 11 Apr 2019 08:09:55 +0000 (UTC)
Date:   Thu, 11 Apr 2019 10:09:55 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
        rjw@rjwysocki.net, davem@davemloft.net, mchehab+samsung@kernel.org,
        gregkh@linuxfoundation.org, nicolas.ferre@microchip.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] cpufreq: Add sunxi nvmem based CPU scaling driver
Message-ID: <20190411080955.ysp3wreifwqrpn3n@flea>
References: <20190410174139.20012-1-tiny.windzz@gmail.com>
 <20190410174139.20012-2-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ljbikfewuqsnslmi"
Content-Disposition: inline
In-Reply-To: <20190410174139.20012-2-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ljbikfewuqsnslmi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Wed, Apr 10, 2019 at 01:41:38PM -0400, Yangtao Li wrote:
> For some SoCs, the CPU frequency subset and voltage value of each OPP
> varies based on the silicon variant in use. The sunxi-cpufreq-nvmem
> driver reads the efuse value from the SoC to provide the OPP framework
> with required information.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

The driver has a bunch of checkpatch warnings, please fix them
(running checkpatch with --strict).

> ---
>  MAINTAINERS                           |   7 +
>  drivers/cpufreq/Kconfig.arm           |  10 ++
>  drivers/cpufreq/Makefile              |   1 +
>  drivers/cpufreq/cpufreq-dt-platdev.c  |   2 +
>  drivers/cpufreq/sunxi-cpufreq-nvmem.c | 232 ++++++++++++++++++++++++++
>  5 files changed, 252 insertions(+)
>  create mode 100644 drivers/cpufreq/sunxi-cpufreq-nvmem.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 391405091c6b..bfd18ba6aa1a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -667,6 +667,13 @@ S:	Maintained
>  F:	Documentation/i2c/busses/i2c-ali1563
>  F:	drivers/i2c/busses/i2c-ali1563.c
>
> +ALLWINNER CPUFREQ DRIVER
> +M:	Yangtao Li <tiny.windzz@gmail.com>
> +L:	linux-pm@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt
> +F:	drivers/cpufreq/sunxi-cpufreq-nvmem.c
> +

Please use a less generic name for the driver as well. It's called
sunxi, but applies to a single SoC (for now).

> +struct sunxi_cpufreq_soc_data {
> +	u32 (*efuse_xlate)(const struct sunxi_cpufreq_soc_data *soc_data,
> +			   u32 efuse);
> +	u32 nvmem_mask;
> +	u32 nvmem_shift;
> +};

What cases do you have? You're mentionning that it might apply to more
SoCs, which ones? How is the data stored on those SoCs (and why do you
need this particular abstraction)?

Thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ljbikfewuqsnslmi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXK72UwAKCRDj7w1vZxhR
xddWAP4/ozszJEsxyLl3PcSuUQNUmGNPTI5/EZoFHMnPIMM1+gEA26Mdnj9YBQVs
HKxva/PTNG3RNdsvgtKweCHQ+Qrllww=
=diSg
-----END PGP SIGNATURE-----

--ljbikfewuqsnslmi--
