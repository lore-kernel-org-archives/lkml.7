Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003DCC3A59C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 12:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5BD12173E
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 12:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GA/F9BJw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730808AbfHOMpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 08:45:42 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43961 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfHOMpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 08:45:42 -0400
Received: by mail-lj1-f195.google.com with SMTP id h15so2095119ljg.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 05:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tNtdmyVFFNYp8n31Oa87YwnukMTlsB7iDWsfjRK39R4=;
        b=GA/F9BJw557px7gsgUF8TwW11POwwgTNmCreAMzDZU2CwJ8006JTnbL5lu57UNPySR
         mNoB1AVz6pclJ8QzeSV7E5TQaMKF+346znOHXoDe7SG+ws42m/tpXOLLQFzPsXUWeibz
         VQOcxlXRn377YpCHAGe2jtNwTQyladcq+yD6fWznIORIyr6xgTQ/f2LMQrmPTSnPt0kb
         oEfI3L+5P2w2F590YYCXv12ms/34q5w04ytyLaxKRmn6oFbNgTdWAkEDMOHU6AbIGSFt
         kdtM9KnJy+YTKthl8Rb6GZui7aWApWeb3FoPqu9YhmVknmGvRe/RD2EZDy0+tVz1FOC2
         TN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tNtdmyVFFNYp8n31Oa87YwnukMTlsB7iDWsfjRK39R4=;
        b=WXvfUljqR33oTC7rPWhHo9DIMz/s8oJpaCb3+V0+kuA5nflSqlO9AAW4+T98Fg6b6v
         3YfJ0zvXEoEjZQDb857vkDuk+egTmfxmSXjEEanqTO+FpfURJQ7+X1MqLw+VIp32Utta
         LN4NFm1YCsI/pMmhAGUqhlq+sPxvjAlpa8hunVZk+tyh60QUSWEqyISQpkjkF1VlNea+
         RcuHTYZ6SijZiAWkCtDbu3Gak5aQPHW8xDLSzCjfLbvlC2fiI64sP+xMJq3Fl7xfjKNj
         E0SRYbMve+i1Vr+aw47y3flcYV/Hv+ehMGk5+BMCuWUkqfTka94h5Kb17WSPkGgheEJY
         NH/g==
X-Gm-Message-State: APjAAAVAd8xbauSLbbm+CsJ9LYNHa4NaFN5KLrHdkmbh4ySrslD2kQ2N
        pLJZnTQzSyu/EstMkbNPPkAK0w==
X-Google-Smtp-Source: APXvYqyLhBVu8CnCpPf/Q2HyMXj3iNqMlFfEten8mXcAPtyNQ1Mj0Lx1aZ0bjrM/tChpk/s9sMfdpg==
X-Received: by 2002:a2e:7818:: with SMTP id t24mr1084914ljc.210.1565873140325;
        Thu, 15 Aug 2019 05:45:40 -0700 (PDT)
Received: from centauri (ua-84-219-138-247.bbcust.telenor.se. [84.219.138.247])
        by smtp.gmail.com with ESMTPSA id f6sm468298lja.16.2019.08.15.05.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 05:45:39 -0700 (PDT)
Date:   Thu, 15 Aug 2019 14:45:37 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: qcs404-evb: Mark WCSS clocks protected
Message-ID: <20190815124537.GA14491@centauri>
References: <20190814030942.2638-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814030942.2638-1-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 08:09:42PM -0700, Bjorn Andersson wrote:
> '7d0c76bdf227 ("clk: qcom: Add WCSS gcc clock control for QCS404")'
> introduces two new clocks to gcc. These are not used before
> clk_disable_unused() and as such the clock framework tries to disable
> them.
> 
> But on the EVB these registers are only accessible through TrustZone, so
> these clocks must be marked as "protected" to prevent the clock code
> from touching them.
> 
> Numerical values are used as the constants are not yet available in a
> common tree.
> 
> Reported-by: Mark Brown <broonie@kernel.org>
> Reported-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/qcs404-evb.dtsi | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> index 2289b01ee9f0..501a7330dbc8 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> @@ -61,7 +61,9 @@
>  	protected-clocks = <GCC_BIMC_CDSP_CLK>,
>  			   <GCC_CDSP_CFG_AHB_CLK>,
>  			   <GCC_CDSP_BIMC_CLK_SRC>,
> -			   <GCC_CDSP_TBU_CLK>;
> +			   <GCC_CDSP_TBU_CLK>,
> +			   <141>, /* GCC_WCSS_Q6_AHB_CLK */
> +			   <142>; /* GCC_WCSS_Q6_AXIM_CLK */
>  };
>  
>  &pms405_spmi_regulators {
> -- 
> 2.18.0
> 

Reviewed-by: Niklas Cassel <niklas.cassel@linaro.org>
