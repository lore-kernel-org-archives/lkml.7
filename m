Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38221C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 181B4208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392974AbfETRem convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 13:34:42 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:58555 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392771AbfETRem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:34:42 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id E76121C0002;
        Mon, 20 May 2019 17:34:36 +0000 (UTC)
Date:   Mon, 20 May 2019 19:34:32 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>
Cc:     MTD Maling List <linux-mtd@lists.infradead.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 2/2] mtd: nand: raw: brcmnand: fallback to detected
 ecc-strength, ecc-step-size
Message-ID: <20190520193432.79cf132f@xps13>
In-Reply-To: <CAC=U0a0bZHgM2yQzz5SupRNWcBg7rpqpGh_o9cvSQNNKsSp9Cg@mail.gmail.com>
References: <1558117914-35807-1-git-send-email-kdasu.kdev@gmail.com>
        <1558117914-35807-2-git-send-email-kdasu.kdev@gmail.com>
        <20190520144436.67e42f00@xps13>
        <CAC=U0a0bZHgM2yQzz5SupRNWcBg7rpqpGh_o9cvSQNNKsSp9Cg@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kamal,

Kamal Dasu <kdasu.kdev@gmail.com> wrote on Mon, 20 May 2019 13:31:52
-0400:

> Will make the changes and send a V2 patch.
> 
> On Mon, May 20, 2019 at 8:44 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >
> > Hi Kamal,
> >
> > Kamal Dasu <kdasu.kdev@gmail.com> wrote on Fri, 17 May 2019 14:29:55
> > -0400:
> >  
> > > This change supports nand-ecc-step-size and nand-ecc-strenght fields in  
> >
> >                                                        strength
> >  
> > > brcmnand dt node to be  optional.  
> >
> >            DT            ^ extra space
> >  
> > > see: Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt
> > >
> > > If both nand-ecc-strength and nand-ecc-step-size are not specified in
> > > device tree node for NAND, nand_base driver does detect onfi ext ecc  
> >
> > s/nand_base driver/the raw NAND layer/
> > s/onfi/ONFI/
> > s/ecc/ECC/
> >
> > What is "ext"? Please use plain English here.
> >  
> > > info from ONFI extended parameter page for parts using ONFI >= 2.1. In  
> >
> > s/info/information/
> >  
> > > case of non-onfi NAND there could be a nand_id table entry with the ecc  
> >
> > s/ecc/ECC/
> >  
> > > info. If there is a valid  device tree entry for nand-ecc-strength and
> > > nand-ecc-step-size fields it still shall override the detected values.
> > >
> > > Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> > > ---
> > >  drivers/mtd/nand/raw/brcmnand/brcmnand.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> > > index ce0b8ff..e967b30 100644
> > > --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> > > +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> > > @@ -2144,6 +2144,16 @@ static int brcmnand_setup_dev(struct brcmnand_host *host)
> > >               return -EINVAL;
> > >       }
> > >
> > > +     if (!(chip->ecc.size > 0 && chip->ecc.strength > 0) &&  
> >
> > Is the case where only size OR strength is valid handled?  
> 
> Both strength and need to be valid, else the driver will behave like
> before and will fail the probe.

Yes, but you do not handle the case when either strength OR size is not
valid but the other one is. Is it one purpose?

> 
> >  
> > > +         (chip->base.eccreq.strength > 0 &&
> > > +          chip->base.eccreq.step_size > 0)) {
> > > +             /* use detected ecc parameters */  
> >
> >                    Use          ECC
> >  
> > > +             chip->ecc.size = chip->base.eccreq.step_size;
> > > +             chip->ecc.strength = chip->base.eccreq.strength;
> > > +             pr_info("Using detected nand-ecc-step-size %d, nand-ecc-strength %d\n",
> > > +                     chip->ecc.size, chip->ecc.strength);
> > > +     }
> > > +
> > >       switch (chip->ecc.size) {
> > >       case 512:
> > >               if (chip->ecc.algo == NAND_ECC_HAMMING)  
> >
> >
> > Thanks,
> > Miquèl  
> 
> Kamal




Thanks,
Miquèl
