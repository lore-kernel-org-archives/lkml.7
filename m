Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C315FC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89FFC21734
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iCxoFq90"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfDIQ32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 12:29:28 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:51474 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbfDIQ31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 12:29:27 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x39GTLRN005704;
        Tue, 9 Apr 2019 11:29:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554827361;
        bh=JDdIj5uHNTxZ+fq5ZDqM9wTxpltPlTL2Apver4F3+/o=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=iCxoFq90P4qKm2zk00l04HJmhDelwYVv2WbnfOfo1LMvFlP2xTPBMTh7cizMx0tZm
         UGtEgvyyjpjyuIQaOZJH8giNohxDHLJ/8V2EwtgBDSIXr5TY5rg3GjtIUFvm7TOKsp
         y/Q7pFtFdzmHtyuvUVk+QHZehqc8+DtJd7Png+HA=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x39GTLZu098833
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Apr 2019 11:29:21 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 9 Apr
 2019 11:29:21 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 9 Apr 2019 11:29:21 -0500
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x39GTJXI042955;
        Tue, 9 Apr 2019 11:29:19 -0500
Subject: Re: [PATCH] spi: spi-mem: Fix build error without CONFIG_SPI_MEM
To:     Yue Haibing <yuehaibing@huawei.com>, <broonie@kernel.org>,
        <naga.sureshkumar.relli@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
References: <20190408143949.10688-1-yuehaibing@huawei.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <4c9cb550-e0b6-8f66-979d-ab8237e28166@ti.com>
Date:   Tue, 9 Apr 2019 22:00:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408143949.10688-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/19 8:09 PM, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> When building with CONFIG_SPI_MEM is not set
> gc warns this:
> 
> drivers/spi/spi-zynq-qspi.o: In function `zynq_qspi_supports_op':
> spi-zynq-qspi.c:(.text+0x1da): undefined reference to `spi_mem_default_supports_op'
> 
> Fixes: 67dca5e580f1 ("spi: spi-mem: Add support for Zynq QSPI controller")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  include/linux/spi/spi-mem.h | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
> index c845cd6..1941b84 100644
> --- a/include/linux/spi/spi-mem.h
> +++ b/include/linux/spi/spi-mem.h
> @@ -295,6 +295,10 @@ int spi_controller_dma_map_mem_op_data(struct spi_controller *ctlr,
>  void spi_controller_dma_unmap_mem_op_data(struct spi_controller *ctlr,
>  					  const struct spi_mem_op *op,
>  					  struct sg_table *sg);
> +
> +bool spi_mem_default_supports_op(struct spi_mem *mem,
> +				 const struct spi_mem_op *op);
> +
>  #else
>  static inline int
>  spi_controller_dma_map_mem_op_data(struct spi_controller *ctlr,
> @@ -310,6 +314,13 @@ spi_controller_dma_unmap_mem_op_data(struct spi_controller *ctlr,
>  				     struct sg_table *sg)
>  {
>  }
> +
> +bool spi_mem_default_supports_op(struct spi_mem *mem,
> +				 const struct spi_mem_op *op)

This needs to be declared static inline to avoid multiple definitions.
Right?

> +{
> +	return false;
> +}
> +
>  #endif /* CONFIG_SPI_MEM */
>  
>  int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op);
> @@ -341,9 +352,6 @@ int spi_mem_driver_register_with_owner(struct spi_mem_driver *drv,
>  
>  void spi_mem_driver_unregister(struct spi_mem_driver *drv);
>  
> -bool spi_mem_default_supports_op(struct spi_mem *mem,
> -				 const struct spi_mem_op *op);
> -
>  #define spi_mem_driver_register(__drv)                                  \
>  	spi_mem_driver_register_with_owner(__drv, THIS_MODULE)
>  
> 

-- 
Regards
Vignesh
