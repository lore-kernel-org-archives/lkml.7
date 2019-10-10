Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74C5C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 06:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF63218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 06:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732987AbfJJGyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 02:54:41 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44048 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfJJGyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 02:54:41 -0400
Received: from dhcp-172-31-174-146.wireless.concordia.ca (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 111722905BC;
        Thu, 10 Oct 2019 07:54:38 +0100 (BST)
Date:   Thu, 10 Oct 2019 08:54:35 +0200
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
Subject: Re: [PATCH v2 03/22] mtd: spi-nor: cadence-quadspi: Fix
 cqspi_command_read() definition
Message-ID: <20191010085435.67b08ab5@dhcp-172-31-174-146.wireless.concordia.ca>
In-Reply-To: <20190924074533.6618-4-tudor.ambarus@microchip.com>
References: <20190924074533.6618-1-tudor.ambarus@microchip.com>
        <20190924074533.6618-4-tudor.ambarus@microchip.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Sep 2019 07:45:58 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> n_tx was never used, drop it. Replace 'const u8 *txbuf' with 'u8 opcode',
> to comply with the SPI NOR int (*read_reg)() method. The 'const'
> qualifier has no meaning for parameters passed by value, drop it.
> Going furher, the opcode was passed to cqspi_calc_rdreg() and never used,
> drop it.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/mtd/spi-nor/cadence-quadspi.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
> index ebda612641a4..22008fecd326 100644
> --- a/drivers/mtd/spi-nor/cadence-quadspi.c
> +++ b/drivers/mtd/spi-nor/cadence-quadspi.c
> @@ -285,7 +285,7 @@ static irqreturn_t cqspi_irq_handler(int this_irq, void *dev)
>  	return IRQ_HANDLED;
>  }
>  
> -static unsigned int cqspi_calc_rdreg(struct spi_nor *nor, const u8 opcode)
> +static unsigned int cqspi_calc_rdreg(struct spi_nor *nor)
>  {
>  	struct cqspi_flash_pdata *f_pdata = nor->priv;
>  	u32 rdreg = 0;
> @@ -354,8 +354,7 @@ static int cqspi_exec_flash_cmd(struct cqspi_st *cqspi, unsigned int reg)
>  	return cqspi_wait_idle(cqspi);
>  }
>  
> -static int cqspi_command_read(struct spi_nor *nor,
> -			      const u8 *txbuf, const unsigned n_tx,
> +static int cqspi_command_read(struct spi_nor *nor, u8 opcode,
>  			      u8 *rxbuf, size_t n_rx)
>  {
>  	struct cqspi_flash_pdata *f_pdata = nor->priv;
> @@ -373,9 +372,9 @@ static int cqspi_command_read(struct spi_nor *nor,
>  		return -EINVAL;
>  	}
>  
> -	reg = txbuf[0] << CQSPI_REG_CMDCTRL_OPCODE_LSB;
> +	reg = opcode << CQSPI_REG_CMDCTRL_OPCODE_LSB;
>  
> -	rdreg = cqspi_calc_rdreg(nor, txbuf[0]);
> +	rdreg = cqspi_calc_rdreg(nor);
>  	writel(rdreg, reg_base + CQSPI_REG_RD_INSTR);
>  
>  	reg |= (0x1 << CQSPI_REG_CMDCTRL_RD_EN_LSB);
> @@ -471,7 +470,7 @@ static int cqspi_read_setup(struct spi_nor *nor)
>  	unsigned int reg;
>  
>  	reg = nor->read_opcode << CQSPI_REG_RD_INSTR_OPCODE_LSB;
> -	reg |= cqspi_calc_rdreg(nor, nor->read_opcode);
> +	reg |= cqspi_calc_rdreg(nor);
>  
>  	/* Setup dummy clock cycles */
>  	dummy_clk = nor->read_dummy;
> @@ -604,7 +603,7 @@ static int cqspi_write_setup(struct spi_nor *nor)
>  	/* Set opcode. */
>  	reg = nor->program_opcode << CQSPI_REG_WR_INSTR_OPCODE_LSB;
>  	writel(reg, reg_base + CQSPI_REG_WR_INSTR);
> -	reg = cqspi_calc_rdreg(nor, nor->program_opcode);
> +	reg = cqspi_calc_rdreg(nor);
>  	writel(reg, reg_base + CQSPI_REG_RD_INSTR);
>  
>  	reg = readl(reg_base + CQSPI_REG_SIZE);
> @@ -1087,7 +1086,7 @@ static int cqspi_read_reg(struct spi_nor *nor, u8 opcode, u8 *buf, size_t len)
>  
>  	ret = cqspi_set_protocol(nor, 0);
>  	if (!ret)
> -		ret = cqspi_command_read(nor, &opcode, 1, buf, len);
> +		ret = cqspi_command_read(nor, opcode, buf, len);
>  
>  	return ret;
>  }

