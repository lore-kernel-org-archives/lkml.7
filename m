Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1108C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 969082086C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563196739;
	bh=JA2fTp9dnf2nlyPHVTs3F19oE6Gk/iu4+M5IYlTffx8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZKNL/fdE3Ho4hw6CRH4bGtWzNFHIY5FYLlA7YTZjFt6voe6Fk3k+hJuzZ/D+Y7wGf
	 sCmNMMAOll6T9dZeXvyxOpJXhtGdB7lfBvc7x5JG0hVgxH7UlINGdTtlouc9XldYqd
	 t39rCawzZx0+nEMlrXJnPiQqH6jMCesJgihc19Xg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730200AbfGONS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 09:18:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:50252 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730071AbfGONS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 09:18:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F30B1AFFE;
        Mon, 15 Jul 2019 13:18:56 +0000 (UTC)
Date:   Mon, 15 Jul 2019 15:18:56 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>, dvyukov@google.com,
        catalin.marinas@arm.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: page_alloc: document kmemleak's non-blockable
 __GFP_NOFAIL case
Message-ID: <20190715131856.GY29483@dhcp22.suse.cz>
References: <1562964544-59519-1-git-send-email-yang.shi@linux.alibaba.com>
 <alpine.DEB.2.21.1907131230280.246128@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1907131230280.246128@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 13-07-19 12:39:16, David Rientjes wrote:
> On Sat, 13 Jul 2019, Yang Shi wrote:
> 
> > When running ltp's oom test with kmemleak enabled, the below warning was
> > triggerred since kernel detects __GFP_NOFAIL & ~__GFP_DIRECT_RECLAIM is
> > passed in:
> > 
> > WARNING: CPU: 105 PID: 2138 at mm/page_alloc.c:4608 __alloc_pages_nodemask+0x1c31/0x1d50
> > Modules linked in: loop dax_pmem dax_pmem_core
> > ip_tables x_tables xfs virtio_net net_failover virtio_blk failover
> > ata_generic virtio_pci virtio_ring virtio libata
> > CPU: 105 PID: 2138 Comm: oom01 Not tainted 5.2.0-next-20190710+ #7
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.10.2-0-g5f4c7b1-prebuilt.qemu-project.org 04/01/2014
> > RIP: 0010:__alloc_pages_nodemask+0x1c31/0x1d50
> > ...
> >  kmemleak_alloc+0x4e/0xb0
> >  kmem_cache_alloc+0x2a7/0x3e0
> >  ? __kmalloc+0x1d6/0x470
> >  ? ___might_sleep+0x9c/0x170
> >  ? mempool_alloc+0x2b0/0x2b0
> >  mempool_alloc_slab+0x2d/0x40
> >  mempool_alloc+0x118/0x2b0
> >  ? __kasan_check_read+0x11/0x20
> >  ? mempool_resize+0x390/0x390
> >  ? lock_downgrade+0x3c0/0x3c0
> >  bio_alloc_bioset+0x19d/0x350
> >  ? __swap_duplicate+0x161/0x240
> >  ? bvec_alloc+0x1b0/0x1b0
> >  ? do_raw_spin_unlock+0xa8/0x140
> >  ? _raw_spin_unlock+0x27/0x40
> >  get_swap_bio+0x80/0x230
> >  ? __x64_sys_madvise+0x50/0x50
> >  ? end_swap_bio_read+0x310/0x310
> >  ? __kasan_check_read+0x11/0x20
> >  ? check_chain_key+0x24e/0x300
> >  ? bdev_write_page+0x55/0x130
> >  __swap_writepage+0x5ff/0xb20
> > 
> > The mempool_alloc_slab() clears __GFP_DIRECT_RECLAIM, kmemleak has
> > __GFP_NOFAIL set all the time due to commit
> > d9570ee3bd1d4f20ce63485f5ef05663866fe6c0 ("kmemleak: allow to coexist
> > with fault injection").
> > 
> 
> It only clears __GFP_DIRECT_RECLAIM provisionally to see if the allocation 
> would immediately succeed before falling back to the elements in the 
> mempool.  If that fails, and the mempool is empty, mempool_alloc() 
> attempts the allocation with __GFP_DIRECT_RECLAIM.  So for the problem 
> described here, I think what we really want is this:
> 
> diff --git a/mm/mempool.c b/mm/mempool.c
> --- a/mm/mempool.c
> +++ b/mm/mempool.c
> @@ -386,7 +386,7 @@ void *mempool_alloc(mempool_t *pool, gfp_t gfp_mask)
>  	gfp_mask |= __GFP_NORETRY;	/* don't loop in __alloc_pages */
>  	gfp_mask |= __GFP_NOWARN;	/* failures are OK */
>  
> -	gfp_temp = gfp_mask & ~(__GFP_DIRECT_RECLAIM|__GFP_IO);
> +	gfp_temp = gfp_mask & ~(__GFP_DIRECT_RECLAIM|__GFP_IO|__GFP_NOFAIL);
>  
>  repeat_alloc:

No, I do not think we should make mempool allocator more complex for
something that is an implementation problem the kmemleak.
-- 
Michal Hocko
SUSE Labs
