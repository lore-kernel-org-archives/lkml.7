Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC375C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 14:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95EB62072A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 14:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qpe8GlFN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbgAHOUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 09:20:49 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33240 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728840AbgAHOUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 09:20:49 -0500
Received: by mail-pl1-f196.google.com with SMTP id ay11so1177409plb.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 06:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/aEjzLy1m+pr9fYmy6Qqkup19duszl1cC8/K5QqSxE8=;
        b=qpe8GlFNfBC6nf5YI9O4uRYrjBtZ9BNXvhlnDCUWw9+cDQ2dgu/UNuRLMYVOLuG4se
         r7yvABsHu9PN2tEo2VRv66vibxBWwUHkIC8Zo/3VdZ2UVyeTa1ndzEfkZOT+6Ii/Hu6I
         TRf07r/WYLPB10WjB31B55KI1mG9dd71bATLWaYvl5zTnVHJJCT9PIRyLbkTS1ops9J4
         GQIEcB8et7Y9TEhD/RMcEviZ96NMB3kiWLq5Ae7hxbxsTvyGjns87LUxe84ndOaia2HW
         uctfMEW98f/W/YTrOOZH4qBSaCWi4GnpXVGcppG9rvC7PqCsjCzIyWUqEHlZTlJ6vxno
         j/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/aEjzLy1m+pr9fYmy6Qqkup19duszl1cC8/K5QqSxE8=;
        b=iBQTkeB9qKuWMduKGbcNO7IqAuUDElIrIxF/5UBxREoOnFeD9CfpIh2KPm8UGTAGDr
         zgmcTgR9wvrv6r2X5581B8Lf3dNVOBWMxEa5pd/P08LekgDVxcAex2kQMP87tL8CRRrE
         XLLvSUyZzgXe+VcfHV8EYcA0JdvIjk2pSFFPuGF9vTuhxVWH/HiuGHy9ZxYYpfy7STmD
         OSmm/qlW78XTVoGvdMx1lyHspQ9ih7cuVQNX9SgzBwVcQv1qfb494INoWZKQLsbfNEiI
         7FktOjsH0gbvEPETiB7M+/aPtWoeQd6dxxYnBiEBbq96XKJ3rX846dLo0EeD3lZaBx6M
         ewSg==
X-Gm-Message-State: APjAAAWtm+SwATYj5Ur+m3rEbSBO3JAhSQjoZPf0uP7si4hD/dQCENtR
        pbwFCiDnZPI9YaWAW9RAzNClVQ==
X-Google-Smtp-Source: APXvYqzMYFTj4LN5WwXGXgMh2iMmjC65zcigFPNSkgVq6XH8IcNFu5eijDL7kpj/fzNhdjx6x9GbTA==
X-Received: by 2002:a17:902:6bc9:: with SMTP id m9mr5637488plt.260.1578493247423;
        Wed, 08 Jan 2020 06:20:47 -0800 (PST)
Received: from localhost.localdomain (li519-153.members.linode.com. [66.175.222.153])
        by smtp.gmail.com with ESMTPSA id a18sm3515054pjq.30.2020.01.08.06.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 06:20:46 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andi Kleen <ak@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 1/2] perf parse: Refactor struct perf_evsel_config_term
Date:   Wed,  8 Jan 2020 22:20:09 +0800
Message-Id: <20200108142010.11269-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct perf_evsel_config_term::val is a union which contains
multiple variables for corresponding types.  This leads the union to
be complex and also causes complex code logic.

