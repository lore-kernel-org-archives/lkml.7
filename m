Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDD2C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED9320659
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="gJ2MeqS+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfG3TFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 15:05:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52311 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfG3TFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 15:05:46 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UJ5Xpq3339946
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 12:05:33 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UJ5Xpq3339946
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564513534;
        bh=ivKFStmr6RZz/xDcYVJLBUPOzyDgtvBh8VAWgv4Qdso=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=gJ2MeqS+CNcN8yIq6mBGm17wXv7ibjFdxNKgiD3lXZd7xJ71aBvM1SFtqeZ4517gV
         ApfkMtmBz5aQAiu8WZt1sGR040GYkM+RcnvaWbD6JlKcHxjx3f9lUFZZBw8RCoIxBP
         2lt7Tki0+/+u9DpXrcgu3erjTDLgWNu14kReVC2yQfVxHCRuKO0kjV/N6WcA5TKcsf
         lfCMmd1LhrHaLsFmt9XeGkQ+FTt01EJBvPeMNd8q7loOVP2voWFUDYLdGbcuxdchd/
         /C/R/utucHmf6FRmiE4jmo6xvbbrBW1ebtYeGW/5AISlKHDnOEfkSXtDFDVRFv7aMb
         02HgpsvQ8YuNg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UJ5W3d3339942;
        Tue, 30 Jul 2019 12:05:32 -0700
Date:   Tue, 30 Jul 2019 12:05:32 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-6bda376ff416cf713773d38b743953a1a9bc0603@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, acme@redhat.com,
        mingo@kernel.org, mpetlan@redhat.com, jolsa@kernel.org,
        hpa@zytor.com, alexey.budankov@linux.intel.com,
        alexander.shishkin@linux.intel.com, peterz@infradead.org,
        ak@linux.intel.com, namhyung@kernel.org
Reply-To: alexey.budankov@linux.intel.com,
          alexander.shishkin@linux.intel.com, peterz@infradead.org,
          ak@linux.intel.com, namhyung@kernel.org, mingo@kernel.org,
          tglx@linutronix.de, acme@redhat.com,
          linux-kernel@vger.kernel.org, mpetlan@redhat.com,
          jolsa@kernel.org, hpa@zytor.com
In-Reply-To: <20190721112506.12306-78-jolsa@kernel.org>
References: <20190721112506.12306-78-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] libperf: Add perf_evlist__enable/disable test
Git-Commit-ID: 6bda376ff416cf713773d38b743953a1a9bc0603
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

Commit-ID:  6bda376ff416cf713773d38b743953a1a9bc0603
Gitweb:     https://git.kernel.org/tip/6bda376ff416cf713773d38b743953a1a9bc0603
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:25:04 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:47 -0300

libperf: Add perf_evlist__enable/disable test

Add simple perf_evlist enable/disable test together with evlist counter
reading interface.

Committer testing:

  # make -C tools/perf/lib tests
  make: Entering directory '/home/acme/git/perf/tools/perf/lib'
    LINK     test-cpumap-a
    LINK     test-threadmap-a
    LINK     test-evlist-a
    LINK     test-evsel-a
    LINK     test-cpumap-so
    LINK     test-threadmap-so
    LINK     test-evlist-so
    LINK     test-evsel-so
  running static:
  - running test-cpumap.c...OK
  - running test-threadmap.c...OK
  - running test-evlist.c...OK
  - running test-evsel.c...OK
  running dynamic:
  - running test-cpumap.c...OK
  - running test-threadmap.c...OK
  - running test-evlist.c...OK
  - running test-evsel.c...OK
  make: Leaving directory '/home/acme/git/perf/tools/perf/lib'
  #

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-78-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/tests/test-evlist.c | 63 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/tools/perf/lib/tests/test-evlist.c b/tools/perf/lib/tests/test-evlist.c
index f24c531afcb6..4e1407f20ffd 100644
--- a/tools/perf/lib/tests/test-evlist.c
+++ b/tools/perf/lib/tests/test-evlist.c
@@ -111,12 +111,75 @@ static int test_stat_thread(void)
 	return 0;
 }
 
+static int test_stat_thread_enable(void)
+{
+	struct perf_counts_values counts = { .val = 0 };
+	struct perf_thread_map *threads;
+	struct perf_evlist *evlist;
+	struct perf_evsel *evsel;
+	struct perf_event_attr attr1 = {
+		.type	  = PERF_TYPE_SOFTWARE,
+		.config	  = PERF_COUNT_SW_CPU_CLOCK,
+		.disabled = 1,
+	};
+	struct perf_event_attr attr2 = {
+		.type	  = PERF_TYPE_SOFTWARE,
+		.config	  = PERF_COUNT_SW_TASK_CLOCK,
+		.disabled = 1,
+	};
+	int err;
+
+	threads = perf_thread_map__new_dummy();
+	__T("failed to create threads", threads);
+
+	perf_thread_map__set_pid(threads, 0, 0);
+
+	evlist = perf_evlist__new();
+	__T("failed to create evlist", evlist);
+
+	evsel = perf_evsel__new(&attr1);
+	__T("failed to create evsel1", evsel);
+
+	perf_evlist__add(evlist, evsel);
+
+	evsel = perf_evsel__new(&attr2);
+	__T("failed to create evsel2", evsel);
+
+	perf_evlist__add(evlist, evsel);
+
+	perf_evlist__set_maps(evlist, NULL, threads);
+
+	err = perf_evlist__open(evlist);
+	__T("failed to open evsel", err == 0);
+
+	perf_evlist__for_each_evsel(evlist, evsel) {
+		perf_evsel__read(evsel, 0, 0, &counts);
+		__T("failed to read value for evsel", counts.val == 0);
+	}
+
+	perf_evlist__enable(evlist);
+
+	perf_evlist__for_each_evsel(evlist, evsel) {
+		perf_evsel__read(evsel, 0, 0, &counts);
+		__T("failed to read value for evsel", counts.val != 0);
+	}
+
+	perf_evlist__disable(evlist);
+
+	perf_evlist__close(evlist);
+	perf_evlist__delete(evlist);
+
+	perf_thread_map__put(threads);
+	return 0;
+}
+
 int main(int argc, char **argv)
 {
 	__T_START;
 
 	test_stat_cpu();
 	test_stat_thread();
+	test_stat_thread_enable();
 
 	__T_OK;
 	return 0;
