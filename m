Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1790EC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 05:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E96F4206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 05:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbfHAFwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 01:52:10 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33522 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfHAFwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 01:52:10 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id E827028AC1E;
        Thu,  1 Aug 2019 06:52:08 +0100 (BST)
Date:   Thu, 1 Aug 2019 07:52:05 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v3 2/3] mtd: spi-nor: Move m25p80 code in spi-nor.c
Message-ID: <20190801075205.3336693b@collabora.com>
In-Reply-To: <20190801043052.30192-3-vigneshr@ti.com>
References: <20190801043052.30192-1-vigneshr@ti.com>
        <20190801043052.30192-3-vigneshr@ti.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Aug 2019 10:00:51 +0530
Vignesh Raghavendra <vigneshr@ti.com> wrote:

> From: Boris Brezillon <boris.brezillon@bootlin.com>
> 
> The m25p80 driver is actually a generic wrapper around the spi-mem
> layer. Not only the driver name is misleading, but we'd expect such a
> common logic to be directly available in the core. Another reason for
> moving this code is that SPI NOR controller drivers should
> progressively be replaced by SPI controller drivers implementing the
> spi_mem_ops interface, and when the conversion is done, we should have
> a single spi-nor driver directly interfacing with the spi-mem layer.
> 
> While moving the code we also fix a longstanding issue when
> non-DMA-able buffers are passed by the MTD layer.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
> v3:
> Simplify register read/write by dropping spi_nor_exec_op() and using
> spi_mem_exec_op() directly
> Modify spi_nor_spimem_xfer_data() to drop "enum spi_nor_protocol proto"
> Fix misc coding style comments by Tudor
> 
> v2:
> Add docs for new functions added
> Add spi_nor_ prefix to new functions
> Incorporate Andrey's patches https://lkml.org/lkml/2019/4/1/32
> to avoid looping spi_nor_spimem_* APIs
> 
>  drivers/mtd/devices/Kconfig   |  18 -
>  drivers/mtd/devices/Makefile  |   1 -
>  drivers/mtd/devices/m25p80.c  | 347 -------------------
>  drivers/mtd/spi-nor/Kconfig   |   2 +
>  drivers/mtd/spi-nor/spi-nor.c | 632 ++++++++++++++++++++++++++++++++--
>  include/linux/mtd/spi-nor.h   |   3 +
>  6 files changed, 604 insertions(+), 399 deletions(-)
>  delete mode 100644 drivers/mtd/devices/m25p80.c
> 

[...]


> @@ -348,6 +530,16 @@ static int read_cr(struct spi_nor *nor)
>   */
>  static int write_sr(struct spi_nor *nor, u8 val)
>  {
> +	if (nor->spimem) {
> +		struct spi_mem_op op =
> +			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRSR, 1),
> +				   SPI_MEM_OP_NO_ADDR,
> +				   SPI_MEM_OP_NO_DUMMY,
> +				   SPI_MEM_OP_DATA_IN(1, nor->bouncebuf, 1));
> +
> +		return spi_mem_exec_op(nor->spimem, &op);
> +	}
> +
>  	nor->bouncebuf[0] = val;

The above line should be moved at the beginning of the function if you
want the spimem path to work correctly.

>  	return nor->write_reg(nor, SPINOR_OP_WRSR, nor->bouncebuf, 1);
>  }


