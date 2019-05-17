Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB80C04E87
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 21:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E47B62133D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 21:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="OCk6/zZy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbfEQVyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 17:54:47 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43321 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbfEQVyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 17:54:45 -0400
Received: by mail-qt1-f193.google.com with SMTP id i26so9715487qtr.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 14:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=oZtfX1EsFJjeahXRqy4pGct5cturWJyiPbutyS49o0o=;
        b=OCk6/zZyF14XcPyyMATB4Ym+LlfbjeEqQItqmdENfhxAIL7cHoM94ugihG5R1YlUwP
         jyOovQljik1bZ9u1Q17gwNSzs//6T0sHHsn2nZn6oduYrc1RwPHPU82m9/ULK5W2vkrF
         4+ZOr0KMFsimF91CAv01CSFgbFsxosShzFArqF02FMtG9sDp0Orljcvp+xse0RqkWqKq
         K3kiIonSoJQg0yVwJ2g6tZMJKiovC3dzhCAAP42XaahkEEEEZ8Qb3VLkPAin2xpWGCFO
         1HB+ik713/SslbvcIJeCr1EhRo4dQwxqJXMBiS6l96Ce9QQeD79P47HlY+Bi+I+kUnbX
         KdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oZtfX1EsFJjeahXRqy4pGct5cturWJyiPbutyS49o0o=;
        b=E6YTbJeoEuHiJNuA2Dt0AMH/tmqd1w2ppyqx+/aFXuK6DA0iUr/69QAreL7xC45P4C
         sbLQrnDwmLuF0FMpq9UFwPGGymOnl9r1YMETTOiRJQPMLKHSEYnf2/WajPVycxCHiBQ+
         VQkDWszZxa3kYu0vn+Y4O7Jo1XhdzFJKYMnQ6w4p+HQwjxEGV4uwNWUs9PmOrgHXI/n8
         K06tRkRXMIHpNu2NfbDLsKdX77mmMwJincxu5VyD4Hwj+qY1/mjV1IsbIRRgV9pAlYDO
         pTJgq1jeGeKnPqAYUbjrrDm86XiWy27phOsRXXzenoh7BJ0ivydbCERSS2IgWHFfSvV3
         dzuQ==
X-Gm-Message-State: APjAAAVNxwLcXKE3m1CEsTjlNVnnP3+rEtVArbFDNMkAw8i7s4cPBZrr
        0CvrQLt5y4kWBzhVCMT2Zzhe7Q==
X-Google-Smtp-Source: APXvYqw1HhlmDQ1zjvj92mE60iFZ0AD+1AWuI0vYk2b6i/mKmMR7uORFYBtfk6du8rP1a68lCkbwRw==
X-Received: by 2002:a0c:9ac1:: with SMTP id k1mr47616206qvf.36.1558130084638;
        Fri, 17 May 2019 14:54:44 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id n36sm6599813qtk.9.2019.05.17.14.54.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 14:54:43 -0700 (PDT)
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
Subject: [v6 2/3] mm/hotplug: make remove_memory() interface useable
Date:   Fri, 17 May 2019 17:54:37 -0400
Message-Id: <20190517215438.6487-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190517215438.6487-1-pasha.tatashin@soleen.com>
References: <20190517215438.6487-1-pasha.tatashin@soleen.com>
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
index 328878b6799d..ace2cc614da4 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1735,9 +1735,10 @@ static int check_memblock_offlined_cb(struct memory_block *mem, void *arg)
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
@@ -1820,19 +1821,9 @@ static void __release_memory_resource(resource_size_t start,
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
 
@@ -1840,13 +1831,13 @@ void __ref __remove_memory(int nid, u64 start, u64 size)
 
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
@@ -1858,14 +1849,45 @@ void __ref __remove_memory(int nid, u64 start, u64 size)
 
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
2.21.0

