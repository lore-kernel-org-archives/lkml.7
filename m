Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064FECA9ECF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 10:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C426121928
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 10:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388193AbfKEKCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 05:02:03 -0500
Received: from mga03.intel.com ([134.134.136.65]:22746 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730699AbfKEKCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 05:02:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2019 02:02:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,270,1569308400"; 
   d="scan'208";a="227047022"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.197])
  by fmsmga004.fm.intel.com with ESMTP; 05 Nov 2019 02:01:57 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] perf inject: Make --strip keep evsels
Date:   Tue,  5 Nov 2019 12:00:57 +0200
Message-Id: <20191105100057.21465-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

create_gcov (refer to the autofdo example in
tools/perf/Documentation/intel-pt.txt) now needs the evsels to read the
perf.data file. So don't strip them.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-inject.c | 54 -------------------------------------
 1 file changed, 54 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 372ecb3e2c06..1e5d28311e14 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -578,58 +578,6 @@ static void strip_init(struct perf_inject *inject)
 		evsel->handler = drop_sample;
 }
 
-static bool has_tracking(struct evsel *evsel)
-{
-	return evsel->core.attr.mmap || evsel->core.attr.mmap2 || evsel->core.attr.comm ||
-	       evsel->core.attr.task;
-}
-
-#define COMPAT_MASK (PERF_SAMPLE_ID | PERF_SAMPLE_TID | PERF_SAMPLE_TIME | \
-		     PERF_SAMPLE_ID | PERF_SAMPLE_CPU | PERF_SAMPLE_IDENTIFIER)
-
-/*
- * In order that the perf.data file is parsable, tracking events like MMAP need
- * their selected event to exist, except if there is only 1 selected event left
- * and it has a compatible sample type.
- */
-static bool ok_to_remove(struct evlist *evlist,
-			 struct evsel *evsel_to_remove)
-{
-	struct evsel *evsel;
-	int cnt = 0;
-	bool ok = false;
-
-	if (!has_tracking(evsel_to_remove))
-		return true;
-
-	evlist__for_each_entry(evlist, evsel) {
-		if (evsel->handler != drop_sample) {
-			cnt += 1;
-			if ((evsel->core.attr.sample_type & COMPAT_MASK) ==
-			    (evsel_to_remove->core.attr.sample_type & COMPAT_MASK))
-				ok = true;
-		}
-	}
-
-	return ok && cnt == 1;
-}
-
-static void strip_fini(struct perf_inject *inject)
-{
-	struct evlist *evlist = inject->session->evlist;
-	struct evsel *evsel, *tmp;
-
-	/* Remove non-synthesized evsels if possible */
-	evlist__for_each_entry_safe(evlist, tmp, evsel) {
-		if (evsel->handler == drop_sample &&
-		    ok_to_remove(evlist, evsel)) {
-			pr_debug("Deleting %s\n", perf_evsel__name(evsel));
-			evlist__remove(evlist, evsel);
-			evsel__delete(evsel);
-		}
-	}
-}
-
 static int __cmd_inject(struct perf_inject *inject)
 {
 	int ret = -EINVAL;
@@ -729,8 +677,6 @@ static int __cmd_inject(struct perf_inject *inject)
 				evlist__remove(session->evlist, evsel);
 				evsel__delete(evsel);
 			}
-			if (inject->strip)
-				strip_fini(inject);
 		}
 		session->header.data_offset = output_data_offset;
 		session->header.data_size = inject->bytes_written;
-- 
2.17.1

