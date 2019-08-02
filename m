Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87661C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 17:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E93B20880
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 17:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564766096;
	bh=RJ5F0Z8HeRllTFmoyJ/qdw3Zeuzk1T4D+QOe21ZmDAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oTPGynFJgiADT/bqYVljUdikuuzCDatCf/L54wsqjTcK0hYnfbnadU/S56zMRztO7
	 V9jMjNY5SSzxel+KE99uCapbUXVhjRIlwuhy118IxCZNs1WD5gxloJAGrtTB0iKJRO
	 NyknV+mqdoI4fmodfsyDq23eYZ4EtUxQyH+Qt3NA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391596AbfHBROz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 13:14:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:37202 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729364AbfHBROz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 13:14:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E9D3EACC6;
        Fri,  2 Aug 2019 17:14:53 +0000 (UTC)
Date:   Fri, 2 Aug 2019 19:14:51 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH] mm: memcontrol: switch to rcu protection in
 drain_all_stock()
Message-ID: <20190802171451.GN6461@dhcp22.suse.cz>
References: <20190801233513.137917-1-guro@fb.com>
 <20190802080422.GA6461@dhcp22.suse.cz>
 <20190802085947.GC6461@dhcp22.suse.cz>
 <20190802170030.GB28431@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802170030.GB28431@tower.DHCP.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 02-08-19 17:00:34, Roman Gushchin wrote:
> On Fri, Aug 02, 2019 at 10:59:47AM +0200, Michal Hocko wrote:
> > On Fri 02-08-19 10:04:22, Michal Hocko wrote:
> > > On Thu 01-08-19 16:35:13, Roman Gushchin wrote:
> > > > Commit 72f0184c8a00 ("mm, memcg: remove hotplug locking from try_charge")
> > > > introduced css_tryget()/css_put() calls in drain_all_stock(),
> > > > which are supposed to protect the target memory cgroup from being
> > > > released during the mem_cgroup_is_descendant() call.
> > > > 
> > > > However, it's not completely safe. In theory, memcg can go away
> > > > between reading stock->cached pointer and calling css_tryget().
> > > 
> > > I have to remember how is this whole thing supposed to work, it's been
> > > some time since I've looked into that.
> > 
> > OK, I guess I remember now and I do not see how the race is possible.
> > Stock cache is keeping its memcg alive because it elevates the reference
> > counting for each cached charge. And that should keep the whole chain up
> > to the root (of draining) alive, no? Or do I miss something, could you
> > generate a sequence of events that would lead to use-after-free?
> 
> Right, but it's true when you reading a local percpu stock.
> But here we read a remote stock->cached pointer, which can be cleared
> by a remote concurrent drain_local_stock() execution.

OK, I can see how refill_stock can race with drain_all_stock. I am not
sure I see drain_local_stock race because that should be triggered only
from drain_all_stock and only one cpu is allowed to do that. Maybe we
might have scheduled a work from the previous run?

In any case, please document the race in the changelog please. This code
is indeed tricky and a comment would help as well.

-- 
Michal Hocko
SUSE Labs
