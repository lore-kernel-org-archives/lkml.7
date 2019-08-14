Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46711C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 15:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A9B42054F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 15:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbfHNPl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 11:41:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59718 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728152AbfHNPlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 11:41:24 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 788F88E592;
        Wed, 14 Aug 2019 15:41:24 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-49.ams2.redhat.com [10.36.116.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A234E80693;
        Wed, 14 Aug 2019 15:41:22 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Arun KS <arunks@codeaurora.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v2 4/5] mm/memory_hotplug: Make sure the pfn is aligned to the order when onlining
Date:   Wed, 14 Aug 2019 17:41:08 +0200
Message-Id: <20190814154109.3448-5-david@redhat.com>
In-Reply-To: <20190814154109.3448-1-david@redhat.com>
References: <20190814154109.3448-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 14 Aug 2019 15:41:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a9cd410a3d29 ("mm/page_alloc.c: memory hotplug: free pages as higher
order") assumed that any PFN we get via memory resources is aligned to
to MAX_ORDER - 1, I am not convinced that is always true. Let's play safe,
check the alignment and fallback to single pages.

Cc: Arun KS <arunks@codeaurora.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 63b1775f7cf8..f245fb50ba7f 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -646,6 +646,9 @@ static int online_pages_range(unsigned long start_pfn, unsigned long nr_pages,
 	 */
 	for (pfn = start_pfn; pfn < end_pfn; pfn += 1ul << order) {
 		order = min(MAX_ORDER - 1, get_order(PFN_PHYS(end_pfn - pfn)));
+		/* __free_pages_core() wants pfns to be aligned to the order */
+		if (unlikely(!IS_ALIGNED(pfn, 1ul << order)))
+			order = 0;
 		(*online_page_callback)(pfn_to_page(pfn), order);
 	}
 
-- 
2.21.0

