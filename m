Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75F2C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 06:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89A992089E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 06:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729992AbfHAGYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 02:24:35 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33858 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729196AbfHAGYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 02:24:35 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id F2B9B28BFE1;
        Thu,  1 Aug 2019 07:24:32 +0100 (BST)
Date:   Thu, 1 Aug 2019 08:24:29 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <marek.vasut@gmail.com>, <vigneshr@ti.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] mtd: spi-nor: Add default_init() hook to tweak
 flash parameters
Message-ID: <20190801082429.28feb2b5@collabora.com>
In-Reply-To: <20190731090315.26798-2-tudor.ambarus@microchip.com>
References: <20190731090315.26798-1-tudor.ambarus@microchip.com>
        <20190731090315.26798-2-tudor.ambarus@microchip.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jul 2019 09:03:27 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> As of now, the flash parameters initialization logic is as following:
> 
> a/ default flash parameters init in spi_nor_init_params()
> b/ manufacturer specific flash parameters updates, split across entire
>    spi-nor core code
> c/ flash parameters updates based on SFDP tables
> d/ post BFPT flash parameter updates
> 
> In the quest of removing the manufacturer specific code from the spi-nor
> core, we want to impose a timeline/priority on how the flash parameters
> are updated. The following sequence of calls is pursued:
> 
> 1/ spi-nor core legacy flash parameters init:
> 	spi_nor_default_init_params()
> 
> 2/ MFR-based manufacturer flash parameters init:
> 	nor->manufacturer->fixups->default_init()
> 
> 3/ specific flash_info tweeks done when decisions can not be done just on
>    MFR:
> 	nor->info->fixups->default_init()
> 
> 4/ SFDP tables flash parameters init - SFDP knows better:
> 	spi_nor_sfdp_init_params()
> 
> 5/ post SFDP tables flash parameters updates - in case manufacturers get
>    the serial flash tables wrong or incomplete.
> 	nor->info->fixups->post_sfdp()
>    The later can be extended to nor->manufacturer->fixups->post_sfdp() if
>    needed.
> 
> This patch opens doors for steps 2/ and 3/.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/mtd/spi-nor/spi-nor.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 28a64dbdaea9..ac00f90ebaa9 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -219,12 +219,17 @@ struct sfdp_bfpt {
>  
>  /**
>   * struct spi_nor_fixups - SPI NOR fixup hooks
> + * @default_init: called after default flash parameters init. Used to tweak
> + *                flash parameters when information provided by the flash_info
> + *                table is incomplete or wrong.
>   * @post_bfpt: called after the BFPT table has been parsed
>   *
>   * Those hooks can be used to tweak the SPI NOR configuration when the SFDP
>   * table is broken or not available.
>   */
>  struct spi_nor_fixups {
> +	void (*default_init)(struct spi_nor *nor,
> +			     struct spi_nor_flash_parameter *params);
>  	int (*post_bfpt)(struct spi_nor *nor,
>  			 const struct sfdp_parameter_header *bfpt_header,
>  			 const struct sfdp_bfpt *bfpt,
> @@ -4267,6 +4272,14 @@ static int spi_nor_parse_sfdp(struct spi_nor *nor,
>  	return err;
>  }
>  
> +static void
> +spi_nor_manufacturer_init_params(struct spi_nor *nor,
> +				 struct spi_nor_flash_parameter *params)
> +{
> +	if (nor->info->fixups && nor->info->fixups->default_init)
> +		return nor->info->fixups->default_init(nor, params);
> +}
> +
>  static int spi_nor_init_params(struct spi_nor *nor,
>  			       struct spi_nor_flash_parameter *params)
>  {
> @@ -4370,6 +4383,8 @@ static int spi_nor_init_params(struct spi_nor *nor,
>  			params->quad_enable = info->quad_enable;
>  	}
>  
> +	spi_nor_manufacturer_init_params(nor, params);
> +
>  	if ((info->flags & (SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)) &&
>  	    !(info->flags & SPI_NOR_SKIP_SFDP)) {
>  		struct spi_nor_flash_parameter sfdp_params;

