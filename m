Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446A6C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 21:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11AC120866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 21:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfFEVLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 17:11:18 -0400
Received: from gloria.sntech.de ([185.11.138.130]:60832 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbfFEVLS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 17:11:18 -0400
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hYdBh-0000gP-2F; Wed, 05 Jun 2019 23:11:13 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 2/2] ARM: dts: rockchip: Configure BT_HOST_WAKE as wake-up signal on veyron
Date:   Wed, 05 Jun 2019 23:11:12 +0200
Message-ID: <3079472.D8Re4Zsj2W@diego>
In-Reply-To: <20190605204320.22343-2-mka@chromium.org>
References: <20190605204320.22343-1-mka@chromium.org> <20190605204320.22343-2-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 5. Juni 2019, 22:43:20 CEST schrieb Matthias Kaehlcke:
> This enables wake up on Bluetooth activity when the device is
> suspended. The BT_HOST_WAKE signal is only connected on devices
> with BT module that are connected through UART.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Housekeeping question, with the two Signed-off-by lines, is Doug the
original author, or was this Co-developer-by?

Heiko

> ---
>  arch/arm/boot/dts/rk3288-veyron.dtsi | 29 ++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
> index cc4c3595f145..145cac7c0847 100644
> --- a/arch/arm/boot/dts/rk3288-veyron.dtsi
> +++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
> @@ -23,6 +23,31 @@
>  		reg = <0x0 0x0 0x0 0x80000000>;
>  	};
>  
> +	bt_activity: bt-activity {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&bt_host_wake>;
> +
> +		/*
> +		 * HACK: until we have an LPM driver, we'll use an
> +		 * ugly GPIO key to allow Bluetooth to wake from S3.
> +		 * This is expected to only be used by BT modules that
> +		 * use UART for comms.  For BT modules that talk over
> +		 * SDIO we should use a wakeup mechanism related to SDIO.
> +		 *
> +		 * Use KEY_RESERVED here since that will work as a wakeup but
> +		 * doesn't get reported to higher levels (so doesn't confuse
> +		 * Chrome).
> +		 */
> +		bt-wake {
> +			label = "BT Wakeup";
> +			gpios = <&gpio4 RK_PD7 GPIO_ACTIVE_HIGH>;
> +			linux,code = <KEY_RESERVED>;
> +			wakeup-source;
> +		};
> +
> +	};
> +
>  	power_button: power-button {
>  		compatible = "gpio-keys";
>  		pinctrl-names = "default";
> @@ -555,6 +580,10 @@
>  			rockchip,pins = <4 RK_PD5 RK_FUNC_GPIO &pcfg_pull_none>;
>  		};
>  
> +		bt_host_wake: bt-host-wake {
> +			rockchip,pins = <4 31 RK_FUNC_GPIO &pcfg_pull_down>;
> +		};
> +
>  		/*
>  		 * We run sdio0 at max speed; bump up drive strength.
>  		 * We also have external pulls, so disable the internal ones.
> 




