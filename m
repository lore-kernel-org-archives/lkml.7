Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2888AC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC599206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="N6xlQNtK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbfDDMnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 08:43:24 -0400
Received: from vps.xff.cz ([195.181.215.36]:52584 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728858AbfDDMnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 08:43:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1554381802; bh=9WIXEApug09An5XJwX8DDMYtH2Xh13PrrTgcg1AzzTo=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=N6xlQNtKmt9qTo3zexMCyoIByyOaXW8650s+HfIEX3+TFpkp7JHa1rQ1qXEzM5oZG
         4HbaaCh/YVtUReLNrxIFtRl4MJ4VJrj6Pupe6qKxKnunA3AWPaZA70Ojj+w9QVlQWl
         7Pqxe9rvrHnqjP7jaAJYAyXtNAYqB6Ovvf7zY3I0=
Date:   Thu, 4 Apr 2019 14:43:22 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     maxime.ripard@free-electrons.com, wens@csie.org, robh@kernel.org,
        johan@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [linux-sunxi] [PATCH v2 5/5] ARM: dts: sun8i: tbs-a711: Enable
 UART2 (for NEO-6M GPS module)
Message-ID: <20190404124322.aejij7qomgoco37u@core.my.home>
Mail-Followup-To: maxime.ripard@free-electrons.com, wens@csie.org,
        robh@kernel.org, johan@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
References: <20190401115616.21337-1-megous@megous.com>
 <20190401115616.21337-6-megous@megous.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401115616.21337-6-megous@megous.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Maxime,

On Mon, Apr 01, 2019 at 01:56:16PM +0200, megous via linux-sunxi wrote:
> From: Ondrej Jirman <megous@megous.com>
> 
> TBS A711 tablet contains u-blox NEO-6M module connected to UART2.
> Enable UART2 to gain access to the module from userspace.

Other GPS bits are now applied (thank you, Johan), so if this last bit
can go in too via a sunxi tree, the series will be complete.

thank you,
  Ondrej

> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
>  arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
> index d70fe04b66f0..fd170bc45927 100644
> --- a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
> +++ b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
> @@ -98,6 +98,13 @@
>  		};
>  	};
>  
> +	reg_gps: reg-gps {
> +		compatible = "regulator-fixed";
> +		regulator-name = "gps";
> +		regulator-min-microvolt = <3000000>;
> +		regulator-max-microvolt = <3000000>;
> +	};
> +
>  	reg_vbat: reg-vbat {
>  		compatible = "regulator-fixed";
>  		regulator-name = "vbat";
> @@ -422,6 +429,20 @@
>  	status = "okay";
>  };
>  
> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart2_pb_pins>;
> +	status = "okay";
> +
> +	gnss {
> +		compatible = "u-blox,neo-6m";
> +
> +		v-bckp-supply = <&reg_rtc_ldo>;
> +		vcc-supply = <&reg_gps>;
> +		current-speed = <9600>;
> +	};
> +};
> +
>  &usb_otg {
>  	dr_mode = "otg";
>  	status = "okay";
> -- 
> 2.21.0
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
