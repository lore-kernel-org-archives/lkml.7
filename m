Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A268C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2879C22CED
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567089689;
	bh=KnTtXJJ5ggWnxQtE06+W1hAOFL1HpxKZLczSinsq5vo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H5AnOeWYMrf+gpaftEk1gs6x8oVVRnD2SxQS4YFgna57QLTgzlHWNPteZBU2+yDBF
	 Ghed+m0tblre1JQ75YG27niZ78BQN2rzJbnwN3zl2de8PYoaQmqEhbf6CC2+FHcnb0
	 GNoj+9Ntf8k6oglsNiID8a8W9wSlRToZ7GzAf51U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbfH2Ol2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:41:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:45450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727635AbfH2Ol0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:41:26 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3C6D2342A;
        Thu, 29 Aug 2019 14:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567089685;
        bh=KnTtXJJ5ggWnxQtE06+W1hAOFL1HpxKZLczSinsq5vo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KfRWy6JAv4uC9iDFBzTbARX6Wp5SkKa1GHZhR0G0swKM+4PwS3UqRQdv2Ik91OIL9
         BdbLwEYliiN7DyIgyLt5wRgY8Qqp5rCcwcfx6M80pmAxvizkYl2zllC+6CNpy+mInH
         zsSAybA93p3xJGFfvJfl6Z7jJa0Tn7OWegAyHSnI=
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
Subject: [PATCH 34/37] libperf: Move 'enum perf_user_event_type' to perf/event.h
Date:   Thu, 29 Aug 2019 11:39:14 -0300
Message-Id: <20190829143917.29745-35-acme@kernel.org>
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

So it's available for libperf's users.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190828135717.7245-24-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 23 +++++++++++++++++++++++
 tools/perf/util/event.h             | 23 -----------------------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index 1655c744ec2b..18106899cb4e 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -323,6 +323,29 @@ struct perf_record_compressed {
 	char			 data[];
 };
 
+enum perf_user_event_type { /* above any possible kernel type */
+	PERF_RECORD_USER_TYPE_START		= 64,
+	PERF_RECORD_HEADER_ATTR			= 64,
+	PERF_RECORD_HEADER_EVENT_TYPE		= 65, /* deprecated */
+	PERF_RECORD_HEADER_TRACING_DATA		= 66,
+	PERF_RECORD_HEADER_BUILD_ID		= 67,
+	PERF_RECORD_FINISHED_ROUND		= 68,
+	PERF_RECORD_ID_INDEX			= 69,
+	PERF_RECORD_AUXTRACE_INFO		= 70,
+	PERF_RECORD_AUXTRACE			= 71,
+	PERF_RECORD_AUXTRACE_ERROR		= 72,
+	PERF_RECORD_THREAD_MAP			= 73,
+	PERF_RECORD_CPU_MAP			= 74,
+	PERF_RECORD_STAT_CONFIG			= 75,
+	PERF_RECORD_STAT			= 76,
+	PERF_RECORD_STAT_ROUND			= 77,
+	PERF_RECORD_EVENT_UPDATE		= 78,
+	PERF_RECORD_TIME_CONV			= 79,
+	PERF_RECORD_HEADER_FEATURE		= 80,
+	PERF_RECORD_COMPRESSED			= 81,
+	PERF_RECORD_HEADER_MAX
+};
+
 union perf_event {
 	struct perf_event_header		header;
 	struct perf_record_mmap			mmap;
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index a7341e14eb48..4c0c5232bd41 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -146,29 +146,6 @@ struct perf_sample {
 	 PERF_MEM_S(LOCK, NA) |\
 	 PERF_MEM_S(TLB, NA))
 
-enum perf_user_event_type { /* above any possible kernel type */
-	PERF_RECORD_USER_TYPE_START		= 64,
-	PERF_RECORD_HEADER_ATTR			= 64,
-	PERF_RECORD_HEADER_EVENT_TYPE		= 65, /* deprecated */
-	PERF_RECORD_HEADER_TRACING_DATA		= 66,
-	PERF_RECORD_HEADER_BUILD_ID		= 67,
-	PERF_RECORD_FINISHED_ROUND		= 68,
-	PERF_RECORD_ID_INDEX			= 69,
-	PERF_RECORD_AUXTRACE_INFO		= 70,
-	PERF_RECORD_AUXTRACE			= 71,
-	PERF_RECORD_AUXTRACE_ERROR		= 72,
-	PERF_RECORD_THREAD_MAP			= 73,
-	PERF_RECORD_CPU_MAP			= 74,
-	PERF_RECORD_STAT_CONFIG			= 75,
-	PERF_RECORD_STAT			= 76,
-	PERF_RECORD_STAT_ROUND			= 77,
-	PERF_RECORD_EVENT_UPDATE		= 78,
-	PERF_RECORD_TIME_CONV			= 79,
-	PERF_RECORD_HEADER_FEATURE		= 80,
-	PERF_RECORD_COMPRESSED			= 81,
-	PERF_RECORD_HEADER_MAX
-};
-
 enum auxtrace_error_type {
 	PERF_AUXTRACE_ERROR_ITRACE  = 1,
 	PERF_AUXTRACE_ERROR_MAX
-- 
2.21.0

