Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9096C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 05:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53BEF214D8
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 05:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="H2bAuAd9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfKFFpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 00:45:47 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47082 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbfKFFpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 00:45:46 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xA65jVnw066184;
        Tue, 5 Nov 2019 23:45:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573019131;
        bh=F+2KCiRVtt38KnE0aoSA04LjhA8ClGxqrZ5iELh5C9Q=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=H2bAuAd99tEJLZRqsLOArOvhB4rfFLkWxBK+PcW2rDeP2NFxxKx1mpCtULzqKSBSi
         4M9LGisJGMqDYqHpnyiePall+Jxt837DnmKxQ2VDpe2WVe6tAYTakAcw9FInjOuZdu
         m08A6LkWl5JKHfj3nsJcu+G1KvLb+Us5tOBnkNG4=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xA65jVh4040135
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Nov 2019 23:45:31 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 5 Nov
 2019 23:45:16 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 5 Nov 2019 23:45:16 -0600
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xA65jTIr128203;
        Tue, 5 Nov 2019 23:45:29 -0600
Subject: Re: [PATCH v4 17/20] mtd: spi-nor: Merge spansion Quad Enable methods
To:     <Tudor.Ambarus@microchip.com>, <boris.brezillon@collabora.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20191102112316.20715-1-tudor.ambarus@microchip.com>
 <20191102112316.20715-18-tudor.ambarus@microchip.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <b82f9dd6-5b49-21a0-0720-5f46f53f8cc0@ti.com>
Date:   Wed, 6 Nov 2019 11:16:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191102112316.20715-18-tudor.ambarus@microchip.com>
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
> Merge
>     spansion_no_read_cr_quad_enable()
>     spansion_read_cr_quad_enable()
> into
>     spi_nor_sr2_bit1_quad_enable().
> 
> Reduce code duplication by introducing spi_nor_write_16bit_cr_and_check().
> The Configuration Register contains bits that can be updated in future:
> FREEZE, CMP. Provide a generic method that allows updating all bits
> of the Configuration Register.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

Regards
Vignesh

