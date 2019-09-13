Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D62C4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80388206A5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381117;
	bh=cHxa1Vtv5KDcEMYhBY8FgzLuSGFaR0gH1+/rypjIwfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wOrZL4ci2YCzoT90Vzxhh6ac8R8bqLyh9czh4O061jM03tqpm4RrrhSzeevtMo6it
	 wOvMkmVgDJ//cYidgWvlWioBM4PpX7INEIKlVa4GMf2OxWA53aGbZFkeyI6Ky8iEEP
	 Bvyp2AB22TEl6859ww/8jV3yyrbRGgL2+iQLDFD8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391322AbfIMNZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:25:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37342 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391311AbfIMNZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:25:13 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A4AE911A27;
        Fri, 13 Sep 2019 13:25:12 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0BDEB5C219;
        Fri, 13 Sep 2019 13:25:10 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 29/73] libperf: Add perf_evlist__read_format function
Date:   Fri, 13 Sep 2019 15:23:11 +0200
Message-Id: <20190913132355.21634-30-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 13 Sep 2019 13:25:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding perf_evlist__read_format function to libperf
as internal function.

Link: http://lkml.kernel.org/n/tip-2gky29czqxqtl37cj5q349t7@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/evlist.c                  | 7 +++++++
 tools/perf/lib/include/internal/evlist.h | 2 ++
 tools/perf/util/evlist.c                 | 8 +-------
 tools/perf/util/evlist.h                 | 1 -
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 2bdd9d2c79d9..ae861bf38976 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -161,3 +161,10 @@ void perf_evlist__disable(struct perf_evlist *evlist)
 	perf_evlist__for_each_entry(evlist, evsel)
 		perf_evsel__disable(evsel);
 }
+
+u64 perf_evlist__read_format(struct perf_evlist *evlist)
+{
+	struct perf_evsel *first = perf_evlist__first(evlist);
+
+	return first->attr.read_format;
+}
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index 16ae6d6cfb39..63516fe14f4c 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -66,4 +66,6 @@ static inline struct perf_evsel *perf_evlist__last(struct perf_evlist *evlist)
 	return list_entry(evlist->entries.prev, struct perf_evsel, node);
 }
 
+u64 perf_evlist__read_format(struct perf_evlist *evlist);
+
 #endif /* __LIBPERF_INTERNAL_EVLIST_H */
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index a57e2f9c6e6d..de1dc73d1fe4 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -502,7 +502,7 @@ int perf_evlist__id_add_fd(struct evlist *evlist,
 	 * This way does not work with group format read, so bail
 	 * out in that case.
 	 */
-	if (perf_evlist__read_format(evlist) & PERF_FORMAT_GROUP)
+	if (perf_evlist__read_format(&evlist->core) & PERF_FORMAT_GROUP)
 		return -1;
 
 	if (!(evsel->core.attr.read_format & PERF_FORMAT_ID) ||
@@ -1239,12 +1239,6 @@ bool perf_evlist__valid_read_format(struct evlist *evlist)
 	return true;
 }
 
-u64 perf_evlist__read_format(struct evlist *evlist)
-{
-	struct evsel *first = evlist__first(evlist);
-	return first->core.attr.read_format;
-}
-
 u16 perf_evlist__id_hdr_size(struct evlist *evlist)
 {
 	struct evsel *first = evlist__first(evlist);
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 88890e6a3ac7..f0212738bed6 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -189,7 +189,6 @@ int perf_evlist__apply_filters(struct evlist *evlist, struct evsel **err_evsel);
 void __perf_evlist__set_leader(struct list_head *list);
 void perf_evlist__set_leader(struct evlist *evlist);
 
-u64 perf_evlist__read_format(struct evlist *evlist);
 u64 __perf_evlist__combined_sample_type(struct evlist *evlist);
 u64 perf_evlist__combined_sample_type(struct evlist *evlist);
 u64 perf_evlist__combined_branch_type(struct evlist *evlist);
-- 
2.21.0

