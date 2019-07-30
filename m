Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCA7C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B052089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Zz6wD9gR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbfG3SH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:07:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52495 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfG3SH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:07:56 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UI7dHm3324711
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:07:39 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UI7dHm3324711
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564510060;
        bh=lKyA9m0mnhqAyIQI7v6BmCVsK802ZuwxtGLxUS30gLc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Zz6wD9gRHhu2oWLy+D+5XaTznjXdl0i+aQYe+YvYFVfiK2si1jpL+7mmj1J1jf2r6
         YxAFWOh41Pj40/IdCaQXN+RWDyg8xIbPvr7MRYIECz6bJKnV4Bcs5m3WEETU5TCfLi
         nSUR6fO5TXaO+e0WnhEtNxlWrpx8VI9GBo6j+gWgIVa2BALuZwJNKcySex2Jj1NmMa
         KKg6kKuqHHyMRF90bFF74XvE2l0AHtBS8tPVWYWOXnFRycqRq5DrdxzWt9b8svC1Yr
         rGlXEswqHpIRmS19RwAGtNpHyIZvs+zE02UlI5C5+a/o5ivbyleAVJh28DWtigUIdM
         6iJ+u+GnvOkUQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UI7cHr3324708;
        Tue, 30 Jul 2019 11:07:38 -0700
Date:   Tue, 30 Jul 2019 11:07:38 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-df1d6856eaa7ec9ad1e670685b370f3e66326079@git.kernel.org>
Cc:     hpa@zytor.com, namhyung@kernel.org,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mpetlan@redhat.com, jolsa@kernel.org,
        peterz@infradead.org, mingo@kernel.org,
        alexey.budankov@linux.intel.com, acme@redhat.com,
        ak@linux.intel.com
Reply-To: mingo@kernel.org, alexey.budankov@linux.intel.com,
          acme@redhat.com, ak@linux.intel.com, namhyung@kernel.org,
          hpa@zytor.com, alexander.shishkin@linux.intel.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          mpetlan@redhat.com, peterz@infradead.org, jolsa@kernel.org
In-Reply-To: <20190721112506.12306-2-jolsa@kernel.org>
References: <20190721112506.12306-2-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf stat: Move loaded out of struct
 perf_counts_values
Git-Commit-ID: df1d6856eaa7ec9ad1e670685b370f3e66326079
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

Commit-ID:  df1d6856eaa7ec9ad1e670685b370f3e66326079
Gitweb:     https://git.kernel.org/tip/df1d6856eaa7ec9ad1e670685b370f3e66326079
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:23:48 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:42 -0300

perf stat: Move loaded out of struct perf_counts_values

Because we will make struct perf_counts_values public in following
patches and 'loaded' is implementation related.

No functional change is expected.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c |  4 ++--
 tools/perf/util/counts.c  | 11 +++++++++++
 tools/perf/util/counts.h  | 14 +++++++++++++-
 tools/perf/util/evsel.c   |  3 ++-
 4 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 352cf39d7c2f..7b9c26f9cf34 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -287,7 +287,7 @@ static int read_counter(struct perf_evsel *counter, struct timespec *rs)
 			 * The leader's group read loads data into its group members
 			 * (via perf_evsel__read_counter) and sets threir count->loaded.
 			 */
-			if (!count->loaded &&
+			if (!perf_counts__is_loaded(counter->counts, cpu, thread) &&
 			    read_single_counter(counter, cpu, thread, rs)) {
 				counter->counts->scaled = -1;
 				perf_counts(counter->counts, cpu, thread)->ena = 0;
@@ -295,7 +295,7 @@ static int read_counter(struct perf_evsel *counter, struct timespec *rs)
 				return -1;
 			}
 
-			count->loaded = false;
+			perf_counts__set_loaded(counter->counts, cpu, thread, false);
 
 			if (STAT_RECORD) {
 				if (perf_evsel__write_stat_event(counter, cpu, thread, count)) {
diff --git a/tools/perf/util/counts.c b/tools/perf/util/counts.c
index 88be9c4365e0..01ee81df3fe5 100644
--- a/tools/perf/util/counts.c
+++ b/tools/perf/util/counts.c
@@ -19,6 +19,15 @@ struct perf_counts *perf_counts__new(int ncpus, int nthreads)
 		}
 
 		counts->values = values;
+
+		values = xyarray__new(ncpus, nthreads, sizeof(bool));
+		if (!values) {
+			xyarray__delete(counts->values);
+			free(counts);
+			return NULL;
+		}
+
+		counts->loaded = values;
 	}
 
 	return counts;
@@ -27,6 +36,7 @@ struct perf_counts *perf_counts__new(int ncpus, int nthreads)
 void perf_counts__delete(struct perf_counts *counts)
 {
 	if (counts) {
+		xyarray__delete(counts->loaded);
 		xyarray__delete(counts->values);
 		free(counts);
 	}
@@ -34,6 +44,7 @@ void perf_counts__delete(struct perf_counts *counts)
 
 static void perf_counts__reset(struct perf_counts *counts)
 {
+	xyarray__reset(counts->loaded);
 	xyarray__reset(counts->values);
 }
 
diff --git a/tools/perf/util/counts.h b/tools/perf/util/counts.h
index 0d1050ccc586..460b56ce3252 100644
--- a/tools/perf/util/counts.h
+++ b/tools/perf/util/counts.h
@@ -13,13 +13,13 @@ struct perf_counts_values {
 		};
 		u64 values[3];
 	};
-	bool	loaded;
 };
 
 struct perf_counts {
 	s8			  scaled;
 	struct perf_counts_values aggr;
 	struct xyarray		  *values;
+	struct xyarray		  *loaded;
 };
 
 
@@ -29,6 +29,18 @@ perf_counts(struct perf_counts *counts, int cpu, int thread)
 	return xyarray__entry(counts->values, cpu, thread);
 }
 
+static inline bool
+perf_counts__is_loaded(struct perf_counts *counts, int cpu, int thread)
+{
+	return *((bool *) xyarray__entry(counts->loaded, cpu, thread));
+}
+
+static inline void
+perf_counts__set_loaded(struct perf_counts *counts, int cpu, int thread, bool loaded)
+{
+	*((bool *) xyarray__entry(counts->loaded, cpu, thread)) = loaded;
+}
+
 struct perf_counts *perf_counts__new(int ncpus, int nthreads);
 void perf_counts__delete(struct perf_counts *counts);
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 7d1757a2ec46..d23b9574f793 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1439,7 +1439,8 @@ perf_evsel__set_count(struct perf_evsel *counter, int cpu, int thread,
 	count->val    = val;
 	count->ena    = ena;
 	count->run    = run;
-	count->loaded = true;
+
+	perf_counts__set_loaded(counter->counts, cpu, thread, true);
 }
 
 static int
