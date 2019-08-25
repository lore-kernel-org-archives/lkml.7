Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68A4C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 18:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB097206E0
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 18:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566757122;
	bh=GXSu1A2U8m6T+951+h01StaHMUlhk3Pa8BuVjnAkY6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LpzzYDroelTs4rOq9GS+/Ynl1G4y0e896lGpiBrADXXTfwnCtESaXHqYKsYfUf6w9
	 6XtNsSycnUg8B4NT4J4a5lDajuPyLkBpIrllRYEBBl2ffLGw1aSuYXyJysbf0L7x5V
	 3tR1Xo4Cv+bMV8yHzsTb0eQ3VTOIerqf+9vdUw2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbfHYSSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 14:18:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:19574 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728897AbfHYSSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 14:18:13 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E99FD10F23E4;
        Sun, 25 Aug 2019 18:18:12 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-45.brq.redhat.com [10.40.204.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 480765D9C3;
        Sun, 25 Aug 2019 18:18:10 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 06/12] libperf: Add lost_event to perf/event.h
Date:   Sun, 25 Aug 2019 20:17:46 +0200
Message-Id: <20190825181752.722-7-jolsa@kernel.org>
In-Reply-To: <20190825181752.722-1-jolsa@kernel.org>
References: <20190825181752.722-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.66]); Sun, 25 Aug 2019 18:18:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving lost_event event definition into libperf's event.h
header include.

In order to keep libperf simple, we switch 'u64/u32/u16/u8'
types used events to their generic '__u*' versions.

Perf added 'u*' types mainly to ease up printing __u64 values
as stated in the linux/types.h comment:

  /*
   * We define u64 as uint64_t for every architecture
   * so that we can print it with "%"PRIx64 without getting warnings.
   *
   * typedef __u64 u64;
   * typedef __s64 s64;
   */

Adding and using new PRI_lu64 and PRI_lx64 macros to be used for
that.  Using extra '_' to ease up the reading and differentiate
them from standard PRI*64 macros.

Link: http://lkml.kernel.org/n/tip-ayq02ukxxsjmv3kcn2s4qxyt@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-sched.c          | 2 +-
 tools/perf/lib/include/perf/event.h | 6 ++++++
 tools/perf/util/event.c             | 2 +-
 tools/perf/util/event.h             | 6 ------
 tools/perf/util/machine.c           | 2 +-
 tools/perf/util/python.c            | 4 ++--
 6 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 0d6b4c3b1a51..025151dcb651 100644
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
index 7a34221abbba..6c25d0adbe6d 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -50,4 +50,10 @@ struct fork_event {
 	__u64 time;
 };
 
+struct lost_event {
+	struct perf_event_header header;
+	__u64 id;
+	__u64 lost;
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 0954f980574f..3bd9fc2a3ae8 100644
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
index 817f12643f11..cc9cc38f0bf7 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -16,12 +16,6 @@
 #define PRI_lu64 "l" PRIu64
 #define PRI_lx64 "l" PRIx64
 
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
index 5734460fc89e..f61349d1d0d4 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -642,7 +642,7 @@ int machine__process_namespaces_event(struct machine *machine __maybe_unused,
 int machine__process_lost_event(struct machine *machine __maybe_unused,
 				union perf_event *event, struct perf_sample *sample __maybe_unused)
 {
-	dump_printf(": id:%" PRIu64 ": lost:%" PRIu64 "\n",
+	dump_printf(": id:%" PRI_lu64 ": lost:%" PRI_lu64 "\n",
 		    event->lost.id, event->lost.lost);
 	return 0;
 }
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 8bdadb24f6ba..5be85f50cd1c 100644
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
-- 
2.21.0

