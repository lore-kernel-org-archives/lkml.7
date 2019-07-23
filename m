Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C65C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 20:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2F9E229F3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 20:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563912372;
	bh=66xijGkadEpiYl4HtmGoTSyjuEGkHSmGleRr0BBfJZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vCJzdSWHIKCfxNZxYdsleAhAl4HYn0MPd+sJu1/WJuJBWMzPHy6ZuZoMgEegEQF36
	 9a73BSLtTubfzDRXEFF8LHBOh0VUWPjoS6Rf7JW17yRj6O34g+i91LwC+wwaDM8I8E
	 2vbe+MZj8JMuEimjQn9nTp8jsp3FCBT2rdKGKRWk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387934AbfGWUGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 16:06:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:50298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbfGWUGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 16:06:10 -0400
Received: from quaco.ghostprotocols.net (unknown [179.182.218.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69324229EC;
        Tue, 23 Jul 2019 20:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563912369;
        bh=66xijGkadEpiYl4HtmGoTSyjuEGkHSmGleRr0BBfJZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y1VlueYNQs+jiqUVCxGcw+7OyWv6iZWSTUm0KdQnQyvztUfnh0tls4TbJNq0DXShD
         O7NVtuXSKFo9L8VjSemUQ9FxEPU8nGci94f4btmFTqDCeMfaw5McaaQ6Cm3Jrja+HL
         u8IEXDm9ibgiDh655j43cqjFNkrCY7aRRvkyTXnM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jiri Olsa <jolsa@redhat.com>,
        Numfor Mbiziwo-Tiapo <nums@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>, Mark Drayton <mbd@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 05/10] perf stat: Fix segfault for event group in repeat mode
Date:   Tue, 23 Jul 2019 17:05:25 -0300
Message-Id: <20190723200530.14090-6-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190723200530.14090-1-acme@kernel.org>
References: <20190723200530.14090-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>

Numfor Mbiziwo-Tiapo reported segfault on stat of event group in repeat
mode:

  # perf stat -e '{cycles,instructions}' -r 10 ls

It's caused by memory corruption due to not cleaned evsel's id array and
index, which needs to be rebuilt in every stat iteration. Currently the
ids index grows, while the array (which is also not freed) has the same
size.

Fixing this by releasing id array and zeroing ids index in
perf_evsel__close function.

We also need to keep the evsel_list alive for stat record (which is
disabled in repeat mode).

Reported-by: Numfor Mbiziwo-Tiapo <nums@google.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Mark Drayton <mbd@fb.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190715142121.GC6032@krava
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 9 ++++++++-
 tools/perf/util/evsel.c   | 2 ++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index b55a534b4de0..352cf39d7c2f 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -607,7 +607,13 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	 * group leaders.
 	 */
 	read_counters(&(struct timespec) { .tv_nsec = t1-t0 });
-	perf_evlist__close(evsel_list);
+
+	/*
+	 * We need to keep evsel_list alive, because it's processed
+	 * later the evsel_list will be closed after.
+	 */
+	if (!STAT_RECORD)
+		perf_evlist__close(evsel_list);
 
 	return WEXITSTATUS(status);
 }
@@ -1997,6 +2003,7 @@ int cmd_stat(int argc, const char **argv)
 			perf_session__write_header(perf_stat.session, evsel_list, fd, true);
 		}
 
+		perf_evlist__close(evsel_list);
 		perf_session__delete(perf_stat.session);
 	}
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ebb46da4dfe5..52459dd5ad0c 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1291,6 +1291,7 @@ static void perf_evsel__free_id(struct perf_evsel *evsel)
 	xyarray__delete(evsel->sample_id);
 	evsel->sample_id = NULL;
 	zfree(&evsel->id);
+	evsel->ids = 0;
 }
 
 static void perf_evsel__free_config_terms(struct perf_evsel *evsel)
@@ -2077,6 +2078,7 @@ void perf_evsel__close(struct perf_evsel *evsel)
 
 	perf_evsel__close_fd(evsel);
 	perf_evsel__free_fd(evsel);
+	perf_evsel__free_id(evsel);
 }
 
 int perf_evsel__open_per_cpu(struct perf_evsel *evsel,
-- 
2.21.0

