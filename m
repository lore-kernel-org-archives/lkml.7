Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70684C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F28221835
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfJOFfB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 01:35:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42043 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbfJOFcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:32:02 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iKFR5-0000G9-Nu; Tue, 15 Oct 2019 07:31:55 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3665C1C04DF;
        Tue, 15 Oct 2019 07:31:44 +0200 (CEST)
Date:   Tue, 15 Oct 2019 05:31:44 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf evlist: Introduce append_tp_filter() method
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Luis =?utf-8?q?Cl=C3=A1udio_Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-h9rot08qmxlnfmte0holt68x@git.kernel.org>
References: <tip-h9rot08qmxlnfmte0holt68x@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157111750408.12254.10823049937651993535.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     53c92f73389d049d72b2e1d1cbc81c007241d422
Gitweb:        https://git.kernel.org/tip/53c92f73389d049d72b2e1d1cbc81c007241d422
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 07 Oct 2019 16:52:17 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 09 Oct 2019 11:23:52 -03:00

perf evlist: Introduce append_tp_filter() method

Will be used by 'perf trace' to support 'perf trace --filter', we need
to append to any pre-existing filter.

When parse_filter() gets invoked to process --filter, it'll set the
filter to that specified on the command line, later on, when we filter
out 'perf trace' own pid to avoid an event feedback loop, we need to
preserve the command line filter put in place by parse_filter().

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-h9rot08qmxlnfmte0holt68x@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 20 ++++++++++++++++++++
 tools/perf/util/evlist.h |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index c1b4608..1650d24 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1068,6 +1068,26 @@ int perf_evlist__set_tp_filter(struct evlist *evlist, const char *filter)
 	return err;
 }
 
+int perf_evlist__append_tp_filter(struct evlist *evlist, const char *filter)
+{
+	struct evsel *evsel;
+	int err = 0;
+
+	if (filter == NULL)
+		return -1;
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel->core.attr.type != PERF_TYPE_TRACEPOINT)
+			continue;
+
+		err = perf_evsel__append_tp_filter(evsel, filter);
+		if (err)
+			break;
+	}
+
+	return err;
+}
+
 static char *asprintf__tp_filter_pids(size_t npids, pid_t *pids)
 {
 	char *filter;
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 00eab94..c58fd19 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -140,6 +140,8 @@ int perf_evlist__set_tp_filter(struct evlist *evlist, const char *filter);
 int perf_evlist__set_tp_filter_pid(struct evlist *evlist, pid_t pid);
 int perf_evlist__set_tp_filter_pids(struct evlist *evlist, size_t npids, pid_t *pids);
 
+int perf_evlist__append_tp_filter(struct evlist *evlist, const char *filter);
+
 struct evsel *
 perf_evlist__find_tracepoint_by_id(struct evlist *evlist, int id);
 
