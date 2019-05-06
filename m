Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3130C04AAB
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 747BD2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557178009;
	bh=Mg455CaQtrldQHNm99B2B+0lwo+ctvkfUKnaVrDevLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=XR9RnAdY+oX3O+tmTc4ZyLRi9wz6a2SS1ZZbCAnM4J1HxBFPg/hETN1EJbReeywMi
	 7cYHwZxj72S5LDto1DddL1dGk/esoFMoh/dnEabpLYZZFN0lYauMiarlwU8fnmjrDD
	 TSV/vo8woqa7Bo+eBgIRD83YTvU0h6atM9N6nTFQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfEFV0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 17:26:48 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:52506 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbfEFV0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 17:26:46 -0400
Received: by mail-it1-f195.google.com with SMTP id q65so21434307itg.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 14:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=xc8GKgAhN2BvbVtHbXIFXp3HIXwPjdL/8iP1wX8Tn7g=;
        b=ozFQSbOZOyhObe/no7EhClYnzFZzOsCbgo4msZ+u1fLhicbN21oM6AcTsExK91rdfm
         +fd2ZYhdfc1ENDRemCuw90t6iFB2kxr/M4UEI/n50xyxxONR5P1en9MSoLwTBqo6UTJM
         iFF6tNPbknYhDiFetefa0H6devKafP72nRFJgEYqIXHEDkYSEQ1cR2B/4B3nncGSDCEE
         /W9jvzmMy6tczOttS/cQo3oQxb7DXtFxVY3uH1dFwVZZrvX4dnlo1Sb3xRySj7tJ5fz8
         J86Jcy7BD6NS5kds6a7j7+KKKQU6kwsq6V0BmY0ibj+rLOaBKxXOJ5tGEU8QSJmVT8Hq
         88Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=xc8GKgAhN2BvbVtHbXIFXp3HIXwPjdL/8iP1wX8Tn7g=;
        b=PKFb8c13aUCh91M6GrBSbSrCO5ba2FTGLH5UovrJlTIlQqWvtlF+9Xt/haE7rkrzAJ
         Kk1uybinx/Ogif/nd+wuvZ7XW0Q74P/Uy85nzS2OtEmwlDIEw3smW9bxZj3h3TTXiigG
         6HU8Toc5p9QAhQxQ4FaVNVz+UDZMYxugaGX0a3z7bxAMufCCP0q4jN278fxo7ao0wK1H
         RZn3UC78sAYAw3kg+nG3QUvq+zCFhJYk69ux4r9VjOn8qaE4Q+nDMu6hFmGBLNlTtNUw
         MLPgx95QzI/PKNrrcakL+33lHC0EZgcPmnr8ndbvXuHg+9k9rWtESK50aZ6+2d2zbccq
         ZpxA==
X-Gm-Message-State: APjAAAVTjc5mw4IV/UXGLhiYQcgyGBAzqWaIc7QDEWKiIKFcxq+zmkCl
        63uwiTG2XrmppppQEMXYJEM=
X-Google-Smtp-Source: APXvYqygrG8Bj0hd8b9f6a8cGA8LyqsJ5nXu/CF7g9z3/v2GelvFtbElk0TBz6cXZlTaVLTMyd56yg==
X-Received: by 2002:a24:4161:: with SMTP id x94mr19479400ita.83.1557178005568;
        Mon, 06 May 2019 14:26:45 -0700 (PDT)
Received: from nuc8.lan (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id v25sm4268009ioh.81.2019.05.06.14.26.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 14:26:44 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <len.brown@intel.com>
Subject: [PATCH 16/22] perf/x86/intel/uncore: Support multi-die/package
Date:   Mon,  6 May 2019 17:26:11 -0400
Message-Id: <1d7c4d47cfca91c11b0e078d86a8f7f7da6d862a.1557177585.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1557177585.git.len.brown@intel.com>
References: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1557177585.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Uncore becomes die-scope on Xeon Cascade Lake-AP. Uncore driver needs to
support die-scope uncore units.

Use topology_logical_die_id() to replace topology_logical_package_id().
For previous platforms which doesn't have multi-die,
topology_logical_die_id() is identical as topology_logical_package_id().

In pci_probe/remove, the group id reads from PCI BUS is logical die id
for multi-die systems.

Use topology_die_cpumask() to replace topology_core_cpumask().
For previous platforms which doesn't have multi-die,
topology_die_cpumask() is identical as topology_core_cpumask().

There is no functional change for previous platforms.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/events/intel/uncore.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 9fe64c01a2e5..a6461ff85a32 100644
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
 
@@ -1411,7 +1413,7 @@ static int __init intel_uncore_init(void)
 	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
 		return -ENODEV;
 
-	max_packages = topology_max_packages();
+	max_packages = topology_max_packages() * topology_max_die_per_package();
 
 	uncore_init = (struct intel_uncore_init_fun *)id->driver_data;
 	if (uncore_init->pci_init) {
-- 
2.18.0-rc0

