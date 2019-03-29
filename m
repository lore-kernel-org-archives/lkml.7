Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE27C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 07:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C1B82173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 07:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="eWWDI9tS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbfC2HCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 03:02:53 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:28218 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728719AbfC2HCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 03:02:53 -0400
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x2T72aB3010461
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 16:02:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x2T72aB3010461
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1553842957;
        bh=Ruq2JIDk5dGxA9NJovtSIj+mgyV4C+T1XepbEFuu4z4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eWWDI9tSVm7NLtfnt4SxEesW8mBp28eGszdf5sFwa0baskaynZgl5gUZwV0Xbmu6P
         XC7tTK8FnE9K3LK87sQ73a9zEA8EaVy5He9s0X5hh2uG+yGSAU8XwClwHtSFEyN5Gt
         08opxjas5gdYnYPgeTdQlOabxWWowUMZufKKO539Tz86x815ChbMIvVynuvuvFxVxa
         VgsBz+N+4bamwlPmNeCr7Rl/VYrT2XkU4RMnirelX5qcQfhu9zDnozOWCLaiPjpkRv
         eImqcaLuZgKiFXZK5J6otkZFz9Wy+yP+CwW9ocDm12kzpJKZT8CCqq8l0PJ3ndRbzq
         5ZYZ1z9jTc9HQ==
X-Nifty-SrcIP: [209.85.217.51]
Received: by mail-vs1-f51.google.com with SMTP id s2so707998vsi.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 00:02:37 -0700 (PDT)
X-Gm-Message-State: APjAAAVlMRIgFANTIcNS7ncSmvkWIp1U26cKBNLNALWutoeQnv4ZQcXu
        u/pKnkreztZ80kVwPqe4ejqYWIAJOz0z6aYDPAc=
X-Google-Smtp-Source: APXvYqzfUKI/WMYrkEEPnhaevPwvGhKTSTCm/EJIWVjLC6VaiP/KYjZ+Kydg/okhrnLn6fe/+8eFD4mE2YqOfYQB4wA=
X-Received: by 2002:a67:7a43:: with SMTP id v64mr28921483vsc.54.1553842956015;
 Fri, 29 Mar 2019 00:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <1552380290-19951-1-git-send-email-yamada.masahiro@socionext.com>
 <1552380290-19951-3-git-send-email-yamada.masahiro@socionext.com>
 <20190312112811.1af0bb00@xps13> <CAK7LNATud=QTQ4FGxt1FtSZ06-Boa-jiROp7-wOj192FgXTNLw@mail.gmail.com>
 <20190312115425.612bcdf2@xps13> <CAK7LNAT_h7o4Rbzsgmd8Z6G3Pq3Uhvdqyhp2-ArCb8hfnreEpA@mail.gmail.com>
 <20190312141327.31c6af3f@xps13> <CAK7LNASegGwny8T+3-daaTJZoBNAar_26SSoNPqgd=Ns-t2_dA@mail.gmail.com>
 <20190315093429.35137adb@xps13>
In-Reply-To: <20190315093429.35137adb@xps13>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 29 Mar 2019 16:02:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ08gL3ABaRwmbVZGgYwr54ahqLpvDGDP+0aRaUpZzcdQ@mail.gmail.com>
Message-ID: <CAK7LNAQ08gL3ABaRwmbVZGgYwr54ahqLpvDGDP+0aRaUpZzcdQ@mail.gmail.com>
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


On Fri, Mar 15, 2019 at 5:34 PM Miquel Raynal <miquel.raynal@bootlin.com> w=
rote:
>
> Hi Masahiro,
>
> Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Thu, 14 Mar
> 2019 17:24:41 +0900:
>
> > Hi Miquel,
> >
> > On Tue, Mar 12, 2019 at 10:13 PM Miquel Raynal
> > <miquel.raynal@bootlin.com> wrote:
> > >
> > > Hi Masahiro,
> > >
> > > Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Tue, 12 Mar
> > > 2019 20:07:27 +0900:
> > >
> > > > Hi Miquel,
> > > >
> > > >
> > > > On Tue, Mar 12, 2019 at 7:54 PM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
> > > > >
> > > > > Hi Masahiro,
> > > > >
> > > > > Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Tue, 12 =
Mar
> > > > > 2019 19:51:21 +0900:
> > > > >
> > > > > > On Tue, Mar 12, 2019 at 7:28 PM Miquel Raynal <miquel.raynal@bo=
otlin.com> wrote:
> > > > > > >
> > > > > > > Hi Masahiro,
> > > > > > >
> > > > > > > Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Tue,=
 12 Mar
