Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4E5CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F07882087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfJaLPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 07:15:42 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46912 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfJaLPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 07:15:42 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 98A3628F256;
        Thu, 31 Oct 2019 11:15:40 +0000 (GMT)
Date:   Thu, 31 Oct 2019 12:15:37 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 17/32] mtd: spi-nor: Move the WE and wait calls
 inside Write SR methods
Message-ID: <20191031121537.0c8135da@collabora.com>
In-Reply-To: <20191029111615.3706-18-tudor.ambarus@microchip.com>
References: <20191029111615.3706-1-tudor.ambarus@microchip.com>
        <20191029111615.3706-18-tudor.ambarus@microchip.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2019 11:17:15 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Avoid duplicating code by moving the calls to spi_nor_write_enable() and
> spi_nor_wait_till_ready() inside the Write Status Register methods.
> 
> Move spi_nor_write_sr() to avoid forward declaration of
> spi_nor_wait_till_ready().
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/mtd/spi-nor/spi-nor.c | 108 +++++++++++++++++-------------------------
>  1 file changed, 44 insertions(+), 64 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index ed7c233a7208..5fb4d953b5c7 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -534,35 +534,6 @@ static int spi_nor_read_cr(struct spi_nor *nor, u8 *cr)
>  	return ret;
>  }
>  
> -/*
> - * Write status register 1 byte
> - * Returns negative if error occurred.
> - */
> -static int spi_nor_write_sr(struct spi_nor *nor, u8 val)
> -{
> -	int ret;
> -
> -	nor->bouncebuf[0] = val;
> -	if (nor->spimem) {
> -		struct spi_mem_op op =
> -			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRSR, 1),
> -				   SPI_MEM_OP_NO_ADDR,
> -				   SPI_MEM_OP_NO_DUMMY,
> -				   SPI_MEM_OP_DATA_OUT(1, nor->bouncebuf, 1));
> -
> -		ret = spi_mem_exec_op(nor->spimem, &op);
> -	} else {
> -		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_WRSR,
> -						     nor->bouncebuf, 1);
> -	}
> -
> -	if (ret)
> -		dev_err(nor->dev, "error %d writing SR\n", ret);
> -
> -	return ret;
> -
> -}
> -
>  static int macronix_set_4byte(struct spi_nor *nor, bool enable)
>  {
>  	int ret;
> @@ -854,6 +825,41 @@ static int spi_nor_wait_till_ready(struct spi_nor *nor)
>  }
>  
>  /*
> + * Write status register 1 byte
> + * Returns negative if error occurred.
> + */
> +static int spi_nor_write_sr(struct spi_nor *nor, u8 val)
> +{
> +	int ret;
> +
> +	nor->bouncebuf[0] = val;
> +
> +	ret = spi_nor_write_enable(nor);
> +	if (ret)
> +		return ret;
> +
> +	if (nor->spimem) {
> +		struct spi_mem_op op =
> +			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRSR, 1),
> +				   SPI_MEM_OP_NO_ADDR,
> +				   SPI_MEM_OP_NO_DUMMY,
> +				   SPI_MEM_OP_DATA_OUT(1, nor->bouncebuf, 1));
> +
> +		ret = spi_mem_exec_op(nor->spimem, &op);
> +	} else {
> +		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_WRSR,
> +						     nor->bouncebuf, 1);
> +	}
> +
> +	if (ret) {
> +		dev_err(nor->dev, "error %d writing SR\n", ret);
> +		return ret;
> +	}
> +
> +	return spi_nor_wait_till_ready(nor);
> +}
> +
> +/*
>   * Write status Register and configuration register with 2 bytes
>   * The first byte will be written to the status register, while the
>   * second byte will be written to the configuration register.
> @@ -895,18 +901,10 @@ static int spi_nor_write_sr_and_check(struct spi_nor *nor, u8 status_new,
>  {
>  	int ret;
>  
> -	ret = spi_nor_write_enable(nor);
> -	if (ret)
> -		return ret;
> -
>  	ret = spi_nor_write_sr(nor, status_new);
>  	if (ret)
>  		return ret;
>  
> -	ret = spi_nor_wait_till_ready(nor);
> -	if (ret)
> -		return ret;
> -
>  	ret = spi_nor_read_sr(nor, &nor->bouncebuf[0]);
>  	if (ret)
>  		return ret;
> @@ -918,6 +916,10 @@ static int spi_nor_write_sr2(struct spi_nor *nor, u8 *sr2)
>  {
>  	int ret;
>  
> +	ret = spi_nor_write_enable(nor);
> +	if (ret)
> +		return ret;
> +
>  	if (nor->spimem) {
>  		struct spi_mem_op op =
>  			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRSR2, 1),
> @@ -931,10 +933,12 @@ static int spi_nor_write_sr2(struct spi_nor *nor, u8 *sr2)
>  						     sr2, 1);
>  	}
>  
> -	if (ret)
> +	if (ret) {
>  		dev_err(nor->dev, "error %d writing SR2\n", ret);
> +		return ret;
> +	}
>  
> -	return ret;
> +	return spi_nor_wait_till_ready(nor);
>  }
>  
>  static int spi_nor_read_sr2(struct spi_nor *nor, u8 *sr2)
> @@ -1864,18 +1868,10 @@ static int macronix_quad_enable(struct spi_nor *nor)
>  	if (nor->bouncebuf[0] & SR_QUAD_EN_MX)
>  		return 0;
>  
> -	ret = spi_nor_write_enable(nor);
> -	if (ret)
> -		return ret;
> -
>  	ret = spi_nor_write_sr(nor, nor->bouncebuf[0] | SR_QUAD_EN_MX);
>  	if (ret)
>  		return ret;
>  
> -	ret = spi_nor_wait_till_ready(nor);
> -	if (ret)
> -		return ret;
> -
>  	ret = spi_nor_read_sr(nor, &nor->bouncebuf[0]);
>  	if (ret)
>  		return ret;
> @@ -2041,18 +2037,10 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor)
>  	/* Update the Quad Enable bit. */
>  	*sr2 |= SR2_QUAD_EN_BIT7;
>  
> -	ret = spi_nor_write_enable(nor);
> -	if (ret)
> -		return ret;
> -
>  	ret = spi_nor_write_sr2(nor, sr2);
>  	if (ret)
>  		return ret;
>  
> -	ret = spi_nor_wait_till_ready(nor);
> -	if (ret)
> -		return ret;
> -
>  	/* Read back and check it. */
>  	ret = spi_nor_read_sr2(nor, sr2);
>  	if (ret)
> @@ -2084,15 +2072,7 @@ static int spi_nor_clear_sr_bp(struct spi_nor *nor)
>  	if (ret)
>  		return ret;
>  
> -	ret = spi_nor_write_enable(nor);
> -	if (ret)
> -		return ret;
> -
> -	ret = spi_nor_write_sr(nor, nor->bouncebuf[0] & ~mask);
> -	if (ret)
> -		return ret;
> -
> -	return spi_nor_wait_till_ready(nor);
> +	return spi_nor_write_sr(nor, nor->bouncebuf[0] & ~mask);
>  }
>  
>  /**

