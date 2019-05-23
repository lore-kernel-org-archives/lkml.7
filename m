Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7ADC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FFA821773
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="noyZXq8Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbfEWJd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 05:33:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46171 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfEWJd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 05:33:26 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4N9VGVs4042683
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 23 May 2019 02:31:16 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4N9VGVs4042683
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1558603876;
        bh=+M7EPqU26h0B1Z1u98UjZuykFHUDbS0wqvAvgIAiVWU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=noyZXq8Qce3/Jxjrmg1kUegqU5mDUtY+Uo+hQYVWGW6+S/meEZXcx37N20/ppnJ5S
         4B+Yp6fWzBLJpBu29+n5N3/V3cFUVp0FDvoQmPHCfBvxtdDajNGhMBir9gs4haPSsD
         mT/1ImEUBrVfaciCj9dkHdKqnll2oqfMCKjAMBj4VEUXol9QBHmCyIvbsPTKNXBJW5
         UQNrjDqH/vGQnlTpYaGxXQ0F6rEH9DIijwIA1QZmASK/DeE7CO3cq9WSZkEziHGsK4
         Zbz0wKa+rjnjrz+6axP6Jlnul65tQqsL3NIKe5Gy/YKd6bZArNPf0VIACyJ4D0gMX0
         Z67VQNhAAlOFg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4N9VFAp4042680;
        Thu, 23 May 2019 02:31:15 -0700
Date:   Thu, 23 May 2019 02:31:15 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-1ff4a47b2d0c13b755b2eeeb0e23be6c056d5dd9@git.kernel.org>
Cc:     mingo@kernel.org, hpa@zytor.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        kan.liang@linux.intel.com, len.brown@intel.com
Reply-To: hpa@zytor.com, mingo@kernel.org, peterz@infradead.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          kan.liang@linux.intel.com, len.brown@intel.com
In-Reply-To: <a25bba4a5b480aa4e9f8190005d7f5f53e29c8da.1557769318.git.len.brown@intel.com>
References: <a25bba4a5b480aa4e9f8190005d7f5f53e29c8da.1557769318.git.len.brown@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/topology] perf/x86/intel/uncore: Support multi-die/package
Git-Commit-ID: 1ff4a47b2d0c13b755b2eeeb0e23be6c056d5dd9
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

Commit-ID:  1ff4a47b2d0c13b755b2eeeb0e23be6c056d5dd9
Gitweb:     https://git.kernel.org/tip/1ff4a47b2d0c13b755b2eeeb0e23be6c056d5dd9
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Mon, 13 May 2019 13:58:57 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 23 May 2019 10:08:35 +0200

perf/x86/intel/uncore: Support multi-die/package

Uncore becomes die-scope on Xeon Cascade Lake-AP. Uncore driver needs to
support die-scope uncore units.

Use topology_logical_die_id() to replace topology_logical_package_id().
For previous platforms which doesn't have multi-die,
topology_logical_die_id() is identical as topology_logical_package_id().

In pci_probe()/remove(), the group id reads from PCI BUS is logical die id
for multi-die systems.

Use topology_die_cpumask() to replace topology_core_cpumask().
For previous platforms which doesn't have multi-die,
topology_die_cpumask() is identical as topology_core_cpumask().

There is no functional change for previous platforms.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/a25bba4a5b480aa4e9f8190005d7f5f53e29c8da.1557769318.git.len.brown@intel.com

---
 arch/x86/events/intel/uncore.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index fc40a1473058..aeb5eae83750 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -100,7 +100,7 @@ ssize_t uncore_event_show(struct kobject *kobj,
 
 struct intel_uncore_box *uncore_pmu_to_box(struct intel_uncore_pmu *pmu, int cpu)
 {
-	unsigned int pkgid = topology_logical_package_id(cpu);
+	unsigned int pkgid = topology_logical_die_id(cpu);
 
 	/*
 	 * The unsigned check also catches the '-1' return value for non
@@ -942,7 +942,8 @@ static int uncore_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	if (phys_id < 0)
 		return -ENODEV;
 
-	pkg = topology_phys_to_logical_pkg(phys_id);
+	pkg = (topology_max_die_per_package() > 1) ? phys_id :
+					topology_phys_to_logical_pkg(phys_id);
 	if (pkg < 0)
 		return -EINVAL;
 
@@ -1033,7 +1034,8 @@ static void uncore_pci_remove(struct pci_dev *pdev)
 
 	box = pci_get_drvdata(pdev);
 	if (!box) {
-		pkg = topology_phys_to_logical_pkg(phys_id);
+		pkg = (topology_max_die_per_package() > 1) ? phys_id :
+					topology_phys_to_logical_pkg(phys_id);
 		for (i = 0; i < UNCORE_EXTRA_PCI_DEV_MAX; i++) {
 			if (uncore_extra_pci_dev[pkg].dev[i] == pdev) {
 				uncore_extra_pci_dev[pkg].dev[i] = NULL;
@@ -1110,7 +1112,7 @@ static void uncore_change_type_ctx(struct intel_uncore_type *type, int old_cpu,
 	struct intel_uncore_box *box;
 	int i, pkg;
 
-	pkg = topology_logical_package_id(old_cpu < 0 ? new_cpu : old_cpu);
+	pkg = topology_logical_die_id(old_cpu < 0 ? new_cpu : old_cpu);
 	for (i = 0; i < type->num_boxes; i++, pmu++) {
 		box = pmu->boxes[pkg];
 		if (!box)
@@ -1151,7 +1153,7 @@ static int uncore_event_cpu_offline(unsigned int cpu)
 	if (!cpumask_test_and_clear_cpu(cpu, &uncore_cpu_mask))
 		goto unref;
 	/* Find a new cpu to collect uncore events */
-	target = cpumask_any_but(topology_core_cpumask(cpu), cpu);
+	target = cpumask_any_but(topology_die_cpumask(cpu), cpu);
 
 	/* Migrate uncore events to the new target */
 	if (target < nr_cpu_ids)
@@ -1164,7 +1166,7 @@ static int uncore_event_cpu_offline(unsigned int cpu)
 
 unref:
 	/* Clear the references */
-	pkg = topology_logical_package_id(cpu);
+	pkg = topology_logical_die_id(cpu);
 	for (; *types; types++) {
 		type = *types;
 		pmu = type->pmus;
@@ -1223,7 +1225,7 @@ static int uncore_event_cpu_online(unsigned int cpu)
 	struct intel_uncore_box *box;
 	int i, ret, pkg, target;
 
-	pkg = topology_logical_package_id(cpu);
+	pkg = topology_logical_die_id(cpu);
 	ret = allocate_boxes(types, pkg, cpu);
 	if (ret)
 		return ret;
@@ -1242,7 +1244,7 @@ static int uncore_event_cpu_online(unsigned int cpu)
 	 * Check if there is an online cpu in the package
 	 * which collects uncore events already.
 	 */
-	target = cpumask_any_and(&uncore_cpu_mask, topology_core_cpumask(cpu));
+	target = cpumask_any_and(&uncore_cpu_mask, topology_die_cpumask(cpu));
 	if (target < nr_cpu_ids)
 		return 0;
 
@@ -1417,7 +1419,7 @@ static int __init intel_uncore_init(void)
 	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
 		return -ENODEV;
 
-	max_packages = topology_max_packages();
+	max_packages = topology_max_packages() * topology_max_die_per_package();
 
 	uncore_init = (struct intel_uncore_init_fun *)id->driver_data;
 	if (uncore_init->pci_init) {
