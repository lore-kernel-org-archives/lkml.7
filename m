Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EA5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 821E721873
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbfCUII3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 04:08:29 -0400
Received: from foss.arm.com ([217.140.101.70]:51914 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727823AbfCUII2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 04:08:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 304B280D;
        Thu, 21 Mar 2019 01:08:28 -0700 (PDT)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com [10.162.42.102])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2ACEB3F59C;
        Thu, 21 Mar 2019 01:08:24 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     logang@deltatee.com, osalvador@suse.de, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org,
        richard.weiyang@gmail.com, rientjes@google.com,
        zi.yan@cs.rutgers.edu
Subject: [RFC] mm/hotplug: Make get_nid_for_pfn() work with HAVE_ARCH_PFN_VALID
Date:   Thu, 21 Mar 2019 13:38:20 +0530
Message-Id: <1553155700-3414-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory hot remove uses get_nid_for_pfn() while tearing down linked sysfs
entries between memory block and node. It first checks pfn validity with
pfn_valid_within() before fetching nid. With CONFIG_HOLES_IN_ZONE config
(arm64 has this enabled) pfn_valid_within() calls pfn_valid().

pfn_valid() is an arch implementation on arm64 (CONFIG_HAVE_ARCH_PFN_VALID)
which scans all mapped memblock regions with memblock_is_map_memory(). This
creates a problem in memory hot remove path which has already removed given
memory range from memory block with memblock_[remove|free] before arriving
at unregister_mem_sect_under_nodes().

During runtime memory hot remove get_nid_for_pfn() needs to validate that
given pfn has a struct page mapping so that it can fetch required nid. This
can be achieved just by looking into it's section mapping information. This
adds a new helper pfn_section_valid() for this purpose. Its same as generic
pfn_valid().

This maintains existing behaviour for deferred struct page init case.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This is a preparatory patch for memory hot-remove enablement on arm64. I
will appreciate some early feedback on this approach.

 drivers/base/node.c    | 15 ++++++++++++---
 include/linux/mmzone.h |  9 +++++++--
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 86d6cd92ce3d..9e944b71e352 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -394,11 +394,20 @@ int unregister_cpu_under_node(unsigned int cpu, unsigned int nid)
 #ifdef CONFIG_MEMORY_HOTPLUG_SPARSE
 static int __ref get_nid_for_pfn(unsigned long pfn)
 {
-	if (!pfn_valid_within(pfn))
-		return -1;
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
-	if (system_state < SYSTEM_RUNNING)
+	if (system_state < SYSTEM_RUNNING) {
+		if (!pfn_valid_within(pfn))
+			return -1;
 		return early_pfn_to_nid(pfn);
+	}
+#endif
+
+#if defined(CONFIG_HAVE_ARCH_PFN_VALID) && defined(CONFIG_HOLES_IN_ZONE)
+	if (!pfn_section_valid(pfn))
+		return -1;
+#else
+	if (!pfn_valid_within(pfn))
+		return -1;
 #endif
 	return pfn_to_nid(pfn);
 }
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 842f9189537b..9cf4c1111b95 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1242,13 +1242,18 @@ static inline struct mem_section *__pfn_to_section(unsigned long pfn)
 
 extern int __highest_present_section_nr;
 
-#ifndef CONFIG_HAVE_ARCH_PFN_VALID
-static inline int pfn_valid(unsigned long pfn)
+static inline int pfn_section_valid(unsigned long pfn)
 {
 	if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
 		return 0;
 	return valid_section(__nr_to_section(pfn_to_section_nr(pfn)));
 }
+
+#ifndef CONFIG_HAVE_ARCH_PFN_VALID
+static inline int pfn_valid(unsigned long pfn)
+{
+	return pfn_section_valid(pfn);
+}
 #endif
 
 static inline int pfn_present(unsigned long pfn)
-- 
2.20.1

