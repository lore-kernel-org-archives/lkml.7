Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D3FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B65242087C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hY3X6Atp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfCNGXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 02:23:17 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34156 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbfCNGXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 02:23:17 -0400
Received: by mail-pg1-f194.google.com with SMTP id v12so3317401pgq.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 23:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4UEwZcRZKefxbRs0SQ2I3FGnnDB9jYMdr+0cEMlgH4I=;
        b=hY3X6Atpmb1fXtpUhDpD/kVAiIPwqL0g6w9L358qUo9NCFNRQEKZgUrRTTxNbChYyE
         iui25Vf9hh2ldcr5mmEda0BLJWSTqxqHeQtrSluQ3n1+R7uZlzPoPdbbLOCnS/DuVGxR
         hxVY5iHklt+mRZ80T5YAsQqhCMeC9DUfK8Az6b9X1ng7wYZipFUXK8NeWCtCeZA1DP28
         llbOB5vC4johOZfb9/UhtOrHkODuzr5tEMwQrIiuHtRnnHA4z5fsysYFd1+HiEsJu2RM
         D/ktzwu67icChDpOpn6H9PEclzVBPamyD/PL1yhz50MwzNpF9+PzxSD0YrsYMMWkaTYt
         P+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4UEwZcRZKefxbRs0SQ2I3FGnnDB9jYMdr+0cEMlgH4I=;
        b=BETyNeR33FU83aTGdiURnfM+/DdLkRwEHVyITB3DGOn26Vl/1R+K1xASucTTlZoBs4
         Qeah3EYGxj9/mAINXWN9C895zg6/2sbKzKiGoVq9ebO/2orpz1z2p9zMhtVBBm4HIjWV
         kZKvWVyp7zR/Nec6oJt3W3zOcazl8uYdrVcEyjLVxVatimSUv1xCw6fBNFjU6KYhRUyM
         lo+xrRggLxLLAjIPf3+nrkpHZT1ubWa4+7DPaY9Wm/vMnoFR1wiJxNxik9FZdDNVjJld
         y2SeLQFG9DxVL5gcguRGdk5b/FG4uZW7S4SdLNc/7T9fSZ7DM7l1Ei5IGPq48NRZvvzl
         xmYg==
X-Gm-Message-State: APjAAAVrrBaQREcarw3oec2GIMeRj9E7JZpwKHlwfJ+tx6+E37Ycg42N
        DhtTiao48X8VE1EW6ykbI0NTCw==
X-Google-Smtp-Source: APXvYqw8UxJn6pohHptAOi01f+GN1faHFmcDfVAxKSX3Wd1jTTBHNOtMTV1kXkAKQz5LDaBewSl5yA==
X-Received: by 2002:a63:2bd5:: with SMTP id r204mr44224702pgr.48.1552544596378;
        Wed, 13 Mar 2019 23:23:16 -0700 (PDT)
Received: from localhost ([122.166.134.37])
        by smtp.gmail.com with ESMTPSA id d23sm19660577pfn.69.2019.03.13.23.23.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 23:23:14 -0700 (PDT)
Date:   Thu, 14 Mar 2019 11:53:12 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     vireshk@kernel.org, sboyd@kernel.org, nm@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net,
        jcrouse@codeaurora.org, vincent.guittot@linaro.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, sibis@codeaurora.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: opp: Introduce opp-bw-MBs bindings
Message-ID: <20190314062312.vwyu3ryeyc6iv55h@vireshk-i7>
References: <20190313090010.20534-1-georgi.djakov@linaro.org>
 <20190313090010.20534-2-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313090010.20534-2-georgi.djakov@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-03-19, 11:00, Georgi Djakov wrote:
> In addition to frequency and voltage, some devices may have bandwidth
> requirements for their interconnect throughput - for example a CPU
> or GPU may also need to increase or decrease their bandwidth to DDR
> memory based on the current operating performance point.
> 
> Extend the OPP tables with additional property to describe the bandwidth
> needs of a device. The average and peak bandwidth values depend on the
> hardware and its properties.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  Documentation/devicetree/bindings/opp/opp.txt | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> index 76b6c79604a5..fa598264615f 100644
> --- a/Documentation/devicetree/bindings/opp/opp.txt
> +++ b/Documentation/devicetree/bindings/opp/opp.txt
> @@ -129,6 +129,9 @@ Optional properties:
>  - opp-microamp-<name>: Named opp-microamp property. Similar to
>    opp-microvolt-<name> property, but for microamp instead.
>  
> +- opp-bw-MBs: The interconnect bandwidth is specified with an array containing
> +  the two integer values for average and peak bandwidth in megabytes per second.
> +
>  - opp-level: A value representing the performance level of the device,
>    expressed as a 32-bit integer.
>  
> @@ -546,3 +549,45 @@ Example 6: opp-microvolt-<name>, opp-microamp-<name>:
>  		};
>  	};
>  };
> +
> +Example 7: opp-bw-MBs:
> +(example: average and peak bandwidth values are defined for each OPP and the
> +interconnect between CPU and DDR memory is scaled together with CPU frequency)
> +
> +/ {
> +	cpus {
> +		CPU0: cpu@0 {
> +			compatible = "arm,cortex-a53", "arm,armv8";
> +			...
> +			operating-points-v2 = <&cpu_opp_table>;
> +			/* path between the CPU and DDR memory */
> +			interconnects = <&rpm_bimc MASTER_AMPSS_M0
> +					&rpm_bimc SLAVE_EBI_CH0>;

Can we have multiple paths for a device ?

> +		};
> +	};
> +
> +	cpu_opp_table: cpu_opp_table {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp-200000000 {
> +			opp-hz = /bits/ 64 <200000000>;
> +			/* 457 MB/s average and 1525 MB/s peak bandwidth */
> +			opp-bw-MBs = <457 1525>;

In that case fixing this to just 2 entries in the array is incorrect
and we should take care of that in the bindings here.

> +		};
> +		opp-400000000 {
> +			opp-hz = /bits/ 64 <400000000>;
> +			/* 915 MB/s average and 3051 MB/s peak bandwidth */
> +			opp-bw-MBs = <915 3051>;
> +		};
> +		opp-800000000 {
> +			opp-hz = /bits/ 64 <800000000>;
> +			/* 1830 MB/s average and 6103 MB/s peak bandwidth */
> +			opp-bw-MBs = <1830 6103>;
> +		};
> +		opp-998400000 {
> +			opp-hz = /bits/ 64 <998400000>;
> +			/* 2282 MB/s average and 7614 MB/s peak bandwidth */
> +			opp-bw-MBs = <2284 7614>;
> +		};
> +	};

-- 
viresh
