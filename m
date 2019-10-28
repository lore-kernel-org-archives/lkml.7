Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F3DCA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 11:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A78B20659
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 11:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388565AbfJ1LmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 07:42:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44335 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730170AbfJ1LmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 07:42:04 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iP3PA-0001G5-8s; Mon, 28 Oct 2019 12:41:48 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D870A1C047C;
        Mon, 28 Oct 2019 12:41:47 +0100 (CET)
Date:   Mon, 28 Oct 2019 11:41:47 -0000
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/uncore: Fix event group support
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>,
        linux-drivers-review@eclists.intel.com,
        linux-perf@eclists.intel.com, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <1572014593-31591-1-git-send-email-kan.liang@linux.intel.com>
References: <1572014593-31591-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <157226290760.29376.8601472796585890503.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     75be6f703a141b048590d659a3954c4fedd30bba
Gitweb:        https://git.kernel.org/tip/75be6f703a141b048590d659a3954c4fedd30bba
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 25 Oct 2019 07:43:13 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 28 Oct 2019 11:02:01 +01:00

perf/x86/uncore: Fix event group support

The events in the same group don't start or stop simultaneously.
Here is the ftrace when enabling event group for uncore_iio_0:

  # perf stat -e "{uncore_iio_0/event=0x1/,uncore_iio_0/event=0xe/}"

            <idle>-0     [000] d.h.  8959.064832: read_msr: a41, value
  b2b0b030		//Read counter reg of IIO unit0 counter0
            <idle>-0     [000] d.h.  8959.064835: write_msr: a48, value
  400001			//Write Ctrl reg of IIO unit0 counter0 to enable
  counter0. <------ Although counter0 is enabled, Unit Ctrl is still
  freezed. Nothing will count. We are still good here.
            <idle>-0     [000] d.h.  8959.064836: read_msr: a40, value
  30100                   //Read Unit Ctrl reg of IIO unit0
            <idle>-0     [000] d.h.  8959.064838: write_msr: a40, value
  30000			//Write Unit Ctrl reg of IIO unit0 to enable all
  counters in the unit by clear Freeze bit  <------Unit0 is un-freezed.
  Counter0 has been enabled. Now it starts counting. But counter1 has not
  been enabled yet. The issue starts here.
            <idle>-0     [000] d.h.  8959.064846: read_msr: a42, value 0
			//Read counter reg of IIO unit0 counter1
            <idle>-0     [000] d.h.  8959.064847: write_msr: a49, value
  40000e			//Write Ctrl reg of IIO unit0 counter1 to enable
  counter1.   <------ Now, counter1 just starts to count. Counter0 has
  been running for a while.

Current code un-freezes the Unit Ctrl right after the first counter is
enabled. The subsequent group events always loses some counter values.

Implement pmu_enable and pmu_disable support for uncore, which can help
to batch hardware accesses.

No one uses uncore_enable_box and uncore_disable_box. Remove them.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: linux-drivers-review@eclists.intel.com
Cc: linux-perf@eclists.intel.com
Fixes: 087bfbb03269 ("perf/x86: Add generic Intel uncore PMU support")
Link: https://lkml.kernel.org/r/1572014593-31591-1-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/uncore.c | 44 ++++++++++++++++++++++++++++-----
 arch/x86/events/intel/uncore.h | 12 +---------
 2 files changed, 38 insertions(+), 18 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 6fc2e06..86467f8 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -502,10 +502,8 @@ void uncore_pmu_event_start(struct perf_event *event, int flags)
 	local64_set(&event->hw.prev_count, uncore_read_counter(box, event));
 	uncore_enable_event(box, event);
 
-	if (box->n_active == 1) {
-		uncore_enable_box(box);
+	if (box->n_active == 1)
 		uncore_pmu_start_hrtimer(box);
-	}
 }
 
 void uncore_pmu_event_stop(struct perf_event *event, int flags)
@@ -529,10 +527,8 @@ void uncore_pmu_event_stop(struct perf_event *event, int flags)
 		WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
 		hwc->state |= PERF_HES_STOPPED;
 
-		if (box->n_active == 0) {
-			uncore_disable_box(box);
+		if (box->n_active == 0)
 			uncore_pmu_cancel_hrtimer(box);
-		}
 	}
 
 	if ((flags & PERF_EF_UPDATE) && !(hwc->state & PERF_HES_UPTODATE)) {
@@ -778,6 +774,40 @@ static int uncore_pmu_event_init(struct perf_event *event)
 	return ret;
 }
 
+static void uncore_pmu_enable(struct pmu *pmu)
+{
+	struct intel_uncore_pmu *uncore_pmu;
+	struct intel_uncore_box *box;
+
+	uncore_pmu = container_of(pmu, struct intel_uncore_pmu, pmu);
+	if (!uncore_pmu)
+		return;
+
+	box = uncore_pmu_to_box(uncore_pmu, smp_processor_id());
+	if (!box)
+		return;
+
+	if (uncore_pmu->type->ops->enable_box)
+		uncore_pmu->type->ops->enable_box(box);
+}
+
+static void uncore_pmu_disable(struct pmu *pmu)
+{
+	struct intel_uncore_pmu *uncore_pmu;
+	struct intel_uncore_box *box;
+
+	uncore_pmu = container_of(pmu, struct intel_uncore_pmu, pmu);
+	if (!uncore_pmu)
+		return;
+
+	box = uncore_pmu_to_box(uncore_pmu, smp_processor_id());
+	if (!box)
+		return;
+
+	if (uncore_pmu->type->ops->disable_box)
+		uncore_pmu->type->ops->disable_box(box);
+}
+
 static ssize_t uncore_get_attr_cpumask(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
@@ -803,6 +833,8 @@ static int uncore_pmu_register(struct intel_uncore_pmu *pmu)
 		pmu->pmu = (struct pmu) {
 			.attr_groups	= pmu->type->attr_groups,
 			.task_ctx_nr	= perf_invalid_context,
+			.pmu_enable	= uncore_pmu_enable,
+			.pmu_disable	= uncore_pmu_disable,
 			.event_init	= uncore_pmu_event_init,
 			.add		= uncore_pmu_event_add,
 			.del		= uncore_pmu_event_del,
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index f36f7be..bbfdaa7 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -441,18 +441,6 @@ static inline int uncore_freerunning_hw_config(struct intel_uncore_box *box,
 	return -EINVAL;
 }
 
-static inline void uncore_disable_box(struct intel_uncore_box *box)
-{
-	if (box->pmu->type->ops->disable_box)
-		box->pmu->type->ops->disable_box(box);
-}
-
-static inline void uncore_enable_box(struct intel_uncore_box *box)
-{
-	if (box->pmu->type->ops->enable_box)
-		box->pmu->type->ops->enable_box(box);
-}
-
 static inline void uncore_disable_event(struct intel_uncore_box *box,
 				struct perf_event *event)
 {
