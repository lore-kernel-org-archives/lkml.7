Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FEAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2735120823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553786167;
	bh=I+7+OpOnHZhgUqsV/YG9f1fRPTqcnfV9fHXcPwvjtdA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mWohC0O0AL27LP/F1H6D5PEPaa5TlpuD/b6RORdLj/VsPuL1DXQH2Ip25GG97bfe4
	 4FkULbgtqlLvO7dpO5pU/kYZR9UpPYPpzKPjOKYn7RPVBHBh7+zrR+ZFitbkFoQkU4
	 nrVlMpoIblyqIaWwO1uZBCFCJJqWotEapyhLc0+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfC1PQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:16:06 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46744 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfC1PQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 11:16:05 -0400
Received: by mail-ot1-f65.google.com with SMTP id s24so9180737otk.13;
        Thu, 28 Mar 2019 08:16:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vg2nnOWclGBSUxeqiGO409j0Hxo80ujZxFyKGzOki+c=;
        b=TaQFMYbY64VMLHm8x+1QKWMng3cjgo2mVdxF+c/8h+18rhhvOz22nJqrVQbFv+uInY
         93h2f++It8Kll/znevHqBZLjFokcQ3ojEqL1huwdwOzYcv+hLPPGcHK1V7zvq84d8zx3
         opolbO/SZSBO3VVL5u2iFw4xGENBmS01a/7Ljd5SQwlMo2I0yb+XUbjFNYJDFIt6FbNO
         97qMgxlxNi24ta6hmtq+heIY8mvtdWgFdWHRMYwobomdSRNFdQ4FB1tQxqWR0zO7zEZr
         pELEXnhfb5FPpRSVIEEKbNhhjrNQXZPWLh7An3zCSOcV+nS5BSDy2S5y/Zgnl3Q/MVKd
         L3gA==
X-Gm-Message-State: APjAAAWF/iak2UoDYGpAaJtnrXTAFMC3neh033oOLpvH5saDK2eVN7ou
        IsTMJDcAWUclRcBGMNj3ow==
X-Google-Smtp-Source: APXvYqxSm/hD3UH8F7OGttEuDxbVt7P3mC8jKlKRQOeNs2/s53dKnneiUlzhjm6zrwJhqzfkmbC+hA==
X-Received: by 2002:a9d:3444:: with SMTP id v62mr33085867otb.165.1553786164411;
        Thu, 28 Mar 2019 08:16:04 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e186sm9969768oia.44.2019.03.28.08.16.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 08:16:03 -0700 (PDT)
Date:   Thu, 28 Mar 2019 10:16:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>, vireshk@kernel.org,
        sboyd@kernel.org, nm@ti.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, jcrouse@codeaurora.org,
        vincent.guittot@linaro.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        myungjoo.ham@samsung.com, Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Subject: Re: [PATCH 0/4] Introduce OPP bandwidth bindings
Message-ID: <20190328151602.GB5262@bogus>
References: <20190313090010.20534-1-georgi.djakov@linaro.org>
 <460be20a-0baa-cf9c-2d5c-ea825aa34bc4@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <460be20a-0baa-cf9c-2d5c-ea825aa34bc4@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2019 at 12:32:49AM +0530, Sibi Sankar wrote:
