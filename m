Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562C7C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 07:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 313902084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 07:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbfDJHQT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 03:16:19 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:45527 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbfDJHQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 03:16:18 -0400
X-Originating-IP: 90.88.18.121
Received: from xps13 (aaubervilliers-681-1-63-121.w90-88.abo.wanadoo.fr [90.88.18.121])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id B6D7EFF808;
        Wed, 10 Apr 2019 07:16:13 +0000 (UTC)
Date:   Wed, 10 Apr 2019 09:16:12 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     masonccyang@mxic.com.tw
Cc:     "Boris Brezillon" <boris.brezillon@collabora.com>,
        bbrezillon@kernel.org, computersforpeace@gmail.com,
        dwmw2@infradead.org, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        marek.vasut@gmail.com, richard@nod.at, zhengxunli@mxic.com.tw
Subject: Re: [PATCH] mtd: rawnand: Add Macronix NAND read retry and
 randomizer support
Message-ID: <20190410091612.229c91b4@xps13>
In-Reply-To: <OF9601E14B.A48284C4-ON482583D8.0005E3EB-482583D8.0006CC14@mxic.com.tw>
References: <1554780172-23111-1-git-send-email-masonccyang@mxic.com.tw>
        <20190409090427.22de9917@collabora.com>
        <OF6C97E4DE.45261545-ON482583D7.00340468-482583D7.0034B3FE@mxic.com.tw>
        <20190409114701.744c2c8c@collabora.com>
        <OF9601E14B.A48284C4-ON482583D8.0005E3EB-482583D8.0006CC14@mxic.com.tw>
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

masonccyang@mxic.com.tw wrote on Wed, 10 Apr 2019 09:14:14 +0800:

> Hi Boris,
> 
> > 
> > Subject
> > 
> > Re: [PATCH] mtd: rawnand: Add Macronix NAND read retry and randomizer   
> support
> > 
> > On Tue, 9 Apr 2019 17:35:39 +0800
> > masonccyang@mxic.com.tw wrote:
> >   
> > > > > +
> > > > > +static const struct kobj_attribute sysfs_mxic_nand =
> > > > > +   __ATTR(nand_random, S_IRUGO | S_IWUSR,
> > > > > +          mxic_nand_rand_type_show,
> > > > > +          mxic_nand_rand_type_store);   
> > > > 
> > > > No, we don't want to expose that through a sysfs file, especially   
> since
> > > > changing the randomizer config means making the NAND unreadable for
> > > > those that have used it before the change.
> > > >   
> > > 
> > > Our on-die randomizer is still readable from user after the function 
> > > is enabled.  
> > 
> > You mean the memory is still readable no matter the randomizer state.
> > Not sure how that's possible, but okay.

So if you write non-randomized data to the NAND chip, then enable the
randomizer en read back the data, all will be ok?

And if randomized data is written to the NAND chip and we disable the
randomizer, then the data will also be correct?

> >   
> > > This randomizer is just like a internal memory cell 
> > > reliability enhanced.  
> > 
> > Why don't you enable it by default then?  
> 
> The penalty of randomizer is read/write performance down.
> i.e,. tPROG 300 us to 340 us (randomizer enable)
> therefore, disable it by default.

Is this info somewhere in the ONFI param page? I suppose once
randomization is enabled we should also tweak the timings and verify
that the controller supports it.

> > > It could be enable at any time with OTP bit function and that's why
> > > we patch it by sys-fs.  
> > 
> > Sorry, but that's not a good reason to expose that through sysfs.  
> 
> Any good way to expose randomizer function for user ?
> 
> thanks & best regards,
> Mason
> 

Thanks,
Miquèl
