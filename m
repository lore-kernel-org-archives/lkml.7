Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395AFC48BD9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 13:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 104B92086D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 13:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bOz1LZTI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfF0N1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 09:27:47 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:41396 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfF0N1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 09:27:46 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5RDRXvw060752;
        Thu, 27 Jun 2019 08:27:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1561642053;
        bh=xq/Qn8cyjc0wU5dUtTeO+f9uJWKfCB/3ok/DX4zAubo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=bOz1LZTIoZSzGVnXJ3yCUWh1AF44gQjGDX6nm8ZYYVMH3Fz4shwBBmOMbaHaFx2qS
         IZC3aQAXO9a17k/3I4i5gMw3MXFkezydNtljdXrS6wBfjnjiSidxJeHGA+kGXzxNXD
         ErgjRNGrHhjRmTJ7of8pOpoR6cpwy1BlEhL9g7wY=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5RDRXA1102542
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Jun 2019 08:27:33 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 27
 Jun 2019 08:27:33 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 27 Jun 2019 08:27:33 -0500
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5RDRUfv111336;
        Thu, 27 Jun 2019 08:27:31 -0500
Subject: Re: [PATCHv6 2/2] mtd: spi-nor: cadence-quadspi: add reset control
To:     Dinh Nguyen <dinguyen@kernel.org>, <linux-mtd@lists.infradead.org>
CC:     <marex@denx.de>, Tien-Fong Chee <tien.fong.chee@intel.com>,
        <bbrezillon@kernel.org>, <tudor.ambarus@microchip.com>,
        <linux-kernel@vger.kernel.org>, <computersforpeace@gmail.com>,
        <dwmw2@infradead.org>
References: <20190613113138.8280-1-dinguyen@kernel.org>
 <20190613113138.8280-2-dinguyen@kernel.org>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <ea6000bd-51ec-d9bd-7d48-e5bebcc621dd@ti.com>
Date:   Thu, 27 Jun 2019 18:58:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190613113138.8280-2-dinguyen@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/06/19 5:01 PM, Dinh Nguyen wrote:
> Get the reset control properties for the QSPI controller and bring them
> out of reset. Most will have just one reset bit, but there is an additional
> OCP reset bit that is used ECC. The OCP reset bit will also need to get
> de-asserted as well. [1]
> 
> The reason this patch is needed is in the case where a bootloader leaves
> the QSPI controller in a reset state, or a state where init cannot occur
> successfully, the patch will put the QSPI controller into a clean state.
> 
> [1] https://www.intel.com/content/www/us/en/programmable/hps/arria-10/hps.html#reg_soc_top/sfo1429890575955.html
> 
> Suggested-by: Tien-Fong Chee <tien.fong.chee@intel.com>
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---


Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

Regards
Vignesh

> v6: no need to check for reset pointer in assert/deassert as the call to
>     assert/deassert is already doing the checking
> v5: remove udelay(not needed) on tested hardware
>     group reset assert/deassert together
>     update commit message with reasoning for patch
> v4: fix compile error
> v3: return full error by using PTR_ERR(rtsc)
>     move reset control calls until after the clock enables
>     use udelay(2) to be safe
>     Add optional OCP(Open Core Protocol) reset signal
> v2: use devm_reset_control_get_optional_exclusive
>     print an error message
>     return -EPROBE_DEFER
> ---
>  drivers/mtd/spi-nor/cadence-quadspi.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
> index 792628750eec..732323c2adb1 100644
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
> @@ -1336,6 +1337,8 @@ static int cqspi_probe(struct platform_device *pdev)
>  	struct cqspi_st *cqspi;
>  	struct resource *res;
>  	struct resource *res_ahb;
> +	struct reset_control *rstc;
> +	struct reset_control *rstc_ocp;
>  	const struct cqspi_driver_platdata *ddata;
>  	int ret;
>  	int irq;
> @@ -1402,6 +1405,25 @@ static int cqspi_probe(struct platform_device *pdev)
>  		goto probe_clk_failed;
>  	}
>  
> +	/* Obtain QSPI reset control */
> +	rstc = devm_reset_control_get_optional_exclusive(dev, "qspi");
> +	if (IS_ERR(rstc)) {
> +		dev_err(dev, "Cannot get QSPI reset.\n");
> +		return PTR_ERR(rstc);
> +	}
> +
> +	rstc_ocp = devm_reset_control_get_optional_exclusive(dev, "qspi-ocp");
> +	if (IS_ERR(rstc_ocp)) {
> +		dev_err(dev, "Cannot get QSPI OCP reset.\n");
> +		return PTR_ERR(rstc_ocp);
> +	}
> +
> +	reset_control_assert(rstc);
> +	reset_control_deassert(rstc);
> +
> +	reset_control_assert(rstc_ocp);
> +	reset_control_deassert(rstc_ocp);
> +
>  	cqspi->master_ref_clk_hz = clk_get_rate(cqspi->clk);
>  	ddata  = of_device_get_match_data(dev);
>  	if (ddata && (ddata->quirks & CQSPI_NEEDS_WR_DELAY))
> 

-- 
Regards
Vignesh
