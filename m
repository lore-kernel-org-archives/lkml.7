Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512AEC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E982087E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564752132;
	bh=Z09HykGBFDymPa5q/kYKLaQEDnODKlFMnfYyW5VwmUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tO6wPMXKmpcvFFZqDslRt0cFBhnWUa9p94tSqIK6aiHBdd24yAM5QUZUvtJul6E1Q
	 D8V6uChr+plACnLlEKamfggVchOfcbhS4IMl0w1dCGx2rsj+BeeddgLr6a2fhGD83o
	 ioLwckhja/IqhjTusDt0kA7hyNLf4Wpt4Ad/H9A8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393721AbfHBNWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:22:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:60696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393693AbfHBNWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:22:08 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2EFB2173E;
        Fri,  2 Aug 2019 13:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564752127;
        bh=Z09HykGBFDymPa5q/kYKLaQEDnODKlFMnfYyW5VwmUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bu21OI19DJPAv+jFa4eyiljRSFkdFKykgVjDTf6o6dGvQXVB+unWd3J5u2wZ/xIV7
         TdtWj7AsFw/QyCsrUfmyjd3I6H/jgU6VrD+r65GFvLKZx6ra0mX/cmZ2aSDaklacuB
         HqEfSPrxuRGTA9kr3eGdezBoWLfexOj/rW51ETCk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Numfor Mbiziwo-Tiapo <nums@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>, Mark Drayton <mbd@fb.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 54/76] perf stat: Fix segfault for event group in repeat mode
Date:   Fri,  2 Aug 2019 09:19:28 -0400
Message-Id: <20190802131951.11600-54-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802131951.11600-1-sashal@kernel.org>
References: <20190802131951.11600-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>

[ Upstream commit 08ef3af1579d0446db1c1bd08e2c42565addf10f ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-stat.c | 9 ++++++++-
 tools/perf/util/evsel.c   | 2 ++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index e28002d905738..c6c550dbb9479 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -607,7 +607,13 @@ try_again:
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
@@ -1922,6 +1928,7 @@ int cmd_stat(int argc, const char **argv)
 			perf_session__write_header(perf_stat.session, evsel_list, fd, true);
 		}
 
+		perf_evlist__close(evsel_list);
 		perf_session__delete(perf_stat.session);
 	}
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 2c46f9aa416c6..b854541604df5 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1282,6 +1282,7 @@ static void perf_evsel__free_id(struct perf_evsel *evsel)
 	xyarray__delete(evsel->sample_id);
 	evsel->sample_id = NULL;
 	zfree(&evsel->id);
+	evsel->ids = 0;
 }
 
 static void perf_evsel__free_config_terms(struct perf_evsel *evsel)
@@ -2074,6 +2075,7 @@ void perf_evsel__close(struct perf_evsel *evsel)
 
 	perf_evsel__close_fd(evsel);
 	perf_evsel__free_fd(evsel);
+	perf_evsel__free_id(evsel);
 }
 
 int perf_evsel__open_per_cpu(struct perf_evsel *evsel,
-- 
2.20.1

