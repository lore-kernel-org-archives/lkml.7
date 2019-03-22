Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E2FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C65EF2190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbfCVWGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:06:51 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50279 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbfCVWGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:06:50 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MM6ZYQ747817
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:06:35 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MM6Ykw747814;
        Fri, 22 Mar 2019 15:06:34 -0700
Date:   Fri, 22 Mar 2019 15:06:34 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-e51f806198306a8ad7ae6e34d1af0716ef73da80@git.kernel.org>
Cc:     peterz@infradead.org, tglx@linutronix.de, hpa@zytor.com,
        alexey.budankov@linux.intel.com, adrian.hunter@intel.com,
        jolsa@kernel.org, mingo@kernel.org,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        eranian@google.com, namhyung@kernel.org, ak@linux.intel.com,
        acme@redhat.com
Reply-To: hpa@zytor.com, tglx@linutronix.de, peterz@infradead.org,
          mingo@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
          alexey.budankov@linux.intel.com, eranian@google.com,
          linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
          acme@redhat.com, ak@linux.intel.com, namhyung@kernel.org
In-Reply-To: <20190308134745.5057-7-jolsa@kernel.org>
References: <20190308134745.5057-7-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf session: Add process callback to reader
 object
Git-Commit-ID: e51f806198306a8ad7ae6e34d1af0716ef73da80
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  e51f806198306a8ad7ae6e34d1af0716ef73da80
Gitweb:     https://git.kernel.org/tip/e51f806198306a8ad7ae6e34d1af0716ef73da80
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Fri, 8 Mar 2019 14:47:40 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 11 Mar 2019 11:56:03 -0300

perf session: Add process callback to reader object

Adding callback function to reader object so callers can process data in
different ways.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190308134745.5057-7-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index de777bdc0ed3..0ec34227bd60 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1847,10 +1847,17 @@ fetch_mmaped_event(struct perf_session *session,
 #define NUM_MMAPS 128
 #endif
 
+struct reader;
+
+typedef s64 (*reader_cb_t)(struct perf_session *session,
+			   union perf_event *event,
+			   u64 file_offset);
+
 struct reader {
-	int	fd;
-	u64	data_size;
-	u64	data_offset;
+	int		 fd;
+	u64		 data_size;
+	u64		 data_offset;
+	reader_cb_t	 process;
 };
 
 static int
@@ -1921,7 +1928,7 @@ more:
 	size = event->header.size;
 
 	if (size < sizeof(struct perf_event_header) ||
-	    (skip = perf_session__process_event(session, event, file_pos)) < 0) {
+	    (skip = rd->process(session, event, file_pos)) < 0) {
 		pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
 		       file_offset + head, event->header.size,
 		       event->header.type);
@@ -1947,12 +1954,20 @@ out:
 	return err;
 }
 
+static s64 process_simple(struct perf_session *session,
+			  union perf_event *event,
+			  u64 file_offset)
+{
+	return perf_session__process_event(session, event, file_offset);
+}
+
 static int __perf_session__process_events(struct perf_session *session)
 {
 	struct reader rd = {
 		.fd		= perf_data__fd(session->data),
 		.data_size	= session->header.data_size,
 		.data_offset	= session->header.data_offset,
+		.process	= process_simple,
 	};
 	struct ordered_events *oe = &session->ordered_events;
 	struct perf_tool *tool = session->tool;
