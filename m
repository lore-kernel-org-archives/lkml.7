Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F93BCA9EAE
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 16:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EF61222C2
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 16:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfJTQOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 12:14:08 -0400
Received: from mga14.intel.com ([192.55.52.115]:39878 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726600AbfJTQOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 12:14:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Oct 2019 09:13:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,320,1566889200"; 
   d="scan'208";a="187321663"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga007.jf.intel.com with ESMTP; 20 Oct 2019 09:13:58 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 462B5300393; Sun, 20 Oct 2019 09:13:58 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, eranian@google.com, kan.liang@linux.intel.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v1 6/9] perf stat: Use affinity for closing file descriptors
Date:   Sun, 20 Oct 2019 09:13:43 -0700
Message-Id: <20191020161346.18938-7-andi@firstfloor.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191020161346.18938-1-andi@firstfloor.org>
References: <20191020161346.18938-1-andi@firstfloor.org>
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
 tools/perf/lib/evsel.c              | 27 +++++++++++++++++++------
 tools/perf/lib/include/perf/evsel.h |  1 +
 tools/perf/util/evlist.c            | 31 +++++++++++++++++++++++++++--
 tools/perf/util/evsel.c             |  2 +-
 tools/perf/util/evsel.h             |  2 ++
 5 files changed, 54 insertions(+), 9 deletions(-)

diff --git a/tools/perf/lib/evsel.c b/tools/perf/lib/evsel.c
index 106522305ed0..5d23bf09e486 100644
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
index 4388667f265c..ed10a914cd3f 100644
--- a/tools/perf/lib/include/perf/evsel.h
+++ b/tools/perf/lib/include/perf/evsel.h
@@ -28,6 +28,7 @@ LIBPERF_API void perf_evsel__delete(struct perf_evsel *evsel);
 LIBPERF_API int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
 				 struct perf_thread_map *threads);
 LIBPERF_API void perf_evsel__close(struct perf_evsel *evsel);
+LIBPERF_API void perf_evsel__close_cpu(struct perf_evsel *evsel, int cpu);
 LIBPERF_API int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
 				 struct perf_counts_values *count);
 LIBPERF_API int perf_evsel__enable(struct perf_evsel *evsel);
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 00eaa6c5cdbe..f36f7eb64091 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -17,6 +17,7 @@
 #include "debug.h"
 #include "units.h"
 #include "util.h"
+#include "affinity.h"
 #include "../perf.h"
 #include "asm/bug.h"
 #include "bpf-event.h"
@@ -1342,9 +1343,35 @@ void perf_evlist__set_selected(struct evlist *evlist,
 void evlist__close(struct evlist *evlist)
 {
 	struct evsel *evsel;
+	struct affinity affinity;
+	struct perf_cpu_map *cpus;
+	int i;
+
+	/* So far record doesn't set this up */
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
+	for (i = 0; i < cpus->nr; i++) {
+		int cpu = cpus->map[i];
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
+		perf_evsel__free_id(evsel);
+	}
 }
 
 static int perf_evlist__create_syswide_maps(struct evlist *evlist)
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index bc57ac5d51a0..8cdf7c3d5f31 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1248,7 +1248,7 @@ int perf_evsel__alloc_id(struct evsel *evsel, int ncpus, int nthreads)
 	return 0;
 }
 
-static void perf_evsel__free_id(struct evsel *evsel)
+void perf_evsel__free_id(struct evsel *evsel)
 {
 	xyarray__delete(evsel->sample_id);
 	evsel->sample_id = NULL;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 227320501eb8..169bb896caf3 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -511,4 +511,6 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 struct perf_env *perf_evsel__env(struct evsel *evsel);
 
 int perf_evsel__store_ids(struct evsel *evsel, struct evlist *evlist);
+void perf_evsel__free_id(struct evsel *evsel);
+
 #endif /* __PERF_EVSEL_H */
-- 
2.21.0

