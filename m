Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B0EC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 13:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B88AA216C4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 13:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbfEJNxq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 09:53:46 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:54965 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbfEJNxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 09:53:46 -0400
X-Originating-IP: 90.88.28.253
Received: from xps13 (aaubervilliers-681-1-86-253.w90-88.abo.wanadoo.fr [90.88.28.253])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id D5D0A240011;
        Fri, 10 May 2019 13:53:41 +0000 (UTC)
Date:   Fri, 10 May 2019 15:53:40 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Mason Yang <masonccyang@mxic.com.tw>, bbrezillon@kernel.org,
        marek.vasut@gmail.com, linux-kernel@vger.kernel.org,
        richard@nod.at, dwmw2@infradead.org, computersforpeace@gmail.com,
        linux-mtd@lists.infradead.org, juliensu@mxic.com.tw
Subject: Re: [PATCH v1] mtd: rawnand: Add Macronix NAND read retry support
Message-ID: <20190510155340.1130487f@xps13>
In-Reply-To: <20190510153704.33de9568@windsurf.home>
References: <1557474062-4949-1-git-send-email-masonccyang@mxic.com.tw>
        <20190510153704.33de9568@windsurf.home>
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

Thomas Petazzoni <thomas.petazzoni@bootlin.com> wrote on Fri, 10 May
2019 15:37:04 +0200:

> Hello,
> 
> Some purely cosmetic suggestions below.
> 
> On Fri, 10 May 2019 15:41:02 +0800
> Mason Yang <masonccyang@mxic.com.tw> wrote:
> 
> > +	if (ret)
> > +		pr_err("set feature failed to read retry moded:%d\n", mode);    
> 
> I don't know what is the policy in the MTD/NAND subsystem, but
> shouldn't you be using dev_err() instead of pr_err() here to have a
> nice prefix for the message ?
> 
> 		dev_err(&nand_to_mtd(chip)->dev, "set feature ..", mode);

Indeed. You can even dereference an mtd_info object first, then use
mtd->dev.

> 
> > +static void macronix_nand_onfi_init(struct nand_chip *chip)
> > +{
> > +	struct nand_parameters *p = &chip->parameters;
> > +
> > +	if (p->onfi) {  
> 
> Change to:
> 
> 	if (!p->onfi)
> 		return;
> 
> This way the rest of the function can save one level of indentation.
> 
> > +		struct nand_onfi_vendor_macronix *mxic =
> > +				(void *)p->onfi->vendor;
> > +
> > +		if (mxic->reliability_func & MACRONIX_READ_RETRY_BIT) {  
> 
> Change to:
> 
> 	if (mxic->reliability_func & MACRONIX_READ_RETRY_BIT == 0)
> 		return;
> 
> And the rest of the function can save one level of indentation.
> 
> > +			chip->read_retries = MACRONIX_READ_RETRY_MODE + 1;
> > +			chip->setup_read_retry =
> > +				 macronix_nand_setup_read_retry;
> > +			if (p->supports_set_get_features) {
> > +				set_bit(ONFI_FEATURE_ADDR_READ_RETRY,
> > +					p->set_feature_list);
> > +				set_bit(ONFI_FEATURE_ADDR_READ_RETRY,
> > +					p->get_feature_list);
> > +			}  
> 
> Which will require less wrapping in those lines that are already at the
> third indentation level.
> 
> To me, it is also more logical: we exclude the cases we are not
> interested in and return early, and then if we are still in the case we
> are interested, we handle it.

I definitely agree with these cosmetic changes.

Thanks,
Miquèl
