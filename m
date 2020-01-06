Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6490AC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 16:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 364F624676
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 16:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578326881;
	bh=RsFoq6B47pcM1adbel5xM5sfPhSs0sqf7VUGEZTg3bo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iPbV8KJbf8Ic5SaMqx/hpN11veohKSpynYfNOOaLbDUNgc0+vQeT6uHbhsmzlsLA+
	 1eh7hZjVWuoJB9Slkyl90vePlI2/SU9UNKI+5oI0vXvp0/B0YyfL0WY//R+AmCL1aT
	 JzCoHIYZ7YI/Y19DmwYUBlsMhZEuL7+x3pfUJk14=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbgAFQIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 11:08:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:46026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727146AbgAFQH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 11:07:56 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D869222D9;
        Mon,  6 Jan 2020 16:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578326875;
        bh=RsFoq6B47pcM1adbel5xM5sfPhSs0sqf7VUGEZTg3bo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LbhNDcgzH+VCZGfdY1hCyH6ioFX9FXtxsI2Pe3hP0LNCQnwHccXj5UAuaPbXOCUyu
         vHfyAtPTrBEtqoZjW58d7Q3JWk76afxwmZV3MB4kSi+JzdtSKdliQvhwtopWjCILvi
         00X8i59fE+eqzPbGV0kSl01Wd14P0+aG4V0z6wYY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>
Subject: [PATCH 11/20] perf report/top: Add menu entry for toggling callchain expansion
Date:   Mon,  6 Jan 2020 13:06:56 -0300
Message-Id: <20200106160705.10899-12-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200106160705.10899-1-acme@kernel.org>
References: <20200106160705.10899-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Since previously pressing ENTER toggled expansion/collapse of callchain
entries and now brings up the same menu used when callchains are not
present, add an entry so that users can quickly figure out the change in
behaviour.

Its worth mentioning that we also always had 'e'/'c' to expand/collapse
all entries in a hist entry and 'E'/'C' for all hist entries.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-f9o03jo29fypvd8ly3j49d36@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index fefa505d4fa8..1b5a5990dddb 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2527,6 +2527,26 @@ add_dso_opt(struct hist_browser *browser, struct popup_action *act,
 	return 1;
 }
 
+static int do_toggle_callchain(struct hist_browser *browser, struct popup_action *act __maybe_unused)
+{
+	hist_browser__toggle_fold(browser);
+	return 0;
+}
+
+static int add_callchain_toggle_opt(struct hist_browser *browser, struct popup_action *act, char **optstr)
+{
+	struct hist_entry *he = browser->he_selection;
+
+        if (!he->has_children)
+                return 0;
+
+	if (asprintf(optstr, "Expand/Collapse callchain") < 0)
+		return 0;
+
+	act->fn = do_toggle_callchain;
+	return 1;
+}
+
 static int
 do_browse_map(struct hist_browser *browser __maybe_unused,
 	      struct popup_action *act)
@@ -3137,6 +3157,7 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
 					     &options[nr_options], thread);
 		nr_options += add_dso_opt(browser, &actions[nr_options],
 					  &options[nr_options], map);
+		nr_options += add_callchain_toggle_opt(browser, &actions[nr_options], &options[nr_options]);
 		nr_options += add_map_opt(browser, &actions[nr_options],
 					  &options[nr_options],
 					  browser->selection ?
-- 
2.21.1

