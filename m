Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3CCCA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36AC52087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfJaLO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 07:14:27 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46904 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfJaLO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 07:14:27 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id B990728F256;
        Thu, 31 Oct 2019 11:14:25 +0000 (GMT)
Date:   Thu, 31 Oct 2019 12:14:23 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 16/32] mtd: spi-nor: Rename label as it is no longer
 generic
Message-ID: <20191031121423.4c7d2684@collabora.com>
In-Reply-To: <20191029111615.3706-17-tudor.ambarus@microchip.com>
References: <20191029111615.3706-1-tudor.ambarus@microchip.com>
        <20191029111615.3706-17-tudor.ambarus@microchip.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2019 11:17:13 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Rename 'sst_write_err' label to 'out' as it is no longer generic for
> all the errors in the sst_write() method, and may introduce confusion.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/mtd/spi-nor/spi-nor.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 21f01fdcfa16..ed7c233a7208 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -2705,7 +2705,7 @@ static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
>  
>  	ret = spi_nor_write_enable(nor);
>  	if (ret)
> -		goto sst_write_err;
> +		goto out;
>  
>  	nor->sst_write_second = false;
>  
> @@ -2716,11 +2716,11 @@ static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
>  		/* write one byte. */
>  		ret = spi_nor_write_data(nor, to, 1, buf);
>  		if (ret < 0)
> -			goto sst_write_err;
> +			goto out;
>  		WARN(ret != 1, "While writing 1 byte written %i bytes\n", ret);
>  		ret = spi_nor_wait_till_ready(nor);
>  		if (ret)
> -			goto sst_write_err;
> +			goto out;
>  
>  		to++;
>  		actual++;
> @@ -2733,11 +2733,11 @@ static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
>  		/* write two bytes. */
>  		ret = spi_nor_write_data(nor, to, 2, buf + actual);
>  		if (ret < 0)
> -			goto sst_write_err;
> +			goto out;
>  		WARN(ret != 2, "While writing 2 bytes written %i bytes\n", ret);
>  		ret = spi_nor_wait_till_ready(nor);
>  		if (ret)
> -			goto sst_write_err;
> +			goto out;
>  		to += 2;
>  		nor->sst_write_second = true;
>  	}
> @@ -2745,32 +2745,32 @@ static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
>  
>  	ret = spi_nor_write_disable(nor);
>  	if (ret)
> -		goto sst_write_err;
> +		goto out;
>  
>  	ret = spi_nor_wait_till_ready(nor);
>  	if (ret)
> -		goto sst_write_err;
> +		goto out;
>  
>  	/* Write out trailing byte if it exists. */
>  	if (actual != len) {
>  		ret = spi_nor_write_enable(nor);
>  		if (ret)
> -			goto sst_write_err;
> +			goto out;
>  
>  		nor->program_opcode = SPINOR_OP_BP;
>  		ret = spi_nor_write_data(nor, to, 1, buf + actual);
>  		if (ret < 0)
> -			goto sst_write_err;
> +			goto out;
>  		WARN(ret != 1, "While writing 1 byte written %i bytes\n", ret);
>  		ret = spi_nor_wait_till_ready(nor);
>  		if (ret)
> -			goto sst_write_err;
> +			goto out;
>  
>  		actual += 1;
>  
>  		ret = spi_nor_write_disable(nor);
>  	}
> -sst_write_err:
> +out:
>  	*retlen += actual;
>  	spi_nor_unlock_and_unprep(nor, SPI_NOR_OPS_WRITE);
>  	return ret;

