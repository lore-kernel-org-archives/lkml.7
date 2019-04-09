Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5CBC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2806720830
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfDIJrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:47:07 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49182 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfDIJrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 05:47:06 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 1DDF22820C8;
        Tue,  9 Apr 2019 10:47:05 +0100 (BST)
Date:   Tue, 9 Apr 2019 11:47:01 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     masonccyang@mxic.com.tw
Cc:     bbrezillon@kernel.org, computersforpeace@gmail.com,
        dwmw2@infradead.org, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        marek.vasut@gmail.com, miquel.raynal@bootlin.com, richard@nod.at,
        zhengxunli@mxic.com.tw
Subject: Re: [PATCH] mtd: rawnand: Add Macronix NAND read retry and
 randomizer support
Message-ID: <20190409114701.744c2c8c@collabora.com>
In-Reply-To: <OF6C97E4DE.45261545-ON482583D7.00340468-482583D7.0034B3FE@mxic.com.tw>
References: <1554780172-23111-1-git-send-email-masonccyang@mxic.com.tw>
        <20190409090427.22de9917@collabora.com>
        <OF6C97E4DE.45261545-ON482583D7.00340468-482583D7.0034B3FE@mxic.com.tw>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Apr 2019 17:35:39 +0800
masonccyang@mxic.com.tw wrote:

> > > +
> > > +static const struct kobj_attribute sysfs_mxic_nand =
> > > +   __ATTR(nand_random, S_IRUGO | S_IWUSR,
> > > +          mxic_nand_rand_type_show,
> > > +          mxic_nand_rand_type_store);  
> > 
> > No, we don't want to expose that through a sysfs file, especially since
> > changing the randomizer config means making the NAND unreadable for
> > those that have used it before the change.
> >   
> 
> Our on-die randomizer is still readable from user after the function 
> is enabled.

You mean the memory is still readable no matter the randomizer state.
Not sure how that's possible, but okay.

> This randomizer is just like a internal memory cell 
> reliability enhanced.

Why don't you enable it by default then?

> It could be enable at any time with OTP bit function and that's why
> we patch it by sys-fs.

Sorry, but that's not a good reason to expose that through sysfs.
