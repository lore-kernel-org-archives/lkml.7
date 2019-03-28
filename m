Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFCCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C918E2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553785979;
	bh=wHCw3Y0PBUKaGOP93kzs9fJi3NZ39YAl7puzLcC1qVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NkBRJVvKNHLsNCfmCz3yNEIOkkdwHJdDSD/PazJ4T3ty4/U0WdPkxhkt4aFLluUKI
	 qQhbWqRfliPuk/dMTHIFNzHRiZTWU6SjQIO+cLC2PAPG5VApVei1Xj3I7mbDT0+Jy9
	 Dkqh6FExvM5Sk2apL8J1trhR0G/lgtKHvW+4LiwE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfC1PM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:12:58 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38190 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfC1PM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 11:12:58 -0400
Received: by mail-oi1-f193.google.com with SMTP id w137so16043925oiw.5;
        Thu, 28 Mar 2019 08:12:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2omjLpVmBJBs90j22YOsKFu6lqZLzI5wEkDiwrbmN2o=;
        b=d4tznvV61Nda1p20HjYXaTLwfLOej7TAiV0KTUFYDNUqxz76MxV/qad9kF298m/ofh
         50qvAsudfKv45lAuvKhCKJ06mKuGsA6aJWKO1y1263RRlHa9ARkL9916J0dPBjCIZw8e
         cux7Tv693XKPCU+PhsGEIICzcBAuZf9WICk7GJUExQyHPzEc7ijGk0Iu4QKOXR+Y+rwJ
         JBZ3mLWKbdyTEkUdfezEr2oTcndIfZU3nUQxwDsvHrhRcEmf2l2ZgjPu3x7H/ypd+GKz
         jqb5alDOYbV0tRyQzJXzGxQqV7sikKfCyKfu+k14PhGdKnn8rbNy+ysAnNnGPDSnwEau
         k5bg==
X-Gm-Message-State: APjAAAUVA/XVqPnW76DJp/F9da0pDsBzvRaOSBwGkikGGLYSavPKk+Em
        trOs59Ba7sZUSy2exbzqBA==
X-Google-Smtp-Source: APXvYqzPRfN0o0Jhnk1J3InNtmZWBIwqddBNaY2TafmVtSNRcm8PILuBKY3f9II32b6cXPQCLo1IKA==
X-Received: by 2002:aca:3c8a:: with SMTP id j132mr346880oia.38.1553785977344;
        Thu, 28 Mar 2019 08:12:57 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t66sm9878666oig.39.2019.03.28.08.12.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 08:12:56 -0700 (PDT)
Date:   Thu, 28 Mar 2019 10:12:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     vireshk@kernel.org, sboyd@kernel.org, nm@ti.com,
        mark.rutland@arm.com, rjw@rjwysocki.net, jcrouse@codeaurora.org,
        vincent.guittot@linaro.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        sibis@codeaurora.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: opp: Introduce opp-bw-MBs bindings
Message-ID: <20190328151255.GA5262@bogus>
References: <20190313090010.20534-1-georgi.djakov@linaro.org>
 <20190313090010.20534-2-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313090010.20534-2-georgi.djakov@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 11:00:07AM +0200, Georgi Djakov wrote:
> In addition to frequency and voltage, some devices may have bandwidth
> requirements for their interconnect throughput - for example a CPU
> or GPU may also need to increase or decrease their bandwidth to DDR
> memory based on the current operating performance point.
> 
> Extend the OPP tables with additional property to describe the bandwidth
> needs of a device. The average and peak bandwidth values depend on the
> hardware and its properties.

How would this work if you have 1 OPP (for the bus/interconnect/ddr) and 
2 devices with variable bandwidth needs? Or 'device' here means the 
interconnect?

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

-MBps would be better IMO. Either way, units should be documented in 
property-units.txt.

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
