Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C6AC3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19114233FF
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567089728;
	bh=eLaGrTGsgZaXe/OR0bfIYNLE9wDIHPmyaNZGgp83mcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SFniXRVFK1kDRKYQjCYb76Zx7hGNAeTxEAly9ubHhYC3PHR8lLiYuar0obhduLrnZ
	 IbuvBEd5TTpHGg68M448NBy601tpkvhhH0Z8MiaxMx6T/DQtTUf0Idr5st77y4jQG6
	 4z/fWNNVwE9zehA3CYTb87/wBdjMJJxgs+ShIStQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbfH2Okp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:40:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:44592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728653AbfH2Okn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:40:43 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C12522CED;
        Thu, 29 Aug 2019 14:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567089641;
        bh=eLaGrTGsgZaXe/OR0bfIYNLE9wDIHPmyaNZGgp83mcA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=icQxrucSAoeJKXacuim2VkDfOqDJ1W7qwMo+CPBBknoKez9RuR8vzfuHGUuecnBwi
         Vq1n1a1eQgWtTTidw/Tf2+9ifBxjoCEDw6gHfRXOWNUulvZVWGvjXD89sd1+Tr8RTA
         j5J5O6yPea3fZnBm9Zi0pY/JACm5pJqi9LScr1HY=
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
Subject: [PATCH 20/37] libperf: Add PERF_RECORD_AUXTRACE 'struct auxtrace_event' to perf/event.h
Date:   Thu, 29 Aug 2019 11:39:00 -0300
Message-Id: <20190829143917.29745-21-acme@kernel.org>
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

Move the PERF_RECORD_AUXTRACE event definition to libperf's event.h.

Ipn order to keep libperf simple, we switch 'u64/u32/u16/u8'
types used events to their generic '__u*' versions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190828135717.7245-10-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 11 +++++++++++
 tools/perf/util/auxtrace.c          |  2 +-
 tools/perf/util/event.h             | 11 -----------
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index 02da73491451..78001c2973b6 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -208,4 +208,15 @@ struct auxtrace_info_event {
 	__u64			 priv[];
 };
 
+struct auxtrace_event {
+	struct perf_event_header header;
+	__u64			 size;
+	__u64			 offset;
+	__u64			 reference;
+	__u32			 idx;
+	__u32			 tid;
+	__u32			 cpu;
+	__u32			 reserved__; /* For alignment */
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 112c24aa2cf2..5edec7123328 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -943,7 +943,7 @@ s64 perf_event__process_auxtrace(struct perf_session *session,
 	s64 err;
 
 	if (dump_trace)
-		fprintf(stdout, " size: %#"PRIx64"  offset: %#"PRIx64"  ref: %#"PRIx64"  idx: %u  tid: %d  cpu: %d\n",
+		fprintf(stdout, " size: %#"PRI_lx64"  offset: %#"PRI_lx64"  ref: %#"PRI_lx64"  idx: %u  tid: %d  cpu: %d\n",
 			event->auxtrace.size, event->auxtrace.offset,
 			event->auxtrace.reference, event->auxtrace.idx,
 			event->auxtrace.tid, event->auxtrace.cpu);
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index ca2cae332c43..60895a3b2c85 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -332,17 +332,6 @@ struct events_stats {
 	u32 nr_proc_map_timeout;
 };
 
-struct auxtrace_event {
-	struct perf_event_header header;
-	u64 size;
-	u64 offset;
-	u64 reference;
-	u32 idx;
-	u32 tid;
-	u32 cpu;
-	u32 reserved__; /* For alignment */
-};
-
 #define MAX_AUXTRACE_ERROR_MSG 64
 
 struct auxtrace_error_event {
-- 
2.21.0

