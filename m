Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809D6CA9EBA
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC7B21479
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbfJUJsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 05:48:13 -0400
Received: from outbound-smtp06.blacknight.com ([81.17.249.39]:49577 "EHLO
        outbound-smtp06.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727696AbfJUJsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 05:48:12 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp06.blacknight.com (Postfix) with ESMTPS id 9900898917
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 10:48:10 +0100 (IST)
Received: (qmail 32579 invoked from network); 21 Oct 2019 09:48:10 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.19.210])
  by 81.17.254.9 with ESMTPA; 21 Oct 2019 09:48:10 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Borislav Petkov <bp@alien8.de>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 1/3] mm, meminit: Recalculate pcpu batch and high limits after init completes
Date:   Mon, 21 Oct 2019 10:48:06 +0100
Message-Id: <20191021094808.28824-2-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191021094808.28824-1-mgorman@techsingularity.net>
References: <20191021094808.28824-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deferred memory initialisation updates zone->managed_pages during
the initialisation phase but before that finishes, the per-cpu page
allocator (pcpu) calculates the number of pages allocated/freed in
batches as well as the maximum number of pages allowed on a per-cpu list.
As zone->managed_pages is not up to date yet, the pcpu initialisation
calculates inappropriately low batch and high values.

This increases zone lock contention quite severely in some cases with the
degree of severity depending on how many CPUs share a local zone and the
size of the zone. A private report indicated that kernel build times were
excessive with extremely high system CPU usage. A perf profile indicated
that a large chunk of time was lost on zone->lock contention.

This patch recalculates the pcpu batch and high values after deferred
initialisation completes for every populated zone in the system. It
was tested on a 2-socket AMD EPYC 2 machine using a kernel compilation
workload -- allmodconfig and all available CPUs.

mmtests configuration: config-workload-kernbench-max
Configuration was modified to build on a fresh XFS partition.

kernbench
                                5.4.0-rc3              5.4.0-rc3
                                  vanilla           resetpcpu-v2
Amean     user-256    13249.50 (   0.00%)    16401.31 * -23.79%*
Amean     syst-256    14760.30 (   0.00%)     4448.39 *  69.86%*
Amean     elsp-256      162.42 (   0.00%)      119.13 *  26.65%*
Stddev    user-256       42.97 (   0.00%)       19.15 (  55.43%)
Stddev    syst-256      336.87 (   0.00%)        6.71 (  98.01%)
Stddev    elsp-256        2.46 (   0.00%)        0.39 (  84.03%)

                   5.4.0-rc3    5.4.0-rc3
                     vanilla resetpcpu-v2
Duration User       39766.24     49221.79
Duration System     44298.10     13361.67
Duration Elapsed      519.11       388.87

The patch reduces system CPU usage by 69.86% and total build time by
26.65%. The variance of system CPU usage is also much reduced.

Before, this was the breakdown of batch and high values over all zones was.

    256               batch: 1
    256               batch: 63
    512               batch: 7
    256               high:  0
    256               high:  378
    512               high:  42

512 pcpu pagesets had a batch limit of 7 and a high limit of 42. After the patch

    256               batch: 1
    768               batch: 63
    256               high:  0
    768               high:  378

Cc: stable@vger.kernel.org # v4.1+
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/page_alloc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c0b2e0306720..f972076d0f6b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1947,6 +1947,14 @@ void __init page_alloc_init_late(void)
 	/* Block until all are initialised */
 	wait_for_completion(&pgdat_init_all_done_comp);
 
+	/*
+	 * The number of managed pages has changed due to the initialisation
+	 * so the pcpu batch and high limits needs to be updated or the limits
+	 * will be artificially small.
+	 */
+	for_each_populated_zone(zone)
+		zone_pcp_update(zone);
+
 	/*
 	 * We initialized the rest of the deferred pages.  Permanently disable
 	 * on-demand struct page initialization.
-- 
2.16.4

