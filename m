Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04D5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D842070D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731613AbfCZQUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 12:20:47 -0400
Received: from foss.arm.com ([217.140.101.70]:39400 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbfCZQUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 12:20:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 458091596;
        Tue, 26 Mar 2019 09:20:46 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 51A8A3F614;
        Tue, 26 Mar 2019 09:20:44 -0700 (PDT)
Date:   Tue, 26 Mar 2019 16:20:41 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org,
        mhocko@kernel.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] kmemleaak: survive in a low-memory situation
Message-ID: <20190326162038.GH33308@arrakis.emea.arm.com>
References: <20190326154338.20594-1-cai@lca.pw>
 <20190326160536.GO10344@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326160536.GO10344@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 09:05:36AM -0700, Matthew Wilcox wrote:
> On Tue, Mar 26, 2019 at 11:43:38AM -0400, Qian Cai wrote:
> > Unless there is a brave soul to reimplement the kmemleak to embed it's
> > metadata into the tracked memory itself in a foreseeable future, this
> > provides a good balance between enabling kmemleak in a low-memory
> > situation and not introducing too much hackiness into the existing
> > code for now.
> 
> I don't understand kmemleak.  Kirill pointed me at this a few days ago:
> 
> https://gist.github.com/kiryl/3225e235fea390aa2e49bf625bbe83ec
> 
> It's caused by the XArray allocating memory using GFP_NOWAIT | __GFP_NOWARN.
> kmemleak then decides it needs to allocate memory to track this memory.
> So it calls kmem_cache_alloc(object_cache, gfp_kmemleak_mask(gfp));
> 
> #define gfp_kmemleak_mask(gfp)  (((gfp) & (GFP_KERNEL | GFP_ATOMIC)) | \
>                                  __GFP_NORETRY | __GFP_NOMEMALLOC | \
>                                  __GFP_NOWARN | __GFP_NOFAIL)
> 
> then the page allocator gets to see GFP_NOFAIL | GFP_NOWAIT and gets angry.
> 
> But I don't understand why kmemleak needs to mess with the GFP flags at
> all.

Originally, it was just preserving GFP_KERNEL | GFP_ATOMIC. Starting
with commit 6ae4bd1f0bc4 ("kmemleak: Allow kmemleak metadata allocations
to fail"), this mask changed, aimed at making kmemleak allocation
failures less verbose (i.e. just disable it since it's a debug tool).

Commit d9570ee3bd1d ("kmemleak: allow to coexist with fault injection")
introduced __GFP_NOFAIL but this came with its own problems which have
been previously reported (the warning you mentioned is another one of
these). We didn't get to any clear conclusion on how best to allow
allocations to fail with fault injection but not for the kmemleak
metadata. Your suggestion below would probably do the trick.

> Just allocate using the same flags as the caller, and fail the original
> allocation if the kmemleak allocation fails.  Like this:
> 
> +++ b/mm/slab.h
> @@ -435,12 +435,22 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s, gfp_t flags,
>         for (i = 0; i < size; i++) {
>                 p[i] = kasan_slab_alloc(s, p[i], flags);
>                 /* As p[i] might get tagged, call kmemleak hook after KASAN. */
> -               kmemleak_alloc_recursive(p[i], s->object_size, 1,
> -                                        s->flags, flags);
> +               if (kmemleak_alloc_recursive(p[i], s->object_size, 1,
> +                                        s->flags, flags))
> +                       goto fail;
>         }
>  
>         if (memcg_kmem_enabled())
>                 memcg_kmem_put_cache(s);
> +       return;
> +
> +fail:
> +       while (i > 0) {
> +               kasan_blah(...);
> +               kmemleak_blah();
> +               i--;
> +       }
> +	free_blah(p);
> +       *p = NULL;
>  }
>  
>  #ifndef CONFIG_SLOB
> 
> 
> and if we had something like this, we wouldn't need kmemleak to have this
> self-disabling or must-succeed property.

We'd still need the self-disabling in place since there are a few other
places where we call kmemleak_alloc() from.

-- 
Catalin
