Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A38C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 19:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA6F2064A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 19:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TumRendw";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NgWpzAL8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfCOTDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 15:03:00 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51344 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfCOTC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 15:02:59 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3A7A1608FC; Fri, 15 Mar 2019 19:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552676578;
        bh=ttf5U3eWK+DzMc1T2QHcSyEwQK4IW0JhEUDkBQSt3GQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TumRendwOz+eit06FcJFEezST/dCJX3aD6c7e2RAq+xUJNqGmrKvP3f0yqe6BEI6S
         2B8hy/It7x2ecJcyVm2RAkFytXhoAsTmNG5F+c9hTnrfIkpbZ4f3C7QaWhh1UsuZK/
         UQnyaZIERBwFgMq1FpBJL/9O7GjY+U9buDuVsW4c=
Received: from [10.79.40.96] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C3496604D4;
        Fri, 15 Mar 2019 19:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552676577;
        bh=ttf5U3eWK+DzMc1T2QHcSyEwQK4IW0JhEUDkBQSt3GQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NgWpzAL8BZkJrafmm3MT41vrAC4tsHcKuZxatfvXkX8gsBjWNpiVXbtooQnXoaAv9
         Y9332rlL42wubyQZmSfgM5G6bWW7bauCPNJyUUdCw7wYl7fhXvAQuGbD9mjCdfWZ3U
         4gE5zK3JaykKGdPZ4rwDi5FQHS1EO4uQPEj0smuU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C3496604D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
Subject: Re: [PATCH 0/4] Introduce OPP bandwidth bindings
To:     Georgi Djakov <georgi.djakov@linaro.org>, vireshk@kernel.org,
        sboyd@kernel.org, nm@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com, rjw@rjwysocki.net
Cc:     jcrouse@codeaurora.org, vincent.guittot@linaro.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, myungjoo.ham@samsung.com,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
References: <20190313090010.20534-1-georgi.djakov@linaro.org>
From:   Sibi Sankar <sibis@codeaurora.org>
Message-ID: <460be20a-0baa-cf9c-2d5c-ea825aa34bc4@codeaurora.org>
Date:   Sat, 16 Mar 2019 00:32:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190313090010.20534-1-georgi.djakov@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/13/19 2:30 PM, Georgi Djakov wrote:
> Here is a proposal to extend the OPP bindings with bandwidth based on
> a previous discussion [1].
> 
> Every functional block on a SoC can contribute to the system power
> efficiency by expressing its own bandwidth needs (to memory or other SoC
> modules). This will allow the system to save power when high throughput
> is not required (and also provide maximum throughput when needed).
> 
> There are at least three ways for a device to determine its bandwidth
> needs:
> 	1. The device can dynamically calculate the needed bandwidth
> based on some known variable. For example: UART (baud rate), I2C (fast
> mode, high-speed mode, etc), USB (specification version, data transfer
> type), SDHC (SD standard, clock rate, bus-width), Video Encoder/Decoder
> (video format, resolution, frame-rate)
> 
> 	2. There is a hardware specific value. For example: hardware
> specific constant value (e.g. for PRNG) or use-case specific value that
> is hard-coded.
> 
> 	3. Predefined SoC/board specific bandwidth values. For example:
> CPU or GPU bandwidth is related to the current core frequency and both
> bandwidth and frequency are scaled together.
> 
> This patchset is trying to address point 3 above by extending the OPP
> bindings to support predefined SoC/board bandwidth values and adds
> support in cpufreq-dt to scale the interconnect between the CPU and the
> DDR together with frequency and voltage.

Hey Georgi,
Having opp-bw-MBps as a part of cpu opp does greatly simplify the
problem of scaling multiple interconnect devices with change in cpu
frequency. But there is still a need to scale other devices (non 
interconnect based) according to cpu frequency. Having a devfreq
governor for the same would help to have the same generic solution
across SoCs (msm8916/8996/qcs405/sdm845). The devfreq maintainer did
like the idea but wanted it incorporated into the passive governor.

* 
https://lore.kernel.org/lkml/20180528060014epcms1p87ec68a4d44f9447b06f979a87e545b7d@epcms1p8/

* 
https://lore.kernel.org/lkml/20180802095608epcms1p33fb061543efc9ceb3ec12d5567ceffbc@epcms1p3/

I have a RFC series implementing ddr scaling with passive governor for 
sdm845 with the following bindings, will post it early next week.

cpus {
	...

	CPU0: cpu@0 {
		...
		operating-points-v2 = <&cpu0_opp_table>;
		...
	};
         ....

	CPU4: cpu@400 {
		...
		operating-points-v2 = <&cpu4_opp_table>;
		...
	};
         ...
};

cpu0_opp_table: cpu0_opp_table {
	compatible = "operating-points-v2";
	opp-shared;

	cpu0_opp1: opp-300000000 {
		opp-hz = /bits/ 64 <300000000>;
	};

	...

	cpu0_opp16: opp-1612800000 {
		opp-hz = /bits/ 64 <1612800000>;
	};

	...
};

cpu4_opp_table: cpu4_opp_table {
	compatible = "operating-points-v2";
	opp-shared;

	...

	cpu4_opp4: opp-1056000000 {
		opp-hz = /bits/ 64 <1056000000>;
	};

	cpu4_opp5: opp-1209600000 {
		opp-hz = /bits/ 64 <1209600000>;
	};

	...
};

bw_opp_table: bw-opp-table {
	compatible = "operating-points-v2";

	opp-200  {
		opp-hz = /bits/ 64 < 200000000 >; /* 200 MHz */
		required-opps = <&cpu0_opp1>;
		/* 0 MB/s average and 762 MB/s peak bandwidth */
		opp-bw-MBs = <0 762>;
	};

	opp-300 {
		opp-hz = /bits/ 64 < 300000000 >; /* 300 MHz */
		/* 0 MB/s average and 1144 MB/s peak bandwidth */
		opp-bw-MBs = <0 1144>;
	};

	...

	opp-768 {
		opp-hz = /bits/ 64 < 768000000 >; /* 768 MHz */
		/* 0 MB/s average and 2929 MB/s peak bandwidth */
		opp-bw-MBs = <0 2929>;
		required-opps = <&cpu4_opp4>;
	};

	opp-1017 {
		opp-hz = /bits/ 64 < 1017000000 >; /* 1017 MHz */
		/* 0 MB/s average and 3879 MB/s peak bandwidth */
		opp-bw-MBs = <0 3879>;
		required-opps = <&cpu0_opp16>, <&cpu4_opp5>;
	};
};

cpubw {
	compatible = "devfreq-icbw";
	interconnects = <&snoc MASTER_APSS_1 &bimc SLAVE_EBI_CH0>;
	operating-points-v2 = <&bw_opp_table>;
};


> > [1] https://patchwork.kernel.org/patch/10577315/
> 
> Georgi Djakov (4):
>    dt-bindings: opp: Introduce opp-bw-MBs bindings
>    OPP: Add support for parsing the interconnect bandwidth
>    OPP: Update the bandwidth on OPP frequency changes
>    cpufreq: dt: Add support for interconnect bandwidth scaling
> 
>   Documentation/devicetree/bindings/opp/opp.txt | 45 ++++++++++++
>   drivers/cpufreq/cpufreq-dt.c                  | 27 ++++++-
>   drivers/opp/core.c                            | 71 +++++++++++++++++++
>   drivers/opp/of.c                              | 44 ++++++++++++
>   drivers/opp/opp.h                             |  6 ++
>   include/linux/pm_opp.h                        | 14 ++++
>   6 files changed, 206 insertions(+), 1 deletion(-)
> 

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc, is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
