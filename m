Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A22DECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF40E2173B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbfJGOwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 10:52:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44250 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728048AbfJGOtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 10:49:25 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iHUK8-0005vM-Dv; Mon, 07 Oct 2019 16:49:20 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1F61C1C079B;
        Mon,  7 Oct 2019 16:49:15 +0200 (CEST)
Date:   Mon, 07 Oct 2019 14:49:15 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf evsel: Fall back to global 'perf_env' in
 perf_evsel__env()
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-uqq4grmhbi12rwb0lfpo6lfu@git.kernel.org>
References: <tip-uqq4grmhbi12rwb0lfpo6lfu@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157045975509.9978.15970537878008487052.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     9db0e3635fb35b6695275774ab909c51221b66ad
Gitweb:        https://git.kernel.org/tip/9db0e3635fb35b6695275774ab909c51221b66ad
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 30 Sep 2019 11:48:32 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 30 Sep 2019 17:29:57 -03:00

perf evsel: Fall back to global 'perf_env' in perf_evsel__env()

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
index 5591af8..abc7fda 100644
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
index 53f3105..0246036 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -14,6 +14,7 @@
 #include "thread_map.h"
 #include "trace-event.h"
 #include "mmap.h"
+#include "util/env.h"
 #include <internal/lib.h>
 #include "../perf-sys.h"
 
@@ -54,6 +55,11 @@ int parse_callchain_record(const char *arg __maybe_unused,
 }
 
 /*
+ * Add this one here not to drag util/env.c
+ */
+struct perf_env perf_env;
+
+/*
  * Support debug printing even though util/debug.c is not linked.  That means
  * implementing 'verbose' and 'eprintf'.
  */
