Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F819C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 23:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3225E2075B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 23:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y86THFYY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfFEXQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 19:16:11 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34367 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbfFEXQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 19:16:11 -0400
Received: by mail-pf1-f194.google.com with SMTP id c85so260488pfc.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 16:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=83uaEygo28oePM8F3N5NKuuyzBb7fPbGLBzqyFLAQQA=;
        b=y86THFYYFuCwg4NjgtAt7q46z+gYvfpS6JqQFp2TWNQo+PZyW2UuCmgfYs5ihF7zsV
         XumG9iIAEVLK8uyQS3mak0JKMY1b+ReeQfrKxAmqp22LDWu3HffTgFEiYsvFl7qalEFB
         arlU6GJSju0p8Q1UH6cfZbyy5D62Wv10AChwbI1AaZ5GaGOCgHYdqsa3X30OAgKJG58s
         6JALkoJuHNPpb2z9+j7A+1zNGbPGpiODmwm/iohB98CcqGrtJytsgbA/azm2orw4oGLZ
         IwGC80IxpqcR3MrG1W+XPElhPBNJ6TFFKPlNKhhJRGrYkuSHAZrdeW4H1J6o62wMhLLl
         HWmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=83uaEygo28oePM8F3N5NKuuyzBb7fPbGLBzqyFLAQQA=;
        b=q9M21/d2RgKosUmZ0oQV6RMuWP77pjNbGF7LKBFq+/9Zwrhp0vLm64zs7SITNa9L15
         g/x1NxKztdz8xtbQ2NDkIu4EJ9fcsHXY9vaXIpZSkD9QVg9E1ZGcyhN64qSWc5iYki/7
         Mg/C3p1ZL+io6g5igwfbprzLiVAb1J996csT8Y2koIGY4djd2fWiz++HMRCZCdBFqeZt
         10CTHDPJCLPglGRrcV6C4iVJzssORc3/02n2AEndgAo1xWmaReVAE3Gt1oAhZTMKWx2e
         XPyXS5EKkU1Acbm2qFNsDiHBY5iJDCtPWwELd5wzaE0JWdMKfAZofjUjnsUitrSdJvGq
         c4hA==
X-Gm-Message-State: APjAAAXNdceLd2BfyTZLQWZQTi4abG9MlKhdzRumFba/4dQD5evwOQ3R
        d3vUHQFr0dbe0EbOUINw6sNSZA==
X-Google-Smtp-Source: APXvYqyrieihJjw0LyM7b9fHrzgoFMOxImgwdOC+BxMvC1MGA+JrHx/r56FAICY9eUBKenRtbDPxJg==
X-Received: by 2002:a62:e417:: with SMTP id r23mr18453641pfh.160.1559776570125;
        Wed, 05 Jun 2019 16:16:10 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v4sm48956pff.45.2019.06.05.16.16.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 16:16:09 -0700 (PDT)
Date:   Wed, 5 Jun 2019 16:16:07 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3 v2] arm64: dts: qcom: pm8998: Use qcom,pm8998-pon
 binding for second gen pon
Message-ID: <20190605231607.GL4814@minitux>
References: <20190603222319.62842-1-john.stultz@linaro.org>
 <20190603222319.62842-3-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603222319.62842-3-john.stultz@linaro.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 03 Jun 15:23 PDT 2019, John Stultz wrote:

> This changes pm8998 to use the new qcom,pm8998-pon compatible
> string for the pon in order to support the gen2 pon
> functionality properly.
> 
> Cc: Andy Gross <agross@kernel.org>
> Cc: David Brown <david.brown@linaro.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Amit Pundir <amit.pundir@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: devicetree@vger.kernel.org

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/pm8998.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> index d3ca35a940fb6..051a52df80f9e 100644
> --- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> @@ -39,7 +39,7 @@
>  		#size-cells = <0>;
>  
>  		pm8998_pon: pon@800 {
> -			compatible = "qcom,pm8916-pon";
> +			compatible = "qcom,pm8998-pon";
>  
>  			reg = <0x800>;
>  			mode-bootloader = <0x2>;
> -- 
> 2.17.1
> 
