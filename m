Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A276FC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86C6C2238C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389884AbfGYQC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:02:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:50152 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388760AbfGYQCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:02:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AEB8DAFFB;
        Thu, 25 Jul 2019 16:02:17 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     dan.j.williams@intel.com, david@redhat.com,
        pasha.tatashin@soleen.com, mhocko@suse.com,
        anshuman.khandual@arm.com, Jonathan.Cameron@huawei.com,
        vbabka@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v3 5/5] mm,memory_hotplug: Allow userspace to enable/disable vmemmap
Date:   Thu, 25 Jul 2019 18:02:07 +0200
Message-Id: <20190725160207.19579-6-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190725160207.19579-1-osalvador@suse.de>
References: <20190725160207.19579-1-osalvador@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that we have some users out there that want to expose all
hotpluggable memory to userspace, so this implements a toggling mechanism
for those users who want to disable it.

By default, vmemmap pages mechanism is enabled.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 drivers/base/memory.c          | 33 +++++++++++++++++++++++++++++++++
 include/linux/memory_hotplug.h |  3 +++
 mm/memory_hotplug.c            |  7 +++++++
 3 files changed, 43 insertions(+)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index d30d0f6c8ad0..5ec6b80de9dd 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -578,6 +578,35 @@ static DEVICE_ATTR_WO(soft_offline_page);
 static DEVICE_ATTR_WO(hard_offline_page);
 #endif
 
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+static ssize_t vmemmap_hotplug_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	if (vmemmap_enabled)
+		return sprintf(buf, "enabled\n");
+	else
+		return sprintf(buf, "disabled\n");
+}
+
+static ssize_t vmemmap_hotplug_store(struct device *dev,
+			   struct device_attribute *attr,
+			   const char *buf, size_t count)
+{
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (sysfs_streq(buf, "enable"))
+		vmemmap_enabled = true;
+	else if (sysfs_streq(buf, "disable"))
+		vmemmap_enabled = false;
+	else
+		return -EINVAL;
+
+	return count;
+}
+static DEVICE_ATTR_RW(vmemmap_hotplug);
+#endif
+
 /*
  * Note that phys_device is optional.  It is here to allow for
  * differentiation between which *physical* devices each
@@ -794,6 +823,10 @@ static struct attribute *memory_root_attrs[] = {
 	&dev_attr_hard_offline_page.attr,
 #endif
 
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+	&dev_attr_vmemmap_hotplug.attr,
+#endif
+
 	&dev_attr_block_size_bytes.attr,
 	&dev_attr_auto_online_blocks.attr,
 	NULL
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index e1e8abf22a80..03d227d13301 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -134,6 +134,9 @@ extern int arch_add_memory(int nid, u64 start, u64 size,
 			struct mhp_restrictions *restrictions);
 extern u64 max_mem_size;
 
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+extern bool vmemmap_enabled;
+#endif
 extern bool memhp_auto_online;
 /* If movable_node boot option specified */
 extern bool movable_node_enabled;
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 09d41339cd11..5ffe5375b87c 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -68,6 +68,10 @@ void put_online_mems(void)
 
 bool movable_node_enabled = false;
 
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+bool vmemmap_enabled __read_mostly = true;
+#endif
+
 #ifndef CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE
 bool memhp_auto_online;
 #else
@@ -1108,6 +1112,9 @@ static unsigned long mhp_check_flags(unsigned long flags)
 	if (!flags)
 		return 0;
 
+	if (!vmemmap_enabled)
+		return 0;
+
 	if (flags != MHP_MEMMAP_ON_MEMORY) {
 		WARN(1, "Wrong flags value (%lx). Ignoring flags.\n", flags);
 		return 0;
-- 
2.12.3

