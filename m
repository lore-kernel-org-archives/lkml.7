Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75E5C76195
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BC692147A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563708643;
	bh=MDO2GI/8GlbfAQsjh/pUGsSXp4kHM/AG4J5m97bPnUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a84kTUY7cIIbqk6LB8x+4teTdMALnh+XXU7U1uG+arxNtjp4fRrGEFMZuUWcXEtai
	 IZms58wukhwOBWTMZ19H6/u9zSdSDMeabGYrcbjJA4QUvibcgsj0yLl5d3EhhUfDa1
	 g7wxK+0vlNHYm6WwMS7zXuZUTRtLPUaLbVTfztJ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbfGULam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 07:30:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35528 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbfGULal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:30:41 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 010BF307D90E;
        Sun, 21 Jul 2019 11:30:41 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 057B15D9D3;
        Sun, 21 Jul 2019 11:30:36 +0000 (UTC)
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
Subject: [PATCH 47/79] libperf: Add perf_evlist__for_each_evsel macro
Date:   Sun, 21 Jul 2019 13:24:34 +0200
Message-Id: <20190721112506.12306-48-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Sun, 21 Jul 2019 11:30:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding perf_evlist__for_each_evsel macro to iterate
perf_evsel objects in evlist.

Adding perf_evlist__next function to do that.

Link: http://lkml.kernel.org/n/tip-usi0zxyxmai1ld94nrbum43i@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/evlist.c              | 20 ++++++++++++++++++++
 tools/perf/lib/include/perf/evlist.h |  7 +++++++
 tools/perf/lib/libperf.map           |  1 +
 3 files changed, 28 insertions(+)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 0517deb4cb1c..8c26ebf290f0 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -34,3 +34,23 @@ struct perf_evlist *perf_evlist__new(void)
 
 	return evlist;
 }
+
+struct perf_evsel*
+perf_evlist__next(struct perf_evlist *evlist, struct perf_evsel *prev)
+{
+	struct perf_evsel *next;
+
+	if (!prev) {
+		next = list_first_entry(&evlist->entries,
+					struct perf_evsel,
+					node);
+	} else {
+		next = list_next_entry(prev, node);
+	}
+
+	/* Empty list is noticed here so don't need checking on entry. */
+	if (&next->node == &evlist->entries)
+		return NULL;
+
+	return next;
+}
diff --git a/tools/perf/lib/include/perf/evlist.h b/tools/perf/lib/include/perf/evlist.h
index 7255a60869a1..5092b622935b 100644
--- a/tools/perf/lib/include/perf/evlist.h
+++ b/tools/perf/lib/include/perf/evlist.h
@@ -13,5 +13,12 @@ LIBPERF_API void perf_evlist__add(struct perf_evlist *evlist,
 LIBPERF_API void perf_evlist__remove(struct perf_evlist *evlist,
 				     struct perf_evsel *evsel);
 LIBPERF_API struct perf_evlist *perf_evlist__new(void);
+LIBPERF_API struct perf_evsel* perf_evlist__next(struct perf_evlist *evlist,
+						 struct perf_evsel *evsel);
+
+#define perf_evlist__for_each_evsel(evlist, pos)	\
+	for ((pos) = perf_evlist__next((evlist), NULL);	\
+	     (pos) != NULL;				\
+	     (pos) = perf_evlist__next((evlist), (pos)))
 
 #endif /* __LIBPERF_EVLIST_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index e3eac9b60726..c0968226f7b6 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -17,6 +17,7 @@ LIBPERF_0.0.1 {
 		perf_evlist__init;
 		perf_evlist__add;
 		perf_evlist__remove;
+		perf_evlist__next;
 	local:
 		*;
 };
-- 
2.21.0

