Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA5BC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D08EE20882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730342AbfDDTVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 15:21:55 -0400
Received: from mga05.intel.com ([192.55.52.43]:31869 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729287AbfDDTVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 15:21:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Apr 2019 12:21:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,309,1549958400"; 
   d="scan'208";a="140174118"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga007.fm.intel.com with ESMTP; 04 Apr 2019 12:21:23 -0700
Subject: [RFC PATCH 3/5] acpi/hmat: Track target address ranges
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        vishal.l.verma@intel.com, x86@kernel.org, linux-mm@kvack.org,
        keith.busch@intel.com, vishal.l.verma@intel.com,
        linux-nvdimm@lists.01.org
Date:   Thu, 04 Apr 2019 12:08:44 -0700
Message-ID: <155440492414.3190322.12683374224345847860.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155440490809.3190322.15060922240602775809.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <155440490809.3190322.15060922240602775809.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of ACPI 6.3 the HMAT no longer advertises the physical memory address
range for its entries. Instead, the expectation is the corresponding
entry in the SRAT is looked up by the target proximity domain.

Given there may be multiple distinct address ranges that share the same
performance profile (sparse address space), find_mem_target() is updated
to also consider the start address of the memory range. Target property
updates are also adjusted to loop over all possible 'struct target'
instances that may share the same proximity domain identification.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/hmat/hmat.c |   77 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 53 insertions(+), 24 deletions(-)

diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
index b275016ff648..e7ae44c8d359 100644
--- a/drivers/acpi/hmat/hmat.c
+++ b/drivers/acpi/hmat/hmat.c
@@ -38,6 +38,7 @@ static struct memory_locality *localities_types[4];
 
 struct memory_target {
 	struct list_head node;
+	u64 start, size;
 	unsigned int memory_pxm;
 	unsigned int processor_pxm;
 	struct node_hmem_attrs hmem_attrs;
@@ -63,12 +64,13 @@ static __init struct memory_initiator *find_mem_initiator(unsigned int cpu_pxm)
 	return NULL;
 }
 
-static __init struct memory_target *find_mem_target(unsigned int mem_pxm)
+static __init struct memory_target *find_mem_target(unsigned int mem_pxm,
+		u64 start)
 {
 	struct memory_target *target;
 
 	list_for_each_entry(target, &targets, node)
-		if (target->memory_pxm == mem_pxm)
+		if (target->memory_pxm == mem_pxm && target->start == start)
 			return target;
 	return NULL;
 }
@@ -92,14 +94,15 @@ static __init void alloc_memory_initiator(unsigned int cpu_pxm)
 	list_add_tail(&initiator->node, &initiators);
 }
 
-static __init void alloc_memory_target(unsigned int mem_pxm)
+static __init void alloc_memory_target(unsigned int mem_pxm,
+		u64 start, u64 size)
 {
 	struct memory_target *target;
 
 	if (pxm_to_node(mem_pxm) == NUMA_NO_NODE)
 		return;
 
-	target = find_mem_target(mem_pxm);
+	target = find_mem_target(mem_pxm, start);
 	if (target)
 		return;
 
@@ -109,6 +112,8 @@ static __init void alloc_memory_target(unsigned int mem_pxm)
 
 	target->memory_pxm = mem_pxm;
 	target->processor_pxm = PXM_INVAL;
+	target->start = start;
+	target->size = size;
 	list_add_tail(&target->node, &targets);
 }
 
@@ -183,8 +188,8 @@ static __init u32 hmat_normalize(u16 entry, u64 base, u8 type)
 	return value;
 }
 
