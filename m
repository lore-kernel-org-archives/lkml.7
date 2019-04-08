Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A056C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62039218FC
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfDHKMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 06:12:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35518 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbfDHKMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 06:12:39 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BB04559460;
        Mon,  8 Apr 2019 10:12:38 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-53.ams2.redhat.com [10.36.117.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8293F27196;
        Mon,  8 Apr 2019 10:12:34 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Banman <andrew.banman@hpe.com>, mike.travis@hpe.com,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Wei Yang <richard.weiyang@gmail.com>, Qian Cai <cai@lca.pw>,
        Arun KS <arunks@codeaurora.org>,
        Mathieu Malaterre <malat@debian.org>, linux-mm@kvack.org,
        dan.j.williams@intel.com, David Hildenbrand <david@redhat.com>
Subject: [PATCH RFC 1/3] mm/memory_hotplug: Simplify and fix check_hotplug_memory_range()
Date:   Mon,  8 Apr 2019 12:12:24 +0200
Message-Id: <20190408101226.20976-2-david@redhat.com>
In-Reply-To: <20190408101226.20976-1-david@redhat.com>
References: <20190408101226.20976-1-david@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 08 Apr 2019 10:12:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By converting start and size to page granularity, we actually ignore
unaligned parts within a page instead of properly bailing out with an
error.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index f206b8b66af1..680dcc67f9d5 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1070,16 +1070,11 @@ int try_online_node(int nid)
 
 static int check_hotplug_memory_range(u64 start, u64 size)
 {
-	unsigned long block_sz = memory_block_size_bytes();
-	u64 block_nr_pages = block_sz >> PAGE_SHIFT;
-	u64 nr_pages = size >> PAGE_SHIFT;
-	u64 start_pfn = PFN_DOWN(start);
-
 	/* memory range must be block size aligned */
-	if (!nr_pages || !IS_ALIGNED(start_pfn, block_nr_pages) ||
-	    !IS_ALIGNED(nr_pages, block_nr_pages)) {
+	if (!size || !IS_ALIGNED(start, memory_block_size_bytes()) ||
+	    !IS_ALIGNED(size, memory_block_size_bytes())) {
 		pr_err("Block size [%#lx] unaligned hotplug range: start %#llx, size %#llx",
-		       block_sz, start, size);
+		       memory_block_size_bytes(), start, size);
 		return -EINVAL;
 	}
 
-- 
2.17.2

