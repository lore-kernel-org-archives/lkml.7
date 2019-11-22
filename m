Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30196C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 14:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F390A2075B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 14:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574434697;
	bh=hWoigqBHbzS6dVqaCF23/6XuZ0aEotA12dAXx16wvzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fEvmJ/HaruW3vTdAA2Mpk13VgOKDqIA2lxTVaku3PPorp06pu53H3/8EmB6WoOJa5
	 iEoNyD1A735AufmacEq1lrHkq1ui6C5ufHfIqc+Z2EOHJCnK3CV+Z35Lpl5Y8xRwbG
	 75u5xEplE0ogNEQjivzIUOqUOEt7tDT2uS4oiyx8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfKVO6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 09:58:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:59206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727551AbfKVO6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 09:58:12 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63A382072D;
        Fri, 22 Nov 2019 14:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574434691;
        bh=hWoigqBHbzS6dVqaCF23/6XuZ0aEotA12dAXx16wvzw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VSdqFPAInDqdD43Hgkp7loF+V6J9KRHEw/pM039DXLJlKdU0fhFPhF5BNiW0bM3PU
         WwDIfN50n3/qSTB+GfisN2Su1MzjpwR7qo4rOeEhTpACqtDcqsmgTSaf/P5L4VHnE6
         Sci0nK//24/dwJk08oHmvbjWgUvAsK+Er8N0xRsU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 19/26] perf pmu: When using default config, record which bits of config were changed by the user
Date:   Fri, 22 Nov 2019 11:57:04 -0300
Message-Id: <20191122145711.3171-20-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191122145711.3171-1-acme@kernel.org>
References: <20191122145711.3171-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Default config for a PMU is defined before selected events are parsed.
That allows the user-entered config to override the default config.

However that does not allow for changing the default config based on
other options.

For example, if the user chooses AUX area sampling mode, in the case of
Intel PT, the psb_period needs to be small for sampling, so there is a
need to set the default psb_period to 0 (2 KiB) in that case. However
that should not override a value set by the user. To allow for that,
when using default config, record which bits of config were changed by
the user.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20191115124225.5247-13-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c        |  2 ++
 tools/perf/util/evsel_config.h |  2 ++
 tools/perf/util/parse-events.c | 42 +++++++++++++++++++++++++++++++++-
 tools/perf/util/pmu.c          | 10 ++++++++
 tools/perf/util/pmu.h          |  1 +
 5 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ad7665a546cf..f4dea055b080 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -849,6 +849,8 @@ static void apply_config_terms(struct evsel *evsel,
 		case PERF_EVSEL__CONFIG_TERM_AUX_SAMPLE_SIZE:
 			/* Already applied by auxtrace */
 			break;
+		case PERF_EVSEL__CONFIG_TERM_CFG_CHG:
+			break;
 		default:
 			break;
 		}
diff --git a/tools/perf/util/evsel_config.h b/tools/perf/util/evsel_config.h
index 6e654ede8fbe..1f8d2fe0b66e 100644
--- a/tools/perf/util/evsel_config.h
+++ b/tools/perf/util/evsel_config.h
@@ -26,6 +26,7 @@ enum evsel_term_type {
 	PERF_EVSEL__CONFIG_TERM_PERCORE,
 	PERF_EVSEL__CONFIG_TERM_AUX_OUTPUT,
 	PERF_EVSEL__CONFIG_TERM_AUX_SAMPLE_SIZE,
+	PERF_EVSEL__CONFIG_TERM_CFG_CHG,
 };
 
 struct perf_evsel_config_term {
@@ -46,6 +47,7 @@ struct perf_evsel_config_term {
 		bool	      percore;
 		bool	      aux_output;
 		u32	      aux_sample_size;
+		u64	      cfg_chg;
 	} val;
 	bool weak;
 };
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index fc5e27bc8315..6c313c4087ed 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1290,7 +1290,40 @@ do {								\
 			break;
 		}
 	}
-#undef ADD_EVSEL_CONFIG
+	return 0;
+}
+
+/*
+ * Add PERF_EVSEL__CONFIG_TERM_CFG_CHG where cfg_chg will have a bit set for
+ * each bit of attr->config that the user has changed.
+ */
+static int get_config_chgs(struct perf_pmu *pmu, struct list_head *head_config,
+			   struct list_head *head_terms)
+{
+	struct parse_events_term *term;
+	u64 bits = 0;
+	int type;
+
+	list_for_each_entry(term, head_config, list) {
+		switch (term->type_term) {
+		case PARSE_EVENTS__TERM_TYPE_USER:
+			type = perf_pmu__format_type(&pmu->format, term->config);
+			if (type != PERF_PMU_FORMAT_VALUE_CONFIG)
+				continue;
+			bits |= perf_pmu__format_bits(&pmu->format, term->config);
+			break;
+		case PARSE_EVENTS__TERM_TYPE_CONFIG:
+			bits = ~(u64)0;
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (bits)
+		ADD_CONFIG_TERM(CFG_CHG, cfg_chg, bits);
+
+#undef ADD_CONFIG_TERM
 	return 0;
 }
 
@@ -1419,6 +1452,13 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 	if (get_config_terms(head_config, &config_terms))
 		return -ENOMEM;
 
+	/*
+	 * When using default config, record which bits of attr->config were
+	 * changed by the user.
+	 */
+	if (pmu->default_config && get_config_chgs(pmu, head_config, &config_terms))
+		return -ENOMEM;
+
 	if (perf_pmu__config(pmu, &attr, head_config, parse_state->error)) {
 		struct perf_evsel_config_term *pos, *tmp;
 
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index db1e57113f4b..e8d348988026 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -931,6 +931,16 @@ __u64 perf_pmu__format_bits(struct list_head *formats, const char *name)
 	return bits;
 }
 
+int perf_pmu__format_type(struct list_head *formats, const char *name)
+{
+	struct perf_pmu_format *format = pmu_find_format(formats, name);
+
+	if (!format)
+		return -1;
+
+	return format->value;
+}
+
 /*
  * Sets value based on the format definition (format parameter)
  * and unformated value (value parameter).
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 2eb7a7001307..6737e3d5d568 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -72,6 +72,7 @@ int perf_pmu__config_terms(struct list_head *formats,
 			   struct list_head *head_terms,
 			   bool zero, struct parse_events_error *error);
 __u64 perf_pmu__format_bits(struct list_head *formats, const char *name);
+int perf_pmu__format_type(struct list_head *formats, const char *name);
 int perf_pmu__check_alias(struct perf_pmu *pmu, struct list_head *head_terms,
 			  struct perf_pmu_info *info);
 struct list_head *perf_pmu__alias(struct perf_pmu *pmu,
-- 
2.21.0

