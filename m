Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7930CC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 509EE22CED
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567089631;
	bh=Lwz8TtcV4awjo4jSJ4avew1yIUynfNAmNOPSoRSD89I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NHVNtbvdjFlrJgUJ9Clxqzy/6z0xrEeD4zw7dAV656ICzBWoiG4ovf+UgiHlMecr1
	 Un+KDfc7H/f4WaWkDdItSWTcVHDw2UJcdDIcxzNzx78BURycxNtwmlavyFQus7PODz
	 tSnh3DEkW25G1H5eXo/QZ5mPOTd/lVEfYcg5RYoo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbfH2Oka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:40:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:44220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728555AbfH2Ok2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:40:28 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5FD223407;
        Thu, 29 Aug 2019 14:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567089627;
        bh=Lwz8TtcV4awjo4jSJ4avew1yIUynfNAmNOPSoRSD89I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hRfRbXgdKDta6wzsp8sD9BfT8mHNT6IymmXZG/Lu3SBMeUZeqppmG3qT0tBkd6cw9
         rdjj0Yw6D1z0MmBMFG50wuQFHbXawiq3tsAehl1tYCKCj7PZd4aROpGSO2zJdPMNaX
         2Kw126Qpb2zFStm9GAFU+HlHuYe17h+KCdsA3XZs=
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
Subject: [PATCH 15/37] libperf: Add PERF_RECORD_HEADER_EVENT_TYPE 'struct event_type_event' to perf/event.h
Date:   Thu, 29 Aug 2019 11:38:55 -0300
Message-Id: <20190829143917.29745-16-acme@kernel.org>
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

Move the PERF_RECORD_HEADER_EVENT_TYPE event definition to libperf's event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8'
types used events to their generic '__u*' versions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190828135717.7245-5-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 12 ++++++++++++
 tools/perf/util/event.h             | 12 ------------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index 3d99818077d8..ecd1536a3a0c 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -163,4 +163,16 @@ struct event_update_event {
 	char			 data[];
 };
 
+#define MAX_EVENT_NAME 64
+
+struct perf_trace_event_type {
+	__u64			 event_id;
+	char			 name[MAX_EVENT_NAME];
+};
+
+struct event_type_event {
+	struct perf_event_header	 header;
+	struct perf_trace_event_type	 event_type;
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index a579e6b439d6..00725a1b602b 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -337,18 +337,6 @@ struct events_stats {
 	u32 nr_proc_map_timeout;
 };
 
-#define MAX_EVENT_NAME 64
-
-struct perf_trace_event_type {
-	u64	event_id;
-	char	name[MAX_EVENT_NAME];
-};
-
-struct event_type_event {
-	struct perf_event_header header;
-	struct perf_trace_event_type event_type;
-};
-
 struct tracing_data_event {
 	struct perf_event_header header;
 	u32 size;
-- 
2.21.0

