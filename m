Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773AEC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 12:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 489EB206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 12:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbfFEMWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 08:22:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60268 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727422AbfFEMWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 08:22:05 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C790BA6E13;
        Wed,  5 Jun 2019 12:22:04 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4935E600CC;
        Wed,  5 Jun 2019 12:22:00 +0000 (UTC)
Date:   Wed, 5 Jun 2019 08:21:59 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Gen Zhang <blackgod016574@gmail.com>, agk@redhat.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: dm-region-hash: Fix a missing-check bug in __rh_alloc()
Message-ID: <20190605122159.GA32538@redhat.com>
References: <20190524031248.GA6295@zhanggen-UX430UQ>
 <79ec221d-6970-3b30-0660-4a288a4c465e@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79ec221d-6970-3b30-0660-4a288a4c465e@suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 05 Jun 2019 12:22:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05 2019 at  2:05am -0400,
Jiri Slaby <jslaby@suse.cz> wrote:

> On 24. 05. 19, 5:12, Gen Zhang wrote:
> > In function __rh_alloc(), the pointer nreg is allocated a memory space
> > via kmalloc(). And it is used in the following codes. However, when 
> > there is a memory allocation error, kmalloc() fails. Thus null pointer
> > dereference may happen. And it will cause the kernel to crash. Therefore,
> > we should check the return value and handle the error.
> > Further, in __rh_find(), we should also check the return value and
> > handle the error.
> > 
> > Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> > 
> > ---
> > diff --git a/drivers/md/dm-region-hash.c b/drivers/md/dm-region-hash.c
> > index 1f76045..2fa1641 100644
> > --- a/drivers/md/dm-region-hash.c
> > +++ b/drivers/md/dm-region-hash.c
> > @@ -290,8 +290,11 @@ static struct dm_region *__rh_alloc(struct dm_region_hash *rh, region_t region)
> >  	struct dm_region *reg, *nreg;
> >  
> >  	nreg = mempool_alloc(&rh->region_pool, GFP_ATOMIC);
> > -	if (unlikely(!nreg))
> > +	if (unlikely(!nreg)) {
> >  		nreg = kmalloc(sizeof(*nreg), GFP_NOIO | __GFP_NOFAIL);
> > +		if (!nreg)
> > +			return NULL;
> 
> What's the purpose of checking NO_FAIL allocations?

There isn't, that was already pointed out in a different thread for this
same patch (think patch was posted twice):
https://www.redhat.com/archives/dm-devel/2019-May/msg00124.html

Mike
