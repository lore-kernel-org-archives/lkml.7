Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAC6C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 22:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA13E20674
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 22:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cbU0NoM5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfDRW5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 18:57:18 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36218 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfDRW5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 18:57:18 -0400
Received: by mail-pf1-f196.google.com with SMTP id z5so1754788pfn.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 15:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ag6Pa49hu/ALuIx1FZfQOLAfd+1VTNjEXJqzChfJsJs=;
        b=cbU0NoM5yAs1pvFY9bJA4c1LDD1huKPpXp7W97Jb/8eNMh7QNUAGuqW4C/XbPndUlp
         cGMarV2dWKyvevGoFj7nls8yijAvPMCIMpIctjH8VVZeS1zumjHO0WQNBc0dLjKs9i+a
         jc/XIEsi9LxnWpbrRyJ1386ccHO/0qfizrDG4F0L3S0VvQvNMenrnEJvbk57+X55HrXU
         LKjNXoNuFSqIyGtfA7xWQwu1GvhkSfQ++q3UBdq8NhblTkTxpmVbfqA02SKRHjIFxvQW
         +336RCNVtfLOIHsB7zzpWF4vuvpF3GjksTVIcN7MRS1KVYXjqUsDRxdo4CNUEMfFH/jj
         TPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ag6Pa49hu/ALuIx1FZfQOLAfd+1VTNjEXJqzChfJsJs=;
        b=R9dU/5DaR6l6RpjjtWpf4dma/fo6keJj/nNNc7dLlZ0rDhFoIE/8gPws6Hp4UB923T
         O4Chn2MMxkbfV6m/fHp3GI9+wPVHWS6zHxo9ifYpTOP2aUzJiISAmBexi9q20F178Dg4
         hr+JBDg5JeE6jsTqo1GRQ4xOIbPxsxBsgpYqqgp+UXgJj7nVGE2/th5MvnlfVVR5yaiX
         RnDS20GvWlq1hOIaT9xervRG871hCiMAegQanGO/koeUc35cTvYrmtZl6ErfZaZ7xUIW
         6gdODmJvuoOMwHkdld7uhQ2VAZjVmaQ9671331PYn/pRc07lq6PrXkLgQLJmEnNEJJXb
         303w==
X-Gm-Message-State: APjAAAXHSbkr2lmaNQ4ADwLi9KVCP2EHmIf0WJdxplWn6TC0Ks46yt0J
        n7zsi9xHEFnB4f6UmuaK+dDeCw==
X-Google-Smtp-Source: APXvYqwxsa++WpJ1MVXmafLTcTZvjnkZ0q8rvY70oxgqlkhQed7tcU8Z8H/TgbyBesyzVfDtsdHZXQ==
X-Received: by 2002:a63:4616:: with SMTP id t22mr495257pga.217.1555627913896;
        Thu, 18 Apr 2019 15:51:53 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v20sm4001699pfn.116.2019.04.18.15.51.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 15:51:52 -0700 (PDT)
Date:   Thu, 18 Apr 2019 15:51:50 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     robh+dt@kernel.org, vkoul@kernel.org, evgreen@chromium.org,
        daidavid1@codeaurora.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 4/4] dt-bindings: interconnect: qcs404: Introduce
 qcom,qos DT property
Message-ID: <20190418225150.GN27005@builder>
References: <20190415104357.5305-1-georgi.djakov@linaro.org>
 <20190415104357.5305-5-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415104357.5305-5-georgi.djakov@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 15 Apr 03:43 PDT 2019, Georgi Djakov wrote:

> There are separate hardware blocks per each interconnect that allow QoS
> configuration to be applied to each port (node). There are different kinds of
> priorities that could be set on these ports. Each port supports also various
> QoS modes such as "fixed", "limiter", "bypass" and "regulator". Depending on
> the mode, there are a few additional knobs that could be configured.
> 
> Introduce the qcom,qos property, so that we describe this relation in DT and
> allow the interconnect provider drivers can make use of it.
> 

As the example shows we will end up with two nodes describing the same
hardware with pretty much identical set of properties.

I really do think it's better to represent and implement the NoC
controllers on the mmio/platform bus and have a small "proxy" as a child
of the RPM.


By doing this you avoid the duplication of the clock properties and you
don't need the qcom,qos reference to pair up each "bus performance
driver" to the "bus qos driver".

And you still maintain the idea that the entity you request bandwidth
votes with are the NoC controller (which also will be the QoS
controller).

Regards,
Bjorn

> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
> 
> v2:
> - New patch.
> 
>  .../bindings/interconnect/qcom,qcs404.txt     | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt b/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
> index 9befcd14a5b5..b971e0ee2963 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
> @@ -11,9 +11,37 @@ Required properties :
>  Optional properties :
>  clocks : list of phandles and specifiers to all interconnect bus clocks
>  clock-names : clock names should include both "bus_clk" and "bus_a_clk"
> +qcom,qos : phandle to the QoS device-tree node
>  
>  Example:
>  
> +soc {
> +	...
> +	bimc_qos: interconnect@400000 {
> +		compatible = "qcom,qcs404-bimc-qos";
> +		reg = <0x400000 0x80000>;
> +		clock-names = "bus_clk", "bus_a_clk";
> +		clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
> +			<&rpmcc RPM_SMD_BIMC_A_CLK>;
> +	};
> +
> +	pcnoc_qos: interconnect@500000 {
> +		compatible = "qcom,qcs404-pcnoc-qos";
> +		reg = <0x500000 0x15080>;
> +		clock-names = "bus_clk", "bus_a_clk";
> +		clocks = <&rpmcc RPM_SMD_PNOC_CLK>,
> +			<&rpmcc RPM_SMD_PNOC_A_CLK>;
> +	};
> +
> +	snoc_qos: interconnect@580000 {
> +		compatible = "qcom,qcs404-snoc-qos";
> +		reg = <0x580000 0x14000>;
> +		clock-names = "bus_clk", "bus_a_clk";
> +		clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
> +			<&rpmcc RPM_SMD_SNOC_A_CLK>;
> +	};
> +};
> +
>  rpm-glink {
>  	...
>  	rpm_requests: glink-channel {
> @@ -24,6 +52,7 @@ rpm-glink {
>  			clock-names = "bus_clk", "bus_a_clk";
>  			clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
>  				<&rpmcc RPM_SMD_BIMC_A_CLK>;
> +			qcom,qos = <&bimc_qos>;
>  		};
>  
>  		pnoc: interconnect@1 {
> @@ -32,6 +61,7 @@ rpm-glink {
>  			clock-names = "bus_clk", "bus_a_clk";
>  			clocks = <&rpmcc RPM_SMD_PNOC_CLK>,
>  				<&rpmcc RPM_SMD_PNOC_A_CLK>;
> +			qcom,qos = <&pcnoc_qos>;
>  		};
>  
>  		snoc: interconnect@2 {
> @@ -40,6 +70,7 @@ rpm-glink {
>  			clock-names = "bus_clk", "bus_a_clk";
>  			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
>  				<&rpmcc RPM_SMD_SNOC_A_CLK>;
> +			qcom,qos = <&snoc_qos>;
>  		};
>  	};
>  };
