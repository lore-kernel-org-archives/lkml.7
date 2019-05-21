Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1609C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 09:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4FA921743
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 09:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KPVsE6tb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfEUJZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 05:25:49 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40840 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfEUJZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 05:25:49 -0400
Received: by mail-lj1-f195.google.com with SMTP id q62so5692161ljq.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 02:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CkcirGX3QvjLhz9moY6Imqk+qItJBJo6soSbUqVfWnQ=;
        b=KPVsE6tbmoozmtanxFIcLRZ6t1QsqfMa3iEgemxmZvJCVg3YSyfhz+CWOYIPn0z+kY
         524LHkx3uTbLNW0a9Bl8sjLjp9ktTb+7R7bqyH+QgCptPcvc9ZophZDDPdlNs/xeSF7U
         j4J9EGZ/mU8uv6wsxOsnY4zzJWe9mp04gIuNNcH1qSt4Oq2aMb3yMVsub/9Swq8bqmLm
         VEJP0jlpCLr3ns9M+fimlkhyx5MkOdIJs6LEhZGXU30FJFAzQ+7BRQAWIiNZ3w0edpuu
         C8//mxCK9vsrcJ5Y/NGIoVB7X1R1mOdaHqMoNLZTXcVPxj6gEyDC5uUnC5Os6oKuWGrl
         XGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CkcirGX3QvjLhz9moY6Imqk+qItJBJo6soSbUqVfWnQ=;
        b=bNAT9sHmHmiIHfpvUfAgoxedbnw6+NWtUNUk+lHlALhVNpJtR3GmHCIIBWQYpQevv5
         oLRjoWSm19vs8YTLQ7DlIj1Ad0If5oYSbyNapP+HzaztgcAeNrxv0PtSeAXraOa3AL6v
         ECQup6bfaFv7AZxQO/OTTCOhv6E3qm7Z5PuYS3kLqHp7po47BGpZEgRgtM1vZI07Rn0v
         lavJmIClYnKzSJ8+2Sq5TZdN6dnyreqvLHMMOuMdec5NWlHl014mCEPitGQ9GUFy1a/x
         ucwCa/ezk1RBMvEzZkFnRJj5QQ7AjwsLLrJpb1XdFFGfYBkaJNT3lIoSrp4NG1qrcLx6
         Luww==
X-Gm-Message-State: APjAAAUYLDMdcuKZy7WQzEQD06tN/VlwIXaEvIXDGOVFL8H5F1yaE9w0
        DjMmsw4+NfgATEvUEBopuOvNpQ==
X-Google-Smtp-Source: APXvYqyREgv4vGHN0qpoxZgnvPbSHQF4hl4/zB2vk3nwAFQr5ASD4uiHBCK/ox3Af/hHK+UEStkOEA==
X-Received: by 2002:a2e:731a:: with SMTP id o26mr543653ljc.105.1558430747246;
        Tue, 21 May 2019 02:25:47 -0700 (PDT)
Received: from centauri (m83-185-80-163.cust.tele2.se. [83.185.80.163])
        by smtp.gmail.com with ESMTPSA id i1sm38409lfc.86.2019.05.21.02.25.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 21 May 2019 02:25:46 -0700 (PDT)
Date:   Tue, 21 May 2019 11:25:44 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: msm8996: Stop using legacy clock names
Message-ID: <20190521092544.GB22910@centauri>
References: <20190503232442.1530-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503232442.1530-1-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 04:24:42PM -0700, Bjorn Andersson wrote:
> MDSS and its friends complain about the DTS is using legacy clock names,
> update these to silence the warnings.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index a988edabe474..3d861f1d836c 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -1678,7 +1678,7 @@
>  			#interrupt-cells = <1>;
>  
>  			clocks = <&mmcc MDSS_AHB_CLK>;
> -			clock-names = "iface_clk";
> +			clock-names = "iface";
>  
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> @@ -1697,11 +1697,11 @@
>  					 <&mmcc MDSS_MDP_CLK>,
>  					 <&mmcc SMMU_MDP_AXI_CLK>,
>  					 <&mmcc MDSS_VSYNC_CLK>;
> -				clock-names = "iface_clk",
> -					      "bus_clk",
> -					      "core_clk",
> -					      "iommu_clk",
> -					      "vsync_clk";
> +				clock-names = "iface",
> +					      "bus",
> +					      "core",
> +					      "iommu",
> +					      "vsync";
>  
>  				iommus = <&mdp_smmu 0>;
>  
> @@ -1736,11 +1736,11 @@
>  					 <&mmcc MDSS_HDMI_AHB_CLK>,
>  					 <&mmcc MDSS_EXTPCLK_CLK>;
>  				clock-names =
> -					"mdp_core_clk",
> -					"iface_clk",
> -					"core_clk",
> -					"alt_iface_clk",
> -					"extp_clk";
> +					"mdp_core",
> +					"iface",
> +					"core",
> +					"alt_iface",
> +					"extp";
>  
>  				phys = <&hdmi_phy>;
>  				phy-names = "hdmi_phy";
> @@ -1777,8 +1777,8 @@
>  
>  				clocks = <&mmcc MDSS_AHB_CLK>,
>  					 <&gcc GCC_HDMI_CLKREF_CLK>;
> -				clock-names = "iface_clk",
> -					      "ref_clk";
> +				clock-names = "iface",
> +					      "ref";
>  			};
>  		};
>  	};
> -- 
> 2.18.0
> 

Reviewed-by: Niklas Cassel <niklas.cassel@linaro.org>
