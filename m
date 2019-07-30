Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4E0C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2368A217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455608;
	bh=BVEOybWi9R8A9A4YxYWVFI7PG/vLvggJZXLMVuFYNj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PRDiijChZ4MEHoR001Q0OMNSlXIu46i4jAhGykfBSkEGDuonR8m0oL3LpVIJ6eQnt
	 j0eY93g5y7H8mB9qepVIOPvDfzXgSDPXTeAok/LHwUS0E+rgxsw7kIm0b5PC+IhQ41
	 P2drtEjwVIefjuVqlVPMjJwOfBXn/armlT/Zvhng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732344AbfG3DAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 23:00:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:49326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732317AbfG3DAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 23:00:01 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58E0921773;
        Tue, 30 Jul 2019 02:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455600;
        bh=BVEOybWi9R8A9A4YxYWVFI7PG/vLvggJZXLMVuFYNj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oEXwqCixNNsM+Nm0jKccpjrUV2nrbWilWqlTBn7vUcdyn7zwXWV5L1m66bD87mXIS
         E42CeNqstZmESlgmhj/xtH6Idupkt+8NJuyZP7rL9fEUNJG+qkdDGSDoKhVy44RwTR
         Ak6+rxzuIcmOT1JGf9ClddDGlfVg1mDXVc/pIlHY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 066/107] libperf: Add perf_evlist__add() function
Date:   Mon, 29 Jul 2019 23:55:29 -0300
Message-Id: <20190730025610.22603-67-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add the perf_evlist__add() function to add a perf_evsel in a perf_evlist
struct.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-40-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evlist.c              | 7 +++++++
 tools/perf/lib/include/perf/evlist.h | 3 +++
 tools/perf/lib/libperf.map           | 1 +
 tools/perf/util/evlist.c             | 2 +-
 4 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index fdc8c1894b37..e5f187fa4e57 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -2,8 +2,15 @@
 #include <perf/evlist.h>
 #include <linux/list.h>
 #include <internal/evlist.h>
+#include <internal/evsel.h>
 
 void perf_evlist__init(struct perf_evlist *evlist)
 {
 	INIT_LIST_HEAD(&evlist->entries);
 }
+
+void perf_evlist__add(struct perf_evlist *evlist,
+		      struct perf_evsel *evsel)
+{
+	list_add_tail(&evsel->node, &evlist->entries);
+}
diff --git a/tools/perf/lib/include/perf/evlist.h b/tools/perf/lib/include/perf/evlist.h
index 1ddfcca0bd01..6992568b14a0 100644
--- a/tools/perf/lib/include/perf/evlist.h
+++ b/tools/perf/lib/include/perf/evlist.h
@@ -5,7 +5,10 @@
 #include <perf/core.h>
 
 struct perf_evlist;
+struct perf_evsel;
 
 LIBPERF_API void perf_evlist__init(struct perf_evlist *evlist);
+LIBPERF_API void perf_evlist__add(struct perf_evlist *evlist,
+				  struct perf_evsel *evsel);
 
 #endif /* __LIBPERF_EVLIST_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index 5ca6ff6fcdfa..06ccf31eb24d 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -11,6 +11,7 @@ LIBPERF_0.0.1 {
 		perf_thread_map__put;
 		perf_evsel__init;
 		perf_evlist__init;
+		perf_evlist__add;
 	local:
 		*;
 };
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index f4aa6cf80559..f2b86f49ab8d 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -180,8 +180,8 @@ static void perf_evlist__propagate_maps(struct evlist *evlist)
 
 void evlist__add(struct evlist *evlist, struct evsel *entry)
 {
+	perf_evlist__add(&evlist->core, &entry->core);
 	entry->evlist = evlist;
-	list_add_tail(&entry->core.node, &evlist->core.entries);
 	entry->idx = evlist->nr_entries;
 	entry->tracking = !entry->idx;
 
-- 
2.21.0

