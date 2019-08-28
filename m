Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8615CC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D4F82339E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567000680;
	bh=juaq8aML1gweExQQzRMvyukg8/8Y3nYgBmJ4Y+x+IJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iVhucN9DZ5tjR7UxleIQk5GnVKadHAPS4D9CQmVaImMpY/CZZcFW95f5OhrxRyyYF
	 NY2bLacFSOLfdxmVQCe7BZTL7xuhSizmjU29L9foYQPWwPtwYGOcaomMqP70k4P2j5
	 CWEmpRTsAzvVxYnhui8o7aE1oLxno4XlYccnkjRY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfH1N57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:57:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45898 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbfH1N54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:57:56 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ECF3D796EB;
        Wed, 28 Aug 2019 13:57:55 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E51D01001B00;
        Wed, 28 Aug 2019 13:57:52 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 16/23] libperf: Add PERF_RECORD_STAT 'struct stat_event' to perf/event.h
Date:   Wed, 28 Aug 2019 15:57:10 +0200
Message-Id: <20190828135717.7245-17-jolsa@kernel.org>
In-Reply-To: <20190828135717.7245-1-jolsa@kernel.org>
References: <20190828135717.7245-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 28 Aug 2019 13:57:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the PERF_RECORD_STAT event definition to libperf's event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8'
types used events to their generic '__u*' versions.

Link: http://lkml.kernel.org/n/tip-80tqbm5o9hhyl924f8khd6tp@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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

