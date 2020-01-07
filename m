Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC79C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 12:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1782A207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 12:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dVk7CKVv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgAGMDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 07:03:34 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32978 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbgAGMDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 07:03:33 -0500
Received: by mail-pf1-f196.google.com with SMTP id z16so28522126pfk.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 04:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=tkqN/39xAVVYr6U6uU+iM+2t7KKXsj6P8b1qKRDl2lI=;
        b=dVk7CKVvDs/ovAaORf1KHIkkSp1zoAdLMGZ0efTRwv/f/HRhmLTBX0QgD/5OSWTZA+
         q+/AByMKWCrY6kHTDw46Op7E5kyT4rYyU/hqmSIc/1juMRPTlOjWLBxjrfwXKGuHVtL1
         C3v6tGzq9yc/XjRrm12VhNsjV5DVACBHQ+wRT3h+qHWV+rTSKt/mKTx+oSXYlJbILl3Z
         71YeZeC74pTeYvh4IrsDAoIm8JI6R77yo31e9SgOrCHpxUSAWn0MCCl02nN2Z1d078XT
         UdvRIzlVWVabFSpe7NWljCSLxEpZegjZnD0CW9sPWsvniXivI06E+iOv8tw0lVUo9tsQ
         W0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tkqN/39xAVVYr6U6uU+iM+2t7KKXsj6P8b1qKRDl2lI=;
        b=B5lihKRY8ubs8DI0fl28y7mjmqu22TW+zJUsCgC7GpcL8Uv7wh53cdabahHB2UwaGr
         3XyvZdoedc5QYEHU++Wkg/PnanUNib/b5vypctqgVjbfXE/zUQYG/qvuXhSQlLtiBz6i
         LlSuUeMU8ntFyllkQ+YPhJLRrTf1j0bOLTZobqyvpMf0bh6nF0LKN6+BFL3C2GAcszSS
         UsMAiejKQfdCHzMJA6/GzR8L9QwuNir1kqwcb11pUhrgXAEDgjogA36zUFVnQrgAoZCF
         QmCeQ2mzh8E3T5EjN9Pzb8HU780sSXcRnWIjvsR5mW7wZ0RuodVZqO0DUFmDyG97Gxc0
         ILlw==
X-Gm-Message-State: APjAAAWNUhn0vEMfGVd6XPb4OrS5eQl9qN3yGpOjFvUulOpoJ7w8UzcV
        ma2+Y4ZGEARntEmkIhTlt23Opg==
X-Google-Smtp-Source: APXvYqySmSvsNGId7fJN5k3lEKZqOlXKBtaMiYEYka6FIHXuRPRRbuHxcz0QUVweWchPEqbCEIxr5A==
X-Received: by 2002:a63:e309:: with SMTP id f9mr73934175pgh.391.1578398612964;
        Tue, 07 Jan 2020 04:03:32 -0800 (PST)
Received: from localhost.localdomain (li519-153.members.linode.com. [66.175.222.153])
        by smtp.gmail.com with ESMTPSA id c26sm78318620pfj.101.2020.01.07.04.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 04:03:32 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3] perf parse: Copy string to perf_evsel_config_term
Date:   Tue,  7 Jan 2020 20:03:10 +0800
Message-Id: <20200107120310.9632-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf with CoreSight fails to record trace data with command:

  perf record -e cs_etm/@tmc_etr0/u --per-thread ls
  failed to set sink "" on event cs_etm/@tmc_etr0/u with 21 (Is a
  directory)/perf/

