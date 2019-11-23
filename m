Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6C5C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 09:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2589B20719
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 09:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfKWJYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 04:24:44 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7169 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726524AbfKWJYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 04:24:43 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6FCDF6972E370EE2FF39;
        Sat, 23 Nov 2019 17:24:40 +0800 (CST)
Received: from huawei.com (10.175.102.38) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Sat, 23 Nov 2019
 17:24:30 +0800
From:   Tan Xiaojun <tanxiaojun@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <ak@linux.intel.com>,
        <adrian.hunter@intel.com>, <yao.jin@linux.intel.com>,
        <tmricht@linux.ibm.com>, <brueckner@linux.ibm.com>,
        <songliubraving@fb.com>, <gregkh@linuxfoundation.org>,
        <kim.phillips@arm.com>, <James.Clark@arm.com>,
        <jeremy.linton@arm.com>
CC:     <gengdongjiu@huawei.com>, <wxf.wang@hisilicon.com>,
        <liwei391@huawei.com>, <tanxiaojun@huawei.com>,
        <huawei.libin@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>
Subject: [RFC v3 5/5] perf tools: Add support to process multi spe events
Date:   Sat, 23 Nov 2019 18:11:18 +0800
Message-ID: <20191123101118.12635-6-tanxiaojun@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191123101118.12635-1-tanxiaojun@huawei.com>
References: <20191123101118.12635-1-tanxiaojun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.38]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Under the original logic, if the user specifies multiple spe
events during the record, perf will report an error and exit
without actually running. This is not very friendly.

This patch slightly modifies this logic, in which case a
warning is reported and the first spe event is taken as a
record.

At the same time, this patch also supports the recording of
multi new synthetic events. However, if the user specifies the
spe event and then specifies the synthetic spe events, a warning
will be reported and the above principles will still be followed,
only the first spe event will be recorded.

Example:
------------------------------------------------------------------
1) For multiple spe events
$ perf record -e arm_spe_0/ts_enable=0,load_filter=1,jitter=1,min_latency=0/ -e arm_spe_0/ts_enable=0,store_filter=1,jitter=1,min_latency=0/ ls
Warning:
There may be only one arm_spe_x event. More than one spe event will be ignored, unless they are synthetic events of spe, like:
arm_spe_x/llc_miss/
arm_spe_x/branch_miss/
arm_spe_x/tlb_miss/
arm_spe_x/remote_access/
(see 'perf list')
...
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.078 MB perf.data ]

$ perf report --stdio
...
 # Samples: 0  of event 'arm_spe_0/ts_enable=0,load_filter=1,jitter=1,min_latency=0/'
...

2) For multiple spe precise ip events (synthetic event)
$ perf record -e arm_spe_0/llc_miss/ -e arm_spe_0/llc_miss/ -e arm_spe_0/tlb_miss/ ls
Warning:
These events are precise ip events, please add :p/pp/ppp after the event.
...
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.343 MB perf.data ]

