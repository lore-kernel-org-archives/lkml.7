Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD2DC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF0F20818
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555058827;
	bh=IAoea2NMhGYn0MALqNfrG4bJU/Sr/YNE0/qHexgJHxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NEcGPVs9F/gP6lO7cGEdVuFiX2g8p2knNS7u2Q7svg6sQUEh5Fki/R2BTiYCvHdLQ
	 O3GMBS1Z/JZVEYhfsfvhB6XWw0M2tHDpbXk/Gjc/VaW+8EpbIkIpAnH9hH0sTNXam+
	 k7/u+dVqNxIUNi73aMV0RCWnZV2bFBcPfu5IFFWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfDLIrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:47:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:58874 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725973AbfDLIrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 04:47:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9CBE5ACBA;
        Fri, 12 Apr 2019 08:47:03 +0000 (UTC)
Date:   Fri, 12 Apr 2019 10:47:02 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     mgorman@techsingularity.net, riel@surriel.com, hannes@cmpxchg.org,
        akpm@linux-foundation.org, dave.hansen@intel.com,
        keith.busch@intel.com, dan.j.williams@intel.com,
        fengguang.wu@intel.com, fan.du@intel.com, ying.huang@intel.com,
        ziy@nvidia.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 RFC PATCH 0/9] Another Approach to Use PMEM as NUMA Node
Message-ID: <20190412084702.GD13373@dhcp22.suse.cz>
References: <1554955019-29472-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554955019-29472-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 11-04-19 11:56:50, Yang Shi wrote:
[...]
> Design
> ======
> Basically, the approach is aimed to spread data from DRAM (closest to local
> CPU) down further to PMEM and disk (typically assume the lower tier storage
> is slower, larger and cheaper than the upper tier) by their hotness.  The
> patchset tries to achieve this goal by doing memory promotion/demotion via
> NUMA balancing and memory reclaim as what the below diagram shows:
> 
>     DRAM <--> PMEM <--> Disk
>       ^                   ^
>       |-------------------|
>                swap
> 
> When DRAM has memory pressure, demote pages to PMEM via page reclaim path.
> Then NUMA balancing will promote pages to DRAM as long as the page is referenced
> again.  The memory pressure on PMEM node would push the inactive pages of PMEM 
> to disk via swap.
> 
> The promotion/demotion happens only between "primary" nodes (the nodes have
> both CPU and memory) and PMEM nodes.  No promotion/demotion between PMEM nodes
> and promotion from DRAM to PMEM and demotion from PMEM to DRAM.
> 
> The HMAT is effectively going to enforce "cpu-less" nodes for any memory range
> that has differentiated performance from the conventional memory pool, or
> differentiated performance for a specific initiator, per Dan Williams.  So,
> assuming PMEM nodes are cpuless nodes sounds reasonable.
> 
> However, cpuless nodes might be not PMEM nodes.  But, actually, memory
> promotion/demotion doesn't care what kind of memory will be the target nodes,
> it could be DRAM, PMEM or something else, as long as they are the second tier
> memory (slower, larger and cheaper than regular DRAM), otherwise it sounds
> pointless to do such demotion.
> 
> Defined "N_CPU_MEM" nodemask for the nodes which have both CPU and memory in
> order to distinguish with cpuless nodes (memory only, i.e. PMEM nodes) and
> memoryless nodes (some architectures, i.e. Power, may have memoryless nodes).
> Typically, memory allocation would happen on such nodes by default unless
> cpuless nodes are specified explicitly, cpuless nodes would be just fallback
> nodes, so they are also as known as "primary" nodes in this patchset.  With
> two tier memory system (i.e. DRAM + PMEM), this sounds good enough to
> demonstrate the promotion/demotion approach for now, and this looks more
> architecture-independent.  But it may be better to construct such node mask
> by reading hardware information (i.e. HMAT), particularly for more complex
> memory hierarchy.

I still believe you are overcomplicating this without a strong reason.
Why cannot we start simple and build from there? In other words I do not
think we really need anything like N_CPU_MEM at all.

I would expect that the very first attempt wouldn't do much more than
migrate to-be-reclaimed pages (without an explicit binding) with a
very optimistic allocation strategy (effectivelly GFP_NOWAIT) and if
that fails then simply give up. All that hooked essentially to the
node_reclaim path with a new node_reclaim mode so that the behavior
would be opt-in. This should be the most simplistic way to start AFAICS
and something people can play with without risking regressions.

Once we see how that behaves in the real world and what kind of corner
case user are able to trigger then we can build on top. E.g. do we want
to migrate from cpuless nodes as well? I am not really sure TBH. On one
hand why not if other nodes are free to hold that memory? Swap out is
more expensive. Anyway this is kind of decision which would rather be
shaped on an existing experience rather than ad-hoc decistion right now.

I would also not touch the numa balancing logic at this stage and rather
see how the current implementation behaves.
-- 
Michal Hocko
SUSE Labs
