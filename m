Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D43C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 09:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E682173E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 09:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="U5qB+MFr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbfKFJS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 04:18:57 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:51504 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfKFJS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 04:18:57 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xA69IcxD067545;
        Wed, 6 Nov 2019 03:18:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573031918;
        bh=eldzo8YWe5MamJNiigJfyEJUufaORNMZTQ1Z2CgzULc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=U5qB+MFrnN88rFoGyyYQkKCueJVXXaxryE8U0eoUby4U5nJbeHbmVzBrxURQ1GD2p
         gETubghjWq98LjZE040mYFK5DkzPnL9HOE0tfc1zgGzX3lG/g3kLqM6B7MPHpz5T7+
         4QSlYCTeXy2njOgSj9S7btAwLKCJViL1nxN/yRWw=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xA69IcxR087453
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Nov 2019 03:18:38 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 6 Nov
 2019 03:18:23 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 6 Nov 2019 03:18:38 -0600
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xA69IYtN114855;
        Wed, 6 Nov 2019 03:18:36 -0600
Subject: Re: [PATCH v4 03/20] mtd: spi-nor: Check for errors after each
 Register Operation
To:     <Tudor.Ambarus@microchip.com>, <boris.brezillon@collabora.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20191102112316.20715-1-tudor.ambarus@microchip.com>
 <20191102112316.20715-4-tudor.ambarus@microchip.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <f25eab6d-4ccd-09c2-6ce1-fa6f00ca9367@ti.com>
Date:   Wed, 6 Nov 2019 14:49:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191102112316.20715-4-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/11/19 4:53 PM, Tudor.Ambarus@microchip.com wrote:
> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Check for the return vales of each Register Operation.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---


Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

Regards
Vignesh

