Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D311C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 17:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF1020731
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 17:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HlJEyMb8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgAFR3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 12:29:17 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34223 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgAFR3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 12:29:16 -0500
Received: by mail-ed1-f68.google.com with SMTP id l8so48086118edw.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 09:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=xILTpET5HvTSzruyix3vfVm6CvfCGp/jihwvwllbC3w=;
        b=HlJEyMb8VUi7sQRbOTe70KWZFvO4offX7v6+PJlsTms05KH/5Zk2AcWBD9QwLXKqGT
         ieSHoimZJohktzModRyY8OAzatcq9yauRfiGnkz32G9Ipx/4A49q5YqcD5aPva03h2Gw
         iG/yDXnl2eWu9nK2nKVrfDj721JJZDwkforMU2Jn8MknDcBd+czSHnh1eS8CymkNkqAV
         r9k3nOJs2+i89oIxZFd9w2Yqh4Va+CZT2PGBQCWYuAyQmw47boYD9S7MyfCSZNt3wfn9
         tcKDGcFrzCrm9o/daxrbRT35fhFe4Ez0ffBC1AeUnDlIeJp8mZKfYprbwwzxEAAyBLh/
         A8Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xILTpET5HvTSzruyix3vfVm6CvfCGp/jihwvwllbC3w=;
        b=otPz21Hp6gLbM2W8f0i6jzYah6lgvzY6nBGBBbziiJ+bCoqBtwQhx+hf8hq4VxggRP
         20+55EDQpMK6mRfEVR2X8lWBo/lkAZarjvHRpXCTlHDbFk71lPU3SQXxceRpGP35m2qf
         gfuzQS+WnHMyTkg/Bss8cJY+btwzLn8hD2XNND7Va4WUzAo50Bw1+TWIZ1340QKS6+/H
         eugSDWHxMgWvKIgpTweHjdMYBaikjb1PD2eMOWxcmcvVf/An3jxyQhovZaSnHAz2UM7c
         SeNAc+FOFIGO+tx1vpsQNjzRDMwh+qAszhMKZLJYAJFM0YZ+Z45Nqg7KFkJPHJ0keEjm
         QO4A==
X-Gm-Message-State: APjAAAV8gy0bwVHFsSXprcT1+G4W2bIdFKeUbUfwRulucy23DFkPBMxT
        lXIirYU7pysIphfYNGWKmBBQjg==
X-Google-Smtp-Source: APXvYqxEzJZM06OUQohBMr1QHRp1MDY9Ku71gw8Iw1kMg/pbAp8k7JloMdp2qZLjR6txq6yNFFdkFQ==
X-Received: by 2002:a17:906:b301:: with SMTP id n1mr108850634ejz.285.1578331754162;
        Mon, 06 Jan 2020 09:29:14 -0800 (PST)
Received: from [192.168.27.135] ([37.157.136.193])
        by smtp.googlemail.com with ESMTPSA id e24sm7403328edy.93.2020.01.06.09.29.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2020 09:29:13 -0800 (PST)
Subject: Re: [V2, 3/3] arm64: dts: sc7180: Add interconnect provider DT nodes
To:     Odelu Kukatla <okukatla@codeaurora.org>, daidavid1@codeaurora.org,
        bjorn.andersson@linaro.org, evgreen@google.com,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     sboyd@kernel.org, ilina@codeaurora.org, seansw@qti.qualcomm.com,
        elder@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org
References: <1577782737-32068-1-git-send-email-okukatla@codeaurora.org>
 <1577782737-32068-4-git-send-email-okukatla@codeaurora.org>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Message-ID: <f144cc82-d4d9-b841-0cdf-41202e11b979@linaro.org>
Date:   Mon, 6 Jan 2020 19:29:11 +0200
MIME-Version: 1.0
In-Reply-To: <1577782737-32068-4-git-send-email-okukatla@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.12.19 г. 10:58 ч., Odelu Kukatla wrote:
> Add the DT nodes for the network-on-chip interconnect buses found
> on sc7180-based platforms.
> ---
>   arch/arm64/boot/dts/qcom/sc7180.dtsi | 96 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 96 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index 3676bfd..077b1e5 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -8,6 +8,7 @@
>   #include <dt-bindings/clock/qcom,gcc-sc7180.h>
>   #include <dt-bindings/clock/qcom,rpmh.h>
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/interconnect/qcom,sc7180.h>

This should be moved one line up if we want to keep the headers sorted.

>   #include <dt-bindings/phy/phy-qcom-qusb2.h>
>   #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>   
> @@ -1286,6 +1287,10 @@
>   				clock-names = "xo";
>   				#clock-cells = <1>;
>   			};
> +
> +			apps_bcm_voter: bcm_voter {
> +				compatible = "qcom,sc7180-bcm-voter";
> +			};
>   		};
>   
>   		cpufreq_hw: cpufreq@18323000 {
> @@ -1298,6 +1303,97 @@
>   
>   			#freq-domain-cells = <1>;
>   		};
> + > +		config_noc: interconnect@1500000 {

All DT nodes in this file are ordered by their address. Please move these up
to keep it consistent.

Thanks,
Georgi
