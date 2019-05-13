Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B5DC04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D07D620989
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbfEMJ7d convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 05:59:33 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:48781 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbfEMJ7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 05:59:33 -0400
X-Originating-IP: 77.154.224.5
Received: from xps13 (5.224.154.77.rev.sfr.net [77.154.224.5])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id A2A7F6000D;
        Mon, 13 May 2019 09:59:28 +0000 (UTC)
Date:   Mon, 13 May 2019 11:59:26 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     masonccyang@mxic.com.tw
Cc:     bbrezillon@kernel.org, computersforpeace@gmail.com,
        dwmw2@infradead.org, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        marek.vasut@gmail.com, richard@nod.at
Subject: Re: [PATCH v1] mtd: rawnand: Add Macronix NAND read retry support
Message-ID: <20190513115926.3e862566@xps13>
In-Reply-To: <OF3A216E48.80ABBB8A-ON482583F9.002A09DA-482583F9.002AD40E@mxic.com.tw>
References: <1557474062-4949-1-git-send-email-masonccyang@mxic.com.tw>
        <20190510094528.6008e8da@xps13>
        <OF5E2BF75D.98A43E33-ON482583F6.002E7A65-482583F6.0030A2DE@mxic.com.tw>
        <20190510111121.54f42e70@xps13>
        <OF3A216E48.80ABBB8A-ON482583F9.002A09DA-482583F9.002AD40E@mxic.com.tw>
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

masonccyang@mxic.com.tw wrote on Mon, 13 May 2019 15:47:53 +0800:

> Hi Miquel,
> 
> 
> > >   
> > > >   
> > > > > +   if (ret)
> > > > > +      pr_err("set feature failed to read retry moded:%d\n",   
> mode); 
> > > > 
> > > >                        "Failed to set read retry mode: %d\n"
> > > > 
> > > > I think you can abort the operation with a negative return code in   
> this
> > > > case.
> > > >   
> > > 
> > > After set feature operation, this NAND device need a get feature   
> command 
> > 
> > You need to add a comment for this.  
> 
> okay, will add this comment by next version.
> 
> >   
> > > or
> > > SW reset command to exit read retry mode.
> > > Therefore, set features command followed by get feature command is   
> needed.
> > 
> > In this case you must check first that both set and get are supported.
> >   
> 
> okay, thanks.
> 
> 
> > > > > +
> > > > > +      if (mxic->reliability_func & MACRONIX_READ_RETRY_BIT) {
> > > > > +         chip->read_retries = MACRONIX_READ_RETRY_MODE + 1;   
> > > > 
> > > > Why +1 here, I am missing something?   
> > > 
> > > 
> > > Without + 1, read retry mode is up to 4 rather than 5.
> > > But this NAND device support read retry mode up to 5.
> > >   
> > 
> > If there are 5 modes, you need to set 5 to chip->read_retries, not 6.
> > 
> > If only 4 modes are used, there is probably a bug in the core that
> > must be fixed, please do not workaround it in the driver!  
> 
> 
> It seems some patches is needed in nand_base.c
> -------------------------------------------------------------------------------------
> diff --git a/drivers/mtd/nand/raw/nand_base.c 
> b/drivers/mtd/nand/raw/nand_base.c
> index ddd396e..56be3a9 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -3101,7 +3101,8 @@ static int nand_setup_read_retry(struct nand_chip 
> *chip, int retry_mode)
>  {
>         pr_debug("setting READ RETRY mode %d\n", retry_mode);
> 
> -       if (retry_mode >= chip->read_retries)
> +       if (retry_mode > chip->read_retries)

If I understand correctly, chip->read_retries is the total number of
'modes' so the last valid mode is indeed chip->read_retries -1.

I thought the problem would come from the core but I was wrong, you
actually need a MACRONIX_NUM_READ_RETRY_MODES set to 6. Please have two
defines if you need both (the first one being something like
MACRONIX_MAXIMUM_READ_RETRY_MODE set to 5).


Thanks,
Miquèl
