Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BF0C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6252320835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555493002;
	bh=On61lV3a1/bW53ofi1FVyqPg3yLaqDDNipDU4n3m0FI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HF+D+4n0K0bIZHzcgjABI0a5Xk/LWo75qvQKsLrdv3rm5qQmz4wvt8/DAQF91tPdc
	 og7xavJZJZKzNJhJSJ8mtJaIpoinaBkGaP5QWUx+KioSCpNb/MNxHLMmQeJjWl/rbr
	 20Ic6uZqVY4WoU8h9MZssLWFpu4rsrE2QWCr39Ek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731507AbfDQJXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 05:23:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:49832 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727282AbfDQJXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 05:23:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9FF4CB143;
        Wed, 17 Apr 2019 09:23:19 +0000 (UTC)
Date:   Wed, 17 Apr 2019 11:23:18 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>, mgorman@techsingularity.net,
        riel@surriel.com, hannes@cmpxchg.org, akpm@linux-foundation.org,
        keith.busch@intel.com, dan.j.williams@intel.com,
        fengguang.wu@intel.com, fan.du@intel.com, ying.huang@intel.com,
        ziy@nvidia.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 RFC PATCH 0/9] Another Approach to Use PMEM as NUMA Node
Message-ID: <20190417092318.GG655@dhcp22.suse.cz>
References: <1554955019-29472-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190412084702.GD13373@dhcp22.suse.cz>
 <a68137bb-dcd8-4e4a-b3a9-69a66f9dccaf@linux.alibaba.com>
 <20190416074714.GD11561@dhcp22.suse.cz>
 <876768ad-a63a-99c3-59de-458403f008c4@linux.alibaba.com>
 <a0bf6b61-1ec2-6209-5760-80c5f205d52e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0bf6b61-1ec2-6209-5760-80c5f205d52e@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 16-04-19 14:22:33, Dave Hansen wrote:
> On 4/16/19 12:19 PM, Yang Shi wrote:
> > would we prefer to try all the nodes in the fallback order to find the
> > first less contended one (i.e. DRAM0 -> PMEM0 -> DRAM1 -> PMEM1 -> Swap)?
> 
> Once a page went to DRAM1, how would we tell that it originated in DRAM0
> and is following the DRAM0 path rather than the DRAM1 path?
> 
> Memory on DRAM0's path would be:
> 
> 	DRAM0 -> PMEM0 -> DRAM1 -> PMEM1 -> Swap
> 
> Memory on DRAM1's path would be:
> 
> 	DRAM1 -> PMEM1 -> DRAM0 -> PMEM0 -> Swap
> 
> Keith Busch had a set of patches to let you specify the demotion order
> via sysfs for fun.  The rules we came up with were:

I am not a fan of any sysfs "fun"

> 1. Pages keep no history of where they have been

makes sense

> 2. Each node can only demote to one other node

Not really, see my other email. I do not really see any strong reason
why not use the full zonelist to demote to

> 3. The demotion path can not have cycles

yes. This could be achieved by GFP_NOWAIT opportunistic allocation for
the migration target. That should prevent from loops or artificial nodes
exhausting quite naturaly AFAICS. Maybe we will need some tricks to
raise the watermark but I am not convinced something like that is really
necessary.

-- 
Michal Hocko
SUSE Labs
