Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981F9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A90B2133D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552933289;
	bh=ybS1XyanrzwXsUMqGmwCH2Mmn8/4FMNkT16QSdCz/vA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fffaZ3Dozybp0HW9vz+kXi+MCjaWmN14ukTLEQO160jSZzc0caeS2jCjxKsZ7otgp
	 8P+6kSV2Rgvw67OGUhddgALsTMHiQDFYFFXr+Upe4Bw8FLV8ztuGEHii1YcHVxPo9C
	 Rd2E/BDxxMZScke02sWs0SSMjpGWBQaU+ouOm3dg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfCRSV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 14:21:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54313 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbfCRSV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 14:21:26 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5194830821E0;
        Mon, 18 Mar 2019 18:21:25 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 75F1F600D4;
        Mon, 18 Mar 2019 18:21:22 +0000 (UTC)
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
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 2/8] perf/x86/msr: Use new probe function
Date:   Mon, 18 Mar 2019 19:21:10 +0100
Message-Id: <20190318182116.17388-3-jolsa@kernel.org>
In-Reply-To: <20190318182116.17388-1-jolsa@kernel.org>
References: <20190318182116.17388-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 18 Mar 2019 18:21:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using perf_msr_probe function to add msr events.

The functionality is the same, with one exception,
that perf_msr_probe checks for rdmsr to return
value != 0 for given MSR register.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/events/msr.c | 76 ++++++++++++++++++++-----------------------
 1 file changed, 35 insertions(+), 41 deletions(-)

diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index a878e6286e4a..926d887aa606 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -2,6 +2,7 @@
 #include <linux/perf_event.h>
 #include <linux/nospec.h>
 #include <asm/intel-family.h>
+#include "probe.h"
 
 enum perf_msr_id {
 	PERF_MSR_TSC			= 0,
@@ -12,32 +13,30 @@ enum perf_msr_id {
 	PERF_MSR_PTSC			= 5,
 	PERF_MSR_IRPERF			= 6,
 	PERF_MSR_THERM			= 7,
-	PERF_MSR_THERM_SNAP		= 8,
-	PERF_MSR_THERM_UNIT		= 9,
 	PERF_MSR_EVENT_MAX,
 };
 
-static bool test_aperfmperf(int idx)
+static bool test_aperfmperf(int idx, void *data)
 {
 	return boot_cpu_has(X86_FEATURE_APERFMPERF);
 }
 
-static bool test_ptsc(int idx)
+static bool test_ptsc(int idx, void *data)
 {
 	return boot_cpu_has(X86_FEATURE_PTSC);
 }
 
-static bool test_irperf(int idx)
+static bool test_irperf(int idx, void *data)
 {
 	return boot_cpu_has(X86_FEATURE_IRPERF);
 }
 
-static bool test_therm_status(int idx)
+static bool test_therm_status(int idx, void *data)
 {
 	return boot_cpu_has(X86_FEATURE_DTHERM);
 }
 
-static bool test_intel(int idx)
+static bool test_intel(int idx, void *data)
 {
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL ||
 	    boot_cpu_data.x86 != 6)
@@ -97,12 +96,6 @@ static bool test_intel(int idx)
 	return false;
 }
 
-struct perf_msr {
-	u64	msr;
-	struct	perf_pmu_events_attr *attr;
-	bool	(*test)(int idx);
-};
-
 PMU_EVENT_ATTR_STRING(tsc,				evattr_tsc,		"event=0x00"	);
 PMU_EVENT_ATTR_STRING(aperf,				evattr_aperf,		"event=0x01"	);
 PMU_EVENT_ATTR_STRING(mperf,				evattr_mperf,		"event=0x02"	);
@@ -114,17 +107,32 @@ PMU_EVENT_ATTR_STRING(cpu_thermal_margin,		evattr_therm,		"event=0x07"	);
 PMU_EVENT_ATTR_STRING(cpu_thermal_margin.snapshot,	evattr_therm_snap,	"1"		);
 PMU_EVENT_ATTR_STRING(cpu_thermal_margin.unit,		evattr_therm_unit,	"C"		);
 
