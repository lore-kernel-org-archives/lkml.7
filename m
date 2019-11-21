Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90F1C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 00:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6A0F208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 00:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfKUAQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 19:16:04 -0500
Received: from mga06.intel.com ([134.134.136.31]:58450 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726979AbfKUAPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 19:15:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 16:15:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,223,1571727600"; 
   d="scan'208";a="381553875"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga005.jf.intel.com with ESMTP; 20 Nov 2019 16:15:34 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 9EA74300D85; Wed, 20 Nov 2019 16:15:34 -0800 (PST)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 06/12] perf evsel: Add functions to close evsel on a CPU
Date:   Wed, 20 Nov 2019 16:15:16 -0800
Message-Id: <20191121001522.180827-7-andi@firstfloor.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191121001522.180827-1-andi@firstfloor.org>
References: <20191121001522.180827-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Refactor the existing all CPU function to use the per CPU
close internally.

Export APIs to close per CPU.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/lib/evsel.c              | 27 +++++++++++++++++++++------
 tools/perf/lib/include/perf/evsel.h |  1 +
 2 files changed, 22 insertions(+), 6 deletions(-)

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
-- 
2.23.0

