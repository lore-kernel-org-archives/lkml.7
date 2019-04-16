Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBD3C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E59312077C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbfDPLh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:37:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45913 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfDPLh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:37:56 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3GBbfNN3428723
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 16 Apr 2019 04:37:41 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3GBbfCV3428720;
        Tue, 16 Apr 2019 04:37:41 -0700
Date:   Tue, 16 Apr 2019 04:37:41 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-63b79f6ebc464afb730bc45762c820795e276da1@git.kernel.org>
Cc:     acme@redhat.com, peterz@infradead.org, eranian@google.com,
        hpa@zytor.com, mingo@kernel.org, jolsa@redhat.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kan.liang@linux.intel.com, alexander.shishkin@linux.intel.com,
        tglx@linutronix.de, ak@linux.intel.com, vincent.weaver@maine.edu
Reply-To: jolsa@redhat.com, torvalds@linux-foundation.org, acme@redhat.com,
          peterz@infradead.org, eranian@google.com, mingo@kernel.org,
          hpa@zytor.com, kan.liang@linux.intel.com, tglx@linutronix.de,
          alexander.shishkin@linux.intel.com, ak@linux.intel.com,
          vincent.weaver@maine.edu, linux-kernel@vger.kernel.org
In-Reply-To: <20190402194509.2832-8-kan.liang@linux.intel.com>
References: <20190402194509.2832-8-kan.liang@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86: Support constraint ranges
Git-Commit-ID: 63b79f6ebc464afb730bc45762c820795e276da1
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

Commit-ID:  63b79f6ebc464afb730bc45762c820795e276da1
Gitweb:     https://git.kernel.org/tip/63b79f6ebc464afb730bc45762c820795e276da1
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Tue, 2 Apr 2019 12:45:04 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 16 Apr 2019 12:26:17 +0200

perf/x86: Support constraint ranges

Icelake extended the general counters to 8, even when SMT is enabled.
However only a (large) subset of the events can be used on all 8
counters.

The events that can or cannot be used on all counters are organized
in ranges.

A lot of scheduler constraints are required to handle all this.

To avoid blowing up the tables add event code ranges to the constraint
tables, and a new inline function to match them.

Originally-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org> # developer hat on
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org> # maintainer hat on
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: acme@kernel.org
Cc: jolsa@kernel.org
Link: https://lkml.kernel.org/r/20190402194509.2832-8-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/core.c |  2 +-
 arch/x86/events/intel/ds.c   |  2 +-
 arch/x86/events/perf_event.h | 43 +++++++++++++++++++++++++++++++++++++------
 3 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index bdc366d709aa..d4b52896f173 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2693,7 +2693,7 @@ x86_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 
 	if (x86_pmu.event_constraints) {
 		for_each_event_constraint(c, x86_pmu.event_constraints) {
-			if ((event->hw.config & c->cmask) == c->code) {
+			if (constraint_match(c, event->hw.config)) {
 				event->hw.flags |= c->flags;
 				return c;
 			}
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 6436452d6342..4429bfa92fbc 100644
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
index dced91582147..0ff0c5ae8c29 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -49,13 +49,19 @@ struct event_constraint {
 		unsigned long	idxmsk[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
 		u64		idxmsk64;
 	};
-	u64	code;
-	u64	cmask;
-	int	weight;
-	int	overlap;
-	int	flags;
+	u64		code;
+	u64		cmask;
+	int		weight;
+	int		overlap;
+	int		flags;
+	unsigned int	size;
 };
 
+static inline bool constraint_match(struct event_constraint *c, u64 ecode)
+{
+	return ((ecode & c->cmask) - c->code) <= (u64)c->size;
+}
+
 /*
  * struct hw_perf_event.flags flags
  */
@@ -280,18 +286,29 @@ struct cpu_hw_events {
 	void				*kfree_on_online[X86_PERF_KFREE_MAX];
 };
 
-#define __EVENT_CONSTRAINT(c, n, m, w, o, f) {\
+#define __EVENT_CONSTRAINT_RANGE(c, e, n, m, w, o, f) {	\
 	{ .idxmsk64 = (n) },		\
 	.code = (c),			\
+	.size = (e) - (c),		\
 	.cmask = (m),			\
 	.weight = (w),			\
 	.overlap = (o),			\
 	.flags = f,			\
 }
 
+#define __EVENT_CONSTRAINT(c, n, m, w, o, f) \
+	__EVENT_CONSTRAINT_RANGE(c, c, n, m, w, o, f)
+
 #define EVENT_CONSTRAINT(c, n, m)	\
 	__EVENT_CONSTRAINT(c, n, m, HWEIGHT(n), 0, 0)
 
+/*
+ * The constraint_match() function only works for 'simple' event codes
+ * and not for extended (AMD64_EVENTSEL_EVENT) events codes.
+ */
+#define EVENT_CONSTRAINT_RANGE(c, e, n, m) \
+	__EVENT_CONSTRAINT_RANGE(c, e, n, m, HWEIGHT(n), 0, 0)
+
 #define INTEL_EXCLEVT_CONSTRAINT(c, n)	\
 	__EVENT_CONSTRAINT(c, n, ARCH_PERFMON_EVENTSEL_EVENT, HWEIGHT(n),\
 			   0, PERF_X86_EVENT_EXCL)
@@ -326,6 +343,12 @@ struct cpu_hw_events {
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
@@ -373,6 +396,9 @@ struct cpu_hw_events {
 #define INTEL_FLAGS_EVENT_CONSTRAINT(c, n) \
 	EVENT_CONSTRAINT(c, n, INTEL_ARCH_EVENT_MASK|X86_ALL_EVENT_FLAGS)
 
+#define INTEL_FLAGS_EVENT_CONSTRAINT_RANGE(c, e, n)			\
+	EVENT_CONSTRAINT_RANGE(c, e, n, INTEL_ARCH_EVENT_MASK|X86_ALL_EVENT_FLAGS)
+
 /* Check only flags, but allow all event/umask */
 #define INTEL_ALL_EVENT_CONSTRAINT(code, n)	\
 	EVENT_CONSTRAINT(code, n, X86_ALL_EVENT_FLAGS)
@@ -389,6 +415,11 @@ struct cpu_hw_events {
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
