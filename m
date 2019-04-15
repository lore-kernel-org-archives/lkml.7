Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB737C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72CB22147C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfDOPPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:15:41 -0400
Received: from mga04.intel.com ([192.55.52.120]:23729 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727412AbfDOPPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 11:15:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Apr 2019 08:15:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,354,1549958400"; 
   d="scan'208";a="149585862"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Apr 2019 08:15:29 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Brice Goglin <Brice.Goglin@inria.fr>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 2/2] hmat: Register attributes for memory hot add
Date:   Mon, 15 Apr 2019 09:16:54 -0600
Message-Id: <20190415151654.15913-3-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190415151654.15913-1-keith.busch@intel.com>
References: <20190415151654.15913-1-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some memory nodes described in HMAT may not be online at the time the
we parse the subtables. Should the node be set to online later, as can
happen when using PMEM as RAM after boot, the nodes will be missing
their initiator links and performance attributes.

Register a memory notifier callback and register the memory attributes
the first time its node is brought online if it wasn't registered,
ensuring a node's attributes may be registered only once.

Reported-by: Brice Goglin <Brice.Goglin@inria.fr>
Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/acpi/hmat/hmat.c | 72 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 55 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
index bdb167c026ff..4fcfad6c2181 100644
--- a/drivers/acpi/hmat/hmat.c
+++ b/drivers/acpi/hmat/hmat.c
@@ -14,14 +14,18 @@
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/list_sort.h>
+#include <linux/memory.h>
+#include <linux/mutex.h>
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
+
+static DEFINE_MUTEX(target_lock);
 
 /*
  * The defined enum order is used to prioritize attributes to break ties when
@@ -42,6 +46,7 @@ struct memory_target {
 	unsigned int processor_pxm;
 	struct node_hmem_attrs hmem_attrs;
 	struct node_cache_attrs cache_attrs;
+	bool registered;
 };
 
 struct memory_initiator {
@@ -54,7 +59,7 @@ struct memory_locality {
 	struct acpi_hmat_locality *hmat_loc;
 };
 
-static __init struct memory_initiator *find_mem_initiator(unsigned int cpu_pxm)
+static struct memory_initiator *find_mem_initiator(unsigned int cpu_pxm)
 {
 	struct memory_initiator *initiator;
 
@@ -64,7 +69,7 @@ static __init struct memory_initiator *find_mem_initiator(unsigned int cpu_pxm)
 	return NULL;
 }
 
-static __init struct memory_target *find_mem_target(unsigned int mem_pxm)
+static struct memory_target *find_mem_target(unsigned int mem_pxm)
 {
 	struct memory_target *target;
 
@@ -149,7 +154,7 @@ static __init const char *hmat_data_type_suffix(u8 type)
 	}
 }
 
-static __init u32 hmat_normalize(u16 entry, u64 base, u8 type)
+static u32 hmat_normalize(u16 entry, u64 base, u8 type)
 {
 	u32 value;
 
@@ -184,7 +189,7 @@ static __init u32 hmat_normalize(u16 entry, u64 base, u8 type)
 	return value;
 }
 
-static __init void hmat_update_target_access(struct memory_target *target,
+static void hmat_update_target_access(struct memory_target *target,
 					     u8 type, u32 value)
 {
 	switch (type) {
@@ -439,7 +444,7 @@ static __init int srat_parse_mem_affinity(union acpi_subtable_headers *header,
 	return 0;
 }
 
-static __init u32 hmat_initiator_perf(struct memory_target *target,
+static u32 hmat_initiator_perf(struct memory_target *target,
 			       struct memory_initiator *initiator,
 			       struct acpi_hmat_locality *hmat_loc)
 {
@@ -477,7 +482,7 @@ static __init u32 hmat_initiator_perf(struct memory_target *target,
 			      hmat_loc->data_type);
 }
 
-static __init bool hmat_update_best(u8 type, u32 value, u32 *best)
+static bool hmat_update_best(u8 type, u32 value, u32 *best)
 {
 	bool updated = false;
 
@@ -521,7 +526,7 @@ static int initiator_cmp(void *priv, struct list_head *a, struct list_head *b)
 	return ia->processor_pxm - ib->processor_pxm;
 }
 
-static __init void hmat_register_target_initiators(struct memory_target *target)
+static void hmat_register_target_initiators(struct memory_target *target)
 {
 	static DECLARE_BITMAP(p_nodes, MAX_NUMNODES);
 	struct memory_initiator *initiator;
@@ -581,13 +586,13 @@ static __init void hmat_register_target_initiators(struct memory_target *target)
 	}
 }
 
-static __init void hmat_register_target_cache(struct memory_target *target)
+static void hmat_register_target_cache(struct memory_target *target)
 {
 	unsigned mem_nid = pxm_to_node(target->memory_pxm);
 	node_add_cache(mem_nid, &target->cache_attrs);
 }
 
-static __init void hmat_register_target_perf(struct memory_target *target)
+static void hmat_register_target_perf(struct memory_target *target)
 {
 	unsigned mem_nid = pxm_to_node(target->memory_pxm);
 	node_set_perf_attrs(mem_nid, &target->hmem_attrs, 0);
@@ -598,12 +603,17 @@ static __init void hmat_register_target(struct memory_target *target)
 	if (!node_online(pxm_to_node(target->memory_pxm)))
 		return;
 
-	hmat_register_target_initiators(target);
-	hmat_register_target_cache(target);
-	hmat_register_target_perf(target);
+	mutex_lock(&target_lock);
+	if (!target->registered) {
+		hmat_register_target_initiators(target);
+		hmat_register_target_cache(target);
+		hmat_register_target_perf(target);
+		target->registered = true;
+	}
+	mutex_unlock(&target_lock);
 }
 
-static __init void hmat_register_targets(void)
+static void hmat_register_targets(void)
 {
 	struct memory_target *target;
 
@@ -611,6 +621,30 @@ static __init void hmat_register_targets(void)
 		hmat_register_target(target);
 }
 
+static int hmat_callback(struct notifier_block *self,
+			 unsigned long action, void *arg)
+{
+	struct memory_target *target;
+	struct memory_notify *mnb = arg;
+	int pxm, nid = mnb->status_change_nid;
+
+	if (nid == NUMA_NO_NODE || action != MEM_ONLINE)
+		return NOTIFY_OK;
+
+	pxm = node_to_pxm(nid);
+	target = find_mem_target(pxm);
+	if (!target)
+		return NOTIFY_OK;
+
+	hmat_register_target(target);
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
@@ -676,6 +710,10 @@ static __init int hmat_init(void)
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

