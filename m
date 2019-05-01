Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB93C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 03:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DF9120866
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 03:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rTsCkA1U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfEADoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 23:44:07 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46935 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfEADoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 23:44:07 -0400
Received: by mail-pl1-f196.google.com with SMTP id bi2so2892692plb.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 20:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=025dxPWxKmwI/dBmRrdG4C63+fVgWqjqwo+ZLtKNyyw=;
        b=rTsCkA1UlAa0fjgvcykfFxaRHBlVq4HLzf+0AOpB0PQr4x4g+FpJj2IJD18yUq6l3i
         ULePD0caC4TBBXoj5oODrZCNBAwFgtOKs/wBH2O9krb5sPs83IRhAZQwa1AYbOJwCAoo
         l+1eAKQNRAEJkospYiGsNJiGDFW6MrdSVb6YHVLTzQVPkYsnqd7YyvY2LxGq53y2lsfJ
         GoA7+YYe8ewT/6sgbX3ChA8HSx5Te2AI8FVfXWDj2vDEEAHNq1PFqEnsv46vxigeom//
         mQ41EaAxkmeKbFDtY0H+UIjaA3MM7Q7zlrH/BEzEXsb3KMcbscRefVr+mq6elB91+TQp
         +4Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=025dxPWxKmwI/dBmRrdG4C63+fVgWqjqwo+ZLtKNyyw=;
        b=Quw/VQoQIfVMPR2PDO/1TCd1fedHKCBzXQ3+vrfZ9YA76vxr/0VnsOluhjfOt7vv8W
         F/y+0eTkWrKsMEOTXW4xO4rvJMhG8+Zuzi4o6wVmI0XxP/WfVMs+wSsRcdlBdm0U1+42
         VDJxrro/ztuomy16YDbZW3j4WztUi8vKSBwEtW7uTysgHuXoGR7AYZP7c/ap8jVaLvbg
         cXY5+R0UPxj5cX45nBQrjpsabKU4gFj/fd4urdxhPfJ+Rw98EXS+PN+sZIY5npVVWAbi
         VeRjfNAgliYugLf22amYj+XhPcD2/a/blikDv3Fo2/jmAtJJ8K0btW01eGzWSBchnKgd
         JBtQ==
X-Gm-Message-State: APjAAAXzdbkAcKAqq1Lx2M9a20eGkWHIZXNluuZfjTQy0Ed+CmYTzLxS
        LAWUKO8He9irHxckdD6rYh7oag==
X-Google-Smtp-Source: APXvYqzLQCo7RS7U18iLNvi0f4WF4MPd5oRVQUcgtOF/CmHYVo3C9Vx1is70i17QsW8aDl8n2g1zQA==
X-Received: by 2002:a17:902:f24:: with SMTP id 33mr67625015ply.44.1556682246445;
        Tue, 30 Apr 2019 20:44:06 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id j22sm23188511pfi.139.2019.04.30.20.44.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Apr 2019 20:44:05 -0700 (PDT)
Date:   Tue, 30 Apr 2019 20:44:06 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     agross@kernel.org, david.brown@linaro.org, marc.w.gonzalez@free.fr,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 6/6] arm64: dts: qcom: msm8998: Add mmcc node
Message-ID: <20190501034406.GF2938@tuxbook-pro>
References: <1556677404-29194-1-git-send-email-jhugo@codeaurora.org>
 <1556677679-29465-1-git-send-email-jhugo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556677679-29465-1-git-send-email-jhugo@codeaurora.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 30 Apr 19:27 PDT 2019, Jeffrey Hugo wrote:

> Add MSM8998 Multimedia Clock Controller DT node.
> 
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

(But same comment as earlier wrt clocks vs clock-names ordering)

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/msm8998.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> index 9c88801..5b63fa2 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> @@ -3,6 +3,7 @@
>  
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/clock/qcom,gcc-msm8998.h>
> +#include <dt-bindings/clock/qcom,mmcc-msm8998.h>
>  #include <dt-bindings/clock/qcom,rpmcc.h>
>  #include <dt-bindings/gpio/gpio.h>
>  
> @@ -1066,6 +1067,19 @@
>  			status = "disabled";
>  		};
>  
> +		mmcc: clock-controller@c8c0000 {
> +			compatible = "qcom,mmcc-msm8998";
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +			#power-domain-cells = <1>;
> +			reg = <0x0c8c0000 0x40000>;
> +
> +			clock-names = "xo",
> +				      "gpll0";
> +			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
> +				 <&gcc GPLL0_OUT_MAIN>;
> +		};
> +
>  		timer@17920000 {
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> -- 
> Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
> Qualcomm Technologies, Inc. is a member of the
> Code Aurora Forum, a Linux Foundation Collaborative Project.
> 
