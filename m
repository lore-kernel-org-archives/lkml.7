Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7079AC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4831B23405
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567000668;
	bh=FRo4tceVVbOfAsqL+x4ZcU/GVZ/D+De28iD+p1auhOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bDe7pMw4Y31cVTHbRsWNmBEMTSBiD50v3qbOQzhKO5sQZKj5X+1eDFmeIMcO7Okfi
	 28ubLWb+DL0WG7h4BG80VEtwTuVxoJ0eiYbtY5eQ81i+hUGsRM4M8TIrq3LqGbtAx+
	 rAeIaEk085dUifioOJVRAhJE/6/BeRed7PlHAC2k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfH1N5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:57:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:13415 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726901AbfH1N5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:57:41 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4612110F09;
        Wed, 28 Aug 2019 13:57:41 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 41B021001B09;
        Wed, 28 Aug 2019 13:57:38 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 10/23] libperf: Add PERF_RECORD_AUXTRACE_ERROR 'struct auxtrace_error_event' to perf/event.h
Date:   Wed, 28 Aug 2019 15:57:04 +0200
Message-Id: <20190828135717.7245-11-jolsa@kernel.org>
In-Reply-To: <20190828135717.7245-1-jolsa@kernel.org>
References: <20190828135717.7245-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 28 Aug 2019 13:57:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the PERF_RECORD_AUXTRACE_ERROR event definition to libperf's event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8'
types used events to their generic '__u*' versions.

Link: http://lkml.kernel.org/n/tip-2i1ggfthfst9ont7ulmejgwg@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/include/perf/event.h | 15 +++++++++++++++
 tools/perf/util/auxtrace.c          |  2 +-
 tools/perf/util/event.h             | 15 ---------------
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index 78001c2973b6..6292b7c41bac 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -219,4 +219,19 @@ struct auxtrace_event {
 	__u32			 reserved__; /* For alignment */
 };
 
+#define MAX_AUXTRACE_ERROR_MSG 64
+
+struct auxtrace_error_event {
+	struct perf_event_header header;
+	__u32			 type;
+	__u32			 code;
+	__u32			 cpu;
+	__u32			 pid;
+	__u32			 tid;
+	__u32			 fmt;
+	__u64			 ip;
+	__u64			 time;
+	char			 msg[MAX_AUXTRACE_ERROR_MSG];
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 0d2ba1397e47..cddf04c45a20 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1188,7 +1188,7 @@ size_t perf_event__fprintf_auxtrace_error(union perf_event *event, FILE *fp)
 	if (!e->fmt)
 		msg = (const char *)&e->time;
 
-	ret += fprintf(fp, " cpu %d pid %d tid %d ip %#"PRIx64" code %u: %s\n",
+	ret += fprintf(fp, " cpu %d pid %d tid %d ip %#"PRI_lx64" code %u: %s\n",
 		       e->cpu, e->pid, e->tid, e->ip, e->code, msg);
 	return ret;
 }
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 60895a3b2c85..e334ecbe50a0 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -332,21 +332,6 @@ struct events_stats {
 	u32 nr_proc_map_timeout;
 };
 
-#define MAX_AUXTRACE_ERROR_MSG 64
-
-struct auxtrace_error_event {
-	struct perf_event_header header;
-	u32 type;
-	u32 code;
-	u32 cpu;
-	u32 pid;
-	u32 tid;
-	u32 fmt;
-	u64 ip;
-	u64 time;
-	char msg[MAX_AUXTRACE_ERROR_MSG];
-};
-
 struct aux_event {
 	struct perf_event_header header;
 	u64	aux_offset;
-- 
2.21.0

