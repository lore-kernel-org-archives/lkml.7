Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCCCC31E48
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 04:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DC8420874
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 04:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560315452;
	bh=wd2149PBzfIH5Tyo7dV50mGQ50f22EKBdPxxPt8UKbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=csOLYaJCKBxHoIZ+iIUALAb+/Go4GbPM6wJpEtmPyjY/jKH7NUISfXfD3JltNTIFp
	 Mk4Q8nj19vg+ymne5QoBWuh5lM6HszssYXJINURhnHW9xTVTWJGSzD8T5H7Rdsqw6o
	 hvt1eH5FQ3T3M+yLynrzKxEGu8iNmy0dUGbOV78s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730381AbfFLE5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 00:57:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:43094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbfFLE5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 00:57:31 -0400
Received: from localhost (unknown [106.200.205.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 373CC20866;
        Wed, 12 Jun 2019 04:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560315450;
        bh=wd2149PBzfIH5Tyo7dV50mGQ50f22EKBdPxxPt8UKbQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z65Rj73quB9MLOYs/h2T6t7ExrIQimLogxR0aGLWski5KDXH1xSWS05I/zrQ48PhQ
         omROdZbnbeRtpvEkLNkeftJgwNe48IeLt2gphNYRj/B/x6ABPnvilDjbqqPOU+SBOv
         UrOyWd5uYBH0M+pFZH8F+0ap0IbTW4Q8T6A8yhrg=
Date:   Wed, 12 Jun 2019 10:24:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     gustavo.pimentel@synopsys.com, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH -next] dmaengine: dw-edma: Fix build error without
 CONFIG_PCI_MSI
Message-ID: <20190612045423.GZ9160@vkoul-mobl.Dlink>
References: <20190612041954.256-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612041954.256-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-06-19, 12:19, YueHaibing wrote:
> If CONFIG_PCI_MSI is not set, building with CONFIG_DW_EDMA
> fails:
> 
> drivers/dma/dw-edma/dw-edma-core.c: In function dw_edma_irq_request:
> drivers/dma/dw-edma/dw-edma-core.c:784:21: error: implicit declaration of function pci_irq_vector; did you mean rcu_irq_enter? [-Werror=implicit-function-declaration]
>    err = request_irq(pci_irq_vector(to_pci_dev(dev), 0),
>                      ^~~~~~~~~~~~~~

Applied with adding reported by Randy as well, thanks

> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: e63d79d1ffcd ("dmaengine: Add Synopsys eDMA IP core driver")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/dma/dw-edma/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dma/dw-edma/Kconfig b/drivers/dma/dw-edma/Kconfig
> index c0838ce..7ff17b2 100644
> --- a/drivers/dma/dw-edma/Kconfig
> +++ b/drivers/dma/dw-edma/Kconfig
> @@ -2,6 +2,7 @@
>  
>  config DW_EDMA
>  	tristate "Synopsys DesignWare eDMA controller driver"
> +	depends on PCI && PCI_MSI
>  	select DMA_ENGINE
>  	select DMA_VIRTUAL_CHANNELS
>  	help
> -- 
> 2.7.4
> 

-- 
~Vinod
