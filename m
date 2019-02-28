Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F53C10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFBD32171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732221AbfB1JlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 04:41:10 -0500
Received: from nat.nue.novell.com ([195.135.221.2]:7465 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725973AbfB1JlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 04:41:09 -0500
Received: by suse.de (Postfix, from userid 1000)
        id 8B8E943FF; Thu, 28 Feb 2019 10:41:08 +0100 (CET)
Date:   Thu, 28 Feb 2019 10:41:08 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, david@redhat.com,
        mike.kravetz@oracle.com
Subject: Re: [RFC PATCH] mm,memory_hotplug: Unlock 1GB-hugetlb on x86_64
Message-ID: <20190228094104.wbeaowsx25ckpcc7@d104.suse.de>
References: <20190221094212.16906-1-osalvador@suse.de>
 <20190228092154.GV10588@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228092154.GV10588@dhcp22.suse.cz>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 10:21:54AM +0100, Michal Hocko wrote:
> On Thu 21-02-19 10:42:12, Oscar Salvador wrote:
> [...]
> > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > index d5f7afda67db..04f6695b648c 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -1337,8 +1337,7 @@ static unsigned long scan_movable_pages(unsigned long start, unsigned long end)
> >  		if (!PageHuge(page))
> >  			continue;
> >  		head = compound_head(page);
> > -		if (hugepage_migration_supported(page_hstate(head)) &&
> > -		    page_huge_active(head))
> > +		if (page_huge_active(head))
> >  			return pfn;
> >  		skip = (1 << compound_order(head)) - (page - head);
> >  		pfn += skip - 1;
> 
> Is this part correct? Say we have a gigantic page which is migrateable.
> Now scan_movable_pages would skip it and we will not migrate it, no?

All non-migrateable hugepages should have been caught in has_unmovable_pages:

<--
                if (PageHuge(page)) {
                        struct page *head = compound_head(page);
                        unsigned int skip_pages;

                        if (!hugepage_migration_supported(page_hstate(head)))
                                goto unmovable;
-->

So, there is no need to check again for migrateability here, as it is something
that does not change.
To put it in another way, all huge pages found in scan_movable_pages() should be
migrateable.
In scan_movable_pages() we just need to check whether the hugepage, gigantic or not, is
in use (aka active) to migrate it.

> 
> > @@ -1378,10 +1377,6 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
> >  
> >  		if (PageHuge(page)) {
> >  			struct page *head = compound_head(page);
> > -			if (compound_order(head) > PFN_SECTION_SHIFT) {
> > -				ret = -EBUSY;
> > -				break;
> > -			}
> >  			pfn = page_to_pfn(head) + (1<<compound_order(head)) - 1;
> >  			isolate_huge_page(head, &source);
> >  			continue;
> 
> I think it would be much easier to have only this check removed in this
> patch. Because it is obviously bogus and wrong as well. The other check
> might be considered in a separate patch.

I do not have an issue sending both changes separedtly.
I mean, this check is the one we need to remove in order to make 1Gb-hugetlb
offlining to proceed.
The removed check from scan_movable_pages() is only removed because it is redundant
as we already checked for that condition in has_unmovable_pages()
(when isolating the range).

-- 
Oscar Salvador
SUSE L3
