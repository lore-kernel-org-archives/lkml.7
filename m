Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93E1C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA094217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbfH0I0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:26:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42852 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729989AbfH0I0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:26:35 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2Wo5-0007sm-Rh; Tue, 27 Aug 2019 10:26:25 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2F4F31C0DE0;
        Tue, 27 Aug 2019 10:26:20 +0200 (CEST)
Date:   Tue, 27 Aug 2019 08:26:20 -0000
From:   tip-bot2 for Jiri Olsa <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] libperf: Add PERF_RECORD_FORK 'struct fork_event' to
 perf/event.h
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190825181752.722-6-jolsa@kernel.org>
References: <20190825181752.722-6-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <156689438007.24534.12659074587476165506.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     bceb59b1f28d1ca812d816fd8f33c72b1a8378fb
Gitweb:        https://git.kernel.org/tip/bceb59b1f28d1ca812d816fd8f33c72b1a8378fb
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Sun, 25 Aug 2019 20:17:45 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 26 Aug 2019 19:39:09 -03:00

libperf: Add PERF_RECORD_FORK 'struct fork_event' to perf/event.h

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
index b90a8a2..c7cae58 100644
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
index 0d3ac4f..38b258c 100644
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
index 55ff0c3..8bdadb2 100644
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
