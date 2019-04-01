Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABDE7C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 20:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7211F208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 20:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554149526;
	bh=5cp2rqhvstk1dXsMWA6uo5RKnZDhcKc3VGgJZWgpQEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Rd0vXDd9nSq3UXyoojDAd/AJLUG0IFFgbs7MMmXxH9+NCpWo+APsJeLASO/jg3G4g
	 DBAS6NR8Hjl3rUopFjXkfW34CsAADK+6vpnP21WHZCnE/QmIXlULxj+/K3JFZmbZtX
	 FQmpgj7KinMiKI9TCeOXRjwApOmC6tAi2Dcxgcz0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfDAUMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 16:12:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:56458 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725895AbfDAUME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 16:12:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 615C3AC7E;
        Mon,  1 Apr 2019 20:12:03 +0000 (UTC)
Date:   Mon, 1 Apr 2019 22:12:01 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Matthew Wilcox <willy@infradead.org>, Qian Cai <cai@lca.pw>,
        akpm@linux-foundation.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] kmemleak: survive in a low-memory situation
Message-ID: <20190401201201.GJ28293@dhcp22.suse.cz>
References: <20190327005948.24263-1-cai@lca.pw>
 <20190327084432.GA11927@dhcp22.suse.cz>
 <20190327172955.GB17247@arrakis.emea.arm.com>
 <20190327182158.GS10344@bombadil.infradead.org>
 <20190328145917.GC10283@arrakis.emea.arm.com>
 <20190329120237.GB17624@dhcp22.suse.cz>
 <20190329161637.GC48010@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329161637.GC48010@arrakis.emea.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 29-03-19 16:16:38, Catalin Marinas wrote:
> On Fri, Mar 29, 2019 at 01:02:37PM +0100, Michal Hocko wrote:
> > On Thu 28-03-19 14:59:17, Catalin Marinas wrote:
> > [...]
> > > >From 09eba8f0235eb16409931e6aad77a45a12bedc82 Mon Sep 17 00:00:00 2001
> > > From: Catalin Marinas <catalin.marinas@arm.com>
> > > Date: Thu, 28 Mar 2019 13:26:07 +0000
> > > Subject: [PATCH] mm: kmemleak: Use mempool allocations for kmemleak objects
> > > 
> > > This patch adds mempool allocations for struct kmemleak_object and
> > > kmemleak_scan_area as slightly more resilient than kmem_cache_alloc()
> > > under memory pressure. The patch also masks out all the gfp flags passed
> > > to kmemleak other than GFP_KERNEL|GFP_ATOMIC.
> > 
> > Using mempool allocator is better than inventing its own implementation
> > but there is one thing to be slightly careful/worried about.
> > 
> > This allocator expects that somebody will refill the pool in a finit
> > time. Most users are OK with that because objects in flight are going
> > to return in the pool in a relatively short time (think of an IO) but
> > kmemleak is not guaranteed to comply with that AFAIU. Sure ephemeral
> > allocations are happening all the time so there should be some churn
> > in the pool all the time but if we go to an extreme where there is a
> > serious memory leak then I suspect we might get stuck here without any
> > way forward. Page/slab allocator would eventually back off even though
> > small allocations never fail because a user context would get killed
> > sooner or later but there is no fatal_signal_pending backoff in the
> > mempool alloc path.
> 
> We could improve the mempool code slightly to refill itself (from some
> workqueue or during a mempool_alloc() which allows blocking) but it's
> really just a best effort for a debug tool under OOM conditions. It may
> be sufficient just to make the mempool size tunable (via
> /sys/kernel/debug/kmemleak).

The point I've tried to make is that you really have to fail at some
point but mempool is fundamentally about non-failing as long as the
allocation is sleepable. And we cannot really break that assumptions
because existing users really depend on it. But as I've said I would try
it out and see. This is just a debugging feature and I assume that a
really fatal oom caused by a real memory leak would be detected sooner
than the whole thing just blows up.
-- 
Michal Hocko
SUSE Labs
