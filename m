Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E3DC10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 10:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E02320835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 10:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731678AbfDQKEq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 06:04:46 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:35487 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfDQKEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 06:04:45 -0400
X-Originating-IP: 90.88.160.238
Received: from xps13 (aaubervilliers-681-1-42-238.w90-88.abo.wanadoo.fr [90.88.160.238])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 1B4504000F;
        Wed, 17 Apr 2019 10:04:41 +0000 (UTC)
Date:   Wed, 17 Apr 2019 12:04:41 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "richard@nod.at" <richard@nod.at>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        "Marek Vasut" <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/7] mtd: onenand: Store bad block marker position in
 chip struct
Message-ID: <20190417120441.119ae33e@xps13>
In-Reply-To: <71f425a5-4028-1a8a-26db-b4b0860326dc@kontron.de>
References: <20190218104122.18788-1-frieder.schrempf@kontron.de>
        <20190218104122.18788-3-frieder.schrempf@kontron.de>
        <20190304115853.35216632@xps13>
        <71f425a5-4028-1a8a-26db-b4b0860326dc@kontron.de>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frieder,

Schrempf Frieder <frieder.schrempf@kontron.de> wrote on Thu, 21 Mar
2019 08:47:52 +0000:

> On 04.03.19 11:58, Miquel Raynal wrote:
> > Hi Frieder,
> > 
> > Schrempf Frieder <frieder.schrempf@kontron.de> wrote on Mon, 18 Feb
> > 2019 10:42:41 +0000:
> >   
> >> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> >>
> >> The information about where the manufacturer puts the bad block
> >> markers inside the bad block and in the OOB data is stored in
> >> different places. Let's move this information to the chip struct,
> >> as we did it for rawnand.
> >>
> >> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> >> ---
> >>   drivers/mtd/nand/onenand/onenand_base.c | 5 ++++-
> >>   drivers/mtd/nand/onenand/onenand_bbt.c  | 3 ---
> >>   include/linux/mtd/onenand.h             | 3 +++
> >>   3 files changed, 7 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/mtd/nand/onenand/onenand_base.c b/drivers/mtd/nand/onenand/onenand_base.c
> >> index 4ca4b194e7d7..f41d76248550 100644
> >> --- a/drivers/mtd/nand/onenand/onenand_base.c
> >> +++ b/drivers/mtd/nand/onenand/onenand_base.c
> >> @@ -2458,7 +2458,7 @@ static int onenand_default_block_markbad(struct mtd_info *mtd, loff_t ofs)
> >>                   bbm->bbt[block >> 2] |= 0x01 << ((block & 0x03) << 1);
> >>   
> >>           /* We write two bytes, so we don't have to mess with 16-bit access */
> >> -        ofs += mtd->oobsize + (bbm->badblockpos & ~0x01);
> >> +        ofs += mtd->oobsize + (this->badblockpos & ~0x01);
> >>   	/* FIXME : What to do when marking SLC block in partition
> >>   	 * 	   with MLC erasesize? For now, it is not advisable to
> >>   	 *	   create partitions containing both SLC and MLC regions.
> >> @@ -3967,6 +3967,9 @@ int onenand_scan(struct mtd_info *mtd, int maxchips)
> >>   	if (!(this->options & ONENAND_SKIP_INITIAL_UNLOCKING))
> >>   		this->unlock_all(mtd);
> >>   
> >> +	/* Set the bad block marker position */
> >> +	this->badblockpos = ONENAND_BADBLOCK_POS;
> >> +
> >>   	ret = this->scan_bbt(mtd);
> >>   	if ((!FLEXONENAND(this)) || ret)
> >>   		return ret;
> >> diff --git a/drivers/mtd/nand/onenand/onenand_bbt.c b/drivers/mtd/nand/onenand/onenand_bbt.c
> >> index dde20487937d..57c31c81be18 100644
> >> --- a/drivers/mtd/nand/onenand/onenand_bbt.c
> >> +++ b/drivers/mtd/nand/onenand/onenand_bbt.c
> >> @@ -190,9 +190,6 @@ static int onenand_scan_bbt(struct mtd_info *mtd, struct nand_bbt_descr *bd)
> >>   	if (!bbm->bbt)
> >>   		return -ENOMEM;
> >>   
> >> -	/* Set the bad block position */
> >> -	bbm->badblockpos = ONENAND_BADBLOCK_POS;
> >> -
> >>   	/* Set erase shift */
> >>   	bbm->bbt_erase_shift = this->erase_shift;
> >>   
> >> diff --git a/include/linux/mtd/onenand.h b/include/linux/mtd/onenand.h
> >> index 0aaa98b219a4..e03aea7f7e61 100644
> >> --- a/include/linux/mtd/onenand.h
> >> +++ b/include/linux/mtd/onenand.h
> >> @@ -94,6 +94,7 @@ struct onenand_chip {
> >>   	unsigned int		technology;
> >>   	unsigned int		density_mask;
> >>   	unsigned int		options;
> >> +	int			badblockpos;  
> > 
> > Any reason not to unsign this field?  
> 
> It was signed so far, but you're right that it makes more sense to 
> unsign it.

With this addressed please add my:

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miquèl
