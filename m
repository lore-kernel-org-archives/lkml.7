Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBC7C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 205E220693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="zkF2J58s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729975AbfG3Shj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:37:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53785 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfG3Shj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:37:39 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UIaSk83331622
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:36:28 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UIaSk83331622
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564511788;
        bh=bLje3VanhU+Dzk38KDoi83r8huN6l0y6UjtRHV8ZWHw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=zkF2J58srw9YZ0qR7a8jNAutBiP9q37Z/xQpqr1UcS6azxOkQ8eV9/LQ4CwFHCInA
         twbadyK3qzD4P8CTLb2J2ROovm3aonzx00VP9Jz4x5VuNHxGFCA/lmObnSwV6rjjEN
         kPld66WKP0lN6DZ5VKqotbdeS/E7rbmxvS068yppt8eF9fWWU7OLDMZzZN3h94o2wx
         BawdI+ovsAlDkDbr7Fy2ku7QF3is88s/QYsA1HCq8My+4fCSREpyq1OP7j9tjjZzJS
         PDFJA0qN/zVjhyDuxqrlR+3sn5bPZdYpW/Iz6M0NQy6iSIgNfECKhGfseJ6qDEjCQB
         Hvctksb2ZJ64A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UIaR113331619;
        Tue, 30 Jul 2019 11:36:27 -0700
Date:   Tue, 30 Jul 2019 11:36:27 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-9a5edde6d3a6fb26101406534f7a5d09a9fcd362@git.kernel.org>
Cc:     acme@redhat.com, hpa@zytor.com, namhyung@kernel.org,
        mpetlan@redhat.com, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, ak@linux.intel.com,
        alexey.budankov@linux.intel.com,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        jolsa@kernel.org
Reply-To: linux-kernel@vger.kernel.org, jolsa@kernel.org,
          alexander.shishkin@linux.intel.com,
          alexey.budankov@linux.intel.com, peterz@infradead.org,
          ak@linux.intel.com, mingo@kernel.org, mpetlan@redhat.com,
          tglx@linutronix.de, hpa@zytor.com, namhyung@kernel.org,
          acme@redhat.com
In-Reply-To: <20190721112506.12306-40-jolsa@kernel.org>
References: <20190721112506.12306-40-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] libperf: Add perf_evlist__add() function
Git-Commit-ID: 9a5edde6d3a6fb26101406534f7a5d09a9fcd362
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

Commit-ID:  9a5edde6d3a6fb26101406534f7a5d09a9fcd362
Gitweb:     https://git.kernel.org/tip/9a5edde6d3a6fb26101406534f7a5d09a9fcd362
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:24:26 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:44 -0300

libperf: Add perf_evlist__add() function

Add the perf_evlist__add() function to add a perf_evsel in a perf_evlist
struct.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-40-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evlist.c              | 7 +++++++
 tools/perf/lib/include/perf/evlist.h | 3 +++
 tools/perf/lib/libperf.map           | 1 +
 tools/perf/util/evlist.c             | 2 +-
 4 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index fdc8c1894b37..e5f187fa4e57 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -2,8 +2,15 @@
 #include <perf/evlist.h>
 #include <linux/list.h>
 #include <internal/evlist.h>
+#include <internal/evsel.h>
 
 void perf_evlist__init(struct perf_evlist *evlist)
 {
 	INIT_LIST_HEAD(&evlist->entries);
 }
+
+void perf_evlist__add(struct perf_evlist *evlist,
+		      struct perf_evsel *evsel)
+{
+	list_add_tail(&evsel->node, &evlist->entries);
+}
diff --git a/tools/perf/lib/include/perf/evlist.h b/tools/perf/lib/include/perf/evlist.h
index 1ddfcca0bd01..6992568b14a0 100644
--- a/tools/perf/lib/include/perf/evlist.h
+++ b/tools/perf/lib/include/perf/evlist.h
@@ -5,7 +5,10 @@
 #include <perf/core.h>
 
 struct perf_evlist;
+struct perf_evsel;
 
 LIBPERF_API void perf_evlist__init(struct perf_evlist *evlist);
+LIBPERF_API void perf_evlist__add(struct perf_evlist *evlist,
+				  struct perf_evsel *evsel);
 
 #endif /* __LIBPERF_EVLIST_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index 5ca6ff6fcdfa..06ccf31eb24d 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -11,6 +11,7 @@ LIBPERF_0.0.1 {
 		perf_thread_map__put;
 		perf_evsel__init;
 		perf_evlist__init;
+		perf_evlist__add;
 	local:
 		*;
 };
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index f4aa6cf80559..f2b86f49ab8d 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -180,8 +180,8 @@ static void perf_evlist__propagate_maps(struct evlist *evlist)
 
 void evlist__add(struct evlist *evlist, struct evsel *entry)
 {
+	perf_evlist__add(&evlist->core, &entry->core);
 	entry->evlist = evlist;
-	list_add_tail(&entry->core.node, &evlist->core.entries);
 	entry->idx = evlist->nr_entries;
 	entry->tracking = !entry->idx;
 
