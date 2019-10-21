Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF54CA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75C572084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571653695;
	bh=rBzPRO+ZQr2Ac4LSnoT/X/mZGdMpwM2fGwmupJfj5Dc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AGf/iKHC/PsO0UEBQYbskC/3TrgdYFO2ZA+QlQOW0BM4ISQHESm4ylqCTsaq1GSc8
	 JHsXpyWHkcLnZxP9rw6Xu1qVmZftpJlsHXj+WUoHYOawswQSvDMrIoLF/HTctBzPqU
	 sUXwyxIVPn0KxSzOIHfYCBVX6j6pu7E9PU8mvaKs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbfJUK2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 06:28:14 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40697 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbfJUK2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 06:28:14 -0400
Received: by mail-ed1-f68.google.com with SMTP id p59so1183924edp.7;
        Mon, 21 Oct 2019 03:28:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=32WruUQbRO6vTu7JHKjRq7oaWF4FWya6VgqSM214C+Y=;
        b=GqnWt1oPns4jziHWbWYSrELHjv0uvgJuBFHe5mru+4mPU2kPsAInsQeYCrhdI7l2Kf
         k9QoQTIKTcWUpEoysslohOlW8CrFHpMsNb9bqspFQh2eyxHiV+ElOWS2pKy6wl7wDZUU
         EGDTLyqk/bEZ3yBhItawvQsfUQfqaOM7EulLCF1V6U8ie1yf1AKKuNOSGIxgG5NgcSkW
         U2Qw3JE7gxC70haUpGJNM6rB7JQaa1AyWwy+5Q7Pmh6+Oeju7xbO9BbVuNZfPeqqrQIv
         wNZMX0YBKiMcINRBZbZagw30nWHJAHIr6PfGpH3ymlwX354C9ACCccPGXP12Y/M+g3y/
         83XA==
X-Gm-Message-State: APjAAAW4zqYLlMZDE+rIDURBtbJPySgk6gJTR5Pmeb3lJzbdxJKCreQo
        rMkX1jtmVeS7AP1yna3cxAI=
X-Google-Smtp-Source: APXvYqzhozcd1lqqT8Tpyf3S1ox+0mSMUIdIK4/skr94JIQi3fBFI4Y/wJHBDk8i/MAoWWMpQTVaWA==
X-Received: by 2002:a50:ec0f:: with SMTP id g15mr24166931edr.59.1571653692310;
        Mon, 21 Oct 2019 03:28:12 -0700 (PDT)
Received: from pi3 ([194.230.155.217])
        by smtp.googlemail.com with ESMTPSA id w16sm574836edd.93.2019.10.21.03.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 03:28:11 -0700 (PDT)
Date:   Mon, 21 Oct 2019 12:28:09 +0200
From:   "krzk@kernel.org" <krzk@kernel.org>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/10] ARM: dts: imx6ul-kontron-n6310: Move common SoM
 nodes to a separate file
Message-ID: <20191021102809.GA1934@pi3>
References: <20191016150622.21753-1-frieder.schrempf@kontron.de>
 <20191016150622.21753-2-frieder.schrempf@kontron.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191016150622.21753-2-frieder.schrempf@kontron.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 03:07:19PM +0000, Schrempf Frieder wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> The Kontron N6311 and N6411 SoMs are very similar to N6310. In
> preparation to add support for them, we move the common nodes to a
> separate file imx6ul-kontron-n6x1x-som-common.dtsi.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
>  .../boot/dts/imx6ul-kontron-n6310-som.dtsi    |  95 +-------------
>  .../dts/imx6ul-kontron-n6x1x-som-common.dtsi  | 123 ++++++++++++++++++
>  2 files changed, 124 insertions(+), 94 deletions(-)
>  create mode 100644 arch/arm/boot/dts/imx6ul-kontron-n6x1x-som-common.dtsi
> 
> diff --git a/arch/arm/boot/dts/imx6ul-kontron-n6310-som.dtsi b/arch/arm/boot/dts/imx6ul-kontron-n6310-som.dtsi
> index a896b2348dd2..47d3ce5d255f 100644
> --- a/arch/arm/boot/dts/imx6ul-kontron-n6310-som.dtsi
> +++ b/arch/arm/boot/dts/imx6ul-kontron-n6310-som.dtsi
> @@ -6,7 +6,7 @@
>   */
>  
>  #include "imx6ul.dtsi"
> -#include <dt-bindings/gpio/gpio.h>
> +#include "imx6ul-kontron-n6x1x-som-common.dtsi"
>  
>  / {
>  	model = "Kontron N6310 SOM";
> @@ -18,49 +18,7 @@
>  	};
>  };
>  
> -&ecspi2 {
> -	cs-gpios = <&gpio4 22 GPIO_ACTIVE_HIGH>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_ecspi2>;
> -	status = "okay";
> -
> -	spi-flash@0 {
> -		compatible = "mxicy,mx25v8035f", "jedec,spi-nor";
> -		spi-max-frequency = <50000000>;
> -		reg = <0>;
> -	};
> -};
> -
> -&fec1 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_enet1 &pinctrl_enet1_mdio>;
> -	phy-mode = "rmii";
> -	phy-handle = <&ethphy1>;
> -	status = "okay";
> -
> -	mdio {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		ethphy1: ethernet-phy@1 {
> -			reg = <1>;
> -			micrel,led-mode = <0>;
> -			clocks = <&clks IMX6UL_CLK_ENET_REF>;
> -			clock-names = "rmii-ref";
> -		};
> -	};
> -};
> -
> -&fec2 {
> -	phy-mode = "rmii";
> -	status = "disabled";
> -};
> -
>  &qspi {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_qspi>;
> -	status = "okay";
> -
>  	spi-flash@0 {

You left qspi and flash partitions here, while adding it later. It is
not pure move then and some duplicated stuff remains.

Best regards,
Krzysztof

