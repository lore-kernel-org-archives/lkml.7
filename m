Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6462BC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B58622CED
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567089661;
	bh=ZUCOidQvEUL9fzHDOCWtUKH/f3BPjM9SzcbeRWT+iKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a65UNRrX7lImlxOCEtT9C62sHvXKpBXRxHqn9bLjBC3cJNmscke/QHcAFCRelzse3
	 uhT4CNoYAsmljoGrB7bsAvzqE5z55vN/+mWY1d8DWeU3g/73CBV4v8D2n043Ks/4Wx
	 VPo07wTkQD9r6Xh1TMlC7bmbtao9EI0Icu3OjQWk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbfH2Ok7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:40:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:44794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728760AbfH2Ok5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:40:57 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21B092341C;
        Thu, 29 Aug 2019 14:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567089656;
        bh=ZUCOidQvEUL9fzHDOCWtUKH/f3BPjM9SzcbeRWT+iKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RMPLAVS4RFsjkA5On4w30tgSgKdNV2SrXH3rAZmtcc7TiMKiQcHkJpN+crf+ydscT
         pDH17tqyWvsXmuDoJ0N8VVoh/7JNZncrXDghZ3pgRznl5GcUWnbzmRs/mBcZeUWFr0
         DlRwnVcsU0F9tXykntbyB5YzP2iyMs4eN0WiDyuM=
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
Subject: [PATCH 25/37] libperf: Add PERF_RECORD_THREAD_MAP 'struct thread_map_event' to perf/event.h
Date:   Thu, 29 Aug 2019 11:39:05 -0300
Message-Id: <20190829143917.29745-26-acme@kernel.org>
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

Move the PERF_RECORD_THREAD_MAP event definition to libperf's event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8' types used
events to their generic '__u*' versions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190828135717.7245-15-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 11 +++++++++++
 tools/perf/util/event.h             | 11 -----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index a7b0344bb8b4..fe0ce655af17 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -253,4 +253,15 @@ struct itrace_start_event {
 	__u32			 tid;
 };
 
+struct thread_map_event_entry {
+	__u64			 pid;
+	char			 comm[16];
+};
+
+struct thread_map_event {
+	struct perf_event_header	 header;
+	__u64				 nr;
+	struct thread_map_event_entry	 entries[];
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 012b2ba9a9a8..3a856696c6b1 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -332,17 +332,6 @@ struct events_stats {
 	u32 nr_proc_map_timeout;
 };
 
-struct thread_map_event_entry {
-	u64	pid;
-	char	comm[16];
-};
-
-struct thread_map_event {
-	struct perf_event_header	header;
-	u64				nr;
-	struct thread_map_event_entry	entries[];
-};
-
 enum {
 	PERF_STAT_CONFIG_TERM__AGGR_MODE	= 0,
 	PERF_STAT_CONFIG_TERM__INTERVAL		= 1,
-- 
2.21.0