$ perf report --stdio
 # To display the perf.data header info, please use --header/--header-only options.
 #
 #
 # Total Lost Samples: 0
 #
 # Samples: 0  of event 'arm_spe_0/llc_miss/, arm_spe_0/tlb_miss/'
 # Event count (approx.): 0
 #
 # Children      Self  Command  Shared Object  Symbol
 # ........  ........  .......  .............  ......
 #

 # Samples: 0  of event 'dummy:u'
 # Event count (approx.): 0
 #
 # Children      Self  Command  Shared Object  Symbol
 # ........  ........  .......  .............  ......
 #

 # Samples: 83  of event 'llc-miss'
 # Event count (approx.): 83
 #
 # Children      Self  Command  Shared Object      Symbol
 # ........  ........  .......  .................  ....................................
 #
     42.17%    42.17%  ls       [kernel.kallsyms]  [k] perf_iterate_ctx.constprop.64
     14.46%    14.46%  ls       [kernel.kallsyms]  [k] memchr_inv
     13.25%    13.25%  ls       [kernel.kallsyms]  [k] perf_event_mmap
      2.41%     2.41%  ls       [kernel.kallsyms]  [k] available_idle_cpu
      2.41%     2.41%  ls       [kernel.kallsyms]  [k] copy_page
      2.41%     2.41%  ls       [kernel.kallsyms]  [k] try_to_wake_up
      2.41%     2.41%  ls       [kernel.kallsyms]  [k] vma_interval_tree_insert
      2.41%     2.41%  ls       ld-2.28.so         [.] _dl_lookup_symbol_x
      2.41%     2.41%  ls       ld-2.28.so         [.] _dl_relocate_object
      1.20%     1.20%  ls       [kernel.kallsyms]  [k] ext4_getattr
      1.20%     1.20%  ls       [kernel.kallsyms]  [k] get_page_from_freelist
      1.20%     1.20%  ls       [kernel.kallsyms]  [k] get_partial_node.isra.25
      1.20%     1.20%  ls       [kernel.kallsyms]  [k] lock_page_memcg
      1.20%     1.20%  ls       [kernel.kallsyms]  [k] may_open
      1.20%     1.20%  ls       [kernel.kallsyms]  [k] radix_tree_next_chunk
      1.20%     1.20%  ls       [kernel.kallsyms]  [k] rb_prev
      1.20%     1.20%  ls       ld-2.28.so         [.] _dl_map_object_from_fd
      1.20%     1.20%  ls       ld-2.28.so         [.] _dl_start
      1.20%     1.20%  ls       ld-2.28.so         [.] do_lookup_x
      1.20%     1.20%  ls       ld-2.28.so         [.] rtld_lock_default_lock_recursive
      1.20%     1.20%  ls       libc-2.28.so       [.] getenv
      1.20%     1.20%  ls       [unknown]          [.] 0xffff29f1190029b8

 # Samples: 13  of event 'tlb-miss'
 # Event count (approx.): 13
 #
 # Children      Self  Command  Shared Object      Symbol
 # ........  ........  .......  .................  ............................
 #
     15.38%    15.38%  ls       [kernel.kallsyms]  [k] __audit_syscall_entry
     15.38%    15.38%  ls       [kernel.kallsyms]  [k] get_partial_node.isra.25
     15.38%    15.38%  ls       ld-2.28.so         [.] _dl_relocate_object
     15.38%    15.38%  ls       ld-2.28.so         [.] do_lookup_x
      7.69%     7.69%  ls       [kernel.kallsyms]  [k] memchr_inv
      7.69%     7.69%  ls       ld-2.28.so         [.] _dl_map_object_from_fd
      7.69%     7.69%  ls       ld-2.28.so         [.] _dl_setup_hash
      7.69%     7.69%  ls       ld-2.28.so         [.] _dl_start
      7.69%     7.69%  ls       ls                 [.] 0x00000000000097a0

------------------------------------------------------------------

Signed-off-by: Tan Xiaojun <tanxiaojun@huawei.com>
---
 tools/perf/arch/arm64/util/arm-spe.c | 47 +++++++++++++++++++++++++---
 tools/perf/util/arm-spe.c            | 25 +++++++++++++++
 tools/perf/util/arm-spe.h            | 20 ++++++++++++
 3 files changed, 88 insertions(+), 4 deletions(-)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index eba6541ec0f1..68e91f3c9614 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -67,21 +67,60 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 	struct arm_spe_recording *sper =
 			container_of(itr, struct arm_spe_recording, itr);
 	struct perf_pmu *arm_spe_pmu = sper->arm_spe_pmu;
-	struct evsel *evsel, *arm_spe_evsel = NULL;
+	struct evsel *evsel, *tmp, *arm_spe_evsel = NULL;
 	bool privileged = perf_event_paranoid_check(-1);
 	struct evsel *tracking_evsel;
+	char evsel_name[128];
 	int err;
 
 	sper->evlist = evlist;
 
