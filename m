Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E7AECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9742F2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbfJOFdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 01:33:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42266 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728695AbfJOFcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:32:23 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iKFRS-0000WS-Vu; Tue, 15 Oct 2019 07:32:19 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5109B1C04D6;
        Tue, 15 Oct 2019 07:31:52 +0200 (CEST)
Date:   Tue, 15 Oct 2019 05:31:52 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf trace: Make evlist__set_evsel_handler() affect
 just entries without a handler
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-e1bit7upnpmtsayh8039kfuw@git.kernel.org>
References: <tip-e1bit7upnpmtsayh8039kfuw@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157111751221.12254.12826613305063607363.tip-bot2@tip-bot2>
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

Commit-ID:     206d635aa594a5246cd181b3be39d1e3b2126f68
Gitweb:        https://git.kernel.org/tip/206d635aa594a5246cd181b3be39d1e3b2126f68
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Tue, 01 Oct 2019 11:31:59 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 07 Oct 2019 12:22:17 -03:00

perf trace: Make evlist__set_evsel_handler() affect just entries without a handler

Renaming it to evlist__set_default_evsel_handler(), to better reflect
what we want to do, which is to set a default handler for events we
still haven't set a custom handler, like the ones for "msr:write_msr",
etc that are coming soon.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-e1bit7upnpmtsayh8039kfuw@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index bb5130d..ee330f5 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3858,12 +3858,14 @@ static int parse_pagefaults(const struct option *opt, const char *str,
 	return 0;
 }
 
-static void evlist__set_evsel_handler(struct evlist *evlist, void *handler)
+static void evlist__set_default_evsel_handler(struct evlist *evlist, void *handler)
 {
 	struct evsel *evsel;
 
-	evlist__for_each_entry(evlist, evsel)
-		evsel->handler = handler;
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel->handler == NULL)
+			evsel->handler = handler;
+	}
 }
 
 static int evlist__set_syscall_tp_fields(struct evlist *evlist)
@@ -4287,7 +4289,7 @@ int cmd_trace(int argc, const char **argv)
 	}
 
 	if (trace.evlist->core.nr_entries > 0) {
-		evlist__set_evsel_handler(trace.evlist, trace__event_handler);
+		evlist__set_default_evsel_handler(trace.evlist, trace__event_handler);
 		if (evlist__set_syscall_tp_fields(trace.evlist)) {
 			perror("failed to set syscalls:* tracepoint fields");
 			goto out;
