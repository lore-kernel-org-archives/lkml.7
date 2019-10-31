Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D48C47E49
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7074F2067D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="njw1kSrw";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YW2gQkq7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfJaL3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 07:29:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48166 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfJaL3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 07:29:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7EAB6602F0; Thu, 31 Oct 2019 11:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572521373;
        bh=Iul483ITYeU4QpQX+AZgtpLy91D+aok94WxB8TGMZNg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=njw1kSrw4HVbchpOemPSJCP0zLob2TWYLMquBb3IjyGY3ONYQUvMh10IFsfW3MLq1
         +CP9DToxkyWQ4TFReh8TfQAE6pQ3H7WiTCyXY273FW2GdLshdOCrWKIaPJrprseew1
         8VPS82JN0CAqstE+dXLlQABMILHuo7yi1vZ1pawE=
Received: from [10.206.28.9] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C4648602F0;
        Thu, 31 Oct 2019 11:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572521372;
        bh=Iul483ITYeU4QpQX+AZgtpLy91D+aok94WxB8TGMZNg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YW2gQkq7CymRgVr5CmA4gAmZs0XcVkxASl7eZ0O+M7hgSftcDWfjeVC8k+E7HKy4Z
         vPEqe19nFxzjvT2UmdGEcaAS/v2rpTacQJ7wbxZ/CTOKZIoUI9OH8PBOPXIJ+haPRQ
         ZiA5TJyjeJyIYKadSEX/aJUw00MZaXsudOSRdtHc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C4648602F0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v4 5/5] clk: qcom: Add Global Clock controller (GCC)
 driver for SC7180
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org, robh+dt@kernel.org
References: <20191014102308.27441-1-tdas@codeaurora.org>
 <20191014102308.27441-6-tdas@codeaurora.org>
 <20191029175941.GA27773@google.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <fa17b97d-bfc4-4e9c-78b5-c225e5b38946@codeaurora.org>
Date:   Thu, 31 Oct 2019 16:59:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191029175941.GA27773@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

Thanks for your comments.

On 10/29/2019 11:29 PM, Matthias Kaehlcke wrote:
> Hi Taniya,
> 
> On Mon, Oct 14, 2019 at 03:53:08PM +0530, Taniya Das wrote:
>> Add support for the global clock controller found on SC7180
>> based devices. This should allow most non-multimedia device
>> drivers to probe and control their clocks.
>>
>> Signed-off-by: Taniya Das <tdas@codeaurora.org>

> 
> v3 also had
> 
> +	[GCC_DISP_AHB_CLK] = &gcc_disp_ahb_clk.clkr,
> 
> Removing it makes the dpu_mdss driver unhappy:
> 
> [    2.999855] dpu_mdss_enable+0x2c/0x58->msm_dss_enable_clk: 'iface' is not available
> 
> because:
> 
>          mdss: mdss@ae00000 {
>      	        ...
> 
>   =>             clocks = <&gcc GCC_DISP_AHB_CLK>,
>                           <&gcc GCC_DISP_HF_AXI_CLK>,
>                           <&dispcc DISP_CC_MDSS_MDP_CLK>;
>                  clock-names = "iface", "gcc_bus", "core";
> 	};
> 

The basic idea as you mentioned below was to move the CRITICAL clocks to 
probe. The clock provider to return NULL in case the clocks are not 
registered.
This was discussed with Stephen on v3. Thus I submitted the below patch.
clk: qcom: common: Return NULL from clk_hw OF provider.

Yes it would throw these warnings, but no functional issue is observed 
from display. I have tested it on the cheza board.
I guess we could fix the DRM driver to use the "devm_clk_get_optional()" 
instead?

> More clocks were removed in v4:
> 
> -       [GCC_CPUSS_GNOC_CLK] = &gcc_cpuss_gnoc_clk.clkr,
> -       [GCC_GPU_CFG_AHB_CLK] = &gcc_gpu_cfg_ahb_clk.clkr,
> -       [GCC_VIDEO_AHB_CLK] = &gcc_video_ahb_clk.clkr,
> 
> I guess this part of "remove registering the CRITICAL clocks to clock provider
> and leave them always ON from the GCC probe." (change log entry), but are you
> sure nobody is going to reference these clocks?
> 

Even if they are referenced clk provider would return NULL.

>> +static int gcc_sc7180_probe(struct platform_device *pdev)
>> +{
>> +	struct regmap *regmap;
>> +	int ret;
>> +
>> +	regmap = qcom_cc_map(pdev, &gcc_sc7180_desc);
>> +	if (IS_ERR(regmap))
>> +		return PTR_ERR(regmap);
>> +
>> +	/*
>> +	 * Disable the GPLL0 active input to MM blocks, NPU
>> +	 * and GPU via MISC registers.
>> +	 */
>> +	regmap_update_bits(regmap, 0x09ffc, 0x3, 0x3);
>> +	regmap_update_bits(regmap, 0x4d110, 0x3, 0x3);
>> +	regmap_update_bits(regmap, 0x71028, 0x3, 0x3);
> 
> In v3 this was:
> 
> 	regmap_update_bits(regmap, GCC_MMSS_MISC, 0x3, 0x3);
> 	regmap_update_bits(regmap, GCC_NPU_MISC, 0x3, 0x3);
> 	regmap_update_bits(regmap, GCC_GPU_MISC, 0x3, 0x3);
> 
> IMO register names seem preferable, why switch to literal addresses
> instead?
> 

:). These cleanups where done based on the comments I had received 
during SDM845 review. If Stephen is fine moving them to names, I could 
submit them in the next patch series.

>> +
>> +	/*
>> +	 * Keep the clocks always-ON
>> +	 * GCC_CPUSS_GNOC_CLK, GCC_VIDEO_AHB_CLK, GCC_DISP_AHB_CLK
>> +	 * GCC_GPU_CFG_AHB_CLK
>> +	 */
>> +	regmap_update_bits(regmap, 0x48004, BIT(0), BIT(0));
>> +	regmap_update_bits(regmap, 0x0b004, BIT(0), BIT(0));
>> +	regmap_update_bits(regmap, 0x0b00c, BIT(0), BIT(0));
>> +	regmap_update_bits(regmap, 0x71004, BIT(0), BIT(0));
> 
> ditto, register names seem preferable.
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
