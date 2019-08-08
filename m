Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589EBC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 23:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C7592173C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 23:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565305381;
	bh=wZTH8XgTxxxVDsQPmD/QFT6okbtnIXw2oHs1b6PpWBQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=DltqYB3Akhs3T+qLzWlrgD3imeM7UxZ4FbiX3ICz65fdFyo18XiYoUhWsv66BUz59
	 WyVRmOEO1iXWCCO0HYiFYTrhb22rN1j35GNUu2pCcrBiHPQLQoPk7UAFGqUBfhyyy4
	 lme7wJQWCOLbidUsR2uifUx0hUXTReVfdYFzPCDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404541AbfHHXDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 19:03:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:44424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731914AbfHHXC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 19:02:59 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 925222173E;
        Thu,  8 Aug 2019 23:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565305378;
        bh=wZTH8XgTxxxVDsQPmD/QFT6okbtnIXw2oHs1b6PpWBQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UDBUExSYm5sCUD0TghXG06OJsGqPu1AZfFGCiep9coMJJWoxYuTgOrUbpq3rhPlbK
         P4mxpyszZn3CduH+ZquqIGCSZtQsYq2m8lpFlOinhHVXzA5Y6T/Q2/RjMtDHbkfL1T
         HQVHpeuUaWr/qz9fOvQvXscbDoInTLdElTBfNXWU=
Date:   Thu, 8 Aug 2019 16:02:57 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH] mm: memcontrol: flush slab vmstats on kmem offlining
Message-Id: <20190808160257.bce08b5ae1574414f96ee26b@linux-foundation.org>
In-Reply-To: <20190808214706.GA24864@tower.dhcp.thefacebook.com>
References: <20190808203604.3413318-1-guro@fb.com>
        <20190808142146.a328cd673c66d5fdbca26f79@linux-foundation.org>
        <20190808214706.GA24864@tower.dhcp.thefacebook.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Aug 2019 21:47:11 +0000 Roman Gushchin <guro@fb.com> wrote:

> On Thu, Aug 08, 2019 at 02:21:46PM -0700, Andrew Morton wrote:
> > On Thu, 8 Aug 2019 13:36:04 -0700 Roman Gushchin <guro@fb.com> wrote:
> > 
> > > I've noticed that the "slab" value in memory.stat is sometimes 0,
> > > even if some children memory cgroups have a non-zero "slab" value.
> > > The following investigation showed that this is the result
> > > of the kmem_cache reparenting in combination with the per-cpu
> > > batching of slab vmstats.
> > > 
> > > At the offlining some vmstat value may leave in the percpu cache,
> > > not being propagated upwards by the cgroup hierarchy. It means
> > > that stats on ancestor levels are lower than actual. Later when
> > > slab pages are released, the precise number of pages is substracted
> > > on the parent level, making the value negative. We don't show negative
> > > values, 0 is printed instead.
> > > 
> > > To fix this issue, let's flush percpu slab memcg and lruvec stats
> > > on memcg offlining. This guarantees that numbers on all ancestor
> > > levels are accurate and match the actual number of outstanding
> > > slab pages.
> > > 
> > 
> > Looks expensive.  How frequently can these functions be called?
> 
> Once per memcg lifetime.

iirc there are some workloads in which this can be rapid?

> > > +	for_each_node(node)
> > > +		memcg_flush_slab_node_stats(memcg, node);
> > 
> > This loops across all possible CPUs once for each possible node.  Ouch.
> > 
> > Implementing hotplug handlers in here (which is surprisingly simple)
> > brings this down to num_online_nodes * num_online_cpus which is, I
> > think, potentially vastly better.
> >
> 
> Hm, maybe I'm biased because we don't play much with offlining, and
> don't have many NUMA nodes. What's the real world scenario? Disabling
> hyperthreading?

I assume it's machines which could take a large number of CPUs but in
fact have few.  I've asked this in response to many patches down the
ages and have never really got a clear answer.

A concern is that if such machines do exist, it will take a long time
for the regression reports to get to us.  Especially if such machines
are rare.

> Idk, given that it happens once per memcg lifetime, and memcg destruction
> isn't cheap anyway, I'm not sure it worth it. But if you are, I'm happy
> to add hotplug handlers.

I think it's worth taking a look.  As I mentioned, it can turn out to
be stupidly simple.

> I also thought about merging per-memcg stats and per-memcg-per-node stats
> (reading part can aggregate over 2? 4? numa nodes each time). That will
> make everything overall cheaper. But it's a separate topic.

