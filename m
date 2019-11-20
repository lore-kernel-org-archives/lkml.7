Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771ACC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 02:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C99A2240D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 02:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RiVZiAc8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbfKTCcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 21:32:01 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44344 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbfKTCcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 21:32:00 -0500
Received: by mail-pl1-f195.google.com with SMTP id az9so13041563plb.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 18:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zQQ14kvSunH3qSKyw22D8nEYxTv+dx8y8WFEQ+ihPdg=;
        b=RiVZiAc8aD5Xr9TbDx+kUjWZpRMwP/JWqFpdvELJwVTQGhlDjUYxk1dDvhOEANTBJh
         r332TDbC+W8hBRuWmoqmlRLoxczReZzlD/d0LI3hqji6UegQlchBkwekp5U60vqohudB
         kzpj3tR8HTzB9JgjWLBIPXqS36ukdsI5e+6rCndr9sFp1OX6hzyBWEHfPruj+6qO2lp6
         1RIkuPR1cFBkSp98pQyUDniE4FtdZfwlKU1uy1yhvEnuMczTfIlYZdfhbZxj/HhMc16M
         pmH+5cVyNZ1+9uHIrMPxQBdoZqEA19zOaeSvQMlM+G2NODVpncOBaJPBFKvwa1YhXfAQ
         I6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zQQ14kvSunH3qSKyw22D8nEYxTv+dx8y8WFEQ+ihPdg=;
        b=p3LSlTTeOipUSqzMoX1+CeFTXpjvQYjmAo+ToeN/MkuieC+Vhc0q1F9GKKYE4y0Crz
         Z2q5c0FVI23/yjFexPAuqv1bAN6jEGjNpmFKifo88845PxF6j9bzBrST/RrYqHHCHuN+
         o0/nNBkeT731YvC1XN5vOL9Y2FMEBcufuiZrQwY9qN1H/OxrwyV7Y9Ri6LqYRn/CECuY
         1EHluQ6wFva9rzXE7qSlUxzpLf970gsTBRg3n0x4sI2fdhL/M9RN2InVThc9p5BTvglP
         +U8F0z10wOCO2voFt8J5GGCFK220J0qQMtTsbn7WMkoBqlVj5FDZNe4Tqlz1ej4r5BJs
         05zA==
X-Gm-Message-State: APjAAAWikQ5uEesg1RD37huEnHCTye7UmRUXWWMuD+gVB9s7JQY47x1K
        DzM4jrS9768xRCfleeLqfRUvWA==
X-Google-Smtp-Source: APXvYqyqU7IKNWZwMx/vtmP3W3w1KoQMHOCMpSVNlsHnz76K3zwK6DbOhT7AQ/Mt484GpUFb1VenVg==
X-Received: by 2002:a17:902:4a:: with SMTP id 68mr474689pla.8.1574217118372;
        Tue, 19 Nov 2019 18:31:58 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x190sm28654798pfc.89.2019.11.19.18.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 18:31:57 -0800 (PST)
Date:   Tue, 19 Nov 2019 18:31:55 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     robh+dt@kernel.org, ulf.hansson@linaro.org, rnayak@codeaurora.org,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        mark.rutland@arm.com, swboyd@chromium.org, dianders@chromium.org
Subject: Re: [PATCH 4/6] dt-bindings: power: Add rpmh power-domain bindings
 for sc7180
Message-ID: <20191120023155.GM18024@yoga>
References: <20191118173944.27043-1-sibis@codeaurora.org>
 <0101016e7f99ca6c-a46ce88b-3c42-4222-8873-6cf0843b106f-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0101016e7f99ca6c-a46ce88b-3c42-4222-8873-6cf0843b106f-000000@us-west-2.amazonses.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 18 Nov 09:40 PST 2019, Sibi Sankar wrote:

> Add RPMH power-domain bindings for the SC7180 family of SoCs.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/power/qcom,rpmpd.txt |  1 +
>  include/dt-bindings/power/qcom-rpmpd.h                 | 10 ++++++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
> index f3bbaa4aef297..6346d00b1b400 100644
> --- a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
> +++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
> @@ -9,6 +9,7 @@ Required Properties:
>  	* qcom,msm8996-rpmpd: RPM Power domain for the msm8996 family of SoC
>  	* qcom,msm8998-rpmpd: RPM Power domain for the msm8998 family of SoC
>  	* qcom,qcs404-rpmpd: RPM Power domain for the qcs404 family of SoC
> +	* qcom,sc7180-rpmhpd: RPMh Power domain for the sc7180 family of SoC
>  	* qcom,sdm845-rpmhpd: RPMh Power domain for the sdm845 family of SoC
>  	* qcom,sm8150-rpmhpd: RPMh Power domain for the sm8150 family of SoC
>   - #power-domain-cells: number of cells in Power domain specifier
> diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
> index 7d43bafc0026b..3f74096d5a7ca 100644
> --- a/include/dt-bindings/power/qcom-rpmpd.h
> +++ b/include/dt-bindings/power/qcom-rpmpd.h
> @@ -28,6 +28,16 @@
>  #define SM8150_MMCX	9
>  #define SM8150_MMCX_AO	10
>  
> +/* SC7180 Power Domain Indexes */
> +#define SC7180_CX	0
> +#define SC7180_CX_AO	1
> +#define SC7180_GFX	2
> +#define SC7180_MX	3
> +#define SC7180_MX_AO	4
> +#define SC7180_LMX	5
> +#define SC7180_LCX	6
> +#define SC7180_MSS	7
> +
>  /* SDM845 Power Domain performance levels */
>  #define RPMH_REGULATOR_LEVEL_RETENTION	16
>  #define RPMH_REGULATOR_LEVEL_MIN_SVS	48
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
