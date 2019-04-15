Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B414C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 736712073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbfDOSn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:43:58 -0400
Received: from mga05.intel.com ([192.55.52.43]:30899 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728204AbfDOSna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:43:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Apr 2019 11:43:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,354,1549958400"; 
   d="scan'208";a="136032393"
Received: from otc-lr-04.jf.intel.com ([10.54.39.141])
  by orsmga006.jf.intel.com with ESMTP; 15 Apr 2019 11:43:29 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 4/5] perf/x86/intel/uncore: Clean up client IMC
Date:   Mon, 15 Apr 2019 11:41:55 -0700
Message-Id: <1555353716-35041-4-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555353716-35041-1-git-send-email-kan.liang@linux.intel.com>
References: <1555353716-35041-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The client IMC block is accessed by MMIO. Current code uses an informal
way to access the block, which is not recommended.

Cleaning up the code by using __iomem annotation and the accessor
functions (read[lq]()).
Move exit_box() and read_counter() to generic code, which can be shared
with server later.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.c     | 15 +++++++++++++++
 arch/x86/events/intel/uncore.h     |  6 +++++-
 arch/x86/events/intel/uncore_snb.c | 16 ++--------------
 3 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 3c00635..39b0f96 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -119,6 +119,21 @@ u64 uncore_msr_read_counter(struct intel_uncore_box *box, struct perf_event *eve
 	return count;
 }
 
+void uncore_mmio_exit_box(struct intel_uncore_box *box)
+{
+	if (box->io_addr)
+		iounmap(box->io_addr);
+}
+
+u64 uncore_mmio_read_counter(struct intel_uncore_box *box,
+			     struct perf_event *event)
+{
+	if (!box->io_addr)
+		return 0;
+
+	return readq(box->io_addr + event->hw.event_base);
+}
+
 /*
  * generic get constraint function for shared match/mask registers.
  */
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 426a490..738bed3 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -2,6 +2,7 @@
 #include <linux/slab.h>
 #include <linux/pci.h>
 #include <asm/apicdef.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 
 #include <linux/perf_event.h>
 #include "../perf_event.h"
@@ -128,7 +129,7 @@ struct intel_uncore_box {
 	struct hrtimer hrtimer;
 	struct list_head list;
 	struct list_head active_list;
-	void *io_addr;
+	void __iomem *io_addr;
 	struct intel_uncore_extra_reg shared_regs[0];
 };
 
@@ -502,6 +503,9 @@ static inline struct intel_uncore_box *uncore_event_to_box(struct perf_event *ev
 
 struct intel_uncore_box *uncore_pmu_to_box(struct intel_uncore_pmu *pmu, int cpu);
 u64 uncore_msr_read_counter(struct intel_uncore_box *box, struct perf_event *event);
+void uncore_mmio_exit_box(struct intel_uncore_box *box);
+u64 uncore_mmio_read_counter(struct intel_uncore_box *box,
+			     struct perf_event *event);
 void uncore_pmu_start_hrtimer(struct intel_uncore_box *box);
 void uncore_pmu_cancel_hrtimer(struct intel_uncore_box *box);
 void uncore_pmu_event_start(struct perf_event *event, int flags);
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index f843181..5d0ce4347 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -420,11 +420,6 @@ static void snb_uncore_imc_init_box(struct intel_uncore_box *box)
 	box->hrtimer_duration = UNCORE_SNB_IMC_HRTIMER_INTERVAL;
 }
 
-static void snb_uncore_imc_exit_box(struct intel_uncore_box *box)
-{
-	iounmap(box->io_addr);
-}
-
 static void snb_uncore_imc_enable_box(struct intel_uncore_box *box)
 {}
 
@@ -437,13 +432,6 @@ static void snb_uncore_imc_enable_event(struct intel_uncore_box *box, struct per
 static void snb_uncore_imc_disable_event(struct intel_uncore_box *box, struct perf_event *event)
 {}
 
-static u64 snb_uncore_imc_read_counter(struct intel_uncore_box *box, struct perf_event *event)
-{
-	struct hw_perf_event *hwc = &event->hw;
-
-	return (u64)*(unsigned int *)(box->io_addr + hwc->event_base);
-}
-
 /*
  * Keep the custom event_init() function compatible with old event
  * encoding for free running counters.
@@ -570,13 +558,13 @@ static struct pmu snb_uncore_imc_pmu = {
 
 static struct intel_uncore_ops snb_uncore_imc_ops = {
 	.init_box	= snb_uncore_imc_init_box,
-	.exit_box	= snb_uncore_imc_exit_box,
+	.exit_box	= uncore_mmio_exit_box,
 	.enable_box	= snb_uncore_imc_enable_box,
 	.disable_box	= snb_uncore_imc_disable_box,
 	.disable_event	= snb_uncore_imc_disable_event,
 	.enable_event	= snb_uncore_imc_enable_event,
 	.hw_config	= snb_uncore_imc_hw_config,
-	.read_counter	= snb_uncore_imc_read_counter,
+	.read_counter	= uncore_mmio_read_counter,
 };
 
 static struct intel_uncore_type snb_uncore_imc = {
-- 
2.7.4

