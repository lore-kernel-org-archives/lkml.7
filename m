Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF60C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B65482070B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S87ApXvG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfCDTYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 14:24:01 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41268 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfCDTYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 14:24:01 -0500
Received: by mail-lf1-f66.google.com with SMTP id y7so4342743lfg.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 11:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KfysOHbW6wawbFeuvOvV3NIBZk/3AJxyjewlh6u5Nhg=;
        b=S87ApXvGlftJB+/JOfsMR+6XQUpluRuQwns0Zgu9qnpS0uKGl51zw6wqN8yVD+P6Jg
         sRvfzo2waix5IKElVPXr7RTrSgtbCm0igdRUZjammYCJ4xxuDWhTtioXrGBrVAEX0HUi
         phU6W/etyeS1rwfl0LyaY9Q7pJwMGZbUmWZag4zH+0BnA5+DHMdAQOMYpEZYU29F02Oe
         zy37Nepe1HXl6E74u/pTMDzghTNUa0h80pbzR7dNBT0+kAF1LboY5eMNFLCj3OORWj7E
         gHMEguuZIrxxS3xpCkLI0AAYlqWUs2XBXrDKGGCh5rmWPWyzxeato4Brlu0Dn2SLDW+S
         BdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KfysOHbW6wawbFeuvOvV3NIBZk/3AJxyjewlh6u5Nhg=;
        b=iA1n2MwdYOybrifx86oWLV0M+pNslNB89C8nuJxWp1Mrmd9G5Cw89+9aVpSLZ7GF+2
         aQjDDIAq7A7XjzjHvcHQU0CxpCY+CMWd7lGCZQsjQUftiGDbLsikYt9nxWQ1ix1Kpn8z
         fZ3vIEI4T3x0CqHjvsMaDwk5tB3dMRLLLMNgCdOXuKx9ovgOFkUalAsxYDoN4dDhcUuz
         gHDUKeChcuOMFVSn7fY90+s+olrH58LDSzL5Cv+0yPTWQJRQiRFZ2X+c2DW+Q1szZY6n
         /3QAAkjHMAk3TPXpT4y02i7pux1md+lNLuZSlqFfGwUUBkBABDUVE0l8lWEF6pG/aBpo
         NVdw==
X-Gm-Message-State: APjAAAWv1HHw65MSBs7ShN/7nTcJkRh4xNS+5DFCLEDvriHxVHBbl84y
        009hu09MVjw0HHLHjWA4QR7EQw==
X-Google-Smtp-Source: APXvYqxYK579jCkdEkTauj/GVDaGZfxQGrL+lC2dwkNQBENf9ZQRe9n6IiEWAbb8tpRrODNPG1lRKg==
X-Received: by 2002:a19:c616:: with SMTP id w22mr11350966lff.31.1551727439054;
        Mon, 04 Mar 2019 11:23:59 -0800 (PST)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id n6sm1781249lfl.9.2019.03.04.11.23.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 04 Mar 2019 11:23:57 -0800 (PST)
Date:   Mon, 4 Mar 2019 20:23:55 +0100
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>
Subject: Re: [PATCH] arm64: dts: qcom: qcs404: Fix regulator supply names
Message-ID: <20190304192355.GA13754@centauri.lan>
References: <20181213183200.3204-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213183200.3204-1-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 10:32:00AM -0800, Bjorn Andersson wrote:
> The regulator definition got their supply names cleaned up during
> upstreaming, so they no longer match the driver defined names. Update
> the supply names.
> 
> Also fill out the missing voltage of SMPS 5.
> 
> Fixes: 0b363f5b871c ("arm64: dts: qcom: qcs404: Add PMS405 RPM regulators")
> Reported-by: Nicolas Dechesne <nicolas.dechesne@linaro.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/qcs404-evb.dtsi | 28 ++++++++++++------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> index a39924efebe4..d6cc3a96530e 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> @@ -37,18 +37,18 @@
>  	pms405-regulators {
>  		compatible = "qcom,rpm-pms405-regulators";
>  
> -		vdd-s1-supply = <&vph_pwr>;
> -		vdd-s2-supply = <&vph_pwr>;
> -		vdd-s3-supply = <&vph_pwr>;
> -		vdd-s4-supply = <&vph_pwr>;
> -		vdd-s5-supply = <&vph_pwr>;
> -		vdd-l1-l2-supply = <&vreg_s5_1p35>;
> -		vdd-l3-l8-supply = <&vreg_s5_1p35>;
> -		vdd-l4-supply = <&vreg_s5_1p35>;
> -		vdd-l5-l6-supply = <&vreg_s4_1p8>;
> -		vdd-l7-supply = <&vph_pwr>;
> -		vdd-l9-supply = <&vreg_s5_1p35>;
> -		vdd-l10-l11-l12-l13-supply = <&vph_pwr>;
> +		vdd_s1-supply = <&vph_pwr>;
> +		vdd_s2-supply = <&vph_pwr>;
> +		vdd_s3-supply = <&vph_pwr>;
> +		vdd_s4-supply = <&vph_pwr>;
> +		vdd_s5-supply = <&vph_pwr>;
> +		vdd_l1_l2-supply = <&vreg_s5_1p35>;
> +		vdd_l3_l8-supply = <&vreg_s5_1p35>;
> +		vdd_l4-supply = <&vreg_s5_1p35>;
> +		vdd_l5_l6-supply = <&vreg_s4_1p8>;
> +		vdd_l7-supply = <&vph_pwr>;
> +		vdd_l9-supply = <&vreg_s5_1p35>;
> +		vdd_l10_l11_l12_l13-supply = <&vph_pwr>;
>  
>  		vreg_s4_1p8: s4 {
>  			regulator-min-microvolt = <1728000>;
> @@ -56,8 +56,8 @@
>  		};
>  
>  		vreg_s5_1p35: s5 {
> -			regulator-min-microvolt = <>;
> -			regulator-max-microvolt = <>;
> +			regulator-min-microvolt = <1352000>;
> +			regulator-max-microvolt = <1352000>;
>  		};
>  
>  		vreg_l1_1p3: l1 {
> -- 
> 2.18.0
> 

Reviewed-by: Niklas Cassel <niklas.cassel@linaro.org>
