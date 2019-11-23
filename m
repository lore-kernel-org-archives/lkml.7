Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA60C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 08:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F7C2071C
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 08:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfKWIQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 03:16:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36257 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfKWIPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 03:15:13 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iYQZM-0002ZN-Gc; Sat, 23 Nov 2019 09:15:04 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 83F511C1AD1;
        Sat, 23 Nov 2019 09:15:01 +0100 (CET)
Date:   Sat, 23 Nov 2019 08:15:01 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf record: Add aux-sample-size config term
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191115124225.5247-8-adrian.hunter@intel.com>
References: <20191115124225.5247-8-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <157449690144.21853.15093480979478706398.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     eb7a52d46c6ac95df563f867d526b3d46616b10b
Gitweb:        https://git.kernel.org/tip/eb7a52d46c6ac95df563f867d526b3d46616b10b
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Fri, 15 Nov 2019 14:42:17 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 22 Nov 2019 10:48:13 -03:00

perf record: Add aux-sample-size config term

To allow individual events to be selected for AUX area sampling, add
aux-sample-size config term. attr.aux_sample_size is updated by
auxtrace_parse_sample_options() so that the existing validation will see
the value. Any event that has a non-zero aux_sample_size will cause AUX
area sampling to be configured, irrespective of the --aux-sample option.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20191115124225.5247-8-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-record.txt |  3 +-
 tools/perf/util/auxtrace.c               | 76 ++++++++++++++++++++++-
 tools/perf/util/evsel.c                  | 16 +++++-
 tools/perf/util/evsel_config.h           | 11 +++-
 tools/perf/util/parse-events.c           | 14 ++++-
 tools/perf/util/parse-events.h           |  1 +-
 tools/perf/util/parse-events.l           |  1 +-
 7 files changed, 121 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index e216d7b..b23a401 100644
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
index 51fbe01..026585b 100644
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
index 772f487..ad7665a 100644
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
index 8a76480..6e654ed 100644
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
index 6bae9d6..fc5e27b 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -996,6 +996,7 @@ static const char *config_term_names[__PARSE_EVENTS__TERM_TYPE_NR] = {
 	[PARSE_EVENTS__TERM_TYPE_DRV_CFG]		= "driver-config",
 	[PARSE_EVENTS__TERM_TYPE_PERCORE]		= "percore",
 	[PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT]		= "aux-output",
+	[PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE]	= "aux-sample-size",
 };
 
 static bool config_term_shrinked;
@@ -1126,6 +1127,15 @@ do {									   \
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
@@ -1177,6 +1187,7 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
 	case PARSE_EVENTS__TERM_TYPE_OVERWRITE:
 	case PARSE_EVENTS__TERM_TYPE_NOOVERWRITE:
 	case PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT:
+	case PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE:
 		return config_term_common(attr, term, err);
 	default:
 		if (err) {
@@ -1272,6 +1283,9 @@ do {								\
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
index ff367f2..27596cb 100644
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
index 7469497..7b1c8ee 100644
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
