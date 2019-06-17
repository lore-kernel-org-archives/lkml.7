Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2DEC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D096E20833
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="e+1W+mik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbfFQOie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:38:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45823 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfFQOie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:38:34 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HEcM763458946
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 07:38:22 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HEcM763458946
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560782303;
        bh=GG6NDF6JqA8m0f4gEOxScaV6t3a/X/YIo9Ji69IHWAU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=e+1W+mikRlnPEIJma0n03rHGsAiVukeOaBZYYD8iE6hxw0WEtVM7ELnke0E0kZESs
         xFJisMoMthCixmpyxY7rZqcveAe81eMwxW5YRCxznB6bCm3zBAFAOeyTfAahotnCAi
         /0W7wSuiXM+yDwcmuiE1ODXU7DV3oCuDiHuQg0nVmbyDNgSDSakcJmk9UzM98Atlzy
         wAUlJnHP7uS7iKIRTBYZ1zuWl1hSAMqLXM1xcZClBlorpWDQBokndleX921674RE/5
         3/skIFja/XaarxxYGAw2F/X2bGj4591Sg1G7nBSlkQYqNXdtVLsf3wIybPuDeAOkwK
         naj/i9FKwMPNg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HEcMLU3458943;
        Mon, 17 Jun 2019 07:38:22 -0700
Date:   Mon, 17 Jun 2019 07:38:22 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-3da04b8a00dd6d39970b9e764b78c5dfb40ec013@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        kan.liang@linux.intel.com, mingo@kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org, hpa@zytor.com
Reply-To: torvalds@linux-foundation.org, hpa@zytor.com,
          kan.liang@linux.intel.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, peterz@infradead.org, mingo@kernel.org
In-Reply-To: <1556672028-119221-5-git-send-email-kan.liang@linux.intel.com>
References: <1556672028-119221-5-git-send-email-kan.liang@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86/intel/uncore: Support MMIO type uncore
 blocks
Git-Commit-ID: 3da04b8a00dd6d39970b9e764b78c5dfb40ec013
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  3da04b8a00dd6d39970b9e764b78c5dfb40ec013
Gitweb:     https://git.kernel.org/tip/3da04b8a00dd6d39970b9e764b78c5dfb40ec013
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Tue, 30 Apr 2019 17:53:46 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 17 Jun 2019 12:36:20 +0200

perf/x86/intel/uncore: Support MMIO type uncore blocks

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: acme@kernel.org
Cc: eranian@google.com
Link: https://lkml.kernel.org/r/1556672028-119221-5-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/uncore.c | 51 ++++++++++++++++++++++++++++++++++++------
 arch/x86/events/intel/uncore.h | 21 ++++++++++++-----
 2 files changed, 60 insertions(+), 12 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 7b0c88903d47..442f30e5e49a 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -8,6 +8,7 @@
 static struct intel_uncore_type *empty_uncore[] = { NULL, };
 struct intel_uncore_type **uncore_msr_uncores = empty_uncore;
 struct intel_uncore_type **uncore_pci_uncores = empty_uncore;
+struct intel_uncore_type **uncore_mmio_uncores = empty_uncore;
 
 static bool pcidrv_registered;
 struct pci_driver *uncore_pci_driver;
@@ -1178,12 +1179,14 @@ static int uncore_event_cpu_offline(unsigned int cpu)
 		target = -1;
 
 	uncore_change_context(uncore_msr_uncores, cpu, target);
+	uncore_change_context(uncore_mmio_uncores, cpu, target);
 	uncore_change_context(uncore_pci_uncores, cpu, target);
 
 unref:
 	/* Clear the references */
 	die = topology_logical_die_id(cpu);
 	uncore_box_unref(uncore_msr_uncores, die);
+	uncore_box_unref(uncore_mmio_uncores, die);
 	return 0;
 }
 
@@ -1252,12 +1255,13 @@ static int uncore_box_ref(struct intel_uncore_type **types,
 
 static int uncore_event_cpu_online(unsigned int cpu)
 {
-	int ret, die, target;
+	int die, target, msr_ret, mmio_ret;
 
 	die = topology_logical_die_id(cpu);
-	ret = uncore_box_ref(uncore_msr_uncores, die, cpu);
-	if (ret)
-		return ret;
+	msr_ret = uncore_box_ref(uncore_msr_uncores, die, cpu);
+	mmio_ret = uncore_box_ref(uncore_mmio_uncores, die, cpu);
+	if (msr_ret && mmio_ret)
+		return -ENOMEM;
 
 	/*
 	 * Check if there is an online cpu in the package
@@ -1269,7 +1273,10 @@ static int uncore_event_cpu_online(unsigned int cpu)
 
 	cpumask_set_cpu(cpu, &uncore_cpu_mask);
 
-	uncore_change_context(uncore_msr_uncores, -1, cpu);
+	if (!msr_ret)
+		uncore_change_context(uncore_msr_uncores, -1, cpu);
+	if (!mmio_ret)
+		uncore_change_context(uncore_mmio_uncores, -1, cpu);
 	uncore_change_context(uncore_pci_uncores, -1, cpu);
 	return 0;
 }
@@ -1317,12 +1324,35 @@ err:
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
@@ -1437,7 +1467,7 @@ static int __init intel_uncore_init(void)
 {
 	const struct x86_cpu_id *id;
 	struct intel_uncore_init_fun *uncore_init;
-	int pret = 0, cret = 0, ret;
+	int pret = 0, cret = 0, mret = 0, ret;
 
 	id = x86_match_cpu(intel_uncore_match);
 	if (!id)
@@ -1460,7 +1490,12 @@ static int __init intel_uncore_init(void)
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
@@ -1474,6 +1509,7 @@ static int __init intel_uncore_init(void)
 
 err:
 	uncore_types_exit(uncore_msr_uncores);
+	uncore_types_exit(uncore_mmio_uncores);
 	uncore_pci_exit();
 	return ret;
 }
@@ -1483,6 +1519,7 @@ static void __exit intel_uncore_exit(void)
 {
 	cpuhp_remove_state(CPUHP_AP_PERF_X86_UNCORE_ONLINE);
 	uncore_types_exit(uncore_msr_uncores);
+	uncore_types_exit(uncore_mmio_uncores);
 	uncore_pci_exit();
 }
 module_exit(intel_uncore_exit);
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index b444ed35d6f7..fc5f48816005 100644
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