This patch refactors the structure to use two general variables in the
'val' union: one is 'num' for unsigned 64-bit integer and another is
'str' for string variable.  This can simplify the data structure and
the related code, this also can benefit for possibly extension.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c |  2 +-
 tools/perf/builtin-top.c          |  2 +-
 tools/perf/util/auxtrace.c        |  2 +-
 tools/perf/util/evsel.c           | 24 +++++++-------
 tools/perf/util/evsel_config.h    | 17 ++--------
 tools/perf/util/parse-events.c    | 55 ++++++++++++++++++-------------
 6 files changed, 49 insertions(+), 53 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index ede040cf82ad..2898cfdf8fe1 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -226,7 +226,7 @@ static int cs_etm_set_sink_attr(struct perf_pmu *pmu,
 		if (term->type != PERF_EVSEL__CONFIG_TERM_DRV_CFG)
 			continue;
 
-		sink = term->val.drv_cfg;
+		sink = term->val.str;
 		snprintf(path, PATH_MAX, "sinks/%s", sink);
 
 		ret = perf_pmu__scan_file(pmu, path, "%x", &hash);
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 795e353de095..459be44ca2ff 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -947,7 +947,7 @@ static int perf_top__overwrite_check(struct perf_top *top)
 		config_terms = &evsel->config_terms;
 		list_for_each_entry(term, config_terms, list) {
 			if (term->type == PERF_EVSEL__CONFIG_TERM_OVERWRITE)
-				set = term->val.overwrite ? 1 : 0;
+				set = term->val.num ? 1 : 0;
 		}
 
 		/* no term for current and previous event (likely) */
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index eb087e7df6f4..a5c945aadfa7 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -772,7 +772,7 @@ int auxtrace_parse_sample_options(struct auxtrace_record *itr,
 		term = perf_evsel__get_config_term(evsel, AUX_SAMPLE_SIZE);
 		if (term) {
 			has_aux_sample_size = true;
-			evsel->core.attr.aux_sample_size = term->val.aux_sample_size;
+			evsel->core.attr.aux_sample_size = term->val.num;
 			/* If possible, group with the AUX event */
 			if (aux_evsel && evsel->core.attr.aux_sample_size)
 				perf_evlist__regroup(evlist, aux_evsel, evsel);
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index a69e64236120..5f27f6b7ed94 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -789,43 +789,43 @@ static void apply_config_terms(struct evsel *evsel,
 		switch (term->type) {
 		case PERF_EVSEL__CONFIG_TERM_PERIOD:
 			if (!(term->weak && opts->user_interval != ULLONG_MAX)) {
-				attr->sample_period = term->val.period;
+				attr->sample_period = term->val.num;
 				attr->freq = 0;
 				perf_evsel__reset_sample_bit(evsel, PERIOD);
 			}
 			break;
 		case PERF_EVSEL__CONFIG_TERM_FREQ:
 			if (!(term->weak && opts->user_freq != UINT_MAX)) {
-				attr->sample_freq = term->val.freq;
+				attr->sample_freq = term->val.num;
 				attr->freq = 1;
 				perf_evsel__set_sample_bit(evsel, PERIOD);
 			}
 			break;
 		case PERF_EVSEL__CONFIG_TERM_TIME:
-			if (term->val.time)
+			if (term->val.num)
 				perf_evsel__set_sample_bit(evsel, TIME);
 			else
 				perf_evsel__reset_sample_bit(evsel, TIME);
 			break;
 		case PERF_EVSEL__CONFIG_TERM_CALLGRAPH:
-			callgraph_buf = term->val.callgraph;
+			callgraph_buf = term->val.str;
 			break;
 		case PERF_EVSEL__CONFIG_TERM_BRANCH:
-			if (term->val.branch && strcmp(term->val.branch, "no")) {
+			if (term->val.str && strcmp(term->val.str, "no")) {
 				perf_evsel__set_sample_bit(evsel, BRANCH_STACK);
-				parse_branch_str(term->val.branch,
+				parse_branch_str(term->val.str,
 						 &attr->branch_sample_type);
 			} else
 				perf_evsel__reset_sample_bit(evsel, BRANCH_STACK);
 			break;
 		case PERF_EVSEL__CONFIG_TERM_STACK_USER:
-			dump_size = term->val.stack_user;
+			dump_size = term->val.num;
 			break;
 		case PERF_EVSEL__CONFIG_TERM_MAX_STACK:
-			max_stack = term->val.max_stack;
+			max_stack = term->val.num;
 			break;
 		case PERF_EVSEL__CONFIG_TERM_MAX_EVENTS:
-			evsel->max_events = term->val.max_events;
+			evsel->max_events = term->val.num;
 			break;
 		case PERF_EVSEL__CONFIG_TERM_INHERIT:
 			/*
@@ -834,17 +834,17 @@ static void apply_config_terms(struct evsel *evsel,
 			 * inherit using config terms, override global
 			 * opt->no_inherit setting.
 			 */
-			attr->inherit = term->val.inherit ? 1 : 0;
+			attr->inherit = term->val.num ? 1 : 0;
 			break;
 		case PERF_EVSEL__CONFIG_TERM_OVERWRITE:
-			attr->write_backward = term->val.overwrite ? 1 : 0;
+			attr->write_backward = term->val.num ? 1 : 0;
 			break;
 		case PERF_EVSEL__CONFIG_TERM_DRV_CFG:
 			break;
 		case PERF_EVSEL__CONFIG_TERM_PERCORE:
 			break;
 		case PERF_EVSEL__CONFIG_TERM_AUX_OUTPUT:
-			attr->aux_output = term->val.aux_output ? 1 : 0;
+			attr->aux_output = term->val.num ? 1 : 0;
 			break;
 		case PERF_EVSEL__CONFIG_TERM_AUX_SAMPLE_SIZE:
 			/* Already applied by auxtrace */
diff --git a/tools/perf/util/evsel_config.h b/tools/perf/util/evsel_config.h
index 1f8d2fe0b66e..4e5b3ebf09cf 100644
--- a/tools/perf/util/evsel_config.h
+++ b/tools/perf/util/evsel_config.h
@@ -33,21 +33,8 @@ struct perf_evsel_config_term {
 	struct list_head      list;
 	enum evsel_term_type  type;
 	union {
-		u64	      period;
-		u64	      freq;
-		bool	      time;
-		char	      *callgraph;
-		char	      *drv_cfg;
-		u64	      stack_user;
-		int	      max_stack;
-		bool	      inherit;
-		bool	      overwrite;
-		char	      *branch;
-		unsigned long max_events;
-		bool	      percore;
-		bool	      aux_output;
-		u32	      aux_sample_size;
-		u64	      cfg_chg;
+		u64	      num;
+		char	      *str;
 	} val;
 	bool weak;
 };
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index ed7c008b9c8b..caf38518762f 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1219,8 +1219,7 @@ static int config_attr(struct perf_event_attr *attr,
 static int get_config_terms(struct list_head *head_config,
 			    struct list_head *head_terms __maybe_unused)
 {
-#define ADD_CONFIG_TERM(__type, __name, __val)			\
-do {								\
+#define ADD_CONFIG_TERM(__type)					\
 	struct perf_evsel_config_term *__t;			\
 								\
 	__t = zalloc(sizeof(*__t));				\
@@ -1229,9 +1228,19 @@ do {								\
 								\
 	INIT_LIST_HEAD(&__t->list);				\
 	__t->type       = PERF_EVSEL__CONFIG_TERM_ ## __type;	\
-	__t->val.__name = __val;				\
 	__t->weak	= term->weak;				\
-	list_add_tail(&__t->list, head_terms);			\
+	list_add_tail(&__t->list, head_terms)
+
+#define ADD_CONFIG_TERM_VAL(__type, __val)			\
+do {								\
+	ADD_CONFIG_TERM(__type);				\
+	__t->val.num = __val;					\
+} while (0)
+
+#define ADD_CONFIG_TERM_STR(__type, __val)			\
+do {								\
+	ADD_CONFIG_TERM(__type);				\
+	__t->val.str = __val;					\
 } while (0)
 
 	struct parse_events_term *term;
@@ -1239,53 +1248,53 @@ do {								\
 	list_for_each_entry(term, head_config, list) {
 		switch (term->type_term) {
 		case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
-			ADD_CONFIG_TERM(PERIOD, period, term->val.num);
+			ADD_CONFIG_TERM_VAL(PERIOD, term->val.num);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ:
-			ADD_CONFIG_TERM(FREQ, freq, term->val.num);
+			ADD_CONFIG_TERM_VAL(FREQ, term->val.num);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_TIME:
-			ADD_CONFIG_TERM(TIME, time, term->val.num);
+			ADD_CONFIG_TERM_VAL(TIME, term->val.num);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_CALLGRAPH:
-			ADD_CONFIG_TERM(CALLGRAPH, callgraph, term->val.str);
+			ADD_CONFIG_TERM_STR(CALLGRAPH, term->val.str);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_BRANCH_SAMPLE_TYPE:
-			ADD_CONFIG_TERM(BRANCH, branch, term->val.str);
+			ADD_CONFIG_TERM_STR(BRANCH, term->val.str);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_STACKSIZE:
-			ADD_CONFIG_TERM(STACK_USER, stack_user, term->val.num);
+			ADD_CONFIG_TERM_VAL(STACK_USER, term->val.num);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_INHERIT:
-			ADD_CONFIG_TERM(INHERIT, inherit, term->val.num ? 1 : 0);
+			ADD_CONFIG_TERM_VAL(INHERIT, term->val.num ? 1 : 0);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_NOINHERIT:
-			ADD_CONFIG_TERM(INHERIT, inherit, term->val.num ? 0 : 1);
+			ADD_CONFIG_TERM_VAL(INHERIT, term->val.num ? 0 : 1);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_MAX_STACK:
-			ADD_CONFIG_TERM(MAX_STACK, max_stack, term->val.num);
+			ADD_CONFIG_TERM_VAL(MAX_STACK, term->val.num);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_MAX_EVENTS:
-			ADD_CONFIG_TERM(MAX_EVENTS, max_events, term->val.num);
+			ADD_CONFIG_TERM_VAL(MAX_EVENTS, term->val.num);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_OVERWRITE:
-			ADD_CONFIG_TERM(OVERWRITE, overwrite, term->val.num ? 1 : 0);
+			ADD_CONFIG_TERM_VAL(OVERWRITE, term->val.num ? 1 : 0);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_NOOVERWRITE:
-			ADD_CONFIG_TERM(OVERWRITE, overwrite, term->val.num ? 0 : 1);
+			ADD_CONFIG_TERM_VAL(OVERWRITE, term->val.num ? 0 : 1);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
-			ADD_CONFIG_TERM(DRV_CFG, drv_cfg, term->val.str);
+			ADD_CONFIG_TERM_STR(DRV_CFG, term->val.str);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_PERCORE:
-			ADD_CONFIG_TERM(PERCORE, percore,
-					term->val.num ? true : false);
+			ADD_CONFIG_TERM_VAL(PERCORE,
+					    term->val.num ? true : false);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT:
-			ADD_CONFIG_TERM(AUX_OUTPUT, aux_output, term->val.num ? 1 : 0);
+			ADD_CONFIG_TERM_VAL(AUX_OUTPUT, term->val.num ? 1 : 0);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE:
-			ADD_CONFIG_TERM(AUX_SAMPLE_SIZE, aux_sample_size, term->val.num);
+			ADD_CONFIG_TERM_VAL(AUX_SAMPLE_SIZE, term->val.num);
 			break;
 		default:
 			break;
@@ -1322,7 +1331,7 @@ static int get_config_chgs(struct perf_pmu *pmu, struct list_head *head_config,
 	}
 
 	if (bits)
-		ADD_CONFIG_TERM(CFG_CHG, cfg_chg, bits);
+		ADD_CONFIG_TERM_VAL(CFG_CHG, bits);
 
 #undef ADD_CONFIG_TERM
 	return 0;
@@ -1387,7 +1396,7 @@ static bool config_term_percore(struct list_head *config_terms)
 
 	list_for_each_entry(term, config_terms, list) {
 		if (term->type == PERF_EVSEL__CONFIG_TERM_PERCORE)
-			return term->val.percore;
+			return term->val.num;
 	}
 
 	return false;
-- 
2.17.1

