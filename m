Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D37C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE712183F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbfC2Om4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:42:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37758 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728815AbfC2Omz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 10:42:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D2C96308213E;
        Fri, 29 Mar 2019 14:42:55 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-24.pek2.redhat.com [10.72.12.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 76C775C226;
        Fri, 29 Mar 2019 14:42:53 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, willy@infradead.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v4 1/2] mm/sparse: Clean up the obsolete code comment
Date:   Fri, 29 Mar 2019 22:42:49 +0800
Message-Id: <20190329144250.14315-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 29 Mar 2019 14:42:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code comment above sparse_add_one_section() is obsolete and
incorrect, clean it up and write new one.

Signed-off-by: Baoquan He <bhe@redhat.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
---
v3->v4:
  Improve the doc format further.

 mm/sparse.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 69904aa6165b..cb448c8bb46c 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -684,10 +684,18 @@ static void free_map_bootmem(struct page *memmap)
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
+ * Return:
+ * * 0		- On success.
+ * * -EEXIST	- Section has been present.
+ * * -ENOMEM	- Out of memory.
  */
 int __meminit sparse_add_one_section(int nid, unsigned long start_pfn,
 				     struct vmem_altmap *altmap)
-- 
2.17.2

