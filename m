Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3A1C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 14:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D82E20661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 14:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfCFOBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 09:01:30 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48297 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfCFOBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 09:01:30 -0500
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1h1X6j-0002EM-6N; Wed, 06 Mar 2019 15:01:17 +0100
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        patchwork-lst@pengutronix.de
Subject: [RFC PATCH] perf: workaround unaligned NEON vector load
Date:   Wed,  6 Mar 2019 15:01:16 +0100
Message-Id: <20190306140116.23078-1-l.stach@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mmap event buffer may end up in a location that violates the
alignment requirements for a NEON vector load, which GCC generates to
load consecutive values from the event structure. Fix this by copying
the event structure into a properly aligned buffer.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 tools/perf/util/machine.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 143f7057d581..ab5500e85173 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1565,37 +1565,40 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
 }
 
 int machine__process_mmap2_event(struct machine *machine,
-				 union perf_event *event,
+				 union perf_event *event_in,
 				 struct perf_sample *sample)
 {
+	union perf_event event;
 	struct thread *thread;
 	struct map *map;
 	int ret = 0;
 
+	memcpy(&event, event_in, sizeof(union perf_event));
+
 	if (dump_trace)
-		perf_event__fprintf_mmap2(event, stdout);
+		perf_event__fprintf_mmap2(&event, stdout);
 
 	if (sample->cpumode == PERF_RECORD_MISC_GUEST_KERNEL ||
 	    sample->cpumode == PERF_RECORD_MISC_KERNEL) {
-		ret = machine__process_kernel_mmap_event(machine, event);
+		ret = machine__process_kernel_mmap_event(machine, &event);
 		if (ret < 0)
 			goto out_problem;
 		return 0;
 	}
 
-	thread = machine__findnew_thread(machine, event->mmap2.pid,
-					event->mmap2.tid);
+	thread = machine__findnew_thread(machine, event.mmap2.pid,
+					event.mmap2.tid);
 	if (thread == NULL)
 		goto out_problem;
 
-	map = map__new(machine, event->mmap2.start,
-			event->mmap2.len, event->mmap2.pgoff,
-			event->mmap2.maj,
-			event->mmap2.min, event->mmap2.ino,
-			event->mmap2.ino_generation,
-			event->mmap2.prot,
-			event->mmap2.flags,
-			event->mmap2.filename, thread);
+	map = map__new(machine, event.mmap2.start,
+			event.mmap2.len, event.mmap2.pgoff,
+			event.mmap2.maj,
+			event.mmap2.min, event.mmap2.ino,
+			event.mmap2.ino_generation,
+			event.mmap2.prot,
+			event.mmap2.flags,
+			event.mmap2.filename, thread);
 
 	if (map == NULL)
 		goto out_problem_map;
-- 
2.20.1

