Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4603EC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 134E122CED
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567089736;
	bh=o/Yipsn26yLMFmsAkKDZzHA0SeiDOdQdRoESWavlBKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EEH5vY3qVmqC1A9nzZdAmaENJZOtlqHYdObg9jrU6jzJV/30FeZyd+9gj9ZPJx3lC
	 J03Sk8hknsEZPt8eaMCYD8pIG3Zw4PK9wXMVn8HZAapimLowv+6VV+5HtMpg9/RvxQ
	 sO3qmHS07wsANBsJa+xQCJlP45VHPurx+lyfNUpw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbfH2OmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:42:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728623AbfH2Okh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:40:37 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A482D23429;
        Thu, 29 Aug 2019 14:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567089636;
        bh=o/Yipsn26yLMFmsAkKDZzHA0SeiDOdQdRoESWavlBKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hxg3+dvVwVLnZcHQRQAq4BAxckHF2WhQKRT/sqoRQQTwH4revou3JWK7NTPaypPVj
         2Q9Qew8Dv4GIGigBOcA8Ges12QdFNWeLwlMiwcJvRtvLKPLZ3rAAZHSsy82WqoKIP/
         yPcDu+XS0p9HzwAjbUMJFAx3dbPKWMapBOQmcUzk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 18/37] libperf: Add PERF_RECORD_ID_INDEX 'struct id_index_event' to perf/event.h
Date:   Thu, 29 Aug 2019 11:38:58 -0300
Message-Id: <20190829143917.29745-19-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190829143917.29745-1-acme@kernel.org>
References: <20190829143917.29745-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move the PERF_RECORD_ID_INDEX event definition to libperf's event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8' types used
events to their generic '__u*' versions.

Add the PRI_ld64 define, so we can use it in printf output.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190828135717.7245-8-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
index a275f2e15b94..aa9667424c1c 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2393,10 +2393,10 @@ int perf_event__process_id_index(struct perf_session *session,
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

