Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EA9C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 09:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 794F7204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 09:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="Evk8Nfi6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfEGJma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 05:42:30 -0400
Received: from vps.xff.cz ([195.181.215.36]:60136 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbfEGJma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 05:42:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1557222148; bh=HNGqc9MQ013hhLsc6YHpLa3A/Ih8rm2RzSpPVk2ARgM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Evk8Nfi65VGg1TR1WSZioWa7+ZnXS6P+BdJZkVu+ZyhtKbWT6P5hzjiq00m8iHPah
         3ZW1/OCFsNS7kb98114vph9sDXxEiBIdRt9f7u204tMR6e5muSo+fxqIjAJdOAOqL4
         bnwl/Lz0zX5BesMKq0XDjhpXlWxz9yTLM14TJy00=
Date:   Tue, 7 May 2019 11:42:27 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: allwinner: h6: Enable HDMI output on
 orangepi 3
Message-ID: <20190507094227.3kokzszqz74mq5k2@core.my.home>
Mail-Followup-To: Yangtao Li <tiny.windzz@gmail.com>,
        maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190420145240.27400-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190420145240.27400-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yangtao,

On Sat, Apr 20, 2019 at 10:52:40AM -0400, Yangtao Li wrote:
> Orangepi 3 has HDMI type A connector.

It also has DDC-IO-EN, whithout which HDMI will not work as expected
by most users.

I'm working on a proper solution (discussion here):

  https://lkml.org/lkml/2019/4/26/910

regards,
	o.

> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
> rebase:
> sunxi/dt64-for-5.2 arm64: dts: allwinner: a64-amarula-relic: Add OV5640
> camera node
> ---
>  .../dts/allwinner/sun50i-h6-orangepi-3.dts    | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
> index 17d496990108..6ed3a1ee297d 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
> @@ -21,6 +21,17 @@
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> +	connector {
> +		compatible = "hdmi-connector";
> +		type = "a";
> +
> +		port {
> +			hdmi_con_in: endpoint {
> +				remote-endpoint = <&hdmi_out_con>;
> +			};
> +		};
> +	};
> +
>  	leds {
>  		compatible = "gpio-leds";
>  
> @@ -50,6 +61,10 @@
>  	cpu-supply = <&reg_dcdca>;
>  };
>  
> +&de {
> +	status = "okay";
> +};
> +
>  &ehci0 {
>  	status = "okay";
>  };
> @@ -58,6 +73,16 @@
>  	status = "okay";
>  };
>  
> +&hdmi {
> +	status = "okay";
> +};
> +
> +&hdmi_out {
> +	hdmi_out_con: endpoint {
> +		remote-endpoint = <&hdmi_con_in>;
> +	};
> +};
> +
>  &mmc0 {
>  	vmmc-supply = <&reg_cldo1>;
>  	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
> -- 
> 2.17.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