> > > > > > > 2019 17:44:43 +0900:
> > > > > > >
> > > > > > > > The Denali IP adopts the syndrome page layout (payload and =
ECC are
> > > > > > > > interleaved). The *_page_raw() and *_oob() callbacks are co=
mplicated
> > > > > > > > because they must hide the underlying layout used by the ha=
rdware,
> > > > > > > > and always return contiguous in-band and out-of-band data.
> > > > > > > >
> > > > > > > > Currently, similar code is duplicated to reorganize the dat=
a layout.
> > > > > > > > For example, denali_read_page_raw() and denali_write_page_r=
aw() look
> > > > > > > > almost the same.
> > > > > > > >
> > > > > > > > The idea for refactoring is to split the code into two part=
s:
> > > > > > > >   [1] conversion of page layout
> > > > > > > >   [2] what to do at every ECC chunk boundary
> > > > > > > >
> > > > > > > > For [1], I wrote denali_raw_payload_op() and denali_raw_oob=
_op().
> > > > > > > > They manipulate data for the Denali controller's specific p=
age layout
> > > > > > > > of in-band, out-of-band, respectively.
> > > > > > > >
> > > > > > > > The difference between write and read is just the operation=
 at
> > > > > > > > ECC chunk boundaries. For example, denali_read_oob() calls
> > > > > > > > nand_change_read_column_op(), whereas denali_write_oob() ca=
lls
> > > > > > > > nand_change_write_column_op(). So, I implemented [2] as a c=
allback
> > > > > > > > passed into [1].
> > > > > > > >
> > > > > > > > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.c=
om>
> > > > > > > > ---
> > > > > > > >
> > > > > > >
> > > > > > > [...]
> > > > > > >
> > > > > > > >  static int denali_read_page_raw(struct nand_chip *chip, ui=
nt8_t *buf,
> > > > > > > >                               int oob_required, int page)
> > > > > > > >  {
> > > > > > > > +     struct denali_nand_info *denali =3D to_denali(chip);
> > > > > > > >       struct mtd_info *mtd =3D nand_to_mtd(chip);
> > > > > > > > -     struct denali_nand_info *denali =3D mtd_to_denali(mtd=
);
> > > > > > > > -     int writesize =3D mtd->writesize;
> > > > > > > > -     int oobsize =3D mtd->oobsize;
> > > > > > > > -     int ecc_steps =3D chip->ecc.steps;
> > > > > > > > -     int ecc_size =3D chip->ecc.size;
> > > > > > > > -     int ecc_bytes =3D chip->ecc.bytes;
> > > > > > > >       void *tmp_buf =3D denali->buf;
> > > > > > > > -     int oob_skip =3D denali->oob_skip_bytes;
> > > > > > > > -     size_t size =3D writesize + oobsize;
> > > > > > > > -     int ret, i, pos, len;
> > > > > > > > +     size_t size =3D mtd->writesize + mtd->oobsize;
> > > > > > > > +     int ret;
> > > > > > > > +
> > > > > > > > +     if (!buf)
> > > > > > > > +             return -EINVAL;
> > > > > > > >
> > > > > > > >       ret =3D denali_data_xfer(chip, tmp_buf, size, page, 1=
, 0);
> > > > > > > >       if (ret)
> > > > > > > >               return ret;
> > > > > > > >
> > > > > > > > -     /* Arrange the buffer for syndrome payload/ecc layout=
 */
> > > > > > > > -     if (buf) {
> > > > > > > > -             for (i =3D 0; i < ecc_steps; i++) {
> > > > > > > > -                     pos =3D i * (ecc_size + ecc_bytes);
> > > > > > > > -                     len =3D ecc_size;
> > > > > > > > -
> > > > > > > > -                     if (pos >=3D writesize)
> > > > > > > > -                             pos +=3D oob_skip;
> > > > > > > > -                     else if (pos + len > writesize)
> > > > > > > > -                             len =3D writesize - pos;
> > > > > > > > -
> > > > > > > > -                     memcpy(buf, tmp_buf + pos, len);
> > > > > > > > -                     buf +=3D len;
> > > > > > > > -                     if (len < ecc_size) {
> > > > > > > > -                             len =3D ecc_size - len;
> > > > > > > > -                             memcpy(buf, tmp_buf + writesi=
ze + oob_skip,
> > > > > > > > -                                    len);
> > > > > > > > -                             buf +=3D len;
> > > > > > > > -                     }
> > > > > > > > -             }
> > > > > > > > -     }
> > > > > > > > +     ret =3D denali_raw_payload_op(chip, buf, denali_memcp=
y_in, tmp_buf);
> > > > > > >
> > > > > > > Honestly, I still don't like passing denali_memcpy_in/out as =
parameter.
> > > > > > >
> > > > > > > Besides that, once you'll have added helpers to avoid abusing=
 the
> > > > > > > ternary operator in 4/9, the rest looks fine by me.
> > > > > > >
> > > > > >
> > > > > >
> > > > > > Do you have any suggestion?
> > > > >
> > > > > Maybe register these two helpers at probe as controller specific =
hooks,
> > > > > then just pass an in/out boolean to the function?
> > > > >
> > > >
> > > > Sorry, I do not understand.
> > > >
> > > > Are you suggesting to do like follows in probe ?
> > > >
> > > > denali->change_column_read_raw =3D denali_memcpy_in;
> > > > denali->change_column_write_raw =3D denali_memcpy_out;
> > > > denali->change_column_read_oob =3D denali_change_read_column_op;
> > > > denali->change_column_write_oob =3D denali_change_write_column_op;
> > > >
> > > >
> > > > All the 4 hooks are always needed
> > > > regardless of any probed features.
> > > >
> > > >
> > > > The result is just textual replacement
> > > > denali_* with denali->*.
> > > >
> > > > What's the point of copying fixed function addresses
> > > > to denali structure?
> > > >
> > > >
> > >
> > > What I don't like is the function pointer as a function parameter.
> >
> > This is a usual way to handle callback.
> >
> > > You
> > > can use the functions defined statically if you prefer as long as the
> > > parameter is just a boolean for instance?
> >
> >
> >
> > I still do not understand your concern,
> > but if you ban the use of function pointer,
> > the following is the best I can do
> > since there are 4 hooks depending on the
> > combination of oob/raw, write/read.
> >
> >
> >
> > if (oob) {
> >         if (write)
> >                 return nand_change_write_column_op(chip, offset, buf,
> >                                                    len, false);
> >         else
> >                 return nand_change_read_column_op(chip, offset, buf,
> >                                                   len, false);
> > }
> >
> > if (write)
> >         memcpy(denali->buf + offset, buf, len);
> > else
> >         memcpy(buf, denali->buf + offset, len);
> >
> > return 0;
>
> No, I meant passing a boolean to denali_raw_payload_op() instead of a
> function pointer. Then from denali_raw_payload_op(), intead of doing
>
> ret =3D cb();
> if (ret)
>         ...
>
> doing:
>
> if (read)
>         ret =3D denali_memcpy_in()
> else
>         ret =3D denali_memcpy_out()
>
> if (ret)
>         ...


If you look at my code closely,
you will notice 4 callbacks passed in
denali_raw_payload_op().

So, if-conditional would end up like follows:


    if (oob) {
            if (write)
                    ret =3D nand_change_write_column_op(chip, offset, buf,
                                                   len, false);
            else
                    ret =3D nand_change_read_column_op(chip, offset, buf,
                                                  len, false);
            if (ret)
                    return ret;
     } else {
            if (write)
                  memcpy(denali->buf + offset, buf, len);
            else
                  memcpy(buf, denali->buf + offset, len);
     }


This is extremely ugly.
That's why I passed a function pointer
instead of two boolean parameters 'oob', 'write'.




> But nevermind, if this is bothering you too much let's keep the current
> form, it's fine.
>
> >
> >
> > BTW, when are .read_page_raw / .write_page_raw used?
>
> I'm not sure what is the question here but these hooks are important
> and allow to test the driver. nandbiterrs use them (although we do
> not care about the performance in these hooks).


Currently, I use DMA transfer + memcpy()
in order to get better performance for
.read_page_raw() and .write_page_raw()


nand_change_write_column_op() and
nand_change_read_column_op() are slow
since they are low-level hardware accesses.


If we do not have to care about the performance,
I will only use nand_change_{write,read}_column_op().




> >
> > Currently, I use "whole page access && memcpy" for better performance.
> >
> > If those hooks are rarely used, I use
> > nand_change_write_column_op / nand_change_read_column_op,
> > which will reduce the if-conditional.
>
> Yes you can. We do not care about performance in raw accessors.

OK, I will do this in v4.




> Thanks,
> Miqu=C3=A8l
>
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/



--=20
Best Regards
Masahiro Yamada
