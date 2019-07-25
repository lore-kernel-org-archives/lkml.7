Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747E7C76194
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 08:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44F8C21951
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 08:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389058AbfGYIF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 04:05:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:53554 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389040AbfGYIF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 04:05:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1B416AFF4;
        Thu, 25 Jul 2019 08:05:55 +0000 (UTC)
Date:   Thu, 25 Jul 2019 09:05:51 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 1/3] mm, reclaim: make should_continue_reclaim
 perform dryrun detection
Message-ID: <20190725080551.GB2708@suse.de>
References: <20190724175014.9935-1-mike.kravetz@oracle.com>
 <20190724175014.9935-2-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20190724175014.9935-2-mike.kravetz@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 10:50:12AM -0700, Mike Kravetz wrote:
> From: Hillf Danton <hdanton@sina.com>
> 
> Address the issue of should_continue_reclaim continuing true too often
> for __GFP_RETRY_MAYFAIL attempts when !nr_reclaimed and nr_scanned.
> This could happen during hugetlb page allocation causing stalls for
> minutes or hours.
> 
> Restructure code so that false will be returned in this case even if
> there are plenty of inactive pages.
> 
> Need better description from Hillf Danton
> Need SOB from Hillf Danton

Agreed that the description could do with improvement. However, it
makes sense that if compaction reports it can make progress that it is
unnecessary to continue reclaiming. There might be side-effects with
allocation latencies in other cases but that would come at the cost of
potential premature reclaim which has consequences of itself. Overall I
think it's an improvement so I'll ack it once it has a S-O-B.

-- 
Mel Gorman
SUSE Labs
