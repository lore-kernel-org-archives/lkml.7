Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03B8CA9EBD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7883E21D7B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572003836;
	bh=oGf8963/ffh0SXo4J75BA8mJA7B6+pkAReflvOi0+gw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=x5G5gBTwA2jZQi0K3YlN83cZ5AbU9JYxo9xpVTTmYZT1oZNAWlb7rnaDivweWfgNO
	 Q8d1Hdq420rUBCYErs8Qsw5pyZRlC15Q7sExssEvnFhu391PvOfjbIzamSn2kTzAYm
	 I/Nep00Yjx998P3YIc9ugtGXSwsEAzif01Mf1iQw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501993AbfJYLnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 07:43:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:41398 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2501933AbfJYLnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 07:43:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EEFC7AC59;
        Fri, 25 Oct 2019 11:43:52 +0000 (UTC)
Date:   Fri, 25 Oct 2019 13:43:50 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Waiman Long <longman@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mm, vmstat: reduce zone->lock holding time by
 /proc/pagetypeinfo
Message-ID: <20191025114350.GD17610@dhcp22.suse.cz>
References: <192965B3-B446-499C-AEE8-DFF087D46B87@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <192965B3-B446-499C-AEE8-DFF087D46B87@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 25-10-19 07:18:37, Qian Cai wrote:
> ﻿
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
> It was mentioned that developers could use this file is to see the
> movement of those numbers for debugging, so this supposed to introduce
> regressions as there is no movement anymore for those 100k+ items?

Can you provide an explicit example please? As the changelog mentions
it is the "low numbers" that is really interesting when debugging
fragmentation issues. Because we are running out of a respective migrate
type and it is interesting to see why and what compaction is doing etc.

Having more than 100k pages on the respective migrate type list is a
good sign that the migrate type is not in problems. Comparing multiple
migrate types with >100k pages doesn't really need a large precision
AFAIU.

Now, I do agree that some debugging tools might get confused by > in the
output but can we wait for reports and see whether anybody actually
cares? It is more likely that fixing one off debugging tools wouldn't be
a big deal.

-- 
Michal Hocko
SUSE Labs
