Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52D6CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 19:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B318B20882
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 19:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730057AbfJUTjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 15:39:55 -0400
Received: from outbound-smtp05.blacknight.com ([81.17.249.38]:41153 "EHLO
        outbound-smtp05.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726672AbfJUTjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 15:39:55 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp05.blacknight.com (Postfix) with ESMTPS id 8BE2F985A8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 20:39:53 +0100 (IST)
Received: (qmail 14816 invoked from network); 21 Oct 2019 19:39:53 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.19.210])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 21 Oct 2019 19:39:53 -0000
Date:   Mon, 21 Oct 2019 20:39:51 +0100
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
Message-ID: <20191021193951.GB3016@techsingularity.net>
References: <20191021094808.28824-1-mgorman@techsingularity.net>
 <20191021094808.28824-2-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20191021094808.28824-2-mgorman@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LKP reported the following build problem from two hunks that did not
survive the reshuffling of the series reordering.

 ld: mm/page_alloc.o: in function `page_alloc_init_late':
 mm/page_alloc.c:1956: undefined reference to `zone_pcp_update'

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/page_alloc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4179376bb336..e9926bf77463 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8524,7 +8524,6 @@ void free_contig_range(unsigned long pfn, unsigned int nr_pages)
 	WARN(count != 0, "%d pages are still in use!\n", count);
 }
 
-#ifdef CONFIG_MEMORY_HOTPLUG
 /*
  * The zone indicated has a new number of managed_pages; batch sizes and percpu
  * page high values need to be recalulated.
@@ -8535,7 +8534,6 @@ void __meminit zone_pcp_update(struct zone *zone)
 	__zone_pcp_update(zone);
 	mutex_unlock(&pcp_batch_high_lock);
 }
-#endif
 
 void zone_pcp_reset(struct zone *zone)
 {