>  drivers/mtd/spi-nor/spi-nor.c | 81 ++++++++++++++++++++++++++++++++-----------
>  1 file changed, 60 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 0cb3122e74ad..5debb0f7ca13 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -595,11 +595,15 @@ static int st_micron_set_4byte(struct spi_nor *nor, bool enable)
>  {
>  	int ret;
>  
> -	spi_nor_write_enable(nor);
> +	ret = spi_nor_write_enable(nor);
> +	if (ret)
> +		return ret;
> +
>  	ret = macronix_set_4byte(nor, enable);
> -	spi_nor_write_disable(nor);
> +	if (ret)
> +		return ret;
>  
> -	return ret;
> +	return spi_nor_write_disable(nor);
>  }
>  
>  static int spansion_set_4byte(struct spi_nor *nor, bool enable)
> @@ -665,11 +669,15 @@ static int winbond_set_4byte(struct spi_nor *nor, bool enable)
>  	 * Register to be set to 1, so all 3-byte-address reads come from the
>  	 * second 16M. We must clear the register to enable normal behavior.
>  	 */
> -	spi_nor_write_enable(nor);
> +	ret = spi_nor_write_enable(nor);
> +	if (ret)
> +		return ret;
> +
>  	ret = spi_nor_write_ear(nor, 0);
> -	spi_nor_write_disable(nor);
> +	if (ret)
> +		return ret;
>  
> -	return ret;
> +	return spi_nor_write_disable(nor);
>  }
>  
>  static int spi_nor_xread_sr(struct spi_nor *nor, u8 *sr)
> @@ -859,7 +867,9 @@ static int spi_nor_write_sr_cr(struct spi_nor *nor, const u8 *sr_cr)
>  {
>  	int ret;
>  
> -	spi_nor_write_enable(nor);
> +	ret = spi_nor_write_enable(nor);
> +	if (ret)
> +		return ret;
>  
>  	if (nor->spimem) {
>  		struct spi_mem_op op =
> @@ -889,7 +899,10 @@ static int spi_nor_write_sr_and_check(struct spi_nor *nor, u8 status_new,
>  {
>  	int ret;
>  
> -	spi_nor_write_enable(nor);
> +	ret = spi_nor_write_enable(nor);
> +	if (ret)
> +		return ret;
> +
>  	ret = spi_nor_write_sr(nor, status_new);
>  	if (ret)
>  		return ret;
> @@ -1397,7 +1410,9 @@ static int spi_nor_erase_multi_sectors(struct spi_nor *nor, u64 addr, u32 len)
>  	list_for_each_entry_safe(cmd, next, &erase_list, list) {
>  		nor->erase_opcode = cmd->opcode;
>  		while (cmd->count) {
> -			spi_nor_write_enable(nor);
> +			ret = spi_nor_write_enable(nor);
> +			if (ret)
> +				goto destroy_erase_cmd_list;
>  
>  			ret = spi_nor_erase_sector(nor, addr);
>  			if (ret)
> @@ -1452,7 +1467,9 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
>  	if (len == mtd->size && !(nor->flags & SNOR_F_NO_OP_CHIP_ERASE)) {
>  		unsigned long timeout;
>  
> -		spi_nor_write_enable(nor);
> +		ret = spi_nor_write_enable(nor);
> +		if (ret)
> +			goto erase_err;
>  
>  		ret = spi_nor_erase_chip(nor);
>  		if (ret)
> @@ -1479,7 +1496,9 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
>  	/* "sector"-at-a-time erase */
>  	} else if (spi_nor_has_uniform_erase(nor)) {
>  		while (len) {
> -			spi_nor_write_enable(nor);
> +			ret = spi_nor_write_enable(nor);
> +			if (ret)
> +				goto erase_err;
>  
>  			ret = spi_nor_erase_sector(nor, addr);
>  			if (ret)
> @@ -1500,7 +1519,7 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
>  			goto erase_err;
>  	}
>  
> -	spi_nor_write_disable(nor);
> +	ret = spi_nor_write_disable(nor);
>  
>  erase_err:
>  	spi_nor_unlock_and_unprep(nor, SPI_NOR_OPS_ERASE);
> @@ -1849,9 +1868,13 @@ static int macronix_quad_enable(struct spi_nor *nor)
>  	if (nor->bouncebuf[0] & SR_QUAD_EN_MX)
>  		return 0;
>  
> -	spi_nor_write_enable(nor);
> +	ret = spi_nor_write_enable(nor);
> +	if (ret)
> +		return ret;
>  
> -	spi_nor_write_sr(nor, nor->bouncebuf[0] | SR_QUAD_EN_MX);
> +	ret = spi_nor_write_sr(nor, nor->bouncebuf[0] | SR_QUAD_EN_MX);
> +	if (ret)
> +		return ret;
>  
>  	ret = spi_nor_wait_till_ready(nor);
>  	if (ret)
> @@ -2022,7 +2045,9 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor)
>  	/* Update the Quad Enable bit. */
>  	*sr2 |= SR2_QUAD_EN_BIT7;
>  
> -	spi_nor_write_enable(nor);
> +	ret = spi_nor_write_enable(nor);
> +	if (ret)
> +		return ret;
>  
>  	ret = spi_nor_write_sr2(nor, sr2);
>  	if (ret)
> @@ -2063,7 +2088,9 @@ static int spi_nor_clear_sr_bp(struct spi_nor *nor)
>  	if (ret)
>  		return ret;
>  
> -	spi_nor_write_enable(nor);
> +	ret = spi_nor_write_enable(nor);
> +	if (ret)
> +		return ret;
>  
>  	ret = spi_nor_write_sr(nor, nor->bouncebuf[0] & ~mask);
>  	if (ret)
> @@ -2680,7 +2707,9 @@ static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
>  	if (ret)
>  		return ret;
>  
> -	spi_nor_write_enable(nor);
> +	ret = spi_nor_write_enable(nor);
> +	if (ret)
> +		goto sst_write_err;
>  
>  	nor->sst_write_second = false;
>  
> @@ -2718,14 +2747,19 @@ static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
>  	}
>  	nor->sst_write_second = false;
>  
> -	spi_nor_write_disable(nor);
> +	ret = spi_nor_write_disable(nor);
> +	if (ret)
> +		goto sst_write_err;
> +
>  	ret = spi_nor_wait_till_ready(nor);
>  	if (ret)
>  		goto sst_write_err;
>  
>  	/* Write out trailing byte if it exists. */
>  	if (actual != len) {
> -		spi_nor_write_enable(nor);
> +		ret = spi_nor_write_enable(nor);
> +		if (ret)
> +			goto sst_write_err;
>  
>  		nor->program_opcode = SPINOR_OP_BP;
>  		ret = spi_nor_write_data(nor, to, 1, buf + actual);
> @@ -2735,8 +2769,10 @@ static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
>  		ret = spi_nor_wait_till_ready(nor);
>  		if (ret)
>  			goto sst_write_err;
> -		spi_nor_write_disable(nor);
> +
>  		actual += 1;
> +
> +		ret = spi_nor_write_disable(nor);
>  	}
>  sst_write_err:
>  	*retlen += actual;
> @@ -2787,7 +2823,10 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
>  
>  		addr = spi_nor_convert_addr(nor, addr);
>  
> -		spi_nor_write_enable(nor);
> +		ret = spi_nor_write_enable(nor);
> +		if (ret)
> +			goto write_err;
> +
>  		ret = spi_nor_write_data(nor, addr, page_remain, buf + i);
>  		if (ret < 0)
>  			goto write_err;
> 

-- 
Regards
Vignesh
