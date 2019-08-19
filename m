Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC315C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 17:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8779922CE9
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 17:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbfHSREd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 13:04:33 -0400
Received: from ajax.cs.uga.edu ([128.192.4.6]:55394 "EHLO ajax.cs.uga.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726879AbfHSREd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 13:04:33 -0400
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
        (authenticated bits=0)
        by ajax.cs.uga.edu (8.14.4/8.14.4) with ESMTP id x7JH4UPt024745
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 13:04:31 -0400
Received: by mail-lf1-f53.google.com with SMTP id j17so1939286lfp.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 10:04:31 -0700 (PDT)
X-Gm-Message-State: APjAAAXqAhBRSIC3pIkbNEbY8HtO5Fx2jm8C23ISAzb+hpmycrC08i1c
        uLGDlu4vZXjVELZeGZvvs6mpJjcqiGAvmAJAjO8=
X-Google-Smtp-Source: APXvYqz0CsDKhWLNGlfpj78P2CP6D94gX7ot0fBFsR3ju2fwmXEgDiy86CgTCeVqq2XiGXOFVsehNclp+9E/5SALqRU=
X-Received: by 2002:ac2:442d:: with SMTP id w13mr13604474lfl.184.1566234269783;
 Mon, 19 Aug 2019 10:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <1566149993-2748-1-git-send-email-wenwen@cs.uga.edu> <e52a548a-0516-55ee-4005-5cc24c3a20b5@microchip.com>
In-Reply-To: <e52a548a-0516-55ee-4005-5cc24c3a20b5@microchip.com>
From:   Wenwen Wang <wenwen@cs.uga.edu>
Date:   Mon, 19 Aug 2019 13:03:53 -0400
X-Gmail-Original-Message-ID: <CAAa=b7cnsmMNPo+WCBtfKemP6G=Aau5SQBmDyFv-LuTdx5eeCw@mail.gmail.com>
Message-ID: <CAAa=b7cnsmMNPo+WCBtfKemP6G=Aau5SQBmDyFv-LuTdx5eeCw@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: fix a memory leak bug
To:     Tudor Ambarus <Tudor.Ambarus@microchip.com>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "open list:NAND FLASH SUBSYSTEM" <linux-mtd@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Wenwen Wang <wenwen@cs.uga.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 2:03 AM <Tudor.Ambarus@microchip.com> wrote:
>
>
>
> On 08/18/2019 08:39 PM, Wenwen Wang wrote:
> > In spi_nor_parse_4bait(), 'dwords' is allocated through kmalloc(). However,
> > it is not deallocated in the following execution if spi_nor_read_sfdp()
> > fails, leading to a memory leak. To fix this issue, free 'dwords' before
> > returning the error.
>
> Looks good. Would you add a Fixes tag?

Sure, I will add the Fixes tag and resubmit the patch. Thanks!

Wenwen

> >
> > Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
> > ---
> >  drivers/mtd/spi-nor/spi-nor.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> > index 03cc788..a41a466 100644
> > --- a/drivers/mtd/spi-nor/spi-nor.c
> > +++ b/drivers/mtd/spi-nor/spi-nor.c
> > @@ -3453,7 +3453,7 @@ static int spi_nor_parse_4bait(struct spi_nor *nor,
> >       addr = SFDP_PARAM_HEADER_PTP(param_header);
> >       ret = spi_nor_read_sfdp(nor, addr, len, dwords);
> >       if (ret)
> > -             return ret;
> > +             goto out;
> >
> >       /* Fix endianness of the 4BAIT DWORDs. */
> >       for (i = 0; i < SFDP_4BAIT_DWORD_MAX; i++)
> >
