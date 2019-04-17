Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9390C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A7D220652
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555523515;
	bh=alhjzsBTJNyGGje0+kchr4wq2cZcp6GrZacLG8zYlwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=P657AeI763TUzeUh0fjdKennU2HU5pEenXeXL24JG0cOA6GumQthkAabg1waKHY/Y
	 93BKOj5lV1D92NfPn38LSPcj/MEu0lo2maSrJCpyYfuTIQthdW3rAR6iH5g6cimTyu
	 acP9X9k5wyZxHPcYZVNSlYVS5ZdcQRG5gQZyTEPo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733224AbfDQRvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 13:51:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:38802 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731977AbfDQRvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 13:51:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BF352AD3B;
        Wed, 17 Apr 2019 17:51:52 +0000 (UTC)
Date:   Wed, 17 Apr 2019 19:51:51 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Keith Busch <keith.busch@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        mgorman@techsingularity.net, riel@surriel.com, hannes@cmpxchg.org,
        akpm@linux-foundation.org, dan.j.williams@intel.com,
        fengguang.wu@intel.com, fan.du@intel.com, ying.huang@intel.com,
        ziy@nvidia.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 RFC PATCH 0/9] Another Approach to Use PMEM as NUMA Node
Message-ID: <20190417175151.GB9523@dhcp22.suse.cz>
References: <a68137bb-dcd8-4e4a-b3a9-69a66f9dccaf@linux.alibaba.com>
 <20190416074714.GD11561@dhcp22.suse.cz>
 <876768ad-a63a-99c3-59de-458403f008c4@linux.alibaba.com>
 <a0bf6b61-1ec2-6209-5760-80c5f205d52e@intel.com>
 <20190417092318.GG655@dhcp22.suse.cz>
 <20190417152345.GB4786@localhost.localdomain>
 <20190417153923.GO5878@dhcp22.suse.cz>
 <20190417153739.GD4786@localhost.localdomain>
 <20190417163911.GA9523@dhcp22.suse.cz>
 <fcb30853-8039-8154-7ae0-706930642576@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcb30853-8039-8154-7ae0-706930642576@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 17-04-19 10:26:05, Yang Shi wrote:
> 
> 
> On 4/17/19 9:39 AM, Michal Hocko wrote:
> > On Wed 17-04-19 09:37:39, Keith Busch wrote:
> > > On Wed, Apr 17, 2019 at 05:39:23PM +0200, Michal Hocko wrote:
> > > > On Wed 17-04-19 09:23:46, Keith Busch wrote:
> > > > > On Wed, Apr 17, 2019 at 11:23:18AM +0200, Michal Hocko wrote:
> > > > > > On Tue 16-04-19 14:22:33, Dave Hansen wrote:
> > > > > > > Keith Busch had a set of patches to let you specify the demotion order
> > > > > > > via sysfs for fun.  The rules we came up with were:
> > > > > > I am not a fan of any sysfs "fun"
> > > > > I'm hung up on the user facing interface, but there should be some way a
> > > > > user decides if a memory node is or is not a migrate target, right?
> > > > Why? Or to put it differently, why do we have to start with a user
> > > > interface at this stage when we actually barely have any real usecases
> > > > out there?
> > > The use case is an alternative to swap, right? The user has to decide
> > > which storage is the swap target, so operating in the same spirit.
> > I do not follow. If you use rebalancing you can still deplete the memory
> > and end up in a swap storage. If you want to reclaim/swap rather than
> > rebalance then you do not enable rebalancing (by node_reclaim or similar
> > mechanism).
> 
> I'm a little bit confused. Do you mean just do *not* do reclaim/swap in
> rebalancing mode? If rebalancing is on, then node_reclaim just move the
> pages around nodes, then kswapd or direct reclaim would take care of swap?

Yes, that was the idea I wanted to get through. Sorry if that was not
really clear.

> If so the node reclaim on PMEM node may rebalance the pages to DRAM node?
> Should this be allowed?

Why it shouldn't? If there are other vacant Nodes to absorb that memory
then why not use it?

> I think both I and Keith was supposed to treat PMEM as a tier in the reclaim
> hierarchy. The reclaim should push inactive pages down to PMEM, then swap.
> So, PMEM is kind of a "terminal" node. So, he introduced sysfs defined
> target node, I introduced N_CPU_MEM.

I understand that. And I am trying to figure out whether we really have
to tream PMEM specially here. Why is it any better than a generic NUMA
rebalancing code that could be used for many other usecases which are
not PMEM specific. If you present PMEM as a regular memory then also use
it as a normal memory.
-- 
Michal Hocko
SUSE Labs
