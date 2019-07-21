Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09373C76188
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1A732085A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563708334;
	bh=IABfKxWgi2VHJ1AxHBhI/sRXAIFbR4kCtPVnogNeohQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ET74XqTZSAIwJAqLuPaSsvduemI6chaLbveTlpo+3XkJMehN6pyaoXcbqlqvGYBQ8
	 wY9Zrun3F092Yt7ywMCPFvwDyU41cufi725sY5O7zW4/aePe9Q4VemJzfwijQdNLuA
	 +EA7V+navYP4KPve3WZ/huihAMV0BNJPbWhdZWmU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfGULZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 07:25:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54252 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfGULZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:25:24 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A9226369AC;
        Sun, 21 Jul 2019 11:25:23 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AFA005D9D3;
        Sun, 21 Jul 2019 11:25:18 +0000 (UTC)
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
Subject: [PATCH 01/79] perf tools: Move loaded out of struct perf_counts_values
Date:   Sun, 21 Jul 2019 13:23:48 +0200
Message-Id: <20190721112506.12306-2-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Sun, 21 Jul 2019 11:25:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because we will make struct perf_counts_values public in
following patches and 'loaded' is implementation related.

No functional change is expected.

Link: http://lkml.kernel.org/n/tip-418j9zovp8k4t71dqkng6oyu@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
-- 
2.21.0

