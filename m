Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB52C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 05:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 108BB2146E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 05:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D/h/ZJrV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbfFHFq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 01:46:27 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35482 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfFHFq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 01:46:27 -0400
Received: by mail-pg1-f196.google.com with SMTP id s27so2243685pgl.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 22:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GlixWvcFYVT2osuXuqp6jTW4HjMG+s+4U9TFHSTGDvM=;
        b=D/h/ZJrVYwHg/tF2albH+nWZGTIGP8mgb5vZqEEbfXXFUfX33AxVnze8ASnaJQLV4X
         laIgnr0wy/LMQTmXv09dRJl6EpPA3cstVq2diFihAoqQr6xqsV6qzWRUpuCTMUQ7rpHY
         K/GGdjJcnRZXh/UrZ79eaCOSiPOFMXAilypyz123UORgpvVHaxO8H9sXqc9dz0g+kd4L
         x9BLMbNBWSP8C9PwC3vyCb9o8PZ1C0jdr4MNNdoHIxDHSfqnWXxK7kqrjBWJdKeo7Jc/
         LrfM5dIRm5RN/UlR8/PUBnOR5OkE4S2bmTwMQzc577wzJYfjcOh6QgINA/q2zhtWJMvw
         kwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GlixWvcFYVT2osuXuqp6jTW4HjMG+s+4U9TFHSTGDvM=;
        b=F7haL9lkYKgertS8IogfagTw+3w2GWIkBuFYzeKyvl/cqCDPLGjY5PJfCKQPEBvudR
         v/2tsX6omRntt9OgunHfp2e9NsNbkPkqtLiGSrabOFqH8la19mGtpEigbqetg+j/A0zO
         GVLDdpGWVICo6TdVkO2du1jrS7TptpN/zBHUa7P1tzNZdsgpuKKtiECtvDnbGBm638n/
         /TJKmorBuHHKXyeLeJM+EyihOYUD7BnYjIyH1RlSF+Ui1R4+q6BRbonY/har+zA5/Gha
         YqojlzT2pjVXROZTaWKh0t9EI+RG2CvGoiQ4qeIbNQWBMlIAwzsnqTsL9AISQgPsMhq6
         ZTGA==
X-Gm-Message-State: APjAAAWRCyDcfheHyFRhKr7nvvOJQwqRBJKOk/oZ5Rhfh6jheKT/E8wh
        4aV+/YoDP2x9NqnS6q/Vv4w6VA==
X-Google-Smtp-Source: APXvYqx46cEKrkm060Svem6vg7rJOO6SGeAlDGseD6x8321eEySq/IrkVQWtC7EaA4ZGrVcaKjF6vQ==
X-Received: by 2002:a63:1a5e:: with SMTP id a30mr5985274pgm.433.1559972785979;
        Fri, 07 Jun 2019 22:46:25 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id f3sm526309pjo.31.2019.06.07.22.46.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 07 Jun 2019 22:46:25 -0700 (PDT)
Date:   Fri, 7 Jun 2019 22:47:11 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        vincent.guittot@linaro.org, amit.kucheria@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, sibis@codeaurora.org,
        kernel-team@android.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/9] Introduce Bandwidth OPPs & interconnect devfreq
 driver
Message-ID: <20190608054711.GZ22737@tuxbook-pro>
References: <20190608044339.115026-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190608044339.115026-1-saravanak@google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 07 Jun 21:43 PDT 2019, Saravana Kannan wrote:

> I replied[1] to this patch series[2] and described how I think interconnect
> bandwidth voting should be captured in DT and how it should work.
> 
> So sending out a patch series implementing that. This patch series does the
> following:
> - Adds Bandwidth OPP table support (this adds device freq to bandwidth
>   mapping for free)
> - Adds a devfreq library for interconnect paths
> 

Please provide a driver that uses this devfreq library, without it this
its impossible to gauge the usefulness of your approach.

