Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D6FC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95F7321D7B
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569458185;
	bh=GM0/1mzuU9vs2/T+VGFFTUPZO72rFSCUJUXXugPalR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gFLIPnHDa1uxpm23p9MSQaMcPWSCnIO43iaxBVTdNoboo+UpDXdE5yOCME9XSia3y
	 HOWGmMPOxE0WwVntxHUflgHs/pLoHqiVrAAqPQ+MaYRYUeHBXHW8RS0oBpjk6OQcBE
	 9S2fDcgzhY4OHaYQSqJ/ghJPT729WW6/clfzEb5Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390504AbfIZAgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 20:36:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390455AbfIZAgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:36:21 -0400
Received: from quaco.localdomain (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95BC5222C2;
        Thu, 26 Sep 2019 00:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569458180;
        bh=GM0/1mzuU9vs2/T+VGFFTUPZO72rFSCUJUXXugPalR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P/XsBThutLuCw4hXtt30bWvWIIjDRY5tQv3sIZNI8C3LnpqygY3BkPeDPRLmAcaa0
         x5Lugdl6hVZBZdU0TtshtonGIGta6mM07L1xHREFa8Jt95Yz829gm8oRyPm8HjEtDu
         IEWBnHnIZ3sNk+bdd/aHEq0+cZakDk9Ydl9uVdR4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 56/66] perf evsel: Remove need for symbol_conf in evsel_fprintf.c
Date:   Wed, 25 Sep 2019 21:32:34 -0300
Message-Id: <20190926003244.13962-57-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So that we an later link it to the python binding without having to
drag the symbol object files.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-8823tveyasocnuoelq4qopwf@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-sched.c      |  2 +-
 tools/perf/builtin-script.c     |  6 ++++--
 tools/perf/builtin-trace.c      |  2 +-
 tools/perf/util/evsel.h         |  7 ++++---
 tools/perf/util/evsel_fprintf.c | 14 ++++++--------
 5 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 079e67a36904..f9706306fea0 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2055,7 +2055,7 @@ static void timehist_print_sample(struct perf_sched *sched,
 			    EVSEL__PRINT_SYM | EVSEL__PRINT_ONELINE |
 			    EVSEL__PRINT_CALLCHAIN_ARROW |
 			    EVSEL__PRINT_SKIP_IGNORED,
-			    &callchain_cursor, stdout);
+			    &callchain_cursor, symbol_conf.bt_stop_list,  stdout);
 
 out:
 	printf("\n");
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 22c1d114014c..0d43e2e5afff 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1325,7 +1325,8 @@ static int perf_sample__fprintf_bts(struct perf_sample *sample,
 		} else
 			printed += fprintf(fp, "\n");
 
-		printed += sample__fprintf_sym(sample, al, 0, print_opts, cursor, fp);
+		printed += sample__fprintf_sym(sample, al, 0, print_opts, cursor,
+					       symbol_conf.bt_stop_list, fp);
 	}
 
 	/* print branch_to information */
@@ -1867,7 +1868,8 @@ static void process_event(struct perf_script *script,
 			cursor = &callchain_cursor;
 
 		fputc(cursor ? '\n' : ' ', fp);
-		sample__fprintf_sym(sample, al, 0, output[type].print_ip_opts, cursor, fp);
+		sample__fprintf_sym(sample, al, 0, output[type].print_ip_opts, cursor,
+				    symbol_conf.bt_stop_list, fp);
 	}
 
 	if (PRINT_FIELD(IREGS))
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index c52c3120a811..318225c8d7a7 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2076,7 +2076,7 @@ static int trace__fprintf_callchain(struct trace *trace, struct perf_sample *sam
 				        EVSEL__PRINT_DSO |
 				        EVSEL__PRINT_UNKNOWN_AS_ADDR;
 
-	return sample__fprintf_callchain(sample, 38, print_opts, &callchain_cursor, trace->output);
+	return sample__fprintf_callchain(sample, 38, print_opts, &callchain_cursor, symbol_conf.bt_stop_list, trace->output);
 }
 
 static const char *errno_to_name(struct evsel *evsel, int err)
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index a5b29ac10da0..4a4c64833893 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -428,12 +428,13 @@ int perf_evsel__fprintf(struct evsel *evsel,
 struct callchain_cursor;
 
 int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
-			      unsigned int print_opts,
-			      struct callchain_cursor *cursor, FILE *fp);
+			      unsigned int print_opts, struct callchain_cursor *cursor,
+			      struct strlist *bt_stop_list, FILE *fp);
 
 int sample__fprintf_sym(struct perf_sample *sample, struct addr_location *al,
 			int left_alignment, unsigned int print_opts,
-			struct callchain_cursor *cursor, FILE *fp);
+			struct callchain_cursor *cursor,
+			struct strlist *bt_stop_list, FILE *fp);
 
 bool perf_evsel__fallback(struct evsel *evsel, int err,
 			  char *msg, size_t msgsize);
diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
index a8cbdf4c2753..756b1e852db7 100644
--- a/tools/perf/util/evsel_fprintf.c
+++ b/tools/perf/util/evsel_fprintf.c
@@ -102,7 +102,7 @@ int perf_evsel__fprintf(struct evsel *evsel,
 
 int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
 			      unsigned int print_opts, struct callchain_cursor *cursor,
-			      FILE *fp)
+			      struct strlist *bt_stop_list, FILE *fp)
 {
 	int printed = 0;
 	struct callchain_cursor_node *node;
@@ -175,10 +175,8 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
 				printed += fprintf(fp, "\n");
 
 			/* Add srccode here too? */
-			if (symbol_conf.bt_stop_list &&
-			    node->sym &&
-			    strlist__has_entry(symbol_conf.bt_stop_list,
-					       node->sym->name)) {
+			if (bt_stop_list && node->sym &&
+			    strlist__has_entry(bt_stop_list, node->sym->name)) {
 				break;
 			}
 
@@ -193,7 +191,7 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
 
 int sample__fprintf_sym(struct perf_sample *sample, struct addr_location *al,
 			int left_alignment, unsigned int print_opts,
-			struct callchain_cursor *cursor, FILE *fp)
+			struct callchain_cursor *cursor, struct strlist *bt_stop_list, FILE *fp)
 {
 	int printed = 0;
 	int print_ip = print_opts & EVSEL__PRINT_IP;
@@ -204,8 +202,8 @@ int sample__fprintf_sym(struct perf_sample *sample, struct addr_location *al,
 	int print_unknown_as_addr = print_opts & EVSEL__PRINT_UNKNOWN_AS_ADDR;
 
 	if (cursor != NULL) {
-		printed += sample__fprintf_callchain(sample, left_alignment,
-						     print_opts, cursor, fp);
+		printed += sample__fprintf_callchain(sample, left_alignment, print_opts,
+						     cursor, bt_stop_list, fp);
 	} else {
 		printed += fprintf(fp, "%-*.*s", left_alignment, left_alignment, " ");
 
-- 
2.21.0

