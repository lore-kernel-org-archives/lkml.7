Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CC9C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F405A20B7C
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="E1P5WBOE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbfERJfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 05:35:40 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47507 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfERJfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 05:35:40 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I9ZODk1742731
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 02:35:24 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I9ZODk1742731
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558172125;
        bh=8vwNrmBX1okiaqWR8y0zQqBvBSadJHK05ZjwUDUPFZE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=E1P5WBOEY99iOFeHF3K2K/DZyv2cn2rzQ5s98qf55KCtsIod/p7KWwJue+5LfSqOn
         OyuuwybjTaee+FyZclOKkPEwUVPV2J79nbVexPC5/6+jqfSLnHz48fPVbC72T/V/V8
         q0I0vnph9AsnU3dCsVzDkv3gZLT9oxvv+Mmb351KMySpE7rp62z5npLH1JTqpnJ3Uo
         8F+2OgUQ2Yl8w3+DwtJWF0oE8T2KH30Hj2iNC1HMtldgy2R5fLlM+MjfHo1n8I9fOa
         qeAqIlkcjvvZf0VkJ1KC4fdBNVMgsRI01gI/vCBlN+Kli6ojEJV3HgRMk4w7l6I52f
         nI+0ZjRax6v7Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I9ZOYx1742728;
        Sat, 18 May 2019 02:35:24 -0700
Date:   Sat, 18 May 2019 02:35:24 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jin Yao <tipbot@zytor.com>
Message-ID: <tip-064b4e82aa1633c27c383cc686b87ced57e072d1@git.kernel.org>
Cc:     yao.jin@linux.intel.com, ravi.bangoria@linux.ibm.com,
        hpa@zytor.com, mingo@kernel.org, acme@redhat.com, jolsa@kernel.org,
        yao.jin@intel.com, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, kan.liang@linux.intel.com, tglx@linutronix.de
Reply-To: hpa@zytor.com, ravi.bangoria@linux.ibm.com,
          yao.jin@linux.intel.com, yao.jin@intel.com, jolsa@kernel.org,
          acme@redhat.com, mingo@kernel.org, kan.liang@linux.intel.com,
          tglx@linutronix.de, peterz@infradead.org,
          alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
          ak@linux.intel.com
In-Reply-To: <1555077590-27664-2-git-send-email-yao.jin@linux.intel.com>
References: <1555077590-27664-2-git-send-email-yao.jin@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Add a 'percore' event qualifier
Git-Commit-ID: 064b4e82aa1633c27c383cc686b87ced57e072d1
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  064b4e82aa1633c27c383cc686b87ced57e072d1
Gitweb:     https://git.kernel.org/tip/064b4e82aa1633c27c383cc686b87ced57e072d1
Author:     Jin Yao <yao.jin@linux.intel.com>
AuthorDate: Fri, 12 Apr 2019 21:59:47 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 16 May 2019 14:17:24 -0300

perf tools: Add a 'percore' event qualifier

Add a 'percore' event qualifier, like cpu/event=0,umask=0x3,percore=1/,
that sums up the event counts for both hardware threads in a core.

We can already do this with --per-core, but it's often useful to do
this together with other metrics that are collected per hardware thread.
So we need to support this per-core counting on a event level.

This can be implemented in only the user tool, no kernel support needed.

 v4:
 ---
 1. Add Arnaldo's patch which updates the documentation for
    this new qualifier.
 2. Rebase to latest perf/core branch

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
Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1555077590-27664-2-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-list.txt | 12 ++++++++++++
 tools/perf/util/evsel.c                |  2 ++
 tools/perf/util/evsel.h                |  3 +++
 tools/perf/util/parse-events.c         | 27 +++++++++++++++++++++++++++
 tools/perf/util/parse-events.h         |  1 +
 tools/perf/util/parse-events.l         |  1 +
 6 files changed, 46 insertions(+)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 138fb6e94b3c..18ed1b0fceb3 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -199,6 +199,18 @@ also be supplied. For example:
 
   perf stat -C 0 -e 'hv_gpci/dtbp_ptitc,phys_processor_idx=0x2/' ...
 
+EVENT QUALIFIERS:
+
+It is also possible to add extra qualifiers to an event:
+
+percore:
+
+Sums up the event counts for all hardware threads in a core, e.g.:
+
+
+  perf stat -e cpu/event=0,umask=0x3,percore=1/
+
+
 EVENT GROUPS
 ------------
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index a10cf4cde920..a6f572a40deb 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -813,6 +813,8 @@ static void apply_config_terms(struct perf_evsel *evsel,
 			break;
 		case PERF_EVSEL__CONFIG_TERM_DRV_CFG:
 			break;
+		case PERF_EVSEL__CONFIG_TERM_PERCORE:
+			break;
 		default:
 			break;
 		}
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 6d190cbf1070..cad54e8ba522 100644
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
@@ -158,6 +160,7 @@ struct perf_evsel {
 	struct perf_evsel	**metric_events;
 	bool			collect_stat;
 	bool			weak_group;
+	bool			percore;
 	const char		*pmu_name;
 	struct {
 		perf_evsel__sb_cb_t	*cb;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 4432bfe039fd..cf0b9b81c5aa 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -950,6 +950,7 @@ static const char *config_term_names[__PARSE_EVENTS__TERM_TYPE_NR] = {
 	[PARSE_EVENTS__TERM_TYPE_OVERWRITE]		= "overwrite",
 	[PARSE_EVENTS__TERM_TYPE_NOOVERWRITE]		= "no-overwrite",
 	[PARSE_EVENTS__TERM_TYPE_DRV_CFG]		= "driver-config",
+	[PARSE_EVENTS__TERM_TYPE_PERCORE]		= "percore",
 };
 
 static bool config_term_shrinked;
@@ -970,6 +971,7 @@ config_term_avail(int term_type, struct parse_events_error *err)
 	case PARSE_EVENTS__TERM_TYPE_CONFIG2:
 	case PARSE_EVENTS__TERM_TYPE_NAME:
 	case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
+	case PARSE_EVENTS__TERM_TYPE_PERCORE:
 		return true;
 	default:
 		if (!err)
@@ -1061,6 +1063,14 @@ do {									   \
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
@@ -1199,6 +1209,10 @@ do {								\
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
@@ -1260,6 +1274,18 @@ int parse_events_add_tool(struct parse_events_state *parse_state,
 	return add_event_tool(list, &parse_state->idx, tool_event);
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
@@ -1333,6 +1359,7 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 		evsel->metric_name = info.metric_name;
 		evsel->pmu_name = name;
 		evsel->use_uncore_alias = use_uncore_alias;
+		evsel->percore = config_term_percore(&evsel->config_terms);
 	}
 
 	return evsel ? 0 : -ENOMEM;
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index a052cd6ac63e..f7139e1a2fd3 100644
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
index c54bfe88626c..ca6098874fe2 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -283,6 +283,7 @@ inherit			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_INHERIT); }
 no-inherit		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_NOINHERIT); }
 overwrite		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_OVERWRITE); }
 no-overwrite		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_NOOVERWRITE); }
+percore			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_PERCORE); }
 ,			{ return ','; }
 "/"			{ BEGIN(INITIAL); return '/'; }
 {name_minus}		{ return str(yyscanner, PE_NAME); }
