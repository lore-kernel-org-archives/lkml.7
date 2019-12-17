Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22A6C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 747562465E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576594144;
	bh=a9mKoMbq2WRjoubXG8o0HMichj1xLz9Of/S2vlHQBag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qYUB6lmEjebvWHk982V8oaRvIyfVfjMzEt31fkQ+pX6L+WMarCxVunzHPIj6U0UGc
	 MVX285AHU0yvnWkQQsfWyg+CSqS3tpBw5REkIkGN3CInOyvZNk7DQJTZbw6f0rRn8K
	 ySkqTkWQRikcj8cHiRkG8C9zCrGavP2Vs+Dz2aVI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbfLQOtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 09:49:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:41038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728573AbfLQOtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 09:49:01 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D881024676;
        Tue, 17 Dec 2019 14:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576594140;
        bh=a9mKoMbq2WRjoubXG8o0HMichj1xLz9Of/S2vlHQBag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eFvN+YMlDgvFPX0Szbng8VshAM9JOO+2Swb6e/ztBIqWc3lGUXPTxcm72pQ83+xK0
         eVtQ+ZBMtVXwt4V0pqNeI2pFmAzplxFU+rhZHaj3Vg9Nsf2peAkGNYPtoe9/U7dirf
         zxJTkQRp9sxIbIhXyhrLQmN/WHrx/8ZKM2p6BwSE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>
Subject: [PATCH 03/12] perf report/top: Add menu entry for toggling callchain expansion
Date:   Tue, 17 Dec 2019 11:48:19 -0300
Message-Id: <20191217144828.2460-4-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191217144828.2460-1-acme@kernel.org>
References: <20191217144828.2460-1-acme@kernel.org>
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
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
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
2.21.0

