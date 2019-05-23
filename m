Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA45C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 395752075E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="nybCDTO7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390758AbfEWTkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:40:17 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:47028 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390242AbfEWTVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:21:21 -0400
Received: by mail-pf1-f195.google.com with SMTP id y11so3752384pfm.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 12:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lL8Te4jWRFgZjfe9/dkqTtpuaDV38VTY4jurjNdU+eQ=;
        b=nybCDTO7aDXRp6lHK7Rp/GekCdBec5nSv1vGPL7AsV7BWGRmMpr8oMX+SWJ6tqCnxp
         jt/EQgZyLg/K/j88u5FLG64/VrSYEosF8XbzFGIvlQJCMjRf0M8DXdqVQ0oUX3nK364w
         suGKmmBrQv6I+Xu5NLhb2xkCUBExbI9Af8wkA7jprY9/X+blZhxGA4E28OjASTZk8GlE
         Iahzb/L+uDs18U0kDAkmUp8qhJLYZ5F4/1UjoTtbJKk0g1iO165I9P6yIWQcw2GkvCbc
         fC/I9mmKEN1y/R3Bfw+KQcW7sGZmQYK5tAWCko8OOqiS3XuYAeb6IO5tzxQ3JFMAX/Md
         bKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lL8Te4jWRFgZjfe9/dkqTtpuaDV38VTY4jurjNdU+eQ=;
        b=N1engx0I+vvmzwajVGHVCijFMq0N+UcOqNsgE8KTvOG37p1WoUAuZuKIveHoD/KIil
         uofPz/uRfDSMQ+QZEqPScMCZgSb6FBYkModfTqXycuZJ2wLylAAa1UlI9RGaY3ikyQda
         2ZWtNsA31H5tv8rnA1vvLHvGv4Z/GBLvHlS4rmhczcGkXKSf02OCPlxniwxh8FEouKt/
         1t2feyj7Pts+JvXrPhBlNGyzaTdrFY/5b7Znlvzr941iRfZCoFJ3jbFCO87dbnMsmIUF
         LWqY/+z80PnrTKp9UR9scz8QqcHdHV9IifrjCWFeSx3b4VFMh5m2QDiapqPgGhqlcVCF
         FwHg==
X-Gm-Message-State: APjAAAVNPESsAOWPwOkP1DwLCGUZ0nVOZKoRCMrDiUh9SIIH1/7XTk3R
        V0tFUJLh5sfD2OWOFbxv02kdGQ==
X-Google-Smtp-Source: APXvYqzolr8W2Iv7H9NAdQP2LJzWG37v1LpW8TB3ML8vd7Zcc11Bv520V10CfeBPfFfhU5kPqIXneQ==
X-Received: by 2002:a63:1160:: with SMTP id 32mr100783894pgr.106.1558639280337;
        Thu, 23 May 2019 12:21:20 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::ece])
        by smtp.gmail.com with ESMTPSA id u6sm229294pfa.1.2019.05.23.12.21.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 12:21:19 -0700 (PDT)
Date:   Thu, 23 May 2019 15:21:17 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: xarray breaks thrashing detection and cgroup isolation
Message-ID: <20190523192117.GA5723@cmpxchg.org>
References: <20190523174349.GA10939@cmpxchg.org>
 <20190523183713.GA14517@bombadil.infradead.org>
 <CALvZod4o0sA8CM961ZCCp-Vv+i6awFY0U07oJfXFDiVfFiaZfg@mail.gmail.com>
 <20190523190032.GA7873@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523190032.GA7873@bombadil.infradead.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 12:00:32PM -0700, Matthew Wilcox wrote:
