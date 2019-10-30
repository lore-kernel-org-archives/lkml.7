Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5DECA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 22:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1903A2087E
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 22:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l05WTTft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfJ3WfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 18:35:22 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:38115 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbfJ3WfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 18:35:16 -0400
Received: by mail-pg1-f201.google.com with SMTP id b24so2744140pgi.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 15:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=n/kunXFB8a17/1SeufduY2AZP1in+T/Iq/GsFxRYzfY=;
        b=l05WTTftzkwYenk8bVJ16EaTRciLaUtMqRbwlXpBBRfNqUlrXbXG4d2kZVDod0qRT1
         QemSRI2R6pFqjC4xssA9CHv+kG/6uajvIMIsjgW+UAtcEE4Igy3skTCMlF98kAlD8Izb
         aQFaGZAijkQJNO1Kct0mO3IvLAquBqnGS9p01Ule3gft9yLkTaoAXn/+i9HLvlrXiDXI
         u3Z04Nw2FArAfEpqco3sOzW8OPJQt/OzNTRjyUjfjB/x4IQDvX3Z3QhuwAQ6TGeM6klG
         cFo5rdzhOyrSoDwt6GgcM3h6jfLO92wn/vckvlNJab9Bx1/4qg41pEkmJkobejSh+9hE
         xzKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=n/kunXFB8a17/1SeufduY2AZP1in+T/Iq/GsFxRYzfY=;
        b=oTQBkbZNnqWp0dELzcEeLPzuynefpta75r1U6wV6ROeNFMZEjaKFJfSYm1JEiEU216
         M033IBixfk1uFCDJa6NcGAS4o1aHRcKv9KGtKkxWbfHOrB8LxhGO8Q3eBP0YBroH90CX
         n1lLNQqqyFBFDQfacsjc3DmgViDLgaz4QPkOZa3r8pMK3wxc7+wDcz8xXVFEaY9cMO4c
         4Hj8IJqUy5+WtMxg9scFtJ2HdSNMOP0qazr4KHy69l3wX25eziy32pUQ3PVbalcc362o
         OMX7cQtGEMdWPQXMOgCSyAtwNhCPDfbIGqDkWlWMCkc5PHYN5OVL5Oyh3wsLtDWz7BIx
         NstQ==
X-Gm-Message-State: APjAAAWJhWC+py91UBP1fR4CkEfvmdsqUof0w2hZawvWaDwHAyltsD5T
        oUvUZVs8X0mOnuwMpP0j58VBIzp8N512
X-Google-Smtp-Source: APXvYqyUXDTP+AZ2NyPn5itLqJLExzhTopKCQLn1yYFozbb1JDl/bquUPF6RFStOo1v+cOvusy5TPWMDPE6z
X-Received: by 2002:a63:4b52:: with SMTP id k18mr1971001pgl.394.1572474914325;
 Wed, 30 Oct 2019 15:35:14 -0700 (PDT)
Date:   Wed, 30 Oct 2019 15:34:46 -0700
In-Reply-To: <20191030223448.12930-1-irogers@google.com>
Message-Id: <20191030223448.12930-9-irogers@google.com>
Mime-Version: 1.0
References: <20191025180827.191916-1-irogers@google.com> <20191030223448.12930-1-irogers@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v5 08/10] perf tools: if pmu configuration fails free terms
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

Avoid a memory leak when the configuration fails.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 578288c94d2a..a0a80f4e7038 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1388,8 +1388,15 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 	if (get_config_terms(head_config, &config_terms))
 		return -ENOMEM;
 
-	if (perf_pmu__config(pmu, &attr, head_config, parse_state->error))
+	if (perf_pmu__config(pmu, &attr, head_config, parse_state->error)) {
+		struct perf_evsel_config_term *pos, *tmp;
+
+		list_for_each_entry_safe(pos, tmp, &config_terms, list) {
+			list_del_init(&pos->list);
+			free(pos);
+		}
 		return -EINVAL;
+	}
 
 	evsel = __add_event(list, &parse_state->idx, &attr,
 			    get_config_name(head_config), pmu,
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

