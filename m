Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5484C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 07:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B70121D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 07:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569395303;
	bh=6NEvIRTofMvxx5KQe9KgC2Xh1O/df+OTgZqV9a7ij0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EtfW/uIH0AM7GQPn6KEJJ+hSyyJLyA65q277f9rBx6QbI215KiicWEZ3GYMgMk8sS
	 PWiUuOYPkz5qn16j0R/HyDSlH1ey4+WJvmE/eW8m8G7+DcV89kfiGVh0n5Nfq/CZ85
	 yiSWa20u0qk4HjN9iRmva3ve61MJM7wNCD2M0tGk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442463AbfIYHIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 03:08:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:52198 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405152AbfIYHIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 03:08:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EF702AF5A;
        Wed, 25 Sep 2019 07:08:19 +0000 (UTC)
Date:   Wed, 25 Sep 2019 09:08:17 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch for-5.3 0/4] revert immediate fallback to remote hugepages
Message-ID: <20190925070817.GH23050@dhcp22.suse.cz>
References: <alpine.DEB.2.21.1909041252230.94813@chino.kir.corp.google.com>
 <20190904205522.GA9871@redhat.com>
 <alpine.DEB.2.21.1909051400380.217933@chino.kir.corp.google.com>
 <20190909193020.GD2063@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909193020.GD2063@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let me revive this thread as there was no follow up.

On Mon 09-09-19 21:30:20, Michal Hocko wrote:
[...]
> I believe it would be the best to start by explaining why we do not see
> the same problem with order-0 requests. We do not enter the slow path
> and thus the memory reclaim if there is any other node to pass through
> watermakr as well right? So essentially we are relying on kswapd to keep
> nodes balanced so that allocation request can be satisfied from a local
> node. We do have kcompactd to do background compaction. Why do we want
> to rely on the direct compaction instead? What is the fundamental
> difference?

I am especially interested about this part. The more I think about this
the more I am convinced that the underlying problem really is in the pre
mature fallback in the fast path. Does the almost-patch below helps your
workload? It effectively reduces the fast path for higher order
allocations to the local/requested node. The justification is that
watermark check might be too strict for those requests as it is primary
order-0 oriented. Low watermark target simply has no meaning for the
higher order requests AFAIU. The min-low gap is giving kswapd a chance
to balance and be more local node friendly while we do not have anything
like that in compaction.

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ff5484fdbdf9..09036cf55fca 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4685,7 +4685,7 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
 {
 	struct page *page;
 	unsigned int alloc_flags = ALLOC_WMARK_LOW;
-	gfp_t alloc_mask; /* The gfp_t that was actually used for allocation */
+	gfp_t fastpath_mask, alloc_mask; /* The gfp_t that was actually used for allocation */
 	struct alloc_context ac = { };
 
 	/*
@@ -4698,7 +4698,7 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
 	}
 
 	gfp_mask &= gfp_allowed_mask;
-	alloc_mask = gfp_mask;
+	fastpath_mask = alloc_mask = gfp_mask;
 	if (!prepare_alloc_pages(gfp_mask, order, preferred_nid, nodemask, &ac, &alloc_mask, &alloc_flags))
 		return NULL;
 
@@ -4710,8 +4710,17 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
 	 */
 	alloc_flags |= alloc_flags_nofragment(ac.preferred_zoneref->zone, gfp_mask);
 
-	/* First allocation attempt */
-	page = get_page_from_freelist(alloc_mask, order, alloc_flags, &ac);
+	/*
+	 * First allocation attempt. If we have a high order allocation then do not fall
+	 * back to a remote node just based on the watermark check on the requested node
+	 * because compaction might easily free up a requested order and then it would be
+	 * better to simply go to the slow path.
+	 * TODO: kcompactd should help here but nobody has woken it up unless we hit the
+	 * slow path so we might need some tuning there as well.
+	 */
+	if (order && (gfp_mask & __GFP_DIRECT_RECLAIM))
+		fastpath_mask |= __GFP_THISNODE;
+	page = get_page_from_freelist(fastpath_mask, order, alloc_flags, &ac);
 	if (likely(page))
 		goto out;
 
-- 
Michal Hocko
SUSE Labs
