Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93657CA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 14:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62DF821872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 14:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502559AbfJXOBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 10:01:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5153 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390982AbfJXOBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 10:01:23 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 775D38A1FC0A13841FB6;
        Thu, 24 Oct 2019 22:01:12 +0800 (CST)
Received: from huawei.com (10.175.102.38) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Thu, 24 Oct 2019
 22:00:58 +0800
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
Subject: [RFC v2 4/4] perf tools: Support "branch-misses:pp" on arm64
Date:   Thu, 24 Oct 2019 22:48:30 +0800
Message-ID: <20191024144830.16534-5-tanxiaojun@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191024144830.16534-1-tanxiaojun@huawei.com>
References: <20191024144830.16534-1-tanxiaojun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.38]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the suggestion of James Clark, use spe to support the precise
ip of some events. Currently its support event is:
branch-misses.

Example usage:

$ ./perf record -e branch-misses:pp dd if=/dev/zero of=/dev/null count=10000
(:p/pp/ppp is same for this case.)

$ ./perf report --stdio
("--stdio is not necessary")

--------------------------------------------------------------------
...
 # Samples: 14  of event 'branch-misses:pp'
 # Event count (approx.): 14
 #
 # Children      Self  Command  Shared Object      Symbol
 # ........  ........  .......  .................  ..........................
 #
    14.29%    14.29%  dd       [kernel.kallsyms]  [k] __arch_copy_from_user
    14.29%    14.29%  dd       libc-2.28.so       [.] _dl_addr
     7.14%     7.14%  dd       [kernel.kallsyms]  [k] __free_pages
     7.14%     7.14%  dd       [kernel.kallsyms]  [k] __pi_memcpy
     7.14%     7.14%  dd       [kernel.kallsyms]  [k] pagecache_get_page
     7.14%     7.14%  dd       [kernel.kallsyms]  [k] unmap_single_vma
     7.14%     7.14%  dd       dd                 [.] 0x00000000000025ec
     7.14%     7.14%  dd       ld-2.28.so         [.] _dl_lookup_symbol_x
     7.14%     7.14%  dd       ld-2.28.so         [.] check_match
     7.14%     7.14%  dd       libc-2.28.so       [.] __mpn_rshift
     7.14%     7.14%  dd       libc-2.28.so       [.] _nl_intern_locale_data
     7.14%     7.14%  dd       libc-2.28.so       [.] read_alias_file
...
--------------------------------------------------------------------

Signed-off-by: Tan Xiaojun <tanxiaojun@huawei.com>
---
 tools/perf/util/arm-spe.c | 44 +++++++++++++++++++++++++++++++++++++++
 tools/perf/util/arm-spe.h |  3 +++
 tools/perf/util/evlist.c  |  2 ++
 3 files changed, 49 insertions(+)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 596a48df6f4e..9851d1ed6d75 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -35,6 +35,19 @@
 
 #define MAX_TIMESTAMP (~0ULL)
 
+#define SPE_ATTR_TS_ENABLE		BIT(0)
+#define SPE_ATTR_PA_ENABLE		BIT(1)
+#define SPE_ATTR_PCT_ENABLE		BIT(2)
+#define SPE_ATTR_JITTER			BIT(16)
+#define SPE_ATTR_BRANCH_FILTER		BIT(32)
+#define SPE_ATTR_LOAD_FILTER		BIT(33)
+#define SPE_ATTR_STORE_FILTER		BIT(34)
+
+#define SPE_ATTR_EV_RETIRED		BIT(1)
+#define SPE_ATTR_EV_CACHE		BIT(3)
+#define SPE_ATTR_EV_TLB			BIT(5)
+#define SPE_ATTR_EV_BRANCH		BIT(7)
+
 struct arm_spe {
 	struct auxtrace			auxtrace;
 	struct auxtrace_queues		queues;
@@ -771,6 +784,15 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
 	attr.sample_id_all = evsel->core.attr.sample_id_all;
 	attr.read_format = evsel->core.attr.read_format;
 
+	/* If it is in the precise ip mode, there is no need to
+	 * synthesize new events. */
+	if (!strncmp(evsel->name, "branch-misses", 13)) {
+		spe->sample_branch_miss = true;
+		spe->branch_miss_id = evsel->core.id[0];
+
+		return 0;
+	}
+
 	/* create new id val to be a fixed offset from evsel id */
 	id = evsel->core.id[0] + 1000000000;
 
@@ -880,3 +902,25 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 	free(spe);
 	return err;
 }
+
+void arm_spe_precise_ip_support(struct evlist *evlist, struct evsel *evsel)
+{
+	struct perf_pmu *pmu;
+
+	/* Currently only supports precise_ip for branch-misses on arm64 */
+	if (!strcmp(perf_env__arch(evlist->env), "arm64")
+			&& evsel->core.attr.config == PERF_COUNT_HW_BRANCH_MISSES
+			&& evsel->core.attr.precise_ip) {
+		pmu = perf_pmu__find("arm_spe_0");
+		if (pmu) {
+			evsel->pmu_name = pmu->name;
+			evsel->core.attr.type = PERF_RECORD_AUXTRACE;
+			evsel->core.attr.config = SPE_ATTR_TS_ENABLE
+						| SPE_ATTR_PA_ENABLE
+						| SPE_ATTR_JITTER
+						| SPE_ATTR_BRANCH_FILTER;
+			evsel->core.attr.precise_ip = 0;
+			evsel->core.attr.config1 = SPE_ATTR_EV_BRANCH;
+		}
+	}
+}
diff --git a/tools/perf/util/arm-spe.h b/tools/perf/util/arm-spe.h
index 98d3235781c3..8b1fb191d03a 100644
--- a/tools/perf/util/arm-spe.h
+++ b/tools/perf/util/arm-spe.h
@@ -20,6 +20,8 @@ enum {
 union perf_event;
 struct perf_session;
 struct perf_pmu;
+struct evlist;
+struct evsel;
 
 struct auxtrace_record *arm_spe_recording_init(int *err,
 					       struct perf_pmu *arm_spe_pmu);
@@ -28,4 +30,5 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 				  struct perf_session *session);
 
 struct perf_event_attr *arm_spe_pmu_default_config(struct perf_pmu *arm_spe_pmu);
+void arm_spe_precise_ip_support(struct evlist *evlist, struct evsel *evsel);
 #endif
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index d277a98e62df..8a83d2b98209 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -9,6 +9,7 @@
 #include <errno.h>
 #include <inttypes.h>
 #include <poll.h>
+#include "arm-spe.h"
 #include "cpumap.h"
 #include "util/mmap.h"
 #include "thread_map.h"
@@ -181,6 +182,7 @@ void perf_evlist__splice_list_tail(struct evlist *evlist,
 	struct evsel *evsel, *temp;
 
 	__evlist__for_each_entry_safe(list, temp, evsel) {
+		arm_spe_precise_ip_support(evlist, evsel);
 		list_del_init(&evsel->core.node);
 		evlist__add(evlist, evsel);
 	}
-- 
2.17.1

