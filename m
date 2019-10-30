Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3155CC47E49
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 23:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2354208C0
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 23:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GwKBbl1C";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BTdpCrZs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfJ3XJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 19:09:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48028 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfJ3XJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 19:09:46 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9D54E607EB; Wed, 30 Oct 2019 23:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572476984;
        bh=MJbdFytPde7/IWl9jUG/H9ozurDfg3is3lna2YHVZ+c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GwKBbl1Cf+kDNSGJz82m+N8WaB+7woovQcA4NP39rGWmgbmkK9OMfNXoL14y/iEMo
         RsDD6BpNW5LEh81QwqTQvK0ZDPJaF9ypTEODCAPbyOzDcsRvorM0/OaPHoITN7g5Et
         jHmM8XPjZRq8dbXwP1y9WFBGmWTStCLMYyPd9E38=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5B73660397;
        Wed, 30 Oct 2019 23:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572476983;
        bh=MJbdFytPde7/IWl9jUG/H9ozurDfg3is3lna2YHVZ+c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BTdpCrZsl7petc7s6W8QOB3XhGPhab4CY1w75gwKTxlVpFz6yaEXx8y/hK5SieVjg
         ZBoBWC2HR0Z/FjAJou3+CoIyrL0MmBm+mq6HLSP1xCfzFLXO9/wR7fY9h6POMD+Esm
         3K8dnQyJkKprnjsLrPjKGTiuMRLiBoY4kmbUfzc0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5B73660397
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Wed, 30 Oct 2019 17:09:41 -0600
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 6/7] Revert "iommu/arm-smmu: Make arm-smmu explicitly
 non-modular"
Message-ID: <20191030230941.GA8188@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>
References: <20191030145112.19738-1-will@kernel.org>
 <20191030145112.19738-7-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030145112.19738-7-will@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 02:51:11PM +0000, Will Deacon wrote:
> This reverts commit addb672f200f4e99368270da205320b83efe01a0.
> 
> Let's get the SMMU driver building as a module, which means putting
> back some dead code that we used to carry.
> 
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  drivers/iommu/arm-smmu.c | 32 +++++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 7c503a6bc585..53bbe0663b9e 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -27,8 +27,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
> -#include <linux/init.h>
> -#include <linux/moduleparam.h>
> +#include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/of_device.h>
> @@ -59,10 +58,6 @@
>  #define MSI_IOVA_LENGTH			0x100000
>  
>  static int force_stage;
> -/*
> - * not really modular, but the easiest way to keep compat with existing
> - * bootargs behaviour is to continue using module_param() here.
> - */
>  module_param(force_stage, int, S_IRUGO);
>  MODULE_PARM_DESC(force_stage,
>  	"Force SMMU mappings to be installed at a particular stage of translation. A value of '1' or '2' forces the corresponding stage. All other values are ignored (i.e. no stage is forced). Note that selecting a specific stage will disable support for nested translation.");
> @@ -1878,6 +1873,7 @@ static const struct of_device_id arm_smmu_of_match[] = {
>  	{ .compatible = "qcom,smmu-v2", .data = &qcom_smmuv2 },
>  	{ },
>  };
> +MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
>  
>  #ifdef CONFIG_ACPI
>  static int acpi_smmu_get_data(u32 model, struct arm_smmu_device *smmu)
> @@ -2165,12 +2161,12 @@ static int arm_smmu_legacy_bus_init(void)
>  }
>  device_initcall_sync(arm_smmu_legacy_bus_init);
>  
> -static void arm_smmu_device_shutdown(struct platform_device *pdev)
> +static int arm_smmu_device_remove(struct platform_device *pdev)
>  {
>  	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
>  
>  	if (!smmu)
> -		return;
> +		return -ENODEV;
>  
>  	if (!bitmap_empty(smmu->context_map, ARM_SMMU_MAX_CBS))
>  		dev_err(&pdev->dev, "removing device with active domains!\n");
> @@ -2186,6 +2182,12 @@ static void arm_smmu_device_shutdown(struct platform_device *pdev)
>  		clk_bulk_disable(smmu->num_clks, smmu->clks);
>  
>  	clk_bulk_unprepare(smmu->num_clks, smmu->clks);
> +	return 0;
> +}
> +
> +static void arm_smmu_device_shutdown(struct platform_device *pdev)
> +{
> +	arm_smmu_device_remove(pdev);
>  }
>  
>  static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)
> @@ -2235,12 +2237,16 @@ static const struct dev_pm_ops arm_smmu_pm_ops = {
>  
>  static struct platform_driver arm_smmu_driver = {
>  	.driver	= {
> -		.name			= "arm-smmu",
> -		.of_match_table		= of_match_ptr(arm_smmu_of_match),
> -		.pm			= &arm_smmu_pm_ops,
> -		.suppress_bind_attrs	= true,
> +		.name		= "arm-smmu",
> +		.of_match_table	= of_match_ptr(arm_smmu_of_match),
> +		.pm		= &arm_smmu_pm_ops,
>  	},
>  	.probe	= arm_smmu_device_probe,
> +	.remove	= arm_smmu_device_remove,
>  	.shutdown = arm_smmu_device_shutdown,
>  };
> -builtin_platform_driver(arm_smmu_driver);
> +module_platform_driver(arm_smmu_driver);

I know this is a revert, but wouldn't you still want to be at device_init()
level for built in drivers? It always preferable to not defer if given the
choice to do so and device_init() is the right level for this driver IMO.

Jordan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
