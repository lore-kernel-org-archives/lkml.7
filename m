Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346A5C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 12:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F18D426880
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 12:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559304622;
	bh=ksu4tMEHCRo5Z6euRXR4WTk3ATIsLRjXU/XsRRvBxe4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jZZglPUTKmhOOk8lkfrRlk96MDlgYwUB49CXd4PvmdQYdCRutu2DJ6AFnODMs/Ls5
	 /CUjWowKsOcS5vF9BNJdnWcpqkV+zT1HK7X34efDlqYPP0HYSbS9H/Yjbjm7Wj7I8I
	 l6OIGoX2BLwh5Do7sUdhthwEekKFi+MBaJc/KfQg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfEaMKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 08:10:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51388 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727149AbfEaMKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 08:10:16 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 22C41306E5FA;
        Fri, 31 May 2019 12:10:16 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 463FF7C57B;
        Fri, 31 May 2019 12:10:12 +0000 (UTC)
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
Subject: [PATCH 2/8] perf/x86/msr: Use new probe function
Date:   Fri, 31 May 2019 14:09:52 +0200
Message-Id: <20190531120958.29601-3-jolsa@kernel.org>
In-Reply-To: <20190531120958.29601-1-jolsa@kernel.org>
References: <20190531120958.29601-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 31 May 2019 12:10:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using perf_msr_probe function to probe for msr events.

The functionality is the same, with one exception, that
perf_msr_probe checks for rdmsr to return value != 0 for
given MSR register.

Using the new attribute groups and adding the events via
pmu::attr_update.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/events/msr.c | 110 +++++++++++++++++++++++-------------------
 1 file changed, 60 insertions(+), 50 deletions(-)

diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index f3f4c2263501..9431447541e9 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/perf_event.h>
+#include <linux/sysfs.h>
 #include <linux/nospec.h>
 #include <asm/intel-family.h>
