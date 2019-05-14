Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0942C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 07:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B99332086A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 07:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfENHlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 03:41:11 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:35255 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfENHlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 03:41:11 -0400
X-Originating-IP: 80.12.43.150
Received: from windsurf.home (unknown [80.12.43.150])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 6019D4000C;
        Tue, 14 May 2019 07:41:01 +0000 (UTC)
Date:   Tue, 14 May 2019 09:41:00 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     masonccyang@mxic.com.tw
Cc:     bbrezillon@kernel.org, computersforpeace@gmail.com,
        dwmw2@infradead.org, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        marek.vasut@gmail.com, miquel.raynal@bootlin.com, richard@nod.at
Subject: Re: [PATCH v1] mtd: rawnand: Add Macronix NAND read retry support
Message-ID: <20190514094100.34d2a6ba@windsurf.home>
In-Reply-To: <OFB5D53BFC.6B44E7E0-ON482583FA.00090982-482583FA.000A5E93@mxic.com.tw>
References: <1557474062-4949-1-git-send-email-masonccyang@mxic.com.tw>
        <20190510153704.33de9568@windsurf.home>
        <OF1EDBA487.7723094D-ON482583F9.00297ABF-482583F9.0029E3EE@mxic.com.tw>
        <20190513114059.3934b0bb@windsurf.home>
        <OFB5D53BFC.6B44E7E0-ON482583FA.00090982-482583FA.000A5E93@mxic.com.tw>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, 14 May 2019 09:53:16 +0800
masonccyang@mxic.com.tw wrote:

> > > -------------------------------------------------------------------
> > >  static void macronix_nand_onfi_init(struct nand_chip *chip)
> > >  {
> > >           struct nand_parameters *p = &chip->parameters;
> > >           struct nand_onfi_vendor_macronix *mxic = (void 
> > > *)p->onfi->vendor;  
> > 
> > Why cast to void*, instead of casting directly to struct
> > nand_onfi_vendor_macronix * ?  
> 
> Due to got a warning:
> 
>  warning: initialization from incompatible pointer type
>   struct nand_onfi_vendor_macronix *mxic = p->onfi->vendor;

You didn't look at my code, I suggested:

	mxic = (struct nand_onfi_vendor_macronix *) p->info->vendor;

I.e, you indeed still need a cast, because p->info->vendor is a u8[].
But instead of casting to void*, and then implicitly casting to struct
nand_onfi_vendor_macronix *, I suggest to cast directly to struct
nand_onfi_vendor_macronix *.

> > >           if (!p->onfi ||
> > >               ((mxic->reliability_func & MACRONIX_READ_RETRY_BIT) ==   
> 0))
> > >                   return;  
> > 
> > So, the code should be:
> > 
> >    struct nand_onfi_vendor_macronix *mxic;
> > 
> >    if (!p->onfi)
> >       return;
> > 
> >    mxic = (struct nand_onfi_vendor_macronix *) p->info->vendor;
> > 
> >    if ((mxic->reliability_func & MACRONIX_READ_RETRY_BIT) == 0)
> >       return;  
> 
> Also got a warning:
> 
> warning: ISO C90 forbids mixed declarations and code 
> [-Wdeclaration-after-statement]

No, you don't get this warning if you use my code. You get this warning
if you declare and initialized the "mxic" variable at the same location.

>  static void macronix_nand_onfi_init(struct nand_chip *chip)
>  {
>          struct nand_parameters *p = &chip->parameters;
>          struct nand_onfi_vendor_macronix *mxic = (void *)p->onfi->vendor;

You are dereferencing p->info...

> 
>          if (!p->onfi)
>                  return;

... before you check it is NULL. This is wrong.

Please check again the code I sent in my previous e-mail:

    struct nand_onfi_vendor_macronix *mxic;
 
    if (!p->onfi)
       return;
 
    mxic = (struct nand_onfi_vendor_macronix *) p->info->vendor;
 
    if ((mxic->reliability_func & MACRONIX_READ_RETRY_BIT) == 0)
       return;  

Best regards,

Thomas Petazzoni
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
