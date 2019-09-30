Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A479C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 16:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 676CE2075D
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 16:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732294AbfI3QZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 12:25:06 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57376 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727767AbfI3QZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 12:25:06 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: bbrezillon)
        with ESMTPSA id E4C0128DF82
Date:   Mon, 30 Sep 2019 18:24:58 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mtd: rawnand: use bounce buffer when vmalloced data
 buf detected
Message-ID: <20190930182458.761e8077@collabora.com>
In-Reply-To: <CAC=U0a1qvKO+t_62df_JcQBETAuNq0pwRkAb-Ofi3ski2rfdEQ@mail.gmail.com>
References: <20190906194719.15761-1-kdasu.kdev@gmail.com>
        <20190906194719.15761-2-kdasu.kdev@gmail.com>
        <CAC=U0a1qvKO+t_62df_JcQBETAuNq0pwRkAb-Ofi3ski2rfdEQ@mail.gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Sep 2019 12:01:28 -0400
Kamal Dasu <kdasu.kdev@gmail.com> wrote:

> Does anyone have any comments on this patch ?.
> 
> Kamal
> 
> On Fri, Sep 6, 2019 at 3:49 PM Kamal Dasu <kdasu.kdev@gmail.com> wrote:
> >
> > For controller drivers that use DMA and set NAND_USE_BOUNCE_BUFFER
> > option use data buffers that are not vmalloced, aligned and have
> > valid virtual address to be able to do DMA transfers. This change
> > adds additional check and makes use of data buffer allocated
> > in nand_base driver when it is passed a vmalloced data buffer for
> > DMA transfers.
> >
> > Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> > ---
> >  drivers/mtd/nand/raw/nand_base.c | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> > index 91f046d4d452..46f6965a896a 100644
> > --- a/drivers/mtd/nand/raw/nand_base.c
> > +++ b/drivers/mtd/nand/raw/nand_base.c
> > @@ -45,6 +45,12 @@
> >
> >  #include "internals.h"
> >
> > +static int nand_need_bounce_buf(const void *buf, struct nand_chip *chip)
> > +{
> > +       return !virt_addr_valid(buf) || is_vmalloc_addr(buf) ||

I thought virt_addr_valid() was implying !is_vmalloc_addr(), are you
sure you need that test, and can you tell me on which arch(es) this is
needed.

> > +               !IS_ALIGNED((unsigned long)buf, chip->buf_align);
> > +}
> > +
> >  /* Define default oob placement schemes for large and small page devices */
> >  static int nand_ooblayout_ecc_sp(struct mtd_info *mtd, int section,
> >                                  struct mtd_oob_region *oobregion)
> > @@ -3183,9 +3189,7 @@ static int nand_do_read_ops(struct nand_chip *chip, loff_t from,
> >                 if (!aligned)
> >                         use_bufpoi = 1;
> >                 else if (chip->options & NAND_USE_BOUNCE_BUFFER)
> > -                       use_bufpoi = !virt_addr_valid(buf) ||
> > -                                    !IS_ALIGNED((unsigned long)buf,
> > -                                                chip->buf_align);
> > +                       use_bufpoi = nand_need_bounce_buf(buf, chip);
> >                 else
> >                         use_bufpoi = 0;
> >
> > @@ -4009,9 +4013,7 @@ static int nand_do_write_ops(struct nand_chip *chip, loff_t to,
> >                 if (part_pagewr)
> >                         use_bufpoi = 1;
> >                 else if (chip->options & NAND_USE_BOUNCE_BUFFER)
> > -                       use_bufpoi = !virt_addr_valid(buf) ||
> > -                                    !IS_ALIGNED((unsigned long)buf,
> > -                                                chip->buf_align);
> > +                       use_bufpoi = nand_need_bounce_buf(buf, chip);
> >                 else
> >                         use_bufpoi = 0;
> >
> > --
> > 2.17.1
> >  

