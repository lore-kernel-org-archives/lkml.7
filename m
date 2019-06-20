Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF95C48BE2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 05:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3F5D215EA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 05:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561009834;
	bh=nurRONK++9FGau1IDjgsqUoU14JLcgY/a3ap6LeXXIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bfuAIPxGJJSDJSV2M1KWneV50E51fokVDYK7kw7IL1u27Ps23i/XM44stoy8xLH7Z
	 rMHKnt8abvB1h6oBR+2p+l/kw0NeBfiWTWUw8iqXRn9bO0D4YVMuKBZ+4oPWMTyIG+
	 tRrt3k7vfYdFx98PUPbrhGv3TwQa9EwxDu6f3Pkw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfFTFud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 01:50:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:60596 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725857AbfFTFuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 01:50:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4B5A0AC2C;
        Thu, 20 Jun 2019 05:50:31 +0000 (UTC)
Date:   Thu, 20 Jun 2019 07:50:28 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH] slub: Don't panic for memcg kmem cache creation failure
Message-ID: <20190620055028.GA12083@dhcp22.suse.cz>
References: <20190619232514.58994-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619232514.58994-1-shakeelb@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 19-06-19 16:25:14, Shakeel Butt wrote:
> Currently for CONFIG_SLUB, if a memcg kmem cache creation is failed and
> the corresponding root kmem cache has SLAB_PANIC flag, the kernel will
> be crashed. This is unnecessary as the kernel can handle the creation
> failures of memcg kmem caches.

AFAICS it will handle those by simply not accounting those objects
right?

> Additionally CONFIG_SLAB does not
> implement this behavior. So, to keep the behavior consistent between
> SLAB and SLUB, removing the panic for memcg kmem cache creation
> failures. The root kmem cache creation failure for SLAB_PANIC correctly
> panics for both SLAB and SLUB.

I do agree that panicing is really dubious especially because it opens
doors to shut the system down from a restricted environment. So the
patch makes sesne to me.

I am wondering whether SLAB_PANIC makes sense in general though. Why is
it any different from any other essential early allocations? We tend to
not care about allocation failures for those on bases that the system
must be in a broken state to fail that early already. Do you think it is
time to remove SLAB_PANIC altogether?

> Reported-by: Dave Hansen <dave.hansen@intel.com>
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/slub.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 6a5174b51cd6..84c6508e360d 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3640,10 +3640,6 @@ static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
>  
>  	free_kmem_cache_nodes(s);
>  error:
> -	if (flags & SLAB_PANIC)
> -		panic("Cannot create slab %s size=%u realsize=%u order=%u offset=%u flags=%lx\n",
> -		      s->name, s->size, s->size,
> -		      oo_order(s->oo), s->offset, (unsigned long)flags);
>  	return -EINVAL;
>  }
>  
> -- 
> 2.22.0.410.gd8fdbe21b5-goog

-- 
Michal Hocko
SUSE Labs
