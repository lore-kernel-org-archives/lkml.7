Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA47C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 08:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA5B12173E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 08:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfGRI2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 04:28:53 -0400
Received: from foss.arm.com ([217.140.110.172]:55548 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbfGRI2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 04:28:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3805F28;
        Thu, 18 Jul 2019 01:28:52 -0700 (PDT)
Received: from dawn-kernel.cambridge.arm.com (unknown [10.1.197.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 147763F71F;
        Thu, 18 Jul 2019 01:28:49 -0700 (PDT)
Subject: Re: [PATCHv8 2/5] arm64: dts: qcom: msm8998: Add Coresight support
To:     saiprakash.ranjan@codeaurora.org, gregkh@linuxfoundation.org,
        mathieu.poirier@linaro.org, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, mike.leach@linaro.org,
        robh+dt@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, david.brown@linaro.org,
        mark.rutland@arm.com
Cc:     rnayak@codeaurora.org, vivek.gautam@codeaurora.org,
        sibis@codeaurora.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        marc.w.gonzalez@free.fr
References: <cover.1562940244.git.saiprakash.ranjan@codeaurora.org>
 <e510df23f741205fac9030f2c95d06d607549caa.1562940244.git.saiprakash.ranjan@codeaurora.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <3b192063-f31f-b861-d913-61d737cecc57@arm.com>
Date:   Thu, 18 Jul 2019 09:28:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <e510df23f741205fac9030f2c95d06d607549caa.1562940244.git.saiprakash.ranjan@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sai,

On 12/07/2019 15:16, Sai Prakash Ranjan wrote:
> Enable coresight support by adding device nodes for the
> available source, sinks and channel blocks on MSM8998.
> 
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>   arch/arm64/boot/dts/qcom/msm8998.dtsi | 435 ++++++++++++++++++++++++++
>   1 file changed, 435 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> index c13ed7aeb1e0..ad9cb5e8675d 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> @@ -822,6 +822,441 @@


		etr@6048000 {
> +			compatible = "arm,coresight-tmc", "arm,primecell";
> +			reg = <0x06048000 0x1000>;
> +
> +			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
> +			clock-names = "apb_pclk", "atclk";
> +			arm,scatter-gather;

Please could you confirm that you have tested the scatter-gather mode with ETR ? 
Either via perf/sysfs. Please could you share your results ? Unless verified
this is going to be fatal for the system.

Similarly for other platforms.

Kind regards
Suzuki


