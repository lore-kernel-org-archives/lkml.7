Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C23C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E1AB20835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555492672;
	bh=rY2Zi7SwONQd2/4jf9KV2irDMESG5+NmQ50gNNpfyiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=utySF8Wp9TY02eaJQilTGpC4kkJcUOwqjkC3z3q66uGpUAvc4TBfFmQYdbFYw+ME9
	 wmTcJe4yMvI66HS/CL+zO6prmfG45Vd2TQpG52MXuzkIQnKZ0sFq491Mdtmh81nXHx
	 /u0Y2ZVC1gjgqhrm79A2zxFizSOLg/4X0BrajkF8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731528AbfDQJRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 05:17:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:48362 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726237AbfDQJRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 05:17:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BCCB7AE16;
        Wed, 17 Apr 2019 09:17:49 +0000 (UTC)
Date:   Wed, 17 Apr 2019 11:17:48 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     mgorman@techsingularity.net, riel@surriel.com, hannes@cmpxchg.org,
        akpm@linux-foundation.org, dave.hansen@intel.com,
        keith.busch@intel.com, dan.j.williams@intel.com,
        fengguang.wu@intel.com, fan.du@intel.com, ying.huang@intel.com,
        ziy@nvidia.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 RFC PATCH 0/9] Another Approach to Use PMEM as NUMA Node
Message-ID: <20190417091748.GF655@dhcp22.suse.cz>
References: <1554955019-29472-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190412084702.GD13373@dhcp22.suse.cz>
 <a68137bb-dcd8-4e4a-b3a9-69a66f9dccaf@linux.alibaba.com>
 <20190416074714.GD11561@dhcp22.suse.cz>
 <876768ad-a63a-99c3-59de-458403f008c4@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <876768ad-a63a-99c3-59de-458403f008c4@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 16-04-19 12:19:21, Yang Shi wrote:
> 
> 
> On 4/16/19 12:47 AM, Michal Hocko wrote:
[...]
> > Why cannot we simply demote in the proximity order? Why do you make
> > cpuless nodes so special? If other close nodes are vacant then just use
> > them.
> 
> We could. But, this raises another question, would we prefer to just demote
> to the next fallback node (just try once), if it is contended, then just
> swap (i.e. DRAM0 -> PMEM0 -> Swap); or would we prefer to try all the nodes
> in the fallback order to find the first less contended one (i.e. DRAM0 ->
> PMEM0 -> DRAM1 -> PMEM1 -> Swap)?

I would go with the later. Why, because it is more natural. Because that
is the natural allocation path so I do not see why this shouldn't be the
natural demotion path.

> 
> |------|     |------| |------|        |------|
> |PMEM0|---|DRAM0| --- CPU0 --- CPU1 --- |DRAM1| --- |PMEM1|
> |------|     |------| |------|       |------|
> 
> The first one sounds simpler, and the current implementation does so and
> this needs find out the closest PMEM node by recognizing cpuless node.

Unless you are specifying an explicit nodemask then the allocator will
do the allocation fallback for the migration target for you.

> If we prefer go with the second option, it is definitely unnecessary to
> specialize any node.
> 
> > > > I would expect that the very first attempt wouldn't do much more than
> > > > migrate to-be-reclaimed pages (without an explicit binding) with a
> > > Do you mean respect mempolicy or cpuset when doing demotion? I was wondering
> > > this, but I didn't do so in the current implementation since it may need
> > > walk the rmap to retrieve the mempolicy in the reclaim path. Is there any
> > > easier way to do so?
> > You definitely have to follow policy. You cannot demote to a node which
> > is outside of the cpuset/mempolicy because you are breaking contract
> > expected by the userspace. That implies doing a rmap walk.
> 
> OK, however, this may prevent from demoting unmapped page cache since there
> is no way to find those pages' policy.

I do not really expect that hard numa binding for the page cache is a
usecase we really have to lose sleep over for now.

> And, we have to think about what we should do when the demotion target has
> conflict with the mempolicy.

Simply skip it.

> The easiest way is to just skip those conflict
> pages in demotion. Or we may have to do the demotion one page by one page
> instead of migrating a list of pages.

Yes one page at the time sounds reasonable to me. THis is how we do
reclaim anyway.
-- 
Michal Hocko
SUSE Labs
