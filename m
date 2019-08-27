Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECAFC3A59F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E29262080C
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566869896;
	bh=M0gOTArMUtApwHA0ZY65aMJFsM3Hs3HmmwarAHWVWfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LBB1QNXcqW2DWoEnFNmSzInlhV57pgwqG7w4cjvxqsbqn+dMqZw4FCIHluxBmQD1a
	 Px4IKGml+NFzn9/sEaYwjp82QSvcDUVVwuMyN7Lj4gblz9kLPNtd+zPe8t5uuQL9Pe
	 zEVV9Gtnz4l+Bb/AiMy+TkM6wNQlUfBFzgE7eVLQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbfH0BiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 21:38:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:51310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729246AbfH0BiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 21:38:09 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75C32217F5;
        Tue, 27 Aug 2019 01:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566869888;
        bh=M0gOTArMUtApwHA0ZY65aMJFsM3Hs3HmmwarAHWVWfs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D/AqCHxSvnu8/MsNcmXfuFkdEwbMizbQBocPjyaTplvnsD9kQOgan//TltKSwwl6T
         x6/ql8jyx6onBwxUv2GWt9yASxHNG1cNaQnwZeafZjpnYWiC3iuJzHnbswoBDtH70A
         NbtfaVemrf8yDnd7DjdLcuQOmEGTbH2AdGtlcP0g=
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
Subject: [PATCH 28/33] libperf: Add PERF_RECORD_SAMPLE 'struct sample_event' to perf/event.h
Date:   Mon, 26 Aug 2019 22:36:29 -0300
Message-Id: <20190827013634.3173-29-acme@kernel.org>
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
index 585c9d82dba3..e768a2dfbe53 100644
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
index 091a0690a280..dee0ee57efc2 100644
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
index ff415680fe0a..47bc54111f57 100644
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
index 9fadd5857ccc..778262f68d5c 100644
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
-- 
2.21.0