> 
> 
> On 3/13/19 2:30 PM, Georgi Djakov wrote:
> > Here is a proposal to extend the OPP bindings with bandwidth based on
> > a previous discussion [1].
> > 
> > Every functional block on a SoC can contribute to the system power
> > efficiency by expressing its own bandwidth needs (to memory or other SoC
> > modules). This will allow the system to save power when high throughput
> > is not required (and also provide maximum throughput when needed).
> > 
> > There are at least three ways for a device to determine its bandwidth
> > needs:
> > 	1. The device can dynamically calculate the needed bandwidth
> > based on some known variable. For example: UART (baud rate), I2C (fast
> > mode, high-speed mode, etc), USB (specification version, data transfer
> > type), SDHC (SD standard, clock rate, bus-width), Video Encoder/Decoder
> > (video format, resolution, frame-rate)
> > 
> > 	2. There is a hardware specific value. For example: hardware
> > specific constant value (e.g. for PRNG) or use-case specific value that
> > is hard-coded.
> > 
> > 	3. Predefined SoC/board specific bandwidth values. For example:
> > CPU or GPU bandwidth is related to the current core frequency and both
> > bandwidth and frequency are scaled together.
> > 
> > This patchset is trying to address point 3 above by extending the OPP
> > bindings to support predefined SoC/board bandwidth values and adds
> > support in cpufreq-dt to scale the interconnect between the CPU and the
> > DDR together with frequency and voltage.
> 
> Hey Georgi,
> Having opp-bw-MBps as a part of cpu opp does greatly simplify the
> problem of scaling multiple interconnect devices with change in cpu
> frequency. But there is still a need to scale other devices (non
> interconnect based) according to cpu frequency. Having a devfreq
> governor for the same would help to have the same generic solution
> across SoCs (msm8916/8996/qcs405/sdm845). The devfreq maintainer did
> like the idea but wanted it incorporated into the passive governor.
> 
> * https://lore.kernel.org/lkml/20180528060014epcms1p87ec68a4d44f9447b06f979a87e545b7d@epcms1p8/
> 
> * https://lore.kernel.org/lkml/20180802095608epcms1p33fb061543efc9ceb3ec12d5567ceffbc@epcms1p3/
> 
> I have a RFC series implementing ddr scaling with passive governor for
> sdm845 with the following bindings, will post it early next week.
> 
> cpus {
> 	...
> 
> 	CPU0: cpu@0 {
> 		...
> 		operating-points-v2 = <&cpu0_opp_table>;
> 		...
> 	};
>         ....
> 
> 	CPU4: cpu@400 {
> 		...
> 		operating-points-v2 = <&cpu4_opp_table>;
> 		...
> 	};
>         ...
> };
> 
> cpu0_opp_table: cpu0_opp_table {
> 	compatible = "operating-points-v2";
> 	opp-shared;
> 
> 	cpu0_opp1: opp-300000000 {
> 		opp-hz = /bits/ 64 <300000000>;
> 	};
> 
> 	...
> 
> 	cpu0_opp16: opp-1612800000 {
> 		opp-hz = /bits/ 64 <1612800000>;
> 	};
> 
> 	...
> };
> 
> cpu4_opp_table: cpu4_opp_table {
> 	compatible = "operating-points-v2";
> 	opp-shared;
> 
> 	...
> 
> 	cpu4_opp4: opp-1056000000 {
> 		opp-hz = /bits/ 64 <1056000000>;
> 	};
> 
> 	cpu4_opp5: opp-1209600000 {
> 		opp-hz = /bits/ 64 <1209600000>;
> 	};
> 
> 	...
> };
> 
> bw_opp_table: bw-opp-table {
> 	compatible = "operating-points-v2";
> 
> 	opp-200  {
> 		opp-hz = /bits/ 64 < 200000000 >; /* 200 MHz */
> 		required-opps = <&cpu0_opp1>;
> 		/* 0 MB/s average and 762 MB/s peak bandwidth */
> 		opp-bw-MBs = <0 762>;
> 	};
> 
> 	opp-300 {
> 		opp-hz = /bits/ 64 < 300000000 >; /* 300 MHz */
> 		/* 0 MB/s average and 1144 MB/s peak bandwidth */
> 		opp-bw-MBs = <0 1144>;
> 	};
> 
> 	...
> 
> 	opp-768 {
> 		opp-hz = /bits/ 64 < 768000000 >; /* 768 MHz */
> 		/* 0 MB/s average and 2929 MB/s peak bandwidth */
> 		opp-bw-MBs = <0 2929>;
> 		required-opps = <&cpu4_opp4>;
> 	};
> 
> 	opp-1017 {
> 		opp-hz = /bits/ 64 < 1017000000 >; /* 1017 MHz */
> 		/* 0 MB/s average and 3879 MB/s peak bandwidth */
> 		opp-bw-MBs = <0 3879>;
> 		required-opps = <&cpu0_opp16>, <&cpu4_opp5>;
> 	};
> };
> 
> cpubw {
> 	compatible = "devfreq-icbw";

Most certainly not a h/w device, so it doesn't go in DT.

> 	interconnects = <&snoc MASTER_APSS_1 &bimc SLAVE_EBI_CH0>;
> 	operating-points-v2 = <&bw_opp_table>;
> };
> 
> 
> > > [1] https://patchwork.kernel.org/patch/10577315/
> > 
> > Georgi Djakov (4):
> >    dt-bindings: opp: Introduce opp-bw-MBs bindings
> >    OPP: Add support for parsing the interconnect bandwidth
> >    OPP: Update the bandwidth on OPP frequency changes
> >    cpufreq: dt: Add support for interconnect bandwidth scaling
> > 
> >   Documentation/devicetree/bindings/opp/opp.txt | 45 ++++++++++++
> >   drivers/cpufreq/cpufreq-dt.c                  | 27 ++++++-
> >   drivers/opp/core.c                            | 71 +++++++++++++++++++
> >   drivers/opp/of.c                              | 44 ++++++++++++
> >   drivers/opp/opp.h                             |  6 ++
> >   include/linux/pm_opp.h                        | 14 ++++
> >   6 files changed, 206 insertions(+), 1 deletion(-)
> > 
> 
> -- 
> Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc, is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
