Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37ABC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CC5C21019
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557178016;
	bh=MIeMB5M6zStAXdI8vcCEbIVdQRuEDFQeNK8zapPSnoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=vWYHigZKWCiRVJR7bst7xcXB7ZT/S4gqHILNDjXDQKwiFgNU2UAxzGaIwEHsOQ4Qk
	 UxuzGB+C5zmBndRYjzrqLBVgIXZq8zBf1whk0s3snNqkL+gWsCITt5Xe9/YtxCTNlf
	 1Vm5s1bP7AjEUd3Lek+LMhkDrWaV/VTqkOs50KXo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfEFV0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 17:26:54 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36580 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbfEFV0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 17:26:52 -0400
Received: by mail-io1-f67.google.com with SMTP id e19so2634391iob.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 14:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=lv9SgfoJs/HXebdeGiIy6Hfza4k4MZx6gmkLbOGnI/c=;
        b=Mxd1FcTPri7P6gUmClTw6UyUM4K7Gg8xWNs84icmFnKJ0zyf1fsbiNGwZKAO3eBcdZ
         20V+oPt4jWlADs2V7bo3O/+m9Uznk7eOPHG2Wlv+uDowMpF9ItGHizFAWiuiH/5WJEtr
         0Y+tC7icaw9WWhl3i6ql+mEsCO9o7cP0EU7Vuu4UElV15iKelkOE1ibLp7RoidYZJkTM
         O22LHo7VLbUmBKQUl/u3cfLCi4g9KFRa4UlwBiQWUh6gwjJo81atV+7UApsyfRtiZF8t
         hFGQnaFp+LjAUadUQ2+VXcspJcqIAxR4JYe7wEWo/+30atwsXyDcQvpxRO827y2yINbk
         3q1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=lv9SgfoJs/HXebdeGiIy6Hfza4k4MZx6gmkLbOGnI/c=;
        b=JlsqNbwYgb0Mm2Fgem9GfGeMQPRNwFVV8HJeDTGxo29Oj0tqHRRSneRVWPxFQg5uPB
         BBYUPrjHs963Cr90iPZ8js4KgDExX+RCK58oXTSrqYIpLjuz8T4IiZVB27gWRYTmo82S
         8IkqVXyue9OJSQSXTQZh8Ew3tuQkYVjhf7mG6qj0n5Gwf8NtBUU5fAbJx6kYg+YAIoGs
         iVTcVUftESsMIu6JIAV3XZ1x5muU+krRYnPm/dSHxunubYgfA4dDv/2LmeQkkWyiH/Re
         XHoQnCiLSlN9GsjexsFQCstXg9L7ngFFOG7ct9PIUQiq7Yt2u/riFhakWalmFZwCgIfF
         XiLw==
X-Gm-Message-State: APjAAAWLePRKWhI0/NEEH2dlaKY4mNroB5vKNQdK0QNdIewMZTgQO53s
        PUcZSTJtXLnERIWdb7JsO2I=
X-Google-Smtp-Source: APXvYqyBxhAPwSEHVy4Fv7mvECK7wOlpHCP9k8PitsqXmhZoIjprdzQJgFcNh5N6D0X3ZfKG5ta5yg==
X-Received: by 2002:a5e:d505:: with SMTP id e5mr780703iom.99.1557178012073;
        Mon, 06 May 2019 14:26:52 -0700 (PDT)
Received: from nuc8.lan (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id v25sm4268009ioh.81.2019.05.06.14.26.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 14:26:51 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 21/22] perf/x86/intel/uncore: renames in response to multi-die/pkg support
Date:   Mon,  6 May 2019 17:26:16 -0400
Message-Id: <a1ab2f32d8d99f0561ae5e2ce3337d48f1b6f66e.1557177585.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1557177585.git.len.brown@intel.com>
References: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1557177585.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Len Brown <len.brown@intel.com>

Syntax update only -- no logical or functional change.

In response to the new multi-die/package changes, update variable names
to use the more generic "box" terminology, instead of "pkg",
as the boxes can refer to either packages or die.

Signed-off-by: Len Brown <len.brown@intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.c       | 74 ++++++++++++++--------------
 arch/x86/events/intel/uncore.h       |  4 +-
 arch/x86/events/intel/uncore_snbep.c |  2 +-
 3 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index a6461ff85a32..2f25880d7240 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -14,7 +14,7 @@ struct pci_driver *uncore_pci_driver;
 DEFINE_RAW_SPINLOCK(pci2phy_map_lock);
 struct list_head pci2phy_map_head = LIST_HEAD_INIT(pci2phy_map_head);
 struct pci_extra_dev *uncore_extra_pci_dev;
