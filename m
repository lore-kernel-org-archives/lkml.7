Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8104BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 587DD20645
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbfC2I3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 04:29:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37078 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728398AbfC2I3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 04:29:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 389203082E57;
        Fri, 29 Mar 2019 08:29:21 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-24.pek2.redhat.com [10.72.12.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 86BBF379A;
        Fri, 29 Mar 2019 08:29:17 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, rafael@kernel.org, akpm@linux-foundation.org,
        mhocko@suse.com, osalvador@suse.de, rppt@linux.ibm.com,
        willy@infradead.org, fanc.fnst@cn.fujitsu.com,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v3 1/2] mm/sparse: Clean up the obsolete code comment
Date:   Fri, 29 Mar 2019 16:29:14 +0800
Message-Id: <20190329082915.19763-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 29 Mar 2019 08:29:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code comment above sparse_add_one_section() is obsolete and
incorrect, clean it up and write new one.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
v2->v3:
  Normalize the code comment to use '/**' at 1st line of doc
  above function.
v1-v2:
  Add comments to explain what the returned value means for
  each error code.
 mm/sparse.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 69904aa6165b..363f9d31b511 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -684,10 +684,19 @@ static void free_map_bootmem(struct page *memmap)
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 #endif /* CONFIG_SPARSEMEM_VMEMMAP */
 
-/*
- * returns the number of sections whose mem_maps were properly
- * set.  If this is <=0, then that means that the passed-in
- * map was not consumed and must be freed.
+/**
+ * sparse_add_one_section - add a memory section
+ * @nid: The node to add section on
+ * @start_pfn: start pfn of the memory range
+ * @altmap: device page map
+ *
+ * This is only intended for hotplug.
+ *
+ * Returns:
+ *   0 on success.
+ *   Other error code on failure:
+ *     - -EEXIST - section has been present.
+ *     - -ENOMEM - out of memory.
  */
 int __meminit sparse_add_one_section(int nid, unsigned long start_pfn,
 				     struct vmem_altmap *altmap)
-- 
2.17.2

