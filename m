Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626ACC010A2
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F86222C2
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UuvoaKLD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388440AbfKEMNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 07:13:35 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:50918 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfKEMNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 07:13:34 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xA5CDO5D010876;
        Tue, 5 Nov 2019 06:13:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1572956004;
        bh=qyWh625xmws47aGLbw95CGDPWr0YIK/1Ye/Irq28BmY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=UuvoaKLDfdss2z6qAGxGt2U0wgBmlkgf80RqbcpNhjvZTRZgD4Wn73FiG69rWpEUb
         zBX1lsXYzkYgrd310mAcFxRLkfZAfJv23zINpTwd5lwias7gjMjNOiJ1dDk+Vgm7qm
         APN7/q9JE5bzpadFDFUVyYSGt8GNxpfljlEbwvGU=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xA5CDO4F052004
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Nov 2019 06:13:24 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 5 Nov
 2019 06:13:09 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 5 Nov 2019 06:13:09 -0600
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xA5CDMKg077850;
        Tue, 5 Nov 2019 06:13:22 -0600
Subject: Re: [PATCH v4 02/20] mtd: spi-nor: Print debug info inside Reg Ops
 methods
To:     <Tudor.Ambarus@microchip.com>, <boris.brezillon@collabora.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20191102112316.20715-1-tudor.ambarus@microchip.com>
 <20191102112316.20715-3-tudor.ambarus@microchip.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <6f999f6f-3eff-98b6-a6af-a58a143e1171@ti.com>
Date:   Tue, 5 Nov 2019 17:43:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191102112316.20715-3-tudor.ambarus@microchip.com>
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
> Spare the callers of printing debug messages by themselves.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

Regards
Vignesh

