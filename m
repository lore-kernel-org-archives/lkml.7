Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE107CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 10:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80FAB20862
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 10:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfJaKvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 06:51:43 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46638 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfJaKvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 06:51:43 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 673C728FDEA;
        Thu, 31 Oct 2019 10:51:40 +0000 (GMT)
Date:   Thu, 31 Oct 2019 11:51:37 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 08/32] mtd: spi-nor: Pointer parameter for SR in
 spi_nor_read_sr()
Message-ID: <20191031115137.56127404@collabora.com>
In-Reply-To: <20191029111615.3706-9-tudor.ambarus@microchip.com>
References: <20191029111615.3706-1-tudor.ambarus@microchip.com>
        <20191029111615.3706-9-tudor.ambarus@microchip.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2019 11:17:00 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Let the callers pass the pointer to the DMA-able buffer where
> the value of the Status Register will be written. This way we
> avoid the casts between int and u8, which can be confusing.
> 
> Callers stop compare the return value of spi_nor_read_sr() with negative,
> spi_nor_read_sr() returns 0 on success and -errno otherwise.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/mtd/spi-nor/spi-nor.c | 117 +++++++++++++++++++++++-------------------
>  1 file changed, 64 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 1a00438fd061..dc44d1206f77 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -425,12 +425,15 @@ static int spi_nor_write_disable(struct spi_nor *nor)
>  	return nor->controller_ops->write_reg(nor, SPINOR_OP_WRDI, NULL, 0);
>  }
>  
> -/*
> - * Read the status register, returning its value in the location
> - * Return the status register value.
> - * Returns negative if error occurred.
> +/**
> + * spi_nor_read_sr() - Read the Status Register.
> + * @nor:	pointer to 'struct spi_nor'.
> + * @sr:		pointer to a DMA-able buffer where the value of the
> + *              Status Register will be written.
> + *
> + * Return: 0 on success, -errno otherwise.
>   */
> -static int spi_nor_read_sr(struct spi_nor *nor)
> +static int spi_nor_read_sr(struct spi_nor *nor, u8 *sr)
>  {
>  	int ret;
>  
> @@ -439,20 +442,18 @@ static int spi_nor_read_sr(struct spi_nor *nor)
>  			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDSR, 1),
>  				   SPI_MEM_OP_NO_ADDR,
>  				   SPI_MEM_OP_NO_DUMMY,
> -				   SPI_MEM_OP_DATA_IN(1, nor->bouncebuf, 1));
> +				   SPI_MEM_OP_DATA_IN(1, sr, 1));
>  
>  		ret = spi_mem_exec_op(nor->spimem, &op);
>  	} else {
>  		ret = nor->controller_ops->read_reg(nor, SPINOR_OP_RDSR,
> -						    nor->bouncebuf, 1);
> +						    sr, 1);
>  	}
>  
> -	if (ret) {
> +	if (ret)
>  		dev_err(nor->dev, "error %d reading SR\n", ret);
> -		return ret;
> -	}
>  
> -	return nor->bouncebuf[0];
> +	return ret;
>  }
>  
>  /*
> @@ -668,12 +669,14 @@ static int spi_nor_clear_sr(struct spi_nor *nor)
>  
>  static int spi_nor_sr_ready(struct spi_nor *nor)
>  {
> -	int sr = spi_nor_read_sr(nor);
> -	if (sr < 0)
> -		return sr;
> +	int ret = spi_nor_read_sr(nor, &nor->bouncebuf[0]);
>  
> -	if (nor->flags & SNOR_F_USE_CLSR && sr & (SR_E_ERR | SR_P_ERR)) {
> -		if (sr & SR_E_ERR)
> +	if (ret)
> +		return ret;
> +
> +	if (nor->flags & SNOR_F_USE_CLSR &&
> +	    nor->bouncebuf[0] & (SR_E_ERR | SR_P_ERR)) {
> +		if (nor->bouncebuf[0] & SR_E_ERR)
>  			dev_err(nor->dev, "Erase Error occurred\n");
>  		else
>  			dev_err(nor->dev, "Programming Error occurred\n");
> @@ -682,7 +685,7 @@ static int spi_nor_sr_ready(struct spi_nor *nor)
>  		return -EIO;
>  	}
>  
> -	return !(sr & SR_WIP);
> +	return !(nor->bouncebuf[0] & SR_WIP);
>  }
>  
>  static int spi_nor_clear_fsr(struct spi_nor *nor)
> @@ -831,11 +834,11 @@ static int spi_nor_write_sr_and_check(struct spi_nor *nor, u8 status_new,
>  	if (ret)
>  		return ret;
>  
> -	ret = spi_nor_read_sr(nor);
> -	if (ret < 0)
> +	ret = spi_nor_read_sr(nor, &nor->bouncebuf[0]);
> +	if (ret)
>  		return ret;
>  
> -	return ((ret & mask) != (status_new & mask)) ? -EIO : 0;
> +	return ((nor->bouncebuf[0] & mask) != (status_new & mask)) ? -EIO : 0;
>  }
>  
>  static int spi_nor_write_sr2(struct spi_nor *nor, u8 *sr2)
> @@ -1510,16 +1513,18 @@ static int stm_is_unlocked_sr(struct spi_nor *nor, loff_t ofs, uint64_t len,
>  static int stm_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
>  {
>  	struct mtd_info *mtd = &nor->mtd;
> -	int status_old, status_new;
> +	int ret, status_old, status_new;
>  	u8 mask = SR_BP2 | SR_BP1 | SR_BP0;
>  	u8 shift = ffs(mask) - 1, pow, val;
>  	loff_t lock_len;
>  	bool can_be_top = true, can_be_bottom = nor->flags & SNOR_F_HAS_SR_TB;
>  	bool use_top;
>  
> -	status_old = spi_nor_read_sr(nor);
> -	if (status_old < 0)
> -		return status_old;
> +	ret = spi_nor_read_sr(nor, &nor->bouncebuf[0]);
> +	if (ret)
> +		return ret;
> +
> +	status_old = nor->bouncebuf[0];
>  
>  	/* If nothing in our range is unlocked, we don't need to do anything */
>  	if (stm_is_locked_sr(nor, ofs, len, status_old))
> @@ -1590,16 +1595,18 @@ static int stm_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
>  static int stm_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
>  {
>  	struct mtd_info *mtd = &nor->mtd;
> -	int status_old, status_new;
> +	int ret, status_old, status_new;
>  	u8 mask = SR_BP2 | SR_BP1 | SR_BP0;
>  	u8 shift = ffs(mask) - 1, pow, val;
>  	loff_t lock_len;
>  	bool can_be_top = true, can_be_bottom = nor->flags & SNOR_F_HAS_SR_TB;
>  	bool use_top;
>  
> -	status_old = spi_nor_read_sr(nor);
> -	if (status_old < 0)
> -		return status_old;
> +	ret = spi_nor_read_sr(nor, &nor->bouncebuf[0]);
> +	if (ret)
> +		return ret;
> +
> +	status_old = nor->bouncebuf[0];
>  
>  	/* If nothing in our range is locked, we don't need to do anything */
>  	if (stm_is_unlocked_sr(nor, ofs, len, status_old))
> @@ -1674,13 +1681,13 @@ static int stm_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
>   */
>  static int stm_is_locked(struct spi_nor *nor, loff_t ofs, uint64_t len)
>  {
> -	int status;
> +	int ret;
>  
> -	status = spi_nor_read_sr(nor);
> -	if (status < 0)
> -		return status;
> +	ret = spi_nor_read_sr(nor, &nor->bouncebuf[0]);
> +	if (ret)
> +		return ret;
>  
> -	return stm_is_locked_sr(nor, ofs, len, status);
> +	return stm_is_locked_sr(nor, ofs, len, nor->bouncebuf[0]);
>  }
>  
>  static const struct spi_nor_locking_ops stm_locking_ops = {
> @@ -1746,24 +1753,28 @@ static int spi_nor_is_locked(struct mtd_info *mtd, loff_t ofs, uint64_t len)
>   */
>  static int macronix_quad_enable(struct spi_nor *nor)
>  {
> -	int ret, val;
> +	int ret;
> +
> +	ret = spi_nor_read_sr(nor, &nor->bouncebuf[0]);
> +	if (ret)
> +		return ret;
>  
> -	val = spi_nor_read_sr(nor);
> -	if (val < 0)
> -		return val;
> -	if (val & SR_QUAD_EN_MX)
> +	if (nor->bouncebuf[0] & SR_QUAD_EN_MX)
>  		return 0;
>  
>  	spi_nor_write_enable(nor);
>  
> -	spi_nor_write_sr(nor, val | SR_QUAD_EN_MX);
> +	spi_nor_write_sr(nor, nor->bouncebuf[0] | SR_QUAD_EN_MX);
>  
>  	ret = spi_nor_wait_till_ready(nor);
>  	if (ret)
>  		return ret;
>  
> -	ret = spi_nor_read_sr(nor);
> -	if (!(ret > 0 && (ret & SR_QUAD_EN_MX))) {
> +	ret = spi_nor_read_sr(nor, &nor->bouncebuf[0]);
> +	if (ret)
> +		return ret;
> +
> +	if (!(nor->bouncebuf[0] & SR_QUAD_EN_MX)) {
>  		dev_err(nor->dev, "Macronix Quad bit not set\n");
>  		return -EINVAL;
>  	}
> @@ -1835,12 +1846,12 @@ static int spansion_no_read_cr_quad_enable(struct spi_nor *nor)
>  	int ret;
>  
>  	/* Keep the current value of the Status Register. */
> -	ret = spi_nor_read_sr(nor);
> -	if (ret < 0) {
> +	ret = spi_nor_read_sr(nor, &sr_cr[0]);
> +	if (ret) {
>  		dev_err(nor->dev, "error while reading status register\n");
>  		return ret;
>  	}
> -	sr_cr[0] = ret;
> +
>  	sr_cr[1] = CR_QUAD_EN_SPAN;
>  
>  	return spi_nor_write_sr_cr(nor, sr_cr);
> @@ -1878,12 +1889,11 @@ static int spansion_read_cr_quad_enable(struct spi_nor *nor)
>  	sr_cr[1] = ret | CR_QUAD_EN_SPAN;
>  
>  	/* Keep the current value of the Status Register. */
> -	ret = spi_nor_read_sr(nor);
> -	if (ret < 0) {
> +	ret = spi_nor_read_sr(nor, &sr_cr[0]);
> +	if (ret) {
>  		dev_err(dev, "error while reading status register\n");
>  		return ret;
>  	}
> -	sr_cr[0] = ret;
>  
>  	ret = spi_nor_write_sr_cr(nor, sr_cr);
>  	if (ret)
> @@ -1967,15 +1977,15 @@ static int spi_nor_clear_sr_bp(struct spi_nor *nor)
>  	int ret;
>  	u8 mask = SR_BP2 | SR_BP1 | SR_BP0;
>  
> -	ret = spi_nor_read_sr(nor);
> -	if (ret < 0) {
> +	ret = spi_nor_read_sr(nor, &nor->bouncebuf[0]);
> +	if (ret) {
>  		dev_err(nor->dev, "error while reading status register\n");
>  		return ret;
>  	}
>  
>  	spi_nor_write_enable(nor);
>  
> -	ret = spi_nor_write_sr(nor, ret & ~mask);
> +	ret = spi_nor_write_sr(nor, nor->bouncebuf[0] & ~mask);
>  	if (ret) {
>  		dev_err(nor->dev, "write to status register failed\n");
>  		return ret;
> @@ -2021,13 +2031,14 @@ static int spi_nor_spansion_clear_sr_bp(struct spi_nor *nor)
>  	if (ret & CR_QUAD_EN_SPAN) {
>  		sr_cr[1] = ret;
>  
> -		ret = spi_nor_read_sr(nor);
> -		if (ret < 0) {
> +		ret = spi_nor_read_sr(nor, &sr_cr[0]);
> +		if (ret) {
>  			dev_err(nor->dev,
>  				"error while reading status register\n");
>  			return ret;
>  		}
> -		sr_cr[0] = ret & ~mask;
> +
> +		sr_cr[0] &= ~mask;
>  
>  		ret = spi_nor_write_sr_cr(nor, sr_cr);
>  		if (ret)

