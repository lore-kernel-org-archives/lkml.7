Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD66C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F225923407
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567089649;
	bh=bf3B1ulwxFQIerLflS3Q+tRdvSzqx+XmCNO/BVtahZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Yppfk4522p3kTtKiw+3PDpn5jNGEjRwh6x61EBjasbo3FPeMlNjtxt2Ko2miqvefj
	 s4859wVFoFAg2xBe6lt1od/FnKztG/BuSsdfLTFqwKVCEpddzox4+JsjmwBlHD/BLG
	 WYPUzK+3qFfMHQ7Q/XuWTOXRpd53J7a8ijyEUiCE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbfH2Oks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:40:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:44614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728668AbfH2Okq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:40:46 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6833723403;
        Thu, 29 Aug 2019 14:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567089644;
        bh=bf3B1ulwxFQIerLflS3Q+tRdvSzqx+XmCNO/BVtahZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r7FJ8Wok5fSoTrUwvQb0pd/PqtFQeNGUylh+A4c2/J8+dOyULGqWqRmB858r3FlOX
         8Y8Wx8wv2R9OkYdDZIiyvAoID6/Akn73i9yt7J8jv/vo37iURobHRNYoshLoL/DHlv
         or7svZtEi01QN+1bX4g8ba+0MDGuszXtIAXsuypY=
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
Subject: [PATCH 21/37] libperf: Add PERF_RECORD_AUXTRACE_ERROR 'struct auxtrace_error_event' to perf/event.h
Date:   Thu, 29 Aug 2019 11:39:01 -0300
Message-Id: <20190829143917.29745-22-acme@kernel.org>
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

Move the PERF_RECORD_AUXTRACE_ERROR event definition to libperf's
event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8' types used
events to their generic '__u*' versions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190828135717.7245-11-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
index 5edec7123328..c3da8a0e66b2 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1189,7 +1189,7 @@ size_t perf_event__fprintf_auxtrace_error(union perf_event *event, FILE *fp)
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

