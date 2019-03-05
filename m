Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3D0C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 17:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B813D20643
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 17:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730816AbfCERzZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 12:55:25 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:59811 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbfCERzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 12:55:25 -0500
X-Originating-IP: 77.136.16.149
Received: from xps13 (149.16.136.77.rev.sfr.net [77.136.16.149])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id B82D5240002;
        Tue,  5 Mar 2019 17:55:18 +0000 (UTC)
Date:   Tue, 5 Mar 2019 18:55:00 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v2 02/10] mtd: rawnand: denali: refactor syndrome layout
 handling for raw access
Message-ID: <20190305184929.7f0bc93b@xps13>
In-Reply-To: <CAK7LNASeBDxsUj2fu0bh9G6dXV2jxeHp6iBG+8FytNbHGtVHKQ@mail.gmail.com>
References: <1549955582-30346-1-git-send-email-yamada.masahiro@socionext.com>
        <1549955582-30346-3-git-send-email-yamada.masahiro@socionext.com>
        <20190304100106.72ad49c3@xps13>
        <CAK7LNASeBDxsUj2fu0bh9G6dXV2jxeHp6iBG+8FytNbHGtVHKQ@mail.gmail.com>
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

Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Tue, 5 Mar
2019 18:20:22 +0900:

> Hi Miquel,
> 
> On Mon, Mar 4, 2019 at 6:01 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >
> > Hi Masahiro,
> >
> > Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Tue, 12 Feb
> > 2019 16:12:54 +0900:
> >  
> > > The Denali IP adopts the syndrome page layout (payload and ECC are
> > > interleaved). The *_page_raw() and *_oob() callbacks are complicated
> > > because they must hide the underlying layout used by the hardware,
> > > and always return contiguous in-band and out-of-band data.
> > >
> > > Currently, similar code is duplicated to reorganize the data layout.
> > > For example, denali_read_page_raw() and denali_write_page_raw() look
> > > almost the same.
> > >
> > > The idea for refactoring is to split the code into two parts:
> > >   [1] conversion of page layout
> > >   [2] what to do at every ECC chunk boundary
> > >
> > > For [1], I wrote denali_raw_payload_op() and denali_raw_oob_op().
> > > They manipulate data for the Denali controller's specific page layout
> > > of in-band, out-of-band, respectively.  
> >
> > Could you please comment the purpose of these two functions in the code
> > as well?  
> 
> 
> OK, I will.
> 
> 
> 
> > >
> > > The difference between write and read is just the operation at
> > > ECC chunk boundaries. For example, denali_read_oob() calls
> > > nand_change_read_column_op(), whereas denali_write_oob() calls
> > > nand_change_write_column_op(). So, I implemented [2] as a callback
> > > passed into [1].
> > >
> > > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > ---
> > >
> > > Changes in v2: None
> > >
> > > drivers/mtd/nand/raw/denali.c | 354 +++++++++++++++++++-----------------------
> > > 1 file changed, 163 insertions(+), 191 deletions(-)  
> >
> > Too bad that the size of the driver did not shrink more than that :)  
> 
> Indeed, less than expected.
> 
> But, please do not miss this commit is adding
> error check to every operation.
> 
> Prior to this commit, the code just ignored the return code
> because 97d90da8a886949f simply replaced old hooks
> despite the new ones return the error code.
> 
> 
> Generally, every error check costs two lines
> in the following form:
> 
> 
>   ret = (do something)
>   if (ret)
>            return ret;
> 

Right!

> 
> 
> > > +
> > > +static int denali_memcpy_in(void *buf, unsigned int offset, unsigned int len,
> > > +                         void *priv)
> > > +{
> > > +     memcpy(buf, priv + offset, len);
> > > +     return 0;
> > >  }  
> >
> > Maybe this "callback" and the (_out cousin) could be part of you
> > controller's structure,
> > and you could use a read/write flag instead of
> > passing the functions' pointer?  
> 
> This is what the old code does.
> 
> There are 4 callbacks for the combination
> of raw/oob, and write/read.
> 
> I do not know how your suggestion looks like,
> and whether it will make the code cleaner.
> 

Please give it a try!

Thanks,
Miquèl
