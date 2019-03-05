Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FF6C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 09:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66963206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 09:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="oszpQX22"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfCEJVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 04:21:11 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:58113 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfCEJVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 04:21:11 -0500
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x259Kwhx010925
        for <linux-kernel@vger.kernel.org>; Tue, 5 Mar 2019 18:20:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x259Kwhx010925
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1551777659;
        bh=n3KJVYBv09wgsRhWLTES9R+R2x0ss4Nx5o5rZ9eHyZs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oszpQX22Y6OGB4iLb19PNA2O+ohym8GNBBjoN247Q0Pyu04oDluRGXpE/6hsQPCVn
         RpLbOwdAG63/wINPF6ilzvKT7mWc41CJgtEUGRyo2Fw5oj/Hzq6mRLwFozAIGcLdzT
         mjmvqKzoTAWqJZXFcjWsFMTTmVz2i319TgAAQPSBLzyQ2ykoc1QvfQNHGlHRbXiiyk
         Hh3KmH+jwbZzWq2olspQiHoOfEVZHddJrsujS0h+bBPfAoJ/yS8tz0dFDQIUtIEZbp
         7n7KDzXZJdRLgAymCAYHmPpIyv6vLNMMz8VKry6GHfqKFq0yKpJjRY0c6sInA6J1z6
         FtjVSDHkU7FUQ==
X-Nifty-SrcIP: [209.85.222.53]
Received: by mail-ua1-f53.google.com with SMTP id j8so7100494uae.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 01:20:59 -0800 (PST)
X-Gm-Message-State: APjAAAUzVAGGYS16Ua7rGlQ5Ucce6F+kKIIg6I/kLtKxG6gJb2e5OGid
        po2K45YIPMYjEE891Z8D1+zPuc+s/G68FaU/r/U=
X-Google-Smtp-Source: APXvYqwUxPcFCDcq1pmH3zcXmYu/REIVSy9qiCLgsC89JWmmdlOhe3nFAEaGSbdmyo2dPLjaK0/hFjV3uPdc5mbD5JU=
X-Received: by 2002:a9f:314d:: with SMTP id n13mr718977uab.6.1551777658294;
 Tue, 05 Mar 2019 01:20:58 -0800 (PST)
MIME-Version: 1.0
References: <1549955582-30346-1-git-send-email-yamada.masahiro@socionext.com>
 <1549955582-30346-3-git-send-email-yamada.masahiro@socionext.com> <20190304100106.72ad49c3@xps13>
In-Reply-To: <20190304100106.72ad49c3@xps13>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 5 Mar 2019 18:20:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNASeBDxsUj2fu0bh9G6dXV2jxeHp6iBG+8FytNbHGtVHKQ@mail.gmail.com>
Message-ID: <CAK7LNASeBDxsUj2fu0bh9G6dXV2jxeHp6iBG+8FytNbHGtVHKQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] mtd: rawnand: denali: refactor syndrome layout
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

On Mon, Mar 4, 2019 at 6:01 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Masahiro,
>
> Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Tue, 12 Feb
> 2019 16:12:54 +0900:
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
>
> Could you please comment the purpose of these two functions in the code
> as well?


OK, I will.



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
> > Changes in v2: None
> >
> > drivers/mtd/nand/raw/denali.c | 354 +++++++++++++++++++-----------------------
> > 1 file changed, 163 insertions(+), 191 deletions(-)
>
> Too bad that the size of the driver did not shrink more than that :)

Indeed, less than expected.

But, please do not miss this commit is adding
error check to every operation.

Prior to this commit, the code just ignored the return code
because 97d90da8a886949f simply replaced old hooks
despite the new ones return the error code.


Generally, every error check costs two lines
in the following form:


  ret = (do something)
  if (ret)
           return ret;



> > +
> > +static int denali_memcpy_in(void *buf, unsigned int offset, unsigned int len,
> > +                         void *priv)
> > +{
> > +     memcpy(buf, priv + offset, len);
> > +     return 0;
> >  }
>
> Maybe this "callback" and the (_out cousin) could be part of you
> controller's structure,
> and you could use a read/write flag instead of
> passing the functions' pointer?

This is what the old code does.

There are 4 callbacks for the combination
of raw/oob, and write/read.

I do not know how your suggestion looks like,
and whether it will make the code cleaner.



--
Best Regards
Masahiro Yamada
