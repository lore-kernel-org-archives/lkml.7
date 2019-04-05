Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBFCC282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3436620700
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731559AbfDEQnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 12:43:21 -0400
Received: from foss.arm.com ([217.140.101.70]:53012 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730870AbfDEQnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 12:43:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03EAE168F;
        Fri,  5 Apr 2019 09:43:21 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14B143F68F;
        Fri,  5 Apr 2019 09:43:18 -0700 (PDT)
Date:   Fri, 5 Apr 2019 17:43:16 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Qian Cai <cai@lca.pw>,
        akpm@linux-foundation.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] kmemleak: survive in a low-memory situation
Message-ID: <20190405164316.GJ4906@arrakis.emea.arm.com>
References: <20190327005948.24263-1-cai@lca.pw>
 <20190327084432.GA11927@dhcp22.suse.cz>
 <20190327172955.GB17247@arrakis.emea.arm.com>
 <20190327182158.GS10344@bombadil.infradead.org>
 <20190328145917.GC10283@arrakis.emea.arm.com>
 <20190329120237.GB17624@dhcp22.suse.cz>
 <20190329161637.GC48010@arrakis.emea.arm.com>
 <20190401201201.GJ28293@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401201201.GJ28293@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 10:12:01PM +0200, Michal Hocko wrote:
> On Fri 29-03-19 16:16:38, Catalin Marinas wrote:
> > On Fri, Mar 29, 2019 at 01:02:37PM +0100, Michal Hocko wrote:
> > > On Thu 28-03-19 14:59:17, Catalin Marinas wrote:
> > > [...]
> > > > >From 09eba8f0235eb16409931e6aad77a45a12bedc82 Mon Sep 17 00:00:00 2001
> > > > From: Catalin Marinas <catalin.marinas@arm.com>
> > > > Date: Thu, 28 Mar 2019 13:26:07 +0000
> > > > Subject: [PATCH] mm: kmemleak: Use mempool allocations for kmemleak objects
> > > > 
> > > > This patch adds mempool allocations for struct kmemleak_object and
> > > > kmemleak_scan_area as slightly more resilient than kmem_cache_alloc()
> > > > under memory pressure. The patch also masks out all the gfp flags passed
> > > > to kmemleak other than GFP_KERNEL|GFP_ATOMIC.
> > > 
> > > Using mempool allocator is better than inventing its own implementation
> > > but there is one thing to be slightly careful/worried about.
> > > 
> > > This allocator expects that somebody will refill the pool in a finit
> > > time. Most users are OK with that because objects in flight are going
> > > to return in the pool in a relatively short time (think of an IO) but
> > > kmemleak is not guaranteed to comply with that AFAIU. Sure ephemeral
> > > allocations are happening all the time so there should be some churn
> > > in the pool all the time but if we go to an extreme where there is a
> > > serious memory leak then I suspect we might get stuck here without any
> > > way forward. Page/slab allocator would eventually back off even though
> > > small allocations never fail because a user context would get killed
> > > sooner or later but there is no fatal_signal_pending backoff in the
> > > mempool alloc path.
> > 
> > We could improve the mempool code slightly to refill itself (from some
> > workqueue or during a mempool_alloc() which allows blocking) but it's
> > really just a best effort for a debug tool under OOM conditions. It may
> > be sufficient just to make the mempool size tunable (via
> > /sys/kernel/debug/kmemleak).
> 
> The point I've tried to make is that you really have to fail at some
> point but mempool is fundamentally about non-failing as long as the
> allocation is sleepable. And we cannot really break that assumptions
> because existing users really depend on it. But as I've said I would try
> it out and see. This is just a debugging feature and I assume that a
> really fatal oom caused by a real memory leak would be detected sooner
> than the whole thing just blows up.

I'll first push a patch to use mempool as it is, with a tunable size via
/sys/kernel/debug/kmemleak. I think the better solution would be a
rewrite of the metadata handling in kmemleak to embed it into the slab
object (as per Pekka's suggestion). However, I'll be on holiday until
the 15th, so cannot look into this.

Thanks.

-- 
Catalin
