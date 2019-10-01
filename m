Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872B5C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC0321D79
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569928426;
	bh=9fS6W/25MfCNUkjjuTxJCHId8MajGK2hF6bwaFqV7t8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x91lUdaGE7CcsK/016meAToF+dvv/gOgtCVho1Zl3q3HFj7uvT8rcBzD1h7/nvp5e
	 +sqNiweUJX2WVcgzAJjE//pBw3hzwxmbdoBCoWaCuPZ14of0HfdrTGKA75iaYHSdmI
	 xKmVeVFOASYHUdS2dWx6T3d6llLXn0cEWDjt9bKs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732025AbfJALNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:13:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:35710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731944AbfJALNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:13:44 -0400
Received: from quaco.ghostprotocols.net (177.206.223.101.dynamic.adsl.gvt.net.br [177.206.223.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AC8D21A4C;
        Tue,  1 Oct 2019 11:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569928423;
        bh=9fS6W/25MfCNUkjjuTxJCHId8MajGK2hF6bwaFqV7t8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J+H0gC6CLGYyWpfR5ynYsEX8YcZ4RuddtFP1jFZQ/OdX9hYk/xPMLRkmq2KObpjFL
         jHyODOvWG2Ij42AhAMfAZFmjhLqOOvpV2UP+HqcTNYdX/0TqM005EXLMEwJGSYMHN6
         p3YrL3ApQY4NAcv4aLtyPZZ+S5B2X3od6JrZGKLQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 18/24] perf evsel: Fall back to global 'perf_env' in perf_evsel__env()
Date:   Tue,  1 Oct 2019 08:12:10 -0300
Message-Id: <20191001111216.7208-19-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191001111216.7208-1-acme@kernel.org>
References: <20191001111216.7208-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

I.e. if evsel->evlist or evsel->evlist->env isn't set, return the
environment for the running machine, as that would be set if reading
from a perf.data file.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-uqq4grmhbi12rwb0lfpo6lfu@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c  | 3 ++-
 tools/perf/util/python.c | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 5591af81a070..abc7fda4a0fe 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -30,6 +30,7 @@
 #include "counts.h"
 #include "event.h"
 #include "evsel.h"
+#include "util/env.h"
 #include "util/evsel_config.h"
 #include "util/evsel_fprintf.h"
 #include "evlist.h"
@@ -2512,7 +2513,7 @@ struct perf_env *perf_evsel__env(struct evsel *evsel)
 {
 	if (evsel && evsel->evlist)
 		return evsel->evlist->env;
-	return NULL;
+	return &perf_env;
 }
 
 static int store_evsel_ids(struct evsel *evsel, struct evlist *evlist)
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 53f31053a27a..02460362256d 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -14,6 +14,7 @@
 #include "thread_map.h"
 #include "trace-event.h"
 #include "mmap.h"
+#include "util/env.h"
 #include <internal/lib.h>
 #include "../perf-sys.h"
 
@@ -53,6 +54,11 @@ int parse_callchain_record(const char *arg __maybe_unused,
 	return 0;
 }
 
+/*
+ * Add this one here not to drag util/env.c
+ */
+struct perf_env perf_env;
+
 /*
  * Support debug printing even though util/debug.c is not linked.  That means
  * implementing 'verbose' and 'eprintf'.
-- 
2.21.0

