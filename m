Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3643C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86DE523428
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567089667;
	bh=YNmgMz4qCALTiLHY5RzNd+xYk1qMVLBHrCgymLwVjSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cPYWLFmGUVEigmbxGdkUidZC5W7KMpptYayRDf/TE4WFf3abfU3CpLQdzjmveuULl
	 LyA7hv3P9NW4hKpeUrbQ0ah6ziLthrn//fo95VUNHD6hAo8uWE8b2MZAQZ6Fsb5Jf7
	 NyjpS0SrQ59Be3cNmg6zWSm+aXcHSi/jDc9xTc1Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbfH2OlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:41:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:44922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728188AbfH2OlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:41:04 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C05420644;
        Thu, 29 Aug 2019 14:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567089662;
        bh=YNmgMz4qCALTiLHY5RzNd+xYk1qMVLBHrCgymLwVjSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jwb0hoTIz62QyN7Kd0CnFgMo07nlAHf1Dq8bk4awR7AOlKaHutWUZu+2DPtcVq8B5
         Lleph+nju7ni+j1wP4+szCw7sMazZhTca8jnw2ZCbZrXRP0jGON/QxjXRCcNIYgwCC
         FLOCLto3+7OeHdKSNI0j5nk8/hYdZQcdgmfVmbaw=
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
Subject: [PATCH 27/37] libperf: Add PERF_RECORD_STAT 'struct stat_event' to perf/event.h
Date:   Thu, 29 Aug 2019 11:39:07 -0300
Message-Id: <20190829143917.29745-28-acme@kernel.org>
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

Move the PERF_RECORD_STAT event definition to libperf's event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8' types used
events to their generic '__u*' versions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190828135717.7245-17-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 17 +++++++++++++++++
 tools/perf/util/event.h             | 17 -----------------
 tools/perf/util/stat.c              |  4 ++--
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index ba6ed243a31f..7d1834f558d6 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -282,4 +282,21 @@ struct stat_config_event {
 	struct stat_config_event_entry	 data[];
 };
 
+struct stat_event {
+	struct perf_event_header header;
+
+	__u64			 id;
+	__u32			 cpu;
+	__u32			 thread;
+
+	union {
+		struct {
+			__u64	 val;
+			__u64	 ena;
+			__u64	 run;
+		};
+		__u64		 values[3];
+	};
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 68531d08dcec..f3a02e01852a 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -332,23 +332,6 @@ struct events_stats {
 	u32 nr_proc_map_timeout;
 };
 
-struct stat_event {
-	struct perf_event_header	header;
-
-	u64	id;
-	u32	cpu;
-	u32	thread;
-
-	union {
-		struct {
-			u64 val;
-			u64 ena;
-			u64 run;
-		};
-		u64 values[3];
-	};
-};
-
 enum {
 	PERF_STAT_ROUND_TYPE__INTERVAL	= 0,
 	PERF_STAT_ROUND_TYPE__FINAL	= 1,
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index f985336b3a22..c0cd9f9bb0ea 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -405,9 +405,9 @@ size_t perf_event__fprintf_stat(union perf_event *event, FILE *fp)
 	struct stat_event *st = (struct stat_event *) event;
 	size_t ret;
 
-	ret  = fprintf(fp, "\n... id %" PRIu64 ", cpu %d, thread %d\n",
+	ret  = fprintf(fp, "\n... id %" PRI_lu64 ", cpu %d, thread %d\n",
 		       st->id, st->cpu, st->thread);
-	ret += fprintf(fp, "... value %" PRIu64 ", enabled %" PRIu64 ", running %" PRIu64 "\n",
+	ret += fprintf(fp, "... value %" PRI_lu64 ", enabled %" PRI_lu64 ", running %" PRI_lu64 "\n",
 		       st->val, st->ena, st->run);
 
 	return ret;
-- 
2.21.0

