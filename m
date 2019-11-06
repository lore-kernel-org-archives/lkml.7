Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FAEC47E49
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 13:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3020D214D8
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 13:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e/qHUHQv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731823AbfKFNxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 08:53:23 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42150 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731760AbfKFNxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 08:53:22 -0500
Received: by mail-ed1-f66.google.com with SMTP id m13so13071564edv.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 05:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=f/07mDa7U3BeT4TUXv97i2fvuP+QZqH0SLBfnWPxR0U=;
        b=e/qHUHQvOfyQWuy3eA3qaDE8QLdLHxOxgBx/u8WrUcPLw2FI90PTvJFxyxqsUNLPcK
         o48+3FUDK3eRMzzx+D7+KEiZPRV/jFqRLoHsVyi/5NguB6gBPvM/LIaXj+splYGGG5kR
         ZXvinxHU5+Lahgxs2ggeu1zUqtVOqRhUIdEqTbEOQxvYYMi+LarsvZ30hxcvMjRnEqog
         KGrrSYluKhd2IUsGFqQxHRH1MblzTFCIw11rsXgj02UVzpf41mqQUp/H+C9mQjupJ8g+
         pL5c1zvuCtZbWAgfe336LUIpRyY6H99nA9ssqIa8KHZsVdAFTzosjeZaaqBWPdjWlDxj
         S6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f/07mDa7U3BeT4TUXv97i2fvuP+QZqH0SLBfnWPxR0U=;
        b=YCeaANquC56KBX7xmb/pl9azAQRoKibRfgchXcJrmqCcdn99+I+6jGuG31tAXzkmbq
         H8KFzHLkKQFCBzvHp4HMJsn5Id0uVkikQkaVhaPTDMx0MZRHhqMQmIgm3BL/36Fz4td2
         RyvaLVuYSvz2HX0Lt2DtLbj3kBkLspcE5EhPQUJkyBvfdlijbwzw/4KqBdTFyOnGU9/3
         wayhGOu5GNZ/KiC5iO6yaYpxSTHl5MCAKApvHd20tYqvNWEMyHRbf+hcDbTB+TS2EIGL
         XbQnr4x9VaaV10iTav2g8d2nChV0kaRjStjljcpTjS2etyLkfkpWKhNdw3El2jxxJZkl
         rnVw==
X-Gm-Message-State: APjAAAXrCV4qMKIuxBhGJNBlen4+68+ie66piqQIu7qTaayVpyuRiOxd
        ld9ChTSbTWP6KGvNBQCPZArbz/Fh/Fo=
X-Google-Smtp-Source: APXvYqzmxUPfsyqC+mhuIOKBx2mpzZZuLmym1ciYOftytpCIGE4z17WT5/rL35GNWkuidzuUHi5yvA==
X-Received: by 2002:a50:fd03:: with SMTP id i3mr2831317eds.70.1573048400117;
        Wed, 06 Nov 2019 05:53:20 -0800 (PST)
Received: from [192.168.27.135] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id c93sm1172968edf.92.2019.11.06.05.53.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 05:53:19 -0800 (PST)
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sdm845: Add second PCIe PHY and
 controller
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191102003148.4091335-1-bjorn.andersson@linaro.org>
 <20191102003148.4091335-3-bjorn.andersson@linaro.org>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <af66ac9a-f473-44b7-8604-2153c680960b@linaro.org>
