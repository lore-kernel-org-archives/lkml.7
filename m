Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670DBC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3835420693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="CyEz86T7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730336AbfG3Smp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:42:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56271 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfG3Smo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:42:44 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UIgVUR3332712
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:42:31 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UIgVUR3332712
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564512152;
        bh=X5gCfAk+g0cp1gr4qLew4B2332f1Yt1iR4j3L3nbSlw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=CyEz86T7tXAZ9R3USYq+ak7aZ7vKyVdisMIm1HRmiJJ//IYHgtleYO/vgR6PxaDcP
         hYoK3iAV84jAQ7G3Mv+pp5276OnONf6Q92v4GWsw9xm0KH81t+dtfzG64ddzLnaDvC
         XDKDD5HkbKqgB7pikF4dTnoKQ+JJBMB9AQPjX2j4ZiyfMIf89XYZrVcRRivv1JYTyT
         tyA2FyPw+WPpYx5wVmHGdXzhWQjZRBsMcQZS4H+ISH8mxPH+5w9WAWBTJcb9shwDcB
         wxk7W1R/zVdkddQMS/88bwFw1tOknzP3ZHMtlt1nTM0VdaNClN09kqMaAs1eM61X3p
         ZhGv7dj00j7EA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UIgVr23332709;
        Tue, 30 Jul 2019 11:42:31 -0700
Date:   Tue, 30 Jul 2019 11:42:31 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-651bf38ce10a65ef8efb901fc33187127c023e97@git.kernel.org>
Cc:     hpa@zytor.com, ak@linux.intel.com, jolsa@kernel.org,
        acme@redhat.com, peterz@infradead.org,
        alexey.budankov@linux.intel.com, mingo@kernel.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, mpetlan@redhat.com,
        tglx@linutronix.de
Reply-To: acme@redhat.com, peterz@infradead.org,
          alexey.budankov@linux.intel.com, mingo@kernel.org,
          alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
          namhyung@kernel.org, mpetlan@redhat.com, tglx@linutronix.de,
          hpa@zytor.com, ak@linux.intel.com, jolsa@kernel.org
In-Reply-To: <20190721112506.12306-48-jolsa@kernel.org>
References: <20190721112506.12306-48-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] libperf: Add perf_evlist__for_each_evsel() iterator
Git-Commit-ID: 651bf38ce10a65ef8efb901fc33187127c023e97
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

Commit-ID:  651bf38ce10a65ef8efb901fc33187127c023e97
Gitweb:     https://git.kernel.org/tip/651bf38ce10a65ef8efb901fc33187127c023e97
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:24:34 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:45 -0300

libperf: Add perf_evlist__for_each_evsel() iterator

Add a perf_evlist__for_each_evsel() macro to iterate perf_evsel objects
in evlist.

Introduce the perf_evlist__next() function to do that without exposing
'struct perf_evlist' internals.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-48-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evlist.c              | 20 ++++++++++++++++++++
 tools/perf/lib/include/perf/evlist.h |  7 +++++++
 tools/perf/lib/libperf.map           |  1 +
 3 files changed, 28 insertions(+)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 0517deb4cb1c..979ee423490f 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -34,3 +34,23 @@ struct perf_evlist *perf_evlist__new(void)
 
 	return evlist;
 }
+
+struct perf_evsel *
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