> ---
>  drivers/mtd/spi-nor/spi-nor.c | 165 +++++++++++++++++-------------------------
>  1 file changed, 68 insertions(+), 97 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index e367a4862ec1..8bc29cc073a0 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -1055,6 +1055,59 @@ static int spi_nor_write_16bit_sr_and_check(struct spi_nor *nor, u8 sr1)
>  }
>  
>  /**
> + * spi_nor_write_16bit_cr_and_check() - Write the Status Register 1 and the
> + * Configuration Register in one shot. Ensure that the byte written in the
> + * Configuration Register match the received value, and that the 16-bit Write
> + * did not affect what was already in the Status Register 1.
> + * @nor:	pointer to a 'struct spi_nor'.
> + * @cr:		byte value to be written to the Configuration Register.
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
> +static int spi_nor_write_16bit_cr_and_check(struct spi_nor *nor, u8 cr)
> +{
> +	int ret;
> +	u8 *sr_cr = nor->bouncebuf;
> +	u8 sr_written;
> +
> +	/* Keep the current value of the Status Register 1. */
> +	ret = spi_nor_read_sr(nor, sr_cr);
> +	if (ret)
> +		return ret;
> +
> +	sr_cr[1] = cr;
> +
> +	ret = spi_nor_write_sr(nor, sr_cr, 2);
> +	if (ret)
> +		return ret;
> +
> +	sr_written = sr_cr[0];
> +
> +	ret = spi_nor_read_sr(nor, sr_cr);
> +	if (ret)
> +		return ret;
> +
> +	if (sr_written != sr_cr[0]) {
> +		dev_dbg(nor->dev, "SR: Read back test failed\n");
> +		return -EIO;
> +	}
> +
> +	if (nor->flags & SNOR_F_NO_READ_CR)
> +		return 0;
> +
> +	ret = spi_nor_read_cr(nor, &sr_cr[1]);
> +	if (ret)
> +		return ret;
> +
> +	if (cr != sr_cr[1]) {
> +		dev_dbg(nor->dev, "CR: read back test failed\n");
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
>   * spi_nor_write_sr_and_check() - Write the Status Register 1 and ensure that
>   * the byte written match the received value without affecting other bits in the
>   * Status Register 1 and 2.
> @@ -2051,111 +2104,29 @@ static int macronix_quad_enable(struct spi_nor *nor)
>  }
>  
>  /**
> - * spansion_no_read_cr_quad_enable() - set QE bit in Configuration Register.
> - * @nor:	pointer to a 'struct spi_nor'
> + * spi_nor_sr2_bit1_quad_enable() - set the Quad Enable BIT(1) in the Status
> + * Register 2.
> + * @nor:       pointer to a 'struct spi_nor'.
>   *
> - * Set the Quad Enable (QE) bit in the Configuration Register.
> - * This function should be used with QSPI memories not supporting the Read
> - * Configuration Register (35h) instruction.
> - *
> - * bit 1 of the Configuration Register is the QE bit for Spansion like QSPI
> - * memories.
> + * Bit 1 of the Status Register 2 is the QE bit for Spansion like QSPI memories.
>   *
>   * Return: 0 on success, -errno otherwise.
>   */
> -static int spansion_no_read_cr_quad_enable(struct spi_nor *nor)
> +static int spi_nor_sr2_bit1_quad_enable(struct spi_nor *nor)
>  {
> -	u8 *sr_cr = nor->bouncebuf;
>  	int ret;
> -	u8 sr_written;
> -
> -	/* Keep the current value of the Status Register. */
> -	ret = spi_nor_read_sr(nor, sr_cr);
> -	if (ret)
> -		return ret;
> -
> -	sr_cr[1] = SR2_QUAD_EN_BIT1;
> -
> -	ret = spi_nor_write_sr(nor, sr_cr, 2);
> -	if (ret)
> -		return ret;
>  
> -	sr_written = sr_cr[0];
> -
> -	ret = spi_nor_read_sr(nor, sr_cr);
> -	if (ret)
> -		return ret;
> -
> -	if (sr_cr[0] != sr_written) {
> -		dev_err(nor->dev, "SR: Read back test failed\n");
> -		return -EIO;
> -	}
> -
> -	return 0;
> -}
> -
> -/**
> - * spansion_read_cr_quad_enable() - set QE bit in Configuration Register.
> - * @nor:	pointer to a 'struct spi_nor'
> - *
> - * Set the Quad Enable (QE) bit in the Configuration Register.
> - * This function should be used with QSPI memories supporting the Read
> - * Configuration Register (35h) instruction.
> - *
> - * bit 1 of the Configuration Register is the QE bit for Spansion like QSPI
> - * memories.
> - *
> - * Return: 0 on success, -errno otherwise.
> - */
> -static int spansion_read_cr_quad_enable(struct spi_nor *nor)
> -{
> -	u8 *sr_cr = nor->bouncebuf;
> -	int ret;
> -	u8 sr_written;
> +	if (nor->flags & SNOR_F_NO_READ_CR)
> +		return spi_nor_write_16bit_cr_and_check(nor, SR2_QUAD_EN_BIT1);
>  
> -	/* Check current Quad Enable bit value. */
> -	ret = spi_nor_read_cr(nor, &sr_cr[1]);
> +	ret = spi_nor_read_cr(nor, nor->bouncebuf);
>  	if (ret)
>  		return ret;
>  
> -	if (sr_cr[1] & SR2_QUAD_EN_BIT1)
> +	if (nor->bouncebuf[0] & SR2_QUAD_EN_BIT1)
>  		return 0;
>  
> -	sr_cr[1] |= SR2_QUAD_EN_BIT1;
> -
> -	/* Keep the current value of the Status Register. */
> -	ret = spi_nor_read_sr(nor, sr_cr);
> -	if (ret)
> -		return ret;
> -
> -	ret = spi_nor_write_sr(nor, sr_cr, 2);
> -	if (ret)
> -		return ret;
> -
> -	sr_written = sr_cr[0];
> -
> -	ret = spi_nor_read_sr(nor, sr_cr);
> -	if (ret)
> -		return ret;
> -
> -	if (sr_written != sr_cr[0]) {
> -		dev_err(nor->dev, "SR: Read back test failed\n");
> -		return -EIO;
> -	}
> -
> -	sr_written = sr_cr[1];
> -
> -	/* Read back and check it. */
> -	ret = spi_nor_read_cr(nor, &sr_cr[1]);
> -	if (ret)
> -		return ret;
> -
> -	if (sr_cr[1] != sr_written) {
> -		dev_dbg(nor->dev, "CR: Read back test failed\n");
> -		return -EIO;
> -	}
> -
> -	return 0;
> +	return spi_nor_write_16bit_cr_and_check(nor, nor->bouncebuf[0]);
>  }
>  
>  /**
> @@ -2235,7 +2206,7 @@ static int spi_nor_clear_sr_bp(struct spi_nor *nor)
>   *
>   * Read-modify-write function that clears the Block Protection bits from the
>   * Status Register without affecting other bits. The function is tightly
> - * coupled with the spansion_read_cr_quad_enable() function. Both assume that
> + * coupled with the spi_nor_sr2_bit1_quad_enable() function. Both assume that
>   * the Write Register with 16 bits, together with the Read Configuration
>   * Register (35h) instructions are supported.
>   *
> @@ -3753,7 +3724,7 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
>  		 * supported.
>  		 */
>  		nor->flags |= SNOR_F_HAS_16BIT_SR | SNOR_F_NO_READ_CR;
> -		params->quad_enable = spansion_no_read_cr_quad_enable;
> +		params->quad_enable = spi_nor_sr2_bit1_quad_enable;
>  		break;
>  
>  	case BFPT_DWORD15_QER_SR1_BIT6:
> @@ -3775,7 +3746,7 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
>  		 */
>  		nor->flags |= SNOR_F_HAS_16BIT_SR;
>  
> -		params->quad_enable = spansion_read_cr_quad_enable;
> +		params->quad_enable = spi_nor_sr2_bit1_quad_enable;
>  		break;
>  
>  	default:
> @@ -4738,7 +4709,7 @@ static void spi_nor_info_init_params(struct spi_nor *nor)
>  	u8 i, erase_mask;
>  
>  	/* Initialize legacy flash parameters and settings. */
> -	params->quad_enable = spansion_read_cr_quad_enable;
> +	params->quad_enable = spi_nor_sr2_bit1_quad_enable;
>  	params->set_4byte = spansion_set_4byte;
>  	params->setup = spi_nor_default_setup;
>  	/* Default to 16-bit Write Status (01h) Command */
> @@ -4955,7 +4926,7 @@ static int spi_nor_init(struct spi_nor *nor)
>  	int err;
>  
>  	if (nor->clear_sr_bp) {
> -		if (nor->params.quad_enable == spansion_read_cr_quad_enable)
> +		if (nor->params.quad_enable == spi_nor_sr2_bit1_quad_enable)
>  			nor->clear_sr_bp = spi_nor_spansion_clear_sr_bp;
>  
>  		err = nor->clear_sr_bp(nor);
> 

-- 
Regards
Vignesh
