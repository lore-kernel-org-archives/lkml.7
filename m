Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD17BC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F3C120652
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555519155;
	bh=Q/3gqaZqv4SV/BVu2wczug/fGUeCzBxmiB3zH+pv7q8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=n9lEdecAgmBDiVJzZvU//Qf2SnpMaINvQ9JkUr4/GMo+FVf6RV4C1km/NLdn/qKXq
	 OAG59C66gJdgzkWCAeEWcXzvJmxTDXK0lJxdXZ0SKX6Dyc6LzdZ8wl9yDhS1xyAeO1
	 187E/ttGiPN51FLlHHO51DAor5XegG+Oq+ZcTnpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732844AbfDQQjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 12:39:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:54726 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729641AbfDQQjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 12:39:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A99A9B113;
        Wed, 17 Apr 2019 16:39:12 +0000 (UTC)
Date:   Wed, 17 Apr 2019 18:39:11 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Keith Busch <keith.busch@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        mgorman@techsingularity.net, riel@surriel.com, hannes@cmpxchg.org,
        akpm@linux-foundation.org, dan.j.williams@intel.com,
        fengguang.wu@intel.com, fan.du@intel.com, ying.huang@intel.com,
        ziy@nvidia.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 RFC PATCH 0/9] Another Approach to Use PMEM as NUMA Node
Message-ID: <20190417163911.GA9523@dhcp22.suse.cz>
References: <1554955019-29472-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190412084702.GD13373@dhcp22.suse.cz>
 <a68137bb-dcd8-4e4a-b3a9-69a66f9dccaf@linux.alibaba.com>
 <20190416074714.GD11561@dhcp22.suse.cz>
 <876768ad-a63a-99c3-59de-458403f008c4@linux.alibaba.com>
 <a0bf6b61-1ec2-6209-5760-80c5f205d52e@intel.com>
 <20190417092318.GG655@dhcp22.suse.cz>
 <20190417152345.GB4786@localhost.localdomain>
 <20190417153923.GO5878@dhcp22.suse.cz>
 <20190417153739.GD4786@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417153739.GD4786@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 17-04-19 09:37:39, Keith Busch wrote:
> On Wed, Apr 17, 2019 at 05:39:23PM +0200, Michal Hocko wrote:
> > On Wed 17-04-19 09:23:46, Keith Busch wrote:
> > > On Wed, Apr 17, 2019 at 11:23:18AM +0200, Michal Hocko wrote:
> > > > On Tue 16-04-19 14:22:33, Dave Hansen wrote:
> > > > > Keith Busch had a set of patches to let you specify the demotion order
> > > > > via sysfs for fun.  The rules we came up with were:
> > > > 
> > > > I am not a fan of any sysfs "fun"
> > > 
> > > I'm hung up on the user facing interface, but there should be some way a
> > > user decides if a memory node is or is not a migrate target, right?
> > 
> > Why? Or to put it differently, why do we have to start with a user
> > interface at this stage when we actually barely have any real usecases
> > out there?
> 
> The use case is an alternative to swap, right? The user has to decide
> which storage is the swap target, so operating in the same spirit.

I do not follow. If you use rebalancing you can still deplete the memory
and end up in a swap storage. If you want to reclaim/swap rather than
rebalance then you do not enable rebalancing (by node_reclaim or similar
mechanism).

-- 
Michal Hocko
SUSE Labs
