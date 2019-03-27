Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7403DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CDAF2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbfC0MpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 08:45:24 -0400
Received: from outbound-smtp09.blacknight.com ([46.22.139.14]:55455 "EHLO
        outbound-smtp09.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728385AbfC0MpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 08:45:24 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp09.blacknight.com (Postfix) with ESMTPS id 070431C2D99
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 12:45:22 +0000 (GMT)
Received: (qmail 24906 invoked from network); 27 Mar 2019 12:45:21 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.225.79])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 27 Mar 2019 12:45:21 -0000
Date:   Wed, 27 Mar 2019 12:45:20 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Qian Cai <cai@lca.pw>, linux-mm@kvack.org, vbabka@suse.cz,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Correct zone boundary handling when resetting pageblock
 skip hints
Message-ID: <20190327124520.GN3189@techsingularity.net>
References: <20190327085424.GL3189@techsingularity.net>
 <084b92cd-94e9-f8e5-cce1-862d984c8eac@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <084b92cd-94e9-f8e5-cce1-862d984c8eac@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 05:47:06PM +0530, Anshuman Khandual wrote:
> > @@ -267,20 +268,26 @@ __reset_isolation_pfn(struct zone *zone, unsigned long pfn, bool check_source,
> >  	    get_pageblock_migratetype(page) != MIGRATE_MOVABLE)
> >  		return false;
> >  
> > +	/* Ensure the start of the pageblock or zone is online and valid */
> > +	block_pfn = pageblock_start_pfn(pfn);
> > +	block_page = pfn_to_online_page(max(block_pfn, zone->zone_start_pfn));
> > +	if (block_page) {
> > +		page = block_page;
> > +		pfn = block_pfn;
> > +	}
> > +
> > +	/* Ensure the end of the pageblock or zone is online and valid */
> > +	block_pfn += pageblock_nr_pages;
> > +	block_pfn = min(block_pfn, zone_end_pfn(zone) - 1);
> > +	end_page = pfn_to_online_page(block_pfn);
> > +	if (!end_page)
> > +		return false;
> 
> Should not we check zone against page_zone() from both start and end page here.

The lower address has the max(block_pfn, zone->zone_start_pfn) and the
upper address has the min(block_pfn, zone_end_pfn(zone) - 1) check to
keep the PFN within the zone boundary.

-- 
Mel Gorman
SUSE Labs