+static unsigned long msr_mask;
+
+MSR_ATTR(evattr_tsc);
+MSR_ATTR(evattr_aperf);
+MSR_ATTR(evattr_mperf);
+MSR_ATTR(evattr_pperf);
+MSR_ATTR(evattr_smi);
+MSR_ATTR(evattr_ptsc);
+MSR_ATTR(evattr_irperf);
+
+static struct attribute *msr_evattr_therm[] = {
+	&evattr_therm.attr.attr,
+	&evattr_therm_snap.attr.attr,
+	&evattr_therm_unit.attr.attr,
+	NULL,
+};
+
 static struct perf_msr msr[] = {
-	[PERF_MSR_TSC]		= { 0,				&evattr_tsc,		NULL,			},
-	[PERF_MSR_APERF]	= { MSR_IA32_APERF,		&evattr_aperf,		test_aperfmperf,	},
-	[PERF_MSR_MPERF]	= { MSR_IA32_MPERF,		&evattr_mperf,		test_aperfmperf,	},
-	[PERF_MSR_PPERF]	= { MSR_PPERF,			&evattr_pperf,		test_intel,		},
-	[PERF_MSR_SMI]		= { MSR_SMI_COUNT,		&evattr_smi,		test_intel,		},
-	[PERF_MSR_PTSC]		= { MSR_F15H_PTSC,		&evattr_ptsc,		test_ptsc,		},
-	[PERF_MSR_IRPERF]	= { MSR_F17H_IRPERF,		&evattr_irperf,		test_irperf,		},
-	[PERF_MSR_THERM]	= { MSR_IA32_THERM_STATUS,	&evattr_therm,		test_therm_status,	},
-	[PERF_MSR_THERM_SNAP]	= { MSR_IA32_THERM_STATUS,	&evattr_therm_snap,	test_therm_status,	},
-	[PERF_MSR_THERM_UNIT]	= { MSR_IA32_THERM_STATUS,	&evattr_therm_unit,	test_therm_status,	},
+	[PERF_MSR_TSC]		= { 0,				msr_evattr_tsc,		NULL,			},
+	[PERF_MSR_APERF]	= { MSR_IA32_APERF,		msr_evattr_aperf,	test_aperfmperf,	},
+	[PERF_MSR_MPERF]	= { MSR_IA32_MPERF,		msr_evattr_mperf,	test_aperfmperf,	},
+	[PERF_MSR_PPERF]	= { MSR_PPERF,			msr_evattr_pperf,	test_intel,		},
+	[PERF_MSR_SMI]		= { MSR_SMI_COUNT,		msr_evattr_smi,		test_intel,		},
+	[PERF_MSR_PTSC]		= { MSR_F15H_PTSC,		msr_evattr_ptsc,	test_ptsc,		},
+	[PERF_MSR_IRPERF]	= { MSR_F17H_IRPERF,		msr_evattr_irperf,	test_irperf,		},
+	[PERF_MSR_THERM]	= { MSR_IA32_THERM_STATUS,	msr_evattr_therm,	test_therm_status,	},
 };
 
 static struct attribute *events_attrs[PERF_MSR_EVENT_MAX + 1] = {
@@ -168,7 +176,7 @@ static int msr_event_init(struct perf_event *event)
 
 	cfg = array_index_nospec((unsigned long)cfg, PERF_MSR_EVENT_MAX);
 
-	if (!msr[cfg].attr)
+	if (!(msr_mask & (1 << cfg)))
 		return -EINVAL;
 
 	event->hw.idx		= -1;
@@ -255,28 +263,14 @@ static struct pmu pmu_msr = {
 
 static int __init msr_init(void)
 {
-	int i, j = 0;
-
 	if (!boot_cpu_has(X86_FEATURE_TSC)) {
 		pr_cont("no MSR PMU driver.\n");
 		return 0;
 	}
 
-	/* Probe the MSRs. */
-	for (i = PERF_MSR_TSC + 1; i < PERF_MSR_EVENT_MAX; i++) {
-		u64 val;
-
-		/* Virt sucks; you cannot tell if a R/O MSR is present :/ */
-		if (!msr[i].test(i) || rdmsrl_safe(msr[i].msr, &val))
-			msr[i].attr = NULL;
-	}
-
-	/* List remaining MSRs in the sysfs attrs. */
-	for (i = 0; i < PERF_MSR_EVENT_MAX; i++) {
-		if (msr[i].attr)
-			events_attrs[j++] = &msr[i].attr->attr.attr;
-	}
-	events_attrs[j] = NULL;
+	msr[PERF_MSR_TSC].no_check = true;
+	msr_mask = perf_msr_probe(msr, PERF_MSR_EVENT_MAX,
+				  events_attrs, NULL);
 
 	perf_pmu_register(&pmu_msr, "msr", -1);
 
-- 
2.17.2