-static int max_packages;
+static int max_boxes;
 
 /* mask of cpus that collect uncore events */
 static cpumask_t uncore_cpu_mask;
@@ -100,13 +100,13 @@ ssize_t uncore_event_show(struct kobject *kobj,
 
 struct intel_uncore_box *uncore_pmu_to_box(struct intel_uncore_pmu *pmu, int cpu)
 {
-	unsigned int pkgid = topology_logical_die_id(cpu);
+	unsigned int boxid = topology_logical_die_id(cpu);
 
 	/*
 	 * The unsigned check also catches the '-1' return value for non
 	 * existent mappings in the topology map.
 	 */
-	return pkgid < max_packages ? pmu->boxes[pkgid] : NULL;
+	return boxid < max_boxes ? pmu->boxes[boxid] : NULL;
 }
 
 u64 uncore_msr_read_counter(struct intel_uncore_box *box, struct perf_event *event)
@@ -311,7 +311,7 @@ static struct intel_uncore_box *uncore_alloc_box(struct intel_uncore_type *type,
 	uncore_pmu_init_hrtimer(box);
 	box->cpu = -1;
 	box->pci_phys_id = -1;
-	box->pkgid = -1;
+	box->boxid = -1;
 
 	/* set default hrtimer timeout */
 	box->hrtimer_duration = UNCORE_PMU_HRTIMER_INTERVAL;
@@ -826,10 +826,10 @@ static void uncore_pmu_unregister(struct intel_uncore_pmu *pmu)
 
 static void uncore_free_boxes(struct intel_uncore_pmu *pmu)
 {
-	int pkg;
+	int boxid;
 
-	for (pkg = 0; pkg < max_packages; pkg++)
-		kfree(pmu->boxes[pkg]);
+	for (boxid = 0; boxid < max_boxes; boxid++)
+		kfree(pmu->boxes[boxid]);
 	kfree(pmu->boxes);
 }
 
@@ -866,7 +866,7 @@ static int __init uncore_type_init(struct intel_uncore_type *type, bool setid)
 	if (!pmus)
 		return -ENOMEM;
 
-	size = max_packages * sizeof(struct intel_uncore_box *);
+	size = max_boxes * sizeof(struct intel_uncore_box *);
 
 	for (i = 0; i < type->num_boxes; i++) {
 		pmus[i].func_id	= setid ? i : -1;
@@ -936,21 +936,21 @@ static int uncore_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	struct intel_uncore_type *type;
 	struct intel_uncore_pmu *pmu = NULL;
 	struct intel_uncore_box *box;
-	int phys_id, pkg, ret;
+	int phys_id, boxid, ret;
 
 	phys_id = uncore_pcibus_to_physid(pdev->bus);
 	if (phys_id < 0)
 		return -ENODEV;
 
-	pkg = (topology_max_die_per_package() > 1) ? phys_id :
+	boxid = (topology_max_die_per_package() > 1) ? phys_id :
 					topology_phys_to_logical_pkg(phys_id);
-	if (pkg < 0)
+	if (boxid < 0)
 		return -EINVAL;
 
 	if (UNCORE_PCI_DEV_TYPE(id->driver_data) == UNCORE_EXTRA_PCI_DEV) {
 		int idx = UNCORE_PCI_DEV_IDX(id->driver_data);
 
-		uncore_extra_pci_dev[pkg].dev[idx] = pdev;
+		uncore_extra_pci_dev[boxid].dev[idx] = pdev;
 		pci_set_drvdata(pdev, NULL);
 		return 0;
 	}
@@ -989,7 +989,7 @@ static int uncore_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id
 		pmu = &type->pmus[UNCORE_PCI_DEV_IDX(id->driver_data)];
 	}
 
-	if (WARN_ON_ONCE(pmu->boxes[pkg] != NULL))
+	if (WARN_ON_ONCE(pmu->boxes[boxid] != NULL))
 		return -EINVAL;
 
 	box = uncore_alloc_box(type, NUMA_NO_NODE);
@@ -1003,13 +1003,13 @@ static int uncore_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id
 
 	atomic_inc(&box->refcnt);
 	box->pci_phys_id = phys_id;
-	box->pkgid = pkg;
+	box->boxid = boxid;
 	box->pci_dev = pdev;
 	box->pmu = pmu;
 	uncore_box_init(box);
 	pci_set_drvdata(pdev, box);
 
-	pmu->boxes[pkg] = box;
+	pmu->boxes[boxid] = box;
 	if (atomic_inc_return(&pmu->activeboxes) > 1)
 		return 0;
 
@@ -1017,7 +1017,7 @@ static int uncore_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	ret = uncore_pmu_register(pmu);
 	if (ret) {
 		pci_set_drvdata(pdev, NULL);
-		pmu->boxes[pkg] = NULL;
+		pmu->boxes[boxid] = NULL;
 		uncore_box_exit(box);
 		kfree(box);
 	}
@@ -1028,17 +1028,17 @@ static void uncore_pci_remove(struct pci_dev *pdev)
 {
 	struct intel_uncore_box *box;
 	struct intel_uncore_pmu *pmu;
-	int i, phys_id, pkg;
+	int i, phys_id, boxid;
 
 	phys_id = uncore_pcibus_to_physid(pdev->bus);
 
 	box = pci_get_drvdata(pdev);
 	if (!box) {
-		pkg = (topology_max_die_per_package() > 1) ? phys_id :
+		boxid = (topology_max_die_per_package() > 1) ? phys_id :
 					topology_phys_to_logical_pkg(phys_id);
 		for (i = 0; i < UNCORE_EXTRA_PCI_DEV_MAX; i++) {
-			if (uncore_extra_pci_dev[pkg].dev[i] == pdev) {
-				uncore_extra_pci_dev[pkg].dev[i] = NULL;
+			if (uncore_extra_pci_dev[boxid].dev[i] == pdev) {
+				uncore_extra_pci_dev[boxid].dev[i] = NULL;
 				break;
 			}
 		}
@@ -1051,7 +1051,7 @@ static void uncore_pci_remove(struct pci_dev *pdev)
 		return;
 
 	pci_set_drvdata(pdev, NULL);
-	pmu->boxes[box->pkgid] = NULL;
+	pmu->boxes[box->boxid] = NULL;
 	if (atomic_dec_return(&pmu->activeboxes) == 0)
 		uncore_pmu_unregister(pmu);
 	uncore_box_exit(box);
@@ -1063,7 +1063,7 @@ static int __init uncore_pci_init(void)
 	size_t size;
 	int ret;
 
-	size = max_packages * sizeof(struct pci_extra_dev);
+	size = max_boxes * sizeof(struct pci_extra_dev);
 	uncore_extra_pci_dev = kzalloc(size, GFP_KERNEL);
 	if (!uncore_extra_pci_dev) {
 		ret = -ENOMEM;
@@ -1110,11 +1110,11 @@ static void uncore_change_type_ctx(struct intel_uncore_type *type, int old_cpu,
 {
 	struct intel_uncore_pmu *pmu = type->pmus;
 	struct intel_uncore_box *box;
-	int i, pkg;
+	int i, boxid;
 
-	pkg = topology_logical_die_id(old_cpu < 0 ? new_cpu : old_cpu);
+	boxid = topology_logical_die_id(old_cpu < 0 ? new_cpu : old_cpu);
 	for (i = 0; i < type->num_boxes; i++, pmu++) {
-		box = pmu->boxes[pkg];
+		box = pmu->boxes[boxid];
 		if (!box)
 			continue;
 
@@ -1147,7 +1147,7 @@ static int uncore_event_cpu_offline(unsigned int cpu)
 	struct intel_uncore_type *type, **types = uncore_msr_uncores;
 	struct intel_uncore_pmu *pmu;
 	struct intel_uncore_box *box;
-	int i, pkg, target;
+	int i, boxid, target;
 
 	/* Check if exiting cpu is used for collecting uncore events */
 	if (!cpumask_test_and_clear_cpu(cpu, &uncore_cpu_mask))
@@ -1166,12 +1166,12 @@ static int uncore_event_cpu_offline(unsigned int cpu)
 
 unref:
 	/* Clear the references */
-	pkg = topology_logical_die_id(cpu);
+	boxid = topology_logical_die_id(cpu);
 	for (; *types; types++) {
 		type = *types;
 		pmu = type->pmus;
 		for (i = 0; i < type->num_boxes; i++, pmu++) {
-			box = pmu->boxes[pkg];
+			box = pmu->boxes[boxid];
 			if (box && atomic_dec_return(&box->refcnt) == 0)
 				uncore_box_exit(box);
 		}
@@ -1180,7 +1180,7 @@ static int uncore_event_cpu_offline(unsigned int cpu)
 }
 
 static int allocate_boxes(struct intel_uncore_type **types,
-			 unsigned int pkg, unsigned int cpu)
+			 unsigned int boxid, unsigned int cpu)
 {
 	struct intel_uncore_box *box, *tmp;
 	struct intel_uncore_type *type;
@@ -1193,20 +1193,20 @@ static int allocate_boxes(struct intel_uncore_type **types,
 		type = *types;
 		pmu = type->pmus;
 		for (i = 0; i < type->num_boxes; i++, pmu++) {
-			if (pmu->boxes[pkg])
+			if (pmu->boxes[boxid])
 				continue;
 			box = uncore_alloc_box(type, cpu_to_node(cpu));
 			if (!box)
 				goto cleanup;
 			box->pmu = pmu;
-			box->pkgid = pkg;
+			box->boxid = boxid;
 			list_add(&box->active_list, &allocated);
 		}
 	}
 	/* Install them in the pmus */
 	list_for_each_entry_safe(box, tmp, &allocated, active_list) {
 		list_del_init(&box->active_list);
-		box->pmu->boxes[pkg] = box;
+		box->pmu->boxes[boxid] = box;
 	}
 	return 0;
 
@@ -1223,10 +1223,10 @@ static int uncore_event_cpu_online(unsigned int cpu)
 	struct intel_uncore_type *type, **types = uncore_msr_uncores;
 	struct intel_uncore_pmu *pmu;
 	struct intel_uncore_box *box;
-	int i, ret, pkg, target;
+	int i, ret, boxid, target;
 
-	pkg = topology_logical_die_id(cpu);
-	ret = allocate_boxes(types, pkg, cpu);
+	boxid = topology_logical_die_id(cpu);
+	ret = allocate_boxes(types, boxid, cpu);
 	if (ret)
 		return ret;
 
@@ -1234,7 +1234,7 @@ static int uncore_event_cpu_online(unsigned int cpu)
 		type = *types;
 		pmu = type->pmus;
 		for (i = 0; i < type->num_boxes; i++, pmu++) {
-			box = pmu->boxes[pkg];
+			box = pmu->boxes[boxid];
 			if (box && atomic_inc_return(&box->refcnt) == 1)
 				uncore_box_init(box);
 		}
@@ -1413,7 +1413,7 @@ static int __init intel_uncore_init(void)
 	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
 		return -ENODEV;
 
-	max_packages = topology_max_packages() * topology_max_die_per_package();
+	max_boxes = topology_max_packages() * topology_max_die_per_package();
 
 	uncore_init = (struct intel_uncore_init_fun *)id->driver_data;
 	if (uncore_init->pci_init) {
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 853a49a8ccf6..83298d3d604f 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -108,7 +108,7 @@ struct intel_uncore_extra_reg {
 
 struct intel_uncore_box {
 	int pci_phys_id;
-	int pkgid;	/* Logical package ID */
+	int boxid;	/* Logical box ID */
 	int n_active;	/* number of active events */
 	int n_events;
 	int cpu;	/* cpu to collect events */
@@ -467,7 +467,7 @@ static inline void uncore_box_exit(struct intel_uncore_box *box)
 
 static inline bool uncore_box_is_fake(struct intel_uncore_box *box)
 {
-	return (box->pkgid < 0);
+	return (box->boxid < 0);
 }
 
 static inline struct intel_uncore_pmu *uncore_event_to_pmu(struct perf_event *event)
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index b10e04387f38..8f64540b9bc2 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -1058,7 +1058,7 @@ static void snbep_qpi_enable_event(struct intel_uncore_box *box, struct perf_eve
 
 	if (reg1->idx != EXTRA_REG_NONE) {
 		int idx = box->pmu->pmu_idx + SNBEP_PCI_QPI_PORT0_FILTER;
-		int pkg = box->pkgid;
+		int pkg = box->boxid;
 		struct pci_dev *filter_pdev = uncore_extra_pci_dev[pkg].dev[idx];
 
 		if (filter_pdev) {
-- 
2.18.0-rc0

