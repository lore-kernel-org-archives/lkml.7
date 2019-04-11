Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272B8C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 06:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA4D421841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 06:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfDKGx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 02:53:59 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57254 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfDKGx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 02:53:58 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 7EC282756F7;
        Thu, 11 Apr 2019 07:53:56 +0100 (BST)
Date:   Thu, 11 Apr 2019 08:53:53 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     masonccyang@mxic.com.tw
Cc:     bbrezillon@kernel.org, computersforpeace@gmail.com,
        dwmw2@infradead.org, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        marek.vasut@gmail.com, miquel.raynal@bootlin.com, richard@nod.at,
        zhengxunli@mxic.com.tw
Subject: Re: [PATCH] mtd: rawnand: Add Macronix NAND read retry and
 randomizer support
Message-ID: <20190411085353.4c1af008@collabora.com>
In-Reply-To: <OF071D3608.9D6D2523-ON482583D9.00173F52-482583D9.0018188C@mxic.com.tw>
References: <1554780172-23111-1-git-send-email-masonccyang@mxic.com.tw>
        <20190409090427.22de9917@collabora.com>
        <OF6C97E4DE.45261545-ON482583D7.00340468-482583D7.0034B3FE@mxic.com.tw>
        <20190409114701.744c2c8c@collabora.com>
        <OF9601E14B.A48284C4-ON482583D8.0005E3EB-482583D8.0006CC14@mxic.com.tw>
        <20190410092258.332ef399@collabora.com>
        <OF071D3608.9D6D2523-ON482583D9.00173F52-482583D9.0018188C@mxic.com.tw>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Apr 2019 12:23:11 +0800
masonccyang@mxic.com.tw wrote:

> Hi Boris,
>  
>  
> > > > Subject
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
> > I'm a bit puzzled. On the NAND I've seen that required data
> > randomization it's not something you'd want to disable as this implied
> > poor data retention. What's the use case here? Are we talking about SLC
> > or MLC NANDs? Should we enable this feature once we start seeing that
> > the NAND starts being less reliable (basically when read-retry happens
> > more often)? I really think this is something you should decide kernel
> > side, because users have no clue when it's appropriate to switch this
> > feature on/off.
> >   
> 
> It's SLC NAND and seems to has nothing to do with read-retry happens.
> later, I will get more information for your concerns.

Well, this feature is optional, and can be enabled to improve
reliability. Sounds like a good reason to enable it when your NAND
device starts showing reliability issues, and the number of read_retry
attempts reflects the wear level pretty well. Alternatively, you could
use the number of bitflips, but, in any case, don't expect the user to
take this decision, because almost nobody knows what the randomizer
is needed for.

> 
> > >   
> > > >   
> > > > > It could be enable at any time with OTP bit function and that's   
> why
> > > > > we patch it by sys-fs.   
> > > > 
> > > > Sorry, but that's not a good reason to expose that through sysfs.   
> > > 
> > > Any good way to expose randomizer function for user ?  
> > 
> > Don't expose it :P.  
> 
> oh, okay, I will remove sys-fs randomizer.
> 
> Is it OK to keep set/get features for randomizer ?

I don't think it's a good idea to have dead code, so no. But I'm pretty
sure we'll find a way to use/expose this feature.

> that is :
> 
> +static void macronix_nand_onfi_init(struct nand_chip *chip)
> +{
> +                struct nand_parameters *p = &chip->parameters;
> +                struct kobject *kobj;
> +                int ret;
> +
> +                if (p->onfi) {
> +                                struct nand_onfi_vendor_macronix *mxic =
> +                                                                (void 
> *)p->onfi->vendor;
> +
> +                                if (mxic->reliability_func & 
> MACRONIX_READ_RETRY_BIT) {
> +                                                chip->read_retries = 
> MACRONIX_READ_RETRY_MODE + 1;
> +                                                chip->setup_read_retry =
> + macronix_nand_setup_read_retry;
> +                                                if 
> (p->supports_set_get_features) {
> + set_bit(ONFI_FEATURE_ADDR_READ_RETRY,
> +  p->set_feature_list);
> + set_bit(ONFI_FEATURE_ADDR_READ_RETRY,
> +  p->get_feature_list);
> +                                                }
> +                                }
> +
> +                                if (mxic->reliability_func & 
> MACRONIX_RANDOMIZER_BIT) {
> +                                                if 
> (p->supports_set_get_features) {
> + set_bit(ONFI_FEATURE_ADDR_MXIC_RANDOMIZER,
> +  p->set_feature_list);
> + set_bit(ONFI_FEATURE_ADDR_MXIC_RANDOMIZER,
> +  p->get_feature_list);
> +                                                }
> +                                }
> +                }
> +}
> + 
> 
> thanks & best regards,
> Mason
> 
> 
> 
> CONFIDENTIALITY NOTE:
> 
> This e-mail and any attachments may contain confidential information 
> and/or personal data, which is protected by applicable laws. Please be 
> reminded that duplication, disclosure, distribution, or use of this e-mail 
> (and/or its attachments) or any part thereof is prohibited. If you receive 
> this e-mail in error, please notify us immediately and delete this mail as 
> well as its attachment(s) from your system. In addition, please be 
> informed that collection, processing, and/or use of personal data is 
> prohibited unless expressly permitted by personal data protection laws. 
> Thank you for your attention and cooperation.
> 
> Macronix International Co., Ltd.
> 
> =====================================================================
> 
> 
> 
> ============================================================================
> 
> CONFIDENTIALITY NOTE:
> 
> This e-mail and any attachments may contain confidential information and/or personal data, which is protected by applicable laws. Please be reminded that duplication, disclosure, distribution, or use of this e-mail (and/or its attachments) or any part thereof is prohibited. If you receive this e-mail in error, please notify us immediately and delete this mail as well as its attachment(s) from your system. In addition, please be informed that collection, processing, and/or use of personal data is prohibited unless expressly permitted by personal data protection laws. Thank you for your attention and cooperation.
> 
> Macronix International Co., Ltd.
> 
> =====================================================================

