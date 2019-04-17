Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2EDC10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 452D120675
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731122AbfDQHIX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 03:08:23 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:45777 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728261AbfDQHIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 03:08:23 -0400
X-Originating-IP: 90.88.160.238
Received: from xps13 (aaubervilliers-681-1-42-238.w90-88.abo.wanadoo.fr [90.88.160.238])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id C2AD0E0014;
        Wed, 17 Apr 2019 07:08:18 +0000 (UTC)
Date:   Wed, 17 Apr 2019 09:08:17 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     masonccyang@mxic.com.tw
Cc:     "Boris Brezillon" <boris.brezillon@collabora.com>,
        bbrezillon@kernel.org, computersforpeace@gmail.com,
        dwmw2@infradead.org, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        marek.vasut@gmail.com, richard@nod.at, zhengxunli@mxic.com.tw
Subject: Re: [PATCH] mtd: rawnand: Add Macronix NAND read retry and
 randomizer support
Message-ID: <20190417090817.7a0c4638@xps13>
In-Reply-To: <OF84BD5411.301E92AC-ON482583DF.000CC3CC-482583DF.000F4920@mxic.com.tw>
References: <1554780172-23111-1-git-send-email-masonccyang@mxic.com.tw>
        <20190409090427.22de9917@collabora.com>
        <OF6C97E4DE.45261545-ON482583D7.00340468-482583D7.0034B3FE@mxic.com.tw>
        <20190409114701.744c2c8c@collabora.com>
        <OF9601E14B.A48284C4-ON482583D8.0005E3EB-482583D8.0006CC14@mxic.com.tw>
        <20190410092258.332ef399@collabora.com>
        <OF071D3608.9D6D2523-ON482583D9.00173F52-482583D9.0018188C@mxic.com.tw>
        <20190411085353.4c1af008@collabora.com>
        <OF34672B6F.AACFE22C-ON482583D9.00335814-482583D9.0033A673@mxic.com.tw>
        <20190411112943.1fecfa69@collabora.com>
        <OF84BD5411.301E92AC-ON482583DF.000CC3CC-482583DF.000F4920@mxic.com.tw>
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

masonccyang@mxic.com.tw wrote on Wed, 17 Apr 2019 10:46:57 +0800:

> Hi Boris,
>  
>  
> > > > > > > > Subject
> > > > > > > > 
> > > > > > > > Re: [PATCH] mtd: rawnand: Add Macronix NAND read retry and   
> > > > > randomizer   
> > > > > > > support   
> > > > > > > > 
> > > > > > > > On Tue, 9 Apr 2019 17:35:39 +0800
> > > > > > > > masonccyang@mxic.com.tw wrote:
> > > > > > > >   
> > > > > > > > > > > +
> > > > > > > > > > > +static const struct kobj_attribute sysfs_mxic_nand =
> > > > > > > > > > > +   __ATTR(nand_random, S_IRUGO | S_IWUSR,
> > > > > > > > > > > +          mxic_nand_rand_type_show,
> > > > > > > > > > > +          mxic_nand_rand_type_store);   
> > > > > > > > > > 
> > > > > > > > > > No, we don't want to expose that through a sysfs file,   
> > > > > especially   
> > > > > > > since   
> > > > > > > > > > changing the randomizer config means making the NAND   
> > > unreadable   
> > > > > for   
> > > > > > > > > > those that have used it before the change.
> > > > > > > > > >   
> > > > > > > > > 
> > > > > > > > > Our on-die randomizer is still readable from user after   
> the 
> > > > > function   
> > > > > > > > > is enabled.   
> > > > > > > > 
> > > > > > > > You mean the memory is still readable no matter the   
> randomizer 
> > > > > state.   
> > > > > > > > Not sure how that's possible, but okay.
> > > > > > > >   
> > > > > > > > > This randomizer is just like a internal memory cell 
> > > > > > > > > reliability enhanced.   
> > > > > > > > 
> > > > > > > > Why don't you enable it by default then?   
> > > > > > > 
> > > > > > > The penalty of randomizer is read/write performance down.
> > > > > > > i.e,. tPROG 300 us to 340 us (randomizer enable)
> > > > > > > therefore, disable it by default.   
> > > > > > 
> > > > > > I'm a bit puzzled. On the NAND I've seen that required data
> > > > > > randomization it's not something you'd want to disable as this   
> > > implied  
> > > > > > poor data retention. What's the use case here? Are we talking   
> about 
> > > SLC  
> > > > > > or MLC NANDs? Should we enable this feature once we start seeing   
>  
> > > that  
> > > > > > the NAND starts being less reliable (basically when read-retry   
> > > happens  
> > > > > > more often)? I really think this is something you should decide    
> 
> > > kernel  
> > > > > > side, because users have no clue when it's appropriate to switch   
>  
> > > this  
> > > > > > feature on/off.
> > > > > >   
> > > > > 
> > > > > It's SLC NAND and seems to has nothing to do with read-retry   
> happens.
> > > > > later, I will get more information for your concerns.   
> > > > 
> > > > Well, this feature is optional, and can be enabled to improve
> > > > reliability. Sounds like a good reason to enable it when your NAND
> > > > device starts showing reliability issues, and the number of   
> read_retry
> > > > attempts reflects the wear level pretty well. Alternatively, you   
> could
> > > > use the number of bitflips, but, in any case, don't expect the user   
> to
> > > > take this decision, because almost nobody knows what the randomizer
> > > > is needed for.
> > > >   
> > > > >   
> > > > > > >   
> > > > > > > >   
> > > > > > > > > It could be enable at any time with OTP bit function and   
> > > that's   
> > > > > why   
> > > > > > > > > we patch it by sys-fs.   
> > > > > > > > 
> > > > > > > > Sorry, but that's not a good reason to expose that through   
> > > sysfs.   
> > > > > > > 
> > > > > > > Any good way to expose randomizer function for user ?   
> > > > > > 
> > > > > > Don't expose it :P.   
> > > > > 
> > > > > oh, okay, I will remove sys-fs randomizer.
> > > > > 
> > > > > Is it OK to keep set/get features for randomizer ?   
> > > > 
> > > > I don't think it's a good idea to have dead code, so no. But I'm   
> pretty
> > > > sure we'll find a way to use/expose this feature.   
> > > 
> > > okay, great!
> > > Looking forward to hearing this feature use/expose.  
> > 
> > But for that to happen we are waiting for inputs about when this is
> > supposed to be used...  
> 
> 
> The main reason to disable Randomizer in default is
> NOP = 4 (default) change to NOP = 1 (Randomizer enable), 
> NOP: number of partial program cycles in same page

I am not sure to understand, is this related to what we call 'subpages'?

> 
> Some OS file systems(or FTL) much concern NOP = 4 and 
> any better way than sys-fs to enable it?

sysfs entry => user action
The user has absolutely no way to know when it is relevant to enable
the randomizer. The kernel must be in charge of it. So the question is:
when is it relevant to enable the randomizer? What criteria? What
threshold?


Thanks,
Miquèl
