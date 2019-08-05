Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A2AC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 22:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C0D120665
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 22:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ADhAmScp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730917AbfHEW0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 18:26:32 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33642 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728922AbfHEW0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 18:26:32 -0400
Received: by mail-pf1-f196.google.com with SMTP id g2so40349878pfq.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 15:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Rg+oeCwUo/H+oN9H7Czh/5Y4i017SsaPztYn9tG5d2Y=;
        b=ADhAmScpEWlovyJVTyLKzuJz7F5Qrq+05RPL+6N4C4JRJ7fOnPN2zbO7DvvQffhW8t
         5qCOWU2XnFCFiC8n5RMcwqomSreqCMq1Gd2WwapvE6fGGByk3q1c/RjssbFirWe47w3t
         rcsghBXRcnVkLDfhKqTREFm1Xgn01kZZHslN8gOWp9twHwe8fk3fZUehesVIe2MWHtQs
         qi43lT+ENVcIfYraXarMf3sHx//4IEgUiEhzwUuK7wdnLbbCJJvoILbsRb2y4m+iFGTY
         Hx12ZTXyS/cOmpcxo1o/nZidvq+YrehQDR/opapH7e94CZ6hEodbKqes5cLvviEL1CNE
         LlMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rg+oeCwUo/H+oN9H7Czh/5Y4i017SsaPztYn9tG5d2Y=;
        b=KwJRWZRz6cVYuYKbn/Wnaqx3IzboFR8trc7xH3Q6iumoqS2xVoOWbumMX6ZN6CjSOE
         Vkj5MbPlM9mTFX+aHK6TOJyPtCBxNe+5nzrNR60E07I2gicib/kYPB0tQaljaT2rDoCW
         Unf9jQb5vfbEcMHFoeAn5wucSbE+PdkSXeHp9N7VCgwZOQ2QgmY3x0RXLpSFcagPZ6Jg
         kMsifvCXBRwI758H2ommE9bBXY9eaPkULg9LXwb39zLDBwSj0Xjd66ZXPEJ8+A/QVWHn
         rtVUuykpTodrl2irSMI2ygNj1ZSw3QX1gM7CyyoXoE1sbGLWbvm8MYccDGyW+MfI/5js
         ApIw==
X-Gm-Message-State: APjAAAWiLjbvqSwjAh+WPHj1nqFW38nd8PHd4CGLnGEg8p+GAWandK7V
        rK8KqAoEW7mov983+Z9qAQABxQ==
X-Google-Smtp-Source: APXvYqzc51XuCht++M4ETl3qnE2tsM6OOV5lrOa8+FmdxOB6VKu1S1xAEQXEr6+Qn0fnjFDRK43mvA==
X-Received: by 2002:a65:65c5:: with SMTP id y5mr140011pgv.342.1565043990719;
        Mon, 05 Aug 2019 15:26:30 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id u6sm17486631pjx.23.2019.08.05.15.26.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Aug 2019 15:26:29 -0700 (PDT)
Date:   Mon, 5 Aug 2019 15:26:27 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     agross@kernel.org, robh+dt@kernel.org, will.deacon@arm.com,
        robin.murphy@arm.com, joro@8bytes.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        david.brown@linaro.org
Subject: Re: [PATCH v3 4/4] arm64: dts/sdm845: Enable FW implemented safe
 sequence handler on MTP
Message-ID: <20190805222627.GA2634@builder>
References: <20190612071554.13573-1-vivek.gautam@codeaurora.org>
 <20190612071554.13573-5-vivek.gautam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612071554.13573-5-vivek.gautam@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 12 Jun 00:15 PDT 2019, Vivek Gautam wrote:

> Indicate on MTP SDM845 that firmware implements handler to
> TLB invalidate erratum SCM call where SAFE sequence is toggled
> to achieve optimum performance on real-time clients, such as
> display and camera.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 78ec373a2b18..6a73d9744a71 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -2368,6 +2368,7 @@
>  			compatible = "qcom,sdm845-smmu-500", "arm,mmu-500";
>  			reg = <0 0x15000000 0 0x80000>;
>  			#iommu-cells = <2>;
> +			qcom,smmu-500-fw-impl-safe-errata;

Looked back at this series and started to wonder if there there is a
case where this should not be set? I mean we're after all adding this to
the top 845 dtsi...

How about making it the default in the driver and opt out of the errata
once there is a need?

Regards,
Bjorn

>  			#global-interrupts = <1>;
>  			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
