Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4359CC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1358C20880
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="F21bkXrx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfDIKuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 06:50:21 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:43802 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbfDIKuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 06:50:21 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x39AnrC1047784;
        Tue, 9 Apr 2019 05:49:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554806993;
        bh=CgRXcBR8umdVWoutcx4vOvOa55IENYFWhQNepuqf/Ns=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=F21bkXrx9sLYUqF0/AmH/MBnoNr6d1+bXdJpPlhyUqcZMa6w73WXZBhzkEX0sAMdF
         BhqO1C08uT790jr/LpE1UE2CVizD0gw7hD1h37BHgHrBIwh1ktlaJdonV9lEu1goMW
         DDlo53kzS9nltxGOnLA2rJKt7KKjBRc0rmQDW9/8=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x39AnrfC053031
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Apr 2019 05:49:53 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 9 Apr
 2019 05:49:53 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 9 Apr 2019 05:49:53 -0500
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x39Annq6041870;
        Tue, 9 Apr 2019 05:49:50 -0500
Subject: Re: [PATCH] mtd: spi-nor: cadence-quadspi: add reset control
To:     Dinh Nguyen <dinguyen@kernel.org>, <linux-mtd@lists.infradead.org>
CC:     <marex@denx.de>, Tien-Fong Chee <tien.fong.chee@intel.com>,
        <bbrezillon@kernel.org>, <tudor.ambarus@microchip.com>,
        <linux-kernel@vger.kernel.org>, <computersforpeace@gmail.com>,
        <dwmw2@infradead.org>
References: <20190408165046.24310-1-dinguyen@kernel.org>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <0e2b4c71-e634-6489-bccf-fd58b593288c@ti.com>
Date:   Tue, 9 Apr 2019 16:20:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408165046.24310-1-dinguyen@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/04/19 10:20 PM, Dinh Nguyen wrote:
> Get the reset control for the QSPI controller and bring it out of reset.
> 
> Suggested-by: Tien-Fong Chee <tien.fong.chee@intel.com>
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
>  drivers/mtd/spi-nor/cadence-quadspi.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
> index 792628750eec..710a853f9d13 100644
> --- a/drivers/mtd/spi-nor/cadence-quadspi.c
> +++ b/drivers/mtd/spi-nor/cadence-quadspi.c
> @@ -34,6 +34,7 @@
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/reset.h>
>  #include <linux/sched.h>
>  #include <linux/spi/spi.h>
>  #include <linux/timer.h>
> @@ -1336,6 +1337,7 @@ static int cqspi_probe(struct platform_device *pdev)
>  	struct cqspi_st *cqspi;
>  	struct resource *res;
>  	struct resource *res_ahb;
> +	struct reset_control *rstc;
>  	const struct cqspi_driver_platdata *ddata;
>  	int ret;
>  	int irq;
> @@ -1362,6 +1364,14 @@ static int cqspi_probe(struct platform_device *pdev)
>  		return PTR_ERR(cqspi->clk);
>  	}
>  
> +	/* Obtain QSPI reset control */
> +	rstc = devm_reset_control_get_exclusive(dev, NULL);
> +	if (!IS_ERR(rstc)) {
> +		reset_control_assert(rstc);
> +		udelay(1);
> +		reset_control_deassert(rstc);
> +	}
> +

If reset is optional here why not use
devm_reset_control_get_optional_exclusive() and handle error codes (like
-EPROBE_DEFER) appropriately instead of ignoring them?

>  	/* Obtain and remap controller address. */
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	cqspi->iobase = devm_ioremap_resource(dev, res);
> 

-- 
Regards
Vignesh
