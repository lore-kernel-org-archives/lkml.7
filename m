Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE11C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E16F3205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cyEhjGIJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbfH0HQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 03:16:28 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:60332 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfH0HQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 03:16:27 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7R7GHsL001220;
        Tue, 27 Aug 2019 02:16:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1566890177;
        bh=psaWdewCNrpSmfaNAZDTHLLBdu3D8cJuHsF2p6iYpzw=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=cyEhjGIJAUrgm4hc22EAUh6PxdbzdRzznKh76CGsM3wKf6dz3OCUIxqBR1cwpR9wj
         xSOq7fWWdSwRgDUDHuIl2QEkDAIhXN8D9Ttn/88Ik8Tro+Rp1SrQuDRa3OwnWQaNe7
         b5X88nNA9J3ORvpkbO/YvLkUuW7A/vU7r3Z4tHp8=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7R7GHpC124738
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Aug 2019 02:16:17 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 27
 Aug 2019 02:16:16 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 27 Aug 2019 02:16:16 -0500
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7R7GDnY040199;
        Tue, 27 Aug 2019 02:16:14 -0500
Subject: Re: [RESEND PATCH v3 14/20] mtd: spi_nor: Add a ->setup() method
To:     <Tudor.Ambarus@microchip.com>, <boris.brezillon@collabora.com>,
        <marek.vasut@gmail.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20190826120821.16351-1-tudor.ambarus@microchip.com>
 <20190826120821.16351-15-tudor.ambarus@microchip.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <99f42cb0-6571-553f-7714-dbf1889d3827@ti.com>
Date:   Tue, 27 Aug 2019 12:46:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826120821.16351-15-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/08/19 5:38 PM, Tudor.Ambarus@microchip.com wrote:
> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> nor->params.setup() configures the SPI NOR memory. Useful for SPI NOR
> flashes that have peculiarities to the SPI NOR standard, e.g.
> different opcodes, specific address calculation, page size, etc.
> Right now the only user will be the S3AN chips, but other
> manufacturers can implement it if needed.
> 
> Move spi_nor_setup() related code in order to avoid a forward
> declaration to spi_nor_default_setup().
> 
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

Regards
Vignesh

