Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25647C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6CC9213F2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfDHKMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 06:12:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56462 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbfDHKMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 06:12:43 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 51B1D2D7EC;
        Mon,  8 Apr 2019 10:12:42 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-53.ams2.redhat.com [10.36.117.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0F06727192;
        Mon,  8 Apr 2019 10:12:38 +0000 (UTC)
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
Subject: [PATCH RFC 2/3] mm/memory_hotplug: Create memory block devices after arch_add_memory()
Date:   Mon,  8 Apr 2019 12:12:25 +0200
Message-Id: <20190408101226.20976-3-david@redhat.com>
In-Reply-To: <20190408101226.20976-1-david@redhat.com>
References: <20190408101226.20976-1-david@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 08 Apr 2019 10:12:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only memory added via add_memory() and friends will need memory
block devices - only memory to be used via the buddy and to be onlined/
offlined by user space in memory block granularity.

Move creation of memory block devices out of arch_add_memory(). Create all
devices after arch_add_memory() succeeded. We can later drop the
want_memblock parameter, because it is now effectively stale.

Only after memory block devices have been added, memory can be onlined
by user space. This implies, that memory is not visible to user space at
all before arch_add_memory() succeeded.

Issue 1: __add_pages() does not remove pages in case something went
wrong. If this is the case, we would now no longer create memory block
devices for such "partially added memory". So the memory would not be
usable/onlinable. Bad? Or related to issue 2 (e.g. fix __add_pages()
to remove any parts that were added in case of an error). Functions that
fail and don't clean up are not that nice.

Issue 2: In case we can't add memory block devices, and we don't have
HOTREMOVE, we can't remove the pages via arch_remove_pages. Maybe we should
try to get rid of CONFIG_MEMORY_HOTREMOVE, so we can handle all failures
in a nice way? Or at least allow arch_remove_pages() and friends, so a
subset of CONFIG_MEMORY_HOTREMOVE.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/base/memory.c  | 67 +++++++++++++++++++++++++-----------------
 include/linux/memory.h |  2 +-
 mm/memory_hotplug.c    | 17 +++++++----
 3 files changed, 53 insertions(+), 33 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index d9ebb89816f7..847b33061e2e 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -701,44 +701,57 @@ static int add_memory_block(int base_section_nr)
 	return 0;
 }
 
-/*
- * need an interface for the VM to add new memory regions,
- * but without onlining it.
- */
-int hotplug_memory_register(int nid, struct mem_section *section)
+static void unregister_memory(struct memory_block *memory)
 {
-	int ret = 0;
+	BUG_ON(memory->dev.bus != &memory_subsys);
+
+	/* drop the ref. we got via find_memory_block() */
+	put_device(&memory->dev);
+	device_unregister(&memory->dev);
+}
+
+int hotplug_memory_register(unsigned long start, unsigned long size)
+{
+	unsigned long block_nr_pages = memory_block_size_bytes() >> PAGE_SHIFT;
+	unsigned long start_pfn = PFN_DOWN(start);
+	unsigned long end_pfn = start_pfn + (size >> PAGE_SHIFT);
+	unsigned long pfn;
 	struct memory_block *mem;
+	int ret = 0;
 
-	mutex_lock(&mem_sysfs_mutex);
+	BUG_ON(!IS_ALIGNED(start, memory_block_size_bytes()));
+	BUG_ON(!IS_ALIGNED(size, memory_block_size_bytes()));
 
-	mem = find_memory_block(section);
-	if (mem) {
-		mem->section_count++;
-		put_device(&mem->dev);
-	} else {
-		ret = init_memory_block(&mem, section, MEM_OFFLINE);
+	mutex_lock(&mem_sysfs_mutex);
+	for (pfn = start_pfn; pfn != end_pfn; pfn += block_nr_pages) {
+		mem = find_memory_block(__pfn_to_section(pfn));
+		if (mem) {
+			WARN_ON_ONCE(false);
+			put_device(&mem->dev);
+			continue;
+		}
+		ret = init_memory_block(&mem, __pfn_to_section(pfn),
+					MEM_OFFLINE);
 		if (ret)
-			goto out;
-		mem->section_count++;
+			break;
+		mem->section_count = memory_block_size_bytes() /
+				     MIN_MEMORY_BLOCK_SIZE;
+	}
+	if (ret) {
+		end_pfn = pfn;
+		for (pfn = start_pfn; pfn != end_pfn; pfn += block_nr_pages) {
+			mem = find_memory_block(__pfn_to_section(pfn));
+			if (!mem)
+				continue;
+			mem->section_count = 0;
+			unregister_memory(mem);
+		}
 	}
-
-out:
 	mutex_unlock(&mem_sysfs_mutex);
 	return ret;
 }
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
-static void
-unregister_memory(struct memory_block *memory)
-{
-	BUG_ON(memory->dev.bus != &memory_subsys);
-
-	/* drop the ref. we got in remove_memory_section() */
-	put_device(&memory->dev);
-	device_unregister(&memory->dev);
-}
-
 static int remove_memory_section(struct mem_section *section)
 {
 	struct memory_block *mem;
diff --git a/include/linux/memory.h b/include/linux/memory.h
index a6ddefc60517..e275dc775834 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -111,7 +111,7 @@ extern int register_memory_notifier(struct notifier_block *nb);
 extern void unregister_memory_notifier(struct notifier_block *nb);
 extern int register_memory_isolate_notifier(struct notifier_block *nb);
 extern void unregister_memory_isolate_notifier(struct notifier_block *nb);
-int hotplug_memory_register(int nid, struct mem_section *section);
+int hotplug_memory_register(unsigned long start, unsigned long size);
 #ifdef CONFIG_MEMORY_HOTREMOVE
 extern int unregister_memory_section(struct mem_section *);
 #endif
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 680dcc67f9d5..13ee0a26e034 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -260,11 +260,7 @@ static int __meminit __add_section(int nid, unsigned long phys_start_pfn,
 	ret = sparse_add_one_section(nid, phys_start_pfn, altmap);
 	if (ret < 0)
 		return ret;
-
-	if (!want_memblock)
-		return 0;
-
-	return hotplug_memory_register(nid, __pfn_to_section(phys_start_pfn));
+	return 0;
 }
 
 /*
@@ -1125,6 +1121,17 @@ int __ref add_memory_resource(int nid, struct resource *res)
 	if (ret < 0)
 		goto error;
 
+	/* create memory block devices after memory was added */
+	ret = hotplug_memory_register(start, size);
+#ifdef CONFIG_MEMORY_HOTREMOVE
+	if (ret) {
+		arch_remove_memory(nid, start, size, NULL);
+		goto error;
+	}
+#else
+	WARN_ON(ret);
+#endif
+
 	if (new_node) {
 		/* If sysfs file of new node can't be created, cpu on the node
 		 * can't be hot-added. There is no rollback way now.
-- 
2.17.2

