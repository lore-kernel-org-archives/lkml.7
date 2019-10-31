Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC16CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 10:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEC6C20862
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 10:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfJaKx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 06:53:58 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46662 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727348AbfJaKx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 06:53:57 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id CE01028A0E8;
        Thu, 31 Oct 2019 10:53:54 +0000 (GMT)
Date:   Thu, 31 Oct 2019 11:53:52 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 09/32] mtd: spi-nor: Pointer parameter for FSR in
 spi_nor_read_fsr()
Message-ID: <20191031115352.4f111555@collabora.com>
In-Reply-To: <20191029111615.3706-10-tudor.ambarus@microchip.com>
References: <20191029111615.3706-1-tudor.ambarus@microchip.com>
        <20191029111615.3706-10-tudor.ambarus@microchip.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2019 11:17:02 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Let the callers pass the pointer to the DMA-able buffer where
> the value of the Flag Status Register will be written. This way we
> avoid the casts between int and u8, which can be confusing.
> 
> Caller stops compare the return value of spi_nor_read_fsr() with negative,
> spi_nor_read_fsr() returns 0 on success and -errno otherwise.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 38 ++++++++++++++++++++------------------
>  1 file changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index dc44d1206f77..0d38aede4de7 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -456,12 +456,15 @@ static int spi_nor_read_sr(struct spi_nor *nor, u8 *sr)
>  	return ret;
>  }
>  
> -/*
> - * Read the flag status register, returning its value in the location
> - * Return the status register value.
> - * Returns negative if error occurred.
> +/**
> + * spi_nor_read_fsr() - Read the Flag Status Register.
> + * @nor:	pointer to 'struct spi_nor'
> + * @fsr:	pointer to a DMA-able buffer where the value of the
> + *              Flag Status Register will be written.
> + *
> + * Return: 0 on success, -errno otherwise.
>   */
> -static int spi_nor_read_fsr(struct spi_nor *nor)
> +static int spi_nor_read_fsr(struct spi_nor *nor, u8 *fsr)
>  {
>  	int ret;
>  
> @@ -470,20 +473,18 @@ static int spi_nor_read_fsr(struct spi_nor *nor)
>  			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDFSR, 1),
>  				   SPI_MEM_OP_NO_ADDR,
>  				   SPI_MEM_OP_NO_DUMMY,
> -				   SPI_MEM_OP_DATA_IN(1, nor->bouncebuf, 1));
> +				   SPI_MEM_OP_DATA_IN(1, fsr, 1));
>  
>  		ret = spi_mem_exec_op(nor->spimem, &op);
>  	} else {
>  		ret = nor->controller_ops->read_reg(nor, SPINOR_OP_RDFSR,
> -						    nor->bouncebuf, 1);
> +						    fsr, 1);
>  	}
>  
> -	if (ret) {
> +	if (ret)
>  		dev_err(nor->dev, "error %d reading FSR\n", ret);
> -		return ret;
> -	}
>  
> -	return nor->bouncebuf[0];
> +	return ret;
>  }
>  
>  /*
> @@ -705,17 +706,18 @@ static int spi_nor_clear_fsr(struct spi_nor *nor)
>  
>  static int spi_nor_fsr_ready(struct spi_nor *nor)
>  {
> -	int fsr = spi_nor_read_fsr(nor);
> -	if (fsr < 0)
> -		return fsr;
> +	int ret = spi_nor_read_fsr(nor, &nor->bouncebuf[0]);

Didn't comment on the previous patch, but why not simply pass
nor->bouncebuf here?

Anyway, that's just a detail.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> +
> +	if (ret)
> +		return ret;
>  
> -	if (fsr & (FSR_E_ERR | FSR_P_ERR)) {
> -		if (fsr & FSR_E_ERR)
> +	if (nor->bouncebuf[0] & (FSR_E_ERR | FSR_P_ERR)) {
> +		if (nor->bouncebuf[0] & FSR_E_ERR)
>  			dev_err(nor->dev, "Erase operation failed.\n");
>  		else
>  			dev_err(nor->dev, "Program operation failed.\n");
>  
> -		if (fsr & FSR_PT_ERR)
> +		if (nor->bouncebuf[0] & FSR_PT_ERR)
>  			dev_err(nor->dev,
>  			"Attempted to modify a protected sector.\n");
>  
> @@ -723,7 +725,7 @@ static int spi_nor_fsr_ready(struct spi_nor *nor)
>  		return -EIO;
>  	}
>  
> -	return fsr & FSR_READY;
> +	return nor->bouncebuf[0] & FSR_READY;
>  }
>  
>  static int spi_nor_ready(struct spi_nor *nor)

