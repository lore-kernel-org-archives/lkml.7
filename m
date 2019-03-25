Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9C4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 492262085A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553502479;
	bh=DLAQftoeAA44uUHWiO6SCDfvVfrQ6AyPvtfdh4wv2gM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=K/cnvkPeOkFE4sHfmC7VVuQSnw9gwk9uTKdnlfiYkwPVr6To56L2QFtY5tVbuYOQY
	 oKgi85t9zwwBTVgmwSbX1BGfEexyfX+m6NYO9XRwaD+AOXwHWZgTBHSEi9Sfn3yJbX
	 5fjGO1vyc6pQEdHxxS42ypnUPzKMrLIUJ2B6nfe8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbfCYI15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 04:27:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:33566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729920AbfCYI15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 04:27:57 -0400
Received: from localhost (unknown [171.61.95.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 840212085A;
        Mon, 25 Mar 2019 08:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553502476;
        bh=DLAQftoeAA44uUHWiO6SCDfvVfrQ6AyPvtfdh4wv2gM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CJW3/ndcq3CWyJ1N4PSg+lxm3d8ViVdmrHb+PJ/eb6lraw6LsUznwv3eqljqGgEy7
         fzKNWBO5euYYSXgShrlnI0+FcrlhmWj+xjQHGnKxj4P8a+ks25l7oOqd4gSP4lNkyn
         kc1LhqopEVnWwrJoZ/p6dIWpwb225fAEkQZkMD64=
Date:   Mon, 25 Mar 2019 13:57:50 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: qcs404-evb: Enable uart3 and add
 Bluetooth
Message-ID: <20190325082750.GO5348@vkoul-mobl>
References: <20190305070823.11845-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190305070823.11845-1-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-03-19, 23:08, Bjorn Andersson wrote:
> Enable blsp1_uart3, define its pinconf and add the bluetooth node.
> 
> It seems provisioning is lacking a valid BD address, preventing the
> interface from initializing, so provide a dummy for now.

This looks good though I need to hand edit the patch order a bit when
applied on top of the series I sent..

Reviewed-by: Vinod Koul <vkoul@kernel.org>
Tested-by: Vinod Koul <vkoul@kernel.org>


> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/qcs404-evb.dtsi | 45 ++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> index 536f735243d2..5c502e6db424 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> @@ -7,6 +7,7 @@
>  / {
>  	aliases {
>  		serial0 = &blsp1_uart2;
> +		serial1 = &blsp1_uart3;
>  	};
>  
>  	chosen {
> @@ -19,6 +20,32 @@
>  		regulator-always-on;
>  		regulator-boot-on;
>  	};
> +
> +	vdd_ch0_3p3:
> +	vdd_esmps3_3p3: vdd-esmps3-3p3-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "eSMPS3_3P3";
> +
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +	};
> +};
> +
> +&blsp1_uart3 {
> +	status = "okay";
> +
> +	bluetooth {
> +		compatible = "qcom,wcn3990-bt";
> +		vddio-supply = <&vreg_l6_1p8>;
> +		vddxo-supply = <&vreg_l5_1p8>;
> +		vddrf-supply = <&vreg_l1_1p3>;
> +		vddch0-supply = <&vdd_ch0_3p3>;
> +
> +		local-bd-address = [ 02 00 00 00 5a ad ];
> +
> +		max-speed = <3200000>;
> +	};
>  };
>  
>  &remoteproc_adsp {
> @@ -205,3 +232,21 @@
>  		bias-disable;
>  	};
>  };
> +
> +&blsp1_uart3_default {
> +	cts {
> +		pins = "gpio84";
> +		bias-disable;
> +	};
> +
> +	rts-tx {
> +		pins = "gpio85", "gpio82";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	rx {
> +		pins = "gpio83";
> +		bias-pull-up;
> +	};
> +};
> -- 
> 2.18.0

-- 
~Vinod
