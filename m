Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DC2CA9EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 18:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B05FB2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 18:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388264AbfJYSO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 14:14:27 -0400
Received: from mga04.intel.com ([192.55.52.120]:21876 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388170AbfJYSOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 14:14:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 11:14:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,229,1569308400"; 
   d="scan'208";a="210415107"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga001.fm.intel.com with ESMTP; 25 Oct 2019 11:14:25 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id DE936300DDE; Fri, 25 Oct 2019 11:14:24 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, eranian@google.com, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v3 4/7] perf stat: Use affinity for closing file descriptors
Date:   Fri, 25 Oct 2019 11:14:14 -0700
Message-Id: <20191025181417.10670-5-andi@firstfloor.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191025181417.10670-1-andi@firstfloor.org>
References: <20191025181417.10670-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Closing a perf fd can also trigger an IPI to the target CPU.
Use the same affinity technique as we use for reading/enabling events
to closing to optimize the CPU transitions.

Before on a large test case with 94 CPUs:

% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 32.56    3.085463          50     61483           close

After:

 10.54    0.735704          11     61485           close

Signed-off-by: Andi Kleen <ak@linux.intel.com>

---

v2: Use new iterator macros
---
 tools/perf/lib/evsel.c              | 27 +++++++++++++++++++++------
 tools/perf/lib/include/perf/evsel.h |  1 +
 tools/perf/util/evlist.c            | 29 +++++++++++++++++++++++++++--
 tools/perf/util/evsel.h             |  1 +
 4 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/tools/perf/lib/evsel.c b/tools/perf/lib/evsel.c
index 5a89857b0381..ea775dacbd2d 100644
--- a/tools/perf/lib/evsel.c
+++ b/tools/perf/lib/evsel.c
@@ -114,16 +114,23 @@ int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
 	return err;
 }
 
+static void perf_evsel__close_fd_cpu(struct perf_evsel *evsel, int cpu)
+{
+	int thread;
+
+	for (thread = 0; thread < xyarray__max_y(evsel->fd); ++thread) {
+		if (FD(evsel, cpu, thread) >= 0)
+			close(FD(evsel, cpu, thread));
+		FD(evsel, cpu, thread) = -1;
+	}
+}
+
 void perf_evsel__close_fd(struct perf_evsel *evsel)
 {
-	int cpu, thread;
+	int cpu;
 
 	for (cpu = 0; cpu < xyarray__max_x(evsel->fd); cpu++)
-		for (thread = 0; thread < xyarray__max_y(evsel->fd); ++thread) {
-			if (FD(evsel, cpu, thread) >= 0)
-				close(FD(evsel, cpu, thread));
-			FD(evsel, cpu, thread) = -1;
-		}
+		perf_evsel__close_fd_cpu(evsel, cpu);
 }
 
 void perf_evsel__free_fd(struct perf_evsel *evsel)
@@ -141,6 +148,14 @@ void perf_evsel__close(struct perf_evsel *evsel)
 	perf_evsel__free_fd(evsel);
 }
 
+void perf_evsel__close_cpu(struct perf_evsel *evsel, int cpu)
+{
+	if (evsel->fd == NULL)
+		return;
+
+	perf_evsel__close_fd_cpu(evsel, cpu);
+}
+
 int perf_evsel__read_size(struct perf_evsel *evsel)
 {
 	u64 read_format = evsel->attr.read_format;
diff --git a/tools/perf/lib/include/perf/evsel.h b/tools/perf/lib/include/perf/evsel.h
index 557f5815a9c9..e7add554f861 100644
--- a/tools/perf/lib/include/perf/evsel.h
+++ b/tools/perf/lib/include/perf/evsel.h
@@ -26,6 +26,7 @@ LIBPERF_API void perf_evsel__delete(struct perf_evsel *evsel);
 LIBPERF_API int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
 				 struct perf_thread_map *threads);
 LIBPERF_API void perf_evsel__close(struct perf_evsel *evsel);
+LIBPERF_API void perf_evsel__close_cpu(struct perf_evsel *evsel, int cpu);
 LIBPERF_API int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
 				 struct perf_counts_values *count);
 LIBPERF_API int perf_evsel__enable(struct perf_evsel *evsel);
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index da3c8f8ef68e..aeb82de36043 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -18,6 +18,7 @@
 #include "debug.h"
 #include "units.h"
 #include <internal/lib.h> // page_size
+#include "affinity.h"
 #include "../perf.h"
 #include "asm/bug.h"
 #include "bpf-event.h"
@@ -1170,9 +1171,33 @@ void perf_evlist__set_selected(struct evlist *evlist,
 void evlist__close(struct evlist *evlist)
 {
 	struct evsel *evsel;
+	struct affinity affinity;
+	struct perf_cpu_map *cpus;
+	int i, cpu;
+
+	if (!evlist->core.cpus) {
+		evlist__for_each_entry_reverse(evlist, evsel)
+			evsel__close(evsel);
+		return;
+	}
 
-	evlist__for_each_entry_reverse(evlist, evsel)
-		evsel__close(evsel);
+	if (affinity__setup(&affinity) < 0)
+		return;
+	cpus = evlist__cpu_iter_start(evlist);
+	cpumap__for_each_cpu (cpus, i, cpu) {
+		affinity__set(&affinity, cpu);
+
+		evlist__for_each_entry_reverse(evlist, evsel) {
+			if (evlist__cpu_iter_skip(evsel, cpu))
+			    continue;
+			perf_evsel__close_cpu(&evsel->core, evsel->cpu_index);
+			evlist__cpu_iter_next(evsel);
+		}
+	}
+	evlist__for_each_entry_reverse(evlist, evsel) {
+		perf_evsel__free_fd(&evsel->core);
+		perf_evsel__free_id(&evsel->core);
+	}
 }
 
 static int perf_evlist__create_syswide_maps(struct evlist *evlist)
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index cf90019ae744..2e3b011ed09e 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -391,4 +391,5 @@ static inline bool evsel__has_callchain(const struct evsel *evsel)
 struct perf_env *perf_evsel__env(struct evsel *evsel);
 
 int perf_evsel__store_ids(struct evsel *evsel, struct evlist *evlist);
+
 #endif /* __PERF_EVSEL_H */
-- 
2.21.0

