Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9501FC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 07:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C5B3222BE
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 07:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733297AbfJJHi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 03:38:26 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44774 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733071AbfJJHdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 03:33:13 -0400
Received: from dhcp-172-31-174-146.wireless.concordia.ca (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 96F5D290783;
        Thu, 10 Oct 2019 08:33:11 +0100 (BST)
Date:   Thu, 10 Oct 2019 09:33:08 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <vigneshr@ti.com>, <marek.vasut@gmail.com>,
        <linux-mtd@lists.infradead.org>, <geert+renesas@glider.be>,
        <jonas@norrbonn.se>, linux-aspeed@lists.ozlabs.org,
        andrew@aj.id.au, richard@nod.at, linux-kernel@vger.kernel.org,
        vz@mleia.com, linux-mediatek@lists.infradead.org, joel@jms.id.au,
        miquel.raynal@bootlin.com, matthias.bgg@gmail.com,
        computersforpeace@gmail.com, dwmw2@infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 09/22] mtd: spi-nor: Fix retlen handling in
 sst_write()
Message-ID: <20191010093308.2fe94974@dhcp-172-31-174-146.wireless.concordia.ca>
In-Reply-To: <20190924074533.6618-10-tudor.ambarus@microchip.com>
References: <20190924074533.6618-1-tudor.ambarus@microchip.com>
        <20190924074533.6618-10-tudor.ambarus@microchip.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Sep 2019 07:46:21 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> In case the write of the first byte failed, retlen was incorrectly
> incremented to *retlen += actual; on the exit path. retlen should be
> incremented when actual data was written to the flash.
> 
> Rename 'sst_write_err' label to 'out' as it is no longer generic for
> all the write errors in the sst_write() method, and may introduce
> confusion.

Renaming the label is indeed a good thing, but should be done in a
separate patch.

> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 0aee068a5835..be5dee622d51 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -2665,12 +2665,12 @@ static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
>  		/* write one byte. */
>  		ret = spi_nor_write_data(nor, to, 1, buf);
>  		if (ret < 0)
> -			goto sst_write_err;
> +			goto unlock_and_unprep;
>  		WARN(ret != 1, "While writing 1 byte written %i bytes\n",
>  		     (int)ret);
>  		ret = spi_nor_wait_till_ready(nor);
>  		if (ret)
> -			goto sst_write_err;
> +			goto unlock_and_unprep;
>  	}
>  	to += actual;

Not sure we need this new label, we can just have:

	actual = 0;
	/* Start write from odd address. */
	if (to % 2) {
		nor->program_opcode = SPINOR_OP_BP;

		/* write one byte. */
		ret = spi_nor_write_data(nor, to, 1, buf);
		if (ret < 0)
			goto out;
		WARN(ret != 1, "While writing 1 byte written %i
		bytes\n", (int)ret);
		ret = spi_nor_wait_till_ready(nor);
		if (ret)
			goto out;

		to++;
		actual++;
	}

>  
> @@ -2681,12 +2681,12 @@ static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
>  		/* write two bytes. */
>  		ret = spi_nor_write_data(nor, to, 2, buf + actual);
>  		if (ret < 0)
> -			goto sst_write_err;
> +			goto out;
>  		WARN(ret != 2, "While writing 2 bytes written %i bytes\n",
>  		     (int)ret);
>  		ret = spi_nor_wait_till_ready(nor);
>  		if (ret)
> -			goto sst_write_err;
> +			goto out;
>  		to += 2;
>  		nor->sst_write_second = true;
>  	}
> @@ -2694,35 +2694,35 @@ static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
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
>  		WARN(ret != 1, "While writing 1 byte written %i bytes\n",
>  		     (int)ret);
>  		ret = spi_nor_wait_till_ready(nor);
>  		if (ret)
> -			goto sst_write_err;
> +			goto out;
>  
>  		ret = spi_nor_write_disable(nor);
>  		if (ret)
> -			goto sst_write_err;
> +			goto out;
>  
>  		actual += 1;
>  	}
> -sst_write_err:
> +out:
>  	*retlen += actual;
>  unlock_and_unprep:
>  	spi_nor_unlock_and_unprep(nor, SPI_NOR_OPS_WRITE);

