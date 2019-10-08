Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235B2C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 14:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E550520659
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 14:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570546542;
	bh=5fOgwzhfdA5+8PnXOHzasxxh4PswZwiu+EnnYsOmZLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dg8DYrXn7qsDz/MtifiXeVVkouUjnGKt7vbpknJiKCf+e1xYBNd5FIk63dAiJxeAH
	 KI12yvQAx8pw/Zsn0phuUr63KDJD+CdT+3wk/atSr1ifno4RG6A8KPjw+Mpzu7MRWa
	 Y5YHe7437AWcsM32as9KIwt5yAU0+xeNmXesfs2g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfJHOzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 10:55:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:50746 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725908AbfJHOzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 10:55:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 50520ADDC;
        Tue,  8 Oct 2019 14:55:38 +0000 (UTC)
Date:   Tue, 8 Oct 2019 16:55:37 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        kirill.shutemov@linux.intel.com, ktkhai@virtuozzo.com,
        hannes@cmpxchg.org, hughd@google.com, shakeelb@google.com,
        rientjes@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: thp: move deferred split queue to memcg's nodeinfo
Message-ID: <20191008145537.GP6681@dhcp22.suse.cz>
References: <1569968203-64647-1-git-send-email-yang.shi@linux.alibaba.com>
 <20191002084304.GI15624@dhcp22.suse.cz>
 <30421920-4fdb-767a-6ef2-60187932c414@suse.cz>
 <20191007143030.GN2381@dhcp22.suse.cz>
 <20191008144437.fr374cxtpnrnnjsv@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008144437.fr374cxtpnrnnjsv@box>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 08-10-19 17:44:37, Kirill A. Shutemov wrote:
> On Mon, Oct 07, 2019 at 04:30:30PM +0200, Michal Hocko wrote:
> > On Mon 07-10-19 16:19:59, Vlastimil Babka wrote:
> > > On 10/2/19 10:43 AM, Michal Hocko wrote:
> > > > On Wed 02-10-19 06:16:43, Yang Shi wrote:
> > > >> The commit 87eaceb3faa59b9b4d940ec9554ce251325d83fe ("mm: thp: make
> > > >> deferred split shrinker memcg aware") makes deferred split queue per
> > > >> memcg to resolve memcg pre-mature OOM problem.  But, all nodes end up
> > > >> sharing the same queue instead of one queue per-node before the commit.
> > > >> It is not a big deal for memcg limit reclaim, but it may cause global
> > > >> kswapd shrink THPs from a different node.
> > > >>
> > > >> And, 0-day testing reported -19.6% regression of stress-ng's madvise
> > > >> test [1].  I didn't see that much regression on my test box (24 threads,
> > > >> 48GB memory, 2 nodes), with the same test (stress-ng --timeout 1
> > > >> --metrics-brief --sequential 72  --class vm --exclude spawn,exec), I saw
> > > >> average -3% (run the same test 10 times then calculate the average since
> > > >> the test itself may have most 15% variation according to my test)
> > > >> regression sometimes (not every time, sometimes I didn't see regression
> > > >> at all).
> > > >>
> > > >> This might be caused by deferred split queue lock contention.  With some
> > > >> configuration (i.e. just one root memcg) the lock contention my be worse
> > > >> than before (given 2 nodes, two locks are reduced to one lock).
> > > >>
> > > >> So, moving deferred split queue to memcg's nodeinfo to make it NUMA
> > > >> aware again.
> > > >>
> > > >> With this change stress-ng's madvise test shows average 4% improvement
> > > >> sometimes and I didn't see degradation anymore.
> > > > 
> > > > My concern about this getting more and more complex
> > > > (http://lkml.kernel.org/r/20191002084014.GH15624@dhcp22.suse.cz) holds
> > > > here even more. Can we step back and reconsider the whole thing please?
> > > 
> > > What about freeing immediately after split via workqueue and also have a
> > > synchronous version called before going oom? Maybe there would be also
> > > other things that would benefit from this scheme instead of traditional
> > > reclaim and shrinkers?
> > 
> > That is exactly what we have discussed some time ago.
> 
> Yes, I've posted the patch:
> 
> http://lkml.kernel.org/r/20190827125911.boya23eowxhqmopa@box
> 
> But I still not sure that the approach is right. I expect it to trigger
> performance regressions. For system with pleanty of free memory, we will
> just pay split cost for nothing in many cases.

I suspect it got lost in the email thread. Care to send as a separate
RFC patch? We can put it to mm for a cycle or two to see how it behaves.
The patch seems quite simple and straightforward from a very quick
glance. It is a bit of a hack that it piggybacks on top of the shrinker
code which should ideally go away if this approach works but that is a
minor detail.

-- 
Michal Hocko
SUSE Labs
