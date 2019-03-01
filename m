Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC5CC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 11:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D3F2083E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 11:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387646AbfCALmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 06:42:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38336 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbfCALmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 06:42:54 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8F33BE9510;
        Fri,  1 Mar 2019 11:42:53 +0000 (UTC)
Received: from krava (ovpn-204-247.brq.redhat.com [10.40.204.247])
        by smtp.corp.redhat.com (Postfix) with SMTP id 46EC65D9C5;
        Fri,  1 Mar 2019 11:42:51 +0000 (UTC)
Date:   Fri, 1 Mar 2019 12:42:50 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Vince Weaver <vincent.weaver@maine.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: [RFC] perf/x86/rapl: Getting zero on energy-cores event
Message-ID: <20190301114250.GA23459@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 01 Mar 2019 11:42:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
I'm getting zero counts for energy-cores event on broadwell-x
server (model 0x4f)

I checked intel_rapl powercap driver and it won't export the
counter if it rdmsr returns zero on it 

the SDM also says the rdmsr returns zero for some models

I made changes on perf rapl pmu below to remove sysfs events
if their rdmsr returns zero just to ilustrate the case

I think there's probably better fix, but I'm not sure if
there's a reason for zero counters to be exposed..?

thoughts? thanks,
jirka


---
diff --git a/arch/x86/events/intel/rapl.c b/arch/x86/events/intel/rapl.c
index 94dc564146ca..effb9a9d2368 100644
--- a/arch/x86/events/intel/rapl.c
+++ b/arch/x86/events/intel/rapl.c
@@ -54,6 +54,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/perf_event.h>
+#include <linux/nospec.h>
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #include "../perf_event.h"
@@ -346,10 +347,18 @@ static void rapl_pmu_event_del(struct perf_event *event, int flags)
 	rapl_pmu_event_stop(event, PERF_EF_UPDATE);
 }
 
+static unsigned int event_msr[NR_RAPL_DOMAINS] = {
+	MSR_PP0_ENERGY_STATUS,
+	MSR_PKG_ENERGY_STATUS,
+	MSR_DRAM_ENERGY_STATUS,
+	MSR_PP1_ENERGY_STATUS,
+	MSR_PLATFORM_ENERGY_STATUS,
+};
+
 static int rapl_pmu_event_init(struct perf_event *event)
 {
 	u64 cfg = event->attr.config & RAPL_EVENT_MASK;
-	int bit, msr, ret = 0;
+	int bit, ret = 0;
 	struct rapl_pmu *pmu;
 
 	/* only look at RAPL events */
@@ -365,33 +374,12 @@ static int rapl_pmu_event_init(struct perf_event *event)
 
 	event->event_caps |= PERF_EV_CAP_READ_ACTIVE_PKG;
 
-	/*
-	 * check event is known (determines counter)
-	 */
-	switch (cfg) {
-	case INTEL_RAPL_PP0:
-		bit = RAPL_IDX_PP0_NRG_STAT;
-		msr = MSR_PP0_ENERGY_STATUS;
-		break;
-	case INTEL_RAPL_PKG:
-		bit = RAPL_IDX_PKG_NRG_STAT;
-		msr = MSR_PKG_ENERGY_STATUS;
-		break;
-	case INTEL_RAPL_RAM:
-		bit = RAPL_IDX_RAM_NRG_STAT;
-		msr = MSR_DRAM_ENERGY_STATUS;
-		break;
-	case INTEL_RAPL_PP1:
-		bit = RAPL_IDX_PP1_NRG_STAT;
-		msr = MSR_PP1_ENERGY_STATUS;
-		break;
-	case INTEL_RAPL_PSYS:
-		bit = RAPL_IDX_PSYS_NRG_STAT;
-		msr = MSR_PLATFORM_ENERGY_STATUS;
-		break;
-	default:
+	if (!cfg || cfg >= NR_RAPL_DOMAINS)
 		return -EINVAL;
-	}
+
+	cfg = array_index_nospec(cfg, NR_RAPL_DOMAINS);
+	bit = cfg - 1;
+
 	/* check event supported */
 	if (!(rapl_cntr_mask & (1 << bit)))
 		return -EINVAL;
@@ -406,7 +394,7 @@ static int rapl_pmu_event_init(struct perf_event *event)
 		return -EINVAL;
 	event->cpu = pmu->cpu;
 	event->pmu_private = pmu;
-	event->hw.event_base = msr;
+	event->hw.event_base = event_msr[bit];
 	event->hw.config = cfg;
 	event->hw.idx = bit;
 
@@ -435,11 +423,27 @@ static struct attribute_group rapl_pmu_attr_group = {
 	.attrs = rapl_pmu_attrs,
 };
 
-RAPL_EVENT_ATTR_STR(energy-cores, rapl_cores, "event=0x01");
-RAPL_EVENT_ATTR_STR(energy-pkg  ,   rapl_pkg, "event=0x02");
-RAPL_EVENT_ATTR_STR(energy-ram  ,   rapl_ram, "event=0x03");
-RAPL_EVENT_ATTR_STR(energy-gpu  ,   rapl_gpu, "event=0x04");
-RAPL_EVENT_ATTR_STR(energy-psys,   rapl_psys, "event=0x05");
+static ssize_t
+rapl_event_sysfs_show(struct device *dev, struct device_attribute *attr,
+		      char *page)
+{
+	struct perf_pmu_events_attr *pmu_attr =
+		container_of(attr, struct perf_pmu_events_attr, attr);
+
+	return sprintf(page, "event=%llu\n", pmu_attr->id);
+}
+
+#define RAPL_EVENT_ATTR(_name, v, _id)					\
+static struct perf_pmu_events_attr event_attr_##v = {			\
+	.attr	= __ATTR(_name, 0444, rapl_event_sysfs_show, NULL),	\
+	.id	= RAPL_IDX_##_id##_NRG_STAT,				\
+};
+
+RAPL_EVENT_ATTR(energy-cores,  rapl_cores,  PP0);
+RAPL_EVENT_ATTR(energy-pkg  ,    rapl_pkg,  PKG);
+RAPL_EVENT_ATTR(energy-ram  ,    rapl_ram,  RAM);
+RAPL_EVENT_ATTR(energy-gpu  ,    rapl_gpu,  PP1);
+RAPL_EVENT_ATTR(energy-psys ,   rapl_psys, PSYS);
 
 RAPL_EVENT_ATTR_STR(energy-cores.unit, rapl_cores_unit, "Joules");
 RAPL_EVENT_ATTR_STR(energy-pkg.unit  ,   rapl_pkg_unit, "Joules");
