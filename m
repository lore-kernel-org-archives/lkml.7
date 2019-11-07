Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DD5C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 22:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD8942075C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 22:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mKKIHHcP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbfKGWOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 17:14:55 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:44459 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727718AbfKGWOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 17:14:53 -0500
Received: by mail-pg1-f201.google.com with SMTP id k23so2981458pgl.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 14:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=o8eDtK4XLT1yB0wxfi9aIxQpXeS3/ycmioxd58yIuN4=;
        b=mKKIHHcPsVgAONMoZXSGtLwt9SP+tD9wXU5Rr4ErMd4qk25xxGHIDhu0/Qj6blDSXu
         vw8yk435k0zSoO7r85MUWnIiDGrJKFGdKDK82Jw7m6NySbCo1Vauj2i4miFVTQu63CO2
         lA2NNfwcoNrNMgMCR2EJDl6GnmqjppeRJr8OGLkbz4E3cUhsSmX7F6VsUKv6g416lBld
         ejPPz9FG0oGRPSlxptOA762PUJY1ysICvSgHASLoYEhjd4BKZ04jbyyLmhEgBxGvpZsR
         VTQmYTQpApuWnvWKLmyzGmGQ6t5rq1PWRG9ioiWslfV5INFn/whzTGswzoaPdX9PRlzp
         1VWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=o8eDtK4XLT1yB0wxfi9aIxQpXeS3/ycmioxd58yIuN4=;
        b=mtdByqhNWYsmYkfqrx6bj8yKwhXOQ2t3EdP+AKeB6DCtegczWA1S9Dp0LvhDIA2H9+
         iUasIrWIXOOMvAdyC9HOzUMeyagM3bUZikgXdVIxKAzJG5L4Nr+pTkX1rT0hqFF5fdqs
         b5u5d7FzMtuFNWdqVMA5jkNIyYTekiy6C8h9HdsqqCbQVh7eiedIltsO1ImSf5b8ZR+F
         nD8zDt37GcI3l6oyrKZxD0LWDjRqsFoAUsIXK2AyXa2O7MLQGaeUtRPIX74XHaKdQLkv
         LVpMTUhUe+IZ2QV72bRSS2an7JVdIA2myQMwyyZHoPr/OlmBM8fn62CCaoQlrC34JDis
         qicQ==
X-Gm-Message-State: APjAAAUUTkSzVAKufJwbl29b7q/AAT48KMIG4QhaxoPkQyYqzQkRodFs
        xmiFKrFO8rpLCHYIN66+1mcnIvRRword
X-Google-Smtp-Source: APXvYqwJ8VuG9hRWejetPkhG8pMOZtZDUOZmAuU7dpgY1u7aUXH4GS+ccoeO9Va6IB9QTmImhuarKgMRCuzR
X-Received: by 2002:a63:2b84:: with SMTP id r126mr7381052pgr.77.1573164892310;
 Thu, 07 Nov 2019 14:14:52 -0800 (PST)
Date:   Thu,  7 Nov 2019 14:14:22 -0800
In-Reply-To: <20191107221428.168286-1-irogers@google.com>
Message-Id: <20191107221428.168286-5-irogers@google.com>
Mime-Version: 1.0
References: <20191030223448.12930-1-irogers@google.com> <20191107221428.168286-1-irogers@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v6 04/10] perf tools: splice events onto evlist even on error
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If event parsing fails the event list is leaked, instead splice the list
onto the out result and let the caller cleanup.

An example input for parse_events found by libFuzzer that reproduces
this memory leak is 'm{'.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index e9b958d6c534..03e54a2d8685 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1950,15 +1950,20 @@ int parse_events(struct evlist *evlist, const char *str,
 
 	ret = parse_events__scanner(str, &parse_state, PE_START_EVENTS);
 	perf_pmu__parse_cleanup();
+
+	if (!ret && list_empty(&parse_state.list)) {
+		WARN_ONCE(true, "WARNING: event parser found nothing\n");
+		return -1;
+	}
+
+	/*
+	 * Add list to the evlist even with errors to allow callers to clean up.
+	 */
+	perf_evlist__splice_list_tail(evlist, &parse_state.list);
+
 	if (!ret) {
 		struct evsel *last;
 
-		if (list_empty(&parse_state.list)) {
-			WARN_ONCE(true, "WARNING: event parser found nothing\n");
-			return -1;
-		}
-
-		perf_evlist__splice_list_tail(evlist, &parse_state.list);
 		evlist->nr_groups += parse_state.nr_groups;
 		last = evlist__last(evlist);
 		last->cmdline_group_boundary = true;
-- 
2.24.0.432.g9d3f5f5b63-goog

