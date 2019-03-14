Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A40C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 08:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EBEF2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 08:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Umy3ipo4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfCNIZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 04:25:34 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:44009 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbfCNIZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 04:25:33 -0400
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x2E8PJGw010449
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 17:25:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x2E8PJGw010449
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1552551920;
        bh=e9evzMJ+uYgsiNQQS23HsBEHSxwMxqUkSnjbOuWeCO0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Umy3ipo4ci5Upbl0Mhb5E5QR93Vl3uYM7Gi7L0wyLL2WYhOUGAy2oPJWa/cBxkCAM
         OzuBuLywCniMsFDEXJKHFAELXYoBvyAqYbGgHP0115HcRvvST8EuUnkWxEPrgPHnhS
         ERi8IjJlx+6BnHrbSP7GaJlfsXWw5HV87/pn8LJ9jOZIyMr/G8R1CKliAPx5tXf6Hn
         KRhukGeietHB+Ldp+FirNKWtK+fjvex8l2PZO/27mJnMJO4Gd5jAFKzB5IbWTWH+MU
         sC+VbiyK9LVBbK52MNZOQBdnOZmv9toEymyPhOFlr+0tajiKlS5cW4a1bR+y7uY7Jq
         sMQPo7LaNaqDg==
X-Nifty-SrcIP: [209.85.217.42]
Received: by mail-vs1-f42.google.com with SMTP id c189so2702656vsd.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 01:25:19 -0700 (PDT)
X-Gm-Message-State: APjAAAVFFY94g8tW774S4hg+xtyNO9tyKftAhU1Q6aGjPt3O3Ev2oAmF
        6B+DWpRq11bqttri1j8KoTo6lMgr40kHz5fg3nA=
X-Google-Smtp-Source: APXvYqwZk4wBESJvvoYIyvcTIIgfT0pyq1xMF0FcpmWaYXxTvL+yKZZG1iWMytyinJVe0Kz9d7rMGDfOjOuIx82FTcY=
X-Received: by 2002:a67:7c04:: with SMTP id x4mr25724602vsc.155.1552551918500;
 Thu, 14 Mar 2019 01:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <1552380290-19951-1-git-send-email-yamada.masahiro@socionext.com>
 <1552380290-19951-3-git-send-email-yamada.masahiro@socionext.com>
 <20190312112811.1af0bb00@xps13> <CAK7LNATud=QTQ4FGxt1FtSZ06-Boa-jiROp7-wOj192FgXTNLw@mail.gmail.com>
 <20190312115425.612bcdf2@xps13> <CAK7LNAT_h7o4Rbzsgmd8Z6G3Pq3Uhvdqyhp2-ArCb8hfnreEpA@mail.gmail.com>
 <20190312141327.31c6af3f@xps13>
In-Reply-To: <20190312141327.31c6af3f@xps13>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 14 Mar 2019 17:24:41 +0900
X-Gmail-Original-Message-ID: <CAK7LNASegGwny8T+3-daaTJZoBNAar_26SSoNPqgd=Ns-t2_dA@mail.gmail.com>
Message-ID: <CAK7LNASegGwny8T+3-daaTJZoBNAar_26SSoNPqgd=Ns-t2_dA@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On Tue, Mar 12, 2019 at 10:13 PM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> Hi Masahiro,
>
> Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Tue, 12 Mar
> 2019 20:07:27 +0900:
>
> > Hi Miquel,
> >
> >
> > On Tue, Mar 12, 2019 at 7:54 PM Miquel Raynal <miquel.raynal@bootlin.co=
m> wrote:
> > >
> > > Hi Masahiro,
> > >
> > > Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Tue, 12 Mar
> > > 2019 19:51:21 +0900:
> > >
> > > > On Tue, Mar 12, 2019 at 7:28 PM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
> > > > >
> > > > > Hi Masahiro,
> > > > >
> > > > > Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Tue, 12 =
Mar
> > > > > 2019 17:44:43 +0900:
> > > > >
> > > > > > The Denali IP adopts the syndrome page layout (payload and ECC =
are
> > > > > > interleaved). The *_page_raw() and *_oob() callbacks are compli=
cated
> > > > > > because they must hide the underlying layout used by the hardwa=
re,
> > > > > > and always return contiguous in-band and out-of-band data.
> > > > > >
> > > > > > Currently, similar code is duplicated to reorganize the data la=
yout.
> > > > > > For example, denali_read_page_raw() and denali_write_page_raw()=
 look
