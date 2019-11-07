Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB4FFA372C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 06:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E501321882
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 06:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JyLxr2bS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfKGGF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 01:05:59 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57202 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfKGGF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 01:05:59 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xA765W3J009455;
        Thu, 7 Nov 2019 00:05:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573106732;
        bh=YkH6IrLLDyFL1c+gPK30RscWok8biguT1gLAoAK04AQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=JyLxr2bSWrMfVthmAEKDODjrRZchD+nNQJMItKW8Ks3I7yHaZWFw/NTIXH9LXMMTV
         AWIDb9F9kpT/SN5TyhUkE9A3n9+YvhAFnqXIVAhig0y+YtQuKiXYnB8pXVCcFtPIRZ
         hkM+tcR7Sy5I+tIxRrSnbGDOEawmANuil8TnT33M=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xA765W5w098483;
        Thu, 7 Nov 2019 00:05:32 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 7 Nov
 2019 00:05:16 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 7 Nov 2019 00:05:16 -0600
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xA765RSj099257;
        Thu, 7 Nov 2019 00:05:28 -0600
Subject: Re: [PATCH 1/2] mtd: mtk-quadspi: add support for memory-mapped flash
 reading
To:     Chuanhong Guo <gch981213@gmail.com>,
        <linux-mtd@lists.infradead.org>
CC:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20191106140748.13100-1-gch981213@gmail.com>
 <20191106140748.13100-2-gch981213@gmail.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <bc917a56-e688-d701-2279-87df460d6055@ti.com>
Date:   Thu, 7 Nov 2019 11:36:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191106140748.13100-2-gch981213@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/11/19 7:37 PM, Chuanhong Guo wrote:
> PIO reading mode on this controller is ridiculously inefficient
> (one cmd+addr+dummy sequence reads only one byte)
> This patch adds support for reading from memory-mapped flash area
> which increases reading speed from 1MB/s to 5.6MB/s
> 
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> ---
>  drivers/mtd/spi-nor/mtk-quadspi.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/mtk-quadspi.c b/drivers/mtd/spi-nor/mtk-quadspi.c
> index 34db01ab6cab..ba8b3be39896 100644
> --- a/drivers/mtd/spi-nor/mtk-quadspi.c
> +++ b/drivers/mtd/spi-nor/mtk-quadspi.c
> @@ -106,6 +106,7 @@ struct mtk_nor {
>  	struct spi_nor nor;
>  	struct device *dev;
>  	void __iomem *base;	/* nor flash base address */
> +	void __iomem *flash_base;
>  	struct clk *spi_clk;
>  	struct clk *nor_clk;
>  };
> @@ -272,6 +273,11 @@ static ssize_t mtk_nor_read(struct spi_nor *nor, loff_t from, size_t length,
>  	mtk_nor_set_read_mode(mtk_nor);
>  	mtk_nor_set_addr(mtk_nor, addr);
>  
> +	if (mtk_nor->flash_base) {
> +		memcpy_fromio(buffer, mtk_nor->flash_base + from, length);
> +		return length;
> +	}
> +

Don't you need to check if access is still within valid memory mapped
window?

>  	for (i = 0; i < length; i++) {
>  		ret = mtk_nor_execute_cmd(mtk_nor, MTK_NOR_PIO_READ_CMD);
>  		if (ret < 0)
> @@ -475,6 +481,11 @@ static int mtk_nor_drv_probe(struct platform_device *pdev)
>  	if (IS_ERR(mtk_nor->base))
>  		return PTR_ERR(mtk_nor->base);
>  
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	mtk_nor->flash_base = devm_ioremap_resource(&pdev->dev, res);

There is a single API now: devm_platform_ioremap_resource().

> +	if (IS_ERR(mtk_nor->flash_base))
> +		mtk_nor->flash_base = NULL;
> +
>  	mtk_nor->spi_clk = devm_clk_get(&pdev->dev, "spi");
>  	if (IS_ERR(mtk_nor->spi_clk))
>  		return PTR_ERR(mtk_nor->spi_clk);
> 

-- 
Regards
Vignesh
