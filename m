Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFBDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82FB32070D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732401AbfCZQMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 12:12:43 -0400
Received: from mga02.intel.com ([134.134.136.20]:55266 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732177AbfCZQLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 12:11:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 09:11:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,273,1549958400"; 
   d="scan'208";a="217714758"
Received: from otc-icl-cdi187.jf.intel.com ([10.54.55.103])
  by orsmga001.jf.intel.com with ESMTP; 26 Mar 2019 09:11:33 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 12/23] perf/core: Support a REMOVE transaction
Date:   Tue, 26 Mar 2019 09:08:50 -0700
Message-Id: <20190326160901.4887-13-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190326160901.4887-1-kan.liang@linux.intel.com>
References: <20190326160901.4887-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

The TopDown events can be collected per thread/process on Icelake. To
use TopDown through RDPMC in applications, the metrics and slots MSR
values have to be saved/restored during context switching.
It is useful to have a remove transaction when the counter is
unscheduled, so that the values can be saved correctly.
Add a remove transaction to the perf core.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

No changes since V3.

 arch/x86/events/core.c     | 3 +--
 include/linux/perf_event.h | 1 +
 kernel/events/core.c       | 5 +++++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 9378c6b2128f..9c14b4b3e457 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1912,8 +1912,7 @@ static inline void x86_pmu_read(struct perf_event *event)
  * Set the flag to make pmu::enable() not perform the
  * schedulability test, it will be performed at commit time
  *
- * We only support PERF_PMU_TXN_ADD transactions. Save the
- * transaction flags but otherwise ignore non-PERF_PMU_TXN_ADD
+ * Save the transaction flags and ignore non-PERF_PMU_TXN_ADD
  * transactions.
  */
 static void x86_pmu_start_txn(struct pmu *pmu, unsigned int txn_flags)
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index e47ef764f613..fb258c171b2c 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -233,6 +233,7 @@ struct perf_event;
  */
 #define PERF_PMU_TXN_ADD  0x1		/* txn to add/schedule event on PMU */
 #define PERF_PMU_TXN_READ 0x2		/* txn to read event group from PMU */
+#define PERF_PMU_TXN_REMOVE 0x4		/* txn to remove event on PMU */
 
 /**
  * pmu::capabilities flags
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1032a16bd186..dea8cfe2a891 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2032,6 +2032,7 @@ group_sched_out(struct perf_event *group_event,
 		struct perf_cpu_context *cpuctx,
 		struct perf_event_context *ctx)
 {
+	struct pmu *pmu = ctx->pmu;
 	struct perf_event *event;
 
 	if (group_event->state != PERF_EVENT_STATE_ACTIVE)
@@ -2039,6 +2040,8 @@ group_sched_out(struct perf_event *group_event,
 
 	perf_pmu_disable(ctx->pmu);
 
+	pmu->start_txn(pmu, PERF_PMU_TXN_REMOVE);
+
 	event_sched_out(group_event, cpuctx, ctx);
 
 	/*
@@ -2051,6 +2054,8 @@ group_sched_out(struct perf_event *group_event,
 
 	if (group_event->attr.exclusive)
 		cpuctx->exclusive = 0;
+
+	pmu->commit_txn(pmu);
 }
 
 #define DETACH_GROUP	0x01UL
-- 
2.17.1

