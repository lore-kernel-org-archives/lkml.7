Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A27C76194
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 17:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E17702239F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 17:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KClY5whB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391010AbfGWRRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 13:17:34 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:44091 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732757AbfGWRRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 13:17:34 -0400
Received: by mail-vs1-f68.google.com with SMTP id v129so29331141vsb.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 10:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QqrUJzkPpAaDRvvKsmPrqxCm6oyy05uDqHmCovyhL70=;
        b=KClY5whBhZJkA8IHSLzSHzX+WVj0t87uGT0lzsUub/COP4/3SMvz4Iet5QPzraFXgF
         3H5sIXzzJFzGpd9sIfkxKMU0QO4M2bcDm0G+Tf39YMzAJvr0jbNxuRcY7ooqKTXsAWgH
         /tofHFhod7aDMEbGJKL6+i0RWw2prFK/Z4DJ6IZYxw+ZrvIyV2lPSgSvI1ubA+ize+sf
         ljiHEYoC3nR0bUaWqY/zvkbdhaQFxXvwycHLfBlxo6jBsBWETWn9TDMISL99sGP0pZng
         cvD04P8wscxYGTWuyLPSEz5GL4VPipUGVTAGOpCofseTd/SoqMw3MQ4eC8DD0yCVjXMt
         0xNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QqrUJzkPpAaDRvvKsmPrqxCm6oyy05uDqHmCovyhL70=;
        b=WmPPmeiTWxlGEhXbQ6x/rpDlhc31npuY1SCOSN+kJ7NeweoyRLHmvO384oiYWhKtwc
         ptwMTsKy89fmAJg1fxXt49bE2xhxUvIzT+ElkJGHKU4Jjik/MINo74xhVzplz4KGxlt1
         TEcMW82rUCAFSsZPWomnPCweUp5WcO/A+zxqaRorU8wWm+PclPq3NbYOTVf36tGNg939
         +4gVESPaDZOjF7sO5BlC0vLwW2F1b+QMSC4sRYvAhDHFpfqcIXyTqlPNORBIYSv80oxs
         qCBb5bions0TfdmjPZL/BITj4jZ4hmDHv0h+cj1PFlTz02jB4UrImBOB5eiFaWxe6bhs
         lxHA==
X-Gm-Message-State: APjAAAU8qG+vawHGnB3qIGQx2RpJvXFKFsguyu2MhhqKAfxhoXpb43CK
        zQfB79Pf52lT9v6gFicvR+zqA+bNze+rOA==
X-Google-Smtp-Source: APXvYqy/BnQGomP9bfEv9fcbGXC5naUZNkETCjo5R1Jblm92pT8i/VM8xtUGyS2NeeXimmoMCnZGHQ==
X-Received: by 2002:a67:db89:: with SMTP id f9mr45182090vsk.150.1563902253192;
        Tue, 23 Jul 2019 10:17:33 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id i12sm9556385vsr.17.2019.07.23.10.17.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jul 2019 10:17:32 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hpyPr-0002YL-Ko; Tue, 23 Jul 2019 14:17:31 -0300
Date:   Tue, 23 Jul 2019 14:17:31 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] nouveau: unlock mmap_sem on all errors from
 nouveau_range_fault
Message-ID: <20190723171731.GD15357@ziepe.ca>
References: <20190722094426.18563-1-hch@lst.de>
 <20190722094426.18563-5-hch@lst.de>
 <20190723151824.GL15331@mellanox.com>
 <20190723163048.GD1655@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723163048.GD1655@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 06:30:48PM +0200, Christoph Hellwig wrote:
> On Tue, Jul 23, 2019 at 03:18:28PM +0000, Jason Gunthorpe wrote:
> > Hum..
> > 
> > The caller does this:
> > 
> > again:
> > 		ret = nouveau_range_fault(&svmm->mirror, &range);
> > 		if (ret == 0) {
> > 			mutex_lock(&svmm->mutex);
> > 			if (!nouveau_range_done(&range)) {
> > 				mutex_unlock(&svmm->mutex);
> > 				goto again;
> > 
> > And we can't call nouveau_range_fault() -> hmm_range_fault() without
> > holding the mmap_sem, so we can't allow nouveau_range_fault to unlock
> > it.
> 
> Goto again can only happen if nouveau_range_fault was successful,
> in which case we did not drop mmap_sem.

Oh, right we switch from success = number of pages to success =0..

However the reason this looks so weird to me is that the locking
pattern isn't being followed, any result of hmm_range_fault should be
ignored until we enter the svmm->mutex and check if there was a
colliding invalidation.

So the 'goto again' *should* be possible even if range_fault failed.

But that is not for this patch..

> >  	ret = hmm_range_fault(range, true);
> >  	if (ret <= 0) {
> >  		if (ret == 0)
> >  			ret = -EBUSY;
> > -		up_read(&range->vma->vm_mm->mmap_sem);
> >  		hmm_range_unregister(range);
> 
> This would hold mmap_sem over hmm_range_unregister, which can lead
> to deadlock if we call exit_mmap and then acquire mmap_sem again.

That reminds me, this code is also leaking hmm_range_unregister() in
the success path, right?

I think the right way to structure this is to move the goto again and
related into the nouveau_range_fault() so the whole retry algorithm is
sensibly self contained.

Jason
