Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA93AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8369E2133D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552933292;
	bh=EtWijxsb2OH4yEabhQSVuZC5uIDHX5tD3oECLF5Hk+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=om673+lcxTkfDACrKmTL6zo3YqqaaQUrDaaJpOeN9s8s0F+R3I7IhlS3nG8Z+BzJ7
	 +5enH++DyLZikcd0b5v278d8JUwfX09Q/I0IYC3PUXX5CAlxGYxFmXa9rIu6tApzVv
	 KpONDrjJDSF7xnnzqkrKniVFE6qvyB0Gcph2adF4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfCRSVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 14:21:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44234 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727392AbfCRSV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 14:21:28 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 18FA737E79;
        Mon, 18 Mar 2019 18:21:28 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9AECE60123;
        Mon, 18 Mar 2019 18:21:25 +0000 (UTC)
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
Subject: [PATCH 3/8] perf/x86/cstate: Use new probe function
Date:   Mon, 18 Mar 2019 19:21:11 +0100
Message-Id: <20190318182116.17388-4-jolsa@kernel.org>
In-Reply-To: <20190318182116.17388-1-jolsa@kernel.org>
References: <20190318182116.17388-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 18 Mar 2019 18:21:28 +0000 (UTC)
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
 arch/x86/events/intel/cstate.c | 92 +++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 46 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 94a4b7fc75d0..af0b9236445a 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -96,6 +96,7 @@
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #include "../perf_event.h"
+#include "../probe.h"
 
 MODULE_LICENSE("GPL");
 
@@ -149,11 +150,23 @@ PMU_EVENT_ATTR_STRING(c3-residency, evattr_cstate_core_c3, "event=0x01");
 PMU_EVENT_ATTR_STRING(c6-residency, evattr_cstate_core_c6, "event=0x02");
 PMU_EVENT_ATTR_STRING(c7-residency, evattr_cstate_core_c7, "event=0x03");
 
