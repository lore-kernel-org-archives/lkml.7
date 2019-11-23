Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91FAC432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 08:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BC132071C
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 08:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfKWIQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 03:16:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36264 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfKWIPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 03:15:12 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iYQZJ-0002WM-54; Sat, 23 Nov 2019 09:15:01 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B45CD1C19FD;
        Sat, 23 Nov 2019 09:15:00 +0100 (CET)
Date:   Sat, 23 Nov 2019 08:15:00 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf pmu: When using default config, record which
 bits of config were changed by the user
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191115124225.5247-13-adrian.hunter@intel.com>
References: <20191115124225.5247-13-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <157449690066.21853.17967904681518450208.tip-bot2@tip-bot2>
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

Commit-ID:     a1ac7de6902c1ea6def7a743f1d2e6ba429684b3
Gitweb:        https://git.kernel.org/tip/a1ac7de6902c1ea6def7a743f1d2e6ba429684b3
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Fri, 15 Nov 2019 14:42:22 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 22 Nov 2019 10:48:13 -03:00

perf pmu: When using default config, record which bits of config were changed by the user

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
 tools/perf/util/evsel.c        |  2 ++-
 tools/perf/util/evsel_config.h |  2 ++-
 tools/perf/util/parse-events.c | 42 ++++++++++++++++++++++++++++++++-
 tools/perf/util/pmu.c          | 10 ++++++++-
 tools/perf/util/pmu.h          |  1 +-
 5 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ad7665a..f4dea05 100644
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
index 6e654ed..1f8d2fe 100644
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
index fc5e27b..6c313c4 100644
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
index db1e571..e8d3489 100644
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
index 2eb7a70..6737e3d 100644
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
