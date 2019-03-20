Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C679C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC0B72175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbfCTNxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:53:06 -0400
Received: from foss.arm.com ([217.140.101.70]:40442 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbfCTNxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 09:53:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F5B11650;
        Wed, 20 Mar 2019 06:53:05 -0700 (PDT)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 751A43F59C;
        Wed, 20 Mar 2019 06:53:01 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] coresight: funnel: Support static funnel
To:     shiwanglai@hisilicon.com, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, xuwei5@hisilicon.com,
        alexander.shishkin@linux.intel.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, leo.yan@linaro.org,
        suzhuangluan@hisilicon.com
References: <1553085490-42870-1-git-send-email-shiwanglai@hisilicon.com>
 <1553085490-42870-3-git-send-email-shiwanglai@hisilicon.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <ecfa879e-9fd9-0815-d2da-bb9870d6ae59@arm.com>
Date:   Wed, 20 Mar 2019 13:52:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1553085490-42870-3-git-send-email-shiwanglai@hisilicon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/03/2019 12:38, Wanglai Shi wrote:
> From: Leo Yan <leo.yan@linaro.org>
> 
> Since CoreSight hardware topology can use a 'hidden' funnel in the
> trace data path, this kind funnel doesn't have register for accessing
> and is used by default from hardware design perspective.  Below is an
> example for related hardware topology:
> 
>    +------+  +------+
>    | cpu0 |->| ETM  |-\
>    +------+  +------+  \-> +--------+  +-----+
>     ......                 | Funnel |->| ETF |-\    Hidden funnel
>    +------+  +------+  /-> +--------+  +-----+  \        |
>    | cpu3 |->| ETM  |-/                          \       V
>    +------+  +------+                             \-> +--------+
>                                                       | Funnel |-> ...
>    +------+  +------+                             /-> +--------+
>    | cpu4 |->| ETM  |-\                          /
>    +------+  +------+  \-> +--------+  +-----+  /
>     ......                 | Funnel |->| ETF |-/
>    +------+  +------+  /-> +--------+  +-----+
>    | cpu7 |->| ETM  |-/
>    +------+  +------+
> 
> The CoreSight funnel driver only supports dynamic funnel with
> registration register resource, thus it cannot support for the static
> funnel case and it's impossible to create trace data path for this case.
> 
> This patch is to extend CoreSight funnel driver to support both for
> static funnel and dynamic funnel.  For the dynamic funnel it reuses the
> code existed in the driver, for static funnel the driver will support
> device probe if without providing register resource and the driver skips
> registers accessing when detect the register base is NULL.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---

Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>

> -static const struct amba_id funnel_ids[] = {
> +static int static_funnel_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +
> +	pm_runtime_get_noresume(&pdev->dev);
> +	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
> +
> +	/* Static funnel do not have programming base */
> +	ret = funnel_probe(&pdev->dev, NULL);
> +
> +	if (ret) {
> +		pm_runtime_put_noidle(&pdev->dev);
> +		pm_runtime_disable(&pdev->dev);
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id static_funnel_match[] = {
> +	{.compatible = "arm,coresight-funnel"},

There is a potential issue with re-using the "compatible" string
already reserved for the normal programmable funnel. We may handle
a programmable funnel as non-programmable one, which is not good.

Do we need to use "arm,coresight-static-funnel" ?

Otherwise, looks good to me.

Suzuki
