Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7799FC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BE5B2082A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfDIVmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:42:39 -0400
Received: from mga06.intel.com ([134.134.136.31]:17987 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbfDIVmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 17:42:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Apr 2019 14:42:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,330,1549958400"; 
   d="scan'208";a="290150061"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by orsmga004.jf.intel.com with ESMTP; 09 Apr 2019 14:42:37 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Brice Goglin <Brice.Goglin@inria.fr>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH] hmat: Register attributes for memory hot add
Date:   Tue,  9 Apr 2019 15:44:15 -0600
Message-Id: <20190409214415.3722-1-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some types of memory nodes that HMAT describes may not be online at the
time we initially parse their nodes' tables. If the node should be set
to online later, as can happen when using PMEM as RAM after boot, the
node's attributes will be missing their initiator links and performance.

Regsiter a memory notifier callback and set the memory attributes when
a node is initially brought online with hot added memory, and don't try
to register node attributes if the node is not online during initial
scanning.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/acpi/hmat/hmat.c | 63 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 50 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
index b275016ff648..cf24b885feb5 100644
--- a/drivers/acpi/hmat/hmat.c
+++ b/drivers/acpi/hmat/hmat.c
@@ -14,14 +14,15 @@
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/list_sort.h>
+#include <linux/memory.h>
 #include <linux/node.h>
 #include <linux/sysfs.h>
 
-static __initdata u8 hmat_revision;
+static u8 hmat_revision;
 
-static __initdata LIST_HEAD(targets);
-static __initdata LIST_HEAD(initiators);
-static __initdata LIST_HEAD(localities);
+static LIST_HEAD(targets);
+static LIST_HEAD(initiators);
+static LIST_HEAD(localities);
 
 /*
  * The defined enum order is used to prioritize attributes to break ties when
@@ -41,6 +42,7 @@ struct memory_target {
 	unsigned int memory_pxm;
 	unsigned int processor_pxm;
 	struct node_hmem_attrs hmem_attrs;
+	bool registered;
 };
 
 struct memory_initiator {
@@ -53,7 +55,7 @@ struct memory_locality {
 	struct acpi_hmat_locality *hmat_loc;
 };
 
-static __init struct memory_initiator *find_mem_initiator(unsigned int cpu_pxm)
+static struct memory_initiator *find_mem_initiator(unsigned int cpu_pxm)
 {
 	struct memory_initiator *initiator;
 
@@ -63,7 +65,7 @@ static __init struct memory_initiator *find_mem_initiator(unsigned int cpu_pxm)
 	return NULL;
 }
 
-static __init struct memory_target *find_mem_target(unsigned int mem_pxm)
+static struct memory_target *find_mem_target(unsigned int mem_pxm)
 {
 	struct memory_target *target;
 
@@ -148,7 +150,7 @@ static __init const char *hmat_data_type_suffix(u8 type)
 	}
 }
 
-static __init u32 hmat_normalize(u16 entry, u64 base, u8 type)
+static u32 hmat_normalize(u16 entry, u64 base, u8 type)
 {
 	u32 value;
 
@@ -183,7 +185,7 @@ static __init u32 hmat_normalize(u16 entry, u64 base, u8 type)
 	return value;
 }
 
-static __init void hmat_update_target_access(struct memory_target *target,
+static void hmat_update_target_access(struct memory_target *target,
 					     u8 type, u32 value)
 {
 	switch (type) {
@@ -435,7 +437,7 @@ static __init int srat_parse_mem_affinity(union acpi_subtable_headers *header,
 	return 0;
 }
 
-static __init u32 hmat_initiator_perf(struct memory_target *target,
+static u32 hmat_initiator_perf(struct memory_target *target,
 			       struct memory_initiator *initiator,
 			       struct acpi_hmat_locality *hmat_loc)
 {
@@ -473,7 +475,7 @@ static __init u32 hmat_initiator_perf(struct memory_target *target,
 			      hmat_loc->data_type);
 }
 
-static __init bool hmat_update_best(u8 type, u32 value, u32 *best)
+static bool hmat_update_best(u8 type, u32 value, u32 *best)
 {
 	bool updated = false;
 
@@ -517,7 +519,7 @@ static int initiator_cmp(void *priv, struct list_head *a, struct list_head *b)
 	return ia->processor_pxm - ib->processor_pxm;
 }
 
-static __init void hmat_register_target_initiators(struct memory_target *target)
+static void hmat_register_target_initiators(struct memory_target *target)
 {
 	static DECLARE_BITMAP(p_nodes, MAX_NUMNODES);
 	struct memory_initiator *initiator;
@@ -577,22 +579,53 @@ static __init void hmat_register_target_initiators(struct memory_target *target)
 	}
 }
 
-static __init void hmat_register_target_perf(struct memory_target *target)
+static void hmat_register_target_perf(struct memory_target *target)
 {
 	unsigned mem_nid = pxm_to_node(target->memory_pxm);
 	node_set_perf_attrs(mem_nid, &target->hmem_attrs, 0);
 }
 
-static __init void hmat_register_targets(void)
+static void hmat_register_targets(void)
 {
 	struct memory_target *target;
 
 	list_for_each_entry(target, &targets, node) {
+		if (!node_online(pxm_to_node(target->memory_pxm)))
+			continue;
+
 		hmat_register_target_initiators(target);
 		hmat_register_target_perf(target);
+		target->registered = true;
 	}
 }
 
+static int hmat_callback(struct notifier_block *self,
+			 unsigned long action, void *arg)
+{
+	struct memory_notify *mnb = arg;
+	int pxm, nid = mnb->status_change_nid;
+	struct memory_target *target;
+
+	if (nid == NUMA_NO_NODE || action != MEM_ONLINE)
+		return NOTIFY_OK;
+
+	pxm = node_to_pxm(nid);
+	target = find_mem_target(pxm);
+	if (!target || target->registered)
+		return NOTIFY_OK;
+
+	hmat_register_target_initiators(target);
+	hmat_register_target_perf(target);
+	target->registered = true;
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block hmat_callback_nb = {
+	.notifier_call = hmat_callback,
+	.priority = 2,
+};
+
 static __init void hmat_free_structures(void)
 {
 	struct memory_target *target, *tnext;
@@ -658,6 +691,10 @@ static __init int hmat_init(void)
 		}
 	}
 	hmat_register_targets();
+
+	/* Keep the table and structures if the notifier may use them */
+	if (!register_hotmemory_notifier(&hmat_callback_nb))
+		return 0;
 out_put:
 	hmat_free_structures();
 	acpi_put_table(tbl);
-- 
2.14.4

