Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B53BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3291C214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfCLNNd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 09:13:33 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:43343 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfCLNNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 09:13:32 -0400
X-Originating-IP: 90.88.22.102
Received: from xps13 (aaubervilliers-681-1-80-102.w90-88.abo.wanadoo.fr [90.88.22.102])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id A803160014;
        Tue, 12 Mar 2019 13:13:28 +0000 (UTC)
Date:   Tue, 12 Mar 2019 14:13:27 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v3 2/9] mtd: rawnand: denali: refactor syndrome layout
 handling for raw access
Message-ID: <20190312141327.31c6af3f@xps13>
In-Reply-To: <CAK7LNAT_h7o4Rbzsgmd8Z6G3Pq3Uhvdqyhp2-ArCb8hfnreEpA@mail.gmail.com>
References: <1552380290-19951-1-git-send-email-yamada.masahiro@socionext.com>
        <1552380290-19951-3-git-send-email-yamada.masahiro@socionext.com>
        <20190312112811.1af0bb00@xps13>
        <CAK7LNATud=QTQ4FGxt1FtSZ06-Boa-jiROp7-wOj192FgXTNLw@mail.gmail.com>
        <20190312115425.612bcdf2@xps13>
        <CAK7LNAT_h7o4Rbzsgmd8Z6G3Pq3Uhvdqyhp2-ArCb8hfnreEpA@mail.gmail.com>
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

Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Tue, 12 Mar
2019 20:07:27 +0900:

> Hi Miquel,
> 
> 
> On Tue, Mar 12, 2019 at 7:54 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >
> > Hi Masahiro,
> >
> > Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Tue, 12 Mar
> > 2019 19:51:21 +0900:
> >  
> > > On Tue, Mar 12, 2019 at 7:28 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:  
> > > >
> > > > Hi Masahiro,
> > > >
> > > > Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Tue, 12 Mar
> > > > 2019 17:44:43 +0900:
> > > >  
> > > > > The Denali IP adopts the syndrome page layout (payload and ECC are
> > > > > interleaved). The *_page_raw() and *_oob() callbacks are complicated
> > > > > because they must hide the underlying layout used by the hardware,
> > > > > and always return contiguous in-band and out-of-band data.
> > > > >
> > > > > Currently, similar code is duplicated to reorganize the data layout.
> > > > > For example, denali_read_page_raw() and denali_write_page_raw() look
> > > > > almost the same.
> > > > >
> > > > > The idea for refactoring is to split the code into two parts:
> > > > >   [1] conversion of page layout
> > > > >   [2] what to do at every ECC chunk boundary
> > > > >
> > > > > For [1], I wrote denali_raw_payload_op() and denali_raw_oob_op().
> > > > > They manipulate data for the Denali controller's specific page layout
> > > > > of in-band, out-of-band, respectively.
> > > > >
> > > > > The difference between write and read is just the operation at
> > > > > ECC chunk boundaries. For example, denali_read_oob() calls
> > > > > nand_change_read_column_op(), whereas denali_write_oob() calls
> > > > > nand_change_write_column_op(). So, I implemented [2] as a callback
> > > > > passed into [1].
> > > > >
> > > > > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > > > ---
> > > > >  
> > > >
> > > > [...]
> > > >  
> > > > >  static int denali_read_page_raw(struct nand_chip *chip, uint8_t *buf,
> > > > >                               int oob_required, int page)
> > > > >  {
> > > > > +     struct denali_nand_info *denali = to_denali(chip);
> > > > >       struct mtd_info *mtd = nand_to_mtd(chip);
> > > > > -     struct denali_nand_info *denali = mtd_to_denali(mtd);
> > > > > -     int writesize = mtd->writesize;
> > > > > -     int oobsize = mtd->oobsize;
> > > > > -     int ecc_steps = chip->ecc.steps;
> > > > > -     int ecc_size = chip->ecc.size;
> > > > > -     int ecc_bytes = chip->ecc.bytes;
> > > > >       void *tmp_buf = denali->buf;
> > > > > -     int oob_skip = denali->oob_skip_bytes;
> > > > > -     size_t size = writesize + oobsize;
> > > > > -     int ret, i, pos, len;
> > > > > +     size_t size = mtd->writesize + mtd->oobsize;
> > > > > +     int ret;
> > > > > +
> > > > > +     if (!buf)
> > > > > +             return -EINVAL;
> > > > >
> > > > >       ret = denali_data_xfer(chip, tmp_buf, size, page, 1, 0);
> > > > >       if (ret)
> > > > >               return ret;
> > > > >
> > > > > -     /* Arrange the buffer for syndrome payload/ecc layout */
> > > > > -     if (buf) {
> > > > > -             for (i = 0; i < ecc_steps; i++) {
> > > > > -                     pos = i * (ecc_size + ecc_bytes);
> > > > > -                     len = ecc_size;
> > > > > -
> > > > > -                     if (pos >= writesize)
> > > > > -                             pos += oob_skip;
> > > > > -                     else if (pos + len > writesize)
> > > > > -                             len = writesize - pos;
> > > > > -
> > > > > -                     memcpy(buf, tmp_buf + pos, len);
> > > > > -                     buf += len;
> > > > > -                     if (len < ecc_size) {
> > > > > -                             len = ecc_size - len;
> > > > > -                             memcpy(buf, tmp_buf + writesize + oob_skip,
> > > > > -                                    len);
> > > > > -                             buf += len;
> > > > > -                     }
> > > > > -             }
> > > > > -     }
> > > > > +     ret = denali_raw_payload_op(chip, buf, denali_memcpy_in, tmp_buf);  
> > > >
> > > > Honestly, I still don't like passing denali_memcpy_in/out as parameter.
> > > >
> > > > Besides that, once you'll have added helpers to avoid abusing the
> > > > ternary operator in 4/9, the rest looks fine by me.
> > > >  
> > >
> > >
> > > Do you have any suggestion?  
> >
> > Maybe register these two helpers at probe as controller specific hooks,
> > then just pass an in/out boolean to the function?
> >  
> 
> Sorry, I do not understand.
> 
> Are you suggesting to do like follows in probe ?
> 
> denali->change_column_read_raw = denali_memcpy_in;
> denali->change_column_write_raw = denali_memcpy_out;
> denali->change_column_read_oob = denali_change_read_column_op;
> denali->change_column_write_oob = denali_change_write_column_op;
> 
> 
> All the 4 hooks are always needed
> regardless of any probed features.
> 
> 
> The result is just textual replacement
> denali_* with denali->*.
> 
> What's the point of copying fixed function addresses
> to denali structure?
> 
> 

What I don't like is the function pointer as a function parameter. You
can use the functions defined statically if you prefer as long as the
parameter is just a boolean for instance?

Thanks,
Miquèl
