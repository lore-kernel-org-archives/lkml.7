Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294FEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 10:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA0B62075C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 10:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="v2vyN1Az"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfCLKwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 06:52:05 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:54948 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfCLKwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 06:52:04 -0400
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x2CApwm2012086
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 19:51:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x2CApwm2012086
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1552387919;
        bh=ZgV2yFx5wWKrkGMVucK2CamF3L6gxbdxfZJ4ivoFms4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=v2vyN1AzoJYXM5cwTOnimn5xovn8ONyS1BsicHUEY63pJyKLH1ZOxUvceBZTfNCK2
         b/OkxA29h34DZzw73PrO9Fz1+VdBl5BUirsRQGT+VKaioIS6qTG6EAUFUIYCkeaMxq
         boDKWJ2QJt+QcHMynAiLD+3n0XK2a36hMJCN0qpRNp/pk/mXf23j3mRBWQ46AN8rjV
         Sd9WmAF/gNymc+GUDEzKJaHi+9XIYjFm2DeuXm4NlNMwXls4DIuLw8ZJzGGYu4+PXt
         lKEx4jT8JIUpf1KN6VIjkeCKBPnQatAsBULeuOSDBbREfO0LPFkkNriMMb2gZrG6eR
         4fBUBSHQ7eeXA==
X-Nifty-SrcIP: [209.85.217.53]
Received: by mail-vs1-f53.google.com with SMTP id b17so1250712vsr.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 03:51:58 -0700 (PDT)
X-Gm-Message-State: APjAAAUk+WBGx0fI4R88ibMnEay2OZsm/YZc0ah/daYmDyWPicEvGptn
        Mkd2ioaqj6jyzeUfm4BOrV0gIVQHvp+pe6iRy1w=
X-Google-Smtp-Source: APXvYqxElvM3oYkFOdCdJ62Dd/sLxCJHf7rf0mrMK3XRbozxKfgEGYQzEUKBE3HKVM8vMkgjR2TVd45qe5RFU5/E2wE=
X-Received: by 2002:a67:7c04:: with SMTP id x4mr19771381vsc.155.1552387917521;
 Tue, 12 Mar 2019 03:51:57 -0700 (PDT)
MIME-Version: 1.0
References: <1552380290-19951-1-git-send-email-yamada.masahiro@socionext.com>
 <1552380290-19951-3-git-send-email-yamada.masahiro@socionext.com> <20190312112811.1af0bb00@xps13>
In-Reply-To: <20190312112811.1af0bb00@xps13>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 12 Mar 2019 19:51:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNATud=QTQ4FGxt1FtSZ06-Boa-jiROp7-wOj192FgXTNLw@mail.gmail.com>
Message-ID: <CAK7LNATud=QTQ4FGxt1FtSZ06-Boa-jiROp7-wOj192FgXTNLw@mail.gmail.com>
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

On Tue, Mar 12, 2019 at 7:28 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Masahiro,
>
> Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Tue, 12 Mar
> 2019 17:44:43 +0900:
>
> > The Denali IP adopts the syndrome page layout (payload and ECC are
> > interleaved). The *_page_raw() and *_oob() callbacks are complicated
> > because they must hide the underlying layout used by the hardware,
> > and always return contiguous in-band and out-of-band data.
> >
> > Currently, similar code is duplicated to reorganize the data layout.
> > For example, denali_read_page_raw() and denali_write_page_raw() look
> > almost the same.
> >
> > The idea for refactoring is to split the code into two parts:
> >   [1] conversion of page layout
> >   [2] what to do at every ECC chunk boundary
> >
> > For [1], I wrote denali_raw_payload_op() and denali_raw_oob_op().
> > They manipulate data for the Denali controller's specific page layout
> > of in-band, out-of-band, respectively.
> >
> > The difference between write and read is just the operation at
> > ECC chunk boundaries. For example, denali_read_oob() calls
> > nand_change_read_column_op(), whereas denali_write_oob() calls
> > nand_change_write_column_op(). So, I implemented [2] as a callback
> > passed into [1].
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
>
> [...]
>
> >  static int denali_read_page_raw(struct nand_chip *chip, uint8_t *buf,
> >                               int oob_required, int page)
> >  {
> > +     struct denali_nand_info *denali = to_denali(chip);
> >       struct mtd_info *mtd = nand_to_mtd(chip);
> > -     struct denali_nand_info *denali = mtd_to_denali(mtd);
> > -     int writesize = mtd->writesize;
> > -     int oobsize = mtd->oobsize;
> > -     int ecc_steps = chip->ecc.steps;
> > -     int ecc_size = chip->ecc.size;
> > -     int ecc_bytes = chip->ecc.bytes;
> >       void *tmp_buf = denali->buf;
> > -     int oob_skip = denali->oob_skip_bytes;
> > -     size_t size = writesize + oobsize;
> > -     int ret, i, pos, len;
> > +     size_t size = mtd->writesize + mtd->oobsize;
> > +     int ret;
> > +
> > +     if (!buf)
> > +             return -EINVAL;
> >
> >       ret = denali_data_xfer(chip, tmp_buf, size, page, 1, 0);
> >       if (ret)
> >               return ret;
> >
> > -     /* Arrange the buffer for syndrome payload/ecc layout */
> > -     if (buf) {
> > -             for (i = 0; i < ecc_steps; i++) {
> > -                     pos = i * (ecc_size + ecc_bytes);
> > -                     len = ecc_size;
> > -
> > -                     if (pos >= writesize)
> > -                             pos += oob_skip;
> > -                     else if (pos + len > writesize)
> > -                             len = writesize - pos;
> > -
> > -                     memcpy(buf, tmp_buf + pos, len);
> > -                     buf += len;
> > -                     if (len < ecc_size) {
> > -                             len = ecc_size - len;
> > -                             memcpy(buf, tmp_buf + writesize + oob_skip,
> > -                                    len);
> > -                             buf += len;
> > -                     }
> > -             }
> > -     }
> > +     ret = denali_raw_payload_op(chip, buf, denali_memcpy_in, tmp_buf);
>
> Honestly, I still don't like passing denali_memcpy_in/out as parameter.
>
> Besides that, once you'll have added helpers to avoid abusing the
> ternary operator in 4/9, the rest looks fine by me.
>


Do you have any suggestion?

There are 4 callbacks depending on the combination
of full-raw/oob, read/write.

I do not know how to make it cleaner.



-- 
Best Regards
Masahiro Yamada
