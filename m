Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D1DC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE74E2084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731000AbfDASCx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:02:53 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:50505 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730106AbfDARO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:14:26 -0400
Received: from xps13 (178.163.185.81.rev.sfr.net [81.185.163.178])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id E9D4B240002;
        Mon,  1 Apr 2019 17:14:20 +0000 (UTC)
Date:   Mon, 1 Apr 2019 19:14:19 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-mtd@lists.infradead.org,
        Brian Norris <computersforpeace@gmail.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [PATCH v4 1/9] mtd: rawnand: denali: use nand_chip pointer more
 for internal functions
Message-ID: <20190401191419.0431882e@xps13>
In-Reply-To: <20190330152323.71734cb8@collabora.com>
References: <1553844501-7119-1-git-send-email-yamada.masahiro@socionext.com>
        <1553844501-7119-2-git-send-email-yamada.masahiro@socionext.com>
        <20190330152323.71734cb8@collabora.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

Boris Brezillon <boris.brezillon@collabora.com> wrote on Sat, 30 Mar
2019 15:23:23 +0100:

> On Fri, 29 Mar 2019 16:28:13 +0900
> Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> 
> > With the recent refactoring, the NAND driver hooks now take a pointer
> > to nand_chip. Add to_denali() in order to convert (struct nand_chip *)
> > to (struct denali_nand_info *) directly. It is more useful than the
> > current mtd_to_denali().
> > 
> > I changed some helper functions to take (struct nand_chip *). This will
> > avoid pointer conversion back and forth, and ease further development.
> > 
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> > 
> > Changes in v4: None
> > Changes in v3: None
> > Changes in v2: None
> > 
> >  drivers/mtd/nand/raw/denali.c | 57 ++++++++++++++++++++++++-------------------
> >  1 file changed, 32 insertions(+), 25 deletions(-)
> > 
> > diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
> > index 24aeafc..4ac1314 100644
> > --- a/drivers/mtd/nand/raw/denali.c
> > +++ b/drivers/mtd/nand/raw/denali.c
> > @@ -47,6 +47,11 @@ static inline struct denali_nand_info *mtd_to_denali(struct mtd_info *mtd)
> >  	return container_of(mtd_to_nand(mtd), struct denali_nand_info, nand);
> >  }
> >  
> > +static struct denali_nand_info *to_denali(struct nand_chip *chip)
> > +{
> > +	return container_of(chip, struct denali_nand_info, nand);
> > +}
> > +
> >  /*
> >   * Direct Addressing - the slave address forms the control information (command
> >   * type, bank, block, and page address).  The slave data is the actual data to
> > @@ -282,12 +287,12 @@ static void denali_cmd_ctrl(struct nand_chip *chip, int dat, unsigned int ctrl)
> >  	denali->host_write(denali, DENALI_BANK(denali) | type, dat);
> >  }
> >  
> > -static int denali_check_erased_page(struct mtd_info *mtd,
> > -				    struct nand_chip *chip, uint8_t *buf,
> > +static int denali_check_erased_page(struct nand_chip *chip,
> > +				    struct denali_nand_info *denali, u8 *buf,  
> 
> You don't need to pass both chip and denali, as one can be extracted
> from the other.
> 
> >  				    unsigned long uncor_ecc_flags,
> >  				    unsigned int max_bitflips)
> >  {
> > -	struct denali_nand_info *denali = mtd_to_denali(mtd);
> > +	struct mtd_ecc_stats *ecc_stats = &nand_to_mtd(chip)->ecc_stats;
> >  	uint8_t *ecc_code = chip->oob_poi + denali->oob_skip_bytes;
> >  	int ecc_steps = chip->ecc.steps;
> >  	int ecc_size = chip->ecc.size;
> > @@ -303,9 +308,9 @@ static int denali_check_erased_page(struct mtd_info *mtd,
> >  						  NULL, 0,
> >  						  chip->ecc.strength);
> >  		if (stat < 0) {
> > -			mtd->ecc_stats.failed++;
> > +			ecc_stats->failed++;
> >  		} else {
> > -			mtd->ecc_stats.corrected += stat;
> > +			ecc_stats->corrected += stat;
> >  			max_bitflips = max_t(unsigned int, max_bitflips, stat);
> >  		}
> >  
> > @@ -316,11 +321,11 @@ static int denali_check_erased_page(struct mtd_info *mtd,
> >  	return max_bitflips;
> >  }
> >  
> > -static int denali_hw_ecc_fixup(struct mtd_info *mtd,
> > +static int denali_hw_ecc_fixup(struct nand_chip *chip,
> >  			       struct denali_nand_info *denali,  
> 
> Ditto.
> 

I am fine with the series in its current state, please submit a v5
with Boris comment's addressed and I'll queue it right away to next.

Thanks,
Miquèl
