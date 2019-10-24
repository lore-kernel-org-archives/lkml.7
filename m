Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547D6CA9EBD
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 18:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2219821929
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 18:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KiR8cBXd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504205AbfJXS7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 14:59:48 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45345 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391713AbfJXS7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 14:59:47 -0400
Received: by mail-pg1-f195.google.com with SMTP id r1so14765335pgj.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 11:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=k6xNtUF9jI9qyms60Is2SLb9trGjLSZ26AnY5k3NkMw=;
        b=KiR8cBXdVm85Y0kEZZhG1oFziSPy/Cbz+rgVJFf0wZbD5lzlqJYj24vksF96PQVdSn
         S+be1phIyjrKAuYKJ88vyWHJSd6zBKDNKbyjl7RMzeJnk1sdZK+3g3EoKC+w2R2b2fdj
         uosethmdStrHWWyfvR05YotUOjjWF1mlTB56giOrSrjXRol1yhcy5d8WuuUfCToiJSJQ
         /c2CIAFvf9qxDun/zNYa4TX3jA00JtPB/pRtWj3TSscngA1DdcDvOSv3oTkDSiFVrHZv
         3Jli+ialvPb6hIEj96c5wX6PwRwE31LZ8VK2eSTtYTbaGpy8Nan8d2SdxuNk5lcqYpNa
         SM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=k6xNtUF9jI9qyms60Is2SLb9trGjLSZ26AnY5k3NkMw=;
        b=k0URBEeksT+qsXPxeqLcHJeApyzSe7GU3ovYKOse2z2+Jl1IvW0KF2EkrfIWAhzdDm
         g4FqpCjS3kTuI8jdeIWkCgnyt4nVlXThnC/Ewb2BA15Xs8sSkF1HU2Zjs8EappEBTxJ9
         jfqdSskMCew+DdWZ+K6Ssw3DdlnzrvtN5C3+q7xZWh0EPzn3ve8KiDivqIYO4u7UI+eC
         izN9ySnrpVOJyINvKljXoa8iE+7bP0lrOVVSzmUSGrza2z9oPJFwxwarfWD/6cw4mhIJ
         ib4cIQdx0ouKNEkkr72zD9QG14TjVCzzLmqnyG8NSkVDuB7wmFOxLASo6rv6yY0/p1Hm
         B1QA==
X-Gm-Message-State: APjAAAXfyjVCQJnwZiCG2PEBC2vRVwtnOLQax7Xfi36NN8RQRXnqfjgR
        xXPCDtJ5iuztDEvTc7pHaHiqxaArCm0=
X-Google-Smtp-Source: APXvYqyAOsOUjUDr9He3KDPr1dMy8xJnqE02iUQAel6Y3KZok/1lK3ubpUKL6eRwBv8kwqGA0+qPAg==
X-Received: by 2002:a17:90a:a00a:: with SMTP id q10mr8756130pjp.108.1571943585110;
        Thu, 24 Oct 2019 11:59:45 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id i16sm29915753pfa.184.2019.10.24.11.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 11:59:44 -0700 (PDT)
Date:   Thu, 24 Oct 2019 11:59:43 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Michal Hocko <mhocko@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [patch for-5.3 0/4] revert immediate fallback to remote
 hugepages
In-Reply-To: <53c4a6ca-a4d0-0862-8744-f999b17d82d8@suse.cz>
Message-ID: <alpine.DEB.2.21.1910241156370.130350@chino.kir.corp.google.com>
References: <20190904205522.GA9871@redhat.com> <alpine.DEB.2.21.1909051400380.217933@chino.kir.corp.google.com> <20190909193020.GD2063@dhcp22.suse.cz> <20190925070817.GH23050@dhcp22.suse.cz> <alpine.DEB.2.21.1909261149380.39830@chino.kir.corp.google.com>
 <20190927074803.GB26848@dhcp22.suse.cz> <CAHk-=wgba5zOJtGBFCBP3Oc1m4ma+AR+80s=hy=BbvNr3GqEmA@mail.gmail.com> <20190930112817.GC15942@dhcp22.suse.cz> <20191001054343.GA15624@dhcp22.suse.cz> <20191001083743.GC15624@dhcp22.suse.cz> <20191018141550.GS5017@dhcp22.suse.cz>
 <53c4a6ca-a4d0-0862-8744-f999b17d82d8@suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2019, Vlastimil Babka wrote:

