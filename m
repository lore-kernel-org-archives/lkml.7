Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9F0CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB4B521906
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390531AbfJWIrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 04:47:09 -0400
Received: from outbound-smtp19.blacknight.com ([46.22.139.246]:37006 "EHLO
        outbound-smtp19.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390314AbfJWIrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 04:47:09 -0400
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp19.blacknight.com (Postfix) with ESMTPS id 323481C2582
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 09:47:07 +0100 (IST)
Received: (qmail 28718 invoked from network); 23 Oct 2019 08:47:07 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.19.210])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 23 Oct 2019 08:47:07 -0000
Date:   Wed, 23 Oct 2019 09:47:05 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Borislav Petkov <bp@alien8.de>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lkp@intel.com
Subject: [PATCH] mm, meminit: Recalculate pcpu batch and high limits after
 init completes -fix
Message-ID: <20191023084705.GD3016@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LKP reported the following build problem from two hunks that did not
survive the reshuffling of the series reordering.

 ld: mm/page_alloc.o: in function `page_alloc_init_late':
 mm/page_alloc.c:1956: undefined reference to `zone_pcp_update'

This is a fix for the mmotm patch
mm-meminit-recalculate-pcpu-batch-and-high-limits-after-init-completes.patch

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/page_alloc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f9488efff680..12f3ce09d33d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8627,7 +8627,6 @@ void free_contig_range(unsigned long pfn, unsigned int nr_pages)
 	WARN(count != 0, "%d pages are still in use!\n", count);
 }
 
-#ifdef CONFIG_MEMORY_HOTPLUG
 /*
  * The zone indicated has a new number of managed_pages; batch sizes and percpu
  * page high values need to be recalulated.
@@ -8638,7 +8637,6 @@ void __meminit zone_pcp_update(struct zone *zone)
 	__zone_pcp_update(zone);
 	mutex_unlock(&pcp_batch_high_lock);
 }
-#endif
 
 void zone_pcp_reset(struct zone *zone)
 {
