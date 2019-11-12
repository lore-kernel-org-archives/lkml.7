Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787E3C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 19:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49C162196E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 19:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vCbC4L4b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfKLTnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 14:43:55 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39700 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbfKLTny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 14:43:54 -0500
Received: by mail-pf1-f193.google.com with SMTP id x28so14072132pfo.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 11:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HPem8TIIszZ7FemqTmbnyMN0h8Slh11f2S1uwgjMiNs=;
        b=vCbC4L4b7VLJUVxMLdfu7tTiF+7v9bVwa2ILlKu9Fn4M2fXbwAWOJQgS8FoCOPusVZ
         xVC8bQFTXjujcVkJ9se5vr3widjEEvQwNYG8F2b2EBg5AIUw5+fOPgQG++A4VYLRozqo
         I0TRQVo5VgAsRL9UbLXgDoqWci22cl/Fm+fUjNAZ9g9Y6OdwiN6UPJc9iIpL2aV2P87j
         T0tnEhvI9d35ls+XXBtg5NXJFPTbZJwuODyzDhudMtEvx88qzrv6yg3uZzXtJSK5iX6w
         cPzhimTCv0pRwbAC7M+ErI0dUXGxv2qaOkloyNOT2SnYtiU/o5XmDPQkyfepeLZrvV/G
         ESpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HPem8TIIszZ7FemqTmbnyMN0h8Slh11f2S1uwgjMiNs=;
        b=cZRF2YOqTO9hiu7USwSXo9be0lfmOL/OT68v8Kh2qdE6beKqHHkejzsTcd7eOwUDOK
         ci8gWqh1ROa367P2dgNulFjoYBl35JGr2J3/XJNifpmzDWVHJGxOujvfoMDV+fyBYN7W
         3/Cv8aYgb7irPd6YQSG3usMBlJ6kHhzgrbebqeX5ylmvQy0k61sgLOb5dPIxFskYdZlR
         Az4WxLbzeKR6yUrFE3P5tJZjUyba26vUjeGADUozGfnI1nIIWIPaBrUeKmwFVOqRgUQl
         pZYsb+JcnPEA9JhITlvEhq0NyD8jZdes0Tu1mdDmAocexEBsGC2VL2qY2sfkniHhECpF
         Hi1w==
X-Gm-Message-State: APjAAAU0gxJWmfSe8Yj9znEOZF7IHpISeJjbKA2ElHY6psUDfXEaGodN
        55AKmzwaWgDCU/G+JYbcOI/zmg==
X-Google-Smtp-Source: APXvYqwvp01l6+NWe5Q3aOH506LuFAZx7SlH82bO5pfIp1D3hOIxDJgrjOioGwThFhLK0fe655HllA==
X-Received: by 2002:aa7:96bd:: with SMTP id g29mr39160759pfk.28.1573587834096;
        Tue, 12 Nov 2019 11:43:54 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z18sm19047098pgv.90.2019.11.12.11.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 11:43:53 -0800 (PST)
Date:   Tue, 12 Nov 2019 11:43:51 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        edubezval@gmail.com, swboyd@chromium.org, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: sdm845: thermal: Add critical interrupt
 support
Message-ID: <20191112194351.GD3140946@builder>
References: <cover.1573499020.git.amit.kucheria@linaro.org>
 <c536e9cdb448bbad3441f6580fa57f1f921fb580.1573499020.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c536e9cdb448bbad3441f6580fa57f1f921fb580.1573499020.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 11 Nov 11:21 PST 2019, Amit Kucheria wrote:

> Register critical interrupts for each of the two tsens controllers
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Message-Id: <3686bd40c99692feb955e936b608b080e2cb1826.1568624011.git.amit.kucheria@linaro.org>

Picked up for v5.6.

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 0990d5761860..3b643b04ab5a 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -2950,8 +2950,9 @@
>  			reg = <0 0x0c263000 0 0x1ff>, /* TM */
>  			      <0 0x0c222000 0 0x1ff>; /* SROT */
>  			#qcom,sensors = <13>;
> -			interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>;
> -			interrupt-names = "uplow";
> +			interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 508 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "uplow", "critical";
>  			#thermal-sensor-cells = <1>;
>  		};
>  
> @@ -2960,8 +2961,9 @@
>  			reg = <0 0x0c265000 0 0x1ff>, /* TM */
>  			      <0 0x0c223000 0 0x1ff>; /* SROT */
>  			#qcom,sensors = <8>;
> -			interrupts = <GIC_SPI 507 IRQ_TYPE_LEVEL_HIGH>;
> -			interrupt-names = "uplow";
> +			interrupts = <GIC_SPI 507 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 509 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "uplow", "critical";
>  			#thermal-sensor-cells = <1>;
>  		};
>  
> -- 
> 2.17.1
> 
