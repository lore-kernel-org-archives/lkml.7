Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19EA3C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 11:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE7F12070B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 11:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfCDLVg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 06:21:36 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:44797 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfCDLVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 06:21:36 -0500
X-Originating-IP: 90.88.147.150
Received: from xps13 (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr [90.88.147.150])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id BA094E0014;
        Mon,  4 Mar 2019 11:21:31 +0000 (UTC)
Date:   Mon, 4 Mar 2019 12:21:30 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "richard@nod.at" <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH v4 5/7] mtd: rawnand: Support bad block markers in
 first, second or last page
Message-ID: <20190304122130.4b659bee@xps13>
In-Reply-To: <20190218104122.18788-6-frieder.schrempf@kontron.de>
References: <20190218104122.18788-1-frieder.schrempf@kontron.de>
        <20190218104122.18788-6-frieder.schrempf@kontron.de>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Schrempf,

Schrempf Frieder <frieder.schrempf@kontron.de> wrote on Mon, 18 Feb
2019 10:42:45 +0000:

> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> Currently supported bad block marker positions within the block are:
> * in first page only
> * in last page only
> * in first or second page
> 
> Some ESMT NANDs are known to have been shipped by the manufacturer
> with bad block markers in the first or last page, instead of the
> first or second page.
> 
> Also the datasheets for Cypress/Spansion/AMD NANDs claim that the
> first, second *and* last page needs to be checked.
> 
> Therefore we make it possible to set NAND_BBM_FIRSTPAGE,
> NAND_BBM_SECONDPAGE and NAND_BBM_LASTPAGE independently in any
> combination.
> 
> To simplify the code, the logic to evaluate the flags is moved to a
> a new function nand_bbm_get_next_page().
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>
> ---
>  drivers/mtd/nand/raw/internals.h |  1 +
>  drivers/mtd/nand/raw/nand_base.c | 62 ++++++++++++++++++++++++-----------
>  drivers/mtd/nand/raw/nand_bbt.c  | 29 +++++++---------
>  3 files changed, 55 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/internals.h b/drivers/mtd/nand/raw/internals.h
> index fbf6ca015cd7..97ae67e009d5 100644
> --- a/drivers/mtd/nand/raw/internals.h
> +++ b/drivers/mtd/nand/raw/internals.h
> @@ -76,6 +76,7 @@ extern const struct nand_manufacturer_ops toshiba_nand_manuf_ops;
>  
>  /* Core functions */
>  const struct nand_manufacturer *nand_get_manufacturer(u8 id);
> +int nand_bbm_get_next_page(struct nand_chip *chip, int page);
>  int nand_markbad_bbm(struct nand_chip *chip, loff_t ofs);
>  int nand_erase_nand(struct nand_chip *chip, struct erase_info *instr,
>  		    int allowbbt);
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index 9ef7b86cdc42..7bc20c1fe23c 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -285,6 +285,31 @@ static void nand_release_device(struct nand_chip *chip)
>  	spin_unlock(&chip->controller->lock);
>  }
>  
> +/**
> + * nand_bbm_get_next_page - Get the next page for bad block markers
> + * @chip: NAND chip object
> + * @index: Current page, only pages beyond this will be considered

Why pages *beyond*? Can't you change the logic to use the page from
where to start searching? I am not sure such a change would be
clearer in the rest of the code but I don't like the tests against
"-1". Maybe you could just check negative values instead.

> + *
> + * Returns an integer that corresponds to the page offset within a block, for
> + * a page that is used to store bad block markers. If no more pages are
> + * available, -1 is returned.
> + */
> +int nand_bbm_get_next_page(struct nand_chip *chip, int page)
> +{
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	int last_page = ((mtd->erasesize - mtd->writesize) >>
> +			 chip->page_shift) & chip->pagemask;
> +
> +	if (page < 0 && chip->options & NAND_BBM_FIRSTPAGE)
> +		return 0;
> +	else if (page < 1 && chip->options & NAND_BBM_SECONDPAGE)
> +		return 1;
> +	else if (page < last_page && chip->options & NAND_BBM_LASTPAGE)
> +		return last_page;
> +
> +	return -1;

I would prefer a named value (like -EINVAL) and checks against a
negative value (not -1).

> +}
> +
>  /**
>   * nand_block_bad - [DEFAULT] Read bad block marker from the chip
>   * @chip: NAND chip object
> @@ -294,19 +319,14 @@ static void nand_release_device(struct nand_chip *chip)
>   */
>  static int nand_block_bad(struct nand_chip *chip, loff_t ofs)
>  {
> -	struct mtd_info *mtd = nand_to_mtd(chip);
> -	int page, page_end, res;
> +	int page_offset;
> +	int res, first_page = (int)(ofs >> chip->page_shift) & chip->pagemask;

Maybe:

        int first_page, page_offset;
        int res;
        u8 bad;

        first_page = (int)(ofs >> chip->page_shift) & chip->pagemask;
        page_offset = nand_bbm_get_next_page(chip, -1);

>  	u8 bad;
>  
> -	if (chip->options & NAND_BBM_LASTPAGE)
> -		ofs += mtd->erasesize - mtd->writesize;
> +	page_offset = nand_bbm_get_next_page(chip, -1);
>  
> -	page = (int)(ofs >> chip->page_shift) & chip->pagemask;
> -	page_end = page + (((chip->options & NAND_BBM_FIRSTPAGE) &&
> -			    (chip->options & NAND_BBM_SECONDPAGE)) ? 2 : 1);
> -
> -	for (; page < page_end; page++) {
> -		res = chip->ecc.read_oob(chip, page);
> +	while (page_offset != -1) {
> +		res = chip->ecc.read_oob(chip, first_page + page_offset);
>  		if (res < 0)
>  			return res;
>  
> @@ -318,6 +338,8 @@ static int nand_block_bad(struct nand_chip *chip, loff_t ofs)
>  			res = hweight8(bad) < chip->badblockbits;
>  		if (res)
>  			return res;
> +
> +		page_offset = nand_bbm_get_next_page(chip, page_offset);
>  	}
>  
>  	return 0;
> @@ -528,7 +550,7 @@ static int nand_default_block_markbad(struct nand_chip *chip, loff_t ofs)
>  	struct mtd_info *mtd = nand_to_mtd(chip);
>  	struct mtd_oob_ops ops;
>  	uint8_t buf[2] = { 0, 0 };
> -	int ret = 0, res, i = 0;
> +	int ret = 0, res, page_offset;
>  
>  	memset(&ops, 0, sizeof(ops));
>  	ops.oobbuf = buf;
> @@ -541,18 +563,18 @@ static int nand_default_block_markbad(struct nand_chip *chip, loff_t ofs)
>  	}
>  	ops.mode = MTD_OPS_PLACE_OOB;
>  
> -	/* Write to first/last page(s) if necessary */
> -	if (chip->options & NAND_BBM_LASTPAGE)
> -		ofs += mtd->erasesize - mtd->writesize;
> -	do {
> -		res = nand_do_write_oob(chip, ofs, &ops);
> +	page_offset = nand_bbm_get_next_page(chip, -1);
> +
> +	while (page_offset != -1) {
> +		res = nand_do_write_oob(chip,
> +					ofs + page_offset * mtd->writesize,
> +					&ops);
> +
>  		if (!ret)
>  			ret = res;
>  
> -		i++;
> -		ofs += mtd->writesize;
> -	} while ((chip->options & NAND_BBM_FIRSTPAGE) &&
> -		 (chip->options & NAND_BBM_SECONDPAGE) && i < 2);
> +		page_offset = nand_bbm_get_next_page(chip, page_offset);
> +	}
>  
>  	return ret;
>  }
> diff --git a/drivers/mtd/nand/raw/nand_bbt.c b/drivers/mtd/nand/raw/nand_bbt.c
> index 7463afddc7ac..09603c502931 100644
> --- a/drivers/mtd/nand/raw/nand_bbt.c
> +++ b/drivers/mtd/nand/raw/nand_bbt.c
> @@ -415,11 +415,12 @@ static void read_abs_bbts(struct nand_chip *this, uint8_t *buf,
>  
>  /* Scan a given block partially */
>  static int scan_block_fast(struct nand_chip *this, struct nand_bbt_descr *bd,
> -			   loff_t offs, uint8_t *buf, int numpages)
> +			   loff_t offs, uint8_t *buf)
>  {
>  	struct mtd_info *mtd = nand_to_mtd(this);
> +
>  	struct mtd_oob_ops ops;
> -	int j, ret;
> +	int ret, page_offset;
>  
>  	ops.ooblen = mtd->oobsize;
>  	ops.oobbuf = buf;
> @@ -427,12 +428,15 @@ static int scan_block_fast(struct nand_chip *this, struct nand_bbt_descr *bd,
>  	ops.datbuf = NULL;
>  	ops.mode = MTD_OPS_PLACE_OOB;
>  
> -	for (j = 0; j < numpages; j++) {
> +	page_offset = nand_bbm_get_next_page(this, -1);
> +
> +	while (page_offset != -1) {
>  		/*
>  		 * Read the full oob until read_oob is fixed to handle single
>  		 * byte reads for 16 bit buswidth.
>  		 */
> -		ret = mtd_read_oob(mtd, offs, &ops);
> +		ret = mtd_read_oob(mtd, offs + page_offset * mtd->writesize,

Can you add '(' & ')' please?

> +				   &ops);
>  		/* Ignore ECC errors when checking for BBM */
>  		if (ret && !mtd_is_bitflip_or_eccerr(ret))
>  			return ret;
> @@ -440,8 +444,9 @@ static int scan_block_fast(struct nand_chip *this, struct nand_bbt_descr *bd,
>  		if (check_short_pattern(buf, bd))
>  			return 1;
>  
> -		offs += mtd->writesize;
> +		page_offset = nand_bbm_get_next_page(this, page_offset);
>  	}
> +
>  	return 0;
>  }
>  
> @@ -460,18 +465,11 @@ static int create_bbt(struct nand_chip *this, uint8_t *buf,
>  		      struct nand_bbt_descr *bd, int chip)
>  {
>  	struct mtd_info *mtd = nand_to_mtd(this);
> -	int i, numblocks, numpages;
> -	int startblock;
> +	int i, numblocks, startblock;
>  	loff_t from;
>  
>  	pr_info("Scanning device for bad blocks\n");
>  
> -	if ((this->options & NAND_BBM_FIRSTPAGE) &&
> -	    (this->options & NAND_BBM_SECONDPAGE))
> -		numpages = 2;
> -	else
> -		numpages = 1;
> -
>  	if (chip == -1) {
>  		numblocks = mtd->size >> this->bbt_erase_shift;
>  		startblock = 0;
> @@ -488,15 +486,12 @@ static int create_bbt(struct nand_chip *this, uint8_t *buf,
>  		from = (loff_t)startblock << this->bbt_erase_shift;
>  	}
>  
> -	if (this->options & NAND_BBM_LASTPAGE)
> -		from += mtd->erasesize - (mtd->writesize * numpages);
> -
>  	for (i = startblock; i < numblocks; i++) {
>  		int ret;
>  
>  		BUG_ON(bd->options & NAND_BBT_NO_OOB);
>  
> -		ret = scan_block_fast(this, bd, from, buf, numpages);
> +		ret = scan_block_fast(this, bd, from, buf);
>  		if (ret < 0)
>  			return ret;
>  




Thanks,
Miquèl
