Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6460AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 21:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A6742175B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 21:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbfCRVoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 17:44:19 -0400
Received: from mga04.intel.com ([192.55.52.120]:57595 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727516AbfCRVoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 17:44:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 14:44:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,495,1544515200"; 
   d="scan'208";a="308301786"
Received: from otc-icl-cdi187.jf.intel.com ([10.54.55.103])
  by orsmga005.jf.intel.com with ESMTP; 18 Mar 2019 14:44:16 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 05/22] perf/x86: Support constraint ranges
Date:   Mon, 18 Mar 2019 14:41:27 -0700
Message-Id: <20190318214144.4639-6-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190318214144.4639-1-kan.liang@linux.intel.com>
References: <20190318214144.4639-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Icelake extended the general counters to 8, even when SMT is enabled.
However only a (large) subset of the events can be used on all 8
counters.

The events that can or cannot be used on all counters are organized
in ranges.

We need a lot of scheduler constraints to handle all this.

To avoid blowing up the tables add event code ranges to the constraint
tables, and a new inline function to match them.

The changes costs ~2k text size according to 0day report.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c |  2 +-
 arch/x86/events/intel/ds.c   |  2 +-
 arch/x86/events/perf_event.h | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index a964b9832b0c..8486ab87f8f8 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2655,7 +2655,7 @@ x86_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 
 	if (x86_pmu.event_constraints) {
 		for_each_event_constraint(c, x86_pmu.event_constraints) {
-			if ((event->hw.config & c->cmask) == c->code) {
+			if (constraint_match(c, event->hw.config)) {
 				event->hw.flags |= c->flags;
 				return c;
 			}
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 974284c5ed6c..30370fb93e21 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -858,7 +858,7 @@ struct event_constraint *intel_pebs_constraints(struct perf_event *event)
 
 	if (x86_pmu.pebs_constraints) {
 		for_each_event_constraint(c, x86_pmu.pebs_constraints) {
-			if ((event->hw.config & c->cmask) == c->code) {
+			if (constraint_match(c, event->hw.config)) {
 				event->hw.flags |= c->flags;
 				return c;
 			}
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 27c7945b5174..863d27f4c352 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -54,6 +54,7 @@ struct event_constraint {
 	int	weight;
 	int	overlap;
 	int	flags;
+	u64	range_end;
 };
 /*
  * struct hw_perf_event.flags flags
@@ -71,6 +72,12 @@ struct event_constraint {
 #define PERF_X86_EVENT_AUTO_RELOAD	0x0400 /* use PEBS auto-reload */
 #define PERF_X86_EVENT_LARGE_PEBS	0x0800 /* use large PEBS */
 
+static inline bool constraint_match(struct event_constraint *c, u64 ecode)
+{
+	ecode &= c->cmask;
+	return ecode == c->code ||
+		(c->range_end && ecode >= c->code && ecode <= c->range_end);
+}
 
 struct amd_nb {
 	int nb_id;  /* NorthBridge id */
@@ -267,9 +274,22 @@ struct cpu_hw_events {
 	.flags = f,			\
 }
 
+#define __EVENT_CONSTRAINT_RANGE(c, e, n, m, w, o, f) {	\
+	{ .idxmsk64 = (n) },		\
+	.code = (c),			\
+	.range_end = (e),		\
+	.cmask = (m),			\
+	.weight = (w),			\
+	.overlap = (o),			\
+	.flags = f,			\
+}
+
 #define EVENT_CONSTRAINT(c, n, m)	\
 	__EVENT_CONSTRAINT(c, n, m, HWEIGHT(n), 0, 0)
 
+#define EVENT_CONSTRAINT_RANGE(c, e, n, m) \
+	__EVENT_CONSTRAINT_RANGE(c, e, n, m, HWEIGHT(n), 0, 0)
+
 #define INTEL_EXCLEVT_CONSTRAINT(c, n)	\
 	__EVENT_CONSTRAINT(c, n, ARCH_PERFMON_EVENTSEL_EVENT, HWEIGHT(n),\
 			   0, PERF_X86_EVENT_EXCL)
@@ -304,6 +324,12 @@ struct cpu_hw_events {
 #define INTEL_EVENT_CONSTRAINT(c, n)	\
 	EVENT_CONSTRAINT(c, n, ARCH_PERFMON_EVENTSEL_EVENT)
 
+/*
+ * Constraint on a range of Event codes
+ */
+#define INTEL_EVENT_CONSTRAINT_RANGE(c, e, n)			\
+	EVENT_CONSTRAINT_RANGE(c, e, n, ARCH_PERFMON_EVENTSEL_EVENT)
+
 /*
  * Constraint on the Event code + UMask + fixed-mask
  *
@@ -351,6 +377,9 @@ struct cpu_hw_events {
 #define INTEL_FLAGS_EVENT_CONSTRAINT(c, n) \
 	EVENT_CONSTRAINT(c, n, INTEL_ARCH_EVENT_MASK|X86_ALL_EVENT_FLAGS)
 
+#define INTEL_FLAGS_EVENT_CONSTRAINT_RANGE(c, e, n)			\
+	EVENT_CONSTRAINT_RANGE(c, e, n, INTEL_ARCH_EVENT_MASK|X86_ALL_EVENT_FLAGS)
+
 /* Check only flags, but allow all event/umask */
 #define INTEL_ALL_EVENT_CONSTRAINT(code, n)	\
 	EVENT_CONSTRAINT(code, n, X86_ALL_EVENT_FLAGS)
@@ -367,6 +396,11 @@ struct cpu_hw_events {
 			  ARCH_PERFMON_EVENTSEL_EVENT|X86_ALL_EVENT_FLAGS, \
 			  HWEIGHT(n), 0, PERF_X86_EVENT_PEBS_LD_HSW)
 
+#define INTEL_FLAGS_EVENT_CONSTRAINT_DATALA_LD_RANGE(code, end, n) \
+	__EVENT_CONSTRAINT_RANGE(code, end, n,				\
+			  ARCH_PERFMON_EVENTSEL_EVENT|X86_ALL_EVENT_FLAGS, \
+			  HWEIGHT(n), 0, PERF_X86_EVENT_PEBS_LD_HSW)
+
 #define INTEL_FLAGS_EVENT_CONSTRAINT_DATALA_XLD(code, n) \
 	__EVENT_CONSTRAINT(code, n,			\
 			  ARCH_PERFMON_EVENTSEL_EVENT|X86_ALL_EVENT_FLAGS, \
-- 
2.17.1