Date:   Wed, 6 Nov 2019 15:53:18 +0200
MIME-Version: 1.0
In-Reply-To: <20191102003148.4091335-3-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 2.11.19 г. 2:31 ч., Bjorn Andersson wrote:
> Add the second PCIe controller and the associated QHP PHY found on
> SDM845.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 111 +++++++++++++++++++++++++++
>  1 file changed, 111 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index b93537b7a59f..0cdcc8d6d223 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -1468,6 +1468,117 @@
>  			};
>  		};
>  
> +		pcie1: pci@1c08000 {
> +			compatible = "qcom,pcie-sdm845", "snps,dw-pcie";
> +			reg = <0 0x01c08000 0 0x2000>,
> +			      <0 0x40000000 0 0xf1d>,
> +			      <0 0x40000f20 0 0xa8>,
> +			      <0 0x40100000 0 0x100000>;
> +			reg-names = "parf", "dbi", "elbi", "config";
> +			device_type = "pci";
> +			linux,pci-domain = <1>;
> +			bus-range = <0x00 0xff>;
> +			num-lanes = <1>;
> +
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +
> +			ranges = <0x01000000 0x0 0x40200000 0x0 0x40200000 0x0 0x100000>,
> +				 <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x1fd00000>;
> +
> +			interrupts = <GIC_SPI 307 IRQ_TYPE_EDGE_RISING>;
> +			interrupt-names = "msi";
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &intc 0 434 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
> +					<0 0 0 2 &intc 0 435 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
> +					<0 0 0 3 &intc 0 438 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
> +					<0 0 0 4 &intc 0 439 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
> +
> +			clocks = <&gcc GCC_PCIE_1_PIPE_CLK>,
> +				 <&gcc GCC_PCIE_1_AUX_CLK>,
> +				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
> +				 <&gcc GCC_PCIE_1_MSTR_AXI_CLK>,
> +				 <&gcc GCC_PCIE_1_SLV_AXI_CLK>,
> +				 <&gcc GCC_PCIE_1_SLV_Q2A_AXI_CLK>,
> +				 <&gcc GCC_PCIE_1_CLKREF_CLK>,
> +				 <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>;
> +			clock-names = "pipe",
> +				      "aux",
> +				      "cfg",
> +				      "bus_master",
> +				      "bus_slave",
> +				      "slave_q2a",
> +				      "ref",
> +				      "tbu";
> +
> +			assigned-clocks = <&gcc GCC_PCIE_1_AUX_CLK>;
> +			assigned-clock-rates = <19200000>;
> +
> +			iommus = <&apps_smmu 0x1c00 0xf>;
> +			iommu-map = <0x0   &apps_smmu 0x1c00 0x1>,
> +				    <0x100 &apps_smmu 0x1c01 0x1>,
> +				    <0x200 &apps_smmu 0x1c02 0x1>,
> +				    <0x300 &apps_smmu 0x1c03 0x1>,
> +				    <0x400 &apps_smmu 0x1c04 0x1>,
> +				    <0x500 &apps_smmu 0x1c05 0x1>,
> +				    <0x600 &apps_smmu 0x1c06 0x1>,
> +				    <0x700 &apps_smmu 0x1c07 0x1>,
> +				    <0x800 &apps_smmu 0x1c08 0x1>,
> +				    <0x900 &apps_smmu 0x1c09 0x1>,
> +				    <0xa00 &apps_smmu 0x1c0a 0x1>,
> +				    <0xb00 &apps_smmu 0x1c0b 0x1>,
> +				    <0xc00 &apps_smmu 0x1c0c 0x1>,
> +				    <0xd00 &apps_smmu 0x1c0d 0x1>,
> +				    <0xe00 &apps_smmu 0x1c0e 0x1>,
> +				    <0xf00 &apps_smmu 0x1c0f 0x1>;
> +
> +			resets = <&gcc GCC_PCIE_1_BCR>;
> +			reset-names = "pci";
> +
> +			power-domains = <&gcc PCIE_1_GDSC>;
> +
> +			interconnects = <&rsc_hlos MASTER_PCIE_0 &rsc_hlos SLAVE_EBI1>;
> +			interconnect-names = "pcie-mem";

Maybe leave this hunk out (although it looks good), until we conclude on these
refactoring patches [1].

Thanks,
Georgi

[1]
http://lore.kernel.org/r/1571278852-8023-1-git-send-email-daidavid1@codeaurora.org
