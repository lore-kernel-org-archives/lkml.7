Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D80C10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 01:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DD9A2175B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 01:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388222AbfDYBmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 21:42:47 -0400
Received: from mga11.intel.com ([192.55.52.93]:25341 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387460AbfDYBmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 21:42:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Apr 2019 18:42:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,391,1549958400"; 
   d="scan'208";a="152134215"
Received: from zz23f_aep_wp03.sh.intel.com ([10.239.85.39])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Apr 2019 18:42:42 -0700
From:   Fan Du <fan.du@intel.com>
To:     akpm@linux-foundation.org, mhocko@suse.com, fengguang.wu@intel.com,
        dan.j.williams@intel.com, dave.hansen@intel.com,
        xishi.qiuxishi@alibaba-inc.com, ying.huang@intel.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Fan Du <fan.du@intel.com>
Subject: [RFC PATCH 1/5] acpi/numa: memorize NUMA node type from SRAT table
Date:   Thu, 25 Apr 2019 09:21:31 +0800
Message-Id: <1556155295-77723-2-git-send-email-fan.du@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1556155295-77723-1-git-send-email-fan.du@intel.com>
References: <1556155295-77723-1-git-send-email-fan.du@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark NUMA node as DRAM or PMEM.

This could happen in boot up state (see the e820 pmem type
override patch), or on fly when bind devdax device with kmem
driver.

It depends on BIOS supplying PMEM NUMA proximity in SRAT table,
that's current production BIOS does.

Signed-off-by: Fan Du <fan.du@intel.com>
---
 arch/x86/include/asm/numa.h | 2 ++
 arch/x86/mm/numa.c          | 2 ++
 drivers/acpi/numa.c         | 5 +++++
 3 files changed, 9 insertions(+)

diff --git a/arch/x86/include/asm/numa.h b/arch/x86/include/asm/numa.h
index bbfde3d..5191198 100644
--- a/arch/x86/include/asm/numa.h
+++ b/arch/x86/include/asm/numa.h
@@ -30,6 +30,8 @@
  */
 extern s16 __apicid_to_node[MAX_LOCAL_APIC];
 extern nodemask_t numa_nodes_parsed __initdata;
+extern nodemask_t numa_nodes_pmem;
+extern nodemask_t numa_nodes_dram;
 
 extern int __init numa_add_memblk(int nodeid, u64 start, u64 end);
 extern void __init numa_set_distance(int from, int to, int distance);
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index dfb6c4d..3c3a1f5 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -20,6 +20,8 @@
 
 int numa_off;
 nodemask_t numa_nodes_parsed __initdata;
+nodemask_t numa_nodes_pmem;
+nodemask_t numa_nodes_dram;
 
 struct pglist_data *node_data[MAX_NUMNODES] __read_mostly;
 EXPORT_SYMBOL(node_data);
diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index 867f6e3..ec4b7a7e 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -298,6 +298,11 @@ void __init acpi_numa_slit_init(struct acpi_table_slit *slit)
 
 	node_set(node, numa_nodes_parsed);
 
+	if (ma->flags & ACPI_SRAT_MEM_NON_VOLATILE)
+		node_set(node, numa_nodes_pmem);
+	else
+		node_set(node, numa_nodes_dram);
+
 	pr_info("SRAT: Node %u PXM %u [mem %#010Lx-%#010Lx]%s%s\n",
 		node, pxm,
 		(unsigned long long) start, (unsigned long long) end - 1,
-- 
1.8.3.1

