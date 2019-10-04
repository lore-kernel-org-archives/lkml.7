Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A1FC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 17:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC282084D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 17:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8nJut5v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388008AbfJDRUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 13:20:33 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45497 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729291AbfJDRUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 13:20:32 -0400
Received: by mail-io1-f68.google.com with SMTP id c25so15105255iot.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 10:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sKSw8LHZWbzHBzhBHzIOue57k2GC5Z1ZStIkEWKfwgk=;
        b=H8nJut5vMkDRbQ9IMz8Sz2DcHe4QqerOmNEZ82FANGu9ZivVe/t4xGYoF6I9nLVwD7
         RR8V+7CPA2Y+VP+3wAElS4y9hZu7YTTvaw1t+cjyFpGzAd71HMx7+ehjTXW33GBnOh3O
         /rGnNXmfNg3RQnvHEOff7bHYgiKEjXxibgufvwO4jnTJYdFsZH8TmUyINqDNFuGQ9IUq
         hoRQcy32Nv/S5z/SRkd4gbd1RpNOrSpOZXiWk8HaHbUHXqvuZJhvQxdpXZGrm+JMqreg
         jRT6D0AKj9AbqSt2/vRYYN+zuG13++ESvIXV503LB/YCKzEVnkD2ona1uEXFNkKeZrlk
         brZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sKSw8LHZWbzHBzhBHzIOue57k2GC5Z1ZStIkEWKfwgk=;
        b=d3bANYmUV3LDdGJOs/7LbksXZgH4klqKYNxhjtj0zVeq4tEafg7RGxeIl9JtLKC/lF
         Y8wNYLgmBaL2r6jC4nL2jGF/DXAD+ooiXtRNSGPvi4N2FJztmCyIDBIunGpjFtOzcyXX
         fYfEa8F13+YRQ8zFtLM7VLzRaDJqJ8O910Lo5KY/9W2eEWJaLwGo/PEg/0fZZ0wwiWqZ
         qPG1Dg6rGtXuB8gR+4H14A4i4IHtcj+OvKjZHhtozvoka50GeMw8+zNfSdii1p/NHLIH
         /jFwCU11171HnNp5nD4T+hmDn9L/+7gtTsEoHCY49y6eJmB0geTV5iN4rjm035eEDKsG
         Igyw==
X-Gm-Message-State: APjAAAWbTHH5xuMs3KrYBhgHilsNcJRCd/rRcNzY5m93T8dOaBp+mKhA
        l6McdpimagmsB592Q+4SgLzuFrbOBFAZBz587RE=
X-Google-Smtp-Source: APXvYqzAxM+PiltX2TIBjv/ydm3UZ3bSSprb2UNGgPoDAaW9AZlWIyu5QGysW701lNcNQYSychifgmrLEaiO6SabKUI=
X-Received: by 2002:a92:b112:: with SMTP id t18mr16647383ilh.252.1570209631842;
 Fri, 04 Oct 2019 10:20:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190925154302.17708-1-navid.emamdoost@gmail.com>
 <CAEkB2ETTmCsuOFDsJQ8LbBPHNgckpDFn2XhVePwAQEsCRsJo6g@mail.gmail.com> <20191004175740.5dd84c38@xps13>
In-Reply-To: <20191004175740.5dd84c38@xps13>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Fri, 4 Oct 2019 12:20:20 -0500
Message-ID: <CAEkB2ERissJF6EOhMtoO+RBXJOVnZYuMBnkvL2DxxMKfVJoYXQ@mail.gmail.com>
Subject: Re: [PATCH] mtd: onenand: prevent memory leak in onenand_scan
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Miquel for pointing that out. v2 was sent.

Thank you,
Navid.

On Fri, Oct 4, 2019 at 10:57 AM Miquel Raynal <miquel.raynal@bootlin.com> w=
rote:
>
> Hi Navid,
>
> Navid Emamdoost <navid.emamdoost@gmail.com> wrote on Mon, 30 Sep 2019
> 16:37:17 -0500:
>
> > Would you please take a look at this patch?
> >
> > On Wed, Sep 25, 2019 at 10:43 AM Navid Emamdoost
> > <navid.emamdoost@gmail.com> wrote:
> > >
> > > In onenand_scan if scan_bbt fails the allocated buffers should be
> > > released.
> > >
> > > Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> > > ---
> > >  drivers/mtd/nand/onenand/onenand_base.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/mtd/nand/onenand/onenand_base.c b/drivers/mtd/na=
nd/onenand/onenand_base.c
> > > index 77bd32a683e1..79c01f42925a 100644
> > > --- a/drivers/mtd/nand/onenand/onenand_base.c
> > > +++ b/drivers/mtd/nand/onenand/onenand_base.c
> > > @@ -3977,8 +3977,11 @@ int onenand_scan(struct mtd_info *mtd, int max=
chips)
> > >         this->badblockpos =3D ONENAND_BADBLOCK_POS;
> > >
> > >         ret =3D this->scan_bbt(mtd);
> > > -       if ((!FLEXONENAND(this)) || ret)
> > > +       if ((!FLEXONENAND(this)) || ret) {
> > > +               kfree(this->page_buf);
>
> Apparently you missed:
>
> #ifdef CONFIG_MTD_ONENAND_VERIFY_WRITE
>         kfree(this->verify_buf);
> #endif
>
> > > +               kfree(this->oob_buf);
> > >                 return ret;
> > > +       }
> > >
> > >         /* Change Flex-OneNAND boundaries if required */
> > >         for (i =3D 0; i < MAX_DIES; i++)
> > > --
> > > 2.17.1
> > >
> >
> >
>
> Thanks,
> Miqu=C3=A8l



--=20
Navid.
