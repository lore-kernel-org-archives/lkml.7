Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B79ECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF042086A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfJOFeo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 01:34:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42092 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728515AbfJOFcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:32:06 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iKFRB-0000MZ-Hd; Tue, 15 Oct 2019 07:32:01 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1562C1C0673;
        Tue, 15 Oct 2019 07:31:47 +0200 (CEST)
Date:   Tue, 15 Oct 2019 05:31:46 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf trace: Enclose all events argument lists with ()
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Luis =?utf-8?q?Cl=C3=A1udio_Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-y4fcej6v6u1m644nbxd2r4pg@git.kernel.org>
References: <tip-y4fcej6v6u1m644nbxd2r4pg@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157111750684.12254.3965067289207924382.tip-bot2@tip-bot2>
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

Commit-ID:     311baaf93c4b9e6a339722006d1a7c33e4283c0c
Gitweb:        https://git.kernel.org/tip/311baaf93c4b9e6a339722006d1a7c33e4283c0c
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Fri, 04 Oct 2019 15:01:30 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 07 Oct 2019 12:22:18 -03:00

perf trace: Enclose all events argument lists with ()

So that they look a bit like normal strace-like syscall enter+exit
lines.

They will look even more when we switch from using libtraceevent's
tep_print_event() routine in favour of using all the perf beautifiers
used by the strace-like syscall enter+exit lines.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-y4fcej6v6u1m644nbxd2r4pg@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index b3fb208..297aeaa 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2450,7 +2450,7 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
 		 */
 	}
 
-	fprintf(trace->output, "%s:", evsel->name);
+	fprintf(trace->output, "%s(", evsel->name);
 
 	if (perf_evsel__is_bpf_output(evsel)) {
 		bpf_output__fprintf(trace, sample);
@@ -2470,7 +2470,7 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
 	}
 
 newline:
-	fprintf(trace->output, "\n");
+	fprintf(trace->output, ")\n");
 
 	if (callchain_ret > 0)
 		trace__fprintf_callchain(trace, sample);
