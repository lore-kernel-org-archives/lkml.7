Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17543C3A5A6
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7ADB2184D
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbfH0I07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:26:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42869 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730117AbfH0I0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:26:39 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2WoB-0007wt-6Z; Tue, 27 Aug 2019 10:26:31 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8EB251C07DC;
        Tue, 27 Aug 2019 10:26:23 +0200 (CEST)
Date:   Tue, 27 Aug 2019 08:26:23 -0000
From:   tip-bot2 for Jiri Olsa <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] libperf: Add PERF_RECORD_SAMPLE 'struct
 sample_event' to perf/event.h
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190825181752.722-13-jolsa@kernel.org>
References: <20190825181752.722-13-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <156689438344.24556.1687215100185726976.tip-bot2@tip-bot2>
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

Commit-ID:     b1fcd190bb3fc1234dca60390d171a4cc75b21b2
Gitweb:        https://git.kernel.org/tip/b1fcd190bb3fc1234dca60390d171a4cc75b21b2
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Sun, 25 Aug 2019 20:17:52 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 26 Aug 2019 19:39:10 -03:00

libperf: Add PERF_RECORD_SAMPLE 'struct sample_event' to perf/event.h

Move the PERF_RECORD_SAMPLE event definition to libperf's event.h header
include.

In order to keep libperf simple, we switch 'u64/u32/u16/u8' types used
events to their generic '__u*' versions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190825181752.722-13-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 5 +++++
 tools/perf/util/event.h             | 5 -----
 tools/perf/util/evlist.c            | 2 +-
 tools/perf/util/evsel.c             | 8 ++++----
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index 585c9d8..e768a2d 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -104,4 +104,9 @@ struct bpf_event {
 	__u8			 tag[BPF_TAG_SIZE];  // prog tag
 };
 
+struct sample_event {
+	struct perf_event_header header;
+	__u64			 array[];
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 091a069..dee0ee5 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -37,11 +37,6 @@
 /* perf sample has 16 bits size limit */
 #define PERF_SAMPLE_MAX_SIZE (1 << 16)
 
-struct sample_event {
-	struct perf_event_header        header;
-	u64 array[];
-};
-
 struct regs_dump {
 	u64 abi;
 	u64 mask;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index ff41568..47bc541 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -587,7 +587,7 @@ struct evsel *perf_evlist__id2evsel_strict(struct evlist *evlist,
 static int perf_evlist__event2id(struct evlist *evlist,
 				 union perf_event *event, u64 *id)
 {
-	const u64 *array = event->sample.array;
+	const __u64 *array = event->sample.array;
 	ssize_t n;
 
 	n = (event->header.size - sizeof(event->header)) >> 3;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 9fadd58..778262f 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2009,7 +2009,7 @@ static int perf_evsel__parse_id_sample(const struct evsel *evsel,
 				       struct perf_sample *sample)
 {
 	u64 type = evsel->core.attr.sample_type;
-	const u64 *array = event->sample.array;
+	const __u64 *array = event->sample.array;
 	bool swapped = evsel->needs_swap;
 	union u64_swap u;
 
@@ -2099,7 +2099,7 @@ int perf_evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 {
 	u64 type = evsel->core.attr.sample_type;
 	bool swapped = evsel->needs_swap;
-	const u64 *array;
+	const __u64 *array;
 	u16 max_size = event->header.size;
 	const void *endp = (void *)event + max_size;
 	u64 sz;
@@ -2378,7 +2378,7 @@ int perf_evsel__parse_sample_timestamp(struct evsel *evsel,
 				       u64 *timestamp)
 {
 	u64 type = evsel->core.attr.sample_type;
-	const u64 *array;
+	const __u64 *array;
 
 	if (!(type & PERF_SAMPLE_TIME))
 		return -1;
@@ -2529,7 +2529,7 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type,
 				  u64 read_format,
 				  const struct perf_sample *sample)
 {
-	u64 *array;
+	__u64 *array;
 	size_t sz;
 	/*
 	 * used for cross-endian analysis. See git commit 65014ab3
