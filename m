Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F06C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65F052072D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbfKOMnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 07:43:37 -0500
Received: from mga14.intel.com ([192.55.52.115]:58938 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727644AbfKOMnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 07:43:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2019 04:43:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,308,1569308400"; 
   d="scan'208";a="257749676"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.197])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Nov 2019 04:43:32 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 07/15] perf record: Add aux-sample-size config term
Date:   Fri, 15 Nov 2019 14:42:17 +0200
Message-Id: <20191115124225.5247-8-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115124225.5247-1-adrian.hunter@intel.com>
References: <20191115124225.5247-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow individual events to be selected for AUX area sampling, add
aux-sample-size config term. attr.aux_sample_size is updated by
auxtrace_parse_sample_options() so that the existing validation will see
the value. Any event that has a non-zero aux_sample_size will cause AUX
area sampling to be configured, irrespective of the --aux-sample option.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-record.txt |  3 +
 tools/perf/util/auxtrace.c               | 76 +++++++++++++++++++++++-
 tools/perf/util/evsel.c                  | 16 +++++
 tools/perf/util/evsel_config.h           | 11 ++++
 tools/perf/util/parse-events.c           | 14 +++++
 tools/perf/util/parse-events.h           |  1 +
 tools/perf/util/parse-events.l           |  1 +
 7 files changed, 121 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index e216d7b529c9..b23a4012a606 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -62,6 +62,9 @@ OPTIONS
 		    like this: name=\'CPU_CLK_UNHALTED.THREAD:cmask=0x1\'.
 	  - 'aux-output': Generate AUX records instead of events. This requires
 			  that an AUX area event is also provided.
+	  - 'aux-sample-size': Set sample size for AUX area sampling. If the
+	  '--aux-sample' option has been used, set aux-sample-size=0 to disable
+	  AUX area sampling for the event.
 
           See the linkperf:perf-list[1] man page for more parameters.
 
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 51fbe01f8a11..026585b67a3c 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -31,6 +31,7 @@
 #include "map.h"
 #include "pmu.h"
 #include "evsel.h"
+#include "evsel_config.h"
 #include "symbol.h"
 #include "util/synthetic-events.h"
 #include "thread_map.h"
@@ -76,6 +77,53 @@ static bool perf_evsel__is_aux_event(struct evsel *evsel)
 	return pmu && pmu->auxtrace;
 }
 
+/*
+ * Make a group from 'leader' to 'last', requiring that the events were not
+ * already grouped to a different leader.
+ */
+static int perf_evlist__regroup(struct evlist *evlist,
+				struct evsel *leader,
+				struct evsel *last)
+{
+	struct evsel *evsel;
+	bool grp;
+
+	if (!perf_evsel__is_group_leader(leader))
+		return -EINVAL;
+
+	grp = false;
+	evlist__for_each_entry(evlist, evsel) {
+		if (grp) {
+			if (!(evsel->leader == leader ||
+			     (evsel->leader == evsel &&
+			      evsel->core.nr_members <= 1)))
+				return -EINVAL;
+		} else if (evsel == leader) {
+			grp = true;
+		}
+		if (evsel == last)
+			break;
+	}
+
+	grp = false;
+	evlist__for_each_entry(evlist, evsel) {
+		if (grp) {
+			if (evsel->leader != leader) {
+				evsel->leader = leader;
+				if (leader->core.nr_members < 1)
+					leader->core.nr_members = 1;
+				leader->core.nr_members += 1;
+			}
+		} else if (evsel == leader) {
+			grp = true;
+		}
+		if (evsel == last)
+			break;
+	}
+
+	return 0;
+}
+
 static bool auxtrace__dont_decode(struct perf_session *session)
 {
 	return !session->itrace_synth_opts ||
@@ -679,13 +727,16 @@ int auxtrace_parse_sample_options(struct auxtrace_record *itr,
 				  struct evlist *evlist,
 				  struct record_opts *opts, const char *str)
 {
+	struct perf_evsel_config_term *term;
+	struct evsel *aux_evsel;
+	bool has_aux_sample_size = false;
 	bool has_aux_leader = false;
 	struct evsel *evsel;
 	char *endptr;
 	unsigned long sz;
 
 	if (!str)
-		return 0;
+		goto no_opt;
 
 	if (!itr) {
 		pr_err("No AUX area event to sample\n");
@@ -712,6 +763,29 @@ int auxtrace_parse_sample_options(struct auxtrace_record *itr,
 			evsel->core.attr.aux_sample_size = sz;
 		}
 	}
+no_opt:
+	aux_evsel = NULL;
+	/* Override with aux_sample_size from config term */
+	evlist__for_each_entry(evlist, evsel) {
+		if (perf_evsel__is_aux_event(evsel))
+			aux_evsel = evsel;
+		term = perf_evsel__get_config_term(evsel, AUX_SAMPLE_SIZE);
+		if (term) {
+			has_aux_sample_size = true;
+			evsel->core.attr.aux_sample_size = term->val.aux_sample_size;
+			/* If possible, group with the AUX event */
+			if (aux_evsel && evsel->core.attr.aux_sample_size)
+				perf_evlist__regroup(evlist, aux_evsel, evsel);
+		}
+	}
+
+	if (!str && !has_aux_sample_size)
+		return 0;
+
+	if (!itr) {
+		pr_err("No AUX area event to sample\n");
+		return -EINVAL;
+	}
 
 	return auxtrace_validate_aux_sample_size(evlist, opts);
 }
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 772f4879c492..ad7665a546cf 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -846,6 +846,9 @@ static void apply_config_terms(struct evsel *evsel,
 		case PERF_EVSEL__CONFIG_TERM_AUX_OUTPUT:
 			attr->aux_output = term->val.aux_output ? 1 : 0;
 			break;
+		case PERF_EVSEL__CONFIG_TERM_AUX_SAMPLE_SIZE:
+			/* Already applied by auxtrace */
+			break;
 		default:
 			break;
 		}
@@ -905,6 +908,19 @@ static bool is_dummy_event(struct evsel *evsel)
 	       (evsel->core.attr.config == PERF_COUNT_SW_DUMMY);
 }
 