-static __init void hmat_update_target_access(struct memory_target *target,
-					     u8 type, u32 value)
+static __init void __hmat_update_target_access(struct memory_target *target,
+		u8 type, u32 value)
 {
 	switch (type) {
 	case ACPI_HMAT_ACCESS_LATENCY:
@@ -212,6 +217,20 @@ static __init void hmat_update_target_access(struct memory_target *target,
 	}
 }
 
+static __init void hmat_update_target_access(int memory_pxm, int processor_pxm,
+		u8 type, u32 value)
+{
+	struct memory_target *target;
+
+	list_for_each_entry(target, &targets, node) {
+		if (target->processor_pxm != processor_pxm)
+			continue;
+		if (target->memory_pxm != memory_pxm)
+			continue;
+		__hmat_update_target_access(target, type, value);
+	}
+}
+
 static __init void hmat_add_locality(struct acpi_hmat_locality *hmat_loc)
 {
 	struct memory_locality *loc;
@@ -255,7 +274,6 @@ static __init int hmat_parse_locality(union acpi_subtable_headers *header,
 				      const unsigned long end)
 {
 	struct acpi_hmat_locality *hmat_loc = (void *)header;
-	struct memory_target *target;
 	unsigned int init, targ, total_size, ipds, tpds;
 	u32 *inits, *targs, value;
 	u16 *entries;
@@ -296,11 +314,9 @@ static __init int hmat_parse_locality(union acpi_subtable_headers *header,
 				inits[init], targs[targ], value,
 				hmat_data_type_suffix(type));
 
-			if (mem_hier == ACPI_HMAT_MEMORY) {
-				target = find_mem_target(targs[targ]);
-				if (target && target->processor_pxm == inits[init])
-					hmat_update_target_access(target, type, value);
-			}
+			if (mem_hier == ACPI_HMAT_MEMORY)
+				hmat_update_target_access(targs[targ],
+						inits[init], type, value);
 		}
 	}
 
@@ -367,6 +383,7 @@ static int __init hmat_parse_proximity_domain(union acpi_subtable_headers *heade
 {
 	struct acpi_hmat_proximity_domain *p = (void *)header;
 	struct memory_target *target = NULL;
+	bool found = false;
 
 	if (p->header.length != sizeof(*p)) {
 		pr_notice("HMAT: Unexpected address range header length: %d\n",
@@ -382,23 +399,34 @@ static int __init hmat_parse_proximity_domain(union acpi_subtable_headers *heade
 		pr_info("HMAT: Memory Flags:%04x Processor Domain:%d Memory Domain:%d\n",
 			p->flags, p->processor_PD, p->memory_PD);
 
-	if (p->flags & ACPI_HMAT_MEMORY_PD_VALID) {
-		target = find_mem_target(p->memory_PD);
-		if (!target) {
-			pr_debug("HMAT: Memory Domain missing from SRAT\n");
-			return -EINVAL;
-		}
-	}
-	if (target && p->flags & ACPI_HMAT_PROCESSOR_PD_VALID) {
-		int p_node = pxm_to_node(p->processor_PD);
+	if ((p->flags & ACPI_HMAT_MEMORY_PD_VALID) == 0)
+		return 0;
+
+	list_for_each_entry(target, &targets, node) {
+		int p_node;
+
+		if (target->memory_pxm != p->memory_PD)
+			continue;
+		found = true;
 
+		if ((p->flags & ACPI_HMAT_PROCESSOR_PD_VALID) == 0)
+			continue;
+
+		p_node = pxm_to_node(p->processor_PD);
 		if (p_node == NUMA_NO_NODE) {
-			pr_debug("HMAT: Invalid Processor Domain\n");
+			pr_debug("HMAT: Invalid Processor Domain: %d\n",
+					p->processor_PD);
 			return -EINVAL;
 		}
+
 		target->processor_pxm = p_node;
 	}
 
+	if (!found) {
+		pr_debug("HMAT: Memory Domain missing from SRAT for pxm: %d\n",
+				p->memory_PD);
+		return -EINVAL;
+	}
 	return 0;
 }
 
@@ -431,7 +459,7 @@ static __init int srat_parse_mem_affinity(union acpi_subtable_headers *header,
 		return -EINVAL;
 	if (!(ma->flags & ACPI_SRAT_MEM_ENABLED))
 		return 0;
-	alloc_memory_target(ma->proximity_domain);
+	alloc_memory_target(ma->proximity_domain, ma->base_address, ma->length);
 	return 0;
 }
 
@@ -568,7 +596,8 @@ static __init void hmat_register_target_initiators(struct memory_target *target)
 				clear_bit(initiator->processor_pxm, p_nodes);
 		}
 		if (best)
-			hmat_update_target_access(target, loc->hmat_loc->data_type, best);
+			__hmat_update_target_access(target,
+					loc->hmat_loc->data_type, best);
 	}
 
 	for_each_set_bit(i, p_nodes, MAX_NUMNODES) {

