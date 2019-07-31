Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2E8C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 07:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 794DD217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 07:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="m3aMCZfI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfGaHOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 03:14:14 -0400
Received: from uho.ysoft.cz ([81.19.3.130]:56498 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfGaHOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 03:14:14 -0400
Received: from [10.1.8.111] (unknown [10.1.8.111])
        by uho.ysoft.cz (Postfix) with ESMTP id 28A1CA5931;
        Wed, 31 Jul 2019 09:14:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1564557252;
        bh=rtatZtXbN7GFHkDU8P+IOkQRQ4um7ZK8IiXYbfc5WeE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=m3aMCZfI4z3bF4vToIjgXPVOvKiFQOzjM/YKOXl53xcSKSDin8DIZTkNldPCPXPJG
         EE0qy8Y/J9v/FNtMvIadvnVMWqfbCXMpEjB+3wf4zgTkyny49Qqo7+7cCOKL/rQoQJ
         lv/c7r3PmgxkOYZcfaq1K3vbsZsxu6gQDBj4Pllg=
Subject: Re: [PATCH 11/22] ARM: dts: imx6: Add sleep state to can interfaces
To:     Philippe Schenker <dev@pschenker.ch>, marcel.ziswiler@toradex.com,
        max.krummenacher@toradex.com, stefan@agner.ch,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Philippe Schenker <philippe.schenker@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
References: <20190730144649.19022-1-dev@pschenker.ch>
 <20190730144649.19022-12-dev@pschenker.ch>
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Message-ID: <86f1e50b-97d6-5bdb-7cc2-e7dc162d147a@ysoft.com>
Date:   Wed, 31 Jul 2019 09:14:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190730144649.19022-12-dev@pschenker.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30. 07. 19 16:46, Philippe Schenker wrote:
> From: Philippe Schenker <philippe.schenker@toradex.com>
> 
> This patch prepares the devicetree for the new Ixora V1.2 where we are
> able to turn off the supply of the can transceiver. This implies to use
> a sleep state on transmission pins in order to prevent backfeeding.
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> ---

What about "ARM: dts: imx6qdl-apalis: " for the subject?
To be clear that this is not related to the imx6 SoC itself.

> 
>   arch/arm/boot/dts/imx6qdl-apalis.dtsi | 27 +++++++++++++++++++++------
>   1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> index 7c4ad541c3f5..59ed2e4a1fd1 100644
> --- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> @@ -148,14 +148,16 @@
>   };
>   
>   &can1 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_flexcan1>;
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&pinctrl_flexcan1_default>;
> +	pinctrl-1 = <&pinctrl_flexcan1_sleep>;
>   	status = "disabled";
>   };
>   
>   &can2 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_flexcan2>;
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&pinctrl_flexcan2_default>;
> +	pinctrl-1 = <&pinctrl_flexcan2_sleep>;
>   	status = "disabled";
>   };
>   
> @@ -599,19 +601,32 @@
>   		>;
>   	};
>   
> -	pinctrl_flexcan1: flexcan1grp {
> +	pinctrl_flexcan1_default: flexcan1defgrp {
>   		fsl,pins = <
>   			MX6QDL_PAD_GPIO_7__FLEXCAN1_TX 0x1b0b0
>   			MX6QDL_PAD_GPIO_8__FLEXCAN1_RX 0x1b0b0
>   		>;
>   	};
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
>   		fsl,pins = <
>   			MX6QDL_PAD_KEY_COL4__FLEXCAN2_TX 0x1b0b0
>   			MX6QDL_PAD_KEY_ROW4__FLEXCAN2_RX 0x1b0b0
>   		>;
>   	};
> +	pinctrl_flexcan2_sleep: flexcan2slpgrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_KEY_COL4__GPIO4_IO14 0x0
> +			MX6QDL_PAD_KEY_ROW4__GPIO4_IO15 0x0
> +		>;
> +	};
>   
>   	pinctrl_gpio_bl_on: gpioblon {
>   		fsl,pins = <
> 

