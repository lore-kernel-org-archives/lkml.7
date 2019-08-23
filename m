Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CACC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87934233FE
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566554893;
	bh=Crf5MDMj/lbQANBrYTEedXUjRJ1Lg0gXyJkpryyhpFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SK2A5iAIwRyBqYh6aM93iRPR+srGSIrt6PzoD2wmzG40L5S8rmaEkIzmyGZ8ycTBV
	 RaBuJfh0AqEetLtVrgJuheHVNbHz+H2SqdqFHh0B90wbIWPuiVpWHtuaCVXXEyX34i
	 gRzlaZs5PlMvjYlxwW1hnk20wmk+GLboI87Pdo8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403949AbfHWKIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 06:08:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:44900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403911AbfHWKIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:08:11 -0400
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 930E2233FD;
        Fri, 23 Aug 2019 10:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566554890;
        bh=Crf5MDMj/lbQANBrYTEedXUjRJ1Lg0gXyJkpryyhpFA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2I9aABEKFe19P/u13VQXXoUe/QJfkyZhnE0fm2bEYfevqJkdBCeLFRhuL9BGhTqm9
         9b22xeAubdeOR3pRDInaRFfTkcxdZ8PwA+INjNhzq3Q9XM97koWPu16tcri5SeaQ3o
         1/OE/G1oAP9zb5aK6WuNSUUQXiGCCu+BxkVjsYOQ=
Date:   Fri, 23 Aug 2019 12:08:07 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     megous@megous.com
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: allwinner: orange-pi-3: Enable WiFi
Message-ID: <20190823100807.22heh2gahi7owo4e@flea>
References: <20190823094228.6540-1-megous@megous.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sx4erx44vln7kzi7"
Content-Disposition: inline
In-Reply-To: <20190823094228.6540-1-megous@megous.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sx4erx44vln7kzi7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Fri, Aug 23, 2019 at 11:42:28AM +0200, megous@megous.com wrote:
> From: Ondrej Jirman <megous@megous.com>
>
> Orange Pi 3 has AP6256 WiFi/BT module. WiFi part of the module is called
> bcm43356 and can be used with the brcmfmac driver. The module is powered by
> the two always on regulators (not AXP805).
>
> WiFi uses a PG port with 1.8V voltage level signals. SoC needs to be
> configured so that it sets up an 1.8V input bias on this port. This is done
> by the pio driver by reading the vcc-pg-supply voltage.
>
> You'll need a fw_bcm43456c5_ag.bin firmware file and nvram.txt
> configuration that can be found in the Xulongs's repository for H6:
>
> https://github.com/orangepi-xunlong/OrangePiH6_external/tree/master/ap6256
>
> Mainline brcmfmac driver expects the firmware and nvram at the following
> paths relative to the firmware directory:
>
>   brcm/brcmfmac43456-sdio.bin
>   brcm/brcmfmac43456-sdio.txt
>
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
>
> Since RTC patches for H6 were merged, this can now go in too, if it looks ok.
>
> Other patches for this WiFi chip support were merged in previous cycles,
> so this just needs enabling in DTS now.
>
> Sorry for the links in the commit log, but this information is useful,
> even if the link itself goes bad. Any pointer what to google for
> (file names, tree name) is great for anyone searching in the future.

I understand, but this should (also?) be in the wiki. Please add it
there too.

> Please take a look.
>
> Thank you,
> 	Ondrej
>
>  .../dts/allwinner/sun50i-h6-orangepi-3.dts    | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
> index eda9d5f640b9..49d954369087 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
> @@ -56,6 +56,34 @@
>  		regulator-max-microvolt = <5000000>;
>  		regulator-always-on;
>  	};
> +
> +	reg_vcc33_wifi: vcc33-wifi {
> +		/* Always on 3.3V regulator for WiFi and BT */
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc33-wifi";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +		vin-supply = <&reg_vcc5v>;
> +	};
> +
> +	reg_vcc_wifi_io: vcc-wifi-io {
> +		/* Always on 1.8V/300mA regulator for WiFi and BT IO */
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc-wifi-io";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-always-on;
> +		vin-supply = <&reg_vcc33_wifi>;
> +	};
> +
> +	wifi_pwrseq: wifi_pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		clocks = <&rtc 1>;
> +		clock-names = "ext_clock";
> +		reset-gpios = <&r_pio 1 3 GPIO_ACTIVE_LOW>; /* PM3 */
> +		post-power-on-delay-ms = <200>;
> +	};
>  };
>
>  &cpu0 {
> @@ -91,6 +119,25 @@
>  	status = "okay";
>  };
>
> +&mmc1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc1_pins>;

This is the default already. I've removed it and applied.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--sx4erx44vln7kzi7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXV+7BwAKCRDj7w1vZxhR
xdUoAP9lf+bDRTFhwEM+MuhxjkNWf8b3rdWTvPeIslZaYzUokAD+O9BdXFqXhK6Q
TawAIlkWp7SHKOU0NdRWhmLzQZyaJwM=
=YyL0
-----END PGP SIGNATURE-----

--sx4erx44vln7kzi7--
