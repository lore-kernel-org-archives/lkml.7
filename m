Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE613C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 17:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2FBA206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 17:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbfJHR6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 13:58:19 -0400
Received: from gloria.sntech.de ([185.11.138.130]:41550 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbfJHR6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 13:58:19 -0400
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iHtkV-0002h5-9E; Tue, 08 Oct 2019 19:58:15 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, dianders@chromium.org,
        mka@chromium.org, groeck@chromium.org, kernel@collabora.com,
        bleung@chromium.org, linux-rockchip@lists.infradead.org,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] iommu/rockchip: Don't loop until failure to count interrupts
Date:   Tue, 08 Oct 2019 19:58:14 +0200
Message-ID: <3132916.nyj3dfveGU@diego>
In-Reply-To: <20191008135843.30640-1-enric.balletbo@collabora.com>
References: <20191008135843.30640-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

Am Dienstag, 8. Oktober 2019, 15:58:43 CEST schrieb Enric Balletbo i Serra:
> As platform_get_irq() now prints an error when the interrupt does not
> exist, counting interrupts by looping until failure causes the printing
> of scary messages like:
> 
>  rk_iommu ff924000.iommu: IRQ index 1 not found
>  rk_iommu ff914000.iommu: IRQ index 1 not found
>  rk_iommu ff903f00.iommu: IRQ index 1 not found
>  rk_iommu ff8f3f00.iommu: IRQ index 1 not found
>  rk_iommu ff650800.iommu: IRQ index 1 not found
> 
> Fix this by using the platform_irq_count() helper to avoid touching
> non-existent interrupts.

It looks like we did the same fix ... see my patch from september 25:
https://patchwork.kernel.org/patch/11161221/


> Fixes: 7723f4c5ecdb8d83 ("driver core: platform: Add an error message to platform_get_irq*()")
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
>  drivers/iommu/rockchip-iommu.c | 35 +++++++++++++++++++++++-----------
>  1 file changed, 24 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 26290f310f90..8c6318bd1b37 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -1136,7 +1136,7 @@ static int rk_iommu_probe(struct platform_device *pdev)
>  	struct rk_iommu *iommu;
>  	struct resource *res;
>  	int num_res = pdev->num_resources;
> -	int err, i, irq;
> +	int err, i, irq, num_irqs;
>  
>  	iommu = devm_kzalloc(dev, sizeof(*iommu), GFP_KERNEL);
>  	if (!iommu)
> @@ -1219,20 +1219,28 @@ static int rk_iommu_probe(struct platform_device *pdev)
>  
>  	pm_runtime_enable(dev);
>  
> -	i = 0;
> -	while ((irq = platform_get_irq(pdev, i++)) != -ENXIO) {
> -		if (irq < 0)
> -			return irq;
> +	num_irqs = platform_irq_count(pdev);
> +	if (num_irqs < 0) {
> +		err = num_irqs;
> +		goto err_disable_pm_runtime;
> +	}

By moving the basic irq count above the pm_runtime_enable
you save some lines and the whole goto logic ... see my patch
for reference :-D

Heiko

> +
> +	for (i = 0; i < num_irqs; i++) {
> +		irq = platform_get_irq(pdev, i);
> +		if (irq < 0) {
> +			err = irq;
> +			goto err_disable_pm_runtime;
> +		}
>  
>  		err = devm_request_irq(iommu->dev, irq, rk_iommu_irq,
>  				       IRQF_SHARED, dev_name(dev), iommu);
> -		if (err) {
> -			pm_runtime_disable(dev);
> -			goto err_remove_sysfs;
> -		}
> +		if (err)
> +			goto err_disable_pm_runtime;
>  	}
>  
>  	return 0;
> +err_disable_pm_runtime:
> +	pm_runtime_disable(dev);
>  err_remove_sysfs:
>  	iommu_device_sysfs_remove(&iommu->iommu);
>  err_put_group:
> @@ -1245,10 +1253,15 @@ static int rk_iommu_probe(struct platform_device *pdev)
>  static void rk_iommu_shutdown(struct platform_device *pdev)
>  {
>  	struct rk_iommu *iommu = platform_get_drvdata(pdev);
> -	int i = 0, irq;
> +	int i, irq, num_irqs;
>  
> -	while ((irq = platform_get_irq(pdev, i++)) != -ENXIO)
> +	num_irqs = platform_irq_count(pdev);
> +	for (i = 0; i < num_irqs; i++) {
> +		irq = platform_get_irq(pdev, i);
> +		if (irq < 0)
> +			continue;
>  		devm_free_irq(iommu->dev, irq, iommu);
> +	}
>  
>  	pm_runtime_force_suspend(&pdev->dev);
>  }
> 




