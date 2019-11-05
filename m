Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B380CCA9ED3
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 00:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8265020869
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 00:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387699AbfKEAZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 19:25:44 -0500
Received: from mga07.intel.com ([134.134.136.100]:30774 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387527AbfKEAZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 19:25:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2019 16:25:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,268,1569308400"; 
   d="scan'208";a="213712869"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga002.jf.intel.com with ESMTP; 04 Nov 2019 16:25:28 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 32527300884; Mon,  4 Nov 2019 16:25:28 -0800 (PST)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v4 9/9] perf stat: Use affinity for enabling/disabling events
Date:   Mon,  4 Nov 2019 16:25:22 -0800
Message-Id: <20191105002522.83803-10-andi@firstfloor.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191105002522.83803-1-andi@firstfloor.org>
References: <20191105002522.83803-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Restructure event enabling/disabling to use affinity, which
minimizes the number of IPIs needed.

Before on a large test case with 94 CPUs:

% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 54.65    1.899986          22     84812       660 ioctl

after:

 39.21    0.930451          10     84796       644 ioctl

Signed-off-by: Andi Kleen <ak@linux.intel.com>

---

v2: Use new iterator macros
v3: Use new iterator macros
---
 tools/perf/lib/evsel.c              | 49 +++++++++++++++++++++--------
 tools/perf/lib/include/perf/evsel.h |  2 ++
 tools/perf/util/evlist.c            | 46 ++++++++++++++++++++++++---
 tools/perf/util/evsel.c             | 13 ++++++++
 tools/perf/util/evsel.h             |  2 ++
 5 files changed, 94 insertions(+), 18 deletions(-)

diff --git a/tools/perf/lib/evsel.c b/tools/perf/lib/evsel.c
index ea775dacbd2d..89ddfade0b96 100644
--- a/tools/perf/lib/evsel.c
+++ b/tools/perf/lib/evsel.c
@@ -198,38 +198,61 @@ int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
 }
 
 static int perf_evsel__run_ioctl(struct perf_evsel *evsel,
-				 int ioc,  void *arg)
+				 int ioc,  void *arg,
+				 int cpu)
 {
-	int cpu, thread;
+	int thread;
 
-	for (cpu = 0; cpu < xyarray__max_x(evsel->fd); cpu++) {
-		for (thread = 0; thread < xyarray__max_y(evsel->fd); thread++) {
-			int fd = FD(evsel, cpu, thread),
-			    err = ioctl(fd, ioc, arg);
+	for (thread = 0; thread < xyarray__max_y(evsel->fd); thread++) {
+		int fd = FD(evsel, cpu, thread),
+		    err = ioctl(fd, ioc, arg);
 
-			if (err)
-				return err;
-		}
+		if (err)
+			return err;
 	}
 
 	return 0;
 }
 
+int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu)
+{
+	return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, 0, cpu);
+}
+
 int perf_evsel__enable(struct perf_evsel *evsel)
 {
-	return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, 0);
+	int i;
+	int err = 0;
+
+	for (i = 0; i < evsel->cpus->nr && !err; i++)
+		err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, 0, i);
+	return err;
+}
+
+int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu)
+{
+	return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_DISABLE, 0, cpu);
 }
 
 int perf_evsel__disable(struct perf_evsel *evsel)
 {
-	return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_DISABLE, 0);
+	int i;
+	int err = 0;
+
+	for (i = 0; i < evsel->cpus->nr && !err; i++)
+		err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_DISABLE, 0, i);
+	return err;
 }
 
 int perf_evsel__apply_filter(struct perf_evsel *evsel, const char *filter)
 {
-	return perf_evsel__run_ioctl(evsel,
+	int err = 0, i;
+
+	for (i = 0; i < evsel->cpus->nr && !err; i++)
+		err = perf_evsel__run_ioctl(evsel,
 				     PERF_EVENT_IOC_SET_FILTER,
-				     (void *)filter);
+				     (void *)filter, i);
+	return err;
 }
 
 struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel)
diff --git a/tools/perf/lib/include/perf/evsel.h b/tools/perf/lib/include/perf/evsel.h
index e7add554f861..c82ec39a4ad0 100644
--- a/tools/perf/lib/include/perf/evsel.h
+++ b/tools/perf/lib/include/perf/evsel.h
@@ -30,7 +30,9 @@ LIBPERF_API void perf_evsel__close_cpu(struct perf_evsel *evsel, int cpu);
 LIBPERF_API int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
 				 struct perf_counts_values *count);
 LIBPERF_API int perf_evsel__enable(struct perf_evsel *evsel);
