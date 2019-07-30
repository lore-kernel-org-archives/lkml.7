Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DE4C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E2992070B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455507;
	bh=uMHVe1Jmz+IW5ImvG5mKrWBg9uL/REPtdf6JZNMJrBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nyR5dg/ifzDK09nzvUSK8tSu6ymZiWC1Kwyd2vBOdy2kuZpCw/xiNpimXRdyF6ff5
	 lyPQ/xoZxw/xavSc/s9Y+20i1KVCUWsE/q7HCATma5MMg86DdEtjTVDK8zsuSu//lv
	 M/ZzHeGQD8XUdtNIQKN21Ez4bhpZIPKyDFNQyqYc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731991AbfG3C60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 22:58:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:47794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731969AbfG3C6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 22:58:22 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5746421726;
        Tue, 30 Jul 2019 02:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455501;
        bh=uMHVe1Jmz+IW5ImvG5mKrWBg9uL/REPtdf6JZNMJrBo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GFjnXtXacpuW4IaDYurpfRhhVaH3oC5n2pR8rlhR+s/Di3AeevF+I/YNa0aA3zgqh
         8cHcpwna8/sY+Qz8aAuwwALBUwg6z2TFIONdCh057ZTuZJz7NXBgkVGCu0dSE1D1Bi
         m3yeo8qjHIwCDvDkkZckMJ5Z9HI4zlznjVqlvc0k=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 038/107] perf evsel: Rename perf_evsel__new() to evsel__new()
Date:   Mon, 29 Jul 2019 23:55:01 -0300
Message-Id: <20190730025610.22603-39-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Rename perf_evsel__new() to evsel__new(), so we don't have a name clash
when we add perf_evsel__new() in libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-12-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c     | 2 +-
 tools/perf/tests/sw-clock.c    | 2 +-
 tools/perf/util/evsel.c        | 2 +-
 tools/perf/util/evsel.h        | 2 +-
 tools/perf/util/header.c       | 4 ++--
 tools/perf/util/parse-events.c | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 0f7d1859a2d1..c5eb47f4e42e 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2657,7 +2657,7 @@ static struct evsel *perf_evsel__new_pgfault(u64 config)
 
 	event_attr_init(&attr);
 
-	evsel = perf_evsel__new(&attr);
+	evsel = evsel__new(&attr);
 	if (evsel)
 		evsel->handler = trace__pgfault;
 
diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-clock.c
index 1c7d8adb43d0..247d3734686e 100644
--- a/tools/perf/tests/sw-clock.c
+++ b/tools/perf/tests/sw-clock.c
@@ -49,7 +49,7 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 		return -1;
 	}
 
-	evsel = perf_evsel__new(&attr);
+	evsel = evsel__new(&attr);
 	if (evsel == NULL) {
 		pr_debug("perf_evsel__new\n");
 		goto out_delete_evlist;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index de379b63f1ce..c9723c2d57c9 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -301,7 +301,7 @@ struct evsel *perf_evsel__new_cycles(bool precise)
 	 * to kick in when we return and before perf_evsel__open() is called.
 	 */
 new_event:
-	evsel = perf_evsel__new(&attr);
+	evsel = evsel__new(&attr);
 	if (evsel == NULL)
 		goto out;
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 20b4e31b63a9..ecea51a918e0 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -219,7 +219,7 @@ int perf_evsel__object_config(size_t object_size,
 
 struct evsel *perf_evsel__new_idx(struct perf_event_attr *attr, int idx);
 
-static inline struct evsel *perf_evsel__new(struct perf_event_attr *attr)
+static inline struct evsel *evsel__new(struct perf_event_attr *attr)
 {
 	return perf_evsel__new_idx(attr, 0);
 }
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 29bbfd699226..7760ddc4bc18 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3583,7 +3583,7 @@ int perf_session__read_header(struct perf_session *session)
 		}
 
 		tmp = lseek(fd, 0, SEEK_CUR);
-		evsel = perf_evsel__new(&f_attr.attr);
+		evsel = evsel__new(&f_attr.attr);
 
 		if (evsel == NULL)
 			goto out_delete_evlist;
@@ -4021,7 +4021,7 @@ int perf_event__process_attr(struct perf_tool *tool __maybe_unused,
 			return -ENOMEM;
 	}
 
-	evsel = perf_evsel__new(&event->attr.attr);
+	evsel = evsel__new(&event->attr.attr);
 	if (evsel == NULL)
 		return -ENOMEM;
 
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index cc63367f6e45..40087cf74dd1 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2318,7 +2318,7 @@ static bool is_event_supported(u8 type, unsigned config)
 	if (tmap == NULL)
 		return false;
 
-	evsel = perf_evsel__new(&attr);
+	evsel = evsel__new(&attr);
 	if (evsel) {
 		open_return = perf_evsel__open(evsel, NULL, tmap);
 		ret = open_return >= 0;
-- 
2.21.0

