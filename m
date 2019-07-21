Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8505C76195
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B79C2085A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563708430;
	bh=VkikH2yeKu8rIsgQrpyOUbb4bwx+RMzCg4pW2OVRj/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uxMDw1/hZUpnCDeb2ymfQ0+BT8darDE/6IwYjTLBj6bVI1CSWG83swRDP1I3QHZxV
	 gS/K3uJ/7PjUuNEt/C0PzPJ2jmHDROKNlonjaqBBQwjHxiXg8G1JHX5scnB/XVI9LM
	 zHjl3/DgQ1cyA84F8XusIvteBMZwXM2ejeqATvT8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfGUL1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 07:27:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39514 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726405AbfGUL1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:27:08 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 142E8C057EC6;
        Sun, 21 Jul 2019 11:27:08 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2361C5D9D3;
        Sun, 21 Jul 2019 11:27:00 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 11/79] perf tools: Rename perf_evsel__new to evsel__new
Date:   Sun, 21 Jul 2019 13:23:58 +0200
Message-Id: <20190721112506.12306-12-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Sun, 21 Jul 2019 11:27:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renaming perf_evsel__new to evsel__new, so we don't
have a name clash when we add perf_evsel__new in libperf.

Link: http://lkml.kernel.org/n/tip-iej45vzu76gv69qaxod2p7gm@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-trace.c     | 2 +-
 tools/perf/tests/sw-clock.c    | 2 +-
 tools/perf/util/evsel.c        | 2 +-
 tools/perf/util/evsel.h        | 2 +-
 tools/perf/util/header.c       | 4 ++--
 tools/perf/util/parse-events.c | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 465a61e09b3a..9d27307069a1 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2669,7 +2669,7 @@ static struct evsel *perf_evsel__new_pgfault(u64 config)
 
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
index c91bb1fa0aa6..f3d8fdca53ae 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3576,7 +3576,7 @@ int perf_session__read_header(struct perf_session *session)
 		}
 
 		tmp = lseek(fd, 0, SEEK_CUR);
-		evsel = perf_evsel__new(&f_attr.attr);
+		evsel = evsel__new(&f_attr.attr);
 
 		if (evsel == NULL)
 			goto out_delete_evlist;
@@ -4014,7 +4014,7 @@ int perf_event__process_attr(struct perf_tool *tool __maybe_unused,
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

