Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CAFC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 15:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37857218B6
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 15:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733105AbfHHPTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 11:19:51 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40242 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfHHPTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 11:19:50 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 5D68828C51F;
        Thu,  8 Aug 2019 16:19:48 +0100 (BST)
Date:   Thu, 8 Aug 2019 17:19:45 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v5 2/3] mtd: spi-nor: Move m25p80 code in spi-nor.c
Message-ID: <20190808171945.21a608cc@collabora.com>
In-Reply-To: <CAP6Zq1g6Z=o7FnX4UpZ-dq_9Ui-yv9E5OEJGirK49RqFUPoP_g@mail.gmail.com>
References: <20190806051041.3636-1-vigneshr@ti.com>
        <20190806051041.3636-3-vigneshr@ti.com>
        <CAP6Zq1h9Xe9ptGxQpjYwoFaS1sTyd-3EsMTAYwp9e70Cm1czLg@mail.gmail.com>
        <20190808160452.1da76beb@collabora.com>
        <CAP6Zq1g6Z=o7FnX4UpZ-dq_9Ui-yv9E5OEJGirK49RqFUPoP_g@mail.gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Aug 2019 17:44:35 +0300
Tomer Maimon <tmaimon77@gmail.com> wrote:

> Hi Boris,
> 
> On Thu, 8 Aug 2019 at 17:04, Boris Brezillon <boris.brezillon@collabora.com>
> wrote:
> 
> > Hi Tomer,
> >
> > On Thu, 8 Aug 2019 13:05:14 +0300
> > Tomer Maimon <tmaimon77@gmail.com> wrote:
> >  
> > > @@ -688,6 +1003,16 @@ static int spi_nor_erase_sector(struct spi_nor  
> > *nor,  
> > > > u32 addr)
> > > >         if (nor->erase)
> > > >                 return nor->erase(nor, addr);
> > > >
> > > > +       if (nor->spimem) {
> > > > +               struct spi_mem_op op =
> > > > +                       SPI_MEM_OP(SPI_MEM_OP_CMD(nor->erase_opcode,  
> > 1),  
> > > > +                                  SPI_MEM_OP_ADDR(nor->addr_width,  
> > addr,  
> > > > 1),
> > > > +                                  SPI_MEM_OP_NO_DUMMY,
> > > > +                                  SPI_MEM_OP_NO_DATA);
> > > > +
> > > > +               return spi_mem_exec_op(nor->spimem, &op);
> > > > +       }
> > > > +
> > > >  
> > >
> > > static int spi_nor_erase_sector(struct spi_nor *nor, u32 addr)
> > > {
> > >
> > >       int i;
> > >
> > >       if (nor->flags & SNOR_F_S3AN_ADDR_DEFAULT)
> > >               addr = spi_nor_s3an_addr_convert(nor, addr);
> > >
> > >       if (nor->erase)
> > >               return nor->erase(nor, addr);
> > >
> > >       /*
> > >        * Default implementation, if driver doesn't have a specialized HW
> > >        * control
> > >        */
> > >       for (i = nor->addr_width - 1; i >= 0; i--) {
> > >               nor->bouncebuf[i] = addr & 0xff;
> > >               addr >>= 8;
> > >       }
> > >
> > >       if (nor->spimem) {
> > >               struct spi_mem_op op =
> > >                       SPI_MEM_OP(SPI_MEM_OP_CMD(nor->erase_opcode, 1),
> > >                       SPI_MEM_OP_NO_ADDR,
> > >                       SPI_MEM_OP_NO_DUMMY,
> > >                       SPI_MEM_OP_DATA_OUT(nor->addr_width,  
> > nor->bouncebuf, 1));
> >
> > That's wrong. If you need that, that's probably a spi-mem controller
> > driver issue. Address cycles should be passed through the
> > spi_mem_op->addr field, not packed with the data cycles.
> >  
> 
> Maybe I missing something but this is not the way it
> working in the current spi-nor and m25p80 driver...
> in function  spi_nor_erase_sector it calling
> nor->write_reg(nor, nor->erase_opcode, nor->bouncebuf, nor->addr_width);
> 
> so it will call m25p80_write_reg and in this function the op sets as follow:
> 
>         struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(opcode, 1),
>                                           SPI_MEM_OP_NO_ADDR,
>                                           SPI_MEM_OP_NO_DUMMY,
>                                           SPI_MEM_OP_DATA_OUT(len, NULL, 1));
> 
> Do we like to modify it?

Yes. The spi-mem core is taking care of this conversion [1].

[1]https://elixir.bootlin.com/linux/v5.3-rc3/source/drivers/spi/spi-mem.c#L329
