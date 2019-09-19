Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAFCC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 14:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58523214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 14:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390621AbfISOX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 10:23:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35742 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403836AbfISOXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 10:23:39 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0D5DE18C891B;
        Thu, 19 Sep 2019 14:23:39 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.118.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE9CB60920;
        Thu, 19 Sep 2019 14:23:36 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>, Qian Cai <cai@lca.pw>
Subject: [PATCH RFC v3 8/9] mm/memory_hotplug: Introduce offline_and_remove_memory()
Date:   Thu, 19 Sep 2019 16:22:27 +0200
Message-Id: <20190919142228.5483-9-david@redhat.com>
In-Reply-To: <20190919142228.5483-1-david@redhat.com>
References: <20190919142228.5483-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.70]); Thu, 19 Sep 2019 14:23:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

virtio-mem wants to offline and remove a memory block once it unplugged
all subblocks (e.g., using alloc_contig_range()). Let's provide
an interface to do that from a driver. virtio-mem already supports to
offline partially unplugged memory blocks. Offlining a fully unplugged
memory block will not require to migrate any pages. All unplugged
subblocks are PageOffline() and have a reference count of 0 - so
offlining code will simply skip them.

All we need an interface to trigger the "offlining" and the removing in a
single operation - to make sure the memory block cannot get onlined by
user space again before it gets removed.

To keep things simple, allow to only work on a single memory block.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Oscar Salvador <osalvador@suse.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Qian Cai <cai@lca.pw>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/memory_hotplug.h |  1 +
 mm/memory_hotplug.c            | 35 ++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 384ffb3d69ab..a1bf868aaeba 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -313,6 +313,7 @@ extern void try_offline_node(int nid);
 extern int offline_pages(unsigned long start_pfn, unsigned long nr_pages);
 extern int remove_memory(int nid, u64 start, u64 size);
 extern void __remove_memory(int nid, u64 start, u64 size);
+extern int offline_and_remove_memory(int nid, u64 start, u64 size);
 
 #else
 static inline bool is_mem_section_removable(unsigned long pfn,
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index d23ff7c5c96b..caf3c93f5f7c 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1742,4 +1742,39 @@ int remove_memory(int nid, u64 start, u64 size)
 	return rc;
 }
 EXPORT_SYMBOL_GPL(remove_memory);
+
+/*
+ * Try to offline and remove a memory block. Might take a long time to
+ * finish in case memory is still in use. Primarily useful for memory devices
+ * that logically unplugged all memory (so it's no longer in use) and want to
+ * offline + remove the memory block.
+ */
+int offline_and_remove_memory(int nid, u64 start, u64 size)
+{
+	struct memory_block *mem;
+	int rc = -EINVAL;
+
+	if (!IS_ALIGNED(start, memory_block_size_bytes()) ||
+	    size != memory_block_size_bytes())
+		return rc;
+
+	lock_device_hotplug();
+	mem = find_memory_block(__pfn_to_section(PFN_DOWN(start)));
+	if (mem)
+		rc = device_offline(&mem->dev);
+	/* Ignore if the device is already offline. */
+	if (rc > 0)
+		rc = 0;
+
+	/*
+	 * In case we succeeded to offline the memory block, remove it.
+	 * This cannot fail as it cannot get onlined in the meantime.
+	 */
+	if (!rc && try_remove_memory(nid, start, size))
+		BUG();
+	unlock_device_hotplug();
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(offline_and_remove_memory);
 #endif /* CONFIG_MEMORY_HOTREMOVE */
-- 
2.21.0

