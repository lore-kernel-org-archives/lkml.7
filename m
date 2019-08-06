Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E1FC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8042218D8
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732164AbfHFH3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 03:29:07 -0400
Received: from mga02.intel.com ([134.134.136.20]:31206 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731557AbfHFH3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 03:29:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2019 00:24:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,352,1559545200"; 
   d="scan'208";a="325555423"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 06 Aug 2019 00:24:52 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kan.liang@linux.intel.com, Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v5 6/7] perf tools: Add aux-output config term
Date:   Tue,  6 Aug 2019 10:24:32 +0300
Message-Id: <20190806072433.26820-7-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806072433.26820-1-alexander.shishkin@linux.intel.com>
References: <20190806072433.26820-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Expose the aux_output attribute flag to the user to configure, by adding a
config term 'aux-output'. For events that support it, selection of
'aux-output' causes the generation of AUX records instead of event records.
This requires that an AUX area event is also provided.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 tools/perf/Documentation/perf-record.txt | 2 ++
 tools/perf/util/evsel.c                  | 3 +++
 tools/perf/util/evsel.h                  | 2 ++
 tools/perf/util/parse-events.c           | 8 ++++++++
 tools/perf/util/parse-events.h           | 1 +
 tools/perf/util/parse-events.l           | 1 +
 6 files changed, 17 insertions(+)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 15e0fa87241b..566050066c77 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -60,6 +60,8 @@ OPTIONS
 	  - 'name' : User defined event name. Single quotes (') may be used to
 		    escape symbols in the name from parsing by shell and tool
 		    like this: name=\'CPU_CLK_UNHALTED.THREAD:cmask=0x1\'.
+	  - 'aux-output': Generate AUX records instead of events. This requires
+			  that an AUX area event is also provided.
 
           See the linkperf:perf-list[1] man page for more parameters.
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 9ec8782d3226..0530ad796033 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -832,6 +832,9 @@ static void apply_config_terms(struct perf_evsel *evsel,
 			break;
 		case PERF_EVSEL__CONFIG_TERM_PERCORE:
 			break;
+		case PERF_EVSEL__CONFIG_TERM_AUX_SOURCE:
+			attr->aux_output = term->val.aux_output ? 1 : 0;
+			break;
 		default:
 			break;
 		}
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index cad54e8ba522..fa18358a806b 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -51,6 +51,7 @@ enum term_type {
 	PERF_EVSEL__CONFIG_TERM_DRV_CFG,
 	PERF_EVSEL__CONFIG_TERM_BRANCH,
 	PERF_EVSEL__CONFIG_TERM_PERCORE,
+	PERF_EVSEL__CONFIG_TERM_AUX_SOURCE,
 };
 
 struct perf_evsel_config_term {
@@ -69,6 +70,7 @@ struct perf_evsel_config_term {
 		char	*branch;
 		unsigned long max_events;
 		bool	percore;
+		bool	aux_output;
 	} val;
 	bool weak;
 };
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 371ff3aee769..20ad7eb2c27f 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -952,6 +952,7 @@ static const char *config_term_names[__PARSE_EVENTS__TERM_TYPE_NR] = {
 	[PARSE_EVENTS__TERM_TYPE_NOOVERWRITE]		= "no-overwrite",
 	[PARSE_EVENTS__TERM_TYPE_DRV_CFG]		= "driver-config",
 	[PARSE_EVENTS__TERM_TYPE_PERCORE]		= "percore",
+	[PARSE_EVENTS__TERM_TYPE_AUX_SOURCE]		= "aux-output",
 };
 
 static bool config_term_shrinked;
@@ -1072,6 +1073,9 @@ do {									   \
 			return -EINVAL;
 		}
 		break;
+	case PARSE_EVENTS__TERM_TYPE_AUX_SOURCE:
+		CHECK_TYPE_VAL(NUM);
+		break;
 	default:
 		err->str = strdup("unknown term");
 		err->idx = term->err_term;
@@ -1122,6 +1126,7 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
 	case PARSE_EVENTS__TERM_TYPE_MAX_EVENTS:
 	case PARSE_EVENTS__TERM_TYPE_OVERWRITE:
 	case PARSE_EVENTS__TERM_TYPE_NOOVERWRITE:
+	case PARSE_EVENTS__TERM_TYPE_AUX_SOURCE:
 		return config_term_common(attr, term, err);
 	default:
 		if (err) {
@@ -1214,6 +1219,9 @@ do {								\
 			ADD_CONFIG_TERM(PERCORE, percore,
 					term->val.num ? true : false);
 			break;
+		case PARSE_EVENTS__TERM_TYPE_AUX_SOURCE:
+			ADD_CONFIG_TERM(AUX_SOURCE, aux_output, term->val.num ? 1 : 0);
+			break;
 		default:
 			break;
 		}
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index f7139e1a2fd3..782195ce8238 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -76,6 +76,7 @@ enum {
 	PARSE_EVENTS__TERM_TYPE_OVERWRITE,
 	PARSE_EVENTS__TERM_TYPE_DRV_CFG,
 	PARSE_EVENTS__TERM_TYPE_PERCORE,
+	PARSE_EVENTS__TERM_TYPE_AUX_SOURCE,
 	__PARSE_EVENTS__TERM_TYPE_NR,
 };
 
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index ca6098874fe2..b73d4af6c88b 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -284,6 +284,7 @@ no-inherit		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_NOINHERIT); }
 overwrite		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_OVERWRITE); }
 no-overwrite		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_NOOVERWRITE); }
 percore			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_PERCORE); }
+aux-output		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_SOURCE); }
 ,			{ return ','; }
 "/"			{ BEGIN(INITIAL); return '/'; }
 {name_minus}		{ return str(yyscanner, PE_NAME); }
-- 
2.20.1

