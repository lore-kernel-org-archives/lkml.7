Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F27C10F05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F33BA20823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553608725;
	bh=W8fy+juAD7MWXKzh3i6irLB9PyF6m1IeA+OMV8CqpHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ByFYplJo7a+BBzC2yt1hOKkvYKWIUYAOnGqxdLQRCICrH2Ll5dL4fFFn1gN2CzkVX
	 dXAvCnChDfPAR7uvDEoN+yZyCygfH+gjrLarmY2iXStjSsm1s0wVxTPBenta47dXDg
	 Ug3eSHCUAOHjOak/MaApWQrAebXp/3spGMZe7p5s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731571AbfCZN6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 09:58:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:37440 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726175AbfCZN6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 09:58:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1C7FFAC8E;
        Tue, 26 Mar 2019 13:58:40 +0000 (UTC)
Date:   Tue, 26 Mar 2019 14:58:37 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     mgorman@techsingularity.net, riel@surriel.com, hannes@cmpxchg.org,
        akpm@linux-foundation.org, dave.hansen@intel.com,
        keith.busch@intel.com, dan.j.williams@intel.com,
        fengguang.wu@intel.com, fan.du@intel.com, ying.huang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/10] Another Approach to Use PMEM as NUMA Node
Message-ID: <20190326135837.GP28406@dhcp22.suse.cz>
References: <1553316275-21985-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553316275-21985-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 23-03-19 12:44:25, Yang Shi wrote:
> 
> With Dave Hansen's patches merged into Linus's tree
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c221c0b0308fd01d9fb33a16f64d2fd95f8830a4
> 
> PMEM could be hot plugged as NUMA node now. But, how to use PMEM as NUMA node
> effectively and efficiently is still a question. 
> 
> There have been a couple of proposals posted on the mailing list [1] [2].
> 
> The patchset is aimed to try a different approach from this proposal [1]
> to use PMEM as NUMA nodes.
> 
> The approach is designed to follow the below principles:
> 
> 1. Use PMEM as normal NUMA node, no special gfp flag, zone, zonelist, etc.
> 
> 2. DRAM first/by default. No surprise to existing applications and default
> running. PMEM will not be allocated unless its node is specified explicitly
> by NUMA policy. Some applications may be not very sensitive to memory latency,
> so they could be placed on PMEM nodes then have hot pages promote to DRAM
> gradually.

Why are you pushing yourself into the corner right at the beginning? If
the PMEM is exported as a regular NUMA node then the only difference
should be performance characteristics (module durability which shouldn't
play any role in this particular case, right?). Applications which are
already sensitive to memory access should better use proper binding already.
Some NUMA topologies might have quite a large interconnect penalties
already. So this doesn't sound like an argument to me, TBH.

> 5. Control memory allocation and hot/cold pages promotion/demotion on per VMA
> basis.

What does that mean? Anon vs. file backed memory?

[...]

> 2. Introduce a new mempolicy, called MPOL_HYBRID to keep other mempolicy
> semantics intact. We would like to have memory placement control on per process
> or even per VMA granularity. So, mempolicy sounds more reasonable than madvise.
> The new mempolicy is mainly used for launching processes on PMEM nodes then
> migrate hot pages to DRAM nodes via NUMA balancing. MPOL_BIND could bind to
> PMEM nodes too, but migrating to DRAM nodes would just break the semantic of
> it. MPOL_PREFERRED can't constraint the allocation to PMEM nodes. So, it sounds
> a new mempolicy is needed to fulfill the usecase.

The above restriction pushes you to invent an API which is not really
trivial to get right and it seems quite artificial to me already.

> 3. The new mempolicy would promote pages to DRAM via NUMA balancing. IMHO, I
> don't think kernel is a good place to implement sophisticated hot/cold page
> distinguish algorithm due to the complexity and overhead. But, kernel should
> have such capability. NUMA balancing sounds like a good start point.

This is what the kernel does all the time. We call it memory reclaim.

> 4. Promote twice faulted page. Use PG_promote to track if a page is faulted
> twice. This is an optimization to NUMA balancing to reduce the migration
> thrashing and overhead for migrating from PMEM.

I am sorry, but page flags are an extremely scarce resource and a new
flag is extremely hard to get. On the other hand we already do have
use-twice detection for mapped page cache (see page_check_references). I
believe we can generalize that to anon pages as well.

> 5. When DRAM has memory pressure, demote page to PMEM via page reclaim path.
> This is quite similar to other proposals. Then NUMA balancing will promote
> page to DRAM as long as the page is referenced again. But, the
> promotion/demotion still assumes two tier main memory. And, the demotion may
> break mempolicy.

Yes, this sounds like a good idea to me ;)

> 6. Anonymous page only for the time being since NUMA balancing can't promote
> unmapped page cache.

As long as the nvdimm access is faster than the regular storage then
using any node (including pmem one) should be OK.
-- 
Michal Hocko
SUSE Labs
