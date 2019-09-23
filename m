Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1833C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 13:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A22E20867
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 13:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569245313;
	bh=MK+c5c98R3mKB/oVI11sCbJay3/hNsknO37B6y6Lchs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=amMIG2cuAx8M2wnx4S/S11gjWus+wCKdxy0XZs/hPmldDjAXnXmoHkVoot8I6hWLv
	 uADyTZpBanZ6MtNeNSJiPTrycMzcGt6iMZVI+wCTCFvr73AGTac2TEilIlh0BOxTNQ
	 RpQompQAdFs6JTepOQh9RU7bFxyWkCmxseSnbRgU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407085AbfIWN2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 09:28:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:41904 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405044AbfIWN2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 09:28:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DE0C5B152;
        Mon, 23 Sep 2019 13:28:30 +0000 (UTC)
Date:   Mon, 23 Sep 2019 15:28:30 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC] mm: memcg: add priority for soft limit reclaiming
Message-ID: <20190923132830.GQ6016@dhcp22.suse.cz>
References: <20190919133222.GD15782@dhcp22.suse.cz>
 <20190923130459.11072-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923130459.11072-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 23-09-19 21:04:59, Hillf Danton wrote:
> 
> On Thu, 19 Sep 2019 21:32:31 +0800 Michal Hocko wrote:
> > 
> > On Thu 19-09-19 21:13:32, Hillf Danton wrote:
> > >
> > > Currently memory controler is playing increasingly important role in
> > > how memory is used and how pages are reclaimed on memory pressure.
> > >
> > > In daily works memcg is often created for critical tasks and their pre
> > > configured memory usage is supposed to be met even on memory pressure.
> > > Administrator wants to make it configurable that the pages consumed by
> > > memcg-B can be reclaimed by page allocations invoked not by memcg-A but
> > > by memcg-C.
> > 
> > I am not really sure I understand the usecase well but this sounds like
> > what memory reclaim protection in v2 is aiming at.
> > 

Please describe the usecase. 

> A tipoint to the v2 stuff please.

Documentation/admin-guide/cgroup-v2.rst
 
> > > That configurability is addressed by adding priority for soft limit
> > > reclaiming to make sure that no pages will be reclaimed from memcg of
> > > higer priortiy in favor of memcg of lower priority.
> > 
> > cgroup v1 interfaces are generally frozen and mostly aimed at backward
> > compatibility. I am especially concerned about adding a new way to
> > control soft limit which is known to be misdesigned and unfixable to
> > behave reasonably.
> >
> An URL to the drafts/works about the new way in your git tree.

Whut?
-- 
Michal Hocko
SUSE Labs
