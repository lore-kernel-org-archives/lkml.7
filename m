Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2518CC3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA2E72087B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566213544;
	bh=wUOaCEaWH+zGwPwJEP4cQs1+4O414saVr5gYOrQZAfY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I+cjfDKYTVR9soAIPh9qa7B8xG+qC4bEghh7PecKQy3fANAOIk4sXPLpzQ/qatjNZ
	 Whg+4YkN3TEMttFVtksm6VkolgdnoiYvxIayd9IchSsYAmNkXGz5x5i1PXMSzyLjJ+
	 5dzYmbJxXCszeSVv9rVxePsZFM06Nexkmhnp2lnE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfHSLTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 07:19:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:33500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbfHSLTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 07:19:02 -0400
Received: from X250 (37.80-203-192.nextgentel.com [80.203.192.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC9F42085A;
        Mon, 19 Aug 2019 11:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566213541;
        bh=wUOaCEaWH+zGwPwJEP4cQs1+4O414saVr5gYOrQZAfY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DmQrUeLXoNKvO5IHeTW93qHddpzI3CploHgntA27j1EmqglqU89plun/se6FkVdhZ
         By2Fc3Fi1Ikpw6Ms5sSgpdpgJIbzDXCY7mFQUj3ZTfIx0FFWMyEmt90V5pQT6LHQ2A
         oxx5y4i8eocRaYyhM1YcTL0HnBTqZDzfUtuvgdPU=
Date:   Mon, 19 Aug 2019 13:18:48 +0200
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
        Stefan Agner <stefan.agner@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v4 07/21] ARM: dts: imx7-colibri: fix 1.8V/UHS support
Message-ID: <20190819111847.GQ5999@X250>
References: <20190812142105.1995-1-philippe.schenker@toradex.com>
 <20190812142105.1995-8-philippe.schenker@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812142105.1995-8-philippe.schenker@toradex.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 02:21:25PM +0000, Philippe Schenker wrote:
> From: Stefan Agner <stefan.agner@toradex.com>
> 
> Add pinmuxing and do not specify voltage restrictions for the usdhc
> instance available on the modules edge connector. This allows to use
> SD-cards with higher transfer modes if supported by the carrier board.
> 
> Signed-off-by: Stefan Agner <stefan.agner@toradex.com>
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> Acked-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
> Changes in v4:
> - Add Marcel Ziswiler's Ack
> 
> Changes in v3:
> - Add new commit message from Stefan's proposal on ML
> 
> Changes in v2: None
> 
>  arch/arm/boot/dts/imx7-colibri.dtsi | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
> index 5347ed38acb2..c563bb821b5e 100644
> --- a/arch/arm/boot/dts/imx7-colibri.dtsi
> +++ b/arch/arm/boot/dts/imx7-colibri.dtsi
> @@ -326,7 +326,6 @@
>  &usdhc1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_usdhc1 &pinctrl_cd_usdhc1>;
> -	no-1-8-v;
>  	cd-gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;
>  	disable-wp;
>  	vqmmc-supply = <&reg_LDO2>;
> @@ -671,6 +670,28 @@
>  		>;
>  	};
>  
> +	pinctrl_usdhc1_100mhz: usdhc1grp_100mhz {
> +		fsl,pins = <
> +			MX7D_PAD_SD1_CMD__SD1_CMD	0x5a
> +			MX7D_PAD_SD1_CLK__SD1_CLK	0x1a
> +			MX7D_PAD_SD1_DATA0__SD1_DATA0	0x5a
> +			MX7D_PAD_SD1_DATA1__SD1_DATA1	0x5a
> +			MX7D_PAD_SD1_DATA2__SD1_DATA2	0x5a
> +			MX7D_PAD_SD1_DATA3__SD1_DATA3	0x5a
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_200mhz: usdhc1grp_200mhz {

No reference to them from usdhc1 node?

Shawn

> +		fsl,pins = <
> +			MX7D_PAD_SD1_CMD__SD1_CMD	0x5b
> +			MX7D_PAD_SD1_CLK__SD1_CLK	0x1b
> +			MX7D_PAD_SD1_DATA0__SD1_DATA0	0x5b
> +			MX7D_PAD_SD1_DATA1__SD1_DATA1	0x5b
> +			MX7D_PAD_SD1_DATA2__SD1_DATA2	0x5b
> +			MX7D_PAD_SD1_DATA3__SD1_DATA3	0x5b
> +		>;
> +	};
> +
>  	pinctrl_usdhc3: usdhc3grp {
>  		fsl,pins = <
>  			MX7D_PAD_SD3_CMD__SD3_CMD		0x59
> -- 
> 2.22.0
> 
