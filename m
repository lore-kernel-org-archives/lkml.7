Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2C2C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9812920840
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbfGXR12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 13:27:28 -0400
Received: from mga01.intel.com ([192.55.52.88]:32494 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387530AbfGXR1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 13:27:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2019 10:18:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,303,1559545200"; 
   d="scan'208";a="368859116"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.84])
  by fmsmga005.fm.intel.com with ESMTP; 24 Jul 2019 10:18:34 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 8/8] perf, tools: Add documentation for topdown metrics
Date:   Wed, 24 Jul 2019 10:17:53 -0700
Message-Id: <20190724171753.8087-9-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190724171753.8087-1-kan.liang@linux.intel.com>
References: <20190724171753.8087-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Add some documentation how to use the topdown metrics in ring 3.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/Documentation/topdown.txt | 223 +++++++++++++++++++++++++++
 1 file changed, 223 insertions(+)
 create mode 100644 tools/perf/Documentation/topdown.txt

diff --git a/tools/perf/Documentation/topdown.txt b/tools/perf/Documentation/topdown.txt
new file mode 100644
index 000000000000..e82a74fa9243
--- /dev/null
+++ b/tools/perf/Documentation/topdown.txt
@@ -0,0 +1,223 @@
+Using TopDown metrics in user space
+-----------------------------------
+
+Intel CPUs (since Sandy Bridge and Silvermont) support a TopDown
+methology to break down CPU pipeline execution into 4 bottlenecks:
+frontend bound, backend bound, bad speculation, retiring.
+
+For more details on Topdown see [1][5]
+
+Traditionally this was implemented by events in generic counters
+and specific formulas to compute the bottlenecks.
+
+perf stat --topdown implements this.
+
+% perf stat -a --topdown -I1000
+#           time             counts unit events
+     1.000373951      8,460,978,609      topdown-retiring          #     22.9% retiring
+     1.000373951      3,445,383,303      topdown-bad-spec          #      9.3% bad speculation
+     1.000373951     15,886,483,355      topdown-fe-bound          #     43.0% frontend bound
+     1.000373951      9,163,488,720      topdown-be-bound          #     24.8% backend bound
+     2.000782154      8,477,925,431      topdown-retiring          #     22.9% retiring
+     2.000782154      3,459,151,256      topdown-bad-spec          #      9.3% bad speculation
+     2.000782154     15,947,224,725      topdown-fe-bound          #     43.0% frontend bound
+     2.000782154      9,145,551,695      topdown-be-bound          #     24.7% backend bound
+     3.001155967      8,487,323,125      topdown-retiring          #     22.9% retiring
+     3.001155967      3,451,808,066      topdown-bad-spec          #      9.3% bad speculation
+     3.001155967     15,959,068,902      topdown-fe-bound          #     43.0% frontend bound
+     3.001155967      9,172,479,784      topdown-be-bound          #     24.7% backend bound
+...
+
+Full Top Down includes more levels that can break down the
+bottlenecks further. This is not directly implemented in perf,
+but available in other tools that can run on top of perf,
+such as toplev[2] or vtune[3]
+
+New Topdown features in Icelake
+===============================
+
+With Icelake CPUs the TopDown metrics are directly available as
+fixed counters and do not require generic counters. This allows
+to collect TopDown always in addition to other events.
+
+This also enables measuring TopDown per thread/process instead
+of only per core.
+
+Using TopDown through RDPMC in applications on Icelake
+======================================================
+
+For more fine grained measurements it can be useful to
+access the new  directly from user space. This is more complicated,
+but drastically lowers overhead.
+
+On Icelake, there is a new fixed counter 3: SLOTS, which reports
+"pipeline SLOTS" (cycles multiplied by core issue width) and a
+metric register that reports slots ratios for the different bottleneck
+categories.
+
+The metrics counter is CPU model specific and is not be available
+on older CPUs.
+
+Example code
+============
+
+Library functions to do the functionality described below
+is also available in libjevents [4]
+
+The application opens a perf_event file descriptor
+and sets up fixed counter 3 (SLOTS) to start and
+allow user programs to read the performance counters.
+
+Fixed counter 3 is mapped to a pseudo event event=0x00, umask=04,
+so the perf_event_attr structure should be initialized with
+{ .config = 0x0400, .type = PERF_TYPE_RAW }
+
+#include <linux/perf_event.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+
+/* Provide own perf_event_open stub because glibc doesn't */
+__attribute__((weak))
+int perf_event_open(struct perf_event_attr *attr, pid_t pid,
+		    int cpu, int group_fd, unsigned long flags)
+{
+	return syscall(__NR_perf_event_open, attr, pid, cpu, group_fd, flags);
+}
+
+/* open slots counter file descriptor for current task */
+struct perf_event_attr slots = {
+	.type = PERF_TYPE_RAW,
+	.size = sizeof(struct perf_event_attr),
+	.config = 0x400,
+	.exclude_kernel = 1,
+};
+
+int fd = perf_event_open(&slots, 0, -1, -1, 0);
+if (fd < 0)
+	... error ...
+
+The RDPMC instruction (or _rdpmc compiler intrinsic) can now be used
+to read slots and the topdown metrics at different points of the program:
+
+#include <stdint.h>
+#include <x86intrin.h>
+
+#define RDPMC_FIXED	(1 << 30)	/* return fixed counters */
+#define RDPMC_METRIC	(1 << 29)	/* return metric counters */
+
+#define FIXED_COUNTER_SLOTS		3
+#define METRIC_COUNTER_TOPDOWN_L1	0
+
+static inline uint64_t read_slots(void)
+{
+	return _rdpmc(RDPMC_FIXED | FIXED_COUNTER_SLOTS);
+}
+
+static inline uint64_t read_metrics(void)
+{
+	return _rdpmc(RDPMC_METRIC | METRIC_COUNTER_TOPDOWN_L1);
+}
+
+Then the program can be instrumented to read these metrics at different
+points.
+
+It's not a good idea to do this with too short code regions,
+as the parallelism and overlap in the CPU program execution will
+cause too much measurement inaccuracy. For example instrumenting
+individual basic blocks is definitely too fine grained.
+
+Decoding metrics values
+=======================
+
+The value reported by read_metrics() contains four 8 bit fields
+that represent a scaled ratio that represent the Level 1 bottleneck.
+All four fields add up to 0xff (= 100%)
+
+The binary ratios in the metric value can be converted to float ratios:
+
+#define GET_METRIC(m, i) (((m) >> (i*8)) & 0xff)
+
+#define TOPDOWN_RETIRING(val)	((float)GET_METRIC(val, 0) / 0xff)
+#define TOPDOWN_BAD_SPEC(val)	((float)GET_METRIC(val, 1) / 0xff)
+#define TOPDOWN_FE_BOUND(val)	((float)GET_METRIC(val, 2) / 0xff)
+#define TOPDOWN_BE_BOUND(val)	((float)GET_METRIC(val, 3) / 0xff)
+
+and then converted to percent for printing.
+
+The ratios in the metric accumulate for the time when the counter
+is enabled. For measuring programs it is often useful to measure
+specific sections. For this it is needed to deltas on metrics.
+
+This can be done by scaling the metrics with the slots counter
+read at the same time.
+
+Then it's possible to take deltas of these slots counts
+measured at different points, and determine the metrics
+for that time period.
+
+	slots_a = read_slots();
+	metric_a = read_metrics();
+
+	... larger code region ...
+
+	slots_b = read_slots()
+	metric_b = read_metrics()
+
+	# compute scaled metrics for measurement a
+	retiring_slots_a = GET_METRIC(metric_a, 0) * slots_a
+	bad_spec_slots_a = GET_METRIC(metric_a, 1) * slots_a
+	fe_bound_slots_a = GET_METRIC(metric_a, 2) * slots_a
+	be_bound_slots_a = GET_METRIC(metric_a, 3) * slots_a
+
+	# compute delta scaled metrics between b and a
+	retiring_slots = GET_METRIC(metric_b, 0) * slots_b - retiring_slots_a
+	bad_spec_slots = GET_METRIC(metric_b, 1) * slots_b - bad_spec_slots_a
+	fe_bound_slots = GET_METRIC(metric_b, 2) * slots_b - fe_bound_slots_a
+	be_bound_slots = GET_METRIC(metric_b, 3) * slots_b - be_bound_slots_a
+
+Later the individual ratios for the measurement period can be recreated
+from these counts.
+
+	slots_delta = slots_b - slots_a
+	retiring_ratio = (float)retiring_slots / slots_delta
+	bad_spec_ratio = (float)bad_spec_slots / slots_delta
+	fe_bound_ratio = (float)fe_bound_slots / slots_delta
+	be_bound_ratio = (float)be_bound_slots / slota_delta
+
+	printf("Retiring %.2f%% Bad Speculation %.2f%% FE Bound %.2f%% BE Bound %.2f%%\n",
+		retiring_ratio * 100.,
+		bad_spec_ratio * 100.,
+		fe_bound_ratio * 100.,
+		be_bound_ratio * 100.);
+
+Resetting metrics counters
+==========================
+
+Since the individual metrics are only 8bit they lose precision for
+short regions over time because the number of cycles covered by each
+fraction bit shrinks. So the counters need to be reset regularly.
+
+When using the kernel perf API the kernel resets on every read.
+So as long as the reading is at reasonable intervals (every few
+seconds) the precision is good.
+
+When using perf stat it is recommended to always use the -I option,
+with no longer interval than a few seconds
+
+	perf stat -I 1000 --topdown ...
+
+For user programs using RDPMC directly the counter can
+be reset explicitly using ioctl:
+
+	ioctl(perf_fd, PERF_EVENT_IOC_RESET, 0);
+
+This "opens" a new measurement period.
+
+A program using RDPMC for TopDown should schedule such a reset
+regularly, as in every few seconds.
+
+[1] https://software.intel.com/en-us/top-down-microarchitecture-analysis-method-win
+[2] https://github.com/andikleen/pmu-tools/wiki/toplev-manual
+[3] https://software.intel.com/en-us/intel-vtune-amplifier-xe
+[4] https://github.com/andikleen/pmu-tools/tree/master/jevents
+[5] https://sites.google.com/site/analysismethods/yasin-pubs
-- 
2.17.1

