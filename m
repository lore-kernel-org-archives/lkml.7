Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B221C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1462F2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404077AbfDRSXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:23:08 -0400
Received: from mga11.intel.com ([192.55.52.93]:64530 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390262AbfDRSW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:22:57 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Apr 2019 11:22:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,367,1549958400"; 
   d="scan'208";a="144017502"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga007.fm.intel.com with ESMTP; 18 Apr 2019 11:22:56 -0700
Date:   Thu, 18 Apr 2019 12:16:43 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        mgorman@techsingularity.net, riel@surriel.com, hannes@cmpxchg.org,
        akpm@linux-foundation.org, dan.j.williams@intel.com,
        fengguang.wu@intel.com, fan.du@intel.com, ying.huang@intel.com,
        ziy@nvidia.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 RFC PATCH 0/9] Another Approach to Use PMEM as NUMA Node
Message-ID: <20190418181643.GB7659@localhost.localdomain>
References: <1554955019-29472-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190412084702.GD13373@dhcp22.suse.cz>
 <a68137bb-dcd8-4e4a-b3a9-69a66f9dccaf@linux.alibaba.com>
 <20190416074714.GD11561@dhcp22.suse.cz>
 <876768ad-a63a-99c3-59de-458403f008c4@linux.alibaba.com>
 <a0bf6b61-1ec2-6209-5760-80c5f205d52e@intel.com>
 <20190417092318.GG655@dhcp22.suse.cz>
 <5c2d37e1-c7f6-5b7b-4f8e-a34e981b841e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c2d37e1-c7f6-5b7b-4f8e-a34e981b841e@intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 10:13:44AM -0700, Dave Hansen wrote:
> On 4/17/19 2:23 AM, Michal Hocko wrote:
> > yes. This could be achieved by GFP_NOWAIT opportunistic allocation for
> > the migration target. That should prevent from loops or artificial nodes
> > exhausting quite naturaly AFAICS. Maybe we will need some tricks to
> > raise the watermark but I am not convinced something like that is really
> > necessary.
> 
> I don't think GFP_NOWAIT alone is good enough.
> 
> Let's say we have a system full of clean page cache and only two nodes:
> 0 and 1.  GFP_NOWAIT will eventually kick off kswapd on both nodes.
> Each kswapd will be migrating pages to the *other* node since each is in
> the other's fallback path.
> 
> I think what you're saying is that, eventually, the kswapds will see
> allocation failures and stop migrating, providing hysteresis.  This is
> probably true.
> 
> But, I'm more concerned about that window where the kswapds are throwing
> pages at each other because they're effectively just wasting resources
> in this window.  I guess we should figure our how large this window is
> and how fast (or if) the dampening occurs in practice.

I'm still refining tests to help answer this and have some preliminary
data. My test rig has CPU + memory Node 0, memory-only Node 1, and a
fast swap device. The test has an application strict mbind more than
the total memory to node 0, and forever writes random cachelines from
per-cpu threads.

I'm testing two memory pressure policies:

  Node 0 can migrate to Node 1, no cycles
  Node 0 and Node 1 migrate with each other (0 -> 1 -> 0 cycles)

After the initial ramp up time, the second policy is ~7-10% slower than
no cycles. There doesn't appear to be a temporary window dealing with
bouncing pages: it's just a slower overall steady state. Looks like when
migration fails and falls back to swap, the newly freed pages occasionaly
get sniped by the other node, keeping the pressure up.
