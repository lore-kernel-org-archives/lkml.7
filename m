Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3584C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 09:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDFAC21923
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 09:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbfHGJJn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 05:09:43 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:53369 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728687AbfHGJJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 05:09:43 -0400
X-Originating-IP: 86.250.200.211
Received: from xps13 (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 5C81E60010;
        Wed,  7 Aug 2019 09:09:38 +0000 (UTC)
Date:   Wed, 7 Aug 2019 11:09:37 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     shiva.linuxworks@gmail.com
Cc:     Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Shivamurthy Shastri <sshivamurthy@micron.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jeff Kletsky <git-commits@allycomm.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        liaoweixiong <liaoweixiong@allwinnertech.com>
Subject: Re: [PATCH 3/8] mtd: nand: create ONFI table parsing instance
Message-ID: <20190807110937.4dfe1746@xps13>
In-Reply-To: <20190722055621.23526-4-sshivamurthy@micron.com>
References: <20190722055621.23526-1-sshivamurthy@micron.com>
        <20190722055621.23526-4-sshivamurthy@micron.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shiva,

shiva.linuxworks@gmail.com wrote on Mon, 22 Jul 2019 07:56:16 +0200:

> From: Shivamurthy Shastri <sshivamurthy@micron.com>

"Create one generic ONFI table parsing instance"

> 
> ONFI table parsing is common, as most of the variables are common
> between raw and SPI NAND. The parsing function is instantiated in
> onfi.c, which fills ONFI parameters into nand_memory_organization.

... into nand_memory_organization just as before.

> 
> Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
> ---
>  drivers/mtd/nand/onfi.c          | 32 ++++++++++++++++++++++++++++++++
>  drivers/mtd/nand/raw/nand_onfi.c | 22 ++--------------------
>  include/linux/mtd/onfi.h         |  2 ++
>  3 files changed, 36 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/mtd/nand/onfi.c b/drivers/mtd/nand/onfi.c
> index 7aaf36dfc5e0..e78700894aea 100644
> --- a/drivers/mtd/nand/onfi.c
> +++ b/drivers/mtd/nand/onfi.c
> @@ -87,3 +87,35 @@ void sanitize_string(u8 *s, size_t len)
>  	strim(s);
>  }
>  EXPORT_SYMBOL_GPL(sanitize_string);
> +
> +/**
> + * fill_nand_memorg() - Parse ONFI table and fill memorg

      ^ parse_onfi_params() - Parse an ONFI table and fill a memory
      organization structure

> + * @memorg: NAND memorg to be filled

                    memory organization core structure to be filled

> + * @p: ONFI table to be parsed
> + *
> + */
> +void parse_onfi_params(struct nand_memory_organization *memorg,
> +		       struct nand_onfi_params *p)
> +{
> +	memorg->pagesize = le32_to_cpu(p->byte_per_page);
> +
> +	/*
> +	 * pages_per_block and blocks_per_lun may not be a power-of-2 size
> +	 * (don't ask me who thought of this...). MTD assumes that these
> +	 * dimensions will be power-of-2, so just truncate the remaining area.
> +	 */
> +	memorg->pages_per_eraseblock =
> +			1 << (fls(le32_to_cpu(p->pages_per_block)) - 1);
> +
> +	memorg->oobsize = le16_to_cpu(p->spare_bytes_per_page);
> +
> +	memorg->luns_per_target = p->lun_count;
> +	memorg->planes_per_lun = 1 << p->interleaved_bits;
> +
> +	/* See erasesize comment */
> +	memorg->eraseblocks_per_lun =
> +		1 << (fls(le32_to_cpu(p->blocks_per_lun)) - 1);
> +	memorg->max_bad_eraseblocks_per_lun = le32_to_cpu(p->blocks_per_lun);
> +	memorg->bits_per_cell = p->bits_per_cell;
> +}
> +EXPORT_SYMBOL_GPL(parse_onfi_params);
> diff --git a/drivers/mtd/nand/raw/nand_onfi.c b/drivers/mtd/nand/raw/nand_onfi.c
> index 2e8edfa636ef..263796d3298c 100644
> --- a/drivers/mtd/nand/raw/nand_onfi.c
> +++ b/drivers/mtd/nand/raw/nand_onfi.c
> @@ -181,30 +181,12 @@ int nand_onfi_detect(struct nand_chip *chip)
>  		goto free_onfi_param_page;
>  	}
>  
> -	memorg->pagesize = le32_to_cpu(p->byte_per_page);
> -	mtd->writesize = memorg->pagesize;
> +	parse_onfi_params(memorg, p);
>  
> -	/*
> -	 * pages_per_block and blocks_per_lun may not be a power-of-2 size
> -	 * (don't ask me who thought of this...). MTD assumes that these
> -	 * dimensions will be power-of-2, so just truncate the remaining area.
> -	 */
> -	memorg->pages_per_eraseblock =
> -			1 << (fls(le32_to_cpu(p->pages_per_block)) - 1);
> +	mtd->writesize = memorg->pagesize;
>  	mtd->erasesize = memorg->pages_per_eraseblock * memorg->pagesize;
> -
> -	memorg->oobsize = le16_to_cpu(p->spare_bytes_per_page);
>  	mtd->oobsize = memorg->oobsize;
>  
> -	memorg->luns_per_target = p->lun_count;
> -	memorg->planes_per_lun = 1 << p->interleaved_bits;
> -
> -	/* See erasesize comment */
> -	memorg->eraseblocks_per_lun =
> -		1 << (fls(le32_to_cpu(p->blocks_per_lun)) - 1);
> -	memorg->max_bad_eraseblocks_per_lun = le32_to_cpu(p->blocks_per_lun);
> -	memorg->bits_per_cell = p->bits_per_cell;
> -
>  	if (le16_to_cpu(p->features) & ONFI_FEATURE_16_BIT_BUS)
>  		chip->options |= NAND_BUSWIDTH_16;
>  
> diff --git a/include/linux/mtd/onfi.h b/include/linux/mtd/onfi.h
> index 2c8a05a02bb0..4cacf4e9db6d 100644
> --- a/include/linux/mtd/onfi.h
> +++ b/include/linux/mtd/onfi.h
> @@ -183,5 +183,7 @@ void nand_bit_wise_majority(const void **srcbufs,
>  			    void *dstbuf,
>  			    unsigned int bufsize);
>  void sanitize_string(u8 *s, size_t len);
> +void parse_onfi_params(struct nand_memory_organization *memorg,
> +		       struct nand_onfi_params *p);
>  
>  #endif /* __LINUX_MTD_ONFI_H */




Thanks,
Miquèl
