Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE8EC32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 16:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B34512168B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 16:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Sj/iKyao"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732304AbfI3Qdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 12:33:47 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45941 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731976AbfI3Qdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 12:33:46 -0400
Received: by mail-lj1-f194.google.com with SMTP id q64so10154608ljb.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 09:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X342zlUizHRvyrES5Pcuxcu7FqW9SI8435jSZaU4FUM=;
        b=Sj/iKyaonBeAKT/qexlrU1VcHkXhgVA1m/q+Mo3IH33PIj7FTe8dgUPhIfckAOEEJD
         X3agXJR14Qk2KjTT5kojgLMM2ZXbrFmkGk2mA4BELlyzxwkVss1gCi2Ph/Nj718EgBk5
         oF9GM7glPghqrDajeUzP264BZ9CihyvJiUNts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X342zlUizHRvyrES5Pcuxcu7FqW9SI8435jSZaU4FUM=;
        b=jcagcRdZqsc8SUCDnCLyPrulPMFY3/Ny4I1dvGhUhDXmIXQS8HpQLDgunaVEWXiABO
         CrpiDABxiY8p/Uo7UoN5c307an4WPJ7zKo/FvFKMpNXZxFlmB+Z0lJggaHZ56zSqtS3y
         L/IU1J+d2CiX/NLkw88ih1fx0Rp6rz6cQ3GNXaLAuruQW38mfabA4EIN3edzNa7iVXZD
         eLboiPXjBIe80VUAxb2MoYRwBJORCWLmNfGSlGVYVhuMO7uj220Oc4L/zGfJHn1UxiTL
         jTch9LJnG09FkimYIfe5m6fjrw78lhUtCYFWP7jO3QeXRQ/AtZWaJ01gUhAK0VQ4obfN
         8XRg==
X-Gm-Message-State: APjAAAVcnNNAPWHQwnR8Rfd6J7zyq38qVS4tQYiW6yOTOP0UO+B8ySZM
        RvT1qU77gkPhvlN2ULrHpP4O120rBysrw8zybELUJw==
X-Google-Smtp-Source: APXvYqzdPZY49T5ieicFrMHCYGXq6NDeWTOJvMTfNfmO/DWlTvyQJdV6zKDA4pxg0cJL+3VOiOxboNoIeF+TdSdMW/o=
X-Received: by 2002:a2e:9853:: with SMTP id e19mr1416618ljj.57.1569861224396;
 Mon, 30 Sep 2019 09:33:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190906194719.15761-1-kdasu.kdev@gmail.com> <20190906194719.15761-2-kdasu.kdev@gmail.com>
 <CAC=U0a1qvKO+t_62df_JcQBETAuNq0pwRkAb-Ofi3ski2rfdEQ@mail.gmail.com> <20190930182458.761e8077@collabora.com>
In-Reply-To: <20190930182458.761e8077@collabora.com>
From:   Kamal Dasu <kamal.dasu@broadcom.com>
Date:   Mon, 30 Sep 2019 12:33:06 -0400
Message-ID: <CAKekbevBxGh9HRLX_4N98NwKm4GnXWvy9kwi6i=nRVnmfmJ-vw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mtd: rawnand: use bounce buffer when vmalloced data
 buf detected
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Kamal Dasu <kdasu.kdev@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 12:25 PM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> On Mon, 30 Sep 2019 12:01:28 -0400
> Kamal Dasu <kdasu.kdev@gmail.com> wrote:
>
> > Does anyone have any comments on this patch ?.
> >
> > Kamal
> >
> > On Fri, Sep 6, 2019 at 3:49 PM Kamal Dasu <kdasu.kdev@gmail.com> wrote:
> > >
> > > For controller drivers that use DMA and set NAND_USE_BOUNCE_BUFFER
> > > option use data buffers that are not vmalloced, aligned and have
> > > valid virtual address to be able to do DMA transfers. This change
> > > adds additional check and makes use of data buffer allocated
> > > in nand_base driver when it is passed a vmalloced data buffer for
> > > DMA transfers.
> > >
> > > Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> > > ---
> > >  drivers/mtd/nand/raw/nand_base.c | 14 ++++++++------
> > >  1 file changed, 8 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> > > index 91f046d4d452..46f6965a896a 100644
> > > --- a/drivers/mtd/nand/raw/nand_base.c
> > > +++ b/drivers/mtd/nand/raw/nand_base.c
> > > @@ -45,6 +45,12 @@
> > >
> > >  #include "internals.h"
> > >
> > > +static int nand_need_bounce_buf(const void *buf, struct nand_chip *chip)
> > > +{
> > > +       return !virt_addr_valid(buf) || is_vmalloc_addr(buf) ||
>
> I thought virt_addr_valid() was implying !is_vmalloc_addr(), are you
> sure you need that test, and can you tell me on which arch(es) this is
> needed.
>

This has been observed on MIPS4K and MIPS5K architectures. There is a
check on the controller driver to use pio in such cases.

> > > +               !IS_ALIGNED((unsigned long)buf, chip->buf_align);
> > > +}
> > > +
> > >  /* Define default oob placement schemes for large and small page devices */
> > >  static int nand_ooblayout_ecc_sp(struct mtd_info *mtd, int section,
> > >                                  struct mtd_oob_region *oobregion)
> > > @@ -3183,9 +3189,7 @@ static int nand_do_read_ops(struct nand_chip *chip, loff_t from,
> > >                 if (!aligned)
> > >                         use_bufpoi = 1;
> > >                 else if (chip->options & NAND_USE_BOUNCE_BUFFER)
> > > -                       use_bufpoi = !virt_addr_valid(buf) ||
> > > -                                    !IS_ALIGNED((unsigned long)buf,
> > > -                                                chip->buf_align);
> > > +                       use_bufpoi = nand_need_bounce_buf(buf, chip);
> > >                 else
> > >                         use_bufpoi = 0;
> > >
> > > @@ -4009,9 +4013,7 @@ static int nand_do_write_ops(struct nand_chip *chip, loff_t to,
> > >                 if (part_pagewr)
> > >                         use_bufpoi = 1;
> > >                 else if (chip->options & NAND_USE_BOUNCE_BUFFER)
> > > -                       use_bufpoi = !virt_addr_valid(buf) ||
> > > -                                    !IS_ALIGNED((unsigned long)buf,
> > > -                                                chip->buf_align);
> > > +                       use_bufpoi = nand_need_bounce_buf(buf, chip);
> > >                 else
> > >                         use_bufpoi = 0;
> > >
> > > --
> > > 2.17.1
> > >
>