+LIBPERF_API int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu);
 LIBPERF_API int perf_evsel__disable(struct perf_evsel *evsel);
+LIBPERF_API int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu);
 LIBPERF_API struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
 LIBPERF_API struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel);
 LIBPERF_API struct perf_event_attr *perf_evsel__attr(struct perf_evsel *evsel);
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 146e6d126966..01caacf3349b 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -374,26 +374,62 @@ void evlist__cpu_iter_next(struct evsel *ev)
 void evlist__disable(struct evlist *evlist)
 {
 	struct evsel *pos;
+	struct affinity affinity;
+	int cpu, i;
+
+	if (affinity__setup(&affinity) < 0)
+		return;
+
+	evlist__cpu_iter_start(evlist);
+	evlist__for_each_cpu (evlist, i, cpu) {
+		affinity__set(&affinity, cpu);
 
+		evlist__for_each_entry(evlist, pos) {
+			if (evlist__cpu_iter_skip(pos, cpu))
+				continue;
+			if (pos->disabled || !perf_evsel__is_group_leader(pos) || !pos->core.fd)
+				continue;
+			evsel__disable_cpu(pos, pos->cpu_index);
+			evlist__cpu_iter_next(pos);
+		}
+	}
+	affinity__cleanup(&affinity);
 	evlist__for_each_entry(evlist, pos) {
-		if (pos->disabled || !perf_evsel__is_group_leader(pos) || !pos->core.fd)
+		if (!perf_evsel__is_group_leader(pos) || !pos->core.fd)
 			continue;
-		evsel__disable(pos);
+		pos->disabled = true;
 	}
-
 	evlist->enabled = false;
 }
 
 void evlist__enable(struct evlist *evlist)
 {
 	struct evsel *pos;
+	struct affinity affinity;
+	int cpu, i;
+
+	if (affinity__setup(&affinity) < 0)
+		return;
 
+	evlist__cpu_iter_start(evlist);
+	evlist__for_each_cpu (evlist, i, cpu) {
+		affinity__set(&affinity, cpu);
+
+		evlist__for_each_entry(evlist, pos) {
+			if (evlist__cpu_iter_skip(pos, cpu))
+				continue;
+			if (!perf_evsel__is_group_leader(pos) || !pos->core.fd)
+				continue;
+			evsel__enable_cpu(pos, pos->cpu_index);
+			evlist__cpu_iter_next(pos);
+		}
+	}
+	affinity__cleanup(&affinity);
 	evlist__for_each_entry(evlist, pos) {
 		if (!perf_evsel__is_group_leader(pos) || !pos->core.fd)
 			continue;
-		evsel__enable(pos);
+		pos->disabled = false;
 	}
-
 	evlist->enabled = true;
 }
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 7106f9a067df..79050a6f4991 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1205,13 +1205,26 @@ int perf_evsel__append_addr_filter(struct evsel *evsel, const char *filter)
 	return perf_evsel__append_filter(evsel, "%s,%s", filter);
 }
 
+/* Caller has to clear disabled after going through all CPUs. */
+int evsel__enable_cpu(struct evsel *evsel, int cpu)
+{
+	int err = perf_evsel__enable_cpu(&evsel->core, cpu);
+	return err;
+}
+
 int evsel__enable(struct evsel *evsel)
 {
 	int err = perf_evsel__enable(&evsel->core);
 
 	if (!err)
 		evsel->disabled = false;
+	return err;
+}
 
+/* Caller has to set disabled after going through all CPUs. */
+int evsel__disable_cpu(struct evsel *evsel, int cpu)
+{
+	int err = perf_evsel__disable_cpu(&evsel->core, cpu);
 	return err;
 }
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 9fc9f6698aa4..15977bbe7b63 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -222,8 +222,10 @@ int perf_evsel__set_filter(struct evsel *evsel, const char *filter);
 int perf_evsel__append_tp_filter(struct evsel *evsel, const char *filter);
 int perf_evsel__append_addr_filter(struct evsel *evsel,
 				   const char *filter);
+int evsel__enable_cpu(struct evsel *evsel, int cpu);
 int evsel__enable(struct evsel *evsel);
 int evsel__disable(struct evsel *evsel);
+int evsel__disable_cpu(struct evsel *evsel, int cpu);
 
 int perf_evsel__open_per_cpu(struct evsel *evsel,
 			     struct perf_cpu_map *cpus,
-- 
2.23.0

