Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47731C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 22:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC2F12173C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 22:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hIme93JQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbfEVWnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 18:43:23 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40270 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbfEVWnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 18:43:22 -0400
Received: by mail-qt1-f194.google.com with SMTP id k24so4479687qtq.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 15:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4SWkilyQvTQHlEqzOBLa67WncawDCy2JA2Vk1zS3JpI=;
        b=hIme93JQDlrchgrVGm3YMRf+iBRfIGlzkQn6Uz6i+PXXztdN0kFEw0CTW4SlI60+jj
         ppUnQ3Zyy9L2XHkfbEmVOs++b4xQFMnKClFJvOfjytQ2Tmrst7Vcze+IThXgGvYEVHLQ
         p7/BJQtzoS23AfCRaA5SwW8tE2k3tLe9Jv5cIEBl4Jow34rnNtII64T3NBbkli1fmY00
         H5XiZydx6mkiPb6b3AI1UC49umnq4I9YA/8pEZ511MOXZxW/ku9GbaaZFHM5+BAdUq8y
         kUueaZxLGgRXhDs5OeLjbmajBA+PwT0E4sRopqUMWt4+Fv8PLF37kOUwg1PJfaPhzPET
         GT+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4SWkilyQvTQHlEqzOBLa67WncawDCy2JA2Vk1zS3JpI=;
        b=eBgcUDYKIkV/icAD2bSfOLSE17L/+Q7eIRbU/g2XjgbMP5oMcVZWUDQcG4gBXcbbZr
         DB+YwdKszE7Hw8V/cFDzB/IQLi/j+RU3yo7VmEIEwyX/8b88jD5lC6uBVAQu0EXwHMFJ
         /tl6mLEk6JlVFGnXxADn2+rLsahQZR73AcLXJnvidByyZDEq4/q2l9g2/p/1roj/j6Hi
         jmVcvy9mpJg6PY+W6xJHDgrnQnshletrc7PwuSLoV2oI0wVRShxnPsyiRdUtZN2jEwBz
         nSBcfpoY4iZIbY00xORdd3we0vhrPZQXZBX2Oe0xN9rteiVO8NaPJjfHiMdGXgl6AtAs
         AZgQ==
X-Gm-Message-State: APjAAAV0r2BM8dJAX872I/NFeO/0ZFZIR/1+O/agAAae7MLYrQZG8sJ5
        yfaeqDy9fHF2VwIq40fYxs0o9Q==
X-Google-Smtp-Source: APXvYqw+NrK7xEC+5vJ7oOJ7bIjaRY9OboLQe6hOcOWtImCItkydeaRTkFyLlt9dHWnw536nOmZe5w==
X-Received: by 2002:a0c:f40c:: with SMTP id h12mr30465959qvl.95.1558565001202;
        Wed, 22 May 2019 15:43:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id t2sm11883034qkm.11.2019.05.22.15.43.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 15:43:20 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hTZxA-00047q-4Q; Wed, 22 May 2019 19:43:20 -0300
Date:   Wed, 22 May 2019 19:43:20 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        linux-mm@kvack.org
Subject: Re: [PATCH v4 0/1] Use HMM for ODP v4
Message-ID: <20190522224320.GB15389@ziepe.ca>
References: <20190411181314.19465-1-jglisse@redhat.com>
 <20190506195657.GA30261@ziepe.ca>
 <20190521205321.GC3331@redhat.com>
 <20190522005225.GA30819@ziepe.ca>
 <20190522174852.GA23038@redhat.com>
 <20190522192219.GF6054@ziepe.ca>
 <20190522214917.GA20179@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522214917.GA20179@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 05:49:18PM -0400, Jerome Glisse wrote:
> > > > So why is mm suddenly guarenteed valid? It was a bug report that
> > > > triggered the race the mmget_not_zero is fixing, so I need a better
> > > > explanation why it is now safe. From what I see the hmm_range_fault
> > > > is doing stuff like find_vma without an active mmget??
> > > 
> > > So the mm struct can not go away as long as we hold a reference on
> > > the hmm struct and we hold a reference on it through both hmm_mirror
> > > and hmm_range struct. So struct mm can not go away and thus it is
> > > safe to try to take its mmap_sem.
> > 
> > This was always true here, though, so long as the umem_odp exists the
> > the mm has a grab on it. But a grab is not a get..
> > 
> > The point here was the old code needed an mmget() in order to do
> > get_user_pages_remote()
> > 
> > If hmm does not need an external mmget() then fine, we delete this
> > stuff and rely on hmm.
> > 
> > But I don't think that is true as we have:
> > 
> >           CPU 0                                           CPU1
> >                                                        mmput()
> >                        				        __mmput()
> > 							 exit_mmap()
> > down_read(&mm->mmap_sem);
> > hmm_range_dma_map(range, device,..
> >   ret = hmm_range_fault(range, block);
> >      if (hmm->mm == NULL || hmm->dead)
> > 							   mmu_notifier_release()
> > 							     hmm->dead = true
> >      vma = find_vma(hmm->mm, start);
> >         .. rb traversal ..                                 while (vma) remove_vma()
> > 
> > *goes boom*
> > 
> > I think this is violating the basic constraint of the mm by acting on
> > a mm's VMA's without holding a mmget() to prevent concurrent
> > destruction.
> > 
> > In other words, mmput() destruction does not respect the mmap_sem - so
> > holding the mmap sem alone is not enough locking.
> > 
> > The unlucked hmm->dead simply can't save this. Frankly every time I
> > look a struct with 'dead' in it, I find races like this.
> > 
> > Thus we should put the mmget_notzero back in.
> 
> So for some reason i thought exit_mmap() was setting the mm_rb
> to empty node and flushing vmacache so that find_vma() would
> fail.

It would still be racy without locks.

> Note that right before find_vma() there is also range->valid
> check which will also intercept mm release.

There is no locking on range->valid so it is just moves the race
around. You can't solve races with unlocked/non-atomic variables.

> Anyway the easy fix is to get ref on mm user in range_register.

Yes a mmget_not_zero inside range_register would be fine.

How do you want to handle that patch?

> > I saw some other funky looking stuff in hmm as well..
> > 
> > > Hence it is safe to take mmap_sem and it is safe to call in hmm, if
> > > mm have been kill it will return EFAULT and this will propagate to
> > > RDMA.
> >  
> > > As per_mm i removed the per_mm->mm = NULL from release so that it is
> > > always safe to use that field even in face of racing mm "killing".
> > 
> > Yes, that certainly wasn't good.
> > 
> > > > > -	 * An array of the pages included in the on-demand paging umem.
> > > > > -	 * Indices of pages that are currently not mapped into the device will
> > > > > -	 * contain NULL.
> > > > > +	 * An array of the pages included in the on-demand paging umem. Indices
> > > > > +	 * of pages that are currently not mapped into the device will contain
> > > > > +	 * 0.
> > > > >  	 */
> > > > > -	struct page		**page_list;
> > > > > +	uint64_t *pfns;
> > > > 
> > > > Are these actually pfns, or are they mangled with some shift? (what is range->pfn_shift?)
> > > 
> > > They are not pfns they have flags (hence range->pfn_shift) at the
> > > bottoms i just do not have a better name for this.
> > 
> > I think you need to have a better name then
> 
> Suggestion ? i have no idea for a better name, it has pfn value
> in it.

pfn_flags?

Jason
