Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74AAFC6194
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 02:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96AD521D6C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 02:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YYZerKDj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732975AbfKGCui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 21:50:38 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36255 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbfKGCui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 21:50:38 -0500
Received: by mail-oi1-f196.google.com with SMTP id j7so670351oib.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 18:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sQYI1rvlkC0tvETg67Z/XAN6h11szq8NdU5Qx30NxZU=;
        b=YYZerKDjzOjxCSCwAoDCdu2TpeLULDUr67RM6tHUhnlLSHIOBDTadlb85yJr6p3KJU
         sZNan/dTMTOBCNtqPYuXZywBCYjBQ0SLnnFxutuOOZbgnsEUIUG4y6HKpgH7nO5dPjxE
         G4HeVM6Kx273HLA3YqImK3zSc4BJbz1/RbZPDen67LZuVQ+SY84CED0nULACrZSw/PQ3
         dBSln3MdhgMsS0AfDc7wtnyU/wN2pbolcvfb4til6CDH+N3fJbf49qTWi9QyG1Rmt15U
         +mWPf0rKJNrMMwAv9Rm/TXlP0h5AXYxO45UjiC3K1K+IeKBsBlZGwfSclsNduUR2F59L
         j5+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sQYI1rvlkC0tvETg67Z/XAN6h11szq8NdU5Qx30NxZU=;
        b=BEnkBckzVzmpeM95Cg4y87QsMLf4QRlQ4Et1jRfAvqCxaSvjWLj/2MlTIzyh+KRt/q
         ThGVImn9ruEfVBID9eOSKR+9gipnNJR613FwlqVfdxHgx3k+Th9qHKtgzh9bsdGCiKBn
         S/P9xhJyJvGXLgpZbdEGIuqlxQzS7nl5wDc9HeG5DuywsBdf5ThEYHvjVSJ6vo80YCFs
         Bsb0thf8NPNiVjF8e2BWdRk18drE+5rNbRKy+r4S2/gqbQmYHC6e/9wuDp5vsa7Fj0lx
         swYYNeGVimE/Vl6zLZdIbwIw6zpMZh/oJbgvylpxn2SJ20Un8qspoy8IWysmnkrbbJXJ
         vlwg==
X-Gm-Message-State: APjAAAVo8stcmTdMEDwTa/uqzcf3GVHPuVyILsxPYamJQf7s1HUOWEbb
        071gvcBIRHzat9hcRp1ZVsoUoHuY2A6rUdgLKwOUgg==
X-Google-Smtp-Source: APXvYqw3QsyYHxGsVKebECa3LH0CfrG+k7nGglrhd5DPclI4lQyoHb2KXxlR+2hOtYP7XWrp5IgrFsxWcqcEYjulQZs=
X-Received: by 2002:a05:6808:9ae:: with SMTP id e14mr1108571oig.79.1573095036549;
 Wed, 06 Nov 2019 18:50:36 -0800 (PST)
MIME-Version: 1.0
References: <20190603210746.15800-1-hannes@cmpxchg.org>
In-Reply-To: <20190603210746.15800-1-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 6 Nov 2019 18:50:25 -0800
Message-ID: <CALvZod7821vuP_KcOKZkzKu-6b_kzDPrximi3E-Ld95fd=zbMg@mail.gmail.com>
Subject: Re: [PATCH 00/11] mm: fix page aging across multiple cgroups
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@suse.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 3, 2019 at 2:59 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> When applications are put into unconfigured cgroups for memory
> accounting purposes, the cgrouping itself should not change the
> behavior of the page reclaim code. We expect the VM to reclaim the
> coldest pages in the system. But right now the VM can reclaim hot
> pages in one cgroup while there is eligible cold cache in others.
>
> This is because one part of the reclaim algorithm isn't truly cgroup
> hierarchy aware: the inactive/active list balancing. That is the part
> that is supposed to protect hot cache data from one-off streaming IO.
>
> The recursive cgroup reclaim scheme will scan and rotate the physical
> LRU lists of each eligible cgroup at the same rate in a round-robin
> fashion, thereby establishing a relative order among the pages of all
> those cgroups. However, the inactive/active balancing decisions are
> made locally within each cgroup, so when a cgroup is running low on
> cold pages, its hot pages will get reclaimed - even when sibling
> cgroups have plenty of cold cache eligible in the same reclaim run.
>
> For example:
>
>    [root@ham ~]# head -n1 /proc/meminfo
>    MemTotal:        1016336 kB
>
>    [root@ham ~]# ./reclaimtest2.sh
>    Establishing 50M active files in cgroup A...
>    Hot pages cached: 12800/12800 workingset-a
>    Linearly scanning through 18G of file data in cgroup B:
>    real    0m4.269s
>    user    0m0.051s
>    sys     0m4.182s
>    Hot pages cached: 134/12800 workingset-a
>

Can you share reclaimtest2.sh as well? Maybe a selftest to
monitor/test future changes.


> The streaming IO in B, which doesn't benefit from caching at all,
> pushes out most of the workingset in A.
>
> Solution
>
> This series fixes the problem by elevating inactive/active balancing
> decisions to the toplevel of the reclaim run. This is either a cgroup
> that hit its limit, or straight-up global reclaim if there is physical
> memory pressure. From there, it takes a recursive view of the cgroup
> subtree to decide whether page deactivation is necessary.
>
> In the test above, the VM will then recognize that cgroup B has plenty
> of eligible cold cache, and that thet hot pages in A can be spared:
>
>    [root@ham ~]# ./reclaimtest2.sh
>    Establishing 50M active files in cgroup A...
>    Hot pages cached: 12800/12800 workingset-a
>    Linearly scanning through 18G of file data in cgroup B:
>    real    0m4.244s
>    user    0m0.064s
>    sys     0m4.177s
>    Hot pages cached: 12800/12800 workingset-a
>
> Implementation
>
> Whether active pages can be deactivated or not is influenced by two
> factors: the inactive list dropping below a minimum size relative to
> the active list, and the occurence of refaults.
>
> After some cleanups and preparations, this patch series first moves
> refault detection to the reclaim root, then enforces the minimum
> inactive size based on a recursive view of the cgroup tree's LRUs.
>
> History
>
> Note that this actually never worked correctly in Linux cgroups. In
> the past it worked for global reclaim and leaf limit reclaim only (we
> used to have two physical LRU linkages per page), but it never worked
> for intermediate limit reclaim over multiple leaf cgroups.
>
> We're noticing this now because 1) we're putting everything into
> cgroups for accounting, not just the things we want to control and 2)
> we're moving away from leaf limits that invoke reclaim on individual
> cgroups, toward large tree reclaim, triggered by high-level limits or
> physical memory pressure, that is influenced by local protections such
> as memory.low and memory.min instead.
>
> Requirements
>
> These changes are based on the fast recursive memcg stats merged in
> 5.2-rc1. The patches are against v5.2-rc2-mmots-2019-05-29-20-56-12
> plus the page cache fix in https://lkml.org/lkml/2019/5/24/813.
>
>  include/linux/memcontrol.h |  37 +--
>  include/linux/mmzone.h     |  30 +-
>  include/linux/swap.h       |   2 +-
>  mm/memcontrol.c            |   6 +-
>  mm/page_alloc.c            |   2 +-
>  mm/vmscan.c                | 667 ++++++++++++++++++++++---------------------
>  mm/workingset.c            |  74 +++--
>  7 files changed, 437 insertions(+), 381 deletions(-)
>
>
