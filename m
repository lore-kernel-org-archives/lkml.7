Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3214C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9FA320675
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfDLKi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:38:56 -0400
Received: from foss.arm.com ([217.140.101.70]:57778 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbfDLKi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 06:38:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 785F615AB;
        Fri, 12 Apr 2019 03:38:55 -0700 (PDT)
Received: from [10.37.13.120] (unknown [10.37.13.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 911F43F718;
        Fri, 12 Apr 2019 03:38:53 -0700 (PDT)
Subject: Re: [PATCH v5 2/4] coresight: replicator: Add new device id for
 static replicator
To:     leo.yan@linaro.org, mathieu.poirier@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190412102738.12679-1-leo.yan@linaro.org>
 <20190412102738.12679-3-leo.yan@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <489e8aff-b279-b984-1cd2-f528a46eb2fe@arm.com>
Date:   Fri, 12 Apr 2019 11:41:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190412102738.12679-3-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2019 11:27 AM, Leo Yan wrote:
> This patch adds a device id for the new static replicator compatible
> string; it changes the driver name from "coresight-replicator" to
> "coresight-static-replicator" as well.
> 
> This patch also gives warning when use the replicator obsolete DT
> binding.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>   drivers/hwtracing/coresight/coresight-replicator.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
> index 4e0da85efd2d..8c9ce74498e1 100644
> --- a/drivers/hwtracing/coresight/coresight-replicator.c
> +++ b/drivers/hwtracing/coresight/coresight-replicator.c
> @@ -189,6 +189,9 @@ static int replicator_probe(struct device *dev, struct resource *res)
>   		dev->platform_data = pdata;
>   	}
>   
> +	if (of_device_is_compatible(np, "arm,coresight-replicator"))
> +		pr_warn_once("Uses OBSOLETE CoreSight replicator binding\n");
> +
>   	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>   	if (!drvdata)
>   		return -ENOMEM;
> @@ -285,13 +288,14 @@ static const struct dev_pm_ops replicator_dev_pm_ops = {
>   
>   static const struct of_device_id static_replicator_match[] = {
>   	{.compatible = "arm,coresight-replicator"},
> +	{.compatible = "arm,coresight-static-replicator"},
>   	{}
>   };
>   
>   static struct platform_driver static_replicator_driver = {
>   	.probe          = static_replicator_probe,
>   	.driver         = {
> -		.name   = "coresight-replicator",
> +		.name   = "coresight-static-replicator",
>   		.of_match_table = static_replicator_match,
>   		.pm	= &replicator_dev_pm_ops,
>   		.suppress_bind_attrs = true,
> 

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
