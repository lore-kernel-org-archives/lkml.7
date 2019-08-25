Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8EAC3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 18:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6923206E0
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 18:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566757118;
	bh=8oh3tos89xz6u9VCIE/TxOipbrG2oqwP0UctLe0lFlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GOQRZIlx6nSyeggQ4rN0XcuOm3ZxWg294w6WGISiM8Qaw5yXUPY1NwiO4eLUpXaCe
	 B5PjPrSRlUB4GqBQ27fEhL94VmAbYhWoaE+8AGExF/FMXgJ5ybw9jF+nU5iho7fZE7
	 nYUuMxiwV9etQLKKkqpF9RbKNKi5IMpTSeb21Yxg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbfHYSSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 14:18:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42142 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728948AbfHYSST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 14:18:19 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 38908189DAC8;
        Sun, 25 Aug 2019 18:18:18 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-45.brq.redhat.com [10.40.204.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0D01F5D9C3;
        Sun, 25 Aug 2019 18:18:15 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 08/12] libperf: Add read_event to perf/event.h
Date:   Sun, 25 Aug 2019 20:17:48 +0200
Message-Id: <20190825181752.722-9-jolsa@kernel.org>
In-Reply-To: <20190825181752.722-1-jolsa@kernel.org>
References: <20190825181752.722-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.63]); Sun, 25 Aug 2019 18:18:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving read_event event definition into libperf's event.h
header include.

In order to keep libperf simple, we switch 'u64/u32/u16/u8'
types used events to their generic '__u*' versions.

Perf added 'u*' types mainly to ease up printing __u64 values
as stated in the linux/types.h comment:

  /*
   * We define u64 as uint64_t for every architecture
   * so that we can print it with "%"PRIx64 without getting warnings.
   *
   * typedef __u64 u64;
   * typedef __s64 s64;
   */

Adding and using new PRI_lu64 and PRI_lx64 macros to be used for
that.  Using extra '_' to ease up the reading and differentiate
them from standard PRI*64 macros.

Link: http://lkml.kernel.org/n/tip-f41v4s56i2u4hbn2hzufa12l@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/include/perf/event.h | 12 ++++++++++++
 tools/perf/util/event.h             | 12 ------------
 tools/perf/util/session.c           |  8 ++++----
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index 3bd2727ac5f9..a03dbe776a44 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -61,4 +61,16 @@ struct lost_samples_event {
 	__u64 lost;
 };
 
+/*
+ * PERF_FORMAT_ENABLED | PERF_FORMAT_RUNNING | PERF_FORMAT_ID
+ */
+struct read_event {
+	struct perf_event_header header;
+	__u32 pid, tid;
+	__u64 value;
+	__u64 time_enabled;
+	__u64 time_running;
+	__u64 id;
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 1bf44b73fbbf..89872279a5af 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -16,18 +16,6 @@
 #define PRI_lu64 "l" PRIu64
 #define PRI_lx64 "l" PRIx64
 
-/*
- * PERF_FORMAT_ENABLED | PERF_FORMAT_RUNNING | PERF_FORMAT_ID
- */
-struct read_event {
-	struct perf_event_header header;
-	u32 pid, tid;
-	u64 value;
-	u64 time_enabled;
-	u64 time_running;
-	u64 id;
-};
-
 struct throttle_event {
 	struct perf_event_header header;
 	u64 time;
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 82e0438a9160..cb1d8dcd0c19 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1260,7 +1260,7 @@ static void dump_read(struct evsel *evsel, union perf_event *event)
 	if (!dump_trace)
 		return;
 
-	printf(": %d %d %s %" PRIu64 "\n", event->read.pid, event->read.tid,
+	printf(": %d %d %s %" PRI_lu64 "\n", event->read.pid, event->read.tid,
 	       perf_evsel__name(evsel),
 	       event->read.value);
 
@@ -1270,13 +1270,13 @@ static void dump_read(struct evsel *evsel, union perf_event *event)
 	read_format = evsel->core.attr.read_format;
 
 	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
-		printf("... time enabled : %" PRIu64 "\n", read_event->time_enabled);
+		printf("... time enabled : %" PRI_lu64 "\n", read_event->time_enabled);
 
 	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
-		printf("... time running : %" PRIu64 "\n", read_event->time_running);
+		printf("... time running : %" PRI_lu64 "\n", read_event->time_running);
 
 	if (read_format & PERF_FORMAT_ID)
-		printf("... id           : %" PRIu64 "\n", read_event->id);
+		printf("... id           : %" PRI_lu64 "\n", read_event->id);
 }
 
 static struct machine *machines__find_for_cpumode(struct machines *machines,
-- 
2.21.0

