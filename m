Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AF5C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 09:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E493F2184D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 09:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfHSJTY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 05:19:24 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:44895 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbfHSJTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 05:19:24 -0400
Received: from xps13 (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 5038F20000C;
        Mon, 19 Aug 2019 09:19:19 +0000 (UTC)
Date:   Mon, 19 Aug 2019 11:19:18 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
Cc:     Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jeff Kletsky <git-commits@allycomm.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        liaoweixiong <liaoweixiong@allwinnertech.com>
Subject: Re: [EXT] Re: [PATCH 6/8] mtd: spinand: micron: Turn driver
 implementation generic
Message-ID: <20190819111918.6be79570@xps13>
In-Reply-To: <MN2PR08MB5951F13BC1D1D111681CCB4BB8A80@MN2PR08MB5951.namprd08.prod.outlook.com>
References: <20190722055621.23526-1-sshivamurthy@micron.com>
        <20190722055621.23526-7-sshivamurthy@micron.com>
        <20190807120408.031b8d1b@xps13>
        <MN2PR08MB5951F13BC1D1D111681CCB4BB8A80@MN2PR08MB5951.namprd08.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

I need your opinion on the question below.

"Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com> wrote on
Mon, 19 Aug 2019 09:03:38 +0000:

> Hi Miquel,
> 
> > 
> > Hi Shiva,
> > 
> > shiva.linuxworks@gmail.com wrote on Mon, 22 Jul 2019 07:56:19 +0200:
> >   
> > > From: Shivamurthy Shastri <sshivamurthy@micron.com>
> > >  
> > 
> > I am not sure the "turn implemenatation generic" title describes what
> > you do.
> >   
> > > Driver is redesigned using parameter page to support Micron SPI NAND
> > > flashes.  
> > 
> > Redesigned is perhaps a bit too much.
> > 
> > "  
> > > The reason why spinand_select_op_variant globalized is that the Micron
> > > driver no longer calling spinand_match_and_init.
> > >
> > > Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
> > > ---
> > >  drivers/mtd/nand/spi/core.c   |  2 +-
> > >  drivers/mtd/nand/spi/micron.c | 61 +++++++++++++++++++++++++-------  
> > ---  
> > >  include/linux/mtd/spinand.h   |  4 +++
> > >  3 files changed, 49 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> > > index 7ae76dab9141..aae715d388b7 100644
> > > --- a/drivers/mtd/nand/spi/core.c
> > > +++ b/drivers/mtd/nand/spi/core.c
> > > @@ -920,7 +920,7 @@ static void spinand_manufacturer_cleanup(struct  
> > spinand_device *spinand)  
> > >  		return spinand->manufacturer->ops->cleanup(spinand);
> > >  }
> > >
> > > -static const struct spi_mem_op *
> > > +const struct spi_mem_op *
> > >  spinand_select_op_variant(struct spinand_device *spinand,
> > >  			  const struct spinand_op_variants *variants)
> > >  {
> > > diff --git a/drivers/mtd/nand/spi/micron.c  
> > b/drivers/mtd/nand/spi/micron.c  
> > > index 95bc5264ebc1..6fde93ec23a1 100644
> > > --- a/drivers/mtd/nand/spi/micron.c
> > > +++ b/drivers/mtd/nand/spi/micron.c
> > > @@ -90,22 +90,10 @@ static int micron_ecc_get_status(struct  
> > spinand_device *spinand,  
> > >  	return -EINVAL;
> > >  }
> > >
> > > -static const struct spinand_info micron_spinand_table[] = {
> > > -	SPINAND_INFO("MT29F2G01ABAGD", 0x24,
> > > -		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 2, 1, 1),
> > > -		     NAND_ECCREQ(8, 512),
> > > -		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> > > -					      &write_cache_variants,
> > > -					      &update_cache_variants),
> > > -		     0,
> > > -		     SPINAND_ECCINFO(&micron_ooblayout_ops,
> > > -				     micron_ecc_get_status)),
> > > -};
> > > -  
> > 
> > I don't know if it is wise to drop this structure.
> >   
> > >  static int micron_spinand_detect(struct spinand_device *spinand)
> > >  {
> > > +	const struct spi_mem_op *op;
> > >  	u8 *id = spinand->id.data;
> > > -	int ret;
> > >
> > >  	/*
> > >  	 * Micron SPI NAND read ID need a dummy byte,
> > > @@ -114,16 +102,55 @@ static int micron_spinand_detect(struct  
> > spinand_device *spinand)  
> > >  	if (id[1] != SPINAND_MFR_MICRON)
> > >  		return 0;
> > >
> > > -	ret = spinand_match_and_init(spinand, micron_spinand_table,
> > > -				     ARRAY_SIZE(micron_spinand_table),  
> > id[2]);
> > 
> > I am not sure this is the right solution. I would keep this call and
> > overwrite what you need to overwrite with the fixup hook.
> >   
> 
> Then, I will have dummy structure like below.
> 
> static const struct spinand_info micron_spinand_table[] = {                      
>         SPINAND_INFO(NULL, 0,                                                                    
>                      NAND_MEMORG(0, 0, 0, 0, 0, 0, 0, 0, 0),           
>                      NAND_ECCREQ(0, 0),                                                                       
>                      SPINAND_INFO_OP_VARIANTS(&read_cache_variants,              
>                                               &write_cache_variants,             
>                                               &update_cache_variants),           
>                      0,                                                                                         
>                      SPINAND_ECCINFO(&micron_ooblayout_ops,                      
>                                      micron_ecc_get_status)),                    
> };                                    
> 
> Let me know if you are thinking for different approach.
> 

Thanks,
Miquèl
