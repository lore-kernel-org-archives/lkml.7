Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD68CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 11:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF2EC20659
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 11:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730341AbfKALLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 07:11:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:33024 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726720AbfKALLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 07:11:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B54B9B25F;
        Fri,  1 Nov 2019 11:11:47 +0000 (UTC)
Date:   Fri, 1 Nov 2019 11:11:45 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [RFC 01/10] autonuma: Fix watermark checking in
 migrate_balanced_pgdat()
Message-ID: <20191101111145.GN28938@suse.de>
References: <20191101075727.26683-1-ying.huang@intel.com>
 <20191101075727.26683-2-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20191101075727.26683-2-ying.huang@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 03:57:18PM +0800, Huang, Ying wrote:
> From: Huang Ying <ying.huang@intel.com>
> 
> When zone_watermark_ok() is called in migrate_balanced_pgdat() to
> check migration target node, the parameter classzone_idx (for
> requested zone) is specified as 0 (ZONE_DMA).  But when allocating
> memory for autonuma in alloc_misplaced_dst_page(), the requested zone
> from GFP flags is ZONE_MOVABLE.  That is, the requested zone is
> different.  The size of lowmem_reserve for the different requested
> zone is different.  And this may cause some issues.
> 
> For example, in the zoneinfo of a test machine as below,
> 
> Node 0, zone    DMA32
>   pages free     61592
>         min      29
>         low      454
>         high     879
>         spanned  1044480
>         present  442306
>         managed  425921
>         protection: (0, 0, 62457, 62457, 62457)
> 
> The free page number of ZONE_DMA32 is greater than "high watermark +
> lowmem_reserve[ZONE_DMA]", but less than "high watermark +
> lowmem_reserve[ZONE_MOVABLE]".  And because __alloc_pages_node() in
> alloc_misplaced_dst_page() requests ZONE_MOVABLE, the
> zone_watermark_ok() on ZONE_DMA32 in migrate_balanced_pgdat() may
> always return true.  So, autonuma may not stop even when memory
> pressure in node 0 is heavy.
> 
> To fix the issue, ZONE_MOVABLE is used as parameter to call
> zone_watermark_ok() in migrate_balanced_pgdat().  This makes it same
> as requested zone in alloc_misplaced_dst_page().  So that
> migrate_balanced_pgdat() returns false when memory pressure is heavy.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>

Acked-by: Mel Gorman <mgorman@suse.de>

This patch is independent of the series and should be resent separately.
Alternatively Andrew, please pick this patch up on its own.

-- 
Mel Gorman
SUSE Labs
