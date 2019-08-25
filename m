Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453D6C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 11:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D6D32173E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 11:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbfHYLcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 07:32:05 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37722 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfHYLcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 07:32:05 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id C83C928A5BC;
        Sun, 25 Aug 2019 12:32:03 +0100 (BST)
Date:   Sun, 25 Aug 2019 13:32:01 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <marek.vasut@gmail.com>, <vigneshr@ti.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] mtd: spi-nor: Regroup flash parameter and settings
Message-ID: <20190825133201.135d6793@collabora.com>
In-Reply-To: <20190823155325.13459-2-tudor.ambarus@microchip.com>
References: <20190823155325.13459-1-tudor.ambarus@microchip.com>
        <20190823155325.13459-2-tudor.ambarus@microchip.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Aug 2019 15:53:35 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> The scope is to move all [FLASH-SPECIFIC] parameters and settings
> from 'struct spi_nor' to 'struct spi_nor_flash_parameter'.
> 
> 'struct spi_nor_flash_parameter' describes the hardware capabilities
> and associated settings of the SPI NOR flash memory. It includes
> legacy flash parameters and settings that can be overwritten by the
> spi_nor_fixups hooks, or dynamically when parsing the JESD216
> Serial Flash Discoverable Parameters (SFDP) tables. All SFDP params
> and settings will fit inside 'struct spi_nor_flash_parameter'.
> 
> Move spi_nor_hwcaps related code to avoid forward declarations.
> Add a forward declaration that we can't avoid: 'struct spi_nor' will
> be used in 'struct spi_nor_flash_parameter'.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/mtd/spi-nor/spi-nor.c |  65 ------------
>  include/linux/mtd/spi-nor.h   | 239 +++++++++++++++++++++++++++++-------------
>  2 files changed, 164 insertions(+), 140 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 0597cb8257b0..d35dc6a97521 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -40,71 +40,6 @@
>  #define SPI_NOR_MAX_ID_LEN	6
>  #define SPI_NOR_MAX_ADDR_WIDTH	4
>  
> -struct spi_nor_read_command {
> -	u8			num_mode_clocks;
> -	u8			num_wait_states;
> -	u8			opcode;
> -	enum spi_nor_protocol	proto;
> -};
> -
> -struct spi_nor_pp_command {
> -	u8			opcode;
> -	enum spi_nor_protocol	proto;
> -};
> -
> -enum spi_nor_read_command_index {
> -	SNOR_CMD_READ,
> -	SNOR_CMD_READ_FAST,
> -	SNOR_CMD_READ_1_1_1_DTR,
> -
> -	/* Dual SPI */
> -	SNOR_CMD_READ_1_1_2,
> -	SNOR_CMD_READ_1_2_2,
> -	SNOR_CMD_READ_2_2_2,
> -	SNOR_CMD_READ_1_2_2_DTR,
> -
> -	/* Quad SPI */
> -	SNOR_CMD_READ_1_1_4,
> -	SNOR_CMD_READ_1_4_4,
> -	SNOR_CMD_READ_4_4_4,
> -	SNOR_CMD_READ_1_4_4_DTR,
> -
> -	/* Octal SPI */
> -	SNOR_CMD_READ_1_1_8,
> -	SNOR_CMD_READ_1_8_8,
> -	SNOR_CMD_READ_8_8_8,
> -	SNOR_CMD_READ_1_8_8_DTR,
> -
> -	SNOR_CMD_READ_MAX
> -};
> -
> -enum spi_nor_pp_command_index {
> -	SNOR_CMD_PP,
> -
> -	/* Quad SPI */
> -	SNOR_CMD_PP_1_1_4,
> -	SNOR_CMD_PP_1_4_4,
> -	SNOR_CMD_PP_4_4_4,
> -
> -	/* Octal SPI */
> -	SNOR_CMD_PP_1_1_8,
> -	SNOR_CMD_PP_1_8_8,
> -	SNOR_CMD_PP_8_8_8,
> -
> -	SNOR_CMD_PP_MAX
> -};
> -
> -struct spi_nor_flash_parameter {
> -	u64				size;
> -	u32				page_size;
> -
> -	struct spi_nor_hwcaps		hwcaps;
> -	struct spi_nor_read_command	reads[SNOR_CMD_READ_MAX];
> -	struct spi_nor_pp_command	page_programs[SNOR_CMD_PP_MAX];
> -
> -	int (*quad_enable)(struct spi_nor *nor);
> -};
> -
>  struct sfdp_parameter_header {
>  	u8		id_lsb;
>  	u8		minor;
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index 3075ac73b171..77ba692d9348 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -334,6 +334,165 @@ struct spi_nor_erase_map {
>  };
>  
>  /**
> + * struct spi_nor_hwcaps - Structure for describing the hardware capabilies
> + * supported by the SPI controller (bus master).
> + * @mask:		the bitmask listing all the supported hw capabilies
> + */
> +struct spi_nor_hwcaps {
> +	u32	mask;
> +};
> +
> +/*
> + *(Fast) Read capabilities.
> + * MUST be ordered by priority: the higher bit position, the higher priority.
> + * As a matter of performances, it is relevant to use Octal SPI protocols first,
> + * then Quad SPI protocols before Dual SPI protocols, Fast Read and lastly
> + * (Slow) Read.
> + */
> +#define SNOR_HWCAPS_READ_MASK		GENMASK(14, 0)
> +#define SNOR_HWCAPS_READ		BIT(0)
> +#define SNOR_HWCAPS_READ_FAST		BIT(1)
> +#define SNOR_HWCAPS_READ_1_1_1_DTR	BIT(2)
> +
> +#define SNOR_HWCAPS_READ_DUAL		GENMASK(6, 3)
> +#define SNOR_HWCAPS_READ_1_1_2		BIT(3)
> +#define SNOR_HWCAPS_READ_1_2_2		BIT(4)
> +#define SNOR_HWCAPS_READ_2_2_2		BIT(5)
> +#define SNOR_HWCAPS_READ_1_2_2_DTR	BIT(6)
> +
> +#define SNOR_HWCAPS_READ_QUAD		GENMASK(10, 7)
> +#define SNOR_HWCAPS_READ_1_1_4		BIT(7)
> +#define SNOR_HWCAPS_READ_1_4_4		BIT(8)
> +#define SNOR_HWCAPS_READ_4_4_4		BIT(9)
> +#define SNOR_HWCAPS_READ_1_4_4_DTR	BIT(10)
> +
> +#define SNOR_HWCAPS_READ_OCTAL		GENMASK(14, 11)
> +#define SNOR_HWCAPS_READ_1_1_8		BIT(11)
> +#define SNOR_HWCAPS_READ_1_8_8		BIT(12)
> +#define SNOR_HWCAPS_READ_8_8_8		BIT(13)
> +#define SNOR_HWCAPS_READ_1_8_8_DTR	BIT(14)
> +
> +/*
> + * Page Program capabilities.
> + * MUST be ordered by priority: the higher bit position, the higher priority.
> + * Like (Fast) Read capabilities, Octal/Quad SPI protocols are preferred to the
> + * legacy SPI 1-1-1 protocol.
> + * Note that Dual Page Programs are not supported because there is no existing
> + * JEDEC/SFDP standard to define them. Also at this moment no SPI flash memory
> + * implements such commands.
> + */
> +#define SNOR_HWCAPS_PP_MASK	GENMASK(22, 16)
> +#define SNOR_HWCAPS_PP		BIT(16)
> +
> +#define SNOR_HWCAPS_PP_QUAD	GENMASK(19, 17)
> +#define SNOR_HWCAPS_PP_1_1_4	BIT(17)
> +#define SNOR_HWCAPS_PP_1_4_4	BIT(18)
> +#define SNOR_HWCAPS_PP_4_4_4	BIT(19)
> +
> +#define SNOR_HWCAPS_PP_OCTAL	GENMASK(22, 20)
> +#define SNOR_HWCAPS_PP_1_1_8	BIT(20)
> +#define SNOR_HWCAPS_PP_1_8_8	BIT(21)
> +#define SNOR_HWCAPS_PP_8_8_8	BIT(22)
> +
> +#define SNOR_HWCAPS_X_X_X	(SNOR_HWCAPS_READ_2_2_2 |	\
> +				 SNOR_HWCAPS_READ_4_4_4 |	\
> +				 SNOR_HWCAPS_READ_8_8_8 |	\
> +				 SNOR_HWCAPS_PP_4_4_4 |		\
> +				 SNOR_HWCAPS_PP_8_8_8)
> +
> +#define SNOR_HWCAPS_DTR		(SNOR_HWCAPS_READ_1_1_1_DTR |	\
> +				 SNOR_HWCAPS_READ_1_2_2_DTR |	\
> +				 SNOR_HWCAPS_READ_1_4_4_DTR |	\
> +				 SNOR_HWCAPS_READ_1_8_8_DTR)
> +
> +#define SNOR_HWCAPS_ALL		(SNOR_HWCAPS_READ_MASK |	\
> +				 SNOR_HWCAPS_PP_MASK)
> +
> +struct spi_nor_read_command {
> +	u8			num_mode_clocks;
> +	u8			num_wait_states;
> +	u8			opcode;
> +	enum spi_nor_protocol	proto;
> +};
> +
> +struct spi_nor_pp_command {
> +	u8			opcode;
> +	enum spi_nor_protocol	proto;
> +};
> +
> +enum spi_nor_read_command_index {
> +	SNOR_CMD_READ,
> +	SNOR_CMD_READ_FAST,
> +	SNOR_CMD_READ_1_1_1_DTR,
> +
> +	/* Dual SPI */
> +	SNOR_CMD_READ_1_1_2,
> +	SNOR_CMD_READ_1_2_2,
> +	SNOR_CMD_READ_2_2_2,
> +	SNOR_CMD_READ_1_2_2_DTR,
> +
> +	/* Quad SPI */
> +	SNOR_CMD_READ_1_1_4,
> +	SNOR_CMD_READ_1_4_4,
> +	SNOR_CMD_READ_4_4_4,
> +	SNOR_CMD_READ_1_4_4_DTR,
> +
> +	/* Octal SPI */
> +	SNOR_CMD_READ_1_1_8,
> +	SNOR_CMD_READ_1_8_8,
> +	SNOR_CMD_READ_8_8_8,
> +	SNOR_CMD_READ_1_8_8_DTR,
> +
> +	SNOR_CMD_READ_MAX
> +};
> +
> +enum spi_nor_pp_command_index {
> +	SNOR_CMD_PP,
> +
> +	/* Quad SPI */
> +	SNOR_CMD_PP_1_1_4,
> +	SNOR_CMD_PP_1_4_4,
> +	SNOR_CMD_PP_4_4_4,
> +
> +	/* Octal SPI */
> +	SNOR_CMD_PP_1_1_8,
> +	SNOR_CMD_PP_1_8_8,
> +	SNOR_CMD_PP_8_8_8,
> +
> +	SNOR_CMD_PP_MAX
> +};
> +
> +/* Forward declaration that will be used in 'struct spi_nor_flash_parameter' */
> +struct spi_nor;
> +
> +/**
> + * struct spi_nor_flash_parameter - SPI NOR flash parameters and settings.
> + * Includes legacy flash parameters and settings that can be overwritten
> + * by the spi_nor_fixups hooks, or dynamically when parsing the JESD216
> + * Serial Flash Discoverable Parameters (SFDP) tables.
> + *
> + * @size:		the flash memory density in bytes.
> + * @page_size:		the page size of the SPI NOR flash memory.
> + * @hwcaps:		describes the read and page program hardware
> + *			capabilities.
> + * @reads:		read capabilities ordered by priority: the higher index
> + *                      in the array, the higher priority.
> + * @page_programs:	page program capabilities ordered by priority: the
> + *                      higher index in the array, the higher priority.
> + * @quad_enable:	enables SPI NOR quad mode.
> + */
> +struct spi_nor_flash_parameter {
> +	u64				size;
> +	u32				page_size;
> +
> +	struct spi_nor_hwcaps		hwcaps;
> +	struct spi_nor_read_command	reads[SNOR_CMD_READ_MAX];
> +	struct spi_nor_pp_command	page_programs[SNOR_CMD_PP_MAX];
> +
> +	int (*quad_enable)(struct spi_nor *nor);
> +};
> +
> +/**
>   * struct flash_info - Forward declaration of a structure used internally by
>   *		       spi_nor_scan()
>   */
> @@ -379,6 +538,10 @@ struct flash_info;
>   * @quad_enable:	[FLASH-SPECIFIC] enables SPI NOR quad mode
>   * @clear_sr_bp:	[FLASH-SPECIFIC] clears the Block Protection Bits from
>   *			the SPI NOR Status Register.
> + * @params:		[FLASH-SPECIFIC] SPI-NOR flash parameters and settings.
> + *                      The structure includes legacy flash parameters and
> + *                      settings that can be overwritten by the spi_nor_fixups
> + *                      hooks, or dynamically when parsing the SFDP tables.
>   * @priv:		the private data
>   */
>  struct spi_nor {
> @@ -418,6 +581,7 @@ struct spi_nor {
>  	int (*flash_is_locked)(struct spi_nor *nor, loff_t ofs, uint64_t len);
>  	int (*quad_enable)(struct spi_nor *nor);
>  	int (*clear_sr_bp)(struct spi_nor *nor);
> +	struct spi_nor_flash_parameter params;
>  
>  	void *priv;
>  };
> @@ -463,81 +627,6 @@ static inline struct device_node *spi_nor_get_flash_node(struct spi_nor *nor)
>  }
>  
>  /**
> - * struct spi_nor_hwcaps - Structure for describing the hardware capabilies
> - * supported by the SPI controller (bus master).
> - * @mask:		the bitmask listing all the supported hw capabilies
> - */
> -struct spi_nor_hwcaps {
> -	u32	mask;
> -};
> -
> -/*
> - *(Fast) Read capabilities.
> - * MUST be ordered by priority: the higher bit position, the higher priority.
> - * As a matter of performances, it is relevant to use Octal SPI protocols first,
> - * then Quad SPI protocols before Dual SPI protocols, Fast Read and lastly
> - * (Slow) Read.
> - */
> -#define SNOR_HWCAPS_READ_MASK		GENMASK(14, 0)
> -#define SNOR_HWCAPS_READ		BIT(0)
> -#define SNOR_HWCAPS_READ_FAST		BIT(1)
> -#define SNOR_HWCAPS_READ_1_1_1_DTR	BIT(2)
> -
> -#define SNOR_HWCAPS_READ_DUAL		GENMASK(6, 3)
> -#define SNOR_HWCAPS_READ_1_1_2		BIT(3)
> -#define SNOR_HWCAPS_READ_1_2_2		BIT(4)
> -#define SNOR_HWCAPS_READ_2_2_2		BIT(5)
> -#define SNOR_HWCAPS_READ_1_2_2_DTR	BIT(6)
> -
> -#define SNOR_HWCAPS_READ_QUAD		GENMASK(10, 7)
> -#define SNOR_HWCAPS_READ_1_1_4		BIT(7)
> -#define SNOR_HWCAPS_READ_1_4_4		BIT(8)
> -#define SNOR_HWCAPS_READ_4_4_4		BIT(9)
> -#define SNOR_HWCAPS_READ_1_4_4_DTR	BIT(10)
> -
> -#define SNOR_HWCAPS_READ_OCTAL		GENMASK(14, 11)
> -#define SNOR_HWCAPS_READ_1_1_8		BIT(11)
> -#define SNOR_HWCAPS_READ_1_8_8		BIT(12)
> -#define SNOR_HWCAPS_READ_8_8_8		BIT(13)
> -#define SNOR_HWCAPS_READ_1_8_8_DTR	BIT(14)
> -
> -/*
> - * Page Program capabilities.
> - * MUST be ordered by priority: the higher bit position, the higher priority.
> - * Like (Fast) Read capabilities, Octal/Quad SPI protocols are preferred to the
> - * legacy SPI 1-1-1 protocol.
> - * Note that Dual Page Programs are not supported because there is no existing
> - * JEDEC/SFDP standard to define them. Also at this moment no SPI flash memory
> - * implements such commands.
> - */
> -#define SNOR_HWCAPS_PP_MASK	GENMASK(22, 16)
> -#define SNOR_HWCAPS_PP		BIT(16)
> -
> -#define SNOR_HWCAPS_PP_QUAD	GENMASK(19, 17)
> -#define SNOR_HWCAPS_PP_1_1_4	BIT(17)
> -#define SNOR_HWCAPS_PP_1_4_4	BIT(18)
> -#define SNOR_HWCAPS_PP_4_4_4	BIT(19)
> -
> -#define SNOR_HWCAPS_PP_OCTAL	GENMASK(22, 20)
> -#define SNOR_HWCAPS_PP_1_1_8	BIT(20)
> -#define SNOR_HWCAPS_PP_1_8_8	BIT(21)
> -#define SNOR_HWCAPS_PP_8_8_8	BIT(22)
> -
> -#define SNOR_HWCAPS_X_X_X	(SNOR_HWCAPS_READ_2_2_2 |	\
> -				 SNOR_HWCAPS_READ_4_4_4 |	\
> -				 SNOR_HWCAPS_READ_8_8_8 |	\
> -				 SNOR_HWCAPS_PP_4_4_4 |		\
> -				 SNOR_HWCAPS_PP_8_8_8)
> -
> -#define SNOR_HWCAPS_DTR		(SNOR_HWCAPS_READ_1_1_1_DTR |	\
> -				 SNOR_HWCAPS_READ_1_2_2_DTR |	\
> -				 SNOR_HWCAPS_READ_1_4_4_DTR |	\
> -				 SNOR_HWCAPS_READ_1_8_8_DTR)
> -
> -#define SNOR_HWCAPS_ALL		(SNOR_HWCAPS_READ_MASK |	\
> -				 SNOR_HWCAPS_PP_MASK)
> -
> -/**
>   * spi_nor_scan() - scan the SPI NOR
>   * @nor:	the spi_nor structure
>   * @name:	the chip type name