This failure is root caused with the commit 1dc925568f01 ("perf
parse: Add a deep delete for parse event terms").

The log shows, cs_etm fails to parse the sink attribution; cs_etm event
relies on the event configuration to pass sink name, but the event
specific configuration data cannot be passed properly with flow:

  get_config_terms()
    ADD_CONFIG_TERM(DRV_CFG, drv_cfg, term->val.str);
      __t->val.drv_cfg = term->val.str;
        `> __t->val.drv_cfg is assigned to term->val.str;

  parse_events_terms__purge()
    parse_events_term__delete()
      zfree(&term->val.str);
        `> term->val.str is freed and assigned to NULL pointer;

  cs_etm_set_sink_attr()
    sink = __t->val.drv_cfg;
      `> sink string has been freed.

To fix this issue, in the function get_config_terms(), this patch
changes from directly assignment pointer value for the strings to
use strdup() for allocation a new duplicate string for the cases:

  perf_evsel_config_term::val.callgraph
  perf_evsel_config_term::val.branch
  perf_evsel_config_term::val.drv_cfg.

In the data structure perf_evsel_config_term, this patch adds
'char *str' pointer in the val union and new field 'free_str'.  When the
union is used as a string pointer, 'free_str' will be set to true;
finally it's flag to tell perf_evsel__free_config_terms() to free the
string with perf_evsel_config_term::val.str.

Fixes: 1dc925568f01 ("perf parse: Add a deep delete for parse event terms")
Suggested-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/evsel.c        |  2 ++
 tools/perf/util/evsel_config.h |  2 ++
 tools/perf/util/parse-events.c | 56 +++++++++++++++++++++-------------
 3 files changed, 39 insertions(+), 21 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index a69e64236120..ab9925cc1aa7 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1265,6 +1265,8 @@ static void perf_evsel__free_config_terms(struct evsel *evsel)
 
 	list_for_each_entry_safe(term, h, &evsel->config_terms, list) {
 		list_del_init(&term->list);
+		if (term->free_str)
+			free(term->val.str);
 		free(term);
 	}
 }
diff --git a/tools/perf/util/evsel_config.h b/tools/perf/util/evsel_config.h
index 1f8d2fe0b66e..dfc28738e071 100644
--- a/tools/perf/util/evsel_config.h
+++ b/tools/perf/util/evsel_config.h
@@ -32,6 +32,7 @@ enum evsel_term_type {
 struct perf_evsel_config_term {
 	struct list_head      list;
 	enum evsel_term_type  type;
+	bool		      free_str;
 	union {
 		u64	      period;
 		u64	      freq;
@@ -48,6 +49,7 @@ struct perf_evsel_config_term {
 		bool	      aux_output;
 		u32	      aux_sample_size;
 		u64	      cfg_chg;
+		char	      *str;
 	} val;
 	bool weak;
 };
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index ed7c008b9c8b..83fb149b9485 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1220,7 +1220,6 @@ static int get_config_terms(struct list_head *head_config,
 			    struct list_head *head_terms __maybe_unused)
 {
 #define ADD_CONFIG_TERM(__type, __name, __val)			\
-do {								\
 	struct perf_evsel_config_term *__t;			\
 								\
 	__t = zalloc(sizeof(*__t));				\
@@ -1229,9 +1228,24 @@ do {								\
 								\
 	INIT_LIST_HEAD(&__t->list);				\
 	__t->type       = PERF_EVSEL__CONFIG_TERM_ ## __type;	\
-	__t->val.__name = __val;				\
 	__t->weak	= term->weak;				\
-	list_add_tail(&__t->list, head_terms);			\
+	list_add_tail(&__t->list, head_terms)
+
+#define ADD_CONFIG_TERM_VAL(__type, __name, __val)		\
+do {								\
+	ADD_CONFIG_TERM(__type, __name, __val);			\
+	__t->val.__name = __val;				\
+} while (0)
+
+#define ADD_CONFIG_TERM_STR(__type, __name, __val)		\
+do {								\
+	ADD_CONFIG_TERM(__type, __name, __val);			\
+	__t->val.__name = strdup(__val);			\
+	if (!__t->val.__name) {					\
+		zfree(&__t);					\
+		return -ENOMEM;					\
+	}							\
+	__t->free_str = true;					\
 } while (0)
 
 	struct parse_events_term *term;
@@ -1239,53 +1253,53 @@ do {								\
 	list_for_each_entry(term, head_config, list) {
 		switch (term->type_term) {
 		case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
-			ADD_CONFIG_TERM(PERIOD, period, term->val.num);
+			ADD_CONFIG_TERM_VAL(PERIOD, period, term->val.num);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ:
-			ADD_CONFIG_TERM(FREQ, freq, term->val.num);
+			ADD_CONFIG_TERM_VAL(FREQ, freq, term->val.num);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_TIME:
-			ADD_CONFIG_TERM(TIME, time, term->val.num);
+			ADD_CONFIG_TERM_VAL(TIME, time, term->val.num);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_CALLGRAPH:
-			ADD_CONFIG_TERM(CALLGRAPH, callgraph, term->val.str);
+			ADD_CONFIG_TERM_STR(CALLGRAPH, callgraph, term->val.str);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_BRANCH_SAMPLE_TYPE:
-			ADD_CONFIG_TERM(BRANCH, branch, term->val.str);
+			ADD_CONFIG_TERM_STR(BRANCH, branch, term->val.str);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_STACKSIZE:
-			ADD_CONFIG_TERM(STACK_USER, stack_user, term->val.num);
+			ADD_CONFIG_TERM_VAL(STACK_USER, stack_user, term->val.num);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_INHERIT:
-			ADD_CONFIG_TERM(INHERIT, inherit, term->val.num ? 1 : 0);
+			ADD_CONFIG_TERM_VAL(INHERIT, inherit, term->val.num ? 1 : 0);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_NOINHERIT:
-			ADD_CONFIG_TERM(INHERIT, inherit, term->val.num ? 0 : 1);
+			ADD_CONFIG_TERM_VAL(INHERIT, inherit, term->val.num ? 0 : 1);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_MAX_STACK:
-			ADD_CONFIG_TERM(MAX_STACK, max_stack, term->val.num);
+			ADD_CONFIG_TERM_VAL(MAX_STACK, max_stack, term->val.num);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_MAX_EVENTS:
-			ADD_CONFIG_TERM(MAX_EVENTS, max_events, term->val.num);
+			ADD_CONFIG_TERM_VAL(MAX_EVENTS, max_events, term->val.num);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_OVERWRITE:
-			ADD_CONFIG_TERM(OVERWRITE, overwrite, term->val.num ? 1 : 0);
+			ADD_CONFIG_TERM_VAL(OVERWRITE, overwrite, term->val.num ? 1 : 0);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_NOOVERWRITE:
-			ADD_CONFIG_TERM(OVERWRITE, overwrite, term->val.num ? 0 : 1);
+			ADD_CONFIG_TERM_VAL(OVERWRITE, overwrite, term->val.num ? 0 : 1);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
-			ADD_CONFIG_TERM(DRV_CFG, drv_cfg, term->val.str);
+			ADD_CONFIG_TERM_STR(DRV_CFG, drv_cfg, term->val.str);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_PERCORE:
-			ADD_CONFIG_TERM(PERCORE, percore,
-					term->val.num ? true : false);
+			ADD_CONFIG_TERM_VAL(PERCORE, percore,
+					    term->val.num ? true : false);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT:
-			ADD_CONFIG_TERM(AUX_OUTPUT, aux_output, term->val.num ? 1 : 0);
+			ADD_CONFIG_TERM_VAL(AUX_OUTPUT, aux_output, term->val.num ? 1 : 0);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE:
-			ADD_CONFIG_TERM(AUX_SAMPLE_SIZE, aux_sample_size, term->val.num);
+			ADD_CONFIG_TERM_VAL(AUX_SAMPLE_SIZE, aux_sample_size, term->val.num);
 			break;
 		default:
 			break;
@@ -1322,7 +1336,7 @@ static int get_config_chgs(struct perf_pmu *pmu, struct list_head *head_config,
 	}
 
 	if (bits)
-		ADD_CONFIG_TERM(CFG_CHG, cfg_chg, bits);
+		ADD_CONFIG_TERM_VAL(CFG_CHG, cfg_chg, bits);
 
 #undef ADD_CONFIG_TERM
 	return 0;
-- 
2.17.1

