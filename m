Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB932C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B191E2147C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbfDOPPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:15:34 -0400
Received: from mga04.intel.com ([192.55.52.120]:23730 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727413AbfDOPPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 11:15:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Apr 2019 08:15:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,354,1549958400"; 
   d="scan'208";a="149585858"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Apr 2019 08:15:28 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Brice Goglin <Brice.Goglin@inria.fr>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 1/2] hmat: Register memory-side cache after parsing
Date:   Mon, 15 Apr 2019 09:16:53 -0600
Message-Id: <20190415151654.15913-2-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190415151654.15913-1-keith.busch@intel.com>
References: <20190415151654.15913-1-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of registering the hmat cache attributes in line with parsing
the table, save the attributes in the memory target and register them
after parsing completes. This will make it easier to register the
attributes later when hot add is supported.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/acpi/hmat/hmat.c | 48 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
index b7824a0309f7..bdb167c026ff 100644
--- a/drivers/acpi/hmat/hmat.c
+++ b/drivers/acpi/hmat/hmat.c
@@ -41,6 +41,7 @@ struct memory_target {
 	unsigned int memory_pxm;
 	unsigned int processor_pxm;
 	struct node_hmem_attrs hmem_attrs;
+	struct node_cache_attrs cache_attrs;
 };
 
 struct memory_initiator {
@@ -314,7 +315,7 @@ static __init int hmat_parse_cache(union acpi_subtable_headers *header,
 				   const unsigned long end)
 {
 	struct acpi_hmat_cache *cache = (void *)header;
-	struct node_cache_attrs cache_attrs;
+	struct memory_target *target;
 	u32 attrs;
 
 	if (cache->header.length < sizeof(*cache)) {
@@ -328,37 +329,40 @@ static __init int hmat_parse_cache(union acpi_subtable_headers *header,
 		cache->memory_PD, cache->cache_size, attrs,
 		cache->number_of_SMBIOShandles);
 
-	cache_attrs.size = cache->cache_size;
-	cache_attrs.level = (attrs & ACPI_HMAT_CACHE_LEVEL) >> 4;
-	cache_attrs.line_size = (attrs & ACPI_HMAT_CACHE_LINE_SIZE) >> 16;
+	target = find_mem_target(cache->memory_PD);
+	if (!target)
+		return 0;
+
+	target->cache_attrs.size = cache->cache_size;
+	target->cache_attrs.level = (attrs & ACPI_HMAT_CACHE_LEVEL) >> 4;
+	target->cache_attrs.line_size = (attrs & ACPI_HMAT_CACHE_LINE_SIZE) >> 16;
 
 	switch ((attrs & ACPI_HMAT_CACHE_ASSOCIATIVITY) >> 8) {
 	case ACPI_HMAT_CA_DIRECT_MAPPED:
-		cache_attrs.indexing = NODE_CACHE_DIRECT_MAP;
+		target->cache_attrs.indexing = NODE_CACHE_DIRECT_MAP;
 		break;
 	case ACPI_HMAT_CA_COMPLEX_CACHE_INDEXING:
-		cache_attrs.indexing = NODE_CACHE_INDEXED;
+		target->cache_attrs.indexing = NODE_CACHE_INDEXED;
 		break;
 	case ACPI_HMAT_CA_NONE:
 	default:
-		cache_attrs.indexing = NODE_CACHE_OTHER;
+		target->cache_attrs.indexing = NODE_CACHE_OTHER;
 		break;
 	}
 
 	switch ((attrs & ACPI_HMAT_WRITE_POLICY) >> 12) {
 	case ACPI_HMAT_CP_WB:
-		cache_attrs.write_policy = NODE_CACHE_WRITE_BACK;
+		target->cache_attrs.write_policy = NODE_CACHE_WRITE_BACK;
 		break;
 	case ACPI_HMAT_CP_WT:
-		cache_attrs.write_policy = NODE_CACHE_WRITE_THROUGH;
+		target->cache_attrs.write_policy = NODE_CACHE_WRITE_THROUGH;
 		break;
 	case ACPI_HMAT_CP_NONE:
 	default:
-		cache_attrs.write_policy = NODE_CACHE_WRITE_OTHER;
+		target->cache_attrs.write_policy = NODE_CACHE_WRITE_OTHER;
 		break;
 	}
 
-	node_add_cache(pxm_to_node(cache->memory_PD), &cache_attrs);
 	return 0;
 }
 
@@ -577,20 +581,34 @@ static __init void hmat_register_target_initiators(struct memory_target *target)
 	}
 }
 
+static __init void hmat_register_target_cache(struct memory_target *target)
+{
+	unsigned mem_nid = pxm_to_node(target->memory_pxm);
+	node_add_cache(mem_nid, &target->cache_attrs);
+}
+
 static __init void hmat_register_target_perf(struct memory_target *target)
 {
 	unsigned mem_nid = pxm_to_node(target->memory_pxm);
 	node_set_perf_attrs(mem_nid, &target->hmem_attrs, 0);
 }
 
+static __init void hmat_register_target(struct memory_target *target)
+{
+	if (!node_online(pxm_to_node(target->memory_pxm)))
+		return;
+
+	hmat_register_target_initiators(target);
+	hmat_register_target_cache(target);
+	hmat_register_target_perf(target);
+}
+
 static __init void hmat_register_targets(void)
 {
 	struct memory_target *target;
 
-	list_for_each_entry(target, &targets, node) {
-		hmat_register_target_initiators(target);
-		hmat_register_target_perf(target);
-	}
+	list_for_each_entry(target, &targets, node)
+		hmat_register_target(target);
 }
 
 static __init void hmat_free_structures(void)
-- 
2.14.4

