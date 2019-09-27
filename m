Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B80C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 07:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 440722075D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 07:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569570487;
	bh=F0QrRi4/7x8HmmpqmQR0RuwQ7+F0ujZXutNKd0EAbsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mjUoXIaTp1gOCrDw38stKilrYNVZoGXUxd7o0Wnc81c7r+Wa13MM/zcL8q8sFZFva
	 U1ed3+aX6IP1aDPwdYQ1d354JBJopUi5iSiAwSiTw52sVSXWE3Fqr17fc0KhgM6mTg
	 WzyIwY6f8Mmz3NLjWH9b9Pu6u0DT/zLb5UI7G5/A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfI0HsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 03:48:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:34310 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725769AbfI0HsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 03:48:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 82F4BAD63;
        Fri, 27 Sep 2019 07:48:04 +0000 (UTC)
Date:   Fri, 27 Sep 2019 09:48:03 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch for-5.3 0/4] revert immediate fallback to remote hugepages
Message-ID: <20190927074803.GB26848@dhcp22.suse.cz>
References: <alpine.DEB.2.21.1909041252230.94813@chino.kir.corp.google.com>
 <20190904205522.GA9871@redhat.com>
 <alpine.DEB.2.21.1909051400380.217933@chino.kir.corp.google.com>
 <20190909193020.GD2063@dhcp22.suse.cz>
 <20190925070817.GH23050@dhcp22.suse.cz>
 <alpine.DEB.2.21.1909261149380.39830@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1909261149380.39830@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 26-09-19 12:03:37, David Rientjes wrote:
[...]
> Your patch is setting __GFP_THISNODE for __GFP_DIRECT_RECLAIM: this 
> allocation will fail in the fastpath for both my case (fragmented local 
> node) and Andrea's case (out of memory local node).  The first 
> get_page_from_freelist() will then succeed in the slowpath for both cases; 
> compaction is not tried for either.
> 
> In my case, that results in a perpetual remote access latency that we 
> can't tolerate.  If Andrea's remote nodes are fragmented or low on memory, 
> his case encounters swap storms over both the local node and remote nodes.
> 
> So I'm not really sure what is solved by your patch?

There are two aspects the patch is targeting at. The first is that the
fast path is targeting a higher watermak (WMARK_LOW) so it might
fallback to a remote node easier and then the fast path doesn't wake up
kcompactd so there is no pro-active compaction going on to help future
allocations.

You are right that a fragmented or at min watermark node would fallback
to a remote node even with this patch. I wanted to see how much the
kcompactd can change the overall picture. If this is not sufficient then
maybe we need to drop the first optimistic attempt as well and simply go
right into the light compaction. Something like this on top

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ff5484fdbdf9..61284e7f01ee 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4434,7 +4434,8 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	 * The adjusted alloc_flags might result in immediate success, so try
 	 * that first
 	 */
-	page = get_page_from_freelist(gfp_mask, order, alloc_flags, ac);
+	if (!order)
+		page = get_page_from_freelist(gfp_mask, order, alloc_flags, ac);
 	if (page)
 		goto got_pg;
 
The whole point of handling this in the page allocator directly is to
have a unified solutions rather than have each specific caller invent
its own way to achieve higher locality.
-- 
Michal Hocko
SUSE Labs
