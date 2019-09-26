Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C5FC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 19:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E70F9217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 19:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mum4Fr6N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbfIZTDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 15:03:42 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45718 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbfIZTDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 15:03:41 -0400
Received: by mail-pf1-f193.google.com with SMTP id y72so30633pfb.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 12:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=zq1OSYqXH0ZMOnbEBvZSWUC9RaDrbFy9EOSYIIfRujM=;
        b=Mum4Fr6NVjeSKG/DxUfxMiZXklbhuyr1gw2WVg+O/ZIjhh0E8JKygPPSOP3pFlkqab
         kfxjIOHo0Sv9doFiPsu+NDxXddWKKNPHIn6U8xOX2w9NwnGQ20L0WztKOQaX0wT0qJlm
         U+1+F4M/p0BVN9ekWz6cal45avjJUKuQDjldl2CdngZOFC3a2GO1FHTsoXNpYp6f8C3E
         SF8TRotC8a3FjWTAbLWogJeBNhq5SCc6ZKIrAZJu2+rBS3MP+U91mHXcalDcUtLHqcre
         1ldxZdgFqW7UlqYVpbV4wKLhuqoZg6L3sCtupOjdGnZ1g4B9LPzQEJ83/iiO1CefHnS2
         +87Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=zq1OSYqXH0ZMOnbEBvZSWUC9RaDrbFy9EOSYIIfRujM=;
        b=VLGVvElwUKRl4+gjMJ8sxJLDMaEu1cEV/Awp4puexkOmcxNaqQvwuDAHXnwGD2Zfu1
         8hPQFW4WSbHZ9vEIb1uv9IvgzQeULgkDIqdW3c/9M9cAvnYIMCmd0jKh08HHOtjd9nnK
         jXTSFTyn9n22FsftM2bOoTNjMwx9oPK/NywNN8VYVqawV5w/UtbfxcXEKp+gBEK51nfY
         yPzvJQxUHWxM8PgX+9x+RCjc0hPe+4kf7rZB9yAgB8k/8NDhMfxoebtqMcOhK+ZuzfP3
         c8dGLMl4NzPo3rq4XVxAjaJlWBWwydLBP6/oxOhEpWrDYXNvGRWOmzxPgMOoUyr42VFb
         oMzQ==
X-Gm-Message-State: APjAAAX2HAbkQ3UYI9sZiUHjr1W9QInSxn4XPUxa7bVu8J9Ccja25Xr1
        Ks52DnfnWp8O+qe+CZQXqfSTWQ==
X-Google-Smtp-Source: APXvYqybth+jhEWHhwFrFaUJu5dJ/QGrG4exga56c7ex7CZpTkJLsciZXrDNOmRhiIx6qybE7U0tjw==
X-Received: by 2002:a63:7153:: with SMTP id b19mr4931454pgn.10.1569524619541;
        Thu, 26 Sep 2019 12:03:39 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id t68sm6836764pgt.61.2019.09.26.12.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 12:03:38 -0700 (PDT)
Date:   Thu, 26 Sep 2019 12:03:37 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch for-5.3 0/4] revert immediate fallback to remote
 hugepages
In-Reply-To: <20190925070817.GH23050@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1909261149380.39830@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1909041252230.94813@chino.kir.corp.google.com> <20190904205522.GA9871@redhat.com> <alpine.DEB.2.21.1909051400380.217933@chino.kir.corp.google.com> <20190909193020.GD2063@dhcp22.suse.cz> <20190925070817.GH23050@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Sep 2019, Michal Hocko wrote:

> I am especially interested about this part. The more I think about this
> the more I am convinced that the underlying problem really is in the pre
> mature fallback in the fast path.

I appreciate you taking the time to continue to look at this but I'm 
confused about the underlying problem you're referring to: we had no 
underlying problem until 5.3 was released so we need to carry patches that 
will revert this behavior (we simply can't tolerate double digit memory 
access latency regressions lol).

If you're referring to post-5.3 behavior, this appears to override 
alloc_hugepage_direct_gfpmask() but directly in the page allocator.

static inline gfp_t alloc_hugepage_direct_gfpmask(struct vm_area_struct *vma, unsigned long addr)
{
...
        /*
         * __GFP_THISNODE is used only when __GFP_DIRECT_RECLAIM is not
         * specified, to express a general desire to stay on the current

Your patch is setting __GFP_THISNODE for __GFP_DIRECT_RECLAIM: this 
allocation will fail in the fastpath for both my case (fragmented local 
node) and Andrea's case (out of memory local node).  The first 
get_page_from_freelist() will then succeed in the slowpath for both cases; 
compaction is not tried for either.

In my case, that results in a perpetual remote access latency that we 
can't tolerate.  If Andrea's remote nodes are fragmented or low on memory, 
his case encounters swap storms over both the local node and remote nodes.

So I'm not really sure what is solved by your patch?

We're not on 5.3, but I can try it and collect data on exactly how poorly 
it performs on fragmented *hosts* (not single nodes, but really the whole 
system) because swap storms were never fixed here, it was only papered 
over.

> Does the almost-patch below helps your
> workload? It effectively reduces the fast path for higher order
> allocations to the local/requested node. The justification is that
> watermark check might be too strict for those requests as it is primary
> order-0 oriented. Low watermark target simply has no meaning for the
> higher order requests AFAIU. The min-low gap is giving kswapd a chance
> to balance and be more local node friendly while we do not have anything
> like that in compaction.
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index ff5484fdbdf9..09036cf55fca 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4685,7 +4685,7 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
>  {
>  	struct page *page;
>  	unsigned int alloc_flags = ALLOC_WMARK_LOW;
> -	gfp_t alloc_mask; /* The gfp_t that was actually used for allocation */
> +	gfp_t fastpath_mask, alloc_mask; /* The gfp_t that was actually used for allocation */
>  	struct alloc_context ac = { };
>  
>  	/*
> @@ -4698,7 +4698,7 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
>  	}
>  
>  	gfp_mask &= gfp_allowed_mask;
> -	alloc_mask = gfp_mask;
> +	fastpath_mask = alloc_mask = gfp_mask;
>  	if (!prepare_alloc_pages(gfp_mask, order, preferred_nid, nodemask, &ac, &alloc_mask, &alloc_flags))
>  		return NULL;
>  
> @@ -4710,8 +4710,17 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
>  	 */
>  	alloc_flags |= alloc_flags_nofragment(ac.preferred_zoneref->zone, gfp_mask);
>  
> -	/* First allocation attempt */
> -	page = get_page_from_freelist(alloc_mask, order, alloc_flags, &ac);
> +	/*
> +	 * First allocation attempt. If we have a high order allocation then do not fall
> +	 * back to a remote node just based on the watermark check on the requested node
> +	 * because compaction might easily free up a requested order and then it would be
> +	 * better to simply go to the slow path.
> +	 * TODO: kcompactd should help here but nobody has woken it up unless we hit the
> +	 * slow path so we might need some tuning there as well.
> +	 */
> +	if (order && (gfp_mask & __GFP_DIRECT_RECLAIM))
> +		fastpath_mask |= __GFP_THISNODE;
> +	page = get_page_from_freelist(fastpath_mask, order, alloc_flags, &ac);
>  	if (likely(page))
>  		goto out;