> On Thu, May 23, 2019 at 11:49:41AM -0700, Shakeel Butt wrote:
> > On Thu, May 23, 2019 at 11:37 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Thu, May 23, 2019 at 01:43:49PM -0400, Johannes Weiner wrote:
> > > > I noticed that recent upstream kernels don't account the xarray nodes
> > > > of the page cache to the allocating cgroup, like we used to do for the
> > > > radix tree nodes.
> > > >
> > > > This results in broken isolation for cgrouped apps, allowing them to
> > > > escape their containment and harm other cgroups and the system with an
> > > > excessive build-up of nonresident information.
> > > >
> > > > It also breaks thrashing/refault detection because the page cache
> > > > lives in a different domain than the xarray nodes, and so the shadow
> > > > shrinker can reclaim nonresident information way too early when there
> > > > isn't much cache in the root cgroup.
> > > >
> > > > I'm not quite sure how to fix this, since the xarray code doesn't seem
> > > > to have per-tree gfp flags anymore like the radix tree did. We cannot
> > > > add SLAB_ACCOUNT to the radix_tree_node_cachep slab cache. And the
> > > > xarray api doesn't seem to really support gfp flags, either (xas_nomem
> > > > does, but the optimistic internal allocations have fixed gfp flags).
> > >
> > > Would it be a problem to always add __GFP_ACCOUNT to the fixed flags?
> > > I don't really understand cgroups.
> > 
> > Does xarray cache allocated nodes, something like radix tree's:
> > 
> > static DEFINE_PER_CPU(struct radix_tree_preload, radix_tree_preloads) = { 0, };
> > 
> > For the cached one, no __GFP_ACCOUNT flag.
> 
> No.  That was the point of the XArray conversion; no cached nodes.
> 
> > Also some users of xarray may not want __GFP_ACCOUNT. That's the
> > reason we had __GFP_ACCOUNT for page cache instead of hard coding it
> > in radix tree.
> 
> This is what I don't understand -- why would someone not want
> __GFP_ACCOUNT?  For a shared resource?  But the page cache is a shared
> resource.  So what is a good example of a time when an allocation should
> _not_ be accounted to the cgroup?

We used to cgroup-account every slab charge to cgroups per default,
until we changed it to a whitelist behavior:

commit b2a209ffa605994cbe3c259c8584ba1576d3310c
Author: Vladimir Davydov <vdavydov@virtuozzo.com>
Date:   Thu Jan 14 15:18:05 2016 -0800

    Revert "kernfs: do not account ino_ida allocations to memcg"
    
    Currently, all kmem allocations (namely every kmem_cache_alloc, kmalloc,
    alloc_kmem_pages call) are accounted to memory cgroup automatically.
    Callers have to explicitly opt out if they don't want/need accounting
    for some reason.  Such a design decision leads to several problems:
    
     - kmalloc users are highly sensitive to failures, many of them
       implicitly rely on the fact that kmalloc never fails, while memcg
       makes failures quite plausible.
    
     - A lot of objects are shared among different containers by design.
       Accounting such objects to one of containers is just unfair.
       Moreover, it might lead to pinning a dead memcg along with its kmem
       caches, which aren't tiny, which might result in noticeable increase
       in memory consumption for no apparent reason in the long run.
    
     - There are tons of short-lived objects. Accounting them to memcg will
       only result in slight noise and won't change the overall picture, but
       we still have to pay accounting overhead.
    
    For more info, see
    
     - http://lkml.kernel.org/r/20151105144002.GB15111%40dhcp22.suse.cz
     - http://lkml.kernel.org/r/20151106090555.GK29259@esperanza
    
    Therefore this patchset switches to the white list policy.  Now kmalloc
    users have to explicitly opt in by passing __GFP_ACCOUNT flag.
    
    Currently, the list of accounted objects is quite limited and only
    includes those allocations that (1) are known to be easily triggered
    from userspace and (2) can fail gracefully (for the full list see patch
    no.  6) and it still misses many object types.  However, accounting only
    those objects should be a satisfactory approximation of the behavior we
    used to have for most sane workloads.

The arguments would be the same here. Additional allocation overhead,
memory allocated on behalf of a shared facility, long-lived objects
pinning random, unrelated cgroups indefinitely.

The page cache is a sufficiently big user whose size can be directly
attributed to workload behavior, and can be controlled / reclaimed
under memory pressure. That's why it's accounted.

The same isn't true for random drivers using xarray, ida etc. It
shouldn't be implicit in the xarray semantics.
