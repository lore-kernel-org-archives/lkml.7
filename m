Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D34AC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 18:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEB65208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 18:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557770406;
	bh=dD2nMB8UMGWbsPlxc7RtFvocAdCs8Pu/rzFdtOoVUDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=Vygknu6a6o6Z5TbnGXiSbwiYBW3/sZpti2x7xbEtU5K5Oc0oJE6x+Js3p0N7RB55g
	 Z3nEhYZ6Lq9OHxqbGHBOsrLvYKb182EqQypBABeIxtNU8DLkrYf0UN99TwjLq9hWBb
	 OUkqZPHwaaaDs+MF6C5OWbKZRHhrwL+itD20ZZMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732149AbfEMR7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 13:59:40 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33833 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732109AbfEMR7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 13:59:35 -0400
Received: by mail-pg1-f193.google.com with SMTP id c13so7164661pgt.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 10:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=7onjtnZN84JjUK7oZ2w8AiF0xA4BlJXGVsYJW0jGEsg=;
        b=sljGFZlzvzkHMzjG0bIdBztKLD10LnLZSOR95WDG2rjXL7JrDrOntkB7YgTBUhVDxy
         yVM9VCEz8LEuBpbC8PGrFdF1Aa58qBOIC+gQTe9ezcPAABOMSfj0yqZjMx6v5M3iZ5bu
         jU9WVxkavJD7t1POi7ysVmGa9h0ycdElyBGYWmp7l1sTTWx6hjVi9lgQ3fb0r77gABqm
         bb8mQeOm9bzBKNYnw9iLbd0mZjOheNHerjc9L3OsbRZ8yYF858DtuX6giq2Rp4ZDcE1E
         yOqePkEzVFhlAp8WWyDDpyuMXZbiBWFOHrKN2NCEYHrV6jR4LPlNaX1n4Xxn+F6nCAvJ
         IP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=7onjtnZN84JjUK7oZ2w8AiF0xA4BlJXGVsYJW0jGEsg=;
        b=pM+7cXeJAcs9cX+IXLwzrh6BTzX/8I4Ylvrxpom2fzaCsXm3VwfGQtgwA2QpPfFC0T
         nHzR+FwtfrNwaG6Avi4SiPulggHZtj5/ulOcu5ESZ8v5Kr4bMMPyig/d6WhmRPh1vyhK
         Xh6Z4oKxxO3fKrBij+S6B+KGt3SXYZKG/kBBeNO9plrkG3NVghzVYIUvYRdVvbBzxB51
         VdwaYsjjUXHEXiRYZxf+iEq48fenrsGhpOReKmc6SzxVBmeWfSODTngaRS6fJq3ac8UZ
         L5KgOWrAZbPtDddKd4+3cvmL6XoSjMCiRWD/F4sQQdiONj797WcXhBbMymS6QoKbaB0f
         YpoA==
X-Gm-Message-State: APjAAAXIIKyF9fFo+eaL0XGBeujWa32Uzd07tE9uXGszj1NZMZclR0vV
        mltRULLtFrhZ0CpF6dgHuiU=
X-Google-Smtp-Source: APXvYqxMAD8FW48lmfF08ht2JDZkESAGaGmBdI1HDyXeudbzpuQkPurVh6wwLu1KdtaHd5rhYlOIWg==
X-Received: by 2002:aa7:83d4:: with SMTP id j20mr13870791pfn.90.1557770374579;
        Mon, 13 May 2019 10:59:34 -0700 (PDT)
Received: from localhost.localdomain ([96.79.124.202])
        by smtp.gmail.com with ESMTPSA id s12sm9536266pfd.152.2019.05.13.10.59.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 10:59:33 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <len.brown@intel.com>
Subject: [PATCH 13/19] perf/x86/intel/uncore: Support multi-die/package
Date:   Mon, 13 May 2019 13:58:57 -0400
Message-Id: <a25bba4a5b480aa4e9f8190005d7f5f53e29c8da.1557769318.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <7b23d2d26d717b8e14ba137c94b70943f1ae4b5c.1557769318.git.len.brown@intel.com>
References: <7b23d2d26d717b8e14ba137c94b70943f1ae4b5c.1557769318.git.len.brown@intel.com>
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
-- 
2.18.0-rc0

