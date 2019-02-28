Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731E4C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB802171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551347740;
	bh=zT34ukFZennKH4t1h9q9WlMT/WksdgqEzpYN2Osdm0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cV5ARONvF6JutCYu+2Qjwrk/1Uj8EV4rwIgYL2Zei2c+6sfFR8KmlB+l2bUZ+immY
	 jtonNXi7f1b1fKfR/e7EvvD3QCeF1nehcsNIbVpBIYlsDcqB0Do/acBIzM8mAh6Zqu
	 BvNvsobdW2TN3x22WmO01tVLkdWG6rsJow7vV/Os=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732054AbfB1Jzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 04:55:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:58184 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726135AbfB1Jzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 04:55:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6A0F5AB4C;
        Thu, 28 Feb 2019 09:55:37 +0000 (UTC)
Date:   Thu, 28 Feb 2019 10:55:35 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, david@redhat.com,
        mike.kravetz@oracle.com
Subject: Re: [RFC PATCH] mm,memory_hotplug: Unlock 1GB-hugetlb on x86_64
Message-ID: <20190228095535.GX10588@dhcp22.suse.cz>
References: <20190221094212.16906-1-osalvador@suse.de>
 <20190228092154.GV10588@dhcp22.suse.cz>
 <20190228094104.wbeaowsx25ckpcc7@d104.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228094104.wbeaowsx25ckpcc7@d104.suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 28-02-19 10:41:08, Oscar Salvador wrote:
> On Thu, Feb 28, 2019 at 10:21:54AM +0100, Michal Hocko wrote:
> > On Thu 21-02-19 10:42:12, Oscar Salvador wrote:
> > [...]
> > > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > > index d5f7afda67db..04f6695b648c 100644
> > > --- a/mm/memory_hotplug.c
> > > +++ b/mm/memory_hotplug.c
> > > @@ -1337,8 +1337,7 @@ static unsigned long scan_movable_pages(unsigned long start, unsigned long end)
> > >  		if (!PageHuge(page))
> > >  			continue;
> > >  		head = compound_head(page);
> > > -		if (hugepage_migration_supported(page_hstate(head)) &&
> > > -		    page_huge_active(head))
> > > +		if (page_huge_active(head))
> > >  			return pfn;
> > >  		skip = (1 << compound_order(head)) - (page - head);
> > >  		pfn += skip - 1;
> > 
> > Is this part correct? Say we have a gigantic page which is migrateable.
> > Now scan_movable_pages would skip it and we will not migrate it, no?
> 
> All non-migrateable hugepages should have been caught in has_unmovable_pages:
> 
> <--
>                 if (PageHuge(page)) {
>                         struct page *head = compound_head(page);
>                         unsigned int skip_pages;
> 
>                         if (!hugepage_migration_supported(page_hstate(head)))
>                                 goto unmovable;
> -->
> 
> So, there is no need to check again for migrateability here, as it is something
> that does not change.
> To put it in another way, all huge pages found in scan_movable_pages() should be
> migrateable.
> In scan_movable_pages() we just need to check whether the hugepage, gigantic or not, is
> in use (aka active) to migrate it.

You seemed to miss my point or I am wrong here. If scan_movable_pages
skips over a hugetlb page then there is nothing to migrate it and it
will stay in the pfn range and the range will not become idle.

-- 
Michal Hocko
SUSE Labs
