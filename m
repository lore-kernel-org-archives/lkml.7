Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC032C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 05:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BFDA2089F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 05:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BFtXtKdN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbfDXFdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 01:33:33 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45436 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729430AbfDXFdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 01:33:32 -0400
Received: by mail-pf1-f195.google.com with SMTP id e24so8656654pfi.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 22:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ob8NZIMWaFUbrMN0tZ9gmnARtUfEz968OW1qZEZY2U4=;
        b=BFtXtKdNBVOTmiRT98kXDkwNylNrAtarZZ72c4GYQf9yqm8ueePojjS2zoX96t1GKh
         EnxlIDMB4SRPew1+0c3OOkEGorRERK7Fc8CwYvYVmqjx12r20CBqGmvme9nUMZlFmjgb
         SEtnC2VCvBR1UtBRcr518054JOY4LQwZ22DwrxfFDX49UEP32WgS6Pf1BBo19u8XxVlO
         yi3Pby6oATUW3PKT86xKmmCBhEUmFlmQp5rc/9qGpm7l8+h9EAsvwPW9fGr40NgeYGI4
         sD35MnfsLiUtjbncsW8dGQAjKEkbcegE+SIWv2SqlAi2Wa+NR5laj09ptg87N9XkQ8UF
         FqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ob8NZIMWaFUbrMN0tZ9gmnARtUfEz968OW1qZEZY2U4=;
        b=hc08rkoTO6DIVy/YvKyE1sDZDTY82COYzyqb5k67iSTMIW9DwheefOWKREe9pfghAW
         V4YZ110wr2ZE+1KjOmUU0mpDoexrH5+6Fe/S7ojcKX7LivdHqyVd73lHeAeDOkdDeRQ3
         w40UHzB6ppzCBH+kysM82CMo187diFLQZ860+um3E46UTiP0i9iNTY0GRLA9C1Jvzuq1
         RQ/gxUVmyExk/wkyRtt/NLkIMzZ4XC+Q+FjtKncaRypP3tCcm4okTaYHW9qH83J66jLf
         AM9Zkn1O1l6B1iMctvcRAdee6tL8B4bVKbs3DCnD581u+YR5Z3fxCt3QtZ2+3YOPG46d
         4Rbw==
X-Gm-Message-State: APjAAAUZc7AoVhOTcqfYOw0nWQyhURc3YVz3MKTyGou6vq2Y3Eo2KU5+
        hplCWOAX0wkHbgGnqhHNfM2xMg==
X-Google-Smtp-Source: APXvYqw83oLMfwekpoQ9cPC0MfACeIv8F95gDyBz44UEMQI/DhbKAdZHV1x1T8t0e5Zxjz57NnnJPQ==
X-Received: by 2002:a63:2b41:: with SMTP id r62mr28865997pgr.403.1556084011223;
        Tue, 23 Apr 2019 22:33:31 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id h127sm25296392pgc.31.2019.04.23.22.33.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 22:33:29 -0700 (PDT)
Date:   Wed, 24 Apr 2019 11:03:27 +0530
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
Subject: Re: [PATCH v2 1/5] dt-bindings: opp: Introduce bandwidth-MBps
 bindings
Message-ID: <20190424053327.xatmhs3hx62c7tn5@vireshk-i7>
References: <20190423132823.7915-1-georgi.djakov@linaro.org>
 <20190423132823.7915-2-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423132823.7915-2-georgi.djakov@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-04-19, 16:28, Georgi Djakov wrote:
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
>  Documentation/devicetree/bindings/opp/opp.txt | 38 +++++++++++++++++++
>  .../devicetree/bindings/property-units.txt    |  4 ++
>  2 files changed, 42 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> index 76b6c79604a5..830f0206aea7 100644
> --- a/Documentation/devicetree/bindings/opp/opp.txt
> +++ b/Documentation/devicetree/bindings/opp/opp.txt
> @@ -132,6 +132,9 @@ Optional properties:
>  - opp-level: A value representing the performance level of the device,
>    expressed as a 32-bit integer.
>  
> +- bandwidth-MBps: The interconnect bandwidth is specified with an array containing
> +  the two integer values for average and peak bandwidth in megabytes per second.
> +
>  - clock-latency-ns: Specifies the maximum possible transition latency (in
>    nanoseconds) for switching to this OPP from any other OPP.
>  
> @@ -546,3 +549,38 @@ Example 6: opp-microvolt-<name>, opp-microamp-<name>:
>  		};
>  	};
>  };
> +
> +Example 7: bandwidth-MBps:
> +Average and peak bandwidth values for the interconnects between CPU and DDR
> +memory and also between CPU and L3 are defined per each OPP. Bandwidth of both
> +interconnects is scaled together with CPU frequency.
> +
> +/ {
> +	cpus {
> +		CPU0: cpu@0 {
> +			compatible = "arm,cortex-a53", "arm,armv8";
> +			...
> +			operating-points-v2 = <&cpu_opp_table>;
> +			/* path between CPU and DDR memory and CPU and L3 */
> +			interconnects = <&noc MASTER_CPU &noc SLAVE_DDR>,
> +					<&noc MASTER_CPU &noc SLAVE_L3>;
> +		};
> +	};
> +
> +	cpu_opp_table: cpu_opp_table {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp-200000000 {
> +			opp-hz = /bits/ 64 <200000000>;
> +			/* CPU<->DDR bandwidth: 457 MB/s average, 1525 MB/s peak */
> +			 * CPU<->L3 bandwidth: 914 MB/s average, 3050 MB/s peak */
> +			bandwidth-MBps = <457 1525>, <914 3050>;
> +		};
> +		opp-400000000 {
> +			opp-hz = /bits/ 64 <400000000>;
> +			/* CPU<->DDR bandwidth: 915 MB/s average, 3051 MB/s peak */
> +			 * CPU<->L3 bandwidth: 1828 MB/s average, 6102 MB/s peak */
> +			bandwidth-MBps = <915 3051>, <1828 6102>;
> +		};
> +	};
> diff --git a/Documentation/devicetree/bindings/property-units.txt b/Documentation/devicetree/bindings/property-units.txt
> index bfd33734faca..9c3dbefcdae8 100644
> --- a/Documentation/devicetree/bindings/property-units.txt
> +++ b/Documentation/devicetree/bindings/property-units.txt
> @@ -41,3 +41,7 @@ Temperature
>  Pressure
>  ----------------------------------------
>  -kpascal	: kiloPascal
> +
> +Throughput
> +----------------------------------------
> +-MBps		: megabytes per second

LGTM

-- 
viresh
