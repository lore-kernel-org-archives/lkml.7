Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBE6C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1AA218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfGCIiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 04:38:11 -0400
Received: from outbound-smtp15.blacknight.com ([46.22.139.232]:51680 "EHLO
        outbound-smtp15.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726400AbfGCIiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 04:38:11 -0400
Received: from mail.blacknight.com (unknown [81.17.254.11])
        by outbound-smtp15.blacknight.com (Postfix) with ESMTPS id BDD0A1C34A1
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2019 09:38:08 +0100 (IST)
Received: (qmail 31277 invoked from network); 3 Jul 2019 08:38:08 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.36])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 3 Jul 2019 08:38:08 -0000
Date:   Wed, 3 Jul 2019 09:38:03 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hillf Danton <hdanton@sina.com>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm, vmscan: prevent useless kswapd loops
Message-ID: <20190703083803.GA2737@techsingularity.net>
References: <20190701201847.251028-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20190701201847.251028-1-shakeelb@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 01:18:47PM -0700, Shakeel Butt wrote:
> On production we have noticed hard lockups on large machines running
> large jobs due to kswaps hoarding lru lock within isolate_lru_pages when
> sc->reclaim_idx is 0 which is a small zone. The lru was couple hundred
> GiBs and the condition (page_zonenum(page) > sc->reclaim_idx) in
> isolate_lru_pages was basically skipping GiBs of pages while holding the
> LRU spinlock with interrupt disabled.
> 
> On further inspection, it seems like there are two issues:
> 
> 1) If the kswapd on the return from balance_pgdat() could not sleep
> (i.e. node is still unbalanced), the classzone_idx is unintentionally
> set to 0  and the whole reclaim cycle of kswapd will try to reclaim
> only the lowest and smallest zone while traversing the whole memory.
> 
> 2) Fundamentally isolate_lru_pages() is really bad when the allocation
> has woken kswapd for a smaller zone on a very large machine running very
> large jobs. It can hoard the LRU spinlock while skipping over 100s of
> GiBs of pages.
> 
> This patch only fixes the (1). The (2) needs a more fundamental solution.
> To fix (1), in the kswapd context, if pgdat->kswapd_classzone_idx is
> invalid use the classzone_idx of the previous kswapd loop otherwise use
> the one the waker has requested.
> 
> Fixes: e716f2eb24de ("mm, vmscan: prevent kswapd sleeping prematurely
> due to mismatched classzone_idx")
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