-static struct perf_cstate_msr core_msr[] = {
-	[PERF_CSTATE_CORE_C1_RES] = { MSR_CORE_C1_RES,		&evattr_cstate_core_c1 },
-	[PERF_CSTATE_CORE_C3_RES] = { MSR_CORE_C3_RESIDENCY,	&evattr_cstate_core_c3 },
-	[PERF_CSTATE_CORE_C6_RES] = { MSR_CORE_C6_RESIDENCY,	&evattr_cstate_core_c6 },
-	[PERF_CSTATE_CORE_C7_RES] = { MSR_CORE_C7_RESIDENCY,	&evattr_cstate_core_c7 },
+static unsigned long core_msr_mask;
+
+MSR_ATTR(evattr_cstate_core_c1);
+MSR_ATTR(evattr_cstate_core_c3);
+MSR_ATTR(evattr_cstate_core_c6);
+MSR_ATTR(evattr_cstate_core_c7);
+
+static bool test_msr(int idx, void *data)
+{
+	return test_bit(idx, (unsigned long *) data);
+}
+
+static struct perf_msr core_msr[] = {
+	[PERF_CSTATE_CORE_C1_RES] = { MSR_CORE_C1_RES,		msr_evattr_cstate_core_c1,	test_msr },
+	[PERF_CSTATE_CORE_C3_RES] = { MSR_CORE_C3_RESIDENCY,	msr_evattr_cstate_core_c3,	test_msr },
+	[PERF_CSTATE_CORE_C6_RES] = { MSR_CORE_C6_RESIDENCY,	msr_evattr_cstate_core_c6,	test_msr },
+	[PERF_CSTATE_CORE_C7_RES] = { MSR_CORE_C7_RESIDENCY,	msr_evattr_cstate_core_c7,	test_msr },
 };
 
 static struct attribute *core_events_attrs[PERF_CSTATE_CORE_EVENT_MAX + 1] = {
@@ -219,14 +232,24 @@ PMU_EVENT_ATTR_STRING(c8-residency, evattr_cstate_pkg_c8, "event=0x04");
 PMU_EVENT_ATTR_STRING(c9-residency, evattr_cstate_pkg_c9, "event=0x05");
 PMU_EVENT_ATTR_STRING(c10-residency, evattr_cstate_pkg_c10, "event=0x06");
 
-static struct perf_cstate_msr pkg_msr[] = {
-	[PERF_CSTATE_PKG_C2_RES] = { MSR_PKG_C2_RESIDENCY,	&evattr_cstate_pkg_c2 },
-	[PERF_CSTATE_PKG_C3_RES] = { MSR_PKG_C3_RESIDENCY,	&evattr_cstate_pkg_c3 },
-	[PERF_CSTATE_PKG_C6_RES] = { MSR_PKG_C6_RESIDENCY,	&evattr_cstate_pkg_c6 },
-	[PERF_CSTATE_PKG_C7_RES] = { MSR_PKG_C7_RESIDENCY,	&evattr_cstate_pkg_c7 },
-	[PERF_CSTATE_PKG_C8_RES] = { MSR_PKG_C8_RESIDENCY,	&evattr_cstate_pkg_c8 },
-	[PERF_CSTATE_PKG_C9_RES] = { MSR_PKG_C9_RESIDENCY,	&evattr_cstate_pkg_c9 },
-	[PERF_CSTATE_PKG_C10_RES] = { MSR_PKG_C10_RESIDENCY,	&evattr_cstate_pkg_c10 },
+static unsigned long pkg_msr_mask;
+
+MSR_ATTR(evattr_cstate_pkg_c2);
+MSR_ATTR(evattr_cstate_pkg_c3);
+MSR_ATTR(evattr_cstate_pkg_c6);
+MSR_ATTR(evattr_cstate_pkg_c7);
+MSR_ATTR(evattr_cstate_pkg_c8);
+MSR_ATTR(evattr_cstate_pkg_c9);
+MSR_ATTR(evattr_cstate_pkg_c10);
+
+static struct perf_msr pkg_msr[] = {
+	[PERF_CSTATE_PKG_C2_RES]  = { MSR_PKG_C2_RESIDENCY,	msr_evattr_cstate_pkg_c2,	test_msr },
+	[PERF_CSTATE_PKG_C3_RES]  = { MSR_PKG_C3_RESIDENCY,	msr_evattr_cstate_pkg_c3,	test_msr },
+	[PERF_CSTATE_PKG_C6_RES]  = { MSR_PKG_C6_RESIDENCY,	msr_evattr_cstate_pkg_c6,	test_msr },
+	[PERF_CSTATE_PKG_C7_RES]  = { MSR_PKG_C7_RESIDENCY,	msr_evattr_cstate_pkg_c7,	test_msr },
+	[PERF_CSTATE_PKG_C8_RES]  = { MSR_PKG_C8_RESIDENCY,	msr_evattr_cstate_pkg_c8,	test_msr },
+	[PERF_CSTATE_PKG_C9_RES]  = { MSR_PKG_C9_RESIDENCY,	msr_evattr_cstate_pkg_c9,	test_msr },
+	[PERF_CSTATE_PKG_C10_RES] = { MSR_PKG_C10_RESIDENCY,	msr_evattr_cstate_pkg_c10,	test_msr },
 };
 
 static struct attribute *pkg_events_attrs[PERF_CSTATE_PKG_EVENT_MAX + 1] = {
@@ -289,7 +312,8 @@ static int cstate_pmu_event_init(struct perf_event *event)
 	if (event->pmu == &cstate_core_pmu) {
 		if (cfg >= PERF_CSTATE_CORE_EVENT_MAX)
 			return -EINVAL;
-		if (!core_msr[cfg].attr)
+		cfg = array_index_nospec((unsigned long)cfg, PERF_CSTATE_CORE_EVENT_MAX);
+		if (!(core_msr_mask & (1 << cfg)))
 			return -EINVAL;
 		event->hw.event_base = core_msr[cfg].msr;
 		cpu = cpumask_any_and(&cstate_core_cpu_mask,
@@ -298,7 +322,7 @@ static int cstate_pmu_event_init(struct perf_event *event)
 		if (cfg >= PERF_CSTATE_PKG_EVENT_MAX)
 			return -EINVAL;
 		cfg = array_index_nospec((unsigned long)cfg, PERF_CSTATE_PKG_EVENT_MAX);
-		if (!pkg_msr[cfg].attr)
+		if (!(pkg_msr_mask & (1 << cfg)))
 			return -EINVAL;
 		event->hw.event_base = pkg_msr[cfg].msr;
 		cpu = cpumask_any_and(&cstate_pkg_cpu_mask,
@@ -582,31 +606,6 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_cstates_match);
 
-/*
- * Probe the cstate events and insert the available one into sysfs attrs
- * Return false if there are no available events.
- */
-static bool __init cstate_probe_msr(const unsigned long evmsk, int max,
-                                   struct perf_cstate_msr *msr,
-                                   struct attribute **attrs)
-{
-	bool found = false;
-	unsigned int bit;
-	u64 val;
-
-	for (bit = 0; bit < max; bit++) {
-		if (test_bit(bit, &evmsk) && !rdmsrl_safe(msr[bit].msr, &val)) {
-			*attrs++ = &msr[bit].attr->attr.attr;
-			found = true;
-		} else {
-			msr[bit].attr = NULL;
-		}
-	}
-	*attrs = NULL;
-
-	return found;
-}
-
 static int __init cstate_probe(const struct cstate_model *cm)
 {
 	/* SLM has different MSR for PKG C6 */
@@ -618,13 +617,14 @@ static int __init cstate_probe(const struct cstate_model *cm)
 		pkg_msr[PERF_CSTATE_CORE_C6_RES].msr = MSR_KNL_CORE_C6_RESIDENCY;
 
 
-	has_cstate_core = cstate_probe_msr(cm->core_events,
-					   PERF_CSTATE_CORE_EVENT_MAX,
-					   core_msr, core_events_attrs);
+	core_msr_mask = perf_msr_probe(core_msr, PERF_CSTATE_CORE_EVENT_MAX,
+				       core_events_attrs, (void *) &cm->core_events);
+
+	pkg_msr_mask = perf_msr_probe(pkg_msr, PERF_CSTATE_PKG_EVENT_MAX,
+				      pkg_events_attrs, (void *) &cm->pkg_events);
 
-	has_cstate_pkg = cstate_probe_msr(cm->pkg_events,
-					  PERF_CSTATE_PKG_EVENT_MAX,
-					  pkg_msr, pkg_events_attrs);
+	has_cstate_core = !!core_msr_mask;
+	has_cstate_pkg  = !!pkg_msr_mask;
 
 	return (has_cstate_core || has_cstate_pkg) ? 0 : -ENODEV;
 }
-- 
2.17.2

