Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6F1C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C7C20657
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="mC0pp2bK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730703AbfFYIjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:39:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56319 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfFYIjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:39:15 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5P8cfwq3532301
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 25 Jun 2019 01:38:41 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5P8cfwq3532301
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561451922;
        bh=qbsaBjj9EK527xL8PnU/Aq22cIiBo0DGeeIkZlndf5w=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=mC0pp2bKsuo7ZAEOdHSY+xdKVo+zKKcLMTHdw1aL/LgGCuiKqc1bcGuu90sWRSgbo
         tK5m0SyEvigTOsg2C0/QX14fOW2Ziu19y5qSIB4d/hMH25z85xhXqTZS6W36kAjs0a
         mTNMnfvke72VY5IUvmosiuZGPMgOqg6hkla5isnpIHtFT+v+3YpheGMvCh2zKd2Dfy
         ggt4CFI9zRE41nztkTm49vcQX4thxtFpvxTpxr0Q65B3AR9H+3VH+VjFLjyzaCMp+g
         0+R62HY08kuD/pXRca0zgooYLv6t0rrkW8mOa2eN6aXiq6LU2gdMOjGgepRHkL8WEw
         273DANYt3i7yA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5P8ceIc3532298;
        Tue, 25 Jun 2019 01:38:40 -0700
Date:   Tue, 25 Jun 2019 01:38:40 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-dde5e72068cd0cd8237f7c2589ec8f587563a390@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, acme@kernel.org,
        kan.liang@linux.intel.com, jolsa@kernel.org,
        gregkh@linuxfoundation.org, jolsa@redhat.com, peterz@infradead.org,
        namhyung@kernel.org, torvalds@linux-foundation.org,
        tglx@linutronix.de, vincent.weaver@maine.edu, hpa@zytor.com,
        luto@kernel.org, eranian@google.com, bp@alien8.de, acme@redhat.com
Reply-To: hpa@zytor.com, luto@kernel.org, namhyung@kernel.org,
          torvalds@linux-foundation.org, tglx@linutronix.de,
          vincent.weaver@maine.edu, acme@redhat.com, eranian@google.com,
          bp@alien8.de, acme@kernel.org, kan.liang@linux.intel.com,
          jolsa@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
          alexander.shishkin@linux.intel.com, jolsa@redhat.com,
          peterz@infradead.org, gregkh@linuxfoundation.org
In-Reply-To: <20190616140358.27799-3-jolsa@kernel.org>
References: <20190616140358.27799-3-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86/msr: Use new probe function
Git-Commit-ID: dde5e72068cd0cd8237f7c2589ec8f587563a390
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

Commit-ID:  dde5e72068cd0cd8237f7c2589ec8f587563a390
Gitweb:     https://git.kernel.org/tip/dde5e72068cd0cd8237f7c2589ec8f587563a390
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 16 Jun 2019 16:03:52 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 24 Jun 2019 19:28:32 +0200

perf/x86/msr: Use new probe function

Using perf_msr_probe function to probe for msr events.

The functionality is the same, with one exception, that
perf_msr_probe checks for rdmsr to return value != 0 for
given MSR register.

Using the new attribute groups and adding the events via
pmu::attr_update.

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
Link: https://lkml.kernel.org/r/20190616140358.27799-3-jolsa@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/msr.c | 110 +++++++++++++++++++++++++++-----------------------
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
 
