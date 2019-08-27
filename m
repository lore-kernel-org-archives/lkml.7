Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A700C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B1B82189D
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="U5DGvw3D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbfH0HJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 03:09:40 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42826 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfH0HJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 03:09:39 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7R79STM106917;
        Tue, 27 Aug 2019 02:09:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1566889768;
        bh=L4CsoR9kyF0hZV2P6fxDodIlymhCPt1+Z5sMGLgkq/I=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=U5DGvw3D/XfK5S+7Q7z2auIrJd34DRjTQm7jBm7cP56ljh5no0anoAyl/Av0I7XWg
         SoL6LqpZDjZ0HH7XlR5PnWDI2WhiPjarkEZk/SUHdbayMKLmidu0lN4KU2EzXLaxYM
         BHFmlKJtKr3kPKm4FD75BFZ7xHIRXTxjkiHXSsKg=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7R79SY2094956
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Aug 2019 02:09:28 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 27
 Aug 2019 02:09:28 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 27 Aug 2019 02:09:28 -0500
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7R79OAV076726;
        Tue, 27 Aug 2019 02:09:25 -0500
Subject: Re: [RESEND PATCH v3 12/20] mtd: spi-nor: Add
 spansion_post_sfdp_fixups()
To:     <Tudor.Ambarus@microchip.com>, <boris.brezillon@collabora.com>,
        <marek.vasut@gmail.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <boris.brezillon@bootlin.com>
References: <20190826120821.16351-1-tudor.ambarus@microchip.com>
 <20190826120821.16351-13-tudor.ambarus@microchip.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <8f10d895-f97e-934e-8dd4-be22839a7c77@ti.com>
Date:   Tue, 27 Aug 2019 12:40:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826120821.16351-13-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/08/19 5:38 PM, Tudor.Ambarus@microchip.com wrote:
> From: Boris Brezillon <boris.brezillon@bootlin.com>
> 
> Add a spansion_post_sfdp_fixups() function to fix the erase opcode,
> erase sector size and set the SNOR_F_4B_OPCODES flag.
> This way, all spansion related quirks are placed in the
> spansion_post_sfdp_fixups() function.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

Regards
Vignesh

> v3: no changes, rebase on previous commits
> 
>  drivers/mtd/spi-nor/spi-nor.c | 37 +++++++++++++++++++++++--------------
>  1 file changed, 23 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index b8caf5171ff5..c862a59ce9df 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -591,18 +591,6 @@ static u8 spi_nor_convert_3to4_erase(u8 opcode)
>  
>  static void spi_nor_set_4byte_opcodes(struct spi_nor *nor)
>  {
> -	/* Do some manufacturer fixups first */
> -	switch (JEDEC_MFR(nor->info)) {
> -	case SNOR_MFR_SPANSION:
> -		/* No small sector erase for 4-byte command set */
> -		nor->erase_opcode = SPINOR_OP_SE;
> -		nor->mtd.erasesize = nor->info->sector_size;
> -		break;
> -
> -	default:
> -		break;
> -	}
> -
>  	nor->read_opcode = spi_nor_convert_3to4_read(nor->read_opcode);
>  	nor->program_opcode = spi_nor_convert_3to4_program(nor->program_opcode);
>  	nor->erase_opcode = spi_nor_convert_3to4_erase(nor->erase_opcode);
> @@ -4304,6 +4292,19 @@ static void spi_nor_info_init_params(struct spi_nor *nor)
>  	spi_nor_init_uniform_erase_map(map, erase_mask, params->size);
>  }
>  
> +static void spansion_post_sfdp_fixups(struct spi_nor *nor)
> +{
> +	struct mtd_info *mtd = &nor->mtd;
> +
> +	if (mtd->size <= SZ_16M)
> +		return;
> +
> +	nor->flags |= SNOR_F_4B_OPCODES;
> +	/* No small sector erase for 4-byte command set */
> +	nor->erase_opcode = SPINOR_OP_SE;
> +	nor->mtd.erasesize = nor->info->sector_size;
> +}
> +
>  /**
>   * spi_nor_post_sfdp_fixups() - Updates the flash's parameters and settings
>   * after SFDP has been parsed (is also called for SPI NORs that do not
> @@ -4316,6 +4317,15 @@ static void spi_nor_info_init_params(struct spi_nor *nor)
>   */
>  static void spi_nor_post_sfdp_fixups(struct spi_nor *nor)
>  {
> +	switch (JEDEC_MFR(nor->info)) {
> +	case SNOR_MFR_SPANSION:
> +		spansion_post_sfdp_fixups(nor);
> +		break;
> +
> +	default:
> +		break;
> +	}
> +
>  	if (nor->info->fixups && nor->info->fixups->post_sfdp)
>  		nor->info->fixups->post_sfdp(nor);
>  }
> @@ -4862,8 +4872,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
>  		nor->addr_width = 3;
>  	}
>  
> -	if (info->flags & SPI_NOR_4B_OPCODES ||
> -	    (JEDEC_MFR(info) == SNOR_MFR_SPANSION && mtd->size > SZ_16M))
> +	if (info->flags & SPI_NOR_4B_OPCODES)
>  		nor->flags |= SNOR_F_4B_OPCODES;
>  
>  	if (nor->addr_width == 4 && nor->flags & SNOR_F_4B_OPCODES &&
> 

-- 
Regards
Vignesh
