Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C822CA9EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 19:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F8721929
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 19:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wkf8kLJ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504278AbfJXTCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 15:02:16 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:52049 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504266AbfJXTCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 15:02:15 -0400
Received: by mail-pl1-f201.google.com with SMTP id q13so7324470plr.18
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 12:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Suz77OvPj2zse3ACt5ant97LgHIFhYaDbP1x2fdJ/qM=;
        b=Wkf8kLJ4doKtpDHeS4YU4TeKPlVTfPSlzjZQVy1btaihCSxnPHRIiRgaYjanl9P/EF
         /q2/E00TfLxsXDm/qzdA9a90yTBbb4/qddYpb3gRT+yWd3NYuySaiZEjPyPrlD+qwJnh
         ANjOJIs44qf0VigeqJ0knHNu8zN4Bk7UjWqyTwfi0PIYQ1MakLNQBqVMXSki2O7vGllK
         zoy4uAsMMdUrMmpy3X1PSF5M5hqlJ7h7Lwnxz2FkFR5Zqo5zq5Moch8/UhO+6JebGqiw
         gLr47wVdPLeyBXMXulgt1YMfEazJvE3eTrKUZDf4ihGyJCdJUS4yRSlXZzyWAKrXJGSE
         LNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Suz77OvPj2zse3ACt5ant97LgHIFhYaDbP1x2fdJ/qM=;
        b=WxRws4pikqOUik4LkW7xl/V8b4cG/Pr9MYxChrx6p1k8gvi7QO0ck4sXdMxpD0OMlg
         xmB5T+GSqNjT6qySeja2512QsVs4JvT3RZmfubkJj8xHT6U3DWt0nViyf8OCcWIN6EoI
         jIsT9P7QcGGUr9GuiKoZU7Mk5GUJ2E46r+aoyj1Wg3mVLi4EHVmr8j/dxl0nrNFofSEf
         kaU0cbolgLsCCPdF2lgi8vQbTJ7qUKsXaVU2ESQHvtqSGRJxbtB9inm8XaZ8Hjl0Pv+T
         OX4SyVZ2KsxW4EOb4yck3t4ywO0x1IutEeX8+qqdUk6FeWp8+xvL9GLqx8JA/3woi5Eo
         YaBQ==
X-Gm-Message-State: APjAAAVat3tOK9k1cxMbuqMoq7L/OkoS5WayHlSDj0q4A+5AqTEc5E81
        nhSSpc0KXBjIssPxROufNx6pYMiQ+nAd
X-Google-Smtp-Source: APXvYqzE0YLcEtfJD5+y6FsT1a6u7MmXUky94H8cSOwI2hLGViFXlxCW8maOBgQEx701pR+olbLa+qMoDtVo
X-Received: by 2002:a63:748:: with SMTP id 69mr18596734pgh.109.1571943732499;
 Thu, 24 Oct 2019 12:02:12 -0700 (PDT)
Date:   Thu, 24 Oct 2019 12:01:55 -0700
In-Reply-To: <20191024190202.109403-1-irogers@google.com>
Message-Id: <20191024190202.109403-3-irogers@google.com>
Mime-Version: 1.0
References: <20191023005337.196160-1-irogers@google.com> <20191024190202.109403-1-irogers@google.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH v3 2/9] perf tools: splice events onto evlist even on error
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
index edb3ae76777d..f0d50f079d2f 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1968,15 +1968,20 @@ int parse_events(struct evlist *evlist, const char *str,
 
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
2.23.0.866.gb869b98d4c-goog

