Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF525C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 01:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DDBF2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 01:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfCSBGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 21:06:25 -0400
Received: from mga07.intel.com ([134.134.136.100]:35823 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbfCSBGZ (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 21:06:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 18:06:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,495,1544515200"; 
   d="scan'208";a="283811124"
Received: from skl.sh.intel.com ([10.239.159.132])
  by orsmga004.jf.intel.com with ESMTP; 18 Mar 2019 18:06:22 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 1/4] perf: Add a 'percore' event qualifier
Date:   Tue, 19 Mar 2019 16:56:53 +0800
Message-Id: <1552985816-20915-2-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552985816-20915-1-git-send-email-yao.jin@linux.intel.com>
References: <1552985816-20915-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a 'percore' event qualifier, like cpu/event=0,umask=0x3,percore=1/,
that sums up the event counts for both hardware threads in a core.

We can already do this with --per-core, but it's often useful to do
this together with other metrics that are collected per hardware thread.
So we need to support this per-core counting on a event level.

This can be implemented in only the user tool, no kernel support needed.

 v3:
 ---
 Simplify the code according to Jiri's comments.
 Before:
   "return term->val.percore ? true : false;"
 Now:
   "return term->val.percore;"

 v2:
 ---
 Change the qualifier name from 'coresum' to 'percore' according to
 comments from Jiri and Andi.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/evsel.c        |  2 ++
 tools/perf/util/evsel.h        |  3 +++
 tools/perf/util/parse-events.c | 27 +++++++++++++++++++++++++++
 tools/perf/util/parse-events.h |  1 +
 tools/perf/util/parse-events.l |  1 +
 5 files changed, 34 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 3bbf73e..b900157 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -803,6 +803,8 @@ static void apply_config_terms(struct perf_evsel *evsel,
 			break;
 		case PERF_EVSEL__CONFIG_TERM_DRV_CFG:
 			break;
+		case PERF_EVSEL__CONFIG_TERM_PERCORE:
+			break;
 		default:
 			break;
 		}
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index cc578e0..fd86689 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -50,6 +50,7 @@ enum term_type {
 	PERF_EVSEL__CONFIG_TERM_OVERWRITE,
 	PERF_EVSEL__CONFIG_TERM_DRV_CFG,
 	PERF_EVSEL__CONFIG_TERM_BRANCH,
+	PERF_EVSEL__CONFIG_TERM_PERCORE,
 };
 
 struct perf_evsel_config_term {
@@ -67,6 +68,7 @@ struct perf_evsel_config_term {
 		bool	overwrite;
 		char	*branch;
 		unsigned long max_events;
+		bool	percore;
 	} val;
 	bool weak;
 };
@@ -150,6 +152,7 @@ struct perf_evsel {
 	struct perf_evsel	**metric_events;
 	bool			collect_stat;
 	bool			weak_group;
+	bool			percore;
 	const char		*pmu_name;
 };
 
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 4dcc01b..f77be35 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -930,6 +930,7 @@ static const char *config_term_names[__PARSE_EVENTS__TERM_TYPE_NR] = {
 	[PARSE_EVENTS__TERM_TYPE_OVERWRITE]		= "overwrite",
 	[PARSE_EVENTS__TERM_TYPE_NOOVERWRITE]		= "no-overwrite",
 	[PARSE_EVENTS__TERM_TYPE_DRV_CFG]		= "driver-config",
+	[PARSE_EVENTS__TERM_TYPE_PERCORE]		= "percore",
 };
 
 static bool config_term_shrinked;
@@ -950,6 +951,7 @@ config_term_avail(int term_type, struct parse_events_error *err)
 	case PARSE_EVENTS__TERM_TYPE_CONFIG2:
 	case PARSE_EVENTS__TERM_TYPE_NAME:
 	case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
+	case PARSE_EVENTS__TERM_TYPE_PERCORE:
 		return true;
 	default:
 		if (!err)
@@ -1041,6 +1043,14 @@ do {									   \
 	case PARSE_EVENTS__TERM_TYPE_MAX_EVENTS:
 		CHECK_TYPE_VAL(NUM);
 		break;
+	case PARSE_EVENTS__TERM_TYPE_PERCORE:
+		CHECK_TYPE_VAL(NUM);
+		if ((unsigned int)term->val.num > 1) {
+			err->str = strdup("expected 0 or 1");
+			err->idx = term->err_val;
+			return -EINVAL;
+		}
+		break;
 	default:
 		err->str = strdup("unknown term");
 		err->idx = term->err_term;
@@ -1179,6 +1189,10 @@ do {								\
 		case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
 			ADD_CONFIG_TERM(DRV_CFG, drv_cfg, term->val.str);
 			break;
+		case PARSE_EVENTS__TERM_TYPE_PERCORE:
+			ADD_CONFIG_TERM(PERCORE, percore,
+					term->val.num ? true : false);
+			break;
 		default:
 			break;
 		}
@@ -1233,6 +1247,18 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
 			 get_config_name(head_config), &config_terms);
 }
 
+static bool config_term_percore(struct list_head *config_terms)
+{
+	struct perf_evsel_config_term *term;
+
+	list_for_each_entry(term, config_terms, list) {
+		if (term->type == PERF_EVSEL__CONFIG_TERM_PERCORE)
+			return term->val.percore;
+	}
+
+	return false;
+}
+
 int parse_events_add_pmu(struct parse_events_state *parse_state,
 			 struct list_head *list, char *name,
 			 struct list_head *head_config,
@@ -1305,6 +1331,7 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 		evsel->metric_name = info.metric_name;
 		evsel->pmu_name = name;
 		evsel->use_uncore_alias = use_uncore_alias;
+		evsel->percore = config_term_percore(&evsel->config_terms);
 	}
 
 	return evsel ? 0 : -ENOMEM;
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 5ed035c..ad4fbf3 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -75,6 +75,7 @@ enum {
 	PARSE_EVENTS__TERM_TYPE_NOOVERWRITE,
 	PARSE_EVENTS__TERM_TYPE_OVERWRITE,
 	PARSE_EVENTS__TERM_TYPE_DRV_CFG,
+	PARSE_EVENTS__TERM_TYPE_PERCORE,
 	__PARSE_EVENTS__TERM_TYPE_NR,
 };
 
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 7805c71..7e9f8dc 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -274,6 +274,7 @@ inherit			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_INHERIT); }
 no-inherit		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_NOINHERIT); }
 overwrite		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_OVERWRITE); }
 no-overwrite		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_NOOVERWRITE); }
+percore			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_PERCORE); }
 ,			{ return ','; }
 "/"			{ BEGIN(INITIAL); return '/'; }
 {name_minus}		{ return str(yyscanner, PE_NAME); }
-- 
2.7.4

