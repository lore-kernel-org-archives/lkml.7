Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEB0C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFABA204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="GCPvlON+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730257AbfG3Sl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:41:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34373 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfG3Sl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:41:59 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UIflnr3332410
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:41:48 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UIflnr3332410
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564512108;
        bh=0rdS9t2ruUTTjNMLZBRqXP40Hz26l8NmxiTNHfzXIgI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=GCPvlON+FxqdoEOXTG4dsbkdtWLBauS2AOQCUxPuuCvYH84X6tS56eO4tSJYWQF9U
         kkwElHBkkwkIyp8PwNRFxyZ0ads7dhB7gmAX5DkyCcbW85S3jGbFRVAsK/Q7lGQPNG
         NNFDDHg9H8/DBmYfNFldzvfOJN7+ArB5lMTQkgjrws9XIjhHOaJP2jo7vtYGqMxvHI
         bpOaEQpy6mUtBYnHjt53wnBNru6UTJNOdD//b5L/yMkB7WIAMG2MnFk6N3VKbwZnbv
         vY7nLYxZ2cJ1HZwCX24F4NIUxtybeC+pdHDZbrxvyohu4V5IfXRSIzx2whOhClVPjP
         xMSKEA5iYWsQA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UIflnY3332407;
        Tue, 30 Jul 2019 11:41:47 -0700
Date:   Tue, 30 Jul 2019 11:41:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-63bd5dfa69658c459d08a6ee6bfebbd4a91cf24d@git.kernel.org>
Cc:     alexander.shishkin@linux.intel.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org, hpa@zytor.com,
        alexey.budankov@linux.intel.com, ak@linux.intel.com,
        namhyung@kernel.org, acme@redhat.com, jolsa@kernel.org,
        mpetlan@redhat.com, tglx@linutronix.de
Reply-To: acme@redhat.com, namhyung@kernel.org, jolsa@kernel.org,
          mpetlan@redhat.com, tglx@linutronix.de, mingo@kernel.org,
          alexander.shishkin@linux.intel.com, ak@linux.intel.com,
          alexey.budankov@linux.intel.com, hpa@zytor.com,
          peterz@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20190721112506.12306-47-jolsa@kernel.org>
References: <20190721112506.12306-47-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] libperf: Add perf_evsel__new() function
Git-Commit-ID: 63bd5dfa69658c459d08a6ee6bfebbd4a91cf24d
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

Commit-ID:  63bd5dfa69658c459d08a6ee6bfebbd4a91cf24d
Gitweb:     https://git.kernel.org/tip/63bd5dfa69658c459d08a6ee6bfebbd4a91cf24d
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:24:33 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:45 -0300

libperf: Add perf_evsel__new() function

Add a perf_evsel__new() function to create and init a perf_evsel struct
dynamicaly.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-47-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evsel.c              | 11 +++++++++++
 tools/perf/lib/include/perf/evsel.h |  1 +
 tools/perf/lib/libperf.map          |  1 +
 3 files changed, 13 insertions(+)

diff --git a/tools/perf/lib/evsel.c b/tools/perf/lib/evsel.c
index 17cba35becc7..8e91738c5c38 100644
--- a/tools/perf/lib/evsel.c
+++ b/tools/perf/lib/evsel.c
@@ -2,9 +2,20 @@
 #include <perf/evsel.h>
 #include <linux/list.h>
 #include <internal/evsel.h>
+#include <linux/zalloc.h>
 
 void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr)
 {
 	INIT_LIST_HEAD(&evsel->node);
 	evsel->attr = *attr;
 }
+
+struct perf_evsel *perf_evsel__new(struct perf_event_attr *attr)
+{
+	struct perf_evsel *evsel = zalloc(sizeof(*evsel));
+
+	if (evsel != NULL)
+		perf_evsel__init(evsel, attr);
+
+	return evsel;
+}
diff --git a/tools/perf/lib/include/perf/evsel.h b/tools/perf/lib/include/perf/evsel.h
index 295583b89f46..21b66fc1937f 100644
--- a/tools/perf/lib/include/perf/evsel.h
+++ b/tools/perf/lib/include/perf/evsel.h
@@ -9,5 +9,6 @@ struct perf_event_attr;
 
 LIBPERF_API void perf_evsel__init(struct perf_evsel *evsel,
 				  struct perf_event_attr *attr);
+LIBPERF_API struct perf_evsel *perf_evsel__new(struct perf_event_attr *attr);
 
 #endif /* __LIBPERF_EVSEL_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index 5e685d6c7a95..e3eac9b60726 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -11,6 +11,7 @@ LIBPERF_0.0.1 {
 		perf_thread_map__comm;
 		perf_thread_map__get;
 		perf_thread_map__put;
+		perf_evsel__new;
 		perf_evsel__init;
 		perf_evlist__new;
 		perf_evlist__init;
