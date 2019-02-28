Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B22C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 11:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE19E2183F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 11:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731987AbfB1LdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 06:33:07 -0500
Received: from outbound-smtp02.blacknight.com ([81.17.249.8]:40944 "EHLO
        outbound-smtp02.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725945AbfB1LdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 06:33:07 -0500
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp02.blacknight.com (Postfix) with ESMTPS id 46393988D3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 11:33:05 +0000 (UTC)
Received: (qmail 11447 invoked from network); 28 Feb 2019 11:33:05 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.225.79])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 28 Feb 2019 11:33:05 -0000
Date:   Thu, 28 Feb 2019 11:33:03 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v2 2/4] mm: remove zone_lru_lock() function access
 ->lru_lock directly
Message-ID: <20190228113303.GE9565@techsingularity.net>
References: <20190228083329.31892-1-aryabinin@virtuozzo.com>
 <20190228083329.31892-2-aryabinin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20190228083329.31892-2-aryabinin@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 11:33:27AM +0300, Andrey Ryabinin wrote:
> We have common pattern to access lru_lock from a page pointer:
> 	zone_lru_lock(page_zone(page))
> 
> Which is silly, because it unfolds to this:
> 	&NODE_DATA(page_to_nid(page))->node_zones[page_zonenum(page)]->zone_pgdat->lru_lock
> while we can simply do
> 	&NODE_DATA(page_to_nid(page))->lru_lock
> 
> Remove zone_lru_lock() function, since it's only complicate things.
> Use 'page_pgdat(page)->lru_lock' pattern instead.
> 
> Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
