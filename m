Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD628C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 07:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 957142133F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 07:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfJGHwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 03:52:40 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54666 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbfJGHwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 03:52:40 -0400
Received: from dhcp-172-31-174-146.wireless.concordia.ca (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 568E228E657;
        Mon,  7 Oct 2019 08:52:38 +0100 (BST)
Date:   Mon, 7 Oct 2019 09:52:34 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Richard Weinberger <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        liaoweixiong <liaoweixiong@allwinnertech.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Jeff Kletsky <git-commits@allycomm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [EXT] Re: [PATCH 4/8] mtd: spinand: enabled parameter page
 support
Message-ID: <20191007095234.55fcb050@dhcp-172-31-174-146.wireless.concordia.ca>
In-Reply-To: <20190819112118.56b2f9ea@xps13>
References: <20190722055621.23526-1-sshivamurthy@micron.com>
        <20190722055621.23526-5-sshivamurthy@micron.com>
        <20190807114855.35f26229@xps13>
        <MN2PR08MB59511E352AE382D103DA56CBB8A80@MN2PR08MB5951.namprd08.prod.outlook.com>
        <20190819112118.56b2f9ea@xps13>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Aug 2019 11:21:18 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Hi Boris,
> 
> Another question for you :)
> 
> "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com> wrote on
> Mon, 19 Aug 2019 08:51:52 +0000:
> 
> > Hi Miquel,
> >   
> > > 
> > > Hi Shiva,
> > > 
> > > shiva.linuxworks@gmail.com wrote on Mon, 22 Jul 2019 07:56:17 +0200:
> > > 
> > > "mtd: spinand: enable parameter page support"
> > >     
> > > > From: Shivamurthy Shastri <sshivamurthy@micron.com>
> > > >
> > > > Some of the SPI NAND devices has parameter page, which is similar to    
> > >                  -             have a    
> > > > ONFI table.    
> > >   regular raw NAND ONFI tables.
> > >     
> > > >
> > > > But, it may not be self sufficient to propagate all the required    
> > >   As it may not be    
> > > > parameters. Fixup function has been added in struct manufacturer to    
> > >             , a fixup        is being added in the manufacturer structure    
> > > > accommodate this.    
> > > 
> > > The fixup function sentence should be dropped from the commit message,
> > > see below.    
> > 
> > Okay, I will create separate patch for fixup function.
> >   
> > >     
> > > >
> > > > Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
> > > > ---
> > > >  drivers/mtd/nand/spi/core.c | 134    
> > > ++++++++++++++++++++++++++++++++++++    
> > > >  include/linux/mtd/spinand.h |   3 +
> > > >  2 files changed, 137 insertions(+)
> > > >
> > > > diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> > > > index 89f6beefb01c..7ae76dab9141 100644
> > > > --- a/drivers/mtd/nand/spi/core.c
> > > > +++ b/drivers/mtd/nand/spi/core.c
> > > > @@ -400,6 +400,131 @@ static int spinand_lock_block(struct    
> > > spinand_device *spinand, u8 lock)    
> > > >  	return spinand_write_reg_op(spinand, REG_BLOCK_LOCK, lock);
> > > >  }
> > > >
> > > > +/**
> > > > + * spinand_read_param_page_op - Read parameter page operation    
> > > 
> > > Again, the name in the doc does not fit the function you describe
> > >     
> > > > + * @spinand: the spinand    
> > >                     SPI-NAND chip
> > > 
> > > Shiva, there are way too much typos and shortcuts in your series.
> > > Please be more careful otherwise we can't focus on the technical
> > > aspects. I am not a native English speaker at all but please, plain
> > > English is not C code. We talk SPI-NAND and not spinand, we say
> > > structure and not struct, acronyms are uppercase, etc.
> > >     
> > 
> > Sorry for the inconvenience caused, I will take care from next time.
> >   
> > > > + * @page: page number where parameter page tables can be found    
> > >                               ^ the    
> > > > + * @buf: buffer used to store the parameter page
> > > > + * @len: length of the buffer
> > > > + *
> > > > + * Read parameter page    
> > >           the    
> > > > + *
> > > > + * Returns 0 on success, a negative error code otherwise.
> > > > + */
> > > > +static int spinand_parameter_page_read(struct spinand_device *spinand,
> > > > +				       u8 page, void *buf, unsigned int len)
> > > > +{
> > > > +	struct spi_mem_op pread_op = SPINAND_PAGE_READ_OP(page);
> > > > +	struct spi_mem_op pread_cache_op =
> > > > +    
> > > 	SPINAND_PAGE_READ_FROM_CACHE_OP(false,    
> > > > +								0,
> > > > +								1,
> > > > +								buf,
> > > > +								len);    
> > > 
> > > That's ok if you cross the 80 characters boundary here. You may put "0,
> > > 1," on the first line and "buf, len);" on the second.
> > >     
> > > > +	u8 feature;
> > > > +	u8 status;
> > > > +	int ret;
> > > > +
> > > > +	if (len && !buf)
> > > > +		return -EINVAL;
> > > > +
> > > > +	ret = spinand_read_reg_op(spinand, REG_CFG,
> > > > +				  &feature);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	/* CFG_OTP_ENABLE is used to enable parameter page access */
> > > > +	feature |= CFG_OTP_ENABLE;
> > > > +
> > > > +	spinand_write_reg_op(spinand, REG_CFG, feature);
> > > > +
> > > > +	ret = spi_mem_exec_op(spinand->spimem, &pread_op);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	ret = spinand_wait(spinand, &status);
> > > > +	if (ret < 0)
> > > > +		return ret;
> > > > +
> > > > +	ret = spi_mem_exec_op(spinand->spimem, &pread_cache_op);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	ret = spinand_read_reg_op(spinand, REG_CFG,
> > > > +				  &feature);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	feature &= ~CFG_OTP_ENABLE;
> > > > +
> > > > +	spinand_write_reg_op(spinand, REG_CFG, feature);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +    
> > > Add the kernel doc please
> > > 
> > > Change the below function so that it returns 1 if the page was
> > > detected, 0 if it did not, an negative error code otherwise.
> > >     
> > > > +static int spinand_param_page_detect(struct spinand_device *spinand)
> > > > +{
> > > > +	struct mtd_info *mtd = spinand_to_mtd(spinand);
> > > > +	struct nand_memory_organization *memorg;
> > > > +	struct nand_onfi_params *p;
> > > > +	struct nand_device *base = spinand_to_nand(spinand);
> > > > +	int i, ret;
> > > > +
> > > > +	memorg = nanddev_get_memorg(base);
> > > > +
> > > > +	/* Allocate buffer to hold parameter page */
> > > > +	p = kzalloc((sizeof(*p) * 3), GFP_KERNEL);
> > > > +	if (!p)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	ret = spinand_parameter_page_read(spinand, 0x01, p, sizeof(*p) *    
> > > 3);    
> > > > +	if (ret) {
> > > > +		ret = 0;    
> > > 
> > > No, you should return the error in case of error. You will later handle
> > > the fact that there is no parameter page.    
> > 
> > okay.
> >   
> > >     
> > > > +		goto free_param_page;
> > > > +	}
> > > > +
> > > > +	for (i = 0; i < 3; i++) {
> > > > +		if (onfi_crc16(ONFI_CRC_BASE, (u8 *)&p[i], 254) ==    
> > >                                                            ^
> > > If you force the parameter page to be 254 bytes long it means you limit
> > > yourself to ONFI standard. That's not a problem, but then you should
> > > mention it in the function name.    
> > 
> > okay, I will mention in kernel doc.
> >   
> > >     
> > > > +				le16_to_cpu(p->crc)) {
> > > > +			if (i)
> > > > +				memcpy(p, &p[i], sizeof(*p));
> > > > +			break;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	if (i == 3) {
> > > > +		const void *srcbufs[3] = {p, p + 1, p + 2};
> > > > +
> > > > +		pr_warn("Could not find a valid ONFI parameter page, trying    
> > > bit-wise majority to recover it\n");    
> > > > +		nand_bit_wise_majority(srcbufs, ARRAY_SIZE(srcbufs), p,
> > > > +				       sizeof(*p));
> > > > +
> > > > +		if (onfi_crc16(ONFI_CRC_BASE, (u8 *)p, 254) !=
> > > > +				le16_to_cpu(p->crc)) {
> > > > +			pr_err("ONFI parameter recovery failed,    
> > > aborting\n");    
> > > > +			goto free_param_page;
> > > > +		}
> > > > +	}    
> > > 
> > > The whole for-loop and the if (i==3) condition is exactly the same as
> > > for raw NANDs and must be extracted in a generic function:
> > > 1/ extract the function from nand/raw/nand_onfi.c and put it in
> > > nand/onfi.c.
> > > 2/ then use it in this patch.

Sounds like a good idea indeed.
  
> > 
> > I have done this intentionally, because in raw NAND case there is function
> > "nand_read_data_op" called inside for-loop. I don't think just for if (i == 3) 
> > it is necessary to create new function.

Well, reading more than just a single param page in a single step
shouldn't hurt. You can let the caller choose the number of page it
wants to read (can be more than 3) and pass this information to the
helper function. You should probably call nand_bit_wise_majority() from
this helper too.

> > 
> > Let me know if you have different opinion.  
> 
> I don't have a strong opinion on that. Boris what do you think? Shall
> we duplicate the code? It's not just about the if condition, it's the
> whole for loop which is very similar.

I think Miquel is right, we shouldn't duplicate this logic.
