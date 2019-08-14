Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E749C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43F77214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cECcwQ7p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbfHNSAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:00:52 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35036 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728841AbfHNSAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:00:51 -0400
Received: by mail-pf1-f194.google.com with SMTP id d85so3532609pfd.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 11:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fJ9cwj5PrHv4tRSMH6SQvLLbwv7CS8HXTftOWfJo5YU=;
        b=cECcwQ7pw8ag3svApom/3ETlM1wknpk5ILygrzGn1QU4bu/wsXI6CsZTBQ73V5pcq0
         hXnqCylY/c5iFgimVmuUzZM+oxtdeRMf5TF/wOdu6A1kvOEYnyeE+01vSTVm4zSMihXs
         dOnbA/MsU6qsOfN4jSNA1g041BjYGzwr45XH8ZYGhbgHoTpoLoIJvDu+eH4CKDQtRDif
         Xy8xa4yYdsnUQfh1/WWJPu2ImOFr0aFF33yxzD6S2TiL4inlGcSGfNuGxOlQnPdPU1vg
         jV3EmAmQCrmzlIet4ld2gJMgLo6m3DvCFpRneuCBvOV1wloKmsjcsrwY0n3xmKMvqWuF
         8KFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fJ9cwj5PrHv4tRSMH6SQvLLbwv7CS8HXTftOWfJo5YU=;
        b=UJTKzPhBJq4VAY6k+l6D16t23HNFsmlwmYc2iC16hpEz5nz3TrVTyM0SkZeU8g/zIO
         KIl+9r1cSWSVn33pS5ebU6nZcjf3gUIKViz9CJMAhIP2c5n+5UijkfFM6ORR+QFcNYQb
         4fZQdHV1ZC+D2Pcz+I2aUNR94JxjCXqNH3nsT17X+aTc4XBAv7OloqWVYX+R9fOgEamz
         +6xRIKERMPKYrkWYOPZKcErXkHFLHPEpJfjX3jipxYs8Udp/LV32Vy4O97osoIleylIb
         TAgyYTtR2SC57N0UWE6983x/vGIUrD8uglKRlXubYVvF5lec5K9v5lBqZGedBwW0fwht
         UFfQ==
X-Gm-Message-State: APjAAAWRaP+myfNWOKWFvn7OV6UYN3yjaHg/FZ3rxmYf1I6XWt5rEiOT
        FcEZWIsAkZGg1GTy5E9tmFMzKOHE3Ro=
X-Google-Smtp-Source: APXvYqzrakKid7QIIFOdnyxXZVtpIxlsGPaEU5w1zmjCc5Hh5N86JWWqrhekwsDpNQnJ1x5HdupD0w==
X-Received: by 2002:a17:90a:858c:: with SMTP id m12mr870111pjn.129.1565805650121;
        Wed, 14 Aug 2019 11:00:50 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id a6sm694379pjv.30.2019.08.14.11.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 11:00:49 -0700 (PDT)
Date:   Wed, 14 Aug 2019 11:00:47 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        sibis@codeaurora.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/22] arm64: dts: qcom: pm8150b: Add pon and adc nodes
Message-ID: <20190814180047.GH6167@minitux>
References: <20190814125012.8700-1-vkoul@kernel.org>
 <20190814125012.8700-11-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814125012.8700-11-vkoul@kernel.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 14 Aug 05:50 PDT 2019, Vinod Koul wrote:

> Add the pon and adc nodes found in pm8150b PMIC.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  arch/arm64/boot/dts/qcom/pm8150b.dtsi | 54 +++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pm8150b.dtsi b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
> index c0a678b0f159..846197bd65cd 100644
> --- a/arch/arm64/boot/dts/qcom/pm8150b.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
> @@ -2,6 +2,7 @@
>  // Copyright (c) 2017-2019, The Linux Foundation. All rights reserved.
>  // Copyright (c) 2019, Linaro Limited
>  
> +#include <dt-bindings/iio/qcom,spmi-vadc.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/spmi/spmi.h>
>  
> @@ -11,6 +12,59 @@
>  		reg = <0x2 SPMI_USID>;
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> +
> +		pon@800 {
> +			compatible = "qcom,pm8916-pon";
> +			reg = <0x0800>;
> +		};
> +
> +		adc@3100 {
> +			compatible = "qcom,spmi-adc5";
> +			reg = <0x3100>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			#io-channel-cells = <1>;
> +			interrupts = <0x2 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
> +
> +			ref-gnd@0 {
> +				reg = <ADC5_REF_GND>;
> +				qcom,pre-scaling = <1 1>;
> +				label = "ref_gnd";
> +			};
> +
> +			vref-1p25@1 {
> +				reg = <ADC5_1P25VREF>;
> +				qcom,pre-scaling = <1 1>;
> +				label = "vref_1p25";
> +			};
> +
> +			die-temp@6 {
> +				reg = <ADC5_DIE_TEMP>;
> +				qcom,pre-scaling = <1 1>;
> +				label = "die_temp";
> +			};
> +
> +			chg-temp@9 {
> +				reg = <ADC5_CHG_TEMP>;
> +				qcom,pre-scaling = <1 1>;
> +				label = "chg_temp";
> +			};
> +

I believe the above items are internal, so it makes sense to keep them
here, the below amux ones relates to board configuration so I think
those should go in the board file.

Regards,
Bjorn

> +			smb1390-therm@14 {
> +				reg = <ADC5_AMUX_THM2>;
> +				qcom,hw-settle-time = <200>;
> +				qcom,pre-scaling = <1 1>;
> +				label = "smb1390_therm";
> +			};
> +
> +			smb1355-therm@78 {
> +				reg = <ADC5_AMUX_THM2_100K_PU>;
> +				qcom,ratiometric;
> +				qcom,hw-settle-time = <200>;
> +				qcom,pre-scaling = <1 1>;
> +				label = "smb1355_therm";
> +			};
> +		};
>  	};
>  
>  	qcom,pm8150@3 {
> -- 
> 2.20.1
> 
