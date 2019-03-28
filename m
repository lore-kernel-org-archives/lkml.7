Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A711C10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B48E20811
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553805626;
	bh=O8H6U/Ueaq/JS4z6RjA914C3f2Ir0rD+xeINB3krpPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=L3Q1R9koE7NArFrnB/mda4M2tTjavPhpT6AYikyBliZg1kvCx+e+nplOBaa0yrRJb
	 P8kOvkMnpnkI1abwy2Gfyt79Tdmj/Xzblxj7+FWEBCW86hoNLeciMlQsH3HlQ8/pd7
	 28feww/pKPNRnwGiYWvznPGxQp02tBmRrgXoPb/w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfC1UkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 16:40:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:33504 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726195AbfC1UkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 16:40:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 20388AC18;
        Thu, 28 Mar 2019 20:40:22 +0000 (UTC)
Date:   Thu, 28 Mar 2019 21:40:20 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        "Du, Fan" <fan.du@intel.com>, "Huang, Ying" <ying.huang@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/10] Another Approach to Use PMEM as NUMA Node
Message-ID: <20190328204020.GD7155@dhcp22.suse.cz>
References: <f08fb981-d129-3357-e93a-a6b233aa9891@linux.alibaba.com>
 <20190327090100.GD11927@dhcp22.suse.cz>
 <CAPcyv4heiUbZvP7Ewoy-Hy=-mPrdjCjEuSw+0rwdOUHdjwetxg@mail.gmail.com>
 <c3690a19-e2a6-7db7-b146-b08aa9b22854@linux.alibaba.com>
 <20190327193918.GP11927@dhcp22.suse.cz>
 <6f8b4c51-3f3c-16f9-ca2f-dbcd08ea23e6@linux.alibaba.com>
 <20190328065802.GQ11927@dhcp22.suse.cz>
 <6487e0f5-aee4-3fea-00f5-c12602b8ad2b@linux.alibaba.com>
 <20190328191206.GC7155@dhcp22.suse.cz>
 <5934ed42-c512-a4c7-cbed-9062065bf276@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5934ed42-c512-a4c7-cbed-9062065bf276@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 28-03-19 12:40:14, Yang Shi wrote:
> 
> 
> On 3/28/19 12:12 PM, Michal Hocko wrote:
> > On Thu 28-03-19 11:58:57, Yang Shi wrote:
> > > 
> > > On 3/27/19 11:58 PM, Michal Hocko wrote:
> > > > On Wed 27-03-19 19:09:10, Yang Shi wrote:
> > > > > One question, when doing demote and promote we need define a path, for
> > > > > example, DRAM <-> PMEM (assume two tier memory). When determining what nodes
> > > > > are "DRAM" nodes, does it make sense to assume the nodes with both cpu and
> > > > > memory are DRAM nodes since PMEM nodes are typically cpuless nodes?
> > > > Do we really have to special case this for PMEM? Why cannot we simply go
> > > > in the zonelist order? In other words why cannot we use the same logic
> > > > for a larger NUMA machine and instead of swapping simply fallback to a
> > > > less contended NUMA node? It can be a regular DRAM, PMEM or whatever
> > > > other type of memory node.
> > > Thanks for the suggestion. It makes sense. However, if we don't specialize a
> > > pmem node, its fallback node may be a DRAM node, then the memory reclaim may
> > > move the inactive page to the DRAM node, it sounds not make too much sense
> > > since memory reclaim would prefer to move downwards (DRAM -> PMEM -> Disk).
> > There are certainly many details to sort out. One thing is how to handle
> > cpuless nodes (e.g. PMEM). Those shouldn't get any direct allocations
> > without an explicit binding, right? My first naive idea would be to only
> 
> Wait a minute. I thought we were arguing about the default allocation node
> mask yesterday. And, the conclusion is PMEM node should not be excluded from
> the node mask. PMEM nodes are cpuless nodes. I think I should replace all
> "PMEM node" to "cpuless node" in the cover letter and commit logs to make it
> explicitly.

No, this is not about the default allocation mask at all. Your
allocations start from a local/mempolicy node. CPUless nodes thus cannot be a
primary node so it will always be only in a fallback zonelist without an
explicit binding.

-- 
Michal Hocko
SUSE Labs
