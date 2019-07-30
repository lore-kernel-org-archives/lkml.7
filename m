Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7AAC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31A2620578
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455629;
	bh=wocKGREWVWBKwkTkN4LM9HXvszSXVw05wSfU9re+BRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zB3ISZBTFu3aibrMlRLzrAVL8qtPGQ5Man5ZzEHhiT7mqOTsEhj5Pcg2SslQF4pyN
	 Oa1VsKs1vXm+Lv6Mr68XqOm70JLBX90OBeUTbqK7StGCExkCngGZ+CAS+KxAdffoqa
	 wtLFBIcXnXZIBePvrPJGCSf20LvSvEy+tYTY61CY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732404AbfG3DA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 23:00:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:49704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732383AbfG3DAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 23:00:23 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5051A216C8;
        Tue, 30 Jul 2019 03:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455622;
        bh=wocKGREWVWBKwkTkN4LM9HXvszSXVw05wSfU9re+BRE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UJLaJVNwBPk+j/KapS8DzetjRL3lty/mOQ7hYi0Vi8m1RfimVIlV+WcveVR+bayJ5
         cAI+gMsGs9h0zB2ynk9bGDVDhI4a6v09oDGf8DJYPUCenqyuLDQgc8w9CpM5XRV7Bw
         zYAOb8APhjmbOEbLBoXYQlQvJ8HbEHzB/9x1vZt8=
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
Subject: [PATCH 072/107] libperf: Add perf_evlist__new() function
Date:   Mon, 29 Jul 2019 23:55:35 -0300
Message-Id: <20190730025610.22603-73-acme@kernel.org>
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

Add perf_evlist__new() function to create and init a perf_evlist struct
dynamicaly.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-46-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evlist.c              | 11 +++++++++++
 tools/perf/lib/include/perf/evlist.h |  1 +
 tools/perf/lib/libperf.map           |  1 +
 3 files changed, 13 insertions(+)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 1b27fd2de9b9..0517deb4cb1c 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -3,6 +3,7 @@
 #include <linux/list.h>
 #include <internal/evlist.h>
 #include <internal/evsel.h>
+#include <linux/zalloc.h>
 
 void perf_evlist__init(struct perf_evlist *evlist)
 {
@@ -23,3 +24,13 @@ void perf_evlist__remove(struct perf_evlist *evlist,
 	list_del_init(&evsel->node);
 	evlist->nr_entries -= 1;
 }
+
+struct perf_evlist *perf_evlist__new(void)
+{
+	struct perf_evlist *evlist = zalloc(sizeof(*evlist));
+
+	if (evlist != NULL)
+		perf_evlist__init(evlist);
+
+	return evlist;
+}
diff --git a/tools/perf/lib/include/perf/evlist.h b/tools/perf/lib/include/perf/evlist.h
index e0c87995c6ff..7255a60869a1 100644
--- a/tools/perf/lib/include/perf/evlist.h
+++ b/tools/perf/lib/include/perf/evlist.h
@@ -12,5 +12,6 @@ LIBPERF_API void perf_evlist__add(struct perf_evlist *evlist,
 				  struct perf_evsel *evsel);
 LIBPERF_API void perf_evlist__remove(struct perf_evlist *evlist,
 				     struct perf_evsel *evsel);
+LIBPERF_API struct perf_evlist *perf_evlist__new(void);
 
 #endif /* __LIBPERF_EVLIST_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index e38473a8f32f..5e685d6c7a95 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -12,6 +12,7 @@ LIBPERF_0.0.1 {
 		perf_thread_map__get;
 		perf_thread_map__put;
 		perf_evsel__init;
+		perf_evlist__new;
 		perf_evlist__init;
 		perf_evlist__add;
 		perf_evlist__remove;
-- 
2.21.0

