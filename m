Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B828C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CC552064A
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567000735;
	bh=WJmCzFBp86hLU6UlAmTmgqqXeInJqOIWiOkXHySq/+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nTkHkZ3RgH/pcjeTJuVilhzuaIGY0y1k4GfT4uf02GmJ9LOgQTv8aZscpBNg6EDWt
	 xosJd+we1g5QxCnz/LiTQi9h+KQ5gQSrp6+fYN2nRwkWdGQAtLU+Sjm4EyGd1ojrqa
	 bnqc1TRe+72oF48Hz+Kb8LWNlPGXKPnl2rR9Bfxc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfH1N5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:57:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58036 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbfH1N5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:57:34 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 10AD2308FC20;
        Wed, 28 Aug 2019 13:57:34 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6AB921001B00;
        Wed, 28 Aug 2019 13:57:32 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 07/23] libperf: Add PERF_RECORD_ID_INDEX 'struct id_index_event' to perf/event.h
Date:   Wed, 28 Aug 2019 15:57:01 +0200
Message-Id: <20190828135717.7245-8-jolsa@kernel.org>
In-Reply-To: <20190828135717.7245-1-jolsa@kernel.org>
References: <20190828135717.7245-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 28 Aug 2019 13:57:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the PERF_RECORD_ID_INDEX event definition to libperf's event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8'
types used events to their generic '__u*' versions.

Adding PRI_ld64 define, so we can use it in printf output.

Link: http://lkml.kernel.org/n/tip-rfqlci30hjrzropnxjnwoz12@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/include/perf/event.h | 13 +++++++++++++
 tools/perf/util/event.h             | 15 ++-------------
 tools/perf/util/session.c           |  8 ++++----
 3 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index 5e6b6d16793c..c68523c4fa01 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -188,4 +188,17 @@ struct build_id_event {
 	char			 filename[];
 };
 
+struct id_index_entry {
+	__u64			 id;
+	__u64			 idx;
+	__u64			 cpu;
+	__u64			 tid;
+};
+
+struct id_index_event {
+	struct perf_event_header header;
+	__u64			 nr;
+	struct id_index_entry	 entries[0];
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 4b6cf89f31db..82315d2845fe 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -22,9 +22,11 @@
  */
 #define PRI_lu64 "l" PRIu64
 #define PRI_lx64 "l" PRIx64
+#define PRI_ld64 "l" PRId64
 #else
 #define PRI_lu64 PRIu64
 #define PRI_lx64 PRIx64
+#define PRI_ld64 PRId64
 #endif
 
 #define PERF_SAMPLE_MASK				\
@@ -330,19 +332,6 @@ struct events_stats {
 	u32 nr_proc_map_timeout;
 };
 
-struct id_index_entry {
-	u64 id;
-	u64 idx;
-	u64 cpu;
-	u64 tid;
-};
-
-struct id_index_event {
-	struct perf_event_header header;
-	u64 nr;
-	struct id_index_entry entries[0];
-};
-
 struct auxtrace_info_event {
 	struct perf_event_header header;
 	u32 type;
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 5786e9c807c5..daa8aed27eae 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2392,10 +2392,10 @@ int perf_event__process_id_index(struct perf_session *session,
 		struct perf_sample_id *sid;
 
 		if (dump_trace) {
-			fprintf(stdout,	" ... id: %"PRIu64, e->id);
-			fprintf(stdout,	"  idx: %"PRIu64, e->idx);
-			fprintf(stdout,	"  cpu: %"PRId64, e->cpu);
-			fprintf(stdout,	"  tid: %"PRId64"\n", e->tid);
+			fprintf(stdout,	" ... id: %"PRI_lu64, e->id);
+			fprintf(stdout,	"  idx: %"PRI_lu64, e->idx);
+			fprintf(stdout,	"  cpu: %"PRI_ld64, e->cpu);
+			fprintf(stdout,	"  tid: %"PRI_ld64"\n", e->tid);
 		}
 
 		sid = perf_evlist__id2sid(evlist, e->id);
-- 
2.21.0

