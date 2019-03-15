Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74000C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 08:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42148218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 08:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbfCOINo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 04:13:44 -0400
Received: from mga02.intel.com ([134.134.136.20]:56884 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727557AbfCOINn (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 04:13:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Mar 2019 01:13:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,481,1544515200"; 
   d="scan'208";a="134268107"
Received: from skl.sh.intel.com ([10.239.159.132])
  by orsmga003.jf.intel.com with ESMTP; 15 Mar 2019 01:13:40 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 1/3] perf: Add a coresum event qualifier
Date:   Sat, 16 Mar 2019 00:04:14 +0800
Message-Id: <1552665856-27741-2-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552665856-27741-1-git-send-email-yao.jin@linux.intel.com>
References: <1552665856-27741-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a coresum event qualifier, like cpu/event=0,umask=0x3,coresum=1/,
that sums up the event counts for both hardware threads in a core.

We can already do this with --per-core, but it's often useful to do
this together with other metrics that are collected per hardware thread.
So we need to support this per-core counting on a event level.

This can be implemented in only the user tool, no kernel support needed.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/evsel.c        |  2 ++
 tools/perf/util/evsel.h        |  3 +++
 tools/perf/util/parse-events.c | 27 +++++++++++++++++++++++++++
 tools/perf/util/parse-events.h |  1 +
 tools/perf/util/parse-events.l |  1 +
 5 files changed, 34 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 3bbf73e..978e10b 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -803,6 +803,8 @@ static void apply_config_terms(struct perf_evsel *evsel,
 			break;
 		case PERF_EVSEL__CONFIG_TERM_DRV_CFG:
 			break;
+		case PERF_EVSEL__CONFIG_TERM_CORESUM:
+			break;
 		default:
 			break;
 		}
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index cc578e0..25a0777 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -50,6 +50,7 @@ enum term_type {
 	PERF_EVSEL__CONFIG_TERM_OVERWRITE,
 	PERF_EVSEL__CONFIG_TERM_DRV_CFG,
 	PERF_EVSEL__CONFIG_TERM_BRANCH,
+	PERF_EVSEL__CONFIG_TERM_CORESUM,
 };
 
 struct perf_evsel_config_term {
@@ -67,6 +68,7 @@ struct perf_evsel_config_term {
 		bool	overwrite;
 		char	*branch;
 		unsigned long max_events;
+		bool	coresum;
 	} val;
 	bool weak;
 };
@@ -150,6 +152,7 @@ struct perf_evsel {
 	struct perf_evsel	**metric_events;
 	bool			collect_stat;
 	bool			weak_group;
+	bool			coresum;
 	const char		*pmu_name;
 };
 
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 4dcc01b..9c2808c 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -930,6 +930,7 @@ static const char *config_term_names[__PARSE_EVENTS__TERM_TYPE_NR] = {
 	[PARSE_EVENTS__TERM_TYPE_OVERWRITE]		= "overwrite",
 	[PARSE_EVENTS__TERM_TYPE_NOOVERWRITE]		= "no-overwrite",
 	[PARSE_EVENTS__TERM_TYPE_DRV_CFG]		= "driver-config",
+	[PARSE_EVENTS__TERM_TYPE_CORESUM]		= "coresum",
 };
 
 static bool config_term_shrinked;
@@ -950,6 +951,7 @@ config_term_avail(int term_type, struct parse_events_error *err)
 	case PARSE_EVENTS__TERM_TYPE_CONFIG2:
 	case PARSE_EVENTS__TERM_TYPE_NAME:
 	case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
+	case PARSE_EVENTS__TERM_TYPE_CORESUM:
 		return true;
 	default:
 		if (!err)
@@ -1041,6 +1043,14 @@ do {									   \
 	case PARSE_EVENTS__TERM_TYPE_MAX_EVENTS:
 		CHECK_TYPE_VAL(NUM);
 		break;
+	case PARSE_EVENTS__TERM_TYPE_CORESUM:
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
+		case PARSE_EVENTS__TERM_TYPE_CORESUM:
+			ADD_CONFIG_TERM(CORESUM, coresum,
+					term->val.num ? 1 : 0);
+			break;
 		default:
 			break;
 		}
@@ -1233,6 +1247,18 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
 			 get_config_name(head_config), &config_terms);
 }
 
+static bool config_term_coresum(struct list_head *config_terms)
+{
+	struct perf_evsel_config_term *term;
+
+	list_for_each_entry(term, config_terms, list) {
+		if (term->type == PERF_EVSEL__CONFIG_TERM_CORESUM)
+			return term->val.coresum ? true : false;
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
+		evsel->coresum = config_term_coresum(&evsel->config_terms);
 	}
 
 	return evsel ? 0 : -ENOMEM;
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 5ed035c..8d259c5 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -75,6 +75,7 @@ enum {
 	PARSE_EVENTS__TERM_TYPE_NOOVERWRITE,
 	PARSE_EVENTS__TERM_TYPE_OVERWRITE,
 	PARSE_EVENTS__TERM_TYPE_DRV_CFG,
+	PARSE_EVENTS__TERM_TYPE_CORESUM,
 	__PARSE_EVENTS__TERM_TYPE_NR,
 };
 
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 7805c71..3410bc5 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -274,6 +274,7 @@ inherit			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_INHERIT); }
 no-inherit		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_NOINHERIT); }
 overwrite		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_OVERWRITE); }
 no-overwrite		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_NOOVERWRITE); }
+coresum			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_CORESUM); }
 ,			{ return ','; }
 "/"			{ BEGIN(INITIAL); return '/'; }
 {name_minus}		{ return str(yyscanner, PE_NAME); }
-- 
2.7.4

