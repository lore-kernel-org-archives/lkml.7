Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14BAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C97EF20857
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731291AbfCZJCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 05:02:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38554 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfCZJCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 05:02:43 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C1AF28762B;
        Tue, 26 Mar 2019 09:02:42 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-21.pek2.redhat.com [10.72.12.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D91EE80A3F;
        Tue, 26 Mar 2019 09:02:38 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@suse.com,
        rppt@linux.ibm.com, osalvador@suse.de, willy@infradead.org,
        william.kucharski@oracle.com, Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 2/4] mm/sparse: Optimize sparse_add_one_section()
Date:   Tue, 26 Mar 2019 17:02:25 +0800
Message-Id: <20190326090227.3059-3-bhe@redhat.com>
In-Reply-To: <20190326090227.3059-1-bhe@redhat.com>
References: <20190326090227.3059-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 26 Mar 2019 09:02:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorder the allocation of usemap and memmap since usemap allocation
is much simpler and easier. Otherwise hard work is done to make
memmap ready, then have to rollback just because of usemap allocation
failure.

And also check if section is present earlier. Then don't bother to
allocate usemap and memmap if yes.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
v1->v2:
  Do section existence checking earlier to further optimize code.

 mm/sparse.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index b2111f996aa6..f4f34d69131e 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -714,20 +714,18 @@ int __meminit sparse_add_one_section(int nid, unsigned long start_pfn,
 	ret = sparse_index_init(section_nr, nid);
 	if (ret < 0 && ret != -EEXIST)
 		return ret;
-	ret = 0;
-	memmap = kmalloc_section_memmap(section_nr, nid, altmap);
-	if (!memmap)
-		return -ENOMEM;
-	usemap = __kmalloc_section_usemap();
-	if (!usemap) {
-		__kfree_section_memmap(memmap, altmap);
-		return -ENOMEM;
-	}
 
 	ms = __pfn_to_section(start_pfn);
-	if (ms->section_mem_map & SECTION_MARKED_PRESENT) {
-		ret = -EEXIST;
-		goto out;
+	if (ms->section_mem_map & SECTION_MARKED_PRESENT)
+		return -EEXIST;
+
+	usemap = __kmalloc_section_usemap();
+	if (!usemap)
+		return -ENOMEM;
+	memmap = kmalloc_section_memmap(section_nr, nid, altmap);
+	if (!memmap) {
+		kfree(usemap);
+		return  -ENOMEM;
 	}
 
 	/*
@@ -739,12 +737,7 @@ int __meminit sparse_add_one_section(int nid, unsigned long start_pfn,
 	section_mark_present(ms);
 	sparse_init_one_section(ms, section_nr, memmap, usemap);
 
-out:
-	if (ret < 0) {
-		kfree(usemap);
-		__kfree_section_memmap(memmap, altmap);
-	}
-	return ret;
+	return 0;
 }
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
-- 
2.17.2