> v3: collect R-b, rebase on previous commits
> 
>  drivers/mtd/spi-nor/spi-nor.c | 432 +++++++++++++++++++++---------------------
>  include/linux/mtd/spi-nor.h   |   5 +
>  2 files changed, 226 insertions(+), 211 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index b96a7066a36c..2aca56e07341 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -4144,6 +4144,226 @@ static int spi_nor_parse_sfdp(struct spi_nor *nor,
>  	return err;
>  }
>  
> +static int spi_nor_select_read(struct spi_nor *nor,
> +			       u32 shared_hwcaps)
> +{
> +	int cmd, best_match = fls(shared_hwcaps & SNOR_HWCAPS_READ_MASK) - 1;
> +	const struct spi_nor_read_command *read;
> +
> +	if (best_match < 0)
> +		return -EINVAL;
> +
> +	cmd = spi_nor_hwcaps_read2cmd(BIT(best_match));
> +	if (cmd < 0)
> +		return -EINVAL;
> +
> +	read = &nor->params.reads[cmd];
> +	nor->read_opcode = read->opcode;
> +	nor->read_proto = read->proto;
> +
> +	/*
> +	 * In the spi-nor framework, we don't need to make the difference
> +	 * between mode clock cycles and wait state clock cycles.
> +	 * Indeed, the value of the mode clock cycles is used by a QSPI
> +	 * flash memory to know whether it should enter or leave its 0-4-4
> +	 * (Continuous Read / XIP) mode.
> +	 * eXecution In Place is out of the scope of the mtd sub-system.
> +	 * Hence we choose to merge both mode and wait state clock cycles
> +	 * into the so called dummy clock cycles.
> +	 */
> +	nor->read_dummy = read->num_mode_clocks + read->num_wait_states;
> +	return 0;
> +}
> +
> +static int spi_nor_select_pp(struct spi_nor *nor,
> +			     u32 shared_hwcaps)
> +{
> +	int cmd, best_match = fls(shared_hwcaps & SNOR_HWCAPS_PP_MASK) - 1;
> +	const struct spi_nor_pp_command *pp;
> +
> +	if (best_match < 0)
> +		return -EINVAL;
> +
> +	cmd = spi_nor_hwcaps_pp2cmd(BIT(best_match));
> +	if (cmd < 0)
> +		return -EINVAL;
> +
> +	pp = &nor->params.page_programs[cmd];
> +	nor->program_opcode = pp->opcode;
> +	nor->write_proto = pp->proto;
> +	return 0;
> +}
> +
> +/**
> + * spi_nor_select_uniform_erase() - select optimum uniform erase type
> + * @map:		the erase map of the SPI NOR
> + * @wanted_size:	the erase type size to search for. Contains the value of
> + *			info->sector_size or of the "small sector" size in case
> + *			CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is defined.
> + *
> + * Once the optimum uniform sector erase command is found, disable all the
> + * other.
> + *
> + * Return: pointer to erase type on success, NULL otherwise.
> + */
> +static const struct spi_nor_erase_type *
> +spi_nor_select_uniform_erase(struct spi_nor_erase_map *map,
> +			     const u32 wanted_size)
> +{
> +	const struct spi_nor_erase_type *tested_erase, *erase = NULL;
> +	int i;
> +	u8 uniform_erase_type = map->uniform_erase_type;
> +
> +	for (i = SNOR_ERASE_TYPE_MAX - 1; i >= 0; i--) {
> +		if (!(uniform_erase_type & BIT(i)))
> +			continue;
> +
> +		tested_erase = &map->erase_type[i];
> +
> +		/*
> +		 * If the current erase size is the one, stop here:
> +		 * we have found the right uniform Sector Erase command.
> +		 */
> +		if (tested_erase->size == wanted_size) {
> +			erase = tested_erase;
> +			break;
> +		}
> +
> +		/*
> +		 * Otherwise, the current erase size is still a valid canditate.
> +		 * Select the biggest valid candidate.
> +		 */
> +		if (!erase && tested_erase->size)
> +			erase = tested_erase;
> +			/* keep iterating to find the wanted_size */
> +	}
> +
> +	if (!erase)
> +		return NULL;
> +
> +	/* Disable all other Sector Erase commands. */
> +	map->uniform_erase_type &= ~SNOR_ERASE_TYPE_MASK;
> +	map->uniform_erase_type |= BIT(erase - map->erase_type);
> +	return erase;
> +}
> +
> +static int spi_nor_select_erase(struct spi_nor *nor, u32 wanted_size)
> +{
> +	struct spi_nor_erase_map *map = &nor->params.erase_map;
> +	const struct spi_nor_erase_type *erase = NULL;
> +	struct mtd_info *mtd = &nor->mtd;
> +	int i;
> +
> +	/*
> +	 * The previous implementation handling Sector Erase commands assumed
> +	 * that the SPI flash memory has an uniform layout then used only one
> +	 * of the supported erase sizes for all Sector Erase commands.
> +	 * So to be backward compatible, the new implementation also tries to
> +	 * manage the SPI flash memory as uniform with a single erase sector
> +	 * size, when possible.
> +	 */
> +#ifdef CONFIG_MTD_SPI_NOR_USE_4K_SECTORS
> +	/* prefer "small sector" erase if possible */
> +	wanted_size = 4096u;
> +#endif
> +
> +	if (spi_nor_has_uniform_erase(nor)) {
> +		erase = spi_nor_select_uniform_erase(map, wanted_size);
> +		if (!erase)
> +			return -EINVAL;
> +		nor->erase_opcode = erase->opcode;
> +		mtd->erasesize = erase->size;
> +		return 0;
> +	}
> +
> +	/*
> +	 * For non-uniform SPI flash memory, set mtd->erasesize to the
> +	 * maximum erase sector size. No need to set nor->erase_opcode.
> +	 */
> +	for (i = SNOR_ERASE_TYPE_MAX - 1; i >= 0; i--) {
> +		if (map->erase_type[i].size) {
> +			erase = &map->erase_type[i];
> +			break;
> +		}
> +	}
> +
> +	if (!erase)
> +		return -EINVAL;
> +
> +	mtd->erasesize = erase->size;
> +	return 0;
> +}
> +
> +static int spi_nor_default_setup(struct spi_nor *nor,
> +				 const struct spi_nor_hwcaps *hwcaps)
> +{
> +	struct spi_nor_flash_parameter *params = &nor->params;
> +	u32 ignored_mask, shared_mask;
> +	int err;
> +
> +	/*
> +	 * Keep only the hardware capabilities supported by both the SPI
> +	 * controller and the SPI flash memory.
> +	 */
> +	shared_mask = hwcaps->mask & params->hwcaps.mask;
> +
> +	if (nor->spimem) {
> +		/*
> +		 * When called from spi_nor_probe(), all caps are set and we
> +		 * need to discard some of them based on what the SPI
> +		 * controller actually supports (using spi_mem_supports_op()).
> +		 */
> +		spi_nor_spimem_adjust_hwcaps(nor, &shared_mask);
> +	} else {
> +		/*
> +		 * SPI n-n-n protocols are not supported when the SPI
> +		 * controller directly implements the spi_nor interface.
> +		 * Yet another reason to switch to spi-mem.
> +		 */
> +		ignored_mask = SNOR_HWCAPS_X_X_X;
> +		if (shared_mask & ignored_mask) {
> +			dev_dbg(nor->dev,
> +				"SPI n-n-n protocols are not supported.\n");
> +			shared_mask &= ~ignored_mask;
> +		}
> +	}
> +
> +	/* Select the (Fast) Read command. */
> +	err = spi_nor_select_read(nor, shared_mask);
> +	if (err) {
> +		dev_err(nor->dev,
> +			"can't select read settings supported by both the SPI controller and memory.\n");
> +		return err;
> +	}
> +
> +	/* Select the Page Program command. */
> +	err = spi_nor_select_pp(nor, shared_mask);
> +	if (err) {
> +		dev_err(nor->dev,
> +			"can't select write settings supported by both the SPI controller and memory.\n");
> +		return err;
> +	}
> +
> +	/* Select the Sector Erase command. */
> +	err = spi_nor_select_erase(nor, nor->info->sector_size);
> +	if (err) {
> +		dev_err(nor->dev,
> +			"can't select erase settings supported by both the SPI controller and memory.\n");
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static int spi_nor_setup(struct spi_nor *nor,
> +			 const struct spi_nor_hwcaps *hwcaps)
> +{
> +	if (!nor->params.setup)
> +		return 0;
> +
> +	return nor->params.setup(nor, hwcaps);
> +}
> +
>  static void macronix_set_default_init(struct spi_nor *nor)
>  {
>  	nor->params.quad_enable = macronix_quad_enable;
> @@ -4229,6 +4449,7 @@ static void spi_nor_info_init_params(struct spi_nor *nor)
>  	/* Initialize legacy flash parameters and settings. */
>  	params->quad_enable = spansion_quad_enable;
>  	params->set_4byte = spansion_set_4byte;
> +	params->setup = spi_nor_default_setup;
>  
>  	/* Set SPI NOR sizes. */
>  	params->size = (u64)info->sector_size * info->n_sectors;
> @@ -4403,217 +4624,6 @@ static void spi_nor_init_params(struct spi_nor *nor)
>  	spi_nor_late_init_params(nor);
>  }
>  
> -static int spi_nor_select_read(struct spi_nor *nor,
> -			       u32 shared_hwcaps)
> -{
> -	int cmd, best_match = fls(shared_hwcaps & SNOR_HWCAPS_READ_MASK) - 1;
> -	const struct spi_nor_read_command *read;
> -
> -	if (best_match < 0)
> -		return -EINVAL;
> -
> -	cmd = spi_nor_hwcaps_read2cmd(BIT(best_match));
> -	if (cmd < 0)
> -		return -EINVAL;
> -
> -	read = &nor->params.reads[cmd];
> -	nor->read_opcode = read->opcode;
> -	nor->read_proto = read->proto;
> -
> -	/*
> -	 * In the spi-nor framework, we don't need to make the difference
> -	 * between mode clock cycles and wait state clock cycles.
> -	 * Indeed, the value of the mode clock cycles is used by a QSPI
> -	 * flash memory to know whether it should enter or leave its 0-4-4
> -	 * (Continuous Read / XIP) mode.
> -	 * eXecution In Place is out of the scope of the mtd sub-system.
> -	 * Hence we choose to merge both mode and wait state clock cycles
> -	 * into the so called dummy clock cycles.
> -	 */
> -	nor->read_dummy = read->num_mode_clocks + read->num_wait_states;
> -	return 0;
> -}
> -
> -static int spi_nor_select_pp(struct spi_nor *nor,
> -			     u32 shared_hwcaps)
> -{
> -	int cmd, best_match = fls(shared_hwcaps & SNOR_HWCAPS_PP_MASK) - 1;
> -	const struct spi_nor_pp_command *pp;
> -
> -	if (best_match < 0)
> -		return -EINVAL;
> -
> -	cmd = spi_nor_hwcaps_pp2cmd(BIT(best_match));
> -	if (cmd < 0)
> -		return -EINVAL;
> -
> -	pp = &nor->params.page_programs[cmd];
> -	nor->program_opcode = pp->opcode;
> -	nor->write_proto = pp->proto;
> -	return 0;
> -}
> -
> -/**
> - * spi_nor_select_uniform_erase() - select optimum uniform erase type
> - * @map:		the erase map of the SPI NOR
> - * @wanted_size:	the erase type size to search for. Contains the value of
> - *			info->sector_size or of the "small sector" size in case
> - *			CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is defined.
> - *
> - * Once the optimum uniform sector erase command is found, disable all the
> - * other.
> - *
> - * Return: pointer to erase type on success, NULL otherwise.
> - */
> -static const struct spi_nor_erase_type *
> -spi_nor_select_uniform_erase(struct spi_nor_erase_map *map,
> -			     const u32 wanted_size)
> -{
> -	const struct spi_nor_erase_type *tested_erase, *erase = NULL;
> -	int i;
> -	u8 uniform_erase_type = map->uniform_erase_type;
> -
> -	for (i = SNOR_ERASE_TYPE_MAX - 1; i >= 0; i--) {
> -		if (!(uniform_erase_type & BIT(i)))
> -			continue;
> -
> -		tested_erase = &map->erase_type[i];
> -
> -		/*
> -		 * If the current erase size is the one, stop here:
> -		 * we have found the right uniform Sector Erase command.
> -		 */
> -		if (tested_erase->size == wanted_size) {
> -			erase = tested_erase;
> -			break;
> -		}
> -
> -		/*
> -		 * Otherwise, the current erase size is still a valid canditate.
> -		 * Select the biggest valid candidate.
> -		 */
> -		if (!erase && tested_erase->size)
> -			erase = tested_erase;
> -			/* keep iterating to find the wanted_size */
> -	}
> -
> -	if (!erase)
> -		return NULL;
> -
> -	/* Disable all other Sector Erase commands. */
> -	map->uniform_erase_type &= ~SNOR_ERASE_TYPE_MASK;
> -	map->uniform_erase_type |= BIT(erase - map->erase_type);
> -	return erase;
> -}
> -
> -static int spi_nor_select_erase(struct spi_nor *nor, u32 wanted_size)
> -{
> -	struct spi_nor_erase_map *map = &nor->params.erase_map;
> -	const struct spi_nor_erase_type *erase = NULL;
> -	struct mtd_info *mtd = &nor->mtd;
> -	int i;
> -
> -	/*
> -	 * The previous implementation handling Sector Erase commands assumed
> -	 * that the SPI flash memory has an uniform layout then used only one
> -	 * of the supported erase sizes for all Sector Erase commands.
> -	 * So to be backward compatible, the new implementation also tries to
> -	 * manage the SPI flash memory as uniform with a single erase sector
> -	 * size, when possible.
> -	 */
> -#ifdef CONFIG_MTD_SPI_NOR_USE_4K_SECTORS
> -	/* prefer "small sector" erase if possible */
> -	wanted_size = 4096u;
> -#endif
> -
> -	if (spi_nor_has_uniform_erase(nor)) {
> -		erase = spi_nor_select_uniform_erase(map, wanted_size);
> -		if (!erase)
> -			return -EINVAL;
> -		nor->erase_opcode = erase->opcode;
> -		mtd->erasesize = erase->size;
> -		return 0;
> -	}
> -
> -	/*
> -	 * For non-uniform SPI flash memory, set mtd->erasesize to the
> -	 * maximum erase sector size. No need to set nor->erase_opcode.
> -	 */
> -	for (i = SNOR_ERASE_TYPE_MAX - 1; i >= 0; i--) {
> -		if (map->erase_type[i].size) {
> -			erase = &map->erase_type[i];
> -			break;
> -		}
> -	}
> -
> -	if (!erase)
> -		return -EINVAL;
> -
> -	mtd->erasesize = erase->size;
> -	return 0;
> -}
> -
> -static int spi_nor_setup(struct spi_nor *nor,
> -			 const struct spi_nor_hwcaps *hwcaps)
> -{
> -	struct spi_nor_flash_parameter *params = &nor->params;
> -	u32 ignored_mask, shared_mask;
> -	int err;
> -
> -	/*
> -	 * Keep only the hardware capabilities supported by both the SPI
> -	 * controller and the SPI flash memory.
> -	 */
> -	shared_mask = hwcaps->mask & params->hwcaps.mask;
> -
> -	if (nor->spimem) {
> -		/*
> -		 * When called from spi_nor_probe(), all caps are set and we
> -		 * need to discard some of them based on what the SPI
> -		 * controller actually supports (using spi_mem_supports_op()).
> -		 */
> -		spi_nor_spimem_adjust_hwcaps(nor, &shared_mask);
> -	} else {
> -		/*
> -		 * SPI n-n-n protocols are not supported when the SPI
> -		 * controller directly implements the spi_nor interface.
> -		 * Yet another reason to switch to spi-mem.
> -		 */
> -		ignored_mask = SNOR_HWCAPS_X_X_X;
> -		if (shared_mask & ignored_mask) {
> -			dev_dbg(nor->dev,
> -				"SPI n-n-n protocols are not supported.\n");
> -			shared_mask &= ~ignored_mask;
> -		}
> -	}
> -
> -	/* Select the (Fast) Read command. */
> -	err = spi_nor_select_read(nor, shared_mask);
> -	if (err) {
> -		dev_err(nor->dev,
> -			"can't select read settings supported by both the SPI controller and memory.\n");
> -		return err;
> -	}
> -
> -	/* Select the Page Program command. */
> -	err = spi_nor_select_pp(nor, shared_mask);
> -	if (err) {
> -		dev_err(nor->dev,
> -			"can't select write settings supported by both the SPI controller and memory.\n");
> -		return err;
> -	}
> -
> -	/* Select the Sector Erase command. */
> -	err = spi_nor_select_erase(nor, nor->info->sector_size);
> -	if (err) {
> -		dev_err(nor->dev,
> -			"can't select erase settings supported by both the SPI controller and memory.\n");
> -		return err;
> -	}
> -
> -	return 0;
> -}
> -
>  /**
>   * spi_nor_quad_enable() - enable Quad I/O if needed.
>   * @nor:                pointer to a 'struct spi_nor'
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index 35aad92a4ff8..fc0b4b19c900 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -498,6 +498,10 @@ struct spi_nor_locking_ops {
>   * @convert_addr:	converts an absolute address into something the flash
>   *                      will understand. Particularly useful when pagesize is
>   *                      not a power-of-2.
> + * @setup:              configures the SPI NOR memory. Useful for SPI NOR
> + *                      flashes that have peculiarities to the SPI NOR standard
> + *                      e.g. different opcodes, specific address calculation,
> + *                      page size, etc.
>   * @locking_ops:	SPI NOR locking methods.
>   */
>  struct spi_nor_flash_parameter {
> @@ -513,6 +517,7 @@ struct spi_nor_flash_parameter {
>  	int (*quad_enable)(struct spi_nor *nor);
>  	int (*set_4byte)(struct spi_nor *nor, bool enable);
>  	u32 (*convert_addr)(struct spi_nor *nor, u32 addr);
> +	int (*setup)(struct spi_nor *nor, const struct spi_nor_hwcaps *hwcaps);
>  
>  	const struct spi_nor_locking_ops *locking_ops;
>  };
> 

-- 
Regards
Vignesh
