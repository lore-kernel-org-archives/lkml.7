Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C2BC04AA9
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 00:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A7B72177B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 00:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfEAAzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 20:55:04 -0400
Received: from mga18.intel.com ([134.134.136.126]:6348 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbfEAAy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 20:54:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Apr 2019 17:54:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,415,1549958400"; 
   d="scan'208";a="228225476"
Received: from otc-lr-04.jf.intel.com ([10.54.39.157])
  by orsmga001.jf.intel.com with ESMTP; 30 Apr 2019 17:54:55 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [RESEND PATCH 4/6] perf/x86/intel/uncore: Support MMIO type uncore blocks
Date:   Tue, 30 Apr 2019 17:53:46 -0700
Message-Id: <1556672028-119221-5-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556672028-119221-1-git-send-email-kan.liang@linux.intel.com>
References: <1556672028-119221-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

A new MMIO type uncore box is introduced on Snow Ridge server. The
counters of MMIO type uncore box can only be accessed by MMIO.

Add a new uncore type, uncore_mmio_uncores, for MMIO type uncore blocks.

Support MMIO type uncore blocks in CPU hot plug. The MMIO space has to
be map/unmap for the first/last CPU. The context also need to be
migrated if the bind CPU changes.

Add mmio_init() to init and register PMUs for MMIO type uncore blocks.

Add a helper to calculate the box_ctl address.

The helpers which calculate ctl/ctr can be shared with PCI type uncore
blocks.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.c | 51 ++++++++++++++++++++++++++++++++++++------
 arch/x86/events/intel/uncore.h | 21 ++++++++++++-----
 2 files changed, 60 insertions(+), 12 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 0b72ca5..3c00635 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -7,6 +7,7 @@
 static struct intel_uncore_type *empty_uncore[] = { NULL, };
 struct intel_uncore_type **uncore_msr_uncores = empty_uncore;
 struct intel_uncore_type **uncore_pci_uncores = empty_uncore;
+struct intel_uncore_type **uncore_mmio_uncores = empty_uncore;
 
 static bool pcidrv_registered;
 struct pci_driver *uncore_pci_driver;
@@ -1175,12 +1176,14 @@ static int uncore_event_cpu_offline(unsigned int cpu)
 		target = -1;
 
 	uncore_change_context(uncore_msr_uncores, cpu, target);
+	uncore_change_context(uncore_mmio_uncores, cpu, target);
 	uncore_change_context(uncore_pci_uncores, cpu, target);
 
 unref:
 	/* Clear the references */
 	pkg = topology_logical_package_id(cpu);
 	uncore_box_unref(uncore_msr_uncores, pkg);
+	uncore_box_unref(uncore_mmio_uncores, pkg);
 	return 0;
 }
 
