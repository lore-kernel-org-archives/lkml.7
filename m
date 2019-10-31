Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1139DCA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 10:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D951F20862
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 10:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfJaKsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 06:48:41 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46602 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbfJaKsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 06:48:41 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 4BF18283D0E;
        Thu, 31 Oct 2019 10:48:40 +0000 (GMT)
Date:   Thu, 31 Oct 2019 11:48:38 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 07/32] mtd: spi-nor: Don't overwrite errno from Reg
 Ops
Message-ID: <20191031114838.3c9aa4ac@collabora.com>
In-Reply-To: <20191029111615.3706-8-tudor.ambarus@microchip.com>
References: <20191029111615.3706-1-tudor.ambarus@microchip.com>
        <20191029111615.3706-8-tudor.ambarus@microchip.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2019 11:16:59 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Do not overwrite the error numbers received the Register Operations
> methods.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/mtd/spi-nor/spi-nor.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index c794eff69fe9..1a00438fd061 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -1364,10 +1364,9 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
>  
>  		spi_nor_write_enable(nor);
>  
> -		if (spi_nor_erase_chip(nor)) {
> -			ret = -EIO;
> +		ret = spi_nor_erase_chip(nor);
> +		if (ret)
>  			goto erase_err;
> -		}
>  
>  		/*
>  		 * Scale the timeout linearly with the size of the flash, with
> @@ -1839,7 +1838,7 @@ static int spansion_no_read_cr_quad_enable(struct spi_nor *nor)
>  	ret = spi_nor_read_sr(nor);
>  	if (ret < 0) {
>  		dev_err(nor->dev, "error while reading status register\n");
> -		return -EINVAL;
> +		return ret;
>  	}
>  	sr_cr[0] = ret;
>  	sr_cr[1] = CR_QUAD_EN_SPAN;
> @@ -1870,7 +1869,7 @@ static int spansion_read_cr_quad_enable(struct spi_nor *nor)
>  	ret = spi_nor_read_cr(nor);
>  	if (ret < 0) {
>  		dev_err(dev, "error while reading configuration register\n");
> -		return -EINVAL;
> +		return ret;
>  	}
>  
>  	if (ret & CR_QUAD_EN_SPAN)
> @@ -1882,7 +1881,7 @@ static int spansion_read_cr_quad_enable(struct spi_nor *nor)
>  	ret = spi_nor_read_sr(nor);
>  	if (ret < 0) {
>  		dev_err(dev, "error while reading status register\n");
> -		return -EINVAL;
> +		return ret;
>  	}
>  	sr_cr[0] = ret;
>  
> @@ -1932,7 +1931,7 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor)
>  	ret = spi_nor_write_sr2(nor, sr2);
>  	if (ret) {
>  		dev_err(nor->dev, "error while writing status register 2\n");
> -		return -EINVAL;
> +		return ret;
>  	}
>  
>  	ret = spi_nor_wait_till_ready(nor);

