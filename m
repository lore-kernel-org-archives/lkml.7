Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E5BC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 07:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 448F32196E
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 07:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733096AbfJJHWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 03:22:09 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44634 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733012AbfJJHVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 03:21:22 -0400
Received: from dhcp-172-31-174-146.wireless.concordia.ca (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 46710290786;
        Thu, 10 Oct 2019 08:21:20 +0100 (BST)
Date:   Thu, 10 Oct 2019 09:21:17 +0200
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
Subject: Re: [PATCH v2 08/22] mtd: spi-nor: Rework write_enable/disable()
Message-ID: <20191010092117.4c5018a8@dhcp-172-31-174-146.wireless.concordia.ca>
In-Reply-To: <20190924074533.6618-9-tudor.ambarus@microchip.com>
References: <20190924074533.6618-1-tudor.ambarus@microchip.com>
        <20190924074533.6618-9-tudor.ambarus@microchip.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Sep 2019 07:46:18 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> static int write_enable(struct spi_nor *nor)
> static int write_disable(struct spi_nor *nor)
> become
> static int spi_nor_write_enable(struct spi_nor *nor)
> static int spi_nor_write_disable(struct spi_nor *nor)
> 
> Check for errors after each call to them. Move them up in the
> file as the first SPI NOR Register Operations, to avoid further
> forward declarations.

Same here, split that in 3 patches please.

> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 175 +++++++++++++++++++++++++++++-------------
>  1 file changed, 120 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 0fb124bd2e77..0aee068a5835 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -389,6 +389,64 @@ static ssize_t spi_nor_write_data(struct spi_nor *nor, loff_t to, size_t len,
>  }
>  
>  /**
> + * spi_nor_write_enable() - Set write enable latch with Write Enable command.
> + * @nor:        pointer to 'struct spi_nor'
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
> +static int spi_nor_write_enable(struct spi_nor *nor)
> +{
> +	int ret;
> +
> +	if (nor->spimem) {
> +		struct spi_mem_op op =
> +			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WREN, 1),
> +				   SPI_MEM_OP_NO_ADDR,
> +				   SPI_MEM_OP_NO_DUMMY,
> +				   SPI_MEM_OP_NO_DATA);
> +
> +		ret = spi_mem_exec_op(nor->spimem, &op);
> +	} else {
> +		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_WREN,
> +						     NULL, 0);
> +	}
> +
> +	if (ret)
> +		dev_err(nor->dev, "error %d on Write Enable\n", ret);

Do we really need these error messages? I mean, if there's an error it
should be propagated to the upper layer, so maybe we should use
dev_dbg() here.

> +
> +	return ret;
> +}
> +
