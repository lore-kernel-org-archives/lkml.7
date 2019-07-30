Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BE8C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2397F204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="0oB6/df/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387804AbfG3Sn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:43:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33523 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfG3Sn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:43:27 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UIhGiA3332821
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:43:16 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UIhGiA3332821
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564512197;
        bh=+BB1SJcNU4L+JJkZfm+OeqH//qteO1BzhfAvtQCxHA0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=0oB6/df/BM0KgeedAaWP1IUfBvoyWWjqXZsRae1RyjpqxZEXH9QH/6hRkjqCltCVt
         yZ45RF7Ux7g/Tk5NhjOobfU9Y0OJiCddTFbYuvD74cZOSf0gsdCcV3HM56u2igaic9
         SVNJJRh4dNoVYTaz0HncoTXVQ19MBToEjp9tEY2TzCFn4wOpmL9CdxW30zL5ADu7CQ
         qizJqJJYVEKdUPPD6IE3s51hJEuuLc1d6sj80YqEB2o9ON0Mmi3ZiLoZEnSrvIzv1t
         XsfghncGAcyOiWRKDaLBCfSVHghhFa6krR0Z/HyZplgo4x7iw5F67s4PXUkrc3IG/0
         XRmLMH0dBp2gQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UIhFAW3332818;
        Tue, 30 Jul 2019 11:43:15 -0700
Date:   Tue, 30 Jul 2019 11:43:15 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-57f0c3b6e13ae822ba02dd37563c8e6956a47141@git.kernel.org>
Cc:     namhyung@kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        tglx@linutronix.de, peterz@infradead.org, mingo@kernel.org,
        ak@linux.intel.com, mpetlan@redhat.com, hpa@zytor.com,
        alexey.budankov@linux.intel.com
Reply-To: alexander.shishkin@linux.intel.com, jolsa@kernel.org,
          tglx@linutronix.de, namhyung@kernel.org,
          linux-kernel@vger.kernel.org, acme@redhat.com,
          alexey.budankov@linux.intel.com, mingo@kernel.org,
          peterz@infradead.org, ak@linux.intel.com, mpetlan@redhat.com,
          hpa@zytor.com
In-Reply-To: <20190721112506.12306-49-jolsa@kernel.org>
References: <20190721112506.12306-49-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] libperf: Add perf_evlist__delete() function
Git-Commit-ID: 57f0c3b6e13ae822ba02dd37563c8e6956a47141
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

Commit-ID:  57f0c3b6e13ae822ba02dd37563c8e6956a47141
Gitweb:     https://git.kernel.org/tip/57f0c3b6e13ae822ba02dd37563c8e6956a47141
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:24:35 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:45 -0300

libperf: Add perf_evlist__delete() function

Add the perf_evlist__delete() function to delete a perf_evlist instance.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-49-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evlist.c              | 6 ++++++
 tools/perf/lib/include/perf/evlist.h | 1 +
 tools/perf/lib/libperf.map           | 1 +
 3 files changed, 8 insertions(+)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 979ee423490f..087ef76ea8fd 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -4,6 +4,7 @@
 #include <internal/evlist.h>
 #include <internal/evsel.h>
 #include <linux/zalloc.h>
+#include <stdlib.h>
 
 void perf_evlist__init(struct perf_evlist *evlist)
 {
@@ -54,3 +55,8 @@ perf_evlist__next(struct perf_evlist *evlist, struct perf_evsel *prev)
 
 	return next;
 }
+
+void perf_evlist__delete(struct perf_evlist *evlist)
+{
+	free(evlist);
+}
diff --git a/tools/perf/lib/include/perf/evlist.h b/tools/perf/lib/include/perf/evlist.h
index 5092b622935b..9a126fd0773c 100644
--- a/tools/perf/lib/include/perf/evlist.h
+++ b/tools/perf/lib/include/perf/evlist.h
@@ -13,6 +13,7 @@ LIBPERF_API void perf_evlist__add(struct perf_evlist *evlist,
 LIBPERF_API void perf_evlist__remove(struct perf_evlist *evlist,
 				     struct perf_evsel *evsel);
 LIBPERF_API struct perf_evlist *perf_evlist__new(void);
+LIBPERF_API void perf_evlist__delete(struct perf_evlist *evlist);
 LIBPERF_API struct perf_evsel* perf_evlist__next(struct perf_evlist *evlist,
 						 struct perf_evsel *evsel);
 
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index c0968226f7b6..153e77cd6739 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -14,6 +14,7 @@ LIBPERF_0.0.1 {
 		perf_evsel__new;
 		perf_evsel__init;
 		perf_evlist__new;
+		perf_evlist__delete;
 		perf_evlist__init;
 		perf_evlist__add;
 		perf_evlist__remove;
