Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783D6C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 02:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A93F22464
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 02:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AGS0r1kR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfKTC3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 21:29:50 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42897 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbfKTC3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 21:29:50 -0500
Received: by mail-pg1-f193.google.com with SMTP id q17so12529095pgt.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 18:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3izFBnbbEPZlNBqSY62YGlpGBQ6lEBGA76YUc2oWAbI=;
        b=AGS0r1kRuXM0zTE9c/LCDSSkWzND1ZHuEL0QaejlsCqbzQtIWud+mntU+6EcdgADzS
         475Pqc/esEVt4m0GvAizYR75CeN/x2eGQO1xzb8XsvnujuefvyURFbA00rvUHSAHZBd1
         FtYeXOf+7bxZzDZ+PQfUSSTvHjf/u9j3d6b5JQRD1kyKY0sGJFC0YZRCair8JbINNAEB
         NkbWWrvRJ29oXpD0iGxM2IuPPXvRicStPpC5a5yBeGqLfe7FgVD/Y70YnCDpzUyqRGWS
         Oz+NXfYt6WG5WbD2H+resfoNXYL1ncT/IKyt6j9DFEi4dCIUiJMQgo6nyD17Jw5aHSR1
         bH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3izFBnbbEPZlNBqSY62YGlpGBQ6lEBGA76YUc2oWAbI=;
        b=K0sC4572SMixBDo9lGCIDcP7igS5IngGojvhAwPQ60wFLpmRsStS4zfp95FvoGE/rK
         UwURIlAbwpA/C6d1KkussmnwelKP3ErzmlDuj3HTJQFyGdgGlWScjGsQL6QlQ/ou4PcD
         03I1/2ibfB7rwqvqfdp5wfJZjD1G0YirQNf7SMHLjC4WB6Gz6nAarRoRnMvomO+5QzOK
         7lYslEMCkbl4GMZmsb6/OeDcPUoDCN7b1FdGXWyf/vv2DVnFKz3mhJZxeSEnTViWQPxj
         li5yLntK6QsOFSG18jPLrRC5W9OeoEWl2azO+qj50vJwk5XaLQ8eS/Tu4TSa/m1B/YB7
         f1aw==
X-Gm-Message-State: APjAAAVYy7btcYQdYJUTcTbhBfCgvkjFLHjMiKxwMIatvHEo+jpyGZjR
        HRCHxq1iiP8hIGVUCz735dDc4A==
X-Google-Smtp-Source: APXvYqw3F9KheQlkCF24qoQyemaO11ra3UXS3JnsQXzkH7ZbOtXvWRGw6T8jQsN8GAIPJiKIT5vuFg==
X-Received: by 2002:a63:de0b:: with SMTP id f11mr420349pgg.8.1574216987639;
        Tue, 19 Nov 2019 18:29:47 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h3sm26175214pgr.81.2019.11.19.18.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 18:29:46 -0800 (PST)
Date:   Tue, 19 Nov 2019 18:29:43 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     robh+dt@kernel.org, ulf.hansson@linaro.org, rnayak@codeaurora.org,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        mark.rutland@arm.com, swboyd@chromium.org, dianders@chromium.org
Subject: Re: [PATCH 2/6] dt-bindings: power: Add rpmh power-domain bindings
 for SM8150
Message-ID: <20191120022943.GK18024@yoga>
References: <20191118173944.27043-1-sibis@codeaurora.org>
 <0101016e7f99ad2b-2bce2fac-2f02-4b3f-ac64-09942f7251ea-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0101016e7f99ad2b-2bce2fac-2f02-4b3f-ac64-09942f7251ea-000000@us-west-2.amazonses.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 18 Nov 09:40 PST 2019, Sibi Sankar wrote:

> Add RPMH power-domain bindings for the SM8150 family of SoCs.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  .../devicetree/bindings/power/qcom,rpmpd.txt       |  1 +
>  include/dt-bindings/power/qcom-rpmpd.h             | 14 ++++++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
> index bc75bf49cdaea..f3bbaa4aef297 100644
> --- a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
> +++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
> @@ -10,6 +10,7 @@ Required Properties:
>  	* qcom,msm8998-rpmpd: RPM Power domain for the msm8998 family of SoC
>  	* qcom,qcs404-rpmpd: RPM Power domain for the qcs404 family of SoC
>  	* qcom,sdm845-rpmhpd: RPMh Power domain for the sdm845 family of SoC
> +	* qcom,sm8150-rpmhpd: RPMh Power domain for the sm8150 family of SoC
>   - #power-domain-cells: number of cells in Power domain specifier
>  	must be 1.
>   - operating-points-v2: Phandle to the OPP table for the Power domain.
> diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
> index f05f8b1808ec9..7d43bafc0026b 100644
> --- a/include/dt-bindings/power/qcom-rpmpd.h
> +++ b/include/dt-bindings/power/qcom-rpmpd.h
> @@ -15,12 +15,26 @@
>  #define SDM845_GFX	7
>  #define SDM845_MSS	8
>  
> +/* SM8150 Power Domain Indexes */
> +#define SM8150_MSS	0
> +#define SM8150_EBI	1
> +#define SM8150_LMX	2
> +#define SM8150_LCX	3
> +#define SM8150_GFX	4
> +#define SM8150_MX	5
> +#define SM8150_MX_AO	6
> +#define SM8150_CX	7
> +#define SM8150_CX_AO	8
> +#define SM8150_MMCX	9
> +#define SM8150_MMCX_AO	10
> +
>  /* SDM845 Power Domain performance levels */
>  #define RPMH_REGULATOR_LEVEL_RETENTION	16
>  #define RPMH_REGULATOR_LEVEL_MIN_SVS	48
>  #define RPMH_REGULATOR_LEVEL_LOW_SVS	64
>  #define RPMH_REGULATOR_LEVEL_SVS	128
>  #define RPMH_REGULATOR_LEVEL_SVS_L1	192
> +#define RPMH_REGULATOR_LEVEL_SVS_L2	224
>  #define RPMH_REGULATOR_LEVEL_NOM	256
>  #define RPMH_REGULATOR_LEVEL_NOM_L1	320
>  #define RPMH_REGULATOR_LEVEL_NOM_L2	336
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
