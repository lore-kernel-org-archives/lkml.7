Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E414C32771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 03:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 643D02075A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 03:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="knmIP/0T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgAGDSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 22:18:42 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42906 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbgAGDSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 22:18:42 -0500
Received: by mail-pf1-f194.google.com with SMTP id 4so27869087pfz.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 19:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=FPVgAA67m3TAdDYScRWZhAuLGh650kB2AJurIEodDz0=;
        b=knmIP/0Ts3HRnwu5A4EgqxBj1dPlxUQ47wOqTbFr8RIEgTDEQfnS1nmyyPJVAA1xG5
         rWvjeVSg4G3n6TI6C06WOUS3yQkuWFE7XWODNZb5t6+42r91AaWfQT6pf94iEsEszu18
         EGvdZ8pgnpI7kYMP7YkjM2Hucv6wjfre+FunQI4kknoGcILNU710IRUX+Vn6AhiP6E5I
         Ar/auhps/hjfObcVOMAsqbaPQyS/PfUNPIbFTLJrvL4eRBoNZjp7+n1NBhct2OpfZI4O
         4uk78VabCyg9hvhL4aI4LVN/IOfnClF9z9LJgCCN2epuEuXxwYQm6AevZ8sjJGXOjwKN
         W7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FPVgAA67m3TAdDYScRWZhAuLGh650kB2AJurIEodDz0=;
        b=jCpFQNxEeG84vMd78iYFSFeI9NuogJmerZ/+r1Zmew1gFLo4LmygQIJgirhpkYNYjs
         +oPEXK7vlTJ84mecwUjWp4yS0Z/tbSf9GbNjeZGsFjeb63NIRDTI+AAiVvCtmh3JD2mp
         mvo4OQ832Xvcb2c4gVuA7quRnSNzoMsCuHQMpZLUODcjE52H6WiFLlhFSG24oAUYui3g
         2nggC01B/IkRpm5s+A2Owr+/IQF7QTo87zUfIGf+SZgdngCPUPG6iJLQNlvnJTHAypIB
         qVgurEtFP/4/+uEzmyR1sLtQbHUPBVsppo7lOx8Hj8Nye1PT62/DDlSVsg+j4wjRReTv
         AKTg==
X-Gm-Message-State: APjAAAUq4c4w5b2osoQnTev6skt+3LBjQY9DPGeY1Ki9IPZ0K1mj+GGE
        y30lsNOgaecRKnWhYL/zdPuMUA==
X-Google-Smtp-Source: APXvYqzzHczdNbQ54kR/gJeRRIwGxWZ6BMgfEMvdNXwwz324fZfFVf2G4GtUbNN1JDO7TId7us9zJQ==
X-Received: by 2002:a63:7705:: with SMTP id s5mr112078724pgc.379.1578367121393;
        Mon, 06 Jan 2020 19:18:41 -0800 (PST)
Received: from localhost.localdomain (li1058-79.members.linode.com. [45.33.121.79])
        by smtp.gmail.com with ESMTPSA id r62sm81699361pfc.89.2020.01.06.19.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 19:18:40 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2] perf parse: Copy string to perf_evsel_config_term
Date:   Tue,  7 Jan 2020 11:18:28 +0800
Message-Id: <20200107031828.23103-1-leo.yan@linaro.org>
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

Fixes: 1dc925568f01 ("perf parse: Add a deep delete for parse event terms")
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/parse-events.c | 55 +++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index ed7c008b9c8b..49b26504bee3 100644
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
@@ -1229,9 +1228,23 @@ do {								\
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
 } while (0)
 
 	struct parse_events_term *term;
@@ -1239,53 +1252,53 @@ do {								\
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
@@ -1322,7 +1335,7 @@ static int get_config_chgs(struct perf_pmu *pmu, struct list_head *head_config,
 	}
 
 	if (bits)
-		ADD_CONFIG_TERM(CFG_CHG, cfg_chg, bits);
+		ADD_CONFIG_TERM_VAL(CFG_CHG, cfg_chg, bits);
 
 #undef ADD_CONFIG_TERM
 	return 0;
-- 
2.17.1