+#include "probe.h"
 
 enum perf_msr_id {
 	PERF_MSR_TSC			= 0,
@@ -12,32 +14,30 @@ enum perf_msr_id {
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
@@ -98,37 +98,51 @@ static bool test_intel(int idx)
 	return false;
 }
 
-struct perf_msr {
-	u64	msr;
-	struct	perf_pmu_events_attr *attr;
-	bool	(*test)(int idx);
+PMU_EVENT_ATTR_STRING(tsc,				attr_tsc,		"event=0x00"	);
+PMU_EVENT_ATTR_STRING(aperf,				attr_aperf,		"event=0x01"	);
+PMU_EVENT_ATTR_STRING(mperf,				attr_mperf,		"event=0x02"	);
+PMU_EVENT_ATTR_STRING(pperf,				attr_pperf,		"event=0x03"	);
+PMU_EVENT_ATTR_STRING(smi,				attr_smi,		"event=0x04"	);
+PMU_EVENT_ATTR_STRING(ptsc,				attr_ptsc,		"event=0x05"	);
+PMU_EVENT_ATTR_STRING(irperf,				attr_irperf,		"event=0x06"	);
+PMU_EVENT_ATTR_STRING(cpu_thermal_margin,		attr_therm,		"event=0x07"	);
+PMU_EVENT_ATTR_STRING(cpu_thermal_margin.snapshot,	attr_therm_snap,	"1"		);
+PMU_EVENT_ATTR_STRING(cpu_thermal_margin.unit,		attr_therm_unit,	"C"		);
+
+static unsigned long msr_mask;
+
+PMU_EVENT_GROUP(events, aperf);
+PMU_EVENT_GROUP(events, mperf);
+PMU_EVENT_GROUP(events, pperf);
+PMU_EVENT_GROUP(events, smi);
+PMU_EVENT_GROUP(events, ptsc);
+PMU_EVENT_GROUP(events, irperf);
+
+static struct attribute *attrs_therm[] = {
+	&attr_therm.attr.attr,
+	&attr_therm_snap.attr.attr,
+	&attr_therm_unit.attr.attr,
+	NULL,
 };
 
-PMU_EVENT_ATTR_STRING(tsc,				evattr_tsc,		"event=0x00"	);
-PMU_EVENT_ATTR_STRING(aperf,				evattr_aperf,		"event=0x01"	);
-PMU_EVENT_ATTR_STRING(mperf,				evattr_mperf,		"event=0x02"	);
-PMU_EVENT_ATTR_STRING(pperf,				evattr_pperf,		"event=0x03"	);
-PMU_EVENT_ATTR_STRING(smi,				evattr_smi,		"event=0x04"	);
-PMU_EVENT_ATTR_STRING(ptsc,				evattr_ptsc,		"event=0x05"	);
-PMU_EVENT_ATTR_STRING(irperf,				evattr_irperf,		"event=0x06"	);
-PMU_EVENT_ATTR_STRING(cpu_thermal_margin,		evattr_therm,		"event=0x07"	);
-PMU_EVENT_ATTR_STRING(cpu_thermal_margin.snapshot,	evattr_therm_snap,	"1"		);
-PMU_EVENT_ATTR_STRING(cpu_thermal_margin.unit,		evattr_therm_unit,	"C"		);
+static struct attribute_group group_therm = {
+	.name  = "events",
+	.attrs = attrs_therm,
+};
 
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
+	[PERF_MSR_TSC]		= { .no_check = true,								},
+	[PERF_MSR_APERF]	= { MSR_IA32_APERF,		&group_aperf,		test_aperfmperf,	},
+	[PERF_MSR_MPERF]	= { MSR_IA32_MPERF,		&group_mperf,		test_aperfmperf,	},
+	[PERF_MSR_PPERF]	= { MSR_PPERF,			&group_pperf,		test_intel,		},
+	[PERF_MSR_SMI]		= { MSR_SMI_COUNT,		&group_smi,		test_intel,		},
+	[PERF_MSR_PTSC]		= { MSR_F15H_PTSC,		&group_ptsc,		test_ptsc,		},
+	[PERF_MSR_IRPERF]	= { MSR_F17H_IRPERF,		&group_irperf,		test_irperf,		},
+	[PERF_MSR_THERM]	= { MSR_IA32_THERM_STATUS,	&group_therm,		test_therm_status,	},
 };
 
-static struct attribute *events_attrs[PERF_MSR_EVENT_MAX + 1] = {
+static struct attribute *events_attrs[] = {
+	&attr_tsc.attr.attr,
 	NULL,
 };
 
@@ -153,6 +167,17 @@ static const struct attribute_group *attr_groups[] = {
 	NULL,
 };
 
+const struct attribute_group *attr_update[] = {
+	&group_aperf,
+	&group_mperf,
+	&group_pperf,
+	&group_smi,
+	&group_ptsc,
+	&group_irperf,
+	&group_therm,
+	NULL,
+};
+
 static int msr_event_init(struct perf_event *event)
 {
 	u64 cfg = event->attr.config;
@@ -169,7 +194,7 @@ static int msr_event_init(struct perf_event *event)
 
 	cfg = array_index_nospec((unsigned long)cfg, PERF_MSR_EVENT_MAX);
 
-	if (!msr[cfg].attr)
+	if (!(msr_mask & (1 << cfg)))
 		return -EINVAL;
 
 	event->hw.idx		= -1;
@@ -252,32 +277,17 @@ static struct pmu pmu_msr = {
 	.stop		= msr_event_stop,
 	.read		= msr_event_update,
 	.capabilities	= PERF_PMU_CAP_NO_INTERRUPT | PERF_PMU_CAP_NO_EXCLUDE,
+	.attr_update	= attr_update,
 };
 
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
+	msr_mask = perf_msr_probe(msr, PERF_MSR_EVENT_MAX, true, NULL);
 
 	perf_pmu_register(&pmu_msr, "msr", -1);
 
-- 
2.21.0

