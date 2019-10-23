Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86EBCA9EA0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 00:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD3D208C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 00:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dxp56W5Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732458AbfJWAyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 20:54:06 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:44958 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732328AbfJWAyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 20:54:04 -0400
Received: by mail-pg1-f202.google.com with SMTP id k23so6038847pgl.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 17:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=orKMDyFq0pxDsmp0+soEOe34Z3iGwylS1aF6XcYLmDY=;
        b=dxp56W5QwoEHYr+VvlnDojJFQ2s5Jr00cBo2UlZtUhbLztqDX+v6+mFLiFTmFce6QW
         upwIV8Rb7h9vSzOV5rCKmO/VSgT7BjrhF61lxGDW61AFZDGWzaayL/+597j709GkCi0K
         5rt3aQ2QeeayYfKJQ3lcb0LVh0i6yEutFUwWaWPtq+YPMOwqkW0jf9D83dbFi9F99gdS
         KnF088Q2o6Af0a44MJQKk7o6My2hjCNyEk+VeoK2UfTTar3KkzLwaIUqUh/ZwrY3FsVW
         gMFBtHZ/psrnbjZJJYDvno+NZqro2sxpRd6v2a0VIJ/42OdJaudV25DhgeWP532RlMy7
         ycbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=orKMDyFq0pxDsmp0+soEOe34Z3iGwylS1aF6XcYLmDY=;
        b=KqnszUdDhWg/XJw1NnugENe9IKEdhvWrWv4MhKwrYWY2SUsA5pjsorFLor3KKjQsr2
         v7YxAuzJu0HS0QscZ1m6ykObTF/03WAbGwPSmg9KD66Tbdr1QkI2nEesL7obMCBBUQPX
         4VxIRnXdfCQgriaNGQtXrw69+uX1a6Rb7YGSGS5oa6DMpRGXyRJOLCZmepZQgWwC5faL
         +7FpkTinu436LdYgqPhapLwG8VboJGsto4MW1GldHgUiSPROjBrHPMGMfNgbj078nlV1
         QdVNwO/p7f3DGtR4gf6YOnv3uV/nA7rkvdk7r8ZCGyrism7CsJ5y6qbtMDQY9vRmpnGi
         9lEw==
X-Gm-Message-State: APjAAAXMjL2O/IAVQkfLSN4zc+628pRMMfwWuQLO6XOtkus0PWtg9IMI
        n0X1e85IV1mZgTzREWHuwUlLTfDTP/Zh
X-Google-Smtp-Source: APXvYqzyVIwLoq+9wyp9C7zURVMoBQyLpOCJQ6F7p/ccsS8pjZFa43S0nRwH0x7KWI+lYdhQ17E8tgEaTCrC
X-Received: by 2002:a63:1904:: with SMTP id z4mr6951997pgl.413.1571792043458;
 Tue, 22 Oct 2019 17:54:03 -0700 (PDT)
Date:   Tue, 22 Oct 2019 17:53:30 -0700
In-Reply-To: <20191023005337.196160-1-irogers@google.com>
Message-Id: <20191023005337.196160-3-irogers@google.com>
Mime-Version: 1.0
References: <20191017170531.171244-1-irogers@google.com> <20191023005337.196160-1-irogers@google.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH v2 2/9] perf tools: splice events onto evlist even on error
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

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 4d42344698b8..a8f8801bd127 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1962,15 +1962,20 @@ int parse_events(struct evlist *evlist, const char *str,
 
 	ret = parse_events__scanner(str, &parse_state, PE_START_EVENTS);
 	perf_pmu__parse_cleanup();
+
+	if (list_empty(&parse_state.list)) {
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
2.23.0.866.gb869b98d4c-goog

