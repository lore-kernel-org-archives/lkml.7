Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22974C41514
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 16:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC8D922CE3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 16:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lecystT5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbfHUQQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 12:16:37 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37737 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbfHUQQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 12:16:37 -0400
Received: by mail-qt1-f196.google.com with SMTP id y26so3724095qto.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 09:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rSelPuss6Rio+zLxmeT3lHQjONOPz6ghCteSl79uvc4=;
        b=lecystT5pa2A6yo8Axdj1KSsLU40VESQnnpU2Rk1L1SzDdZmYUbd4PsiNU+5iLOE7j
         zbD6bbLCGebQwx9lcXa2B+HW9DoD5q7uBa/gZ7ygQPx77wQQIQ1GmTexMMrPCdK7kyCX
         dcyjDO+jw/ZpT3eBIlbTDS/F9lvZmJkfsIhEr9N+LJxXNscIOIrGwF+RrgQg/pAcfw/v
         C6mD6PK7XpC9IuEvG2lpMuOD0oHl5qpDhT5vYuAjCVMq7SKO6jJn1/Yli0UUb+PtB3VS
         3uspvkistGavDwQta/lD1VQQk7IwUnquCu4OISrFvHvchWTZq1eeFmMkErGSgo9qyGp1
         hN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rSelPuss6Rio+zLxmeT3lHQjONOPz6ghCteSl79uvc4=;
        b=JaSxiW0+eaZ8gKQR+RlEXVmb1jBCZcZEWTI1mcYO2bUoJ1jaojlTD2Z2Nye21M4RNV
         tYLouUUnZqRCp+QAyVQ0dSCj6UqMdLkWb8+XzZBU5Ussk6lwPQ3j3N/31jbELRIKzzry
         xreiEUTC6T1FI5/YJhSUwM3hQKBWwTwJfAxw5Fe8wtabv7fWDbt9FmyYa3TFjjevo1R3
         EOIbEXZDkck4hKDbe85WgZ0a5AHw+QrVHSFxZBd/kaPmGc4aQQjK2hhKNvKNbi/cD6Ra
         slfqxSjMcbg+4fdkG9QHgkah0Tt7rMVh3YNjkz1QFE1fTuobszjscXr/AXIDdcfG7Bwx
         mKGQ==
X-Gm-Message-State: APjAAAWx6lhVP63olFIUTpejnzPqY2PulwDcRjMrbuATfjWqg5KgJANK
        i/6W+eCaoDQHMRgAK2mMGdsfBGbb7rQ=
X-Google-Smtp-Source: APXvYqypokR94+w8NKN6DkdxQ9oFTavnyiG1VlybQkUXWne93Jd3wfqkFsQtWY3s57Jl+U7ZTrZ3aQ==
X-Received: by 2002:ac8:7696:: with SMTP id g22mr31568522qtr.208.1566404196241;
        Wed, 21 Aug 2019 09:16:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id y194sm10143420qkb.111.2019.08.21.09.16.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Aug 2019 09:16:35 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i0THn-0008UM-3g; Wed, 21 Aug 2019 13:16:35 -0300
Date:   Wed, 21 Aug 2019 13:16:35 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 4/4] mm, notifier: Catch sleeping/blocking for !blockable
Message-ID: <20190821161635.GC8653@ziepe.ca>
References: <20190820081902.24815-1-daniel.vetter@ffwll.ch>
 <20190820081902.24815-5-daniel.vetter@ffwll.ch>
 <20190820133418.GG29246@ziepe.ca>
 <20190820151810.GG11147@phenom.ffwll.local>
 <20190821154151.GK11147@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821154151.GK11147@phenom.ffwll.local>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 05:41:51PM +0200, Daniel Vetter wrote:

> > Hm, I thought the page table locks we're holding there already prevent any
> > sleeping, so would be redundant? But reading through code I think that's
> > not guaranteed, so yeah makes sense to add it for invalidate_range_end
> > too. I'll respin once I have the ack/nack from scheduler people.
> 
> So I started to look into this, and I'm a bit confused. There's no
> _nonblock version of this, so does this means blocking is never allowed,
> or always allowed?

RDMA has a mutex:

ib_umem_notifier_invalidate_range_end
  rbt_ib_umem_for_each_in_range
   invalidate_range_start_trampoline
    ib_umem_notifier_end_account
      mutex_lock(&umem_odp->umem_mutex);

I'm working to delete this path though!

nonblocking or not follows the start, the same flag gets placed into
the mmu_notifier_range struct passed to end.

> From a quick look through implementations I've only seen spinlocks, and
> one up_read. So I guess I should wrape this callback in some unconditional
> non_block_start/end, but I'm not sure.

For now, we should keep it the same as start, conditionally blocking.

Hopefully before LPC I can send a RFC series that eliminates most
invalidate_range_end users in favor of common locking..

Jason
