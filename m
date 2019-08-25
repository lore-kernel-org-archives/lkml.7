Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1B0C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 12:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BD4B2070B
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 12:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbfHYMY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 08:24:26 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38022 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfHYMYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 08:24:25 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id ADF2028A404;
        Sun, 25 Aug 2019 13:24:24 +0100 (BST)
Date:   Sun, 25 Aug 2019 14:24:21 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <marek.vasut@gmail.com>, <vigneshr@ti.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 7/7] mtd: spi-nor: Rework the disabling of block
 write protection
Message-ID: <20190825142421.35d31a9b@collabora.com>
In-Reply-To: <20190824120027.14452-8-tudor.ambarus@microchip.com>
References: <20190824120027.14452-1-tudor.ambarus@microchip.com>
        <20190824120027.14452-8-tudor.ambarus@microchip.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Aug 2019 12:00:48 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Get rid of MFR handling and implement specific manufacturer
> default_init() fixup hooks.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 30 ++++++++++++++++++++----------
>  1 file changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index fc9e14777212..f4e9fcca619f 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -4146,6 +4146,16 @@ static int spi_nor_parse_sfdp(struct spi_nor *nor,
>  	return err;
>  }
>  
> +static void atmel_set_default_init(struct spi_nor *nor)
> +{
> +	nor->params.disable_block_protection = spi_nor_clear_sr_bp;
> +}
> +
> +static void intel_set_default_init(struct spi_nor *nor)
> +{
> +	nor->params.disable_block_protection = spi_nor_clear_sr_bp;

That's weird: you can unlock blocks but locking is not
explicitly flagged as supported (SNOR_F_HAS_LOCK is not set). Is that
expected?

> +}
> +
>  static void macronix_set_default_init(struct spi_nor *nor)
>  {
>  	nor->params.quad_enable = macronix_quad_enable;
> @@ -4173,6 +4183,14 @@ static void spi_nor_manufacturer_init_params(struct spi_nor *nor)
>  {
>  	/* Init flash parameters based on MFR */
>  	switch (JEDEC_MFR(nor->info)) {
> +	case SNOR_MFR_ATMEL:
> +		atmel_set_default_init(nor);
> +		break;
> +
> +	case SNOR_MFR_INTEL:
> +		intel_set_default_init(nor);
> +		break;
> +
>  	case SNOR_MFR_MACRONIX:
>  		macronix_set_default_init(nor);
>  		break;
> @@ -4760,18 +4778,10 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
>  	if (info->flags & SPI_S3AN)
>  		nor->flags |=  SNOR_F_READY_XSR_RDY;
>  
> -	if (info->flags & SPI_NOR_HAS_LOCK)
> +	if (info->flags & SPI_NOR_HAS_LOCK) {

If this flag implies SR_BP-based locking we should really rename it into
SPI_NOR_HAS_SR_BP_LOCK to avoid any confusion.

>  		nor->flags |= SNOR_F_HAS_LOCK;
> -
> -	/*
> -	 * Atmel, SST, Intel/Numonyx, and others serial NOR tend to power up
> -	 * with the software protection bits set.
> -	 */
> -	if (JEDEC_MFR(nor->info) == SNOR_MFR_ATMEL ||
> -	    JEDEC_MFR(nor->info) == SNOR_MFR_INTEL ||
> -	    JEDEC_MFR(nor->info) == SNOR_MFR_SST ||
> -	    nor->info->flags & SPI_NOR_HAS_LOCK)
>  		nor->params.disable_block_protection = spi_nor_clear_sr_bp;
> +	}
>  
>  	/* Init flash parameters based on flash_info struct and SFDP */
>  	spi_nor_init_params(nor);

