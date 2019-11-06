Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA287C47E49
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 07:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AECAA217F5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 07:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573025725;
	bh=tSn/w5SW/mmNiyhDfH7SvCgKVaTFQTCA0J0BgcdxKN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BZRfCO1UdZSjawLu1S2MefuzkTaXfrd0+IpM6iwJl5B3DTwWfZXtubIIyf6qey2tt
	 y2Rd51EidFhMJDmhQg5RdLWDym5fwUSjN8cVSKIzI5RjV7U0D5S3xQY5Lsev9zeS7h
	 468hf35vLiC83c5pah/9hrOQJftHsWf+jZEn3SQg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731277AbfKFHfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 02:35:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:60896 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729870AbfKFHfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 02:35:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8E059AE3F;
        Wed,  6 Nov 2019 07:35:22 +0000 (UTC)
Date:   Wed, 6 Nov 2019 08:35:21 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [patch for-5.3 0/4] revert immediate fallback to remote hugepages
Message-ID: <20191106073521.GC8314@dhcp22.suse.cz>
References: <20191001083743.GC15624@dhcp22.suse.cz>
 <20191018141550.GS5017@dhcp22.suse.cz>
 <53c4a6ca-a4d0-0862-8744-f999b17d82d8@suse.cz>
 <alpine.DEB.2.21.1910241156370.130350@chino.kir.corp.google.com>
 <08a3f4dd-c3ce-0009-86c5-9ee51aba8557@suse.cz>
 <20191029151549.GO31513@dhcp22.suse.cz>
 <20191029143351.95f781f09a9fbf254163d728@linux-foundation.org>
 <alpine.DEB.2.21.1910291623050.9914@chino.kir.corp.google.com>
 <20191105130253.GO22672@dhcp22.suse.cz>
 <alpine.DEB.2.21.1911051659010.181254@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1911051659010.181254@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 05-11-19 17:01:00, David Rientjes wrote:
> On Tue, 5 Nov 2019, Michal Hocko wrote:
> 
> > > > Thanks, I'll queue this for some more testing.  At some point we should
> > > > decide on a suitable set of Fixes: tags and a backporting strategy, if any?
> > > > 
> > > 
> > > I'd strongly suggest that Andrea test this patch out on his workload on 
> > > hosts where all nodes are low on memory because based on my understanding 
> > > of his reported issue this would result in swap storms reemerging but 
> > > worse this time because they wouldn't be constrained only locally.  (This 
> > > patch causes us to no longer circumvent excessive reclaim when using 
> > > MADV_HUGEPAGE.)
> > 
> > Could you be more specific on why this would be the case? My testing is
> > doesn't show any such signs and I am effectivelly testing memory low
> > situation. The amount of reclaimed memory matches the amount of
> > requested memory.
> > 
> 
> The follow-up allocation in alloc_pages_vma() would no longer use 
> __GFP_NORETRY and there is no special handling to avoid swap storms in the 
> page allocator anymore as a result of this patch.

Yes there is no __GFP_NORETRY in the fallback path because the control
over how hard to retry is controlled by alloc_hugepage_direct_gfpmask
depending on the defrag mode and madvise mode.

> I don't see any 
> indication that this allocation would behave any different than the code 
> that Andrea experienced swap storms with, but now worse if remote memory 
> is in the same state local memory is when he's using __GFP_THISNODE.

The primary reason for the extensive swapping was exactly the __GFP_THISNODE
in conjunction with an unbounded direct reclaim AFAIR.

The whole point of the Vlastimil's patch is to have an optimistic local
node allocation first and the full gfp context one in the fallback path.
If our full gfp context doesn't really work well then we can revisit
that of course but that should happen at alloc_hugepage_direct_gfpmask
level.
-- 
Michal Hocko
SUSE Labs
