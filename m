Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FAFC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E512082E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfDKIoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 04:44:39 -0400
Received: from outbound-smtp12.blacknight.com ([46.22.139.17]:56122 "EHLO
        outbound-smtp12.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726347AbfDKIoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 04:44:38 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp12.blacknight.com (Postfix) with ESMTPS id 767CB1C1E67
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 09:44:35 +0100 (IST)
Received: (qmail 29726 invoked from network); 11 Apr 2019 08:44:35 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.225.79])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 11 Apr 2019 08:44:35 -0000
Date:   Thu, 11 Apr 2019 09:44:33 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     "Tobin C. Harding" <me@tobin.cc>, Vlastimil Babka <vbabka@suse.cz>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Tejun Heo <tj@kernel.org>, Qian Cai <cai@lca.pw>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] mm: Remove the SLAB allocator
Message-ID: <20190411084433.GC18914@techsingularity.net>
References: <20190410024714.26607-1-tobin@kernel.org>
 <f06aaeae-28c0-9ea4-d795-418ec3362d17@suse.cz>
 <20190410081618.GA25494@eros.localdomain>
 <20190411075556.GO10383@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20190411075556.GO10383@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 09:55:56AM +0200, Michal Hocko wrote:
> > > FWIW, our enterprise kernel use it (latest is 4.12 based), and openSUSE
> > > kernels as well (with openSUSE Tumbleweed that includes latest
> > > kernel.org stables). AFAIK we don't enable SLAB_DEBUG even in general
> > > debug kernel flavours as it's just too slow.
> > 
> > Ok, so that probably already kills this.  Thanks for the response.  No
> > flaming, no swearing, man! and they said LKML was a harsh environment ...
> > 
> > > IIRC last time Mel evaluated switching to SLUB, it wasn't a clear
> > > winner, but I'll just CC him for details :)
> > 
> > Probably don't need to take up too much of Mel's time, if we have one
> > user in production we have to keep it, right.
> 
> Well, I wouldn't be opposed to dropping SLAB. Especially when this is
> not a longterm stable kmalloc implementation anymore. It turned out that
> people want to push features from SLUB back to SLAB and then we are just
> having two featurefull allocators and double the maintenance cost.
> 

Indeed.

> So as long as the performance gap is no longer there and the last data
> from Mel (I am sorry but I cannot find a link handy) suggests that there
> is no overall winner in benchmarks then why to keep them both?
> 

The link isn't public. It was based on kernel 5.0 but I still haven't
gotten around to doing a proper writeup. The very short summary is that
with the defaults, SLUB is either performance-neutral or a win versus slab
which is a big improvement over a few years ago. It's worth noting that
there still is a partial relianace on it using high-order pages to get
that performance. If the max order is 0 then there are cases when SLUB
is a loss *but* even that is not universal.  hackbench using processes
and sockets to communicate seems to be the hardest hit when SLUB is not
using high-order pages. This still allows the possibility that SLUB can
degrade over time if the system gets badly enough fragmented and there
are cases where kcompactd and fragmentation avoidance will be more active
than it was relative to SLAB. Again, this is much better than it was a
few years ago and I'm not aware of bug reports that point to compaction
overhead due to SLUB.

> That being said, if somebody is willing to go and benchmark both
> allocators to confirm Mel's observations and current users of SLAB
> can confirm their workloads do not regress either then let's just drop
> it.
> 

Independent verification would be nice. Of particular interest would be
a real set of networking tests on a high-speed network. The hardware in
the test grid I use doesn't have a fast enough network for me to draw a
reliable conclusion.

-- 
Mel Gorman
SUSE Labs