@@ -1248,12 +1251,13 @@ static int uncore_box_ref(struct intel_uncore_type **types,
 
 static int uncore_event_cpu_online(unsigned int cpu)
 {
-	int ret, pkg, target;
+	int pkg, target, msr_ret, mmio_ret;
 
 	pkg = topology_logical_package_id(cpu);
-	ret = uncore_box_ref(uncore_msr_uncores, pkg, cpu);
-	if (ret)
-		return ret;
+	msr_ret = uncore_box_ref(uncore_msr_uncores, pkg, cpu);
+	mmio_ret = uncore_box_ref(uncore_mmio_uncores, pkg, cpu);
+	if (msr_ret && mmio_ret)
+		return -ENOMEM;
 
 	/*
 	 * Check if there is an online cpu in the package
@@ -1265,7 +1269,10 @@ static int uncore_event_cpu_online(unsigned int cpu)
 
 	cpumask_set_cpu(cpu, &uncore_cpu_mask);
 
-	uncore_change_context(uncore_msr_uncores, -1, cpu);
+	if (!msr_ret)
+		uncore_change_context(uncore_msr_uncores, -1, cpu);
+	if (!mmio_ret)
+		uncore_change_context(uncore_mmio_uncores, -1, cpu);
 	uncore_change_context(uncore_pci_uncores, -1, cpu);
 	return 0;
 }
@@ -1313,12 +1320,35 @@ static int __init uncore_cpu_init(void)
 	return ret;
 }
 
+static int __init uncore_mmio_init(void)
+{
+	struct intel_uncore_type **types = uncore_mmio_uncores;
+	int ret;
+
+	ret = uncore_types_init(types, true);
+	if (ret)
+		goto err;
+
+	for (; *types; types++) {
+		ret = type_pmu_register(*types);
+		if (ret)
+			goto err;
+	}
+	return 0;
+err:
+	uncore_types_exit(uncore_mmio_uncores);
+	uncore_mmio_uncores = empty_uncore;
+	return ret;
+}
+
+
 #define X86_UNCORE_MODEL_MATCH(model, init)	\
 	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, (unsigned long)&init }
 
 struct intel_uncore_init_fun {
 	void	(*cpu_init)(void);
 	int	(*pci_init)(void);
+	void	(*mmio_init)(void);
 };
 
 static const struct intel_uncore_init_fun nhm_uncore_init __initconst = {
@@ -1431,7 +1461,7 @@ static int __init intel_uncore_init(void)
 {
 	const struct x86_cpu_id *id;
 	struct intel_uncore_init_fun *uncore_init;
-	int pret = 0, cret = 0, ret;
+	int pret = 0, cret = 0, mret = 0, ret;
 
 	id = x86_match_cpu(intel_uncore_match);
 	if (!id)
@@ -1454,7 +1484,12 @@ static int __init intel_uncore_init(void)
 		cret = uncore_cpu_init();
 	}
 
-	if (cret && pret)
+	if (uncore_init->mmio_init) {
+		uncore_init->mmio_init();
+		mret = uncore_mmio_init();
+	}
+
+	if (cret && pret && mret)
 		return -ENODEV;
 
 	/* Install hotplug callbacks to setup the targets for each package */
@@ -1468,6 +1503,7 @@ static int __init intel_uncore_init(void)
 
 err:
 	uncore_types_exit(uncore_msr_uncores);
+	uncore_types_exit(uncore_mmio_uncores);
 	uncore_pci_exit();
 	return ret;
 }
@@ -1477,6 +1513,7 @@ static void __exit intel_uncore_exit(void)
 {
 	cpuhp_remove_state(CPUHP_AP_PERF_X86_UNCORE_ONLINE);
 	uncore_types_exit(uncore_msr_uncores);
+	uncore_types_exit(uncore_mmio_uncores);
 	uncore_pci_exit();
 }
 module_exit(intel_uncore_exit);
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 5e97e5e..426a490 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -56,7 +56,10 @@ struct intel_uncore_type {
 	unsigned fixed_ctr;
 	unsigned fixed_ctl;
 	unsigned box_ctl;
-	unsigned msr_offset;
+	union {
+		unsigned msr_offset;
+		unsigned mmio_offset;
+	};
 	unsigned num_shared_regs:8;
 	unsigned single_fixed:1;
 	unsigned pair_ctr_ctl:1;
@@ -190,6 +193,13 @@ static inline bool uncore_pmc_freerunning(int idx)
 	return idx == UNCORE_PMC_IDX_FREERUNNING;
 }
 
+static inline
+unsigned int uncore_mmio_box_ctl(struct intel_uncore_box *box)
+{
+	return box->pmu->type->box_ctl +
+	       box->pmu->type->mmio_offset * box->pmu->pmu_idx;
+}
+
 static inline unsigned uncore_pci_box_ctl(struct intel_uncore_box *box)
 {
 	return box->pmu->type->box_ctl;
@@ -330,7 +340,7 @@ unsigned uncore_msr_perf_ctr(struct intel_uncore_box *box, int idx)
 static inline
 unsigned uncore_fixed_ctl(struct intel_uncore_box *box)
 {
-	if (box->pci_dev)
+	if (box->pci_dev || box->io_addr)
 		return uncore_pci_fixed_ctl(box);
 	else
 		return uncore_msr_fixed_ctl(box);
@@ -339,7 +349,7 @@ unsigned uncore_fixed_ctl(struct intel_uncore_box *box)
 static inline
 unsigned uncore_fixed_ctr(struct intel_uncore_box *box)
 {
-	if (box->pci_dev)
+	if (box->pci_dev || box->io_addr)
 		return uncore_pci_fixed_ctr(box);
 	else
 		return uncore_msr_fixed_ctr(box);
@@ -348,7 +358,7 @@ unsigned uncore_fixed_ctr(struct intel_uncore_box *box)
 static inline
 unsigned uncore_event_ctl(struct intel_uncore_box *box, int idx)
 {
-	if (box->pci_dev)
+	if (box->pci_dev || box->io_addr)
 		return uncore_pci_event_ctl(box, idx);
 	else
 		return uncore_msr_event_ctl(box, idx);
@@ -357,7 +367,7 @@ unsigned uncore_event_ctl(struct intel_uncore_box *box, int idx)
 static inline
 unsigned uncore_perf_ctr(struct intel_uncore_box *box, int idx)
 {
-	if (box->pci_dev)
+	if (box->pci_dev || box->io_addr)
 		return uncore_pci_perf_ctr(box, idx);
 	else
 		return uncore_msr_perf_ctr(box, idx);
@@ -507,6 +517,7 @@ u64 uncore_shared_reg_config(struct intel_uncore_box *box, int idx);
 
 extern struct intel_uncore_type **uncore_msr_uncores;
 extern struct intel_uncore_type **uncore_pci_uncores;
+extern struct intel_uncore_type **uncore_mmio_uncores;
 extern struct pci_driver *uncore_pci_driver;
 extern raw_spinlock_t pci2phy_map_lock;
 extern struct list_head pci2phy_map_head;
-- 
2.7.4

