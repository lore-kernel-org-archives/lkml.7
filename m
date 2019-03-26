Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F13C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 123312070D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VkC7m7yz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731681AbfCZQFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 12:05:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43490 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbfCZQFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 12:05:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Yz2RvGFb8xZomssZ7mtRK2dOFU1jnfJaOyAOB+cKBIQ=; b=VkC7m7yzRINQMwiNCcM2hrk5f
        +Ct1T7URpjIcWrbr0ScsN9kuCOsNZsyRTRwVJnZ0QY/ic6Ti3DY3001lLmKJbVaQ9VHyPCbcZlZjL
        ydVroQFgbIoPel1WyeZe4zc4W/A+zhSPdufqv6Iqh71FPVqEibq+mmDk9aeGpY7LWT4/IXdXHxEF0
        Ki7LZAq/eLVWcWuIrfPd2VYpRPTbE21WP+fudi4qLn3cJJ1fDpoEjImy7GIwSn4N5tGVz9LeXmdwf
        j4dP/8QAmKnXBG9qfRUXJVWa9INHMetFst4pP9jlJRY35GdXDHwNvdQyVLUU/S1YiiDTATVoyKPSw
        QsagImLOQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h8oa0-00042L-Ms; Tue, 26 Mar 2019 16:05:36 +0000
Date:   Tue, 26 Mar 2019 09:05:36 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        mhocko@kernel.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] kmemleaak: survive in a low-memory situation
Message-ID: <20190326160536.GO10344@bombadil.infradead.org>
References: <20190326154338.20594-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326154338.20594-1-cai@lca.pw>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 11:43:38AM -0400, Qian Cai wrote:
> Unless there is a brave soul to reimplement the kmemleak to embed it's
> metadata into the tracked memory itself in a foreseeable future, this
> provides a good balance between enabling kmemleak in a low-memory
> situation and not introducing too much hackiness into the existing
> code for now.

I don't understand kmemleak.  Kirill pointed me at this a few days ago:

https://gist.github.com/kiryl/3225e235fea390aa2e49bf625bbe83ec

It's caused by the XArray allocating memory using GFP_NOWAIT | __GFP_NOWARN.
kmemleak then decides it needs to allocate memory to track this memory.
So it calls kmem_cache_alloc(object_cache, gfp_kmemleak_mask(gfp));

#define gfp_kmemleak_mask(gfp)  (((gfp) & (GFP_KERNEL | GFP_ATOMIC)) | \
                                 __GFP_NORETRY | __GFP_NOMEMALLOC | \
                                 __GFP_NOWARN | __GFP_NOFAIL)

then the page allocator gets to see GFP_NOFAIL | GFP_NOWAIT and gets angry.

But I don't understand why kmemleak needs to mess with the GFP flags at
all.  Just allocate using the same flags as the caller, and fail the original
allocation if the kmemleak allocation fails.  Like this:

+++ b/mm/slab.h
@@ -435,12 +435,22 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s, gfp_t flags,
        for (i = 0; i < size; i++) {
                p[i] = kasan_slab_alloc(s, p[i], flags);
                /* As p[i] might get tagged, call kmemleak hook after KASAN. */
-               kmemleak_alloc_recursive(p[i], s->object_size, 1,
-                                        s->flags, flags);
+               if (kmemleak_alloc_recursive(p[i], s->object_size, 1,
+                                        s->flags, flags))
+                       goto fail;
        }
 
        if (memcg_kmem_enabled())
                memcg_kmem_put_cache(s);
+       return;
+
+fail:
+       while (i > 0) {
+               kasan_blah(...);
+               kmemleak_blah();
+               i--;
+       }
+	free_blah(p);
+       *p = NULL;
 }
 
 #ifndef CONFIG_SLOB


and if we had something like this, we wouldn't need kmemleak to have this
self-disabling or must-succeed property.
