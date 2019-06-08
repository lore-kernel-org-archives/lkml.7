Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256F0C468BC
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 03:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F35EC20833
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 03:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zbm4x2IQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731561AbfFHDvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 23:51:07 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43649 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731570AbfFHDvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 23:51:06 -0400
Received: by mail-pg1-f193.google.com with SMTP id f25so2127594pgv.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 20:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IzVl5hZC8i4hei2lB4B7NGvZFOFsdZTFEiwkTZdNcbI=;
        b=zbm4x2IQkkYxrWv2IeE0ppaapAoezEstTyL/waMvEJf48eUcGb66KQkuRDgP0rCjmg
         7l5drrzOpjDnXq2S6r1kqEeRKF3JED1OfwZDuCi8Uxejc1mRxsPvSadhDPfJWkeL2C9i
         iywuh9w4eNWS3i0i2GHUU1xWuGF1bHV4Xwicm/fq8jsKbfb55r5Hbe6vCtojoae7sN6Q
         KSDdoYBO5GgiuaN/Fec0DXMB4wHwxoRGSLQrIfZj605T9U04WO+oeuyuS+SNIplKFvge
         SKmROS12EnVu8egM+TlTg5JOtdYsdQRNZnqFIp4Ox1r4xHyLbC+VEwECjNDTXmwfOj5q
         BfyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IzVl5hZC8i4hei2lB4B7NGvZFOFsdZTFEiwkTZdNcbI=;
        b=q+xDed/Bqer2bm/+cCIzalutuihCrgyHhn6uzOsu79TJudX9eaTqkrBFomBZcFiNeh
         3XkmvpP81Y77pRqnf9vKF3xLy9ziVSivT+wbzGKevcAt9iuP357vGd2jAKFg/D8shZtb
         QYswFFEGNjKW5G07u2hI6yxiztId40sxitpHiPX/PaTCTcmkOZiF6MgpBnphVKLEytIW
         fsxEU6rREmVLLtyYf59sYUG0wcnt63Ukk4dns9B1sMYXrTKPgXVAq+iQ4znRI7qcx7/W
         U2zJ0dxlL4/sNBWVmskgu53LcoBzjWkMot1vpi0ScLmqAE6owafUfuHdAGL5sAuVXMAW
         T5EA==
X-Gm-Message-State: APjAAAU8jaPMElLKjQk1q1E1GRCTMdVgy0b38MFDfLGCAp6sKPXVt7Qb
        ZITarosIIVqltFymWYl/5topiw==
X-Google-Smtp-Source: APXvYqzv3Wi+b5fl0fYtshM8YZCs9iIWMwg5/dCaLo03hUwNyJHjJ6/OEMKN/nVc0NV5ckcKb0L1pw==
X-Received: by 2002:a62:1b0c:: with SMTP id b12mr60478869pfb.230.1559965845025;
        Fri, 07 Jun 2019 20:50:45 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id m19sm7622094pff.153.2019.06.07.20.50.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 20:50:44 -0700 (PDT)
Date:   Fri, 7 Jun 2019 20:50:42 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, amit.kucheria@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: msm8996: fix PSCI entry-latency-us
Message-ID: <20190608035042.GI24059@builder>
References: <20190604122931.22235-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604122931.22235-1-niklas.cassel@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 04 Jun 05:29 PDT 2019, Niklas Cassel wrote:

> The current entry-latency-us is too short.
> The proper way to convert between the device tree properties
> from the vendor tree to the upstream PSCI device tree properties is:
> 
> entry-latency-us = qcom,time-overhead - qcom,latency-us
> 
> which gives
> 
> entry-latency-us = 210 - 80 = 130
> 
> Fixes: f6aee7af59b6 ("arm64: dts: qcom: msm8996: Add PSCI cpuidle low power states")
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>

Thanks Niklas

Applied,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index b7cf2a17dcb5..e8c03b5c8990 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -174,7 +174,7 @@
>  				compatible = "arm,idle-state";
>  				idle-state-name = "standalone-power-collapse";
>  				arm,psci-suspend-param = <0x00000004>;
> -				entry-latency-us = <40>;
> +				entry-latency-us = <130>;
>  				exit-latency-us = <80>;
>  				min-residency-us = <300>;
>  			};
> -- 
> 2.21.0
> 
