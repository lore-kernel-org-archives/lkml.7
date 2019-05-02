Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F4FC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 11:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A45208C4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 11:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfEBL7w convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 07:59:52 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:34237 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEBL7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 07:59:49 -0400
X-Originating-IP: 90.88.149.145
Received: from xps13 (aaubervilliers-681-1-29-145.w90-88.abo.wanadoo.fr [90.88.149.145])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id AA0E860003;
        Thu,  2 May 2019 11:59:46 +0000 (UTC)
Date:   Thu, 2 May 2019 13:59:45 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Frieder Schrempf <frieder.schrempf@exceet.de>
Subject: Re: [EXT] Re: [PATCH 3/4] mtd: spinand: Enabled support to detect
 parameter page
Message-ID: <20190502135945.61bd6ceb@xps13>
In-Reply-To: <MN2PR08MB5951A622B36705BC26CE36E2B8340@MN2PR08MB5951.namprd08.prod.outlook.com>
References: <MN2PR08MB5951E8D99AA1FBD972131388B85F0@MN2PR08MB5951.namprd08.prod.outlook.com>
        <20190430095508.706fa125@xps13>
        <MN2PR08MB5951A622B36705BC26CE36E2B8340@MN2PR08MB5951.namprd08.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shiva,

"Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com> wrote on
Thu, 2 May 2019 11:37:10 +0000:

> Hi Miquel,
> 
> > 
> > Hi Shivamurthy,
> > 
> > "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com> wrote
> > on
> > Tue, 26 Mar 2019 10:52:00 +0000:
> >   
> > > Some of the SPI NAND devices has parameter page which is similar to ONFI
> > > table.
> > >
> > > But, it may not be self sufficient to propagate all the required
> > > parameters. Fixup function has been added in struct manufacturer to
> > > accommodate this.
> > >
> > > Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
> > > ---
> > >  drivers/mtd/nand/spi/core.c | 113  
> > +++++++++++++++++++++++++++++++++++-  
> > >  include/linux/mtd/spinand.h |   5 ++
> > >  2 files changed, 117 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> > > index 985ad52cdaa7..40882a1d2bc1 100644
> > > --- a/drivers/mtd/nand/spi/core.c
> > > +++ b/drivers/mtd/nand/spi/core.c
> > > @@ -574,6 +574,108 @@ static int spinand_lock_block(struct  
> > spinand_device *spinand, u8 lock)  
> > >  	return spinand_write_reg_op(spinand, REG_BLOCK_LOCK, lock);
> > >  }
> > >
> > > +/**
> > > + * spinand_read_param_page_op - Read parameter page operation
> > > + * @spinand: the spinand device
> > > + * @page: page number where parameter page tables can be found
> > > + * @parameters: buffer used to store the parameter page  
> > 
> > Does not match the prototype  
> 
> I will fix this in next version.
> 
> >   
> > > + * @len: length of the buffer
> > > + *
> > > + * Read parameter page
> > > + *
> > > + * Returns 0 on success, a negative error code otherwise.
> > > + */
> > > +static int spinand_parameter_page_read(struct nand_device *base,  
> > 
> > Please use a spinand structure as parameter, you don't need a
> > nand_device here (same for other spinand functions).  
> 
> This function is helper function for generic ONFI layer.
> From generic ONFI layer, I can get only nand_device.

How do you handle if the SPI NAND core is not compiled-in?


Thanks,
Miquèl
