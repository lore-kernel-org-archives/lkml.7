Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D3DC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 09:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D349620850
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 09:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfEJJMp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 05:12:45 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:54219 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbfEJJMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 05:12:44 -0400
X-Originating-IP: 90.88.28.253
Received: from xps13 (aaubervilliers-681-1-86-253.w90-88.abo.wanadoo.fr [90.88.28.253])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id BCECA6000B;
        Fri, 10 May 2019 09:12:37 +0000 (UTC)
Date:   Fri, 10 May 2019 11:12:36 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     masonccyang@mxic.com.tw
Cc:     bbrezillon@kernel.org, computersforpeace@gmail.com,
        dwmw2@infradead.org, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        marek.vasut@gmail.com, richard@nod.at
Subject: Re: [PATCH v1] mtd: rawnand: Add Macronix NAND read retry support
Message-ID: <20190510111121.54f42e70@xps13>
In-Reply-To: <OF5E2BF75D.98A43E33-ON482583F6.002E7A65-482583F6.0030A2DE@mxic.com.tw>
References: <1557474062-4949-1-git-send-email-masonccyang@mxic.com.tw>
        <20190510094528.6008e8da@xps13>
        <OF5E2BF75D.98A43E33-ON482583F6.002E7A65-482583F6.0030A2DE@mxic.com.tw>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mason,

masonccyang@mxic.com.tw wrote on Fri, 10 May 2019 16:51:20 +0800:

> Hi Miquel,
> 
> 
> > > Add a driver for Macronix NAND read retry.  
> > 
> > "Add support for Macronix NAND read retry."? This is not a "new driver".
> >   
> > > 
> > > Macronix NAND supports specfical read for data recovery and enabled  
> > 
> > 
> > Macronix NANDs support specific read operation for data recovery,
> > which can be enabled with a SET_FEATURE.
> >   
> > > Driver check byte 167 of Vendor Blocks in ONFI parameter page table  
> > 
> >          checks
> >   
> > > to see if this high reliability function is support or not.  
> > 
> >                  high-reliability function? not sure it is English
> >                  anyway.
> > 
> >                                               supported
> >   
> 
> okay, thanks for your review, will patch it to:
> ------------------------------------------------------------------------
> Add support for Macronix NAND read retry.
> 
> Macronix NANDs support specific read operation for data recovery,
> which can be enabled with a SET_FEATURE.
> Driver checks byte 167 of Vendor Blocks in ONFI parameter page table
> to see if this high-reliability function is supported.
> -------------------------------------------------------------------------

Fine by me.

[...]

> > > +   int ret;
> > > +
> > > +   if (mode > MACRONIX_READ_RETRY_MODE)
> > > +      mode = MACRONIX_READ_RETRY_MODE;
> > > +
> > > +   feature[0] = mode;
> > > +   ret =  nand_set_features(chip, ONFI_FEATURE_ADDR_READ_RETRY,   
> feature);
> > 
> > Don't you miss to select/deselect the target?  
> 
> nand_select_target() and nand_deselect_target() are already in 
> nand_do_read_ops().

Right

> 
> >   
> > > +   if (ret)
> > > +      pr_err("set feature failed to read retry moded:%d\n", mode);  
> > 
> >                        "Failed to set read retry mode: %d\n"
> > 
> > I think you can abort the operation with a negative return code in this
> > case.
> >   
> 
> After set feature operation, this NAND device need a get feature command 

You need to add a comment for this.

> or
> SW reset command to exit read retry mode.
> Therefore, set features command followed by get feature command is needed.

In this case you must check first that both set and get are supported.

> 
> > > +
> > > +   ret =  nand_get_features(chip, ONFI_FEATURE_ADDR_READ_RETRY,   
> feature);
> > 
> > If the operation succeeded but the controller cannot get the feature
> > you don't want to abort the operation. You should check if get_features
> > is supported, if yes you can rely on the below test.
> >   
> 
> I thought it has been check in macronix_nand_onfi_init() and set by
> set_bit(ONFI_FEATURE_ADDR_READ_RETRY, p->get_feature_list);

You only checked that the operation can be done, you cannot know in
advance if it will actually succeed.

> 
> right ?
> 
> > > +   if (ret || feature[0] != mode)
> > > +      pr_err("get feature failed to read retry moded:%d(%d)\n",
> > > +             mode, feature[0]);  
> > 
> >                        "Failed to verify read retry mode..."
> > 
> >                 Also return something negative here.
> >   
> > > +
> > > +   return ret;  
> > 
> > And if all went right, return 0 at the end.
> >   
> > > +}
> > > +
> > > +static void macronix_nand_onfi_init(struct nand_chip *chip)
> > > +{
> > > +   struct nand_parameters *p = &chip->parameters;
> > > +
> > > +   if (p->onfi) {
> > > +      struct nand_onfi_vendor_macronix *mxic =
> > > +            (void *)p->onfi->vendor;  
> > 
> > Please put everything on the same line  
> 
> It will over 80 char.

I know, that's fine here.

> 
> >   
> > > +
> > > +      if (mxic->reliability_func & MACRONIX_READ_RETRY_BIT) {
> > > +         chip->read_retries = MACRONIX_READ_RETRY_MODE + 1;  
> > 
> > Why +1 here, I am missing something?  
> 
>  
> Without + 1, read retry mode is up to 4 rather than 5.
> But this NAND device support read retry mode up to 5.
> 

If there are 5 modes, you need to set 5 to chip->read_retries, not 6.

If only 4 modes are used, there is probably a bug in the core that
must be fixed, please do not workaround it in the driver!


Thanks,
Miquèl
