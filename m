Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7E1C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 21:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42EBE22ADC
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 21:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="llunZeFS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403988AbfGWVuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 17:50:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42629 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731612AbfGWVuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 17:50:07 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6NLnJ2K253396
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 23 Jul 2019 14:49:19 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6NLnJ2K253396
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1563918560;
        bh=jEZ7ALSLtumeLXXb+vgVcxrPJSkSgkio94KoNbEl4Ew=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=llunZeFSkgQsQV59HA+bgYcTUHzoospJ7Ox8OUtx6gQSgTmRXP2bHcUuN51nAateN
         5BeLe1vz/uEHq01ZiXh4hErJJ0qajk1jp+A//KZ1AAb6N4IpHcGfg2sEYI6AUdGbnK
         gm7i/BVScv77eIGtynKOs9T8PYbqYE8OYYCpIE3F/IP0W+2DE/uJ9fQhH5fkC2+Ynw
         u1GB0uJkUnmzz2dyiBlC7uhRR81DUZZucM1Pu8PqXtKOc4sFn1iWi8yxqptmcUCDqX
         HzXZuCYRpkS9Kd/qie04H2pRb+3LcoiXzwR1FS/Qz1bvhYsWJwUEosgm2o4J5Czwjn
         mE92PZ8EFfVUA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6NLnIcZ253393;
        Tue, 23 Jul 2019 14:49:18 -0700
Date:   Tue, 23 Jul 2019 14:49:18 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-08ef3af1579d0446db1c1bd08e2c42565addf10f@git.kernel.org>
Cc:     jolsa@redhat.com, eranian@google.com, peterz@infradead.org,
        songliubraving@fb.com, mbd@fb.com, tglx@linutronix.de,
        mingo@kernel.org, irogers@google.com,
        alexander.shishkin@linux.intel.com, nums@google.com,
        linux-kernel@vger.kernel.org, jolsa@kernel.org, hpa@zytor.com,
        acme@redhat.com, namhyung@kernel.org
Reply-To: peterz@infradead.org, jolsa@redhat.com, eranian@google.com,
          mingo@kernel.org, tglx@linutronix.de, mbd@fb.com,
          songliubraving@fb.com, linux-kernel@vger.kernel.org,
          nums@google.com, irogers@google.com,
          alexander.shishkin@linux.intel.com, namhyung@kernel.org,
          acme@redhat.com, hpa@zytor.com, jolsa@kernel.org
In-Reply-To: <20190715142121.GC6032@krava>
References: <20190715142121.GC6032@krava>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf stat: Fix segfault for event group in repeat
 mode
Git-Commit-ID: 08ef3af1579d0446db1c1bd08e2c42565addf10f
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

Commit-ID:  08ef3af1579d0446db1c1bd08e2c42565addf10f
Gitweb:     https://git.kernel.org/tip/08ef3af1579d0446db1c1bd08e2c42565addf10f
Author:     Jiri Olsa <jolsa@redhat.com>
AuthorDate: Mon, 15 Jul 2019 16:21:21 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 23 Jul 2019 09:00:05 -0300

perf stat: Fix segfault for event group in repeat mode

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