-	evlist__for_each_entry(evlist, evsel) {
+	evlist__for_each_entry_safe(evlist, tmp, evsel) {
 		if (evsel->core.attr.type == arm_spe_pmu->type) {
 			if (arm_spe_evsel) {
-				pr_err("There may be only one " ARM_SPE_PMU_NAME "x event\n");
-				return -EINVAL;
+				if ((evsel->core.attr.config
+						& GENMASK_ULL(ARM_SPE_EVENT_HI,
+							ARM_SPE_EVENT_LO))
+						&& (arm_spe_evsel->core.attr.config
+						& GENMASK_ULL(ARM_SPE_EVENT_HI,
+							ARM_SPE_EVENT_LO))) {
+					arm_spe_evsel->core.attr.config |=
+								evsel->core.attr.config;
+
+					if (!strstr(arm_spe_evsel->name, evsel->name)) {
+						scnprintf(evsel_name, sizeof(evsel_name),
+								"%s, %s", arm_spe_evsel->name,
+								evsel->name);
+						arm_spe_evsel->name = strdup(evsel_name);
+					}
+				} else
+					pr_warning("Warning:\n"
+						"There may be only one "
+						ARM_SPE_PMU_NAME "x event."
+						" More than one spe event"
+						" will be ignored, unless"
+						" they are synthetic events"
+						" of spe, like:"
+						"\narm_spe_x/llc_miss/"
+						"\narm_spe_x/branch_miss/"
+						"\narm_spe_x/tlb_miss/"
+						"\narm_spe_x/remote_access/"
+						"\n(see 'perf list')\n");
+				evlist__remove(evlist, evsel);
+				evsel__delete(evsel);
+				continue;
 			}
 			evsel->core.attr.freq = 0;
 			evsel->core.attr.sample_period = 1;
+			if (evsel->core.attr.config
+					& GENMASK_ULL(ARM_SPE_EVENT_HI, ARM_SPE_EVENT_LO)) {
+				evsel->core.attr.config |= SPE_ATTR_TS_ENABLE;
+				if (!evsel->core.attr.precise_ip)
+					pr_warning("Warning:\n"
+						"These events are precise ip events,"
+						" please add :p/pp/ppp after the event.\n");
+			}
+
 			arm_spe_evsel = evsel;
 			opts->full_auxtrace = true;
 		}
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index e7282c2616f3..0c9d7fa518a5 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -779,6 +779,31 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
 	attr.sample_id_all = evsel->core.attr.sample_id_all;
 	attr.read_format = evsel->core.attr.read_format;
 
+	if (evsel->core.attr.config
+			& GENMASK_ULL(ARM_SPE_EVENT_HI,
+				ARM_SPE_EVENT_LO)) {
+		spe->synth_opts.llc_miss = false;
+		spe->synth_opts.tlb_miss = false;
+		spe->synth_opts.branch_miss = false;
+		spe->synth_opts.remote_access = false;
+
+		if (evsel->core.attr.config
+				& (ARM_SPE_EVENT_LLC_MISS << ARM_SPE_EVENT_LO))
+			spe->synth_opts.llc_miss = true;
+
+		if (evsel->core.attr.config
+				& (ARM_SPE_EVENT_TLB_MISS << ARM_SPE_EVENT_LO))
+			spe->synth_opts.tlb_miss = true;
+
+		if (evsel->core.attr.config
+				& (ARM_SPE_EVENT_BRANCH_MISS << ARM_SPE_EVENT_LO))
+			spe->synth_opts.branch_miss = true;
+
+		if (evsel->core.attr.config
+				& (ARM_SPE_EVENT_REMOTE_ACCESS << ARM_SPE_EVENT_LO))
+			spe->synth_opts.remote_access = true;
+	}
+
 	/* create new id val to be a fixed offset from evsel id */
 	id = evsel->core.id[0] + 1000000000;
 
diff --git a/tools/perf/util/arm-spe.h b/tools/perf/util/arm-spe.h
index 98d3235781c3..db7420121979 100644
--- a/tools/perf/util/arm-spe.h
+++ b/tools/perf/util/arm-spe.h
@@ -9,6 +9,26 @@
 
 #define ARM_SPE_PMU_NAME "arm_spe_"
 
+#define ARM_SPE_EVENT_LO			3
+#define ARM_SPE_EVENT_HI			6
+#define ARM_SPE_EVENT_LLC_MISS			BIT(0)
+#define ARM_SPE_EVENT_BRANCH_MISS		BIT(1)
+#define ARM_SPE_EVENT_TLB_MISS			BIT(2)
+#define ARM_SPE_EVENT_REMOTE_ACCESS		BIT(3)
+
+#define SPE_ATTR_TS_ENABLE			BIT(0)
+#define SPE_ATTR_PA_ENABLE			BIT(1)
+#define SPE_ATTR_PCT_ENABLE			BIT(2)
+#define SPE_ATTR_JITTER				BIT(16)
+#define SPE_ATTR_BRANCH_FILTER			BIT(32)
+#define SPE_ATTR_LOAD_FILTER			BIT(33)
+#define SPE_ATTR_STORE_FILTER			BIT(34)
+
+#define SPE_ATTR_EV_RETIRED			BIT(1)
+#define SPE_ATTR_EV_CACHE			BIT(3)
+#define SPE_ATTR_EV_TLB				BIT(5)
+#define SPE_ATTR_EV_BRANCH			BIT(7)
+
 enum {
 	ARM_SPE_PMU_TYPE,
 	ARM_SPE_PER_CPU_MMAPS,
-- 
2.17.1