> > > > > > almost the same.
> > > > > >
> > > > > > The idea for refactoring is to split the code into two parts:
> > > > > >   [1] conversion of page layout
> > > > > >   [2] what to do at every ECC chunk boundary
> > > > > >
> > > > > > For [1], I wrote denali_raw_payload_op() and denali_raw_oob_op(=
).
> > > > > > They manipulate data for the Denali controller's specific page =
layout
> > > > > > of in-band, out-of-band, respectively.
> > > > > >
> > > > > > The difference between write and read is just the operation at
> > > > > > ECC chunk boundaries. For example, denali_read_oob() calls
> > > > > > nand_change_read_column_op(), whereas denali_write_oob() calls
> > > > > > nand_change_write_column_op(). So, I implemented [2] as a callb=
ack
> > > > > > passed into [1].
> > > > > >
> > > > > > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > > > > ---
> > > > > >
> > > > >
> > > > > [...]
> > > > >
> > > > > >  static int denali_read_page_raw(struct nand_chip *chip, uint8_=
t *buf,
> > > > > >                               int oob_required, int page)
> > > > > >  {
> > > > > > +     struct denali_nand_info *denali =3D to_denali(chip);
> > > > > >       struct mtd_info *mtd =3D nand_to_mtd(chip);
> > > > > > -     struct denali_nand_info *denali =3D mtd_to_denali(mtd);
> > > > > > -     int writesize =3D mtd->writesize;
> > > > > > -     int oobsize =3D mtd->oobsize;
> > > > > > -     int ecc_steps =3D chip->ecc.steps;
> > > > > > -     int ecc_size =3D chip->ecc.size;
> > > > > > -     int ecc_bytes =3D chip->ecc.bytes;
> > > > > >       void *tmp_buf =3D denali->buf;
> > > > > > -     int oob_skip =3D denali->oob_skip_bytes;
> > > > > > -     size_t size =3D writesize + oobsize;
> > > > > > -     int ret, i, pos, len;
> > > > > > +     size_t size =3D mtd->writesize + mtd->oobsize;
> > > > > > +     int ret;
> > > > > > +
> > > > > > +     if (!buf)
> > > > > > +             return -EINVAL;
> > > > > >
> > > > > >       ret =3D denali_data_xfer(chip, tmp_buf, size, page, 1, 0)=
;
> > > > > >       if (ret)
> > > > > >               return ret;
> > > > > >
> > > > > > -     /* Arrange the buffer for syndrome payload/ecc layout */
> > > > > > -     if (buf) {
> > > > > > -             for (i =3D 0; i < ecc_steps; i++) {
> > > > > > -                     pos =3D i * (ecc_size + ecc_bytes);
> > > > > > -                     len =3D ecc_size;
> > > > > > -
> > > > > > -                     if (pos >=3D writesize)
> > > > > > -                             pos +=3D oob_skip;
> > > > > > -                     else if (pos + len > writesize)
> > > > > > -                             len =3D writesize - pos;
> > > > > > -
> > > > > > -                     memcpy(buf, tmp_buf + pos, len);
> > > > > > -                     buf +=3D len;
> > > > > > -                     if (len < ecc_size) {
> > > > > > -                             len =3D ecc_size - len;
> > > > > > -                             memcpy(buf, tmp_buf + writesize +=
 oob_skip,
> > > > > > -                                    len);
> > > > > > -                             buf +=3D len;
> > > > > > -                     }
> > > > > > -             }
> > > > > > -     }
> > > > > > +     ret =3D denali_raw_payload_op(chip, buf, denali_memcpy_in=
, tmp_buf);
> > > > >
> > > > > Honestly, I still don't like passing denali_memcpy_in/out as para=
meter.
> > > > >
> > > > > Besides that, once you'll have added helpers to avoid abusing the
> > > > > ternary operator in 4/9, the rest looks fine by me.
> > > > >
> > > >
> > > >
> > > > Do you have any suggestion?
> > >
> > > Maybe register these two helpers at probe as controller specific hook=
s,
> > > then just pass an in/out boolean to the function?
> > >
> >
> > Sorry, I do not understand.
> >
> > Are you suggesting to do like follows in probe ?
> >
> > denali->change_column_read_raw =3D denali_memcpy_in;
> > denali->change_column_write_raw =3D denali_memcpy_out;
> > denali->change_column_read_oob =3D denali_change_read_column_op;
> > denali->change_column_write_oob =3D denali_change_write_column_op;
> >
> >
> > All the 4 hooks are always needed
> > regardless of any probed features.
> >
> >
> > The result is just textual replacement
> > denali_* with denali->*.
> >
> > What's the point of copying fixed function addresses
> > to denali structure?
> >
> >
>
> What I don't like is the function pointer as a function parameter.

This is a usual way to handle callback.

> You
> can use the functions defined statically if you prefer as long as the
> parameter is just a boolean for instance?



I still do not understand your concern,
but if you ban the use of function pointer,
the following is the best I can do
since there are 4 hooks depending on the
combination of oob/raw, write/read.



if (oob) {
        if (write)
                return nand_change_write_column_op(chip, offset, buf,
                                                   len, false);
        else
                return nand_change_read_column_op(chip, offset, buf,
                                                  len, false);
}

if (write)
        memcpy(denali->buf + offset, buf, len);
else
        memcpy(buf, denali->buf + offset, len);

return 0;




BTW, when are .read_page_raw / .write_page_raw used?

Currently, I use "whole page access && memcpy" for better performance.

If those hooks are rarely used, I use
nand_change_write_column_op / nand_change_read_column_op,
which will reduce the if-conditional.




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
