Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C595C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C50A20663
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555523868;
	bh=V5GMeGWCLa5Im7kftNfSBFuWwQ+bYlU1N9X07k5ylqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lyRasKM21xp6YqDJ7PwAZVm9+x8FyJCCUiLOMOW0syZiaMjAqDUc4NiAD9KqA471b
	 D4i6nAuQXwDQL1HgLZUab3LfmixgUcPZn+lfXBku0r+EHyJsepIsVgYqN7xLf34hEG
	 ADrkMssHHOllkyAtTZFyOSzVmVeinqO7BNGA+378=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733112AbfDQR5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 13:57:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:39878 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732587AbfDQR5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 13:57:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 60BC9AC63;
        Wed, 17 Apr 2019 17:57:45 +0000 (UTC)
Date:   Wed, 17 Apr 2019 19:57:43 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>, mgorman@techsingularity.net,
        riel@surriel.com, hannes@cmpxchg.org, akpm@linux-foundation.org,
        keith.busch@intel.com, dan.j.williams@intel.com,
        fengguang.wu@intel.com, fan.du@intel.com, ying.huang@intel.com,
        ziy@nvidia.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 RFC PATCH 0/9] Another Approach to Use PMEM as NUMA Node
Message-ID: <20190417175743.GC9523@dhcp22.suse.cz>
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
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 17-04-19 10:13:44, Dave Hansen wrote:
> On 4/17/19 2:23 AM, Michal Hocko wrote:
> >> 3. The demotion path can not have cycles
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

I was thinking along node reclaim like based migration. You are right
that a parallel kswapd might reclaim enough to cause the ping pong and
we might need to play some watermaks tricks but as you say below this is
to be seen and a playground to explore. All I am saying is to try the
most simplistic approach first without all the bells and whistles to see
how this plays out with real workloads and build on top of that.

We already do have model - node_reclaim - which turned out to suck a lot
because the reclaim was just too aggressive wrt. refault. Maybe
migration will turn out much more feasible. And maybe I am completely
wrong and we need a much more complex solution.

> I think what you're saying is that, eventually, the kswapds will see
> allocation failures and stop migrating, providing hysteresis.  This is
> probably true.
> 
> But, I'm more concerned about that window where the kswapds are throwing
> pages at each other because they're effectively just wasting resources
> in this window.  I guess we should figure our how large this window is
> and how fast (or if) the dampening occurs in practice.

-- 
Michal Hocko
SUSE Labs
