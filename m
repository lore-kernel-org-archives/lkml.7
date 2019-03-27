Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEA0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 11:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B1BA206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 11:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="DT2XcLen"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732995AbfC0LKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 07:10:23 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:18574 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfC0LKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 07:10:23 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9b5a1b0000>; Wed, 27 Mar 2019 04:10:19 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 27 Mar 2019 04:10:21 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 27 Mar 2019 04:10:21 -0700
Received: from [10.24.44.155] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Mar
 2019 11:10:19 +0000
Subject: Re: [PATCH v2 1/2] bus: tegra-aconnect: use devm_clk_*() helpers
To:     <treding@nvidia.com>, <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1552452119-6574-1-git-send-email-spujar@nvidia.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <32ab970f-d6a3-1232-77f1-41f97cc04f9a@nvidia.com>
Date:   Wed, 27 Mar 2019 16:40:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <1552452119-6574-1-git-send-email-spujar@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553685019; bh=IhJb2nqPkz/hMBzG2tc6tEfrJ4LPJ3b+pV/uT8fvHUM=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=DT2XcLenQCl4Z7xGn/mIf0yNu8g1SdoZQ9PONaZBPtK89+9nqRG/K9dhYdHI7wNAK
         KCpd/HT1YWyHwaF5v4KK3CiE8INPOt36CEV6imCbkBoMuqiPHls8mncuvjbOu/Slb3
         ogOctOz6qwAa+J9E6OTaU1fKt848XAF9pzgc6iX+fDdcVkiNjdzptcFeEQaI270Vjy
         FFGYUKTK/tEvYyIRPmrBISph8U75Pwe7VWzgWRJQ2eqiqil98aciRT31Bw/a4Mb+Au
         jhkVzW7PKXfTyubvm9QP8c6HKmiAMlLbu1KWl65meC7R4BuUYWFPIb0mZe+igCY2Io
         SvMEMBgyXkOug==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reviewers,

Request for review and approval.

Thanks,
Sameer.

On 3/13/2019 10:11 AM, Sameer Pujar wrote:
> aconnect bus driver is using pm_clk_*() interface for managing clocks.
> With this, clocks seem to be always ON. This happens on Tegra devices
> which use BPMP co-processor to manage clock resources, where clocks
> are enabled during prepare phase. This is necessary because calls to
> BPMP are always blocking. When pm_clk_*() interface is used on such
> Tegra devices, clock prepare count is not balanced till driver remove()
> gets executed and hence clocks are seen ON always. Thus this patch
> replaces pm_clk_*() with devm_clk_*() framework.
>
> Suggested-by: Mohan Kumar D <mkumard@nvidia.com>
> Reviewed-by: Jonathan Hunter <jonathanh@nvidia.com>
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>   drivers/bus/tegra-aconnect.c | 64 ++++++++++++++++++++++++++++++--------------
>   1 file changed, 44 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/bus/tegra-aconnect.c b/drivers/bus/tegra-aconnect.c
> index 084ae28..9349157 100644
> --- a/drivers/bus/tegra-aconnect.c
> +++ b/drivers/bus/tegra-aconnect.c
> @@ -12,28 +12,38 @@
>   #include <linux/module.h>
>   #include <linux/of_platform.h>
>   #include <linux/platform_device.h>
> -#include <linux/pm_clock.h>
>   #include <linux/pm_runtime.h>
>   
> +struct tegra_aconnect {
> +	struct clk	*ape_clk;
> +	struct clk	*apb2ape_clk;
> +};
> +
>   static int tegra_aconnect_probe(struct platform_device *pdev)
>   {
> -	int ret;
> +	struct tegra_aconnect *aconnect;
>   
>   	if (!pdev->dev.of_node)
>   		return -EINVAL;
>   
> -	ret = pm_clk_create(&pdev->dev);
> -	if (ret)
> -		return ret;
> +	aconnect = devm_kzalloc(&pdev->dev, sizeof(struct tegra_aconnect),
> +				GFP_KERNEL);
> +	if (!aconnect)
> +		return -ENOMEM;
>   
> -	ret = of_pm_clk_add_clk(&pdev->dev, "ape");
> -	if (ret)
> -		goto clk_destroy;
> +	aconnect->ape_clk = devm_clk_get(&pdev->dev, "ape");
> +	if (IS_ERR(aconnect->ape_clk)) {
> +		dev_err(&pdev->dev, "Can't retrieve ape clock\n");
> +		return PTR_ERR(aconnect->ape_clk);
> +	}
>   
> -	ret = of_pm_clk_add_clk(&pdev->dev, "apb2ape");
> -	if (ret)
> -		goto clk_destroy;
> +	aconnect->apb2ape_clk = devm_clk_get(&pdev->dev, "apb2ape");
> +	if (IS_ERR(aconnect->apb2ape_clk)) {
> +		dev_err(&pdev->dev, "Can't retrieve apb2ape clock\n");
> +		return PTR_ERR(aconnect->apb2ape_clk);
> +	}
>   
> +	dev_set_drvdata(&pdev->dev, aconnect);
>   	pm_runtime_enable(&pdev->dev);
>   
>   	of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
> @@ -41,30 +51,44 @@ static int tegra_aconnect_probe(struct platform_device *pdev)
>   	dev_info(&pdev->dev, "Tegra ACONNECT bus registered\n");
>   
>   	return 0;
> -
> -clk_destroy:
> -	pm_clk_destroy(&pdev->dev);
> -
> -	return ret;
>   }
>   
>   static int tegra_aconnect_remove(struct platform_device *pdev)
>   {
>   	pm_runtime_disable(&pdev->dev);
>   
> -	pm_clk_destroy(&pdev->dev);
> -
>   	return 0;
>   }
>   
>   static int tegra_aconnect_runtime_resume(struct device *dev)
>   {
> -	return pm_clk_resume(dev);
> +	struct tegra_aconnect *aconnect = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = clk_prepare_enable(aconnect->ape_clk);
> +	if (ret) {
> +		dev_err(dev, "ape clk_enable failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(aconnect->apb2ape_clk);
> +	if (ret) {
> +		clk_disable_unprepare(aconnect->ape_clk);
> +		dev_err(dev, "apb2ape clk_enable failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
>   }
>   
>   static int tegra_aconnect_runtime_suspend(struct device *dev)
>   {
> -	return pm_clk_suspend(dev);
> +	struct tegra_aconnect *aconnect = dev_get_drvdata(dev);
> +
> +	clk_disable_unprepare(aconnect->ape_clk);
> +	clk_disable_unprepare(aconnect->apb2ape_clk);
> +
> +	return 0;
>   }
>   
>   static const struct dev_pm_ops tegra_aconnect_pm_ops = {