+struct perf_evsel_config_term *__perf_evsel__get_config_term(struct evsel *evsel,
+							     enum evsel_term_type type)
+{
+	struct perf_evsel_config_term *term, *found_term = NULL;
+
+	list_for_each_entry(term, &evsel->config_terms, list) {
+		if (term->type == type)
+			found_term = term;
+	}
+
+	return found_term;
+}
+
 /*
  * The enable_on_exec/disabled value strategy:
  *
diff --git a/tools/perf/util/evsel_config.h b/tools/perf/util/evsel_config.h
index 8a7648037c18..6e654ede8fbe 100644
--- a/tools/perf/util/evsel_config.h
+++ b/tools/perf/util/evsel_config.h
@@ -25,6 +25,7 @@ enum evsel_term_type {
 	PERF_EVSEL__CONFIG_TERM_BRANCH,
 	PERF_EVSEL__CONFIG_TERM_PERCORE,
 	PERF_EVSEL__CONFIG_TERM_AUX_OUTPUT,
+	PERF_EVSEL__CONFIG_TERM_AUX_SAMPLE_SIZE,
 };
 
 struct perf_evsel_config_term {
@@ -44,7 +45,17 @@ struct perf_evsel_config_term {
 		unsigned long max_events;
 		bool	      percore;
 		bool	      aux_output;
+		u32	      aux_sample_size;
 	} val;
 	bool weak;
 };
+
+struct evsel;
+
+struct perf_evsel_config_term *__perf_evsel__get_config_term(struct evsel *evsel,
+							     enum evsel_term_type type);
+
+#define perf_evsel__get_config_term(evsel, type) \
+	__perf_evsel__get_config_term(evsel, PERF_EVSEL__CONFIG_TERM_ ## type)
+
 #endif // __PERF_EVSEL_CONFIG_H
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 6d18ff9bce49..73e0bf293c12 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -979,6 +979,7 @@ static const char *config_term_names[__PARSE_EVENTS__TERM_TYPE_NR] = {
 	[PARSE_EVENTS__TERM_TYPE_DRV_CFG]		= "driver-config",
 	[PARSE_EVENTS__TERM_TYPE_PERCORE]		= "percore",
 	[PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT]		= "aux-output",
+	[PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE]	= "aux-sample-size",
 };
 
 static bool config_term_shrinked;
@@ -1109,6 +1110,15 @@ do {									   \
 	case PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT:
 		CHECK_TYPE_VAL(NUM);
 		break;
+	case PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE:
+		CHECK_TYPE_VAL(NUM);
+		if (term->val.num > UINT_MAX) {
+			parse_events__handle_error(err, term->err_val,
+						strdup("too big"),
+						NULL);
+			return -EINVAL;
+		}
+		break;
 	default:
 		parse_events__handle_error(err, term->err_term,
 				strdup("unknown term"),
@@ -1160,6 +1170,7 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
 	case PARSE_EVENTS__TERM_TYPE_OVERWRITE:
 	case PARSE_EVENTS__TERM_TYPE_NOOVERWRITE:
 	case PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT:
+	case PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE:
 		return config_term_common(attr, term, err);
 	default:
 		if (err) {
@@ -1255,6 +1266,9 @@ do {								\
 		case PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT:
 			ADD_CONFIG_TERM(AUX_OUTPUT, aux_output, term->val.num ? 1 : 0);
 			break;
+		case PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE:
+			ADD_CONFIG_TERM(AUX_SAMPLE_SIZE, aux_sample_size, term->val.num);
+			break;
 		default:
 			break;
 		}
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 5ee8ac93840c..16d57294f332 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -77,6 +77,7 @@ enum {
 	PARSE_EVENTS__TERM_TYPE_DRV_CFG,
 	PARSE_EVENTS__TERM_TYPE_PERCORE,
 	PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT,
+	PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE,
 	__PARSE_EVENTS__TERM_TYPE_NR,
 };
 
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 7469497cd28e..7b1c8ee537cf 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -285,6 +285,7 @@ overwrite		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_OVERWRITE); }
 no-overwrite		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_NOOVERWRITE); }
 percore			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_PERCORE); }
 aux-output		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT); }
+aux-sample-size		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE); }
 ,			{ return ','; }
 "/"			{ BEGIN(INITIAL); return '/'; }
 {name_minus}		{ return str(yyscanner, PE_NAME); }
-- 
2.17.1

