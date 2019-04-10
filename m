Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14F4C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C864B2077C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbfDJJP2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 05:15:28 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:37561 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbfDJJP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 05:15:28 -0400
Received: from xps13 (aaubervilliers-681-1-63-121.w90-88.abo.wanadoo.fr [90.88.18.121])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 9ABAA10000A;
        Wed, 10 Apr 2019 09:15:22 +0000 (UTC)
Date:   Wed, 10 Apr 2019 11:15:21 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     masonccyang@mxic.com.tw
Cc:     bbrezillon@kernel.org,
        "Boris Brezillon" <boris.brezillon@collabora.com>,
        computersforpeace@gmail.com, dwmw2@infradead.org,
        juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, marek.vasut@gmail.com,
        richard@nod.at, zhengxunli@mxic.com.tw
Subject: Re: [PATCH] mtd: rawnand: Add Macronix NAND read retry and
 randomizer support
Message-ID: <20190410111521.026c7010@xps13>
In-Reply-To: <OF37AF39D0.77A1B5F5-ON482583D8.002E12E6-482583D8.002FA5B1@mxic.com.tw>
References: <1554780172-23111-1-git-send-email-masonccyang@mxic.com.tw>
        <20190409090427.22de9917@collabora.com>
        <OF6C97E4DE.45261545-ON482583D7.00340468-482583D7.0034B3FE@mxic.com.tw>
        <20190409114701.744c2c8c@collabora.com>
        <OF9601E14B.A48284C4-ON482583D8.0005E3EB-482583D8.0006CC14@mxic.com.tw>
        <20190410091612.229c91b4@xps13>
        <OF37AF39D0.77A1B5F5-ON482583D8.002E12E6-482583D8.002FA5B1@mxic.com.tw>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi masonccyang@mxic.com.tw,

masonccyang@mxic.com.tw wrote on Wed, 10 Apr 2019 16:40:25 +0800:

> Hi Miquel,
>  
> > > > 
> > > > Re: [PATCH] mtd: rawnand: Add Macronix NAND read retry and   
> randomizer 
> > > support  
> > > > 
> > > > On Tue, 9 Apr 2019 17:35:39 +0800
> > > > masonccyang@mxic.com.tw wrote:
> > > >   
> > > > > > > +
> > > > > > > +static const struct kobj_attribute sysfs_mxic_nand =
> > > > > > > +   __ATTR(nand_random, S_IRUGO | S_IWUSR,
> > > > > > > +          mxic_nand_rand_type_show,
> > > > > > > +          mxic_nand_rand_type_store);   
> > > > > > 
> > > > > > No, we don't want to expose that through a sysfs file,   
> especially 
> > > since  
> > > > > > changing the randomizer config means making the NAND unreadable   
> for
> > > > > > those that have used it before the change.
> > > > > >   
> > > > > 
> > > > > Our on-die randomizer is still readable from user after the   
> function 
> > > > > is enabled.   
> > > > 
> > > > You mean the memory is still readable no matter the randomizer   
> state.
> > > > Not sure how that's possible, but okay.  
> > 
> > So if you write non-randomized data to the NAND chip, then enable the
> > randomizer en read back the data, all will be ok?  

s/en/and/

> 
> yes !

I don't understand how this is possible. Have you tried it yourself?

Can you explain how this is supposed to work?

> 
> > 
> > And if randomized data is written to the NAND chip and we disable the
> > randomizer, then the data will also be correct?
> >   
> 
> Enable randomizer is a OTP(One-Time-Program) bit and can't be erased 
> again!
> That means never disable it once it has been enabled.
> 
> > > >   
> > > > > This randomizer is just like a internal memory cell 
> > > > > reliability enhanced.   
> > > > 
> > > > Why don't you enable it by default then?   
> > > 
> > > The penalty of randomizer is read/write performance down.
> > > i.e,. tPROG 300 us to 340 us (randomizer enable)
> > > therefore, disable it by default.  
> > 
> > Is this info somewhere in the ONFI param page? I suppose once
> > randomization is enabled we should also tweak the timings and verify
> > that the controller supports it.  
> 
> yes, it is in ONFI param page@Byte# 167 of bit 1 (Vendor Blocks 
> starting@Byte# 164).
> 
> +#define ONFI_FEATURE_ADDR_MXIC_RANDOMIZER 0xB0
> +
> +struct nand_onfi_vendor_macronix {
> +                u8 reserved[1];
> +                u8 reliability_func;
> +} __packed;
> 
> 
> in addition, enable randomizer has no any impact on timing of tRC, tRP, 
> tWC and so on.
> host driver just need to check the status pin of RY/#BY as like standard
> read/write operation flow.
> 
> thanks & best regards,
> Mason
> 


Thanks,
Miquèl
