Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EBBC73C63
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 01:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 077C52081C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 01:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="LntS6yWp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfGJBQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 21:16:56 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37453 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbfGJBQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 21:16:53 -0400
Received: by mail-qk1-f193.google.com with SMTP id d15so645907qkl.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 18:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=oUgTnAZaywklydAAAPvB3a6I5/R1cYvy+iIkRwSNZnk=;
        b=LntS6yWpaejTt9SVF+fVC7Ci+89fr1DyTiF2xUKIH6h5NkvSH1k381FHUeqUUuEcc0
         yTUCL82/lOdUkkiALPPXLeGUGi+WKdtti/fdXv7kou9x3YPyBEwjVcIl7USaCoXIZFUA
         fh2Y3StdFNp2P+hUfdI7X47L0fnYYCJ6Q27PFiFAX3EL6BnWqkIs1WJrholKT3m0OGvh
         QoQh/R6z6Axr1Gsk8qhhISOsyPX5mxP1AaJiB9yX8iBQS+y1DZqdo7yTBfxDyRPYS/HN
         y+M1N36aWpeympdukvQFHHSKXlVWGprnTISAipceqCsdtGqIPYS/cmxeFKXBruxe+2u5
         JQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oUgTnAZaywklydAAAPvB3a6I5/R1cYvy+iIkRwSNZnk=;
        b=YG7YRgBrFFscQXrif/cnw9kfn6zAS0H81D96PM0/qXmiSzgYb09xFWl1MSWoFF1hEw
         v4I00B3uFXCAvntPukx4dUADvRDdDVVJZujh2sSfNyqxPc4mcdAj+w+stUf9Om77UJ9J
         QQ4ugurIYo4NpcGn+BjjCEsr5AwnfwfjLhDhvqRDv8E5SeaUBMq9ZvUCzsenGoejgTI3
         lQepEVEJ3SysEJfsoiQt7PQCH7EIXaWGDDIQ9yo4foq7EPmZg3zvalvTYx/jj/c26AUs
         9mD3xcMTAJKiWFh5UU7y7lTcdLLa6PDMIHFXtl3IZa+EPiuEPDJoRqNg9KrK3YD2AeKC
         maUA==
X-Gm-Message-State: APjAAAUdB7ke54fN2idW2yQIylHeKL5KcaT+FC+C6NL1m1kxDcB2OSlC
        S/lK6RlkQ2gXruBHZaNLiXkoew==
X-Google-Smtp-Source: APXvYqyayfanR0LhFsg7XP0bJdPSuQa2GB1LgirxNwXiGmy32bzFbJzapk8lj3SFV7YobHsyO98cKQ==
X-Received: by 2002:a37:4c4e:: with SMTP id z75mr21389763qka.230.1562721412692;
        Tue, 09 Jul 2019 18:16:52 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id u7sm260057qta.82.2019.07.09.18.16.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 18:16:52 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, akpm@linux-foundation.org,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        dan.j.williams@intel.com, keith.busch@intel.com,
        vishal.l.verma@intel.com, dave.jiang@intel.com, zwisler@kernel.org,
        thomas.lendacky@amd.com, ying.huang@intel.com,
        fengguang.wu@intel.com, bp@suse.de, bhelgaas@google.com,
        baiyaowei@cmss.chinamobile.com, tiwai@suse.de, jglisse@redhat.com,
        david@redhat.com
Subject: [v7 2/3] mm/hotplug: make remove_memory() interface useable
Date:   Tue,  9 Jul 2019 21:16:46 -0400
Message-Id: <20190710011647.10944-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190710011647.10944-1-pasha.tatashin@soleen.com>
References: <20190710011647.10944-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of right now remove_memory() interface is inherently broken. It tries
to remove memory but panics if some memory is not offline. The problem
is that it is impossible to ensure that all memory blocks are offline as
this function also takes lock_device_hotplug that is required to
change memory state via sysfs.

So, between calling this function and offlining all memory blocks there
is always a window when lock_device_hotplug is released, and therefore,
there is always a chance for a panic during this window.

