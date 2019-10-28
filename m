Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71D5CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9948214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572279857;
	bh=9SYnGJBKGry8Ep/RmYvXUU7PE75/rx3zjc6eQOr/ZoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rQYO41Dju5Mdol8nhHM7BG6aGkBSE3b0G55WLmMEX33CpGpdI2chXLlC0yulUpDL9
	 c2SNhKtDYpe2hoDcV9HaJGY0snO5sQbXlDPdXjnkU5PzGVO/zq9KnUBwBTFY4WuFun
	 DEWxRxZCdvp9BU03fVSdYY6v3niB+kmktKiih+fY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390901AbfJ1QYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 12:24:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:42222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728653AbfJ1QYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 12:24:16 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9FB9214E0;
        Mon, 28 Oct 2019 16:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572279855;
        bh=9SYnGJBKGry8Ep/RmYvXUU7PE75/rx3zjc6eQOr/ZoU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IIOmHNqdIHOz+TOlaGKmDotsgeOIVao8TqVGu+dbGb6mmOWZ70bF6X17X86o5xrLc
         /T3pzH6rM1uUpzHUhpbC5KVykYGhV2YFfs6PNmoua+la/jkFHGX81u1SzXAdYDj3SN
         omsFCnSD+LDNRZV+1JPIBhn57cqcBH6WZxCIMHjA=
Date:   Mon, 28 Oct 2019 17:24:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     eric@anholt.net, wahrenst@gmx.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vc04_services: replace g_free_fragments_mutex
 with spinlock
Message-ID: <20191028162412.GA321492@kroah.com>
References: <20191027221530.12080-1-dave@stgolabs.net>
 <20191028155354.s3bgq2wazwlh32km@linux-p48b>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028155354.s3bgq2wazwlh32km@linux-p48b>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 08:53:54AM -0700, Davidlohr Bueso wrote:
> Cc devel@driverdev.osuosl.org
> 
> On Sun, 27 Oct 2019, Bueso wrote:
> 
> > There seems no need to be using a semaphore, or a sleeping lock
> > in the first place: critical region is extremely short, does not
> > call into any blocking calls and furthermore lock and unlocking
> > operations occur in the same context.
> > 
> > Get rid of another semaphore user by replacing it with a spinlock.
> > 
> > Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> > ---
> > This is in an effort to further reduce semaphore users in the kernel.
> > 
> > .../staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c | 10 +++++-----
> > 1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
> > index 8dc730cfe7a6..710d21654128 100644
> > --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
> > +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
> > @@ -63,7 +63,7 @@ static char *g_free_fragments;
> > static struct semaphore g_free_fragments_sema;
> > static struct device *g_dev;
> > 
> > -static DEFINE_SEMAPHORE(g_free_fragments_mutex);
> > +static DEFINE_SPINLOCK(g_free_fragments_lock);
> > 
> > static irqreturn_t
> > vchiq_doorbell_irq(int irq, void *dev_id);
> > @@ -528,11 +528,11 @@ create_pagelist(char __user *buf, size_t count, unsigned short type)
> > 
> > 		WARN_ON(g_free_fragments == NULL);
> > 
> > -		down(&g_free_fragments_mutex);
> > +		spin_lock(&g_free_fragments_lock);
> > 		fragments = g_free_fragments;
> > 		WARN_ON(fragments == NULL);
> > 		g_free_fragments = *(char **) g_free_fragments;
> > -		up(&g_free_fragments_mutex);
> > +		spin_unlock(&g_free_fragments_lock);
> > 		pagelist->type = PAGELIST_READ_WITH_FRAGMENTS +
> > 			(fragments - g_fragments_base) / g_fragments_size;
> > 	}
> > @@ -591,10 +591,10 @@ free_pagelist(struct vchiq_pagelist_info *pagelistinfo,
> > 			kunmap(pages[num_pages - 1]);
> > 		}
> > 
> > -		down(&g_free_fragments_mutex);
> > +		spin_lock(&g_free_fragments_lock);
> > 		*(char **)fragments = g_free_fragments;
> > 		g_free_fragments = fragments;
> > -		up(&g_free_fragments_mutex);
> > +		spin_unlock(&g_free_fragments_lock);
> > 		up(&g_free_fragments_sema);
> > 	}
> > 
> > -- 
> > 2.16.4
> > 

This is obviously not in a format I can apply it in :(