> From 8bd960e4e8e7e99fe13baf0d00b61910b3ae8d23 Mon Sep 17 00:00:00 2001
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Tue, 1 Oct 2019 14:20:58 +0200
> Subject: [PATCH] mm, thp: tweak reclaim/compaction effort of local-only and
>  all-node allocations
> 
> THP page faults now attempt a __GFP_THISNODE allocation first, which should
> only compact existing free memory, followed by another attempt that can
> allocate from any node using reclaim/compaction effort specified by global
> defrag setting and madvise.
> 
> This patch makes the following changes to the scheme:
> 
> - before the patch, the first allocation relies on a check for pageblock order
>   and __GFP_IO to prevent excessive reclaim. This however affects also the
>   second attempt, which is not limited to single node. Instead of that, reuse
>   the existing check for costly order __GFP_NORETRY allocations, and make sure
>   the first THP attempt uses __GFP_NORETRY. As a side-effect, all costly order
>   __GFP_NORETRY allocations will bail out if compaction needs reclaim, while
>   previously they only bailed out when compaction was deferred due to previous
>   failures. This should be still acceptable within the __GFP_NORETRY semantics.
> 
> - before the patch, the second allocation attempt (on all nodes) was passing
>   __GFP_NORETRY. This is redundant as the check for pageblock order (discussed
>   above) was stronger. It's also contrary to madvise(MADV_HUGEPAGE) which means
>   some effort to allocate THP is requested. After this patch, the second
>   attempt doesn't pass __GFP_THISNODE nor __GFP_NORETRY.
> 
> To sum up, THP page faults now try the following attempt:
> 
> 1. local node only THP allocation with no reclaim, just compaction.
> 2. THP allocation from any node with effort determined by global defrag setting
>    and VMA madvise
> 3. fallback to base pages on any node
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/mempolicy.c  | 16 +++++++++-------
>  mm/page_alloc.c | 24 +++++-------------------
>  2 files changed, 14 insertions(+), 26 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 4ae967bcf954..2c48146f3ee2 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -2129,18 +2129,20 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
>  		nmask = policy_nodemask(gfp, pol);
>  		if (!nmask || node_isset(hpage_node, *nmask)) {
>  			mpol_cond_put(pol);
> +			/*
> +			 * First, try to allocate THP only on local node, but
> +			 * don't reclaim unnecessarily, just compact.
> +			 */
>  			page = __alloc_pages_node(hpage_node,
> -						gfp | __GFP_THISNODE, order);
> +				gfp | __GFP_THISNODE | __GFP_NORETRY, order);
>  
>  			/*
> -			 * If hugepage allocations are configured to always
> -			 * synchronous compact or the vma has been madvised
> -			 * to prefer hugepage backing, retry allowing remote
> -			 * memory as well.
> +			 * If that fails, allow both compaction and reclaim,
> +			 * but on all nodes.
>  			 */
> -			if (!page && (gfp & __GFP_DIRECT_RECLAIM))
> +			if (!page)
>  				page = __alloc_pages_node(hpage_node,
> -						gfp | __GFP_NORETRY, order);
> +								gfp, order);
>  
>  			goto out;
>  		}

Hi Vlastimil,

For the default case where thp enabled is not set to "always" and the VMA 
is not madvised for MADV_HUGEPAGE, how does this prefer to return node 
local pages rather than remote hugepages?  The idea is to optimize for 
access latency when the vma has not been explicitly madvised.

> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index ecc3dbad606b..36d7d852f7b1 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4473,8 +4473,11 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  		if (page)
>  			goto got_pg;
>  
> -		 if (order >= pageblock_order && (gfp_mask & __GFP_IO) &&
> -		     !(gfp_mask & __GFP_RETRY_MAYFAIL)) {
> +		/*
> +		 * Checks for costly allocations with __GFP_NORETRY, which
> +		 * includes some THP page fault allocations
> +		 */
> +		if (costly_order && (gfp_mask & __GFP_NORETRY)) {
>  			/*
>  			 * If allocating entire pageblock(s) and compaction
>  			 * failed because all zones are below low watermarks
> @@ -4495,23 +4498,6 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  			if (compact_result == COMPACT_SKIPPED ||
>  			    compact_result == COMPACT_DEFERRED)
>  				goto nopage;
> -		}
> -
> -		/*
> -		 * Checks for costly allocations with __GFP_NORETRY, which
> -		 * includes THP page fault allocations
> -		 */
> -		if (costly_order && (gfp_mask & __GFP_NORETRY)) {
> -			/*
> -			 * If compaction is deferred for high-order allocations,
> -			 * it is because sync compaction recently failed. If
> -			 * this is the case and the caller requested a THP
> -			 * allocation, we do not want to heavily disrupt the
> -			 * system, so we fail the allocation instead of entering
> -			 * direct reclaim.
> -			 */
> -			if (compact_result == COMPACT_DEFERRED)
> -				goto nopage;
>  
>  			/*
>  			 * Looks like reclaim/compaction is worth trying, but
> -- 
> 2.23.0
> 
> 