> ---
>  drivers/mtd/spi-nor/spi-nor.c | 169 +++++++++++++++++++++++++++++++-----------
>  1 file changed, 127 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index eca6bce7c336..0cb3122e74ad 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -394,6 +394,8 @@ static ssize_t spi_nor_write_data(struct spi_nor *nor, loff_t to, size_t len,
>   */
>  static int spi_nor_write_enable(struct spi_nor *nor)
>  {
> +	int ret;
> +
>  	if (nor->spimem) {
>  		struct spi_mem_op op =
>  			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WREN, 1),
> @@ -401,10 +403,16 @@ static int spi_nor_write_enable(struct spi_nor *nor)
>  				   SPI_MEM_OP_NO_DUMMY,
>  				   SPI_MEM_OP_NO_DATA);
>  
> -		return spi_mem_exec_op(nor->spimem, &op);
> +		ret = spi_mem_exec_op(nor->spimem, &op);
> +	} else {
> +		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_WREN,
> +						     NULL, 0);
>  	}
>  
> -	return nor->controller_ops->write_reg(nor, SPINOR_OP_WREN, NULL, 0);
> +	if (ret)
> +		dev_dbg(nor->dev, "error %d on Write Enable\n", ret);
> +
> +	return ret;
>  }
>  
>  /*
> @@ -412,6 +420,8 @@ static int spi_nor_write_enable(struct spi_nor *nor)
>   */
>  static int spi_nor_write_disable(struct spi_nor *nor)
>  {
> +	int ret;
> +
>  	if (nor->spimem) {
>  		struct spi_mem_op op =
>  			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRDI, 1),
> @@ -419,10 +429,16 @@ static int spi_nor_write_disable(struct spi_nor *nor)
>  				   SPI_MEM_OP_NO_DUMMY,
>  				   SPI_MEM_OP_NO_DATA);
>  
> -		return spi_mem_exec_op(nor->spimem, &op);
> +		ret = spi_mem_exec_op(nor->spimem, &op);
> +	} else {
> +		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_WRDI,
> +						     NULL, 0);
>  	}
>  
> -	return nor->controller_ops->write_reg(nor, SPINOR_OP_WRDI, NULL, 0);
> +	if (ret)
> +		dev_dbg(nor->dev, "error %d on Write Disable\n", ret);
> +
> +	return ret;
>  }
>  
>  /**
> @@ -524,6 +540,8 @@ static int spi_nor_read_cr(struct spi_nor *nor, u8 *cr)
>   */
>  static int spi_nor_write_sr(struct spi_nor *nor, u8 val)
>  {
> +	int ret;
> +
>  	nor->bouncebuf[0] = val;
>  	if (nor->spimem) {
>  		struct spi_mem_op op =
> @@ -532,15 +550,23 @@ static int spi_nor_write_sr(struct spi_nor *nor, u8 val)
>  				   SPI_MEM_OP_NO_DUMMY,
>  				   SPI_MEM_OP_DATA_OUT(1, nor->bouncebuf, 1));
>  
> -		return spi_mem_exec_op(nor->spimem, &op);
> +		ret = spi_mem_exec_op(nor->spimem, &op);
> +	} else {
> +		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_WRSR,
> +						     nor->bouncebuf, 1);
>  	}
>  
> -	return nor->controller_ops->write_reg(nor, SPINOR_OP_WRSR,
> -					      nor->bouncebuf, 1);
> +	if (ret)
> +		dev_dbg(nor->dev, "error %d writing SR\n", ret);
> +
> +	return ret;
> +
>  }
>  
>  static int macronix_set_4byte(struct spi_nor *nor, bool enable)
>  {
> +	int ret;
> +
>  	if (nor->spimem) {
>  		struct spi_mem_op op =
>  			SPI_MEM_OP(SPI_MEM_OP_CMD(enable ?
> @@ -551,12 +577,18 @@ static int macronix_set_4byte(struct spi_nor *nor, bool enable)
>  				  SPI_MEM_OP_NO_DUMMY,
>  				  SPI_MEM_OP_NO_DATA);
>  
> -		return spi_mem_exec_op(nor->spimem, &op);
> +		ret = spi_mem_exec_op(nor->spimem, &op);
> +	} else {
> +		ret = nor->controller_ops->write_reg(nor,
> +						     enable ? SPINOR_OP_EN4B :
> +							      SPINOR_OP_EX4B,
> +						     NULL, 0);
>  	}
>  
> -	return nor->controller_ops->write_reg(nor, enable ? SPINOR_OP_EN4B :
> -							    SPINOR_OP_EX4B,
> -					      NULL, 0);
> +	if (ret)
> +		dev_dbg(nor->dev, "error %d setting 4-byte mode\n", ret);
> +
> +	return ret;
>  }
>  
>  static int st_micron_set_4byte(struct spi_nor *nor, bool enable)
> @@ -572,6 +604,8 @@ static int st_micron_set_4byte(struct spi_nor *nor, bool enable)
>  
>  static int spansion_set_4byte(struct spi_nor *nor, bool enable)
>  {
> +	int ret;
> +
>  	nor->bouncebuf[0] = enable << 7;
>  
>  	if (nor->spimem) {
> @@ -581,15 +615,22 @@ static int spansion_set_4byte(struct spi_nor *nor, bool enable)
>  				   SPI_MEM_OP_NO_DUMMY,
>  				   SPI_MEM_OP_DATA_OUT(1, nor->bouncebuf, 1));
>  
> -		return spi_mem_exec_op(nor->spimem, &op);
> +		ret = spi_mem_exec_op(nor->spimem, &op);
> +	} else {
> +		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_BRWR,
> +						     nor->bouncebuf, 1);
>  	}
>  
> -	return nor->controller_ops->write_reg(nor, SPINOR_OP_BRWR,
> -					      nor->bouncebuf, 1);
> +	if (ret)
> +		dev_dbg(nor->dev, "error %d setting 4-byte mode\n", ret);
> +
> +	return ret;
>  }
>  
>  static int spi_nor_write_ear(struct spi_nor *nor, u8 ear)
>  {
> +	int ret;
> +
>  	nor->bouncebuf[0] = ear;
>  
>  	if (nor->spimem) {
> @@ -599,11 +640,16 @@ static int spi_nor_write_ear(struct spi_nor *nor, u8 ear)
>  				   SPI_MEM_OP_NO_DUMMY,
>  				   SPI_MEM_OP_DATA_OUT(1, nor->bouncebuf, 1));
>  
> -		return spi_mem_exec_op(nor->spimem, &op);
> +		ret = spi_mem_exec_op(nor->spimem, &op);
> +	} else {
> +		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_WREAR,
> +						     nor->bouncebuf, 1);
>  	}
>  
> -	return nor->controller_ops->write_reg(nor, SPINOR_OP_WREAR,
> -					      nor->bouncebuf, 1);
> +	if (ret)
> +		dev_dbg(nor->dev, "error %d writing EAR\n", ret);
> +
> +	return ret;
>  }
>  
>  static int winbond_set_4byte(struct spi_nor *nor, bool enable)
> @@ -628,6 +674,8 @@ static int winbond_set_4byte(struct spi_nor *nor, bool enable)
>  
>  static int spi_nor_xread_sr(struct spi_nor *nor, u8 *sr)
>  {
> +	int ret;
> +
>  	if (nor->spimem) {
>  		struct spi_mem_op op =
>  			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_XRDSR, 1),
> @@ -635,10 +683,16 @@ static int spi_nor_xread_sr(struct spi_nor *nor, u8 *sr)
>  				   SPI_MEM_OP_NO_DUMMY,
>  				   SPI_MEM_OP_DATA_IN(1, sr, 1));
>  
> -		return spi_mem_exec_op(nor->spimem, &op);
> +		ret = spi_mem_exec_op(nor->spimem, &op);
> +	} else {
> +		ret = nor->controller_ops->read_reg(nor, SPINOR_OP_XRDSR,
> +						    sr, 1);
>  	}
>  
> -	return nor->controller_ops->read_reg(nor, SPINOR_OP_XRDSR, sr, 1);
> +	if (ret)
> +		dev_dbg(nor->dev, "error %d reading XRDSR\n", ret);
> +
> +	return ret;
>  }
>  
>  static int s3an_sr_ready(struct spi_nor *nor)
> @@ -646,16 +700,16 @@ static int s3an_sr_ready(struct spi_nor *nor)
>  	int ret;
>  
>  	ret = spi_nor_xread_sr(nor, nor->bouncebuf);
> -	if (ret) {
> -		dev_dbg(nor->dev, "error %d reading XRDSR\n", ret);
> +	if (ret)
>  		return ret;
> -	}
>  
>  	return !!(nor->bouncebuf[0] & XSR_RDY);
>  }
>  
>  static int spi_nor_clear_sr(struct spi_nor *nor)
>  {
> +	int ret;
> +
>  	if (nor->spimem) {
>  		struct spi_mem_op op =
>  			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_CLSR, 1),
> @@ -663,10 +717,16 @@ static int spi_nor_clear_sr(struct spi_nor *nor)
>  				   SPI_MEM_OP_NO_DUMMY,
>  				   SPI_MEM_OP_NO_DATA);
>  
> -		return spi_mem_exec_op(nor->spimem, &op);
> +		ret = spi_mem_exec_op(nor->spimem, &op);
> +	} else {
> +		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_CLSR,
> +						     NULL, 0);
>  	}
>  
> -	return nor->controller_ops->write_reg(nor, SPINOR_OP_CLSR, NULL, 0);
> +	if (ret)
> +		dev_dbg(nor->dev, "error %d clearing SR\n", ret);
> +
> +	return ret;
>  }
>  
>  static int spi_nor_sr_ready(struct spi_nor *nor)
> @@ -692,6 +752,8 @@ static int spi_nor_sr_ready(struct spi_nor *nor)
>  
>  static int spi_nor_clear_fsr(struct spi_nor *nor)
>  {
> +	int ret;
> +
>  	if (nor->spimem) {
>  		struct spi_mem_op op =
>  			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_CLFSR, 1),
> @@ -699,10 +761,16 @@ static int spi_nor_clear_fsr(struct spi_nor *nor)
>  				   SPI_MEM_OP_NO_DUMMY,
>  				   SPI_MEM_OP_NO_DATA);
>  
> -		return spi_mem_exec_op(nor->spimem, &op);
> +		ret = spi_mem_exec_op(nor->spimem, &op);
> +	} else {
> +		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_CLFSR,
> +						     NULL, 0);
>  	}
>  
> -	return nor->controller_ops->write_reg(nor, SPINOR_OP_CLFSR, NULL, 0);
> +	if (ret)
> +		dev_dbg(nor->dev, "error %d clearing FSR\n", ret);
> +
> +	return ret;
>  }
>  
>  static int spi_nor_fsr_ready(struct spi_nor *nor)
> @@ -839,6 +907,8 @@ static int spi_nor_write_sr_and_check(struct spi_nor *nor, u8 status_new,
>  
>  static int spi_nor_write_sr2(struct spi_nor *nor, const u8 *sr2)
>  {
> +	int ret;
> +
>  	if (nor->spimem) {
>  		struct spi_mem_op op =
>  			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRSR2, 1),
> @@ -846,14 +916,22 @@ static int spi_nor_write_sr2(struct spi_nor *nor, const u8 *sr2)
>  				   SPI_MEM_OP_NO_DUMMY,
>  				   SPI_MEM_OP_DATA_OUT(1, sr2, 1));
>  
> -		return spi_mem_exec_op(nor->spimem, &op);
> +		ret = spi_mem_exec_op(nor->spimem, &op);
> +	} else {
> +		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_WRSR2,
> +						     sr2, 1);
>  	}
>  
> -	return nor->controller_ops->write_reg(nor, SPINOR_OP_WRSR2, sr2, 1);
> +	if (ret)
> +		dev_dbg(nor->dev, "error %d writing SR2\n", ret);
> +
> +	return ret;
>  }
>  
>  static int spi_nor_read_sr2(struct spi_nor *nor, u8 *sr2)
>  {
> +	int ret;
> +
>  	if (nor->spimem) {
>  		struct spi_mem_op op =
>  			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDSR2, 1),
> @@ -861,10 +939,16 @@ static int spi_nor_read_sr2(struct spi_nor *nor, u8 *sr2)
>  				   SPI_MEM_OP_NO_DUMMY,
>  				   SPI_MEM_OP_DATA_IN(1, sr2, 1));
>  
> -		return spi_mem_exec_op(nor->spimem, &op);
> +		ret = spi_mem_exec_op(nor->spimem, &op);
> +	} else {
> +		ret = nor->controller_ops->read_reg(nor, SPINOR_OP_RDSR2,
> +						    sr2, 1);
>  	}
>  
> -	return nor->controller_ops->read_reg(nor, SPINOR_OP_RDSR2, sr2, 1);
> +	if (ret)
> +		dev_dbg(nor->dev, "error %d reading SR2\n", ret);
> +
> +	return ret;
>  }
>  
>  /*
> @@ -874,6 +958,8 @@ static int spi_nor_read_sr2(struct spi_nor *nor, u8 *sr2)
>   */
>  static int spi_nor_erase_chip(struct spi_nor *nor)
>  {
> +	int ret;
> +
>  	dev_dbg(nor->dev, " %lldKiB\n", (long long)(nor->mtd.size >> 10));
>  
>  	if (nor->spimem) {
> @@ -883,11 +969,16 @@ static int spi_nor_erase_chip(struct spi_nor *nor)
>  				   SPI_MEM_OP_NO_DUMMY,
>  				   SPI_MEM_OP_NO_DATA);
>  
> -		return spi_mem_exec_op(nor->spimem, &op);
> +		ret = spi_mem_exec_op(nor->spimem, &op);
> +	} else {
> +		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_CHIP_ERASE,
> +						     NULL, 0);
>  	}
>  
> -	return nor->controller_ops->write_reg(nor, SPINOR_OP_CHIP_ERASE,
> -					      NULL, 0);
> +	if (ret)
> +		dev_dbg(nor->dev, "error %d erasing chip\n", ret);
> +
> +	return ret;
>  }
>  
>  static struct spi_nor *mtd_to_spi_nor(struct mtd_info *mtd)
> @@ -1934,10 +2025,8 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor)
>  	spi_nor_write_enable(nor);
>  
>  	ret = spi_nor_write_sr2(nor, sr2);
> -	if (ret) {
> -		dev_dbg(nor->dev, "error while writing status register 2\n");
> +	if (ret)
>  		return ret;
> -	}
>  
>  	ret = spi_nor_wait_till_ready(nor);
>  	if (ret)
> @@ -1977,10 +2066,8 @@ static int spi_nor_clear_sr_bp(struct spi_nor *nor)
>  	spi_nor_write_enable(nor);
>  
>  	ret = spi_nor_write_sr(nor, nor->bouncebuf[0] & ~mask);
> -	if (ret) {
> -		dev_dbg(nor->dev, "write to status register failed\n");
> +	if (ret)
>  		return ret;
> -	}
>  
>  	return spi_nor_wait_till_ready(nor);
>  }
> @@ -2739,10 +2826,8 @@ static int s3an_nor_setup(struct spi_nor *nor,
>  	int ret;
>  
>  	ret = spi_nor_xread_sr(nor, nor->bouncebuf);
> -	if (ret) {
> -		dev_dbg(nor->dev, "error %d reading XRDSR\n", ret);
> +	if (ret)
>  		return ret;
> -	}
>  
>  	nor->erase_opcode = SPINOR_OP_XSE;
>  	nor->program_opcode = SPINOR_OP_XPP;
> 