Make this interface to return an error if memory removal fails. This way
it is safe to call this function without panicking machine, and also
makes it symmetric to add_memory() which already returns an error.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 include/linux/memory_hotplug.h |  8 +++--
 mm/memory_hotplug.c            | 64 +++++++++++++++++++++++-----------
 2 files changed, 49 insertions(+), 23 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index ae892eef8b82..988fde33cd7f 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -324,7 +324,7 @@ static inline void pgdat_resize_init(struct pglist_data *pgdat) {}
 extern bool is_mem_section_removable(unsigned long pfn, unsigned long nr_pages);
 extern void try_offline_node(int nid);
 extern int offline_pages(unsigned long start_pfn, unsigned long nr_pages);
-extern void remove_memory(int nid, u64 start, u64 size);
+extern int remove_memory(int nid, u64 start, u64 size);
 extern void __remove_memory(int nid, u64 start, u64 size);
 
 #else
@@ -341,7 +341,11 @@ static inline int offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 	return -EINVAL;
 }
 
-static inline void remove_memory(int nid, u64 start, u64 size) {}
+static inline int remove_memory(int nid, u64 start, u64 size)
+{
+	return -EBUSY;
+}
+
 static inline void __remove_memory(int nid, u64 start, u64 size) {}
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index e096c987d261..77d1f69cdead 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1736,9 +1736,10 @@ static int check_memblock_offlined_cb(struct memory_block *mem, void *arg)
 		endpa = PFN_PHYS(section_nr_to_pfn(mem->end_section_nr + 1))-1;
 		pr_warn("removing memory fails, because memory [%pa-%pa] is onlined\n",
 			&beginpa, &endpa);
-	}
 
-	return ret;
+		return -EBUSY;
+	}
+	return 0;
 }
 
 static int check_cpu_on_node(pg_data_t *pgdat)
@@ -1821,19 +1822,9 @@ static void __release_memory_resource(resource_size_t start,
 	}
 }
 
-/**
- * remove_memory
- * @nid: the node ID
- * @start: physical address of the region to remove
- * @size: size of the region to remove
- *
- * NOTE: The caller must call lock_device_hotplug() to serialize hotplug
- * and online/offline operations before this call, as required by
- * try_offline_node().
- */
-void __ref __remove_memory(int nid, u64 start, u64 size)
+static int __ref try_remove_memory(int nid, u64 start, u64 size)
 {
-	int ret;
+	int rc = 0;
 
 	BUG_ON(check_hotplug_memory_range(start, size));
 
@@ -1841,13 +1832,13 @@ void __ref __remove_memory(int nid, u64 start, u64 size)
 
 	/*
 	 * All memory blocks must be offlined before removing memory.  Check
-	 * whether all memory blocks in question are offline and trigger a BUG()
+	 * whether all memory blocks in question are offline and return error
 	 * if this is not the case.
 	 */
-	ret = walk_memory_range(PFN_DOWN(start), PFN_UP(start + size - 1), NULL,
-				check_memblock_offlined_cb);
-	if (ret)
-		BUG();
+	rc = walk_memory_range(PFN_DOWN(start), PFN_UP(start + size - 1), NULL,
+			       check_memblock_offlined_cb);
+	if (rc)
+		goto done;
 
 	/* remove memmap entry */
 	firmware_map_remove(start, start + size, "System RAM");
@@ -1859,14 +1850,45 @@ void __ref __remove_memory(int nid, u64 start, u64 size)
 
 	try_offline_node(nid);
 
+done:
 	mem_hotplug_done();
+	return rc;
 }
 
-void remove_memory(int nid, u64 start, u64 size)
+/**
+ * remove_memory
+ * @nid: the node ID
+ * @start: physical address of the region to remove
+ * @size: size of the region to remove
+ *
+ * NOTE: The caller must call lock_device_hotplug() to serialize hotplug
+ * and online/offline operations before this call, as required by
+ * try_offline_node().
+ */
+void __remove_memory(int nid, u64 start, u64 size)
+{
+
+	/*
+	 * trigger BUG() is some memory is not offlined prior to calling this
+	 * function
+	 */
+	if (try_remove_memory(nid, start, size))
+		BUG();
+}
+
+/*
+ * Remove memory if every memory block is offline, otherwise return -EBUSY is
+ * some memory is not offline
+ */
+int remove_memory(int nid, u64 start, u64 size)
 {
+	int rc;
+
 	lock_device_hotplug();
-	__remove_memory(nid, start, size);
+	rc  = try_remove_memory(nid, start, size);
 	unlock_device_hotplug();
+
+	return rc;
 }
 EXPORT_SYMBOL_GPL(remove_memory);
 #endif /* CONFIG_MEMORY_HOTREMOVE */
-- 
2.22.0

