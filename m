Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D407C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B8972075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553676280;
	bh=ADmEf/U9QEk9lnWwguwZWJqF4iOyCbjRHXcEKCqg8tQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FY+CygpLyfS379Xjk3tS3KoMRtjbRGeRbLgozfFeWGGDgAGnDHAlEkHnZLAz1HJe+
	 sHlNF3APczPXGA1qcKjRO+oglPBMQey9pzGKj5LaoRuwctyt6m6rq7JMQiDDU4X7hZ
	 0rZPoo1ywVgDXzTcErpipSyXoAfoj8wNBUgOp3Yk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732249AbfC0Ioj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 04:44:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:46150 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731915AbfC0Ioh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 04:44:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3FFF3AC3D;
        Wed, 27 Mar 2019 08:44:35 +0000 (UTC)
Date:   Wed, 27 Mar 2019 09:44:32 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com, cl@linux.com,
        willy@infradead.org, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] kmemleak: survive in a low-memory situation
Message-ID: <20190327084432.GA11927@dhcp22.suse.cz>
References: <20190327005948.24263-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327005948.24263-1-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 26-03-19 20:59:48, Qian Cai wrote:
[...]
> Unless there is a brave soul to reimplement the kmemleak to embed it's
> metadata into the tracked memory itself in a foreseeable future, this
> provides a good balance between enabling kmemleak in a low-memory
> situation and not introducing too much hackiness into the existing
> code for now. Another approach is to fail back the original allocation
> once kmemleak_alloc() failed, but there are too many call sites to
> deal with which makes it error-prone.

As long as there is an implicit __GFP_NOFAIL then kmemleak is simply
broken no matter what other gfp flags you play with. Has anybody looked
at some sort of preallocation where gfpflags_allow_blocking context
allocate objects into a pool that non-sleeping allocations can eat from?

> kmemleak: Cannot allocate a kmemleak_object structure
> kmemleak: Kernel memory leak detector disabled
> kmemleak: Automatic memory scanning thread ended
> RIP: 0010:__alloc_pages_nodemask+0x242a/0x2ab0
> Call Trace:
>  allocate_slab+0x4d9/0x930
>  new_slab+0x46/0x70
>  ___slab_alloc+0x5d3/0x9c0
>  __slab_alloc+0x12/0x20
>  kmem_cache_alloc+0x30a/0x360
>  create_object+0x96/0x9a0
>  kmemleak_alloc+0x71/0xa0
>  kmem_cache_alloc+0x254/0x360
>  mempool_alloc_slab+0x3f/0x60
>  mempool_alloc+0x120/0x329
>  bio_alloc_bioset+0x1a8/0x510
>  get_swap_bio+0x107/0x470
>  __swap_writepage+0xab4/0x1650
>  swap_writepage+0x86/0xe0
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
> 
> v4: Update the commit log.
>     Fix a typo in comments per Christ.
>     Consolidate the allocation.
> v3: Update the commit log.
>     Simplify the code inspired by graph_trace_open() from ftrace.
> v2: Remove the needless checking for NULL objects in slab_post_alloc_hook()
>     per Catalin.
> 
>  mm/kmemleak.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index a2d894d3de07..7f4545ab1f84 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -580,7 +580,16 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
>  	struct rb_node **link, *rb_parent;
>  	unsigned long untagged_ptr;
>  
> -	object = kmem_cache_alloc(object_cache, gfp_kmemleak_mask(gfp));
> +	/*
> +	 * The tracked memory was allocated successful, if the kmemleak object
> +	 * failed to allocate for some reasons, it ends up with the whole
> +	 * kmemleak disabled, so try it harder.
> +	 */
> +	gfp = (in_atomic() || irqs_disabled()) ?
> +	       gfp_kmemleak_mask(gfp) | GFP_ATOMIC :
> +	       gfp_kmemleak_mask(gfp) | __GFP_DIRECT_RECLAIM;


The comment for in_atomic says:
 * Are we running in atomic context?  WARNING: this macro cannot
 * always detect atomic context; in particular, it cannot know about
 * held spinlocks in non-preemptible kernels.  Thus it should not be
 * used in the general case to determine whether sleeping is possible.
 * Do not use in_atomic() in driver code.

-- 
Michal Hocko
SUSE Labs
