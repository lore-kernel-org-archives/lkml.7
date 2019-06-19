Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B56BC31E5E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 18:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09B1C214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 18:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E3au49N7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730110AbfFSSWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 14:22:30 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37573 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbfFSSWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 14:22:30 -0400
Received: by mail-pf1-f194.google.com with SMTP id 19so90394pfa.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 11:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a3CSSzDK/AfPhvZqKleGWuu8i4FE7xZqKr9xr1bgsR4=;
        b=E3au49N7pyG8Io5LsggllSx7dglzDxJO/ZYCU/ZSTkVipycqePAt9z+5/9dH+ZrnZ2
         Krlr/654u5Ze421V3VWXqsZPmNeL8bLe+SAZEROt+8KSZm+Nkn8dntnbwFLYPLVnR+lO
         kH0E7SlhlfFUdQ/W3p+WK3k4kPpccPSmKT/4Vxzy41XJLzHf18XGXYvBeRnvFp7JOPej
         x/7WgYM+/FzjjC8n8K1HG4QmVxe7RPEO5/RX/F75WNrD3pyjLcR9Pv4PROpp3Yb4jkWp
         3Nq5EgxniciE3TZoH4FCdBf+jjl8CwZC8op2/RZJnW6SH5ctaAcfZ5qxIlmvJxdNbomv
         ZfGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a3CSSzDK/AfPhvZqKleGWuu8i4FE7xZqKr9xr1bgsR4=;
        b=njjk2kt/YsQKmkYLuhudPGbvMiobpK654xHssHhlk3zLxCYv/feoM0RodQw2ND+BoH
         djIvG19wsiC3yr7RrLJDVolsIaFmGSN4M+DUQHCH3jinVfIj88uWzLSkonujOwjfB6nA
         BhztaBQmFvlHakyvh6wqK6PLDJTYjq1Co54jgqGUrQ9KyisqzumNENJuU0ubYxwf/d21
         mI4q40a0SrcSNK0QunOgPZvMU8Sj2DGP6KNECASfX4jBvMYp8K7uWFum/zIHTxk+GRYI
         TX2hPY2fqtBuyzphejcGdOjon05lqxfWkW0jCB+69ywtyhQ0JdAaKMu+mSa6PRWyeQBu
         B26Q==
X-Gm-Message-State: APjAAAX0Q4BKkYu+QXQRauS6Xeiu2r0Xx5DtMDpK2coOVjjegoCHV2Ad
        WkiBsL8m4umiPgxbsL1EVPx4Ag==
X-Google-Smtp-Source: APXvYqyClqoHUcsBhAU04+uak3wpSqFomnm3WV7QpPGMHHCZMQNt6kymBIn1p6Xcwa/SNOlnvkRkdw==
X-Received: by 2002:a63:6ec1:: with SMTP id j184mr9025604pgc.225.1560968549190;
        Wed, 19 Jun 2019 11:22:29 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id p15sm16736653pgj.61.2019.06.19.11.22.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 11:22:28 -0700 (PDT)
Date:   Wed, 19 Jun 2019 11:22:26 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc:     agross@kernel.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jeffrey.l.hugo@gmail.com, niklas.cassel@linaro.org
Subject: Re: [PATCH] arm64: dts: qcom: qcs404-evb: fix vdd_apc supply
Message-ID: <20190619182226.GK4814@minitux>
References: <20190619181653.29407-1-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619181653.29407-1-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 19 Jun 11:16 PDT 2019, Jorge Ramirez-Ortiz wrote:

> The invalid definition in the supply causes the Qualcomm's EVB-1000
> and EVB-4000 not to boot.
> 
> Fix the boot issue by correctly defining the supply: vdd_s3 (namely
> "vdd_apc") is actually connected to vph_pwr.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Reported-by: Niklas Cassel <niklas.cassel@linaro.org>
> Tested-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/qcs404-evb.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> index b6092a742675..11c0a7137823 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> @@ -65,7 +65,7 @@
>  };
>  
>  &pms405_spmi_regulators {
> -	vdd_s3-supply = <&pms405_s3>;
> +	vdd_s3-supply = <&vph_pwr>;
>  
>  	pms405_s3: s3 {
>  		regulator-always-on;
> -- 
> 2.21.0
> 
