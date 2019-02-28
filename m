Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC9BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CCC721850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731571AbfB1NlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:41:02 -0500
Received: from nat.nue.novell.com ([195.135.221.2]:20100 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726806AbfB1Nkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:40:55 -0500
Received: by suse.de (Postfix, from userid 1000)
        id 698364407; Thu, 28 Feb 2019 14:40:54 +0100 (CET)
Date:   Thu, 28 Feb 2019 14:40:54 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, david@redhat.com,
        mike.kravetz@oracle.com
Subject: Re: [RFC PATCH] mm,memory_hotplug: Unlock 1GB-hugetlb on x86_64
Message-ID: <20190228133951.outlsq7swhp3nffr@d104.suse.de>
References: <20190221094212.16906-1-osalvador@suse.de>
 <20190228092154.GV10588@dhcp22.suse.cz>
 <20190228094104.wbeaowsx25ckpcc7@d104.suse.de>
 <20190228095535.GX10588@dhcp22.suse.cz>
 <20190228101949.qnnzgdhyn6deevnm@d104.suse.de>
 <20190228121115.GA10588@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228121115.GA10588@dhcp22.suse.cz>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 01:11:15PM +0100, Michal Hocko wrote:
> On Thu 28-02-19 11:19:52, Oscar Salvador wrote:
> > On Thu, Feb 28, 2019 at 10:55:35AM +0100, Michal Hocko wrote:
> > > You seemed to miss my point or I am wrong here. If scan_movable_pages
> > > skips over a hugetlb page then there is nothing to migrate it and it
> > > will stay in the pfn range and the range will not become idle.
> > 
> > I might be misunterstanding you, but I am not sure I get you.
> > 
> > scan_movable_pages() can either skip or not a hugetlb page.
> > In case it does, pfn will be incremented to skip the whole hugetlb
> > range.
> > If that happens, pfn will hold the next non-hugetlb page.
> 
> And as a result the previous hugetlb page doesn't get migrated right?
> What does that mean? Well, the page is still in use and we cannot
> proceed with offlining because the full range is not isolated right?

I might be clumsy today but I still fail to see the point of concern here.

Let us start from the beginning.
start_isolate_page_range() will mark the range as isolated unless we happen to have
unmovable pages within it (for the exercise here, that would be non-migreateable hugetlb
pages).

If we pass that point, it means that all hugetlb pages found can really be migrated.
Leter, scan_movable_pages() will scan them, and it will only take those that are
in use (active), as are the ones that we are interested in.
We will skip those who are not being used (non-active).

If it happens that we skip a hugetlb page and we return the next non-hugetlb page
to be migrated, do_migrate_range() will proceed as usual, eventually we will
break the main loop due to having being scanned the whole range, etc.

If it happens that the whole range spans a gigantic hugetlb and it is not in use,
we will skip the whole range, and we will break the main loop by returning "0".
Eitherway, I do not see how this changes the picture.

-- 
Oscar Salvador
SUSE L3
