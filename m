Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3329C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77DFB218A5
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="nHY7Db9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfGCNAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 09:00:48 -0400
Received: from node.akkea.ca ([192.155.83.177]:57972 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbfGCNAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 09:00:47 -0400
Received: by node.akkea.ca (Postfix, from userid 33)
        id BC92D4E204B; Wed,  3 Jul 2019 13:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1562158846; bh=jfEnQz6Z7lDitZDfZEU5tHLgi5WtCywGyso2NpbD6yM=;
        h=To:Subject:Date:From:Cc:In-Reply-To:References;
        b=nHY7Db9TTbezNC91mUbwu6U9bjG3WAnn/Vj2i/HuvYVxqG55+k/M/yHfQaRKCevGh
         3gFNdY/MIMR/QthhXFfVDa7O2uYz6nSZ3Iz73qCjR3tpEJR21kbtwmGf4EUHZylfde
         blLDPH5clasanypevgikazHmk+IrIti1LuSXTjuE=
To:     Andra Danciu <andradanciu1997@gmail.com>
Subject: Re: [PATCH v3] arm64: dts: imx8mq: Add sai3 and sai6 nodes
X-PHP-Originating-Script: 1000:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 03 Jul 2019 07:00:46 -0600
From:   Angus Ainslie <angus@akkea.ca>
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, l.stach@pengutronix.de, abel.vesa@nxp.com,
        Anson.Huang@nxp.com, andrew.smirnov@gmail.com,
        ccaione@baylibre.com, agx@sigxcpu.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20190702132353.18632-1-andradanciu1997@gmail.com>
References: <20190702132353.18632-1-andradanciu1997@gmail.com>
Message-ID: <9ea5109f8645c3f27a9e350c5f9b2d4c@www.akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.1.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andra,

I tried this out on linux-next and I'm not able to record or play sound.

I also added the sai2 entry to test out our devkit and get a PCM timeout 
with that.

On 2019-07-02 07:23, Andra Danciu wrote:
> SAI3 and SAI6 nodes are used to connect to an external codec.
> They have 1 Tx and 1 Rx dataline.
> 
> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
> ---
> Changes since v2:
> 	- removed multiple new lines
> 
> Changes since v1:
> 	- Added sai3 node because we need it to enable audio on pico-pi-8m
> 	- Added commit description
> 
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 29 
> +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index d09b808eff87..736cf81b695e 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -278,6 +278,20 @@
>  			#size-cells = <1>;
>  			ranges = <0x30000000 0x30000000 0x400000>;
> 
> +			sai6: sai@30030000 {
> +				compatible = "fsl,imx8mq-sai",

I don't find this compatible string in sound/soc/fsl/fsl_sai.c. Aren't 
the registers at a different offset from "fsl,imx6sx-sai".

How is this supposed to work ?

Thanks
Angus

> +					"fsl,imx6sx-sai";
> +				reg = <0x30030000 0x10000>;
> +				interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX8MQ_CLK_SAI6_IPG>,
> +					<&clk IMX8MQ_CLK_SAI6_ROOT>,
> +					<&clk IMX8MQ_CLK_DUMMY>, <&clk IMX8MQ_CLK_DUMMY>;
> +				clock-names = "bus", "mclk1", "mclk2", "mclk3";
> +				dmas = <&sdma2 4 24 0>, <&sdma2 5 24 0>;
> +				dma-names = "rx", "tx";
> +				status = "disabled";
> +			};
> +
>  			gpio1: gpio@30200000 {
>  				compatible = "fsl,imx8mq-gpio", "fsl,imx35-gpio";
>  				reg = <0x30200000 0x10000>;
> @@ -728,6 +742,21 @@
>  				status = "disabled";
>  			};
> 
> +			sai3: sai@308c0000 {
> +				compatible = "fsl,imx8mq-sai",
> +					     "fsl,imx6sx-sai";
> +				reg = <0x308c0000 0x10000>;
> +				interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX8MQ_CLK_SAI3_IPG>,
> +					<&clk IMX8MQ_CLK_DUMMY>,
> +					<&clk IMX8MQ_CLK_SAI3_ROOT>,
> +					<&clk IMX8MQ_CLK_DUMMY>, <&clk IMX8MQ_CLK_DUMMY>;
> +				clock-names = "bus", "mclk1", "mclk2", "mclk3";
> +				dmas = <&sdma1 12 24 0>, <&sdma1 13 24 0>;
> +				dma-names = "rx", "tx";
> +				status = "disabled";
> +			};
> +
>  			i2c1: i2c@30a20000 {
>  				compatible = "fsl,imx8mq-i2c", "fsl,imx21-i2c";
>  				reg = <0x30a20000 0x10000>;

