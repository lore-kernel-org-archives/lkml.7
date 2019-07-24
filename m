Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F618C76191
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 18:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0659321852
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 18:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dPDOwqvv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfGXSB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 14:01:56 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42999 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfGXSB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 14:01:56 -0400
Received: by mail-qt1-f196.google.com with SMTP id h18so46381193qtm.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 11:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NHrhrhDMfOD8855Z/WzNY5buipYXjy+AC0JGYKIcbF8=;
        b=dPDOwqvvcar2QZyrIWmnpS9kSbPHrR/wGiHoOguWcVWXL2QB4EbGlIpDh3GEhsu5Ui
         n8DvGZHMQ345DUYe/IKC+YM0nSeJddxkNt+S0YsC7V+nopWE6ScCmbBtAr9p8b7zuqMS
         yY6K83rBY7uS/1zb8JLsSuLsaZshzgZRKjMl6YdJRTawKHyG7IfOhH0vdHKybWcVN7ax
         GxFiQtZPpBb9p7N9LWeYpM2uz0JC6GufyTb6S7aDM2vJh8BzaSTgMbXeFslyg867My9K
         zrKo9Xi9joxNJiWv358sWE53cKRje+sKwuovXQ00SzRkhk+wqTRybQ1JEfewFmBiBsMW
         xDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NHrhrhDMfOD8855Z/WzNY5buipYXjy+AC0JGYKIcbF8=;
        b=Dvo7Snf0xrqKPFEFxDL23gimjsIO+B2FDyXd/0RV1PE2ho6/g9uWHGsN3A8FP5ZcET
         1E4c1IQl37cugqbBtXUKdhoff/ZAKsCjgJH418gupiweL+jDDsl/g4VEkOdhw0pHx1tu
         y6LVRS1nLYDi26U6py3MXIll4JjACjyp0JYdeao2inv7WCGmg9NpBIay758YEhWlBgqG
         Uu0+yl9EMR7Ixd+RisV1AD/qNqlWJkuFJAFH0bF46GvnltMN09H4jg1bC6lrW/rzUIO9
         SM+Oe8ip8POitnvC4m3hV7YrtGwcV/xwcVNgOIz4hbc6ppKDmZpYd3Ijd+RfJ/2LqFLC
         PvcA==
X-Gm-Message-State: APjAAAV3XeUGc4pYGgwVBNiRcwcy3/D0HnjdlLRH5CmcZWqQK25o602k
        nU6XEbixJlfu5P91cEw5C3nfjA==
X-Google-Smtp-Source: APXvYqwh9oIClfhj+Xu8Ca6v+JnH5wuP+h6Sc8J95We/ArJyD9/rby1kOqJsMt32kMVWN+JOLxYozw==
X-Received: by 2002:a0c:f193:: with SMTP id m19mr60859511qvl.20.1563991315101;
        Wed, 24 Jul 2019 11:01:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id r4sm32015444qta.93.2019.07.24.11.01.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jul 2019 11:01:54 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hqLaL-0003Qv-NY; Wed, 24 Jul 2019 15:01:53 -0300
Date:   Wed, 24 Jul 2019 15:01:53 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Michal Hocko <mhocko@suse.com>,
        Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [PATCH] mm/hmm: replace hmm_update with mmu_notifier_range
Message-ID: <20190724180153.GE28493@ziepe.ca>
References: <20190723210506.25127-1-rcampbell@nvidia.com>
 <20190724070553.GA2523@lst.de>
 <20190724152858.GB28493@ziepe.ca>
 <20190724153305.GA10681@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724153305.GA10681@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 05:33:05PM +0200, Christoph Hellwig wrote:
> On Wed, Jul 24, 2019 at 12:28:58PM -0300, Jason Gunthorpe wrote:
> > Humm. Actually having looked this some more, I wonder if this is a
> > problem:
> 
> What a mess.
> 
> Question: do we even care for the non-blocking events?  The only place
> where mmu_notifier_invalidate_range_start_nonblock is called is the oom
> killer, which means the process is about to die and the pagetable will
> get torn down ASAP.  Should we just skip them unconditionally?  nouveau
> already does so, but amdgpu currently tries to handle the non-blocking
> notifications.

I think the issue is the pages need to get freed to make the memory
available without becoming entangled in risky locks and deadlock.

Presumably if we go to the 'torn down ASAP' things get more risky that
the whole thing deadlocks?

I'm guessing a bit, but I *think* non-blocking here really means
something closer to WQ_MEM_RECLAIM, ie you can't do anything that would
become entangled with locks in the allocator that are pending on OOM??

(if so we really should call this reclaim not non-blocking)

ie for ODP umem_rwsem is held by threads while calling into kmalloc,
so when we go to do the exit_mmap we still do the
invalidate_range_start and can still end up blocked on a lock that is
held by a thread waiting for kmalloc to return.

Would be nice to know if this guess is right or not.

Jason
