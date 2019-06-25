Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39E4C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BEF3215EA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="mc46SHqN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730719AbfFYIki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:40:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43383 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729253AbfFYIki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:40:38 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5P8e8nR3532789
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 25 Jun 2019 01:40:08 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5P8e8nR3532789
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561452009;
        bh=idLrJjA8SkYfT/9jLUanHWYICURiHdq3oCEs7OAVeU0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=mc46SHqN2Af+tgYtNRyFkoASFkkfEvW5lpVn5T19Lppn/4yqxZXd/LnKVY33dWF5I
         Wd7uVtTMZNNDZlt/bZ0xaM0E4ePrhKrltqpDFUCyGyPxJWfIu20naNTzDXxfkSbFk3
         9+RqPlIUALa1OKcYHEzT3f1nyahmfcTYFz5cBoZWq5G3rNH5REWplIcj5gniOopp+V
         ajwDwmYq1HGlB5akqhO1NQzChMLcYp9WBBlXKF3iycqUC/TQMOw9PseHhcaxocORdm
         I0Yvr5MCrbVEyvBQixyMo6zS5OutrHr+1gmpaty32eqK3VWlcDaFsDH/Bf/gNxALgH
         +wjgAy/I4llYw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5P8e7IX3532786;
        Tue, 25 Jun 2019 01:40:07 -0700
Date:   Tue, 25 Jun 2019 01:40:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-5fb5273a905ca4cba7aae16e61c26127cadbac5c@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, jolsa@kernel.org, acme@kernel.org,
        alexander.shishkin@linux.intel.com, bp@alien8.de,
        vincent.weaver@maine.edu, mingo@kernel.org, peterz@infradead.org,
        gregkh@linuxfoundation.org, jolsa@redhat.com, namhyung@kernel.org,
        torvalds@linux-foundation.org, hpa@zytor.com, luto@kernel.org,
        tglx@linutronix.de, kan.liang@linux.intel.com, acme@redhat.com,
        eranian@google.com
Reply-To: tglx@linutronix.de, luto@kernel.org, eranian@google.com,
          acme@redhat.com, kan.liang@linux.intel.com, peterz@infradead.org,
          mingo@kernel.org, bp@alien8.de, vincent.weaver@maine.edu,
          alexander.shishkin@linux.intel.com, acme@kernel.org,
          linux-kernel@vger.kernel.org, jolsa@kernel.org, hpa@zytor.com,
          torvalds@linux-foundation.org, namhyung@kernel.org,
          jolsa@redhat.com, gregkh@linuxfoundation.org
In-Reply-To: <20190616140358.27799-5-jolsa@kernel.org>
References: <20190616140358.27799-5-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86/rapl: Use new MSR detection interface
Git-Commit-ID: 5fb5273a905ca4cba7aae16e61c26127cadbac5c
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

Commit-ID:  5fb5273a905ca4cba7aae16e61c26127cadbac5c
Gitweb:     https://git.kernel.org/tip/5fb5273a905ca4cba7aae16e61c26127cadbac5c
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 16 Jun 2019 16:03:54 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 24 Jun 2019 19:28:33 +0200

perf/x86/rapl: Use new MSR detection interface

Using perf_msr_probe function to probe for RAPL MSRs.

Adding new rapl_model_match device table, that
gathers events info for given model, following
the MSR and cstate module design.

It will replace the current rapl_cpu_match device
table and detection code in following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan <kan.liang@linux.intel.com>
Cc: Liang
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Link: https://lkml.kernel.org/r/20190616140358.27799-5-jolsa@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/rapl.c | 192 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 191 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/rapl.c b/arch/x86/events/intel/rapl.c
index 798135419a62..fa6d8065db15 100644
--- a/arch/x86/events/intel/rapl.c
+++ b/arch/x86/events/intel/rapl.c
@@ -58,6 +58,7 @@
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #include "../perf_event.h"
+#include "../probe.h"
 
 MODULE_LICENSE("GPL");
 
@@ -76,6 +77,17 @@ MODULE_LICENSE("GPL");
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
@@ -153,6 +165,11 @@ struct rapl_pmus {
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
@@ -538,9 +555,18 @@ static struct attribute *rapl_events_knl_attr[] = {
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
@@ -561,6 +587,79 @@ static const struct attribute_group *rapl_attr_groups[] = {
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
@@ -674,6 +773,15 @@ static void cleanup_rapl_pmus(void)
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
 	int maxdie = topology_max_packages() * topology_max_die_per_package();
@@ -686,6 +794,7 @@ static int __init init_rapl_pmus(void)
 
 	rapl_pmus->maxdie		= maxdie;
 	rapl_pmus->pmu.attr_groups	= rapl_attr_groups;
+	rapl_pmus->pmu.attr_update	= rapl_attr_update;
 	rapl_pmus->pmu.task_ctx_nr	= perf_invalid_context;
 	rapl_pmus->pmu.event_init	= rapl_pmu_event_init;
 	rapl_pmus->pmu.add		= rapl_pmu_event_add;
@@ -784,13 +893,94 @@ static const struct x86_cpu_id rapl_cpu_match[] __initconst = {
 
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
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ICELAKE_DESKTOP,	model_skl),
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