> Interconnects and interconnect paths quantify they performance levels in
> terms of bandwidth. So similar to how we have frequency based OPP tables
> in DT and in the OPP framework, this patch series adds bandwidth OPP
> table support in the OPP framework and in DT.
> 
> To simplify voting for interconnects, this patch series adds helper
> functions to create devfreq devices out of interconnect paths. This
> allows drivers to add a single line of code to add interconnect voting
> capability.
> 
> To add devfreq device for the "gpu-mem" interconnect path:
> icc_create_devfreq(dev, "gpu-mem");
> 
> With the future addition of a "passive_bandwidth" devfreq governor,
> device frequency to interconnect bandwidth mapping would come for free.
> 
> If the feedback on this patch series is positive, I'll then add the
> devfreq passive_bandwidth governor (or something similar) to v2 of this
> patch series.
> 
> So with the DT bindings added in this patch series, the DT for a GPU
> that does bandwidth voting from GPU to Cache and GPU to DDR would look
> something like this:
> 
> gpu_cache_opp_table: gpu_cache_opp_table {
> 	compatible = "operating-points-v2";
> 
> 	gpu_cache_3000: opp-3000 {
> 		opp-peak-KBps = <3000>;
> 		opp-avg-KBps = <1000>;
> 	};
> 	gpu_cache_6000: opp-6000 {
> 		opp-peak-KBps = <6000>;
> 		opp-avg-KBps = <2000>;
> 	};
> 	gpu_cache_9000: opp-9000 {
> 		opp-peak-KBps = <9000>;
> 		opp-avg-KBps = <9000>;
> 	};
> };
> 
> gpu_ddr_opp_table: gpu_ddr_opp_table {
> 	compatible = "operating-points-v2";
> 
> 	gpu_ddr_1525: opp-1525 {
> 		opp-peak-KBps = <1525>;
> 		opp-avg-KBps = <452>;
> 	};
> 	gpu_ddr_3051: opp-3051 {
> 		opp-peak-KBps = <3051>;
> 		opp-avg-KBps = <915>;
> 	};
> 	gpu_ddr_7500: opp-7500 {
> 		opp-peak-KBps = <7500>;
> 		opp-avg-KBps = <3000>;
> 	};
> };
> 
> gpu_opp_table: gpu_opp_table {
> 	compatible = "operating-points-v2";
> 	opp-shared;
> 
> 	opp-200000000 {
> 		opp-hz = /bits/ 64 <200000000>;
> 		required-opps = <&gpu_cache_3000>, <&gpu_ddr_1525>;

I still don't see the benefit of the indirection, over just spelling out
the bandwidth values here.

Regards,
Bjorn

> 	};
> 	opp-400000000 {
> 		opp-hz = /bits/ 64 <400000000>;
> 		required-opps = <&gpu_cache_6000>, <&gpu_ddr_3051>;
> 	};
> };
> 
> gpu@7864000 {
> 	...
> 	operating-points-v2 = <&gpu_opp_table>, <&gpu_cache_opp_table>, <&gpu_ddr_opp_table>;
> 	interconnects = <&mmnoc MASTER_GPU_1 &bimc SLAVE_SYSTEL_CACHE>,
> 			<&mmnoc MASTER_GPU_1 &bimc SLAVE_DDR>;
> 	interconnect-names = "gpu-cache", "gpu-mem";
> 	interconnect-opp-table = <&gpu_cache_opp_table>, <&gpu_ddr_opp_table>
> };
> 
> Cheers,
> Saravana
> 
> [1] - https://lore.kernel.org/lkml/20190601021228.210574-1-saravanak@google.com/
> [2] - https://lore.kernel.org/lkml/20190423132823.7915-1-georgi.djakov@linaro.org/ 
> 
> Saravana Kannan (9):
>   dt-bindings: opp: Introduce opp-peak-KBps and opp-avg-KBps bindings
>   OPP: Add support for bandwidth OPP tables
>   OPP: Add helper function for bandwidth OPP tables
>   OPP: Add API to find an OPP table from its DT node
>   dt-bindings: interconnect: Add interconnect-opp-table property
>   interconnect: Add OPP table support for interconnects
>   OPP: Add function to look up required OPP's for a given OPP
>   OPP: Allow copying OPPs tables between devices
>   interconnect: Add devfreq support
> 
>  .../bindings/interconnect/interconnect.txt    |   8 +
>  Documentation/devicetree/bindings/opp/opp.txt |  15 +-
>  drivers/interconnect/Makefile                 |   2 +-
>  drivers/interconnect/core.c                   |  27 +++-
>  drivers/interconnect/icc-devfreq.c            | 144 ++++++++++++++++++
>  drivers/opp/core.c                            | 109 +++++++++++++
>  drivers/opp/of.c                              |  75 +++++++--
>  drivers/opp/opp.h                             |   4 +-
>  include/linux/interconnect.h                  |  17 +++
>  include/linux/pm_opp.h                        |  41 +++++
>  10 files changed, 426 insertions(+), 16 deletions(-)
>  create mode 100644 drivers/interconnect/icc-devfreq.c
> 
> -- 
> 2.22.0.rc2.383.gf4fbbf30c2-goog
> 
