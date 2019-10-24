Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21FECA9EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 19:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E1B721929
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 19:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t7KJKTpn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504287AbfJXTCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 15:02:19 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:44582 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504273AbfJXTCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 15:02:16 -0400
Received: by mail-pg1-f202.google.com with SMTP id k23so10739199pgl.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 12:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+BLwqukjEjSzyRsrVOMoR9T3IlY0GDPVz6roAVxq3yY=;
        b=t7KJKTpnHF3ZC04GAfov7AIuzmHbGyRQPlZ9mNgn4WFbdmAzVeA3ChR9XF+XttPnTf
         75zhk2kZQS2H08vWZ0KAjkFIC8V9IkLKQpluChH+lg/MnJuKr5kCVY9jw5PIOMNuUG0v
         anCFzMEgznP21uSnkF6N+V6o/0oK5xhEfGJh11ocATY8YuykY+p/p+swR8vkKlsRnfLB
         tK7un0pAXk7/PR1+clMIhuk9I3sOOVftIxSWxeoxvfFn4oUhFZIpVGQTeMahrHAXmAJ9
         tWCiLish5zUvhxogmHs2c/n+8gLy3wvOevOQOoU0z4JrHSf1zsOhHgFYlXTgrTerzBGJ
         K+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+BLwqukjEjSzyRsrVOMoR9T3IlY0GDPVz6roAVxq3yY=;
        b=nwDi4lT+Zt6TFI/B9gbBNSt9vYSHfI02o3tA6ldaTbv/uuIAmX65fwtRI+pJ901tPI
         VS/83VpueDs3EcYIwJuMidEywUBksVuV9npy5RcFzCdtIIVCfIWFByQARt5Dow6D+2Bh
         piforR59aHCK4aH+U2fczrmYULAupDG/L74+Tm41XI90YdVZHCSTKcewQIFEUqzSKedq
         R9tEBjBcEZ1AIMxkEzz8Nd5SreOQZt6uDrzw+GwFxRnt+S8SkZraP39BUS421tCEzxrS
         oVw1yOTxCD0dyZ+4cXEBoWp3MjkADBLLbu8SBSlQkRW9e8HyeTn6nLHYP2fD7z/FH1t7
         DQmg==
X-Gm-Message-State: APjAAAVUXIagFnBHmwVHZLCg5vkH0cNStdWjyX0QgozKkysNBH6fTBQM
        h9r2gKYPzfup6SV+ooplpN81bYF37Fnj
X-Google-Smtp-Source: APXvYqzxIMOjHfrLCzoADHIQ+vCqU6Dp5CTsgb4D41Uy4S5lE49mdz54PDDtLJ3H/apOgnqz2EcWiMrex7l0
X-Received: by 2002:a63:7218:: with SMTP id n24mr5945150pgc.100.1571943735169;
 Thu, 24 Oct 2019 12:02:15 -0700 (PDT)
Date:   Thu, 24 Oct 2019 12:01:56 -0700
In-Reply-To: <20191024190202.109403-1-irogers@google.com>
Message-Id: <20191024190202.109403-4-irogers@google.com>
Mime-Version: 1.0
References: <20191023005337.196160-1-irogers@google.com> <20191024190202.109403-1-irogers@google.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH v3 3/9] perf tools: ensure config and str in terms are unique
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

Make it easier to release memory associated with parse event terms by
duplicating the string for the config name and ensuring the val string
is a duplicate.

Currently the parser may memory leak terms and this is addressed in a
later patch.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 51 ++++++++++++++++++++++++++++------
 tools/perf/util/parse-events.y |  4 ++-
 2 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index f0d50f079d2f..dc5862a663b5 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1430,7 +1430,6 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 			       char *str, struct list_head **listp)
 {
-	struct list_head *head;
 	struct parse_events_term *term;
 	struct list_head *list;
 	struct perf_pmu *pmu = NULL;
@@ -1447,19 +1446,30 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 
 		list_for_each_entry(alias, &pmu->aliases, list) {
 			if (!strcasecmp(alias->name, str)) {
+				struct list_head *head;
+				char *config;
+
 				head = malloc(sizeof(struct list_head));
 				if (!head)
 					return -1;
 				INIT_LIST_HEAD(head);
-				if (parse_events_term__num(&term, PARSE_EVENTS__TERM_TYPE_USER,
-							   str, 1, false, &str, NULL) < 0)
+				config = strdup(str);
+				if (!config)
+					return -1;
+				if (parse_events_term__num(&term,
+						   PARSE_EVENTS__TERM_TYPE_USER,
+						   config, 1, false, &config,
+						   NULL) < 0) {
+					free(list);
+					free(config);
 					return -1;
+				}
 				list_add_tail(&term->list, head);
 
 				if (!parse_events_add_pmu(parse_state, list,
 							  pmu->name, head,
 							  true, true)) {
-					pr_debug("%s -> %s/%s/\n", str,
+					pr_debug("%s -> %s/%s/\n", config,
 						 pmu->name, alias->str);
 					ok++;
 				}
@@ -1468,8 +1478,10 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 			}
 		}
 	}
-	if (!ok)
+	if (!ok) {
+		free(list);
 		return -1;
+	}
 	*listp = list;
 	return 0;
 }
@@ -2764,30 +2776,51 @@ int parse_events_term__sym_hw(struct parse_events_term **term,
 			      char *config, unsigned idx)
 {
 	struct event_symbol *sym;
+	char *str;
 	struct parse_events_term temp = {
 		.type_val  = PARSE_EVENTS__TERM_TYPE_STR,
 		.type_term = PARSE_EVENTS__TERM_TYPE_USER,
-		.config    = config ?: (char *) "event",
+		.config    = config,
 	};
 
+	if (!temp.config) {
+		temp.config = strdup("event");
+		if (!temp.config)
+			return -ENOMEM;
+	}
 	BUG_ON(idx >= PERF_COUNT_HW_MAX);
 	sym = &event_symbols_hw[idx];
 
-	return new_term(term, &temp, (char *) sym->symbol, 0);
+	str = strdup(sym->symbol);
+	if (!str)
+		return -ENOMEM;
+	return new_term(term, &temp, str, 0);
 }
 
 int parse_events_term__clone(struct parse_events_term **new,
 			     struct parse_events_term *term)
 {
+	char *str;
 	struct parse_events_term temp = {
 		.type_val  = term->type_val,
 		.type_term = term->type_term,
-		.config    = term->config,
+		.config    = NULL,
 		.err_term  = term->err_term,
 		.err_val   = term->err_val,
 	};
 
-	return new_term(new, &temp, term->val.str, term->val.num);
+	if (term->config) {
+		temp.config = strdup(term->config);
+		if (!temp.config)
+			return -ENOMEM;
+	}
+	if (term->type_val == PARSE_EVENTS__TERM_TYPE_NUM)
+		return new_term(new, &temp, NULL, term->val.num);
+
+	str = strdup(term->val.str);
+	if (!str)
+		return -ENOMEM;
+	return new_term(new, &temp, str, 0);
 }
 
 int parse_events_copy_term_list(struct list_head *old,
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 48126ae4cd13..27d6b187c9b1 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -644,9 +644,11 @@ PE_NAME array '=' PE_VALUE
 PE_DRV_CFG_TERM
 {
 	struct parse_events_term *term;
+	char *config = strdup($1);
 
+	ABORT_ON(!config);
 	ABORT_ON(parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE_DRV_CFG,
-					$1, $1, &@1, NULL));
+					config, $1, &@1, NULL));
 	$$ = term;
 }
 
-- 
2.23.0.866.gb869b98d4c-goog

