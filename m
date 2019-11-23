Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41542C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 08:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E9132071C
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 08:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfKWIQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 03:16:15 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36275 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfKWIPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 03:15:13 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iYQZQ-0002Yz-15; Sat, 23 Nov 2019 09:15:08 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 595E51C19FD;
        Sat, 23 Nov 2019 09:15:01 +0100 (CET)
Date:   Sat, 23 Nov 2019 08:15:01 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf inject: Cut AUX area samples
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191115124225.5247-9-adrian.hunter@intel.com>
References: <20191115124225.5247-9-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <157449690128.21853.4094754237556646489.tip-bot2@tip-bot2>
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

Commit-ID:     ba2675bf15fc3ec1d54b9bf938cf5b28392f79fb
Gitweb:        https://git.kernel.org/tip/ba2675bf15fc3ec1d54b9bf938cf5b28392f79fb
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Fri, 15 Nov 2019 14:42:18 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 22 Nov 2019 10:48:13 -03:00

perf inject: Cut AUX area samples

After decoding AUX area samples, the AUX area data is no longer needed
(having been replaced by synthesized events) so cut it out.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20191115124225.5247-9-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-inject.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 1e5d283..9664a72 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -45,6 +45,7 @@ struct perf_inject {
 	u64			aux_id;
 	struct list_head	samples;
 	struct itrace_synth_opts itrace_synth_opts;
+	char			event_copy[PERF_SAMPLE_MAX_SIZE];
 };
 
 struct event_entry {
@@ -214,6 +215,28 @@ static int perf_event__drop_aux(struct perf_tool *tool,
 	return 0;
 }
 
+static union perf_event *
+perf_inject__cut_auxtrace_sample(struct perf_inject *inject,
+				 union perf_event *event,
+				 struct perf_sample *sample)
+{
+	size_t sz1 = sample->aux_sample.data - (void *)event;
+	size_t sz2 = event->header.size - sample->aux_sample.size - sz1;
+	union perf_event *ev = (union perf_event *)inject->event_copy;
+
+	if (sz1 > event->header.size || sz2 > event->header.size ||
+	    sz1 + sz2 > event->header.size ||
+	    sz1 < sizeof(struct perf_event_header) + sizeof(u64))
+		return event;
+
+	memcpy(ev, event, sz1);
+	memcpy((void *)ev + sz1, (void *)event + event->header.size - sz2, sz2);
+	ev->header.size = sz1 + sz2;
+	((u64 *)((void *)ev + sz1))[-1] = 0;
+
+	return ev;
+}
+
 typedef int (*inject_handler)(struct perf_tool *tool,
 			      union perf_event *event,
 			      struct perf_sample *sample,
@@ -226,6 +249,9 @@ static int perf_event__repipe_sample(struct perf_tool *tool,
 				     struct evsel *evsel,
 				     struct machine *machine)
 {
+	struct perf_inject *inject = container_of(tool, struct perf_inject,
+						  tool);
+
 	if (evsel && evsel->handler) {
 		inject_handler f = evsel->handler;
 		return f(tool, event, sample, evsel, machine);
@@ -233,6 +259,9 @@ static int perf_event__repipe_sample(struct perf_tool *tool,
 
 	build_id__mark_dso_hit(tool, event, sample, evsel, machine);
 
+	if (inject->itrace_synth_opts.set && sample->aux_sample.size)
+		event = perf_inject__cut_auxtrace_sample(inject, event, sample);
+
 	return perf_event__repipe_synth(tool, event);
 }
 
