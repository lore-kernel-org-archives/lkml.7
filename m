Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53BDCA9ED2
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 07:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB32222C5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 07:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572852741;
	bh=ayt9FfBU8eNkEx5C3qhg37/hdrYd8vuX/qA86acnJEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PEDgp+YYfCOVtaSmzTQFBgaQYN0KC+3sMiTBMHLDXDbkASZGFi6Ne/Bux2JJEoH9b
	 slgirG8ggtdDbRXKcqmp1eiBq+KgdS4bdiZIkHm4VrjsMzVrMgH8UR0OdhAvgIkG2f
	 zHpe2Jhex6WKvpUSgmYq+Jn0sRiAIxcV4Y/xVaDU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbfKDHcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 02:32:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:48086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbfKDHcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 02:32:19 -0500
Received: from dragon (li1038-30.members.linode.com [45.33.96.30])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71AF921D71;
        Mon,  4 Nov 2019 07:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572852739;
        bh=ayt9FfBU8eNkEx5C3qhg37/hdrYd8vuX/qA86acnJEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qBRB+4+APc0noomEvQDynpelje9OGoU7byUlVPN4D+hQzQpZXc6oazAa/k9SPeEI7
         pmIEyo0tIqwhISJFM7cXzYG9fKwiA+Uaz0EYzxx/ZYyop1sYctwox9UkCY30ViAtuT
         7uwCslD8QDSZEkEeLhi4LveQiDczfFyR/J59qWTE=
Date:   Mon, 4 Nov 2019 15:31:52 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 07/11] ARM: dts: imx6ul-kontron-n6x1x-s: Add
 vbus-supply and overcurrent polarity to usb nodes
Message-ID: <20191104073151.GR24620@dragon>
References: <20191031142112.12431-1-frieder.schrempf@kontron.de>
 <20191031142112.12431-8-frieder.schrempf@kontron.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031142112.12431-8-frieder.schrempf@kontron.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 02:24:21PM +0000, Schrempf Frieder wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> To silence the warnings shown by the driver at boot time, we add a
> fixed regulator for the 5V supply of usbotg2 and specify the polarity
> of the overcurrent signal for usbotg1.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Fixes: 1ea4b76cdfde ("ARM: dts: imx6ul-kontron-n6310: Add Kontron i.MX6UL N6310 SoM and boards")

I do not think it's a bug fix, so the Fixes tag doesn't really apply.

Shawn

> ---
>  arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi b/arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi
> index 2299cad900af..d3eb21aa9014 100644
> --- a/arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi
> +++ b/arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi
> @@ -45,6 +45,13 @@
>  		regulator-max-microvolt = <3300000>;
>  	};
>  
> +	reg_5v: regulator-5v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "5v";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +	};
> +
>  	reg_usb_otg1_vbus: regulator-usb-otg1-vbus {
>  		compatible = "regulator-fixed";
>  		regulator-name = "usb_otg1_vbus";
> @@ -191,6 +198,7 @@
>  	srp-disable;
>  	hnp-disable;
>  	adp-disable;
> +	over-current-active-low;
>  	vbus-supply = <&reg_usb_otg1_vbus>;
>  	status = "okay";
>  };
> @@ -198,6 +206,7 @@
>  &usbotg2 {
>  	dr_mode = "host";
>  	disable-over-current;
> +	vbus-supply = <&reg_5v>;
>  	status = "okay";
>  };
>  
> -- 
> 2.17.1
