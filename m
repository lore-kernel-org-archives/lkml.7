Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74027C33C99
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 21:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51C1C24650
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 21:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgADVXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 16:23:12 -0500
Received: from gloria.sntech.de ([185.11.138.130]:56090 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbgADVXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 16:23:12 -0500
Received: from p508fd2bb.dip0.t-ipconnect.de ([80.143.210.187] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1inqsy-00048F-1e; Sat, 04 Jan 2020 22:23:04 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Markus Reichl <m.reichl@fivetechno.de>
Cc:     linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] arm64: dts: rockchip: Enable mp8859 regulator on rk3399-roc-pc
Date:   Sat, 04 Jan 2020 22:23:03 +0100
Message-ID: <11639547.aalzkRAYeW@phil>
In-Reply-To: <20200104153321.6584-6-m.reichl@fivetechno.de>
References: <20200104153321.6584-1-m.reichl@fivetechno.de> <20200104153321.6584-6-m.reichl@fivetechno.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus,

Am Samstag, 4. Januar 2020, 16:32:49 CET schrieb Markus Reichl:
> The rk3399-roc-pc uses a MP8859 DC/DC converter for 12V supply.
> This supplies 5V only in default state after booting.

Just for my understanding ... both the old static regulator before as
well as the new i2c node said to supply 12V, but above you say that
the default is 5V ... so I'm wondering who configured the 12V before.

Or was it the case that the old regulator node was just wrong and we
had 5V running on the dc_12v line?

Thanks
Heiko

> Now we can control the output voltage via I2C interface.
> Add a node for the driver to reach 12V.
> 
> Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>
> ---
>  .../boot/dts/rockchip/rk3399-roc-pc.dtsi      | 32 +++++++++++--------
>  1 file changed, 18 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
> index 8e01b04144b7..9f225e9c3d54 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
> @@ -110,20 +110,6 @@ vcc_vbus_typec0: vcc-vbus-typec0 {
>  		regulator-max-microvolt = <5000000>;
>  	};
>  
> -	/*
> -	 * should be placed inside mp8859, but not until mp8859 has
> -	 * its own dt-binding.
> -	 */
> -	dc_12v: mp8859-dcdc1 {
> -		compatible = "regulator-fixed";
> -		regulator-name = "dc_12v";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <12000000>;
> -		regulator-max-microvolt = <12000000>;
> -		vin-supply = <&vcc_vbus_typec0>;
> -	};
> -
>  	/* switched by pmic_sleep */
>  	vcc1v8_s3: vcca1v8_s3: vcc1v8-s3 {
>  		compatible = "regulator-fixed";
> @@ -546,6 +532,24 @@ fusb0: usb-typec@22 {
>  		vbus-supply = <&vcc_vbus_typec0>;
>  		status = "okay";
>  	};
> +
> +	mp8859: regulator@66 {
> +		compatible = "mps,mp8859";
> +		reg = <0x66>;
> +		dc_12v: mp8859_dcdc {
> +			regulator-name = "dc_12v";
> +			regulator-min-microvolt = <12000000>;
> +			regulator-max-microvolt = <12000000>;
> +			regulator-always-on;
> +			regulator-boot-on;
> +			vin-supply = <&vcc_vbus_typec0>;
> +
> +			regulator-state-mem {
> +				regulator-on-in-suspend;
> +				regulator-suspend-microvolt = <12000000>;
> +			};
> +		};
> +	};
>  };
>  
>  &i2s0 {
> 




