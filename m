Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7918C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 14:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD93206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 14:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c69GUb5e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbfFEO6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 10:58:32 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54605 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728448AbfFEO6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 10:58:32 -0400
Received: by mail-wm1-f65.google.com with SMTP id g135so2591193wme.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 07:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JMXXe6AqnjayglXVoDkqd6XGPAOEachog6ijJh1WH/M=;
        b=c69GUb5e0zImhjjK5JB+615hWzoFJvTWr+iOyLMJviK5KxLRr6jgx4UWBf5OZDtr5O
         ULDsZSGivOv11ZfUEV2OsGG9u3/8QETHCb2Ot9NobhSlJtJFqaIUbZhvKqerxqPsf4dv
         AFV1ijerqAf4dvnIKNg1r/kW2g1/JmNJbdH7hZRndW1J1WB89VlxAIKj+iVTUBOpyvli
         ZZjKkqgU9LLz8VDcrqr+w10FnSDY4Y0NnQJ/1YUArGkPzxKo8Sc2ToqtEHlHdzCwTBYI
         eM6KcvHjoI7SK/jyBVSUyHIPMHcjBLp3SOUa2uFBvk1AI4tYhw+gM1c8UL665/Brj68w
         gRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JMXXe6AqnjayglXVoDkqd6XGPAOEachog6ijJh1WH/M=;
        b=TScFG2IIv13+LrkNgEZifgKdCKEWTGKB4R7SdvaKx69oKTPKoAOJjIZtnHMh7wNL92
         1HdIVsLH9ChHksbE43XrZHlRNlyNVkw5HqSI/VxB0m8TD8O09kdhAVHry5InjNBQEF9z
         2i7VZHU1nsiZf37SsVRzUZoCWl8G7DBKFVYQOLgAs0LQa0xSsjpE3dsDshfpMFit/cLo
         wzL7uz3AOfARCaBcr6m34m5tYFlDDiG6yKzcswyKbpFzRPzBw2eo0v47jHtf/tJzu9G2
         pPFY2oEAAl/FlfZoH2nSRdmIVSW08/vqK6EuqHByB4QHTH6quBAKrzhuCXnrPaReZ9Hx
         yM4w==
X-Gm-Message-State: APjAAAUkH/jgYp6o6zhSRJyy0BUcrVUKH0hNhIzW3npC0kZ31Z/PyqAf
        ZpAwPYSD7P9yf4t+SizV7rxej9Up
X-Google-Smtp-Source: APXvYqwvCGkjtCVV5oWpvvNG4YlrNQl+LPIGfnSh7pJDigKXy16bUNNk4KEQt0blqoM551eQkLxq6w==
X-Received: by 2002:a1c:6154:: with SMTP id v81mr22169029wmb.92.1559746710125;
        Wed, 05 Jun 2019 07:58:30 -0700 (PDT)
Received: from zhanggen-UX430UQ ([108.61.173.19])
        by smtp.gmail.com with ESMTPSA id 34sm28309312wre.32.2019.06.05.07.58.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 07:58:29 -0700 (PDT)
Date:   Wed, 5 Jun 2019 22:58:20 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Jiri Slaby <jslaby@suse.cz>, agk@redhat.com, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: dm-region-hash: Fix a missing-check bug in __rh_alloc()
Message-ID: <20190605145820.GA3465@zhanggen-UX430UQ>
References: <20190524031248.GA6295@zhanggen-UX430UQ>
 <79ec221d-6970-3b30-0660-4a288a4c465e@suse.cz>
 <20190605122159.GA32538@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605122159.GA32538@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 08:21:59AM -0400, Mike Snitzer wrote:
> On Wed, Jun 05 2019 at  2:05am -0400,
> Jiri Slaby <jslaby@suse.cz> wrote:
> 
> > On 24. 05. 19, 5:12, Gen Zhang wrote:
> > > In function __rh_alloc(), the pointer nreg is allocated a memory space
> > > via kmalloc(). And it is used in the following codes. However, when 
> > > there is a memory allocation error, kmalloc() fails. Thus null pointer
> > > dereference may happen. And it will cause the kernel to crash. Therefore,
> > > we should check the return value and handle the error.
> > > Further, in __rh_find(), we should also check the return value and
> > > handle the error.
> > > 
> > > Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> > > 
> > > ---
> > > diff --git a/drivers/md/dm-region-hash.c b/drivers/md/dm-region-hash.c
> > > index 1f76045..2fa1641 100644
> > > --- a/drivers/md/dm-region-hash.c
> > > +++ b/drivers/md/dm-region-hash.c
> > > @@ -290,8 +290,11 @@ static struct dm_region *__rh_alloc(struct dm_region_hash *rh, region_t region)
> > >  	struct dm_region *reg, *nreg;
> > >  
> > >  	nreg = mempool_alloc(&rh->region_pool, GFP_ATOMIC);
> > > -	if (unlikely(!nreg))
> > > +	if (unlikely(!nreg)) {
> > >  		nreg = kmalloc(sizeof(*nreg), GFP_NOIO | __GFP_NOFAIL);
> > > +		if (!nreg)
> > > +			return NULL;
> > 
> > What's the purpose of checking NO_FAIL allocations?
> 
> There isn't, that was already pointed out in a different thread for this
> same patch (think patch was posted twice):
> https://www.redhat.com/archives/dm-devel/2019-May/msg00124.html
> 
> Mike
Thanks for your reply. The first thread is not replied for a period, so
the second one is posted. But I don't know why Jiri replied to the first
thread.

Thanks
Gen
