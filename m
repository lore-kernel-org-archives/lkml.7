Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18561C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBFD82067C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390100AbfGOOVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:21:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53628 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390043AbfGOOVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:21:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3A3AE308621E;
        Mon, 15 Jul 2019 14:21:25 +0000 (UTC)
Received: from krava (unknown [10.40.205.8])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5D5B75B681;
        Mon, 15 Jul 2019 14:21:22 +0000 (UTC)
Date:   Mon, 15 Jul 2019 16:21:21 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Numfor Mbiziwo-Tiapo <nums@google.com>,
        Stephane Eranian <eranian@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>, mbd@fb.com,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH] perf stat: Fix segfault for event group in repeat mode
Message-ID: <20190715142121.GC6032@krava>
References: <20190710204540.176495-1-nums@google.com>
 <20190714204432.GA8120@krava>
 <20190714205505.GB8120@krava>
 <CABPqkBSq35HZVk2CNi8xy9j7eb3EWRXSdgPKd+fmv2XaKPjOqA@mail.gmail.com>
 <20190715075912.GA2821@krava>
 <CABPqkBR=arE==2H2H0t1uAU2aTgPOr6Yucgh16J0rKughf_=CQ@mail.gmail.com>
 <20190715083105.GB2821@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715083105.GB2821@krava>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 15 Jul 2019 14:21:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Numfor Mbiziwo-Tiapo reported segfault on stat of event
group in repeat mode:

  # perf stat -e '{cycles,instructions}' -r 10 ls

It's caused by memory corruption due to not cleaned
evsel's id array and index, which needs to be rebuilt
in every stat iteration. Currently the ids index grows,
while the array (which is also not freed) has the same
size.

Fixing this by releasing id array and zeroing ids index
in perf_evsel__close function.

We also need to keep the evsel_list alive for stat
record (which is disabled in repeat mode).

Reported-by: Numfor Mbiziwo-Tiapo <nums@google.com>
Link: http://lkml.kernel.org/n/tip-07t75chgdhcr00uerh51hb6j@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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