@@ -780,6 +784,59 @@ static const struct x86_cpu_id rapl_cpu_match[] __initconst = {
 
 MODULE_DEVICE_TABLE(x86cpu, rapl_cpu_match);
 
+static void __init remove_name(struct attribute **attrs, const char *name)
+{
+	struct device_attribute *attr;
+	int i, j;
+
+	for (i = 0; attrs[i]; i++) {
+		attr = (struct device_attribute *) attrs[i];
+
+		if (strncmp(name, attr->attr.name, strlen(name)))
+			continue;
+
+		for (j = i; attrs[j]; j++)
+			attrs[j] = attrs[j + 1];
+
+		/* Check the shifted attr. */
+		i--;
+	}
+}
+
+static void __init check_events(struct attribute **attrs)
+{
+	struct perf_pmu_events_attr *pmu_attr;
+	struct device_attribute *attr;
+	int i, j;
+
+	for (i = 0; attrs[i]; i++) {
+		u64 val = 0;
+		u64 bit;
+
+		attr     = (struct device_attribute *) attrs[i];
+		pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
+
+		if (pmu_attr->event_str)
+			continue;
+
+		bit = pmu_attr->id;
+
+		if (WARN_ON_ONCE(bit >= NR_RAPL_DOMAINS))
+			continue;
+
+		if (!rdmsrl_safe(event_msr[bit], &val) && val)
+			continue;
+
+		remove_name(&attrs[i + 1], attr->attr.name);
+
+		for (j = i; attrs[j]; j++)
+			attrs[j] = attrs[j + 1];
+
+		/* Check the shifted attr. */
+		i--;
+	}
+}
+
 static int __init rapl_pmu_init(void)
 {
 	const struct x86_cpu_id *id;
@@ -796,6 +853,8 @@ static int __init rapl_pmu_init(void)
 	rapl_cntr_mask = rapl_init->cntr_mask;
 	rapl_pmu_events_group.attrs = rapl_init->attrs;
 
+	check_events(rapl_pmu_events_group.attrs);
+
 	ret = rapl_check_hw_unit(apply_quirk);
 	if (ret)
 		return ret;
