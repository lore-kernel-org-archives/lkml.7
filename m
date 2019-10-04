Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A39C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E27DE207FF
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390146AbfJDP5r convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 11:57:47 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:43839 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389954AbfJDP5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 11:57:46 -0400
X-Originating-IP: 93.23.105.117
Received: from xps13 (117.105.23.93.rev.sfr.net [93.23.105.117])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 5BDA1240007;
        Fri,  4 Oct 2019 15:57:42 +0000 (UTC)
Date:   Fri, 4 Oct 2019 17:57:40 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Navid Emamdoost <emamd001@umn.edu>, kjlu@umn.edu,
        Stephen McCamant <smccaman@umn.edu>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: onenand: prevent memory leak in onenand_scan
Message-ID: <20191004175740.5dd84c38@xps13>
In-Reply-To: <CAEkB2ETTmCsuOFDsJQ8LbBPHNgckpDFn2XhVePwAQEsCRsJo6g@mail.gmail.com>
References: <20190925154302.17708-1-navid.emamdoost@gmail.com>
        <CAEkB2ETTmCsuOFDsJQ8LbBPHNgckpDFn2XhVePwAQEsCRsJo6g@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Navid,

Navid Emamdoost <navid.emamdoost@gmail.com> wrote on Mon, 30 Sep 2019
16:37:17 -0500:

> Would you please take a look at this patch?
> 
> On Wed, Sep 25, 2019 at 10:43 AM Navid Emamdoost
> <navid.emamdoost@gmail.com> wrote:
> >
> > In onenand_scan if scan_bbt fails the allocated buffers should be
> > released.
> >
> > Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> > ---
> >  drivers/mtd/nand/onenand/onenand_base.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mtd/nand/onenand/onenand_base.c b/drivers/mtd/nand/onenand/onenand_base.c
> > index 77bd32a683e1..79c01f42925a 100644
> > --- a/drivers/mtd/nand/onenand/onenand_base.c
> > +++ b/drivers/mtd/nand/onenand/onenand_base.c
> > @@ -3977,8 +3977,11 @@ int onenand_scan(struct mtd_info *mtd, int maxchips)
> >         this->badblockpos = ONENAND_BADBLOCK_POS;
> >
> >         ret = this->scan_bbt(mtd);
> > -       if ((!FLEXONENAND(this)) || ret)
> > +       if ((!FLEXONENAND(this)) || ret) {
> > +               kfree(this->page_buf);

Apparently you missed:

#ifdef CONFIG_MTD_ONENAND_VERIFY_WRITE
        kfree(this->verify_buf);
#endif

> > +               kfree(this->oob_buf);
> >                 return ret;
> > +       }
> >
> >         /* Change Flex-OneNAND boundaries if required */
> >         for (i = 0; i < MAX_DIES; i++)
> > --
> > 2.17.1
> >  
> 
> 

Thanks,
Miquèl
