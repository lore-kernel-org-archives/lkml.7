Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DC0C3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D28420989
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566214090;
	bh=2eCWogtyvjtgXycwn80iAAqkLyoGmWRMPImaEfrwOnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Yeu4zd3Fak8wVEE+cS/CBqxFsKJ/TUS5F+Qz5pfa/Ewb5SJ3ArZeb+JIi+FNOC8tU
	 F6ZxQD2KQJo8jcifNwpps50wqEn0k8biIX/wGGSw5Ol6O2450Tzox3Yi/ErbKdd7GA
	 mxTWCCbMIJ6AH85bP2arJVxKKGdkoZcwq/LkUqZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbfHSL2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 07:28:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:36900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727584AbfHSL2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 07:28:08 -0400
Received: from X250 (37.80-203-192.nextgentel.com [80.203.192.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32BA320851;
        Mon, 19 Aug 2019 11:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566214087;
        bh=2eCWogtyvjtgXycwn80iAAqkLyoGmWRMPImaEfrwOnk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yE2pVYkfMReaD9Zs7Yh3YsDcK89YDq2o3CQ11Vnj07BvPLBhPwvzmSM82BSxdYfQQ
         wfWJry5lVUOsaBtcplTxrEAP44nl5jBNfxk7M9+mEKh2UNYdPUG31j/VdzIntKNdGn
         yHJPBEbHM66PCg9z3nFPayRINtIvBToHQIDWepfY=
Date:   Mon, 19 Aug 2019 13:27:55 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Philippe Schenker <philippe.schenker@toradex.com>
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>,
        Fabio Estevam <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v4 11/21] ARM: dts: imx6qdl-apalis: Add sleep state to
 can interfaces
Message-ID: <20190819112754.GU5999@X250>
References: <20190812142105.1995-1-philippe.schenker@toradex.com>
 <20190812142105.1995-12-philippe.schenker@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812142105.1995-12-philippe.schenker@toradex.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 02:21:31PM +0000, Philippe Schenker wrote:
> This patch prepares the devicetree for the new Ixora V1.2 where we are
> able to turn off the supply of the can transceiver. This implies to use
> a sleep state on transmission pins in order to prevent backfeeding.
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> Acked-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
> Changes in v4:
> - Add Marcel Ziswiler's Ack
> 
> Changes in v3: None
> Changes in v2:
> - Changed commit title to '...imx6qdl-apalis:...'
> 
>  arch/arm/boot/dts/imx6qdl-apalis.dtsi | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> index 7c4ad541c3f5..59ed2e4a1fd1 100644
> --- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> @@ -148,14 +148,16 @@
>  };
>  
>  &can1 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_flexcan1>;

This line doesn't need to be changed.

> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&pinctrl_flexcan1_default>;
> +	pinctrl-1 = <&pinctrl_flexcan1_sleep>;
>  	status = "disabled";
>  };
>  
>  &can2 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_flexcan2>;
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&pinctrl_flexcan2_default>;
> +	pinctrl-1 = <&pinctrl_flexcan2_sleep>;
>  	status = "disabled";
>  };
>  
> @@ -599,19 +601,32 @@
>  		>;
>  	};
>  
> -	pinctrl_flexcan1: flexcan1grp {

Ditto.  I take them as unnecessary changes.

Shawn

> +	pinctrl_flexcan1_default: flexcan1defgrp {
>  		fsl,pins = <
>  			MX6QDL_PAD_GPIO_7__FLEXCAN1_TX 0x1b0b0
>  			MX6QDL_PAD_GPIO_8__FLEXCAN1_RX 0x1b0b0
>  		>;
>  	};
>  
> -	pinctrl_flexcan2: flexcan2grp {
> +	pinctrl_flexcan1_sleep: flexcan1slpgrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_GPIO_7__GPIO1_IO07 0x0
> +			MX6QDL_PAD_GPIO_8__GPIO1_IO08 0x0
> +		>;
> +	};
> +
> +	pinctrl_flexcan2_default: flexcan2defgrp {
>  		fsl,pins = <
>  			MX6QDL_PAD_KEY_COL4__FLEXCAN2_TX 0x1b0b0
>  			MX6QDL_PAD_KEY_ROW4__FLEXCAN2_RX 0x1b0b0
>  		>;
>  	};
> +	pinctrl_flexcan2_sleep: flexcan2slpgrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_KEY_COL4__GPIO4_IO14 0x0
> +			MX6QDL_PAD_KEY_ROW4__GPIO4_IO15 0x0
> +		>;
> +	};
>  
>  	pinctrl_gpio_bl_on: gpioblon {
>  		fsl,pins = <
> -- 
> 2.22.0
> 
