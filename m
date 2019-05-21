Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C29C072B5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 21:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75126217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 21:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbfEUVll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 17:41:41 -0400
Received: from mga11.intel.com ([192.55.52.93]:32413 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727466AbfEUVlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 17:41:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 May 2019 14:41:40 -0700
X-ExtLoop1: 1
Received: from otc-icl-cdi-210.jf.intel.com ([10.54.55.28])
  by orsmga006.jf.intel.com with ESMTP; 21 May 2019 14:41:39 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 1/9] perf/core: Support a REMOVE transaction
Date:   Tue, 21 May 2019 14:40:47 -0700
Message-Id: <20190521214055.31060-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190521214055.31060-1-kan.liang@linux.intel.com>
References: <20190521214055.31060-1-kan.liang@linux.intel.com>
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
 arch/x86/events/core.c     | 3 +--
 include/linux/perf_event.h | 1 +
 kernel/events/core.c       | 5 +++++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index f0e4804515d8..e075de494dfd 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1856,8 +1856,7 @@ static inline void x86_pmu_read(struct perf_event *event)
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
index 5beb5cde3d56..973b7f8ce8e9 100644
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
index 118ad1aef6af..f204166f6bc8 100644
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
2.14.5

