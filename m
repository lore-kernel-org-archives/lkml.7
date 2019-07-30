Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A59C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 263A52064A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Fd6/N3+e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729901AbfG3SfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:35:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52091 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfG3SfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:35:06 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UIYrYp3331187
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:34:54 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UIYrYp3331187
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564511694;
        bh=71BJRIeDOD8zMMqkymlqadd5jaWx+y1t5a2f9WJfDHc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Fd6/N3+euIJsIxUFQ49HmzAlseA+P0mAY39SOCSnAEJHcifppNBw67j/7AGGTaRxB
         pe/N/Ib0f4RABjWHvngsBzJEJJi9PAvgd2PSklE+u8CN4AabT5YUnjzCuUdXf/DOjx
         o1HZipn8MPBuLT/omAH56xuLIQY4Cnl5eRqyU06Cqo+BE55uzVzP6G3V4lGjIYjoDk
         lieqMlkk/BtnmRTOE95qw0/hb6Ji97V7nLEHCVZrAkAix58xzf0eGO+eQ1n/mOSzCx
         d8YFt4P+w8pjbMjqbrPTfNiby/qVdR+tcUV4r716BXwtB0AJ7PQ6axa4qrKWAea/ld
         NvXMtSsDHsZTg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UIYr0s3331184;
        Tue, 30 Jul 2019 11:34:53 -0700
Date:   Tue, 30 Jul 2019 11:34:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-b04c597af761ccfd32f40ee3629843b6f3674fce@git.kernel.org>
Cc:     mingo@kernel.org, mpetlan@redhat.com,
        alexey.budankov@linux.intel.com, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        hpa@zytor.com, ak@linux.intel.com, linux-kernel@vger.kernel.org,
        acme@redhat.com, peterz@infradead.org, namhyung@kernel.org
Reply-To: mingo@kernel.org, alexey.budankov@linux.intel.com,
          mpetlan@redhat.com, tglx@linutronix.de,
          alexander.shishkin@linux.intel.com, jolsa@kernel.org,
          hpa@zytor.com, ak@linux.intel.com, linux-kernel@vger.kernel.org,
          acme@redhat.com, peterz@infradead.org, namhyung@kernel.org
In-Reply-To: <20190721112506.12306-38-jolsa@kernel.org>
References: <20190721112506.12306-38-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] libperf: Add perf_evsel__init function
Git-Commit-ID: b04c597af761ccfd32f40ee3629843b6f3674fce
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

Commit-ID:  b04c597af761ccfd32f40ee3629843b6f3674fce
Gitweb:     https://git.kernel.org/tip/b04c597af761ccfd32f40ee3629843b6f3674fce
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:24:24 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:44 -0300

libperf: Add perf_evsel__init function

Add the perf_evsel__init() function to initialize perf_evsel struct.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-38-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evsel.c              | 5 +++++
 tools/perf/lib/include/perf/evsel.h | 4 ++++
 tools/perf/lib/libperf.map          | 1 +
 tools/perf/util/evsel.c             | 3 ++-
 4 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/perf/lib/evsel.c b/tools/perf/lib/evsel.c
index 12e86de1994b..9a87e867a7ec 100644
--- a/tools/perf/lib/evsel.c
+++ b/tools/perf/lib/evsel.c
@@ -2,3 +2,8 @@
 #include <perf/evsel.h>
 #include <linux/list.h>
 #include <internal/evsel.h>
+
+void perf_evsel__init(struct perf_evsel *evsel)
+{
+	INIT_LIST_HEAD(&evsel->node);
+}
diff --git a/tools/perf/lib/include/perf/evsel.h b/tools/perf/lib/include/perf/evsel.h
index 162bffd43409..b4d074a3684b 100644
--- a/tools/perf/lib/include/perf/evsel.h
+++ b/tools/perf/lib/include/perf/evsel.h
@@ -2,6 +2,10 @@
 #ifndef __LIBPERF_EVSEL_H
 #define __LIBPERF_EVSEL_H
 
+#include <perf/core.h>
+
 struct perf_evsel;
 
+LIBPERF_API void perf_evsel__init(struct perf_evsel *evsel);
+
 #endif /* __LIBPERF_EVSEL_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index c4f611010ccc..54f8503c6d82 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -9,6 +9,7 @@ LIBPERF_0.0.1 {
 		perf_thread_map__comm;
 		perf_thread_map__get;
 		perf_thread_map__put;
+		perf_evsel__init;
 	local:
 		*;
 };
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 8fed22d889a4..172bcc2e198f 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -22,6 +22,7 @@
 #include <sys/resource.h>
 #include <sys/types.h>
 #include <dirent.h>
+#include <perf/evsel.h>
 #include "asm/bug.h"
 #include "callchain.h"
 #include "cgroup.h"
@@ -226,6 +227,7 @@ bool perf_evsel__is_function_event(struct evsel *evsel)
 void evsel__init(struct evsel *evsel,
 		 struct perf_event_attr *attr, int idx)
 {
+	perf_evsel__init(&evsel->core);
 	evsel->idx	   = idx;
 	evsel->tracking	   = !idx;
 	evsel->attr	   = *attr;
@@ -236,7 +238,6 @@ void evsel__init(struct evsel *evsel,
 	evsel->evlist	   = NULL;
 	evsel->bpf_obj	   = NULL;
 	evsel->bpf_fd	   = -1;
-	INIT_LIST_HEAD(&evsel->core.node);
 	INIT_LIST_HEAD(&evsel->config_terms);
 	perf_evsel__object.init(evsel);
 	evsel->sample_size = __perf_evsel__sample_size(attr->sample_type);
