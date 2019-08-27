Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268B9C3A59F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED37421881
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566869872;
	bh=VIbygTkGO5NaDVOCEnKGKbq2AOnUvkc/fMe9AoW0zso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tFbJVbZCWlAUEyKCRnpubp6uegp5g3JzeME1LH5kAnEOc0d3EKMCdFyP/yvpcATT5
	 PoHNw0sGHhGggNBkqdsd+krZsJ4tsintpzoICAsOv+XcP1rEU+qH65VHXA6TBRO8Wg
	 URvP/41jm0zWMl/llCpFzfgj5LrH1H2eAHbQCpkw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbfH0Bhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 21:37:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:50978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729094AbfH0Bhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 21:37:47 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 831A62189D;
        Tue, 27 Aug 2019 01:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566869866;
        bh=VIbygTkGO5NaDVOCEnKGKbq2AOnUvkc/fMe9AoW0zso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WTg8bX2ZjLtt80fq3cLpLurJ7vztOVOrdDbl6hbz7c7Ok42of6YhWTdJ8fioKMD7a
         uNBF8wA0eieg6rU/2SX7UlaHOmT7YpDK7grqSnPZKb15V5gWiU42rnLT6k2G9tPpFW
         nZaBuYlfR//d5D2joiC1FYZlKgZEY+RNpspJ4xNA=
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
Subject: [PATCH 21/33] libperf: Add PERF_RECORD_FORK 'struct fork_event' to perf/event.h
Date:   Mon, 26 Aug 2019 22:36:22 -0300
Message-Id: <20190827013634.3173-22-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190827013634.3173-1-acme@kernel.org>
References: <20190827013634.3173-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move the fork_event event definition into libperf's event.h header
include.

In order to keep libperf simple, we switch 'u64/u32/u16/u8' types used
events to their generic '__u*' versions.

Perf added 'u*' types mainly to ease up printing __u64 values
as stated in the linux/types.h comment:

  /*
   * We define u64 as uint64_t for every architecture
   * so that we can print it with "%"PRIx64 without getting warnings.
   *
   * typedef __u64 u64;
   * typedef __s64 s64;
   */

Add and use new PRI_lu64 and PRI_lx64 macros for that.  Using extra '_'
to ease up the reading and differentiate them from standard PRI*64
macros.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190825181752.722-6-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 7 +++++++
 tools/perf/util/event.h             | 7 -------
 tools/perf/util/python.c            | 2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index b90a8a21e613..c7cae58d2535 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -43,4 +43,11 @@ struct namespaces_event {
 	struct perf_ns_link_info link_info[];
 };
 
+struct fork_event {
+	struct perf_event_header header;
+	__u32			 pid, ppid;
+	__u32			 tid, ptid;
+	__u64			 time;
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 0d3ac4fd3ecf..38b258cbbd90 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -27,13 +27,6 @@
 #define PRI_lx64 PRIx64
 #endif
 
-struct fork_event {
-	struct perf_event_header header;
-	u32 pid, ppid;
-	u32 tid, ptid;
-	u64 time;
-};
-
 struct lost_event {
 	struct perf_event_header header;
 	u64 id;
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 55ff0c3182d6..8bdadb24f6ba 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -170,7 +170,7 @@ static PyMemberDef pyrf_task_event__members[] = {
 static PyObject *pyrf_task_event__repr(struct pyrf_event *pevent)
 {
 	return _PyUnicode_FromFormat("{ type: %s, pid: %u, ppid: %u, tid: %u, "
-				   "ptid: %u, time: %" PRIu64 "}",
+				   "ptid: %u, time: %" PRI_lu64 "}",
 				   pevent->event.header.type == PERF_RECORD_FORK ? "fork" : "exit",
 				   pevent->event.fork.pid,
 				   pevent->event.fork.ppid,
-- 
2.21.0

