Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41A7C3A5A6
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B534820828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbfH0Okv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 10:40:51 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:60511 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfH0Okv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 10:40:51 -0400
Received: from localhost (aclermont-ferrand-651-1-259-53.w86-207.abo.wanadoo.fr [86.207.98.53])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 15D4F100013;
        Tue, 27 Aug 2019 14:40:47 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH v7 6/6] arm64: dts: marvell: Add cpu clock node on Armada 7K/8K
In-Reply-To: <20190710134346.30239-7-gregory.clement@bootlin.com>
References: <20190710134346.30239-1-gregory.clement@bootlin.com> <20190710134346.30239-7-gregory.clement@bootlin.com>
Date:   Tue, 27 Aug 2019 16:40:47 +0200
Message-ID: <87ftlmzn68.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Add cpu clock node on AP
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Applied on mvebu/dt64

Gregory
> ---
>  arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi | 4 ++++
>  arch/arm64/boot/dts/marvell/armada-ap806.dtsi      | 7 +++++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi
> index 2baafe12ebd4..472211159979 100644
> --- a/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi
> @@ -20,24 +20,28 @@
>  			compatible = "arm,cortex-a72";
>  			reg = <0x000>;
>  			enable-method = "psci";
> +			clocks = <&cpu_clk 0>;
>  		};
>  		cpu1: cpu@1 {
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a72";
>  			reg = <0x001>;
>  			enable-method = "psci";
> +			clocks = <&cpu_clk 0>;
>  		};
>  		cpu2: cpu@100 {
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a72";
>  			reg = <0x100>;
>  			enable-method = "psci";
> +			clocks = <&cpu_clk 1>;
>  		};
>  		cpu3: cpu@101 {
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a72";
>  			reg = <0x101>;
>  			enable-method = "psci";
> +			clocks = <&cpu_clk 1>;
>  		};
>  	};
>  };
> diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> index 91dad7e4ee59..fca6536494b3 100644
> --- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> @@ -280,6 +280,13 @@
>  				#address-cells = <1>;
>  				#size-cells = <1>;
>  
> +				cpu_clk: clock-cpu@278 {
> +					compatible = "marvell,ap806-cpu-clock";
> +					clocks = <&ap_clk 0>, <&ap_clk 1>;
> +					#clock-cells = <1>;
> +					reg = <0x278 0xa30>;
> +				};
> +
>  				ap_thermal: thermal-sensor@80 {
>  					compatible = "marvell,armada-ap806-thermal";
>  					reg = <0x80 0x10>;
> -- 
> 2.20.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
