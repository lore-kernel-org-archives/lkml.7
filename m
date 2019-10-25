Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB52ACA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B2121D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502569AbfJYMA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 08:00:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:50932 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2409923AbfJYMA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 08:00:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5C5C6AE09;
        Fri, 25 Oct 2019 12:00:26 +0000 (UTC)
Date:   Fri, 25 Oct 2019 13:00:23 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Qian Cai <cai@lca.pw>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 2/2] mm, vmstat: reduce zone->lock holding time by
 /proc/pagetypeinfo
Message-ID: <20191025120023.GD28938@suse.de>
References: <192965B3-B446-499C-AEE8-DFF087D46B87@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <192965B3-B446-499C-AEE8-DFF087D46B87@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 07:18:37AM -0400, Qian Cai wrote:
> ???
> 
> > On Oct 25, 2019, at 3:26 AM, Michal Hocko <mhocko@kernel.org> wrote:
> > 
> > Considering the pagetypeinfo is a debugging tool we do not really need
> > exact numbers here. The primary reason to look at the outuput is to see
> > how pageblocks are spread among different migratetypes and low number of
> > pages is much more interesting therefore putting a bound on the number
> > of pages on the free_list sounds like a reasonable tradeoff.
> > 
> > The new output will simply tell
> > [...]
> > Node    6, zone   Normal, type      Movable >100000 >100000 >100000 >100000  41019  31560  23996  10054   3229    983    648
> 
> It was mentioned that developers could use this file is to see the movement of those numbers for debugging, so this supposed to introduce regressions as there is no movement anymore for those 100k+ items?

They would need to be more explicit on what their requirements are. When
the file was first introduced, the main interesting point was to see
an approximate distribution of orders by migration type. The exact
count was not particularly interesting other than knowing whether
there was large numbers at lower orders that could not be recovered
by compaction/drop_caches/hugetlbfs-allocation/memhog-abuse etc and
the distribution of pageblocks by migration type overall. That was my
perspective at least when developing fragmentation avoidance, lumpy
reclaim and later compaction.

-- 
Mel Gorman
SUSE Labs
