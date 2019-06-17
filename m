Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B933C31E58
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F15142084B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfFQNlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 09:41:42 -0400
Received: from mga17.intel.com ([192.55.52.151]:5916 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbfFQNlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 09:41:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jun 2019 06:41:42 -0700
X-ExtLoop1: 1
Received: from unknown (HELO [10.255.29.180]) ([10.255.29.180])
  by fmsmga004.fm.intel.com with ESMTP; 17 Jun 2019 06:41:39 -0700
Message-ID: <1560778897.10723.6.camel@intel.com>
Subject: [PATCH] perf/rapl: restart perf rapl counter after resume
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, tglx@linutronix.de,
        "Liang, Kan" <kan.liang@intel.com>
Date:   Mon, 17 Jun 2019 21:41:37 +0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From b74a74f953f4c34818a58831b6eb468b42b17c62 Mon Sep 17 00:00:00 2001
From: Zhang Rui <rui.zhang@intel.com>
Date: Tue, 23 Apr 2019 16:26:50 +0800
Subject: [PATCH] perf/rapl: restart perf rapl counter after resume

After S3 suspend/resume, "perf stat -I 1000 -e power/energy-pkg/ -a"
reports an insane value for the very first sampling period after resume
as shown below.

    19.278989977               2.16 Joules power/energy-pkg/
    20.279373569               1.96 Joules power/energy-pkg/
    21.279765481               2.09 Joules power/energy-pkg/
    22.280305420               2.10 Joules power/energy-pkg/
    25.504782277   4,294,966,686.01 Joules power/energy-pkg/
    26.505114993               3.58 Joules power/energy-pkg/
    27.505471758               1.66 Joules power/energy-pkg/

Fix this by resetting the counter right after resume.

Kan, Liang proposed the prototype patch and I reworked it to use syscore
ops.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/rapl.c | 84 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 76 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/intel/rapl.c b/arch/x86/events/intel/rapl.c
index 26c03f5..6cff8fd 100644
--- a/arch/x86/events/intel/rapl.c
+++ b/arch/x86/events/intel/rapl.c
@@ -55,6 +55,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/perf_event.h>
+#include <linux/syscore_ops.h>
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #include "../perf_event.h"
@@ -228,6 +229,32 @@ static u64 rapl_event_update(struct perf_event *event)
 	return new_raw_count;
 }
 
+static void rapl_pmu_update_all(struct rapl_pmu *pmu)
+{
+	struct perf_event *event;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&pmu->lock, flags);
+
+	list_for_each_entry(event, &pmu->active_list, active_entry)
+		rapl_event_update(event);
+
+	raw_spin_unlock_irqrestore(&pmu->lock, flags);
+}
+
+static void rapl_pmu_restart_all(struct rapl_pmu *pmu)
+{
+	struct perf_event *event;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&pmu->lock, flags);
+
+	list_for_each_entry(event, &pmu->active_list, active_entry)
+		local64_set(&event->hw.prev_count, rapl_read_counter(event));
+
+	raw_spin_unlock_irqrestore(&pmu->lock, flags);
+}
+
 static void rapl_start_hrtimer(struct rapl_pmu *pmu)
 {
        hrtimer_start(&pmu->hrtimer, pmu->timer_interval,
@@ -237,18 +264,11 @@ static void rapl_start_hrtimer(struct rapl_pmu *pmu)
 static enum hrtimer_restart rapl_hrtimer_handle(struct hrtimer *hrtimer)
 {
 	struct rapl_pmu *pmu = container_of(hrtimer, struct rapl_pmu, hrtimer);
-	struct perf_event *event;
-	unsigned long flags;
 
 	if (!pmu->n_active)
 		return HRTIMER_NORESTART;
 
-	raw_spin_lock_irqsave(&pmu->lock, flags);
-
-	list_for_each_entry(event, &pmu->active_list, active_entry)
-		rapl_event_update(event);
-
-	raw_spin_unlock_irqrestore(&pmu->lock, flags);
+	rapl_pmu_update_all(pmu);
 
 	hrtimer_forward_now(hrtimer, pmu->timer_interval);
 
@@ -698,6 +718,52 @@ static int __init init_rapl_pmus(void)
 	return 0;
 }
 
+
+#ifdef CONFIG_PM
+
+static int perf_rapl_suspend(void)
+{
+	int i;
+
+	get_online_cpus();
+	for (i = 0; i < rapl_pmus->maxpkg; i++)
+		rapl_pmu_update_all(rapl_pmus->pmus[i]);
+	put_online_cpus();
+	return 0;
+}
+
+static void perf_rapl_resume(void)
+{
+	int i;
+
+	get_online_cpus();
+	for (i = 0; i < rapl_pmus->maxpkg; i++)
+		rapl_pmu_restart_all(rapl_pmus->pmus[i]);
+	put_online_cpus();
+}
+
+static struct syscore_ops perf_rapl_syscore_ops = {
+	.resume = perf_rapl_resume,
+	.suspend = perf_rapl_suspend,
+};
+
+static void perf_rapl_pm_register(void)
+{
+	register_syscore_ops(&perf_rapl_syscore_ops);
+}
+
+static void perf_rapl_pm_unregister(void)
+{
+	unregister_syscore_ops(&perf_rapl_syscore_ops);
+}
+
+#else
+
+static inline void perf_rapl_pm_register(void) { }
+static inline void perf_rapl_pm_unregister(void) { }
+
+#endif
+
 #define X86_RAPL_MODEL_MATCH(model, init)	\
 	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, (unsigned long)&init }
 
@@ -798,6 +864,7 @@ static int __init rapl_pmu_init(void)
 	apply_quirk = rapl_init->apply_quirk;
 	rapl_cntr_mask = rapl_init->cntr_mask;
 	rapl_pmu_events_group.attrs = rapl_init->attrs;
+	perf_rapl_pm_register();
 
 	ret = rapl_check_hw_unit(apply_quirk);
 	if (ret)
@@ -836,6 +903,7 @@ static void __exit intel_rapl_exit(void)
 {
 	cpuhp_remove_state_nocalls(CPUHP_AP_PERF_X86_RAPL_ONLINE);
 	perf_pmu_unregister(&rapl_pmus->pmu);
+	perf_rapl_pm_unregister();
 	cleanup_rapl_pmus();
 }
 module_exit(intel_rapl_exit);
-- 
2.7.4

