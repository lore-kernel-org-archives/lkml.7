Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5077C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 05:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C3422460
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 05:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="et/J9lmp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfKTFRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 00:17:01 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42854 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfKTFRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 00:17:01 -0500
Received: by mail-pf1-f195.google.com with SMTP id s5so13604944pfh.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 21:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7uNFuGTkHht4kVlmGTndg0AtCQQACOHGMMX+d3QoKic=;
        b=et/J9lmplBBlik2YCaRAp6TG8tH6vVIbWesmrAQ3Aohv3+V3X3VNz6wbtquVLnw2Ly
         c4bIvqpXikhgKLXp/0sVXvheUmBT1PeO3JCszhUOQpv50PFwZ90tDOY6wDnA1KKQNyPb
         IdjfrXc4b0PtcFQdUpAVDaT9DKmNM89f/uJsGvcLxK57Yc2+f/JBlTpwce3F1cdFRPLX
         nfGqmJ/QP3NiwovChHCNcx+TOdfHgCC9qoN/z994JUX932xkcO8HjcKOUEm92tYoU43m
         0kSRxk93EqAZQ3T5zBVxNNL8euORnzsg9hFWfQOVSYpe0jMVaHikzyg+ev3abv/RPk+8
         3ZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7uNFuGTkHht4kVlmGTndg0AtCQQACOHGMMX+d3QoKic=;
        b=IClfLFCidoHXHOR2OZ4SXSKjU/e/7O0h9WebHfsKWC+IRm0F/P19xzFIoRWRH0PjNK
         Vrv7kl/7CMfNHWqlXw/3/3JLZz8wlqPCQAdQiMovcDSeBccZe/HESZMOO6HDaYn6kCp3
         WFe4nkWPjxazEMxbwTakVManFXL8i4A9cYtmBhFuF6HkBC/FLjDJ98u7TNJymmqxlG+X
         iuV8KJ+WDpry9vLitI8IVAXtGDXH42mpR+lbuL6CQDIuexSYDVm4ELx8rWLY/52TceLY
         uGgp0evmoEZSKOaFpXef7TNl2EVqe9ELtTeM+QxkIaK+14/9qdwbpqXbtWTrcp6GnLTD
         PnSg==
X-Gm-Message-State: APjAAAUJ/7saAzI/gtfU5RS/3nHeSvRMxu12wn5Tqwlywt9pX1IzY1Jm
        RJy2JP0dQHc2aSHtCGGncEB90g==
X-Google-Smtp-Source: APXvYqyzRYmVnEKGm1r5WusT49tJmRjBJ7jzvN2oRZS+WXGVi9Kc9Yyv6xriF+KNAjdw9bjEEjGvlw==
X-Received: by 2002:a63:d642:: with SMTP id d2mr1014621pgj.205.1574227019574;
        Tue, 19 Nov 2019 21:16:59 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id f31sm5451979pjg.31.2019.11.19.21.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 21:16:58 -0800 (PST)
Date:   Tue, 19 Nov 2019 21:16:56 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        amit.kucheria@linaro.org, sboyd@kernel.org, vireshk@kernel.org,
        ulf.hansson@linaro.org, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 5/5] arm64: defconfig: enable
 CONFIG_ARM_QCOM_CPUFREQ_NVMEM
Message-ID: <20191120051656.GU18024@yoga>
References: <20191119154621.55341-1-niklas.cassel@linaro.org>
 <20191119154621.55341-6-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119154621.55341-6-niklas.cassel@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 19 Nov 07:46 PST 2019, Niklas Cassel wrote:

> Enable CONFIG_ARM_QCOM_CPUFREQ_NVMEM.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 4385033c0a34..09aaffd473a0 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -88,6 +88,7 @@ CONFIG_ACPI_CPPC_CPUFREQ=m
>  CONFIG_ARM_ARMADA_37XX_CPUFREQ=y
>  CONFIG_ARM_SCPI_CPUFREQ=y
>  CONFIG_ARM_IMX_CPUFREQ_DT=m
> +CONFIG_ARM_QCOM_CPUFREQ_NVMEM=y
>  CONFIG_ARM_QCOM_CPUFREQ_HW=y
>  CONFIG_ARM_RASPBERRYPI_CPUFREQ=m
>  CONFIG_ARM_TEGRA186_CPUFREQ=y
> -- 
> 2.23.0
> 
