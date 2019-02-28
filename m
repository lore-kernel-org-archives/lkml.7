Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECD9C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A64F21850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551362900;
	bh=eIjMgN4sh1vRVFSRAPg/6Z2z72hGcjdsuFpnmuK9FRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cP2Iiik5mFo0+MshgVPseqyYZrTZEdFYp90IaqlCnekBw85LOD/t+95C1PHo93DyY
	 /kaNsquywh/fl2xWHpsxvq1Y8ZcTkzij1S9kasdVGZ4HK+wQj6cjdsRS/TmsR1KOL8
	 92d1Vre3EBU1FYNnSQ0hOb52y7cJp8e57FFQl9hU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732237AbfB1OIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:08:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:44982 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728075AbfB1OIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:08:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7B614ADAA;
        Thu, 28 Feb 2019 14:08:17 +0000 (UTC)
Date:   Thu, 28 Feb 2019 15:08:17 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, david@redhat.com,
        mike.kravetz@oracle.com
Subject: Re: [RFC PATCH] mm,memory_hotplug: Unlock 1GB-hugetlb on x86_64
Message-ID: <20190228140817.GD10588@dhcp22.suse.cz>
References: <20190221094212.16906-1-osalvador@suse.de>
 <20190228092154.GV10588@dhcp22.suse.cz>
 <20190228094104.wbeaowsx25ckpcc7@d104.suse.de>
 <20190228095535.GX10588@dhcp22.suse.cz>
 <20190228101949.qnnzgdhyn6deevnm@d104.suse.de>
 <20190228121115.GA10588@dhcp22.suse.cz>
 <20190228133951.outlsq7swhp3nffr@d104.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228133951.outlsq7swhp3nffr@d104.suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 28-02-19 14:40:54, Oscar Salvador wrote:
> On Thu, Feb 28, 2019 at 01:11:15PM +0100, Michal Hocko wrote:
> > On Thu 28-02-19 11:19:52, Oscar Salvador wrote:
> > > On Thu, Feb 28, 2019 at 10:55:35AM +0100, Michal Hocko wrote:
> > > > You seemed to miss my point or I am wrong here. If scan_movable_pages
> > > > skips over a hugetlb page then there is nothing to migrate it and it
> > > > will stay in the pfn range and the range will not become idle.
> > > 
> > > I might be misunterstanding you, but I am not sure I get you.
> > > 
> > > scan_movable_pages() can either skip or not a hugetlb page.
> > > In case it does, pfn will be incremented to skip the whole hugetlb
> > > range.
> > > If that happens, pfn will hold the next non-hugetlb page.
> > 
> > And as a result the previous hugetlb page doesn't get migrated right?
> > What does that mean? Well, the page is still in use and we cannot
> > proceed with offlining because the full range is not isolated right?
> 
> I might be clumsy today but I still fail to see the point of concern here.

No, it's me who is daft. I have misread the patch and seen that also
page_huge_active got removed. Now it makes perfect sense to me because
active pages are still handled properly.

I will leave the decision whether to split up the patch to you.

Acked-by: Michal Hocko <mhocko@suse.com>

and sorry for being dense here.

-- 
Michal Hocko
SUSE Labs
