Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994C4C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F5921738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556003997;
	bh=iAlxB2BAyRbTF5o0K830F2Oc7dRzQKAvHqLr+SZlM6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qqR7t2+Jn/CFeOFeUT/QcCEFkRGBw47tlJrrFjJwtEstuPLmXF4jdTgx2PUoRszQJ
	 gkwLkapfiUTAh3XWoh2SwDKf91bbzOjEPdimRtlw74yNERhUOUQWliVawWV4mDhVdA
	 BNBNo5DG8ClTMRbeEeD8OxovVXS6HmYg/L1K9lR0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfDWHT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 03:19:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:34078 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725888AbfDWHTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 03:19:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8EE12AD1A;
        Tue, 23 Apr 2019 07:19:54 +0000 (UTC)
Date:   Tue, 23 Apr 2019 09:19:53 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [Question] Should direct reclaim time be bounded?
Message-ID: <20190423071953.GC25106@dhcp22.suse.cz>
References: <d38a095e-dc39-7e82-bb76-2c9247929f07@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d38a095e-dc39-7e82-bb76-2c9247929f07@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 22-04-19 21:07:28, Mike Kravetz wrote:
[...]
> However, consider the case of a 2 node system where:
> node 0 has 2GB memory
> node 1 has 4GB memory
> 
> Now, if one wants to allocate 4GB of huge pages they may be tempted to simply,
> "echo 2048 > nr_hugepages".  At first this will go well until node 0 is out
> of memory.  When this happens, alloc_pool_huge_page() will continue to be
> called.  Because of that for_each_node_mask_to_alloc() macro, it will likely
> attempt to first allocate a page from node 0.  It will call direct reclaim and
> compaction until it fails.  Then, it will successfully allocate from node 1.

Yeah, the even distribution is quite a strong statement. We just try to
distribute somehow and it is likely to not work really great on system
with nodes that are different in size. I know it sucks but I've been
recommending to use the /sys/devices/system/node/node$N/hugepages/hugepages-2048kB/nr_hugepages
because that allows the define the actual policy much better. I guess we
want to be more specific about this in the documentation at least.

> In our distro kernel, I am thinking about making allocations try "less hard"
> on nodes where we start to see failures.  less hard == NORETRY/NORECLAIM.
> I was going to try something like this on an upstream kernel when I noticed
> that it seems like direct reclaim may never end/exit.  It 'may' exit, but I
> instrumented __alloc_pages_slowpath() and saw it take well over an hour
> before I 'tricked' it into exiting.
> 
> [ 5916.248341] hpage_slow_alloc: jiffies 5295742  tries 2   node 0 success
> [ 5916.249271]                   reclaim 5295741  compact 1

This is unexpected though. What does tries mean? Number of reclaim
attempts? If yes could you enable tracing to see what takes so long in
the reclaim path?

> This is where it stalled after "echo 4096 > nr_hugepages" on a little VM
> with 8GB total memory.
> 
> I have not started looking at the direct reclaim code to see exactly where
> we may be stuck, or trying really hard.  My question is, "Is this expected
> or should direct reclaim be somewhat bounded?"  With __alloc_pages_slowpath
> getting 'stuck' in direct reclaim, the documented behavior for huge page
> allocation is not going to happen.

Well, our "how hard to try for hugetlb pages" is quite arbitrary. We
used to rety as long as at least order worth of pages have been
reclaimed but that didn't make any sense since the lumpy reclaim was
gone. So the semantic has change to reclaim&compact as long as there is
some progress. From what I understad above it seems that you are not
thrashing and calling reclaim again and again but rather one reclaim
round takes ages.

That being said, I do not think __GFP_RETRY_MAYFAIL is wrong here. It
looks like there is something wrong in the reclaim going on.

-- 
Michal Hocko
SUSE Labs
