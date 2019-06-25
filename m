Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927A8C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7071D2089F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbfFYHxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 03:53:18 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:54345 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730086AbfFYHxN (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Tue, 25 Jun 2019 03:53:13 -0400
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Tue, 25 Jun 2019 09:53:11 +0200
Received: from suse.de (nwb-a10-snat.microfocus.com [10.120.13.201])
        by emea4-mta.ukb.novell.com with ESMTP (NOT encrypted); Tue, 25 Jun 2019 08:52:35 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, dan.j.williams@intel.com,
        pasha.tatashin@soleen.com, Jonathan.Cameron@huawei.com,
        david@redhat.com, anshuman.khandual@arm.com, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 5/5] mm,memory_hotplug: Allow userspace to enable/disable vmemmap
Date:   Tue, 25 Jun 2019 09:52:27 +0200
Message-Id: <20190625075227.15193-6-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190625075227.15193-1-osalvador@suse.de>
References: <20190625075227.15193-1-osalvador@suse.de>
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
 mm/memory_hotplug.c            |  6 +++++-
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index e0ac9a3b66f8..6fca2c96cc08 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -573,6 +573,35 @@ static DEVICE_ATTR_WO(soft_offline_page);
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
@@ -799,6 +828,10 @@ static struct attribute *memory_root_attrs[] = {
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
index e28e226c9a20..94b4adc1a0ba 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -131,6 +131,9 @@ extern int arch_add_memory(int nid, u64 start, u64 size,
 			struct mhp_restrictions *restrictions);
 extern u64 max_mem_size;
 
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+extern bool vmemmap_enabled;
+#endif
 extern bool memhp_auto_online;
 /* If movable_node boot option specified */
 extern bool movable_node_enabled;
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index b5106cb75795..32ee6fb7d3bf 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -70,6 +70,10 @@ void put_online_mems(void)
 
 bool movable_node_enabled = false;
 
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+bool vmemmap_enabled __read_mostly = true;
+#endif
+
 #ifndef CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE
 bool memhp_auto_online;
 #else
@@ -1168,7 +1172,7 @@ int __ref add_memory_resource(int nid, struct resource *res, unsigned long flags
 		goto error;
 	new_node = ret;
 
-	if (mhp_check_correct_flags(flags))
+	if (vmemmap_enabled && mhp_check_correct_flags(flags))
 		restrictions.flags = flags;
 
 	/* call arch's memory hotadd */
-- 
2.12.3

