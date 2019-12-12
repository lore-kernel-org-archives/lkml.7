Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06ECC3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 07:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 705592173E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 07:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QTHWe33G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbfLLHjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 02:39:22 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39140 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbfLLHjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 02:39:22 -0500
Received: by mail-pf1-f193.google.com with SMTP id 2so300009pfx.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 23:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qo4K50LzAN2stnSI10i/xMxtvvEyKR1cSWIWv7pZkAY=;
        b=QTHWe33GqVF+OXqosfCsmbjOnSeJdTu2Ok3v6PGMePJB7YQAsSH2vM9oXU47Iacc1K
         VZ40OB8Jw7epK4xlR0cKDWXRT0MD9vBIZKU0ozV7lJqKRLWkpGu4x5biCxa24CJLzMmm
         Af7H8zLmJguvauWsRE29SjWjC5xmgY0NvyLTypZP3UJ1/9kE6vA/tbijX1IuYbahDU9J
         xLBhl1dQKQbMhG8lIuM1si7Kps/Ur5BXRPI9FyLQDkAymILFAXY8QqmTIY+U3sCCLRa4
         rctivrQJNKlfawkqEDrFRlwXUfcMVLkbnX5GDlhYhfRbdN+Uk7EHa/G7Te1q80lDa28D
         /Mjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qo4K50LzAN2stnSI10i/xMxtvvEyKR1cSWIWv7pZkAY=;
        b=HGHMVpExOG1c2srY/ZE4Lj3oY0mpfWVgPD/dEW8/WX15Z5+CDFmYm8HfQdR+PkhLXG
         gOkGB6JSndv3F38519ChKkn2bXviWjtG9U5sdThVMRutYRknzb/tzwBlRHbcew0xRRML
         7LREDeSLd7OA57Gv/w3Dmh6bXgHhwQocPjQJlDgUhJk/vFIYslhq5kXHNlv7XICkypd7
         1wdpgiMS2V/esZf25Xfoi4NNsSMu5kdKNH8ORv6ar69lHA7hbqtp10kZW5LalxS/gBlg
         Wa44rqCcBkak53teWevtllrhFakQQSyIUYVqJgi5iK8oOCGrvRNqBRBFglN3fFAk2Psx
         7PVQ==
X-Gm-Message-State: APjAAAXxzmn4cgqlxi01P6c2IvJD1NxLSSy5j1Kp1vMZ7gfYHRZwnDf6
        EddpruqzE7Ng1TVeSea9fRGl4g==
X-Google-Smtp-Source: APXvYqyWrtLsL3y0QsBXtvnDvJ4rPvhnI90XbGOmcWEW32DAzZHdT8obP0vpz4JmOvrIUfBy6uGEPQ==
X-Received: by 2002:a63:1f16:: with SMTP id f22mr8587016pgf.2.1576136361275;
        Wed, 11 Dec 2019 23:39:21 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id g17sm5962032pfb.180.2019.12.11.23.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 23:39:20 -0800 (PST)
Date:   Wed, 11 Dec 2019 23:39:18 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     robh+dt@kernel.org, ulf.hansson@linaro.org, rnayak@codeaurora.org,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        mark.rutland@arm.com, swboyd@chromium.org, dianders@chromium.org
Subject: Re: [PATCH 6/6] arm64: dts: sm8150: Add rpmh power-domain node
Message-ID: <20191212073918.GO3143381@builder>
References: <20191118173944.27043-1-sibis@codeaurora.org>
 <0101016e7f99eab9-35efa01f-8ed3-4a77-87e1-09c381173121-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0101016e7f99eab9-35efa01f-8ed3-4a77-87e1-09c381173121-000000@us-west-2.amazonses.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 18 Nov 09:40 PST 2019, Sibi Sankar wrote:

> Add the DT node for the rpmhpd power controller.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

Series applied, please send separate patch for the yaml migration.

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/sm8150.dtsi | 55 ++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> index 8f23fcadecb89..0ac257637c2af 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> @@ -5,6 +5,7 @@
>   */
>  
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/power/qcom-rpmpd.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>  #include <dt-bindings/clock/qcom,rpmh.h>
>  
> @@ -469,6 +470,60 @@
>  				clock-names = "xo";
>  				clocks = <&xo_board>;
>  			};
> +
> +			rpmhpd: power-controller {
> +				compatible = "qcom,sm8150-rpmhpd";
> +				#power-domain-cells = <1>;
> +				operating-points-v2 = <&rpmhpd_opp_table>;
> +
> +				rpmhpd_opp_table: opp-table {
> +					compatible = "operating-points-v2";
> +
> +					rpmhpd_opp_ret: opp1 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_RETENTION>;
> +					};
> +
> +					rpmhpd_opp_min_svs: opp2 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
> +					};
> +
> +					rpmhpd_opp_low_svs: opp3 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
> +					};
> +
> +					rpmhpd_opp_svs: opp4 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
> +					};
> +
> +					rpmhpd_opp_svs_l1: opp5 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
> +					};
> +
> +					rpmhpd_opp_svs_l2: opp6 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_SVS_L2>;
> +					};
> +
> +					rpmhpd_opp_nom: opp7 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
> +					};
> +
> +					rpmhpd_opp_nom_l1: opp8 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
> +					};
> +
> +					rpmhpd_opp_nom_l2: opp9 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_NOM_L2>;
> +					};
> +
> +					rpmhpd_opp_turbo: opp10 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
> +					};
> +
> +					rpmhpd_opp_turbo_l1: opp11 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
> +					};
> +				};
> +			};
>  		};
>  	};
>  
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
