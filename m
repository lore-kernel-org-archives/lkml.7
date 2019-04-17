Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43406C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A55420835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731371AbfDQIaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 04:30:20 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:54993 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbfDQIaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 04:30:20 -0400
Received: from localhost (aaubervilliers-681-1-42-238.w90-88.abo.wanadoo.fr [90.88.160.238])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id E17BA240004;
        Wed, 17 Apr 2019 08:30:00 +0000 (UTC)
Date:   Wed, 17 Apr 2019 10:30:00 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
        rjw@rjwysocki.net, davem@davemloft.net, mchehab+samsung@kernel.org,
        gregkh@linuxfoundation.org, nicolas.ferre@microchip.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] dt-bindings: cpufreq: Document
 allwinner,sun50i-h6-operating-points
Message-ID: <20190417083000.cwzvhlpbxqoifosw@flea>
References: <20190416155209.24216-1-tiny.windzz@gmail.com>
 <20190416155209.24216-3-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f3k7wehh6o47a3dc"
Content-Disposition: inline
In-Reply-To: <20190416155209.24216-3-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f3k7wehh6o47a3dc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 16, 2019 at 11:52:09AM -0400, Yangtao Li wrote:
> Allwinner Process Voltage Scaling Tables defines the voltage and
> frequency value based on the speedbin blown in the efuse combination.
> The sunxi-cpufreq-nvmem driver reads the efuse value from the SoC to
> provide the OPP framework with required information.
> This is used to determine the voltage and frequency value for each
> OPP of operating-points-v2 table when it is parsed by the OPP framework.
>
> The "allwinner,sun50i-h6-operating-points" DT extends the
> "operating-points-v2"
> with following parameters:
> - nvmem-cells (NVMEM area containig the speedbin information)
> - opp-microvolt-<name>: voltage in micro Volts.
>   At runtime, the platform can pick a <name> and matching
>   opp-microvolt-<name> property.
> 			HW:		<name>:
> 			sun50iw-h6      speed0 speed1 speed2
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  .../bindings/opp/sun50i-nvmem-cpufreq.txt     | 167 ++++++++++++++++++
>  1 file changed, 167 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/opp/sun50i-nvmem-cpufreq.txt
>
> diff --git a/Documentation/devicetree/bindings/opp/sun50i-nvmem-cpufreq.txt b/Documentation/devicetree/bindings/opp/sun50i-nvmem-cpufreq.txt
> new file mode 100644
> index 000000000000..3cb39c6caec3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/opp/sun50i-nvmem-cpufreq.txt
> @@ -0,0 +1,167 @@
> +Allwinner Technologies, Inc. NVMEM CPUFreq and OPP bindings
> +===================================
> +
> +For some SoCs, the CPU frequency subset and voltage value of each OPP
> +varies based on the silicon variant in use. Allwinner Process Voltage
> +Scaling Tables defines the voltage and frequency value based on the
> +speedbin blown in the efuse combination. The sun50i-cpufreq-nvmem driver
> +reads the efuse value from the SoC to provide the OPP framework with
> +required information.
> +
> +Required properties:
> +--------------------
> +In 'cpus' nodes:
> +- operating-points-v2: Phandle to the operating-points-v2 table to use.
> +
> +In 'operating-points-v2' table:
> +- compatible: Should be
> +	- 'allwinner,sun50i-h6-operating-points'.
> +- nvmem-cells: A phandle pointing to a nvmem-cells node representing the
> +		efuse registers that has information about the speedbin
> +		that is used to select the right frequency/voltage value
> +		pair. Please refer the for nvmem-cells bindings
> +		Documentation/devicetree/bindings/nvmem/nvmem.txt and
> +		also examples below.
> +
> +In every OPP node:
> +- opp-microvolt-<name>: Voltage in micro Volts.
> +			At runtime, the platform can pick a <name> and
> +			matching opp-microvolt-<name> property.
> +			[See: opp.txt]
> +			HW:		<name>:
> +			sun50iw-h6	speed0 speed1 speed2

There's a typo here (and in your commit log), it should be sun50i-h6
instead of sun50iw-h6

Once fixed:
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--f3k7wehh6o47a3dc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXLbkCAAKCRDj7w1vZxhR
xciRAP4kXlaqxDV3PBOh9mkYIguav5gdYtZ6PN/1DjyEGj/owgD9ExAFQA/XPHlD
bmo+VqCwf/jtInmFUJPSA71UhPVNgAU=
=MTgp
-----END PGP SIGNATURE-----

--f3k7wehh6o47a3dc--
