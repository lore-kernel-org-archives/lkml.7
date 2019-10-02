Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2115EC352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 08:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC848206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 08:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570005621;
	bh=9iYG16RFO8fPLClYXABEDJTEgFb40EFDVuR8BqssZCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PQLUVuF37BjRo3uYmS4DfcfzcqmIEkEjhV3PmMu22FOXHjue/aS/1Bkocbd0eAg1u
	 5IZRe4WvnH15ErIWgWzx7DRTeyawvExMETJPYO3TzgmElaGdXKWlun1yWlaQ0tgsJV
	 4NzlfbBD9sXJerW06/ufFtEVgR9kt8tSEB05puEU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbfJBIkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 04:40:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:37194 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726102AbfJBIkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 04:40:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 35023ACE1;
        Wed,  2 Oct 2019 08:40:16 +0000 (UTC)
Date:   Wed, 2 Oct 2019 10:40:14 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     kirill.shutemov@linux.intel.com, ktkhai@virtuozzo.com,
        hannes@cmpxchg.org, hughd@google.com, shakeelb@google.com,
        rientjes@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm thp: shrink deferred split THPs harder
Message-ID: <20191002084014.GH15624@dhcp22.suse.cz>
References: <1569974210-55366-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569974210-55366-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 02-10-19 07:56:50, Yang Shi wrote:
> The deferred split THPs may get accumulated with some workloads, they
> would get shrunk when memory pressure is hit.  Now we use DEFAULT_SEEKS
> to determine how many objects would get scanned then split if possible,
> but actually they are not like other system cache objects, i.e. inode
> cache which would incur extra I/O if over reclaimed, the unmapped pages
> will not be accessed anymore, so we could shrink them more aggressively.
> 
> We could shrink THPs more pro-actively even though memory pressure is not
> hit, however, IMHO waiting for memory pressure is still a good
> compromise and trade-off.  And, we do have simpler ways to shrink these
> objects harder until we have to take other means do pro-actively drain.
> 
> Change shrinker->seeks to 0 to shrink deferred split THPs harder.

Do you have any numbers on the effect of this patch.

Btw. the whole thing is getting more and more complex and I still
believe the approach is just wrong. We are tunning for something that
doesn't really belong to the memory reclaim in the first place IMHO.
 
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: David Rientjes <rientjes@google.com>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> ---
>  mm/huge_memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 3b78910..1d6b1f1 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2955,7 +2955,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>  static struct shrinker deferred_split_shrinker = {
>  	.count_objects = deferred_split_count,
>  	.scan_objects = deferred_split_scan,
> -	.seeks = DEFAULT_SEEKS,
> +	.seeks = 0,
>  	.flags = SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE |
>  		 SHRINKER_NONSLAB,
>  };
> -- 
> 1.8.3.1

-- 
Michal Hocko
SUSE Labs
