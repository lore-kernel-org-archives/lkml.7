Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A703CC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 12:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 729C5268B4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 12:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559304636;
	bh=OI81bqH0hfBmSoDZangebmBny/Uf3dK8Ptoq2G95tk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Wai4TVz5ESh+QdOsAfE/W8yYADlDrB6yLXFnAea/0WYZTQ0C1+jTe9eHUJo/8WDf+
	 i6f3e7nbOKV/4tfpuKxbfmWW385r0sjhrsPeORxF06zfR2cgyPl1Rrb2ihHdlpKkmD
	 wwV0q5LK4E+sUu79DIdcRSoYyUzpN8UxY9gLb+44=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbfEaMKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 08:10:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33924 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727376AbfEaMKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 08:10:34 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6E8B0A3B67;
        Fri, 31 May 2019 12:10:23 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9913A7838D;
        Fri, 31 May 2019 12:10:20 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4/8] perf/x86/rapl: Use new msr detection interface
Date:   Fri, 31 May 2019 14:09:54 +0200
Message-Id: <20190531120958.29601-5-jolsa@kernel.org>
In-Reply-To: <20190531120958.29601-1-jolsa@kernel.org>
References: <20190531120958.29601-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 31 May 2019 12:10:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using perf_msr_probe function to probe for rapl msrs.

Adding new rapl_model_match device table, that
gathers events info for given model, following
the msr and cstate module design.

It will replace the current rapl_cpu_match device
table and detection code in following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/events/intel/rapl.c | 191 ++++++++++++++++++++++++++++++++++-
 1 file changed, 190 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/rapl.c b/arch/x86/events/intel/rapl.c
index 37ebf6fc5415..c0f15b63f395 100644
--- a/arch/x86/events/intel/rapl.c
+++ b/arch/x86/events/intel/rapl.c
@@ -57,6 +57,7 @@
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #include "../perf_event.h"
+#include "../probe.h"
 
 MODULE_LICENSE("GPL");
 
@@ -75,6 +76,17 @@ MODULE_LICENSE("GPL");
 #define INTEL_RAPL_PSYS		0x5	/* pseudo-encoding */
 
 #define NR_RAPL_DOMAINS         0x5
