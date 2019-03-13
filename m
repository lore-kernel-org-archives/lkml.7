Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C52C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 12:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D85282171F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 12:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="TuXu8Ijs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfCMMLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 08:11:49 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:1437 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfCMMLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 08:11:49 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c88f3850002>; Wed, 13 Mar 2019 05:11:50 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 13 Mar 2019 05:11:48 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 13 Mar 2019 05:11:48 -0700
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 13 Mar
 2019 12:11:46 +0000
Subject: Re: [PATCH v3 2/2] dmaengine: tegra210-adma: update system sleep
 callbacks
To:     Sameer Pujar <spujar@nvidia.com>, <dan.j.williams@intel.com>,
        <vkoul@kernel.org>
CC:     <treding@nvidia.com>, <dmaengine@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1552476757-22360-1-git-send-email-spujar@nvidia.com>
 <1552476757-22360-2-git-send-email-spujar@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <c93afa7f-f7af-a9d6-03ec-0d610dc78932@nvidia.com>
Date:   Wed, 13 Mar 2019 12:11:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1552476757-22360-2-git-send-email-spujar@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1552479110; bh=+O7rx/nQifaa0kmT6WmQEnsI1XskqiNJ1CPaWizXBWA=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=TuXu8Ijs+VEv4aJQCKvPYtNtVEM5wnfRJbmYcOBwDTDP8uVvL2j16Y8iQAxqf9lBe
         PJs+T/VOIzXh2cq2//Xif9b1XUYFA+C8mFT+57FK4GN6J6TVxXtl2oAggpvF5vRlG6
         HJAyPEG7YuAtBBAzL0K/PnehORks0zPor+MbgvKgj6QLkdzix2p+y8wNMTvnNeCKus
         ed30CRNDCoxNLNMocPkNL4i98Bs6Pq5NrSXx4fdYw3sYQSC2Q04w9xQHumNf+b08m2
         FgAwB8SFNSMhN32uSNzKvMqXB32106vSwT8Tw52FgT/CCq7Ru7DC5LqHKV0LtdV32u
         9wgKYpk6GB2bA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/03/2019 11:32, Sameer Pujar wrote:
> If the driver is active till late suspend, where runtime PM cannot run,
> force suspend is essential in such case to put the device in low power
> state. Thus pm_runtime_force_suspend and pm_runtime_force_resume are
> used as system sleep callbacks during system wide PM transitions.
> Late system sleep callbacks are used to ensure, for instance, that the
> sound core has suspended any on-going activity, including stopping the
> ADMA if active, before we attempt to suspend the ADMA.
> 
> Suggested-by: Jonathan Hunter <jonathanh@nvidia.com>
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  drivers/dma/tegra210-adma.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
> index 650cd9c..253d312 100644
> --- a/drivers/dma/tegra210-adma.c
> +++ b/drivers/dma/tegra210-adma.c
> @@ -796,17 +796,11 @@ static int tegra_adma_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
> -static int tegra_adma_pm_suspend(struct device *dev)
> -{
> -	return pm_runtime_suspended(dev) == false;
> -}
> -#endif
> -
>  static const struct dev_pm_ops tegra_adma_dev_pm_ops = {
>  	SET_RUNTIME_PM_OPS(tegra_adma_runtime_suspend,
>  			   tegra_adma_runtime_resume, NULL)
> -	SET_SYSTEM_SLEEP_PM_OPS(tegra_adma_pm_suspend, NULL)
> +	SET_LATE_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +				     pm_runtime_force_resume)
>  };
>  
>  static struct platform_driver tegra_admac_driver = {

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
