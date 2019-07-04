Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5684C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9465C218A6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfGDQAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 12:00:54 -0400
Received: from mga03.intel.com ([134.134.136.65]:53366 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727087AbfGDQAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 12:00:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2019 09:00:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,451,1557212400"; 
   d="scan'208";a="185016993"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Jul 2019 09:00:41 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kan.liang@linux.intel.com, Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v1 6/7] perf tools: Add aux-source config term
Date:   Thu,  4 Jul 2019 19:00:23 +0300
Message-Id: <20190704160024.56600-7-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190704160024.56600-1-alexander.shishkin@linux.intel.com>
References: <20190704160024.56600-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Expose the aux_source attribute flag to the user to configure, by adding a
config term 'aux-source'. For events that support it, selection of
'aux-source' causes the generation of AUX records instead of event records.
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
index 15e0fa87241b..3077f6373dff 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -60,6 +60,8 @@ OPTIONS
 	  - 'name' : User defined event name. Single quotes (') may be used to
 		    escape symbols in the name from parsing by shell and tool
 		    like this: name=\'CPU_CLK_UNHALTED.THREAD:cmask=0x1\'.
+	  - 'aux-source': Generate AUX records instead of events. This requires
+			  that an AUX area event is also provided.
 
           See the linkperf:perf-list[1] man page for more parameters.
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 899dc189ff2d..ff5fafcff8df 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -832,6 +832,9 @@ static void apply_config_terms(struct perf_evsel *evsel,
 			break;
 		case PERF_EVSEL__CONFIG_TERM_PERCORE:
 			break;
+		case PERF_EVSEL__CONFIG_TERM_AUX_SOURCE:
+			attr->aux_source = term->val.aux_source ? 1 : 0;
+			break;
 		default:
 			break;
 		}
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index cad54e8ba522..295d32fd42ba 100644
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
+		bool	aux_source;
 	} val;
 	bool weak;
 };
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index cf0b9b81c5aa..1048227f3eda 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -951,6 +951,7 @@ static const char *config_term_names[__PARSE_EVENTS__TERM_TYPE_NR] = {
 	[PARSE_EVENTS__TERM_TYPE_NOOVERWRITE]		= "no-overwrite",
 	[PARSE_EVENTS__TERM_TYPE_DRV_CFG]		= "driver-config",
 	[PARSE_EVENTS__TERM_TYPE_PERCORE]		= "percore",
+	[PARSE_EVENTS__TERM_TYPE_AUX_SOURCE]		= "aux-source",
 };
 
 static bool config_term_shrinked;
@@ -1071,6 +1072,9 @@ do {									   \
 			return -EINVAL;
 		}
 		break;
+	case PARSE_EVENTS__TERM_TYPE_AUX_SOURCE:
+		CHECK_TYPE_VAL(NUM);
+		break;
 	default:
 		err->str = strdup("unknown term");
 		err->idx = term->err_term;
@@ -1121,6 +1125,7 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
 	case PARSE_EVENTS__TERM_TYPE_MAX_EVENTS:
 	case PARSE_EVENTS__TERM_TYPE_OVERWRITE:
 	case PARSE_EVENTS__TERM_TYPE_NOOVERWRITE:
+	case PARSE_EVENTS__TERM_TYPE_AUX_SOURCE:
 		return config_term_common(attr, term, err);
 	default:
 		if (err) {
@@ -1213,6 +1218,9 @@ do {								\
 			ADD_CONFIG_TERM(PERCORE, percore,
 					term->val.num ? true : false);
 			break;
+		case PARSE_EVENTS__TERM_TYPE_AUX_SOURCE:
+			ADD_CONFIG_TERM(AUX_SOURCE, aux_source, term->val.num ? 1 : 0);
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
index ca6098874fe2..399605a64c3d 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -284,6 +284,7 @@ no-inherit		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_NOINHERIT); }
 overwrite		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_OVERWRITE); }
 no-overwrite		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_NOOVERWRITE); }
 percore			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_PERCORE); }
+aux-source		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_SOURCE); }
 ,			{ return ','; }
 "/"			{ BEGIN(INITIAL); return '/'; }
 {name_minus}		{ return str(yyscanner, PE_NAME); }
-- 
2.20.1

