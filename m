Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D7DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 11:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E9A206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 11:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="tFE+m/bQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfCLLIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 07:08:21 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:21576 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbfCLLIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 07:08:21 -0400
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x2CB83ag008253
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 20:08:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x2CB83ag008253
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1552388884;
        bh=mDCrP0wmHjPdvYFc8iA5MCSfnV+mW/VABfBfZvAFUgg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tFE+m/bQ2TOaxgPbCY5TFDp6VZDgcLv0GdeRRrSjvkBZV7w95jIWHAvgG8FXJjaKJ
         X5DfUiL3mIfcsS2yoE6Wr5mcpC38DdUz5+21Qskqo4c0B07bneufH7fLCS9ZpWrsBH
         0xxpd+qqYy78AxBJ/Raj6aEQhYaVArEERN8lkrAI3zs1+sE7qV1Uxqf0RZ74jGWays
         8qchBuGVd+UxbEFeDz5GkMUxL1tkny2viUkGgVRNW7/8Bsc3/GU6gNEKz14lfOaxq8
         S3aJPUIGuhgnE1SCGZx0FTqMuqYbiTvi+HIVw4XtOiaR4PzMJvlRc9O7O/LrNR1Eeq
         a63ACa1G+EgXQ==
X-Nifty-SrcIP: [209.85.222.44]
Received: by mail-ua1-f44.google.com with SMTP id u1so618918uae.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 04:08:04 -0700 (PDT)
X-Gm-Message-State: APjAAAVehMrTlIvXadXWv414lcmimybCZiZwwNMw+1CCLHZOJIhOeYAr
        NKFRQil81wUdHAbJgSQl5EN5kIuduURCpnW1jo8=
X-Google-Smtp-Source: APXvYqyjMgRUZE6LIxWKxnxfxSm/E/WbTmbTileAswOE09h8TXtG1xzj7jJ5BAvTx9nMbKJbcmRh/E37TZyZXZB7usE=
X-Received: by 2002:ab0:c07:: with SMTP id a7mr19074125uak.55.1552388883017;
 Tue, 12 Mar 2019 04:08:03 -0700 (PDT)
MIME-Version: 1.0
References: <1552380290-19951-1-git-send-email-yamada.masahiro@socionext.com>
 <1552380290-19951-3-git-send-email-yamada.masahiro@socionext.com>
 <20190312112811.1af0bb00@xps13> <CAK7LNATud=QTQ4FGxt1FtSZ06-Boa-jiROp7-wOj192FgXTNLw@mail.gmail.com>
 <20190312115425.612bcdf2@xps13>
In-Reply-To: <20190312115425.612bcdf2@xps13>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 12 Mar 2019 20:07:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT_h7o4Rbzsgmd8Z6G3Pq3Uhvdqyhp2-ArCb8hfnreEpA@mail.gmail.com>
Message-ID: <CAK7LNAT_h7o4Rbzsgmd8Z6G3Pq3Uhvdqyhp2-ArCb8hfnreEpA@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] mtd: rawnand: denali: refactor syndrome layout
 handling for raw access
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,


