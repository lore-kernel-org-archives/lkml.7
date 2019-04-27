Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B042C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 08:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D09208CA
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 08:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556353177;
	bh=F+SqDYoYNfTHf5ZQmfhStkeI3byBSsnmee6PqdO0LLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NyCSCmXRQRFObKz5+zcYD026EpAKcbkEm08erdglpNkQ126dz/T466EVMberMwEM9
	 q4tFqtQjUl5DqDnwtvX/9qTooLBajBWEwNxC1HDg0omIHOxQaBAPwgitonhPuopAYA
	 EyLQV7b06pHfKwDbc5SrzLoXuBv5GPC19eJFJiRg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbfD0ITf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 04:19:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:42476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbfD0ITf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 04:19:35 -0400
Received: from localhost (unknown [106.51.104.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7135206E0;
        Sat, 27 Apr 2019 08:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556353174;
        bh=F+SqDYoYNfTHf5ZQmfhStkeI3byBSsnmee6PqdO0LLc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sxqyZJxt6vfVPsYeht1m0OW/U3O2wSG7KMieCJWClGKdpNa/lPwfm8FV7QyE3OOzx
         GfrgOML2PvVW2A/Ya8wqAeuaf7YciLK4nDPPnwv/WJ+E3g1TAgrY/urKK0Dz8AnXAt
         eylpj/h+1qLnzssW6ZgvMT0n0mOFpWfS5AE5KUXw=
Date:   Sat, 27 Apr 2019 13:49:30 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: Fully describe the CDSP
Message-ID: <20190427081930.GI28103@vkoul-mobl>
References: <20190324172016.1195-1-bjorn.andersson@linaro.org>
 <20190324172016.1195-3-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190324172016.1195-3-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-03-19, 10:20, Bjorn Andersson wrote:

It would have been great to explain the change and why we are moving the
node :)

> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/qcs404.dtsi | 88 ++++++++++++++++++----------
>  1 file changed, 57 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> index f62cd09d965e..c20425aa9ed9 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> @@ -113,37 +113,6 @@
>  		};
>  	};
>  
> -	remoteproc_cdsp: remoteproc-cdsp {
> -		compatible = "qcom,qcs404-cdsp-pas";
> -
> -		interrupts-extended = <&intc GIC_SPI 229 IRQ_TYPE_EDGE_RISING>,
> -				      <&cdsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> -				      <&cdsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
> -				      <&cdsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
> -				      <&cdsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
> -		interrupt-names = "wdog", "fatal", "ready",
> -				  "handover", "stop-ack";
> -
> -		clocks = <&xo_board>;
> -		clock-names = "xo";
> -
> -		memory-region = <&cdsp_fw_mem>;
> -
> -		qcom,smem-states = <&cdsp_smp2p_out 0>;
> -		qcom,smem-state-names = "stop";
> -
> -		status = "disabled";
> -
> -		glink-edge {
> -			interrupts = <GIC_SPI 141 IRQ_TYPE_EDGE_RISING>;
> -
> -			qcom,remote-pid = <5>;
> -			mboxes = <&apcs_glb 12>;
> -
> -			label = "cdsp";
> -		};
> -	};
> -
>  	remoteproc_wcss: remoteproc-wcss {
>  		compatible = "qcom,qcs404-wcss-pas";
>  
> @@ -288,6 +257,57 @@
>  			clock-names = "core";
>  		};
>  
> +		remoteproc_cdsp: remoteproc@b00000 {
> +			compatible = "qcom,qcs404-cdsp-pas";
> +			reg = <0x00b00000 0x4040>;
> +
> +			interrupts-extended = <&intc GIC_SPI 229 IRQ_TYPE_EDGE_RISING>,
> +					      <&cdsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> +					      <&cdsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
> +					      <&cdsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
> +					      <&cdsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
> +			interrupt-names = "wdog", "fatal", "ready",
> +					  "handover", "stop-ack";
> +
> +			clocks = <&xo_board>,
> +				 <&gcc GCC_CDSP_CFG_AHB_CLK>,
> +				 <&gcc GCC_CDSP_TBU_CLK>,
> +				 <&gcc GCC_BIMC_CDSP_CLK>,
> +				 <&turingcc TURING_WRAPPER_AON_CLK>,
> +				 <&turingcc TURING_Q6SS_AHBS_AON_CLK>,
> +				 <&turingcc TURING_Q6SS_AHBM_AON_CLK>,
> +				 <&turingcc TURING_Q6SS_Q6_AXIM_CLK>;
> +			clock-names = "xo",
> +				      "sway",
> +				      "tbu",
> +				      "bimc",
> +				      "ahb_aon",
> +				      "q6ss_slave",
> +				      "q6ss_master",
> +				      "q6_axim";
> +
> +			resets = <&gcc GCC_CDSP_RESTART>;
> +			reset-names = "restart";
> +
> +			qcom,halt-regs = <&tcsr 0x19004>;
> +
> +			memory-region = <&cdsp_fw_mem>;
> +
> +			qcom,smem-states = <&cdsp_smp2p_out 0>;
> +			qcom,smem-state-names = "stop";
> +
> +			status = "disabled";
> +
> +			glink-edge {
> +				interrupts = <GIC_SPI 141 IRQ_TYPE_EDGE_RISING>;
> +
> +				qcom,remote-pid = <5>;
> +				mboxes = <&apcs_glb 12>;
> +
> +				label = "cdsp";
> +			};
> +		};
> +
>  		usb3_phy: phy@78000 {
>  			compatible = "qcom,usb-ssphy";
>  			reg = <0x78000 0x400>;
> @@ -506,6 +526,7 @@
>  			compatible = "qcom,gcc-qcs404";
>  			reg = <0x01800000 0x80000>;
>  			#clock-cells = <1>;
> +			#reset-cells = <1>;

Shouldn't this be a separate patch?

>  
>  			assigned-clocks = <&gcc GCC_APSS_AHB_CLK_SRC>;
>  			assigned-clock-rates = <19200000>;
> @@ -516,6 +537,11 @@
>  			reg = <0x01905000 0x20000>;
>  		};
>  
> +		tcsr: syscon@1937000 {
> +			compatible = "syscon";
> +			reg = <0x01937000 0x25000>;
> +		};
> +

This too..

>  		spmi_bus: spmi@200f000 {
>  			compatible = "qcom,spmi-pmic-arb";
>  			reg = <0x0200f000 0x001000>,
> -- 
> 2.18.0

-- 
~Vinod
