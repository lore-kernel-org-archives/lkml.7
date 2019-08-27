Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821F1C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 592392186A
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730057AbfH0I0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:26:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42796 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729824AbfH0I03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:26:29 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2Wo2-0007tL-CR; Tue, 27 Aug 2019 10:26:22 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id ABCFD1C0DE1;
        Tue, 27 Aug 2019 10:26:20 +0200 (CEST)
Date:   Tue, 27 Aug 2019 08:26:20 -0000
From:   tip-bot2 for Jiri Olsa <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] libperf: Add PERF_RECORD_LOST 'struct lost_event' to
 perf/event.h
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190825181752.722-7-jolsa@kernel.org>
References: <20190825181752.722-7-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <156689438055.24538.2709969380333836917.tip-bot2@tip-bot2>
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

Commit-ID:     5290ed6955ebc481d5cd62f7175e8514931058bc
Gitweb:        https://git.kernel.org/tip/5290ed6955ebc481d5cd62f7175e8514931058bc
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Sun, 25 Aug 2019 20:17:46 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 26 Aug 2019 19:39:09 -03:00

libperf: Add PERF_RECORD_LOST 'struct lost_event' to perf/event.h

Move the lost_event event definition to libperf's event.h header
include.

In order to keep libperf simple, we switch 'u64/u32/u16/u8' types used
events to their generic '__u*' versions.

Perf added 'u*' types mainly to ease up printing __u64 values as stated
in the linux/types.h comment:

  /*
   * We define u64 as uint64_t for every architecture
   * so that we can print it with "%"PRIx64 without getting warnings.
   *
   * typedef __u64 u64;
   * typedef __s64 s64;
   */

Add and use new PRI_lu64 and PRI_lx64 macros for that.  Use extra '_' to
ease up the reading and differentiate them from standard PRI*64 macros.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190825181752.722-7-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-sched.c          | 2 +-
 tools/perf/lib/include/perf/event.h | 6 ++++++
 tools/perf/util/event.c             | 2 +-
 tools/perf/util/event.h             | 6 ------
 tools/perf/util/machine.c           | 2 +-
 tools/perf/util/python.c            | 4 ++--
 6 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 0d6b4c3..025151d 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2643,7 +2643,7 @@ static int process_lost(struct perf_tool *tool __maybe_unused,
 
 	timestamp__scnprintf_usec(sample->time, tstr, sizeof(tstr));
 	printf("%15s ", tstr);
-	printf("lost %" PRIu64 " events on cpu %d\n", event->lost.lost, sample->cpu);
+	printf("lost %" PRI_lu64 " events on cpu %d\n", event->lost.lost, sample->cpu);
 
 	return 0;
 }
diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index c7cae58..71045ea 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -50,4 +50,10 @@ struct fork_event {
 	__u64			 time;
 };
 
+struct lost_event {
+	struct perf_event_header header;
+	__u64			 id;
+	__u64			 lost;
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 0954f98..3bd9fc2 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1480,7 +1480,7 @@ size_t perf_event__fprintf_switch(union perf_event *event, FILE *fp)
 
 static size_t perf_event__fprintf_lost(union perf_event *event, FILE *fp)
 {
-	return fprintf(fp, " lost %" PRIu64 "\n", event->lost.lost);
+	return fprintf(fp, " lost %" PRI_lu64 "\n", event->lost.lost);
 }
 
 size_t perf_event__fprintf_ksymbol(union perf_event *event, FILE *fp)
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 38b258c..4a3f502 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -27,12 +27,6 @@
 #define PRI_lx64 PRIx64
 #endif
 
-struct lost_event {
-	struct perf_event_header header;
-	u64 id;
-	u64 lost;
-};
-
 struct lost_samples_event {
 	struct perf_event_header header;
 	u64 lost;
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 47430af..1ad6e98 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -645,7 +645,7 @@ int machine__process_namespaces_event(struct machine *machine __maybe_unused,
 int machine__process_lost_event(struct machine *machine __maybe_unused,
 				union perf_event *event, struct perf_sample *sample __maybe_unused)
 {
-	dump_printf(": id:%" PRIu64 ": lost:%" PRIu64 "\n",
+	dump_printf(": id:%" PRI_lu64 ": lost:%" PRI_lu64 "\n",
 		    event->lost.id, event->lost.lost);
 	return 0;
 }
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 8bdadb2..5be85f5 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -263,8 +263,8 @@ static PyObject *pyrf_lost_event__repr(struct pyrf_event *pevent)
 	PyObject *ret;
 	char *s;
 
-	if (asprintf(&s, "{ type: lost, id: %#" PRIx64 ", "
-			 "lost: %#" PRIx64 " }",
+	if (asprintf(&s, "{ type: lost, id: %#" PRI_lx64 ", "
+			 "lost: %#" PRI_lx64 " }",
 		     pevent->event.lost.id, pevent->event.lost.lost) < 0) {
 		ret = PyErr_NoMemory();
 	} else {