+
+enum perf_rapl_events {
+	PERF_RAPL_PP0 = 0,		/* all cores */
+	PERF_RAPL_PKG,			/* entire package */
+	PERF_RAPL_RAM,			/* DRAM */
+	PERF_RAPL_PP1,			/* gpu */
+	PERF_RAPL_PSYS,			/* psys */
+
+	PERF_RAPL_MAX,
+};
+
 static const char *const rapl_domain_names[NR_RAPL_DOMAINS] __initconst = {
 	"pp0-core",
 	"package",
@@ -152,6 +164,11 @@ struct rapl_pmus {
 	struct rapl_pmu		*pmus[];
 };
 
+struct rapl_model {
+	unsigned long	events;
+	bool		apply_quirk;
+};
+
  /* 1/2^hw_unit Joule */
 static int rapl_hw_unit[NR_RAPL_DOMAINS] __read_mostly;
 static struct rapl_pmus *rapl_pmus;
@@ -537,9 +554,18 @@ static struct attribute *rapl_events_knl_attr[] = {
 	NULL,
 };
 
+/*
+ * There are no default events, but we need to create
+ * "events" group (with empty attrs) before updating
+ * it with detected events.
+ */
+static struct attribute *attrs_empty[] = {
+	NULL,
+};
+
 static struct attribute_group rapl_pmu_events_group = {
 	.name = "events",
-	.attrs = NULL, /* patched at runtime */
+	.attrs = attrs_empty,
 };
 
 DEFINE_RAPL_FORMAT_ATTR(event, event, "config:0-7");
@@ -560,6 +586,79 @@ static const struct attribute_group *rapl_attr_groups[] = {
 	NULL,
 };
 
+static struct attribute *rapl_events_cores[] = {
+	EVENT_PTR(rapl_cores),
+	EVENT_PTR(rapl_cores_unit),
+	EVENT_PTR(rapl_cores_scale),
+	NULL,
+};
+
+static struct attribute_group rapl_events_cores_group = {
+	.name  = "events",
+	.attrs = rapl_events_cores,
+};
+
+static struct attribute *rapl_events_pkg[] = {
+	EVENT_PTR(rapl_pkg),
+	EVENT_PTR(rapl_pkg_unit),
+	EVENT_PTR(rapl_pkg_scale),
+	NULL,
+};
+
+static struct attribute_group rapl_events_pkg_group = {
+	.name  = "events",
+	.attrs = rapl_events_pkg,
+};
+
+static struct attribute *rapl_events_ram[] = {
+	EVENT_PTR(rapl_ram),
+	EVENT_PTR(rapl_ram_unit),
+	EVENT_PTR(rapl_ram_scale),
+	NULL,
+};
+
+static struct attribute_group rapl_events_ram_group = {
+	.name  = "events",
+	.attrs = rapl_events_ram,
+};
+
+static struct attribute *rapl_events_gpu[] = {
+	EVENT_PTR(rapl_gpu),
+	EVENT_PTR(rapl_gpu_unit),
+	EVENT_PTR(rapl_gpu_scale),
+	NULL,
+};
+
+static struct attribute_group rapl_events_gpu_group = {
+	.name  = "events",
+	.attrs = rapl_events_gpu,
+};
+
+static struct attribute *rapl_events_psys[] = {
+	EVENT_PTR(rapl_psys),
+	EVENT_PTR(rapl_psys_unit),
+	EVENT_PTR(rapl_psys_scale),
+	NULL,
+};
+
+static struct attribute_group rapl_events_psys_group = {
+	.name  = "events",
+	.attrs = rapl_events_psys,
+};
+
+static bool test_msr(int idx, void *data)
+{
+	return test_bit(idx, (unsigned long *) data);
+}
+
+static struct perf_msr rapl_msrs[] = {
+	[PERF_RAPL_PP0]  = { MSR_PP0_ENERGY_STATUS,      &rapl_events_cores_group, test_msr },
+	[PERF_RAPL_PKG]  = { MSR_PKG_ENERGY_STATUS,      &rapl_events_pkg_group,   test_msr },
+	[PERF_RAPL_RAM]  = { MSR_DRAM_ENERGY_STATUS,     &rapl_events_ram_group,   test_msr },
+	[PERF_RAPL_PP1]  = { MSR_PP1_ENERGY_STATUS,      &rapl_events_gpu_group,   test_msr },
+	[PERF_RAPL_PSYS] = { MSR_PLATFORM_ENERGY_STATUS, &rapl_events_psys_group,  test_msr },
+};
+
 static int rapl_cpu_offline(unsigned int cpu)
 {
 	struct rapl_pmu *pmu = cpu_to_rapl_pmu(cpu);
@@ -673,6 +772,15 @@ static void cleanup_rapl_pmus(void)
 	kfree(rapl_pmus);
 }
 
+const struct attribute_group *rapl_attr_update[] = {
+	&rapl_events_cores_group,
+	&rapl_events_pkg_group,
+	&rapl_events_ram_group,
+	&rapl_events_gpu_group,
+	&rapl_events_gpu_group,
+	NULL,
+};
+
 static int __init init_rapl_pmus(void)
 {
 	int maxpkg = topology_max_packages();
@@ -685,6 +793,7 @@ static int __init init_rapl_pmus(void)
 
 	rapl_pmus->maxpkg		= maxpkg;
 	rapl_pmus->pmu.attr_groups	= rapl_attr_groups;
+	rapl_pmus->pmu.attr_update	= rapl_attr_update;
 	rapl_pmus->pmu.task_ctx_nr	= perf_invalid_context;
 	rapl_pmus->pmu.event_init	= rapl_pmu_event_init;
 	rapl_pmus->pmu.add		= rapl_pmu_event_add;
@@ -782,13 +891,93 @@ static const struct x86_cpu_id rapl_cpu_match[] __initconst = {
 
 MODULE_DEVICE_TABLE(x86cpu, rapl_cpu_match);
 
+static struct rapl_model model_snb = {
+	.events		= BIT(PERF_RAPL_PP0) |
+			  BIT(PERF_RAPL_PKG) |
+			  BIT(PERF_RAPL_PP1),
+	.apply_quirk	= false,
+};
+
+static struct rapl_model model_snbep = {
+	.events		= BIT(PERF_RAPL_PP0) |
+			  BIT(PERF_RAPL_PKG) |
+			  BIT(PERF_RAPL_RAM),
+	.apply_quirk	= false,
+};
+
+static struct rapl_model model_hsw = {
+	.events		= BIT(PERF_RAPL_PP0) |
+			  BIT(PERF_RAPL_PKG) |
+			  BIT(PERF_RAPL_RAM) |
+			  BIT(PERF_RAPL_PP1),
+	.apply_quirk	= false,
+};
+
+static struct rapl_model model_hsx = {
+	.events		= BIT(PERF_RAPL_PP0) |
+			  BIT(PERF_RAPL_PKG) |
+			  BIT(PERF_RAPL_RAM),
+	.apply_quirk	= true,
+};
+
+static struct rapl_model model_knl = {
+	.events		= BIT(PERF_RAPL_PKG) |
+			  BIT(PERF_RAPL_RAM),
+	.apply_quirk	= true,
+};
+
+static struct rapl_model model_skl = {
+	.events		= BIT(PERF_RAPL_PP0) |
+			  BIT(PERF_RAPL_PKG) |
+			  BIT(PERF_RAPL_RAM) |
+			  BIT(PERF_RAPL_PP1) |
+			  BIT(PERF_RAPL_PSYS),
+	.apply_quirk	= false,
+};
+
+static const struct x86_cpu_id rapl_model_match[] __initconst = {
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_SANDYBRIDGE,		model_snb),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_SANDYBRIDGE_X,		model_snbep),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_IVYBRIDGE,		model_snb),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_IVYBRIDGE_X,		model_snbep),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_HASWELL_CORE,		model_hsw),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_HASWELL_X,		model_hsx),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_HASWELL_ULT,		model_hsw),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_HASWELL_GT3E,		model_hsw),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL_CORE,		model_hsw),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL_GT3E,		model_hsw),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL_X,		model_hsx),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL_XEON_D,	model_hsx),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_XEON_PHI_KNL,		model_knl),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_XEON_PHI_KNM,		model_knl),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_SKYLAKE_MOBILE,		model_skl),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_SKYLAKE_DESKTOP,	model_skl),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_SKYLAKE_X,		model_hsx),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_KABYLAKE_MOBILE,	model_skl),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_KABYLAKE_DESKTOP,	model_skl),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_CANNONLAKE_MOBILE,	model_skl),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ATOM_GOLDMONT,		model_hsw),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ATOM_GOLDMONT_X,	model_hsw),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ATOM_GOLDMONT_PLUS,	model_hsw),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ICELAKE_MOBILE,		model_skl),
+	{},
+};
+
 static int __init rapl_pmu_init(void)
 {
 	const struct x86_cpu_id *id;
 	struct intel_rapl_init_fun *rapl_init;
+	struct rapl_model *rm;
 	bool apply_quirk;
 	int ret;
 
+	id = x86_match_cpu(rapl_model_match);
+	if (!id)
+		return -ENODEV;
+
+	rm = (struct rapl_model *) id->driver_data;
+	perf_msr_probe(rapl_msrs, PERF_RAPL_MAX, false, (void *) &rm->events);
+
 	id = x86_match_cpu(rapl_cpu_match);
 	if (!id)
 		return -ENODEV;
-- 
2.21.0

