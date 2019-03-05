Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D7AC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 07:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 837F020675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 07:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="iJq8lbC4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfCEHOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 02:14:19 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:22472 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfCEHOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 02:14:18 -0500
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x257DtSm018877
        for <linux-kernel@vger.kernel.org>; Tue, 5 Mar 2019 16:13:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x257DtSm018877
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1551770036;
        bh=FF/HDKixPCW4Zs6T210fuE1DHadGU2VOVKQBgaV87zo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iJq8lbC4VaeEP4nzOunxNWeFv5UmhQr3SYGcEHc8QsHmCOESoBc6wJpSGeYQvfsIJ
         XAROMr1ojeJhNvjPl0vcaWQlqxfaVbpd+b1oJXZrAi1QcmNCps5cwAXGpdRR9f0ykU
         6eq52LnUaFMt70DonRdDMQJWUB5vsJkGcKD9tQNUCcSHeiikwXyC9+EOBM9vzw2HbS
         E+LZSDATgnqSohfluu4U8YS0TUHQVTsosR4QQ56lnpCQS+sHkckAF8VwTRD6QACmw7
         Et8R90Z45nzHJOUP22WA1rkOZivZXC7bd5TfDldrw66smmgS3ukP+UQbUCS0PWP8qS
         ewYvxpSnsd1Ag==
X-Nifty-SrcIP: [209.85.222.49]
Received: by mail-ua1-f49.google.com with SMTP id e15so6851967uam.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 23:13:56 -0800 (PST)
X-Gm-Message-State: APjAAAXIi8C5gd9sEzztFt/rF/ho3qZdl3NikUrmzT7s2bsQmStI/MzT
        j8rz09SSHYTaJEOHusSKBCE4i0C0snqATjMRtv0=
X-Google-Smtp-Source: APXvYqxwMqz2LuTBAW1L2AYPJzwpIICLhgE3zvhVvqcgyg3YskTSz/NTVMbz5wHjYa0aXns+i4CPM5y/mIHaCVNMp68=
X-Received: by 2002:a67:f90e:: with SMTP id t14mr410032vsq.181.1551770035093;
 Mon, 04 Mar 2019 23:13:55 -0800 (PST)
MIME-Version: 1.0
References: <1549955582-30346-1-git-send-email-yamada.masahiro@socionext.com>
 <1549955582-30346-5-git-send-email-yamada.masahiro@socionext.com> <20190304103052.0eba71a6@xps13>
In-Reply-To: <20190304103052.0eba71a6@xps13>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 5 Mar 2019 16:13:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS_c0SsWwwkqc5_HBX560NPM5-QJSH9_JcTLULHvz3b1A@mail.gmail.com>
Message-ID: <CAK7LNAS_c0SsWwwkqc5_HBX560NPM5-QJSH9_JcTLULHvz3b1A@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] mtd: rawnand: denali: switch over to ->exec_op()
 from legacy hooks
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,


On Mon, Mar 4, 2019 at 6:31 PM Miquel Raynal <miquel.raynal@bootlin.com> wr=
ote:
>
> Hi Masahiro,
>
> Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Tue, 12 Feb
> 2019 16:12:56 +0900:
>
> > Implement ->exec_op(), and remove the deprecated hooks.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
>
> Thanks for working on this, I like it very much!
>
> >
> > Changes in v2: None
> >
> >  drivers/mtd/nand/raw/denali.c | 234 +++++++++++++++++++++++-----------=
--------
> >  1 file changed, 126 insertions(+), 108 deletions(-)
> >
> > diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denal=
i.c
> > index a2fe2ff..bd7df25 100644
> > --- a/drivers/mtd/nand/raw/denali.c
> > +++ b/drivers/mtd/nand/raw/denali.c
>
> [...]
>
> > +
> > +static int denali_exec_instr(struct nand_chip *chip,
> > +                          const struct nand_op_instr *instr)
> > +{
> > +     struct denali_nand_info *denali =3D to_denali(chip);
> > +     bool width16 =3D chip->options & NAND_BUSWIDTH_16;
> > +
> > +     switch (instr->type) {
> > +     case NAND_OP_CMD_INSTR:
> > +             denali_exec_out8(denali, DENALI_MAP11_CMD,
> > +                              &instr->ctx.cmd.opcode, 1);
> > +             return 0;
> > +     case NAND_OP_ADDR_INSTR:
> > +             denali_exec_out8(denali, DENALI_MAP11_ADDR,
> > +                              instr->ctx.addr.addrs,
> > +                              instr->ctx.addr.naddrs);
> > +             return 0;
> > +     case NAND_OP_DATA_IN_INSTR:
> > +             (!instr->ctx.data.force_8bit && width16 ?
> > +              denali_exec_in16 :
> > +              denali_exec_in8)(denali, DENALI_MAP11_DATA,
> > +                               instr->ctx.data.buf.in,
> > +                               instr->ctx.data.len);
>
> I think this is abusing the ternary operator, can you please find
> another way for writing this? Otherwise it is not easily readable... If
> it is really too complicated within 80 chars, then never mind.

Yes, I am abusing it,
but the intention is quite clear.


I could stupidly repeat the same function arguments like follows,
but I did not want to do it.

case NAND_OP_DATA_IN_INSTR:
        if (!instr->ctx.data.force_8bit && width16)
                denali_exec_in16(denali, DENALI_MAP11_DATA,
                                 instr->ctx.data.buf.in,
                                 instr->ctx.data.len);
        else
                denali_exec_in8(denali, DENALI_MAP11_DATA,
                                instr->ctx.data.buf.in,
                                instr->ctx.data.len);





> > +             return 0;
> > +     case NAND_OP_DATA_OUT_INSTR:
> > +             (!instr->ctx.data.force_8bit && width16 ?
> > +              denali_exec_out16 :
> > +              denali_exec_out8)(denali, DENALI_MAP11_DATA,
> > +                                instr->ctx.data.buf.out,
> > +                                instr->ctx.data.len);
> > +             return 0;
> > +     case NAND_OP_WAITRDY_INSTR:
> > +             return denali_exec_waitrdy(denali);
> > +     default:
> > +             WARN_ONCE(1, "unsupported NAND instruction type: %d\n",
> > +                       instr->type);
> > +
> > +             return -EINVAL;
> > +     }
> > +}
> > +
>
>
> Thanks,
> Miqu=C3=A8l
>
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/



--=20
Best Regards
Masahiro Yamada