On Tue, Mar 12, 2019 at 7:54 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Masahiro,
>
> Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Tue, 12 Mar
> 2019 19:51:21 +0900:
>
> > On Tue, Mar 12, 2019 at 7:28 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > >
> > > Hi Masahiro,
> > >
> > > Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Tue, 12 Mar
> > > 2019 17:44:43 +0900:
> > >
> > > > The Denali IP adopts the syndrome page layout (payload and ECC are
> > > > interleaved). The *_page_raw() and *_oob() callbacks are complicated
> > > > because they must hide the underlying layout used by the hardware,
> > > > and always return contiguous in-band and out-of-band data.
> > > >
> > > > Currently, similar code is duplicated to reorganize the data layout.
> > > > For example, denali_read_page_raw() and denali_write_page_raw() look
> > > > almost the same.
> > > >
> > > > The idea for refactoring is to split the code into two parts:
> > > >   [1] conversion of page layout
> > > >   [2] what to do at every ECC chunk boundary
> > > >
> > > > For [1], I wrote denali_raw_payload_op() and denali_raw_oob_op().
> > > > They manipulate data for the Denali controller's specific page layout
> > > > of in-band, out-of-band, respectively.
> > > >
> > > > The difference between write and read is just the operation at
> > > > ECC chunk boundaries. For example, denali_read_oob() calls
> > > > nand_change_read_column_op(), whereas denali_write_oob() calls
> > > > nand_change_write_column_op(). So, I implemented [2] as a callback
> > > > passed into [1].
> > > >
> > > > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > > ---
> > > >
> > >
> > > [...]
> > >
> > > >  static int denali_read_page_raw(struct nand_chip *chip, uint8_t *buf,
> > > >                               int oob_required, int page)
> > > >  {
> > > > +     struct denali_nand_info *denali = to_denali(chip);
> > > >       struct mtd_info *mtd = nand_to_mtd(chip);
> > > > -     struct denali_nand_info *denali = mtd_to_denali(mtd);
> > > > -     int writesize = mtd->writesize;
> > > > -     int oobsize = mtd->oobsize;
> > > > -     int ecc_steps = chip->ecc.steps;
> > > > -     int ecc_size = chip->ecc.size;
> > > > -     int ecc_bytes = chip->ecc.bytes;
> > > >       void *tmp_buf = denali->buf;
> > > > -     int oob_skip = denali->oob_skip_bytes;
> > > > -     size_t size = writesize + oobsize;
> > > > -     int ret, i, pos, len;
> > > > +     size_t size = mtd->writesize + mtd->oobsize;
> > > > +     int ret;
> > > > +
> > > > +     if (!buf)
> > > > +             return -EINVAL;
> > > >
> > > >       ret = denali_data_xfer(chip, tmp_buf, size, page, 1, 0);
> > > >       if (ret)
> > > >               return ret;
> > > >
> > > > -     /* Arrange the buffer for syndrome payload/ecc layout */
> > > > -     if (buf) {
> > > > -             for (i = 0; i < ecc_steps; i++) {
> > > > -                     pos = i * (ecc_size + ecc_bytes);
> > > > -                     len = ecc_size;
> > > > -
> > > > -                     if (pos >= writesize)
> > > > -                             pos += oob_skip;
> > > > -                     else if (pos + len > writesize)
> > > > -                             len = writesize - pos;
> > > > -
> > > > -                     memcpy(buf, tmp_buf + pos, len);
> > > > -                     buf += len;
> > > > -                     if (len < ecc_size) {
> > > > -                             len = ecc_size - len;
> > > > -                             memcpy(buf, tmp_buf + writesize + oob_skip,
> > > > -                                    len);
> > > > -                             buf += len;
> > > > -                     }
> > > > -             }
> > > > -     }
> > > > +     ret = denali_raw_payload_op(chip, buf, denali_memcpy_in, tmp_buf);
> > >
> > > Honestly, I still don't like passing denali_memcpy_in/out as parameter.
> > >
> > > Besides that, once you'll have added helpers to avoid abusing the
> > > ternary operator in 4/9, the rest looks fine by me.
> > >
> >
> >
> > Do you have any suggestion?
>
> Maybe register these two helpers at probe as controller specific hooks,
> then just pass an in/out boolean to the function?
>

Sorry, I do not understand.

Are you suggesting to do like follows in probe ?

denali->change_column_read_raw = denali_memcpy_in;
denali->change_column_write_raw = denali_memcpy_out;
denali->change_column_read_oob = denali_change_read_column_op;
denali->change_column_write_oob = denali_change_write_column_op;


All the 4 hooks are always needed
regardless of any probed features.


The result is just textual replacement
denali_* with denali->*.

What's the point of copying fixed function addresses
to denali structure?


-- 
Best Regards
Masahiro Yamada
