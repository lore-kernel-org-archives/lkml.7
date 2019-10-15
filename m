Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C8DECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA240217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbfJOFeF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 01:34:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42166 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728595AbfJOFcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:32:13 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iKFRF-0000Oh-R7; Tue, 15 Oct 2019 07:32:05 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 451BA1C04C9;
        Tue, 15 Oct 2019 07:31:48 +0200 (CEST)
Date:   Tue, 15 Oct 2019 05:31:48 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf trace: Allocate an array of beautifiers for
 tracepoint args
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Luis =?utf-8?q?Cl=C3=A1udio_Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-dcl135relxvf6ljisjg13aqg@git.kernel.org>
References: <tip-dcl135relxvf6ljisjg13aqg@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157111750814.12254.11194117377604786371.tip-bot2@tip-bot2>
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

Commit-ID:     947b843cf52a53f6b35aa1406e11884291f41597
Gitweb:        https://git.kernel.org/tip/947b843cf52a53f6b35aa1406e11884291f41597
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Thu, 03 Oct 2019 16:18:22 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 07 Oct 2019 12:22:18 -03:00

perf trace: Allocate an array of beautifiers for tracepoint args

This will work similar to the syscall args, we'll allocate an array
of 'struct syscall_arg_fmt' for the tracepoint args and then init them
using the same algorithm used for the defaults for syscall args, i.e.
using its types and sometimes names as hints to find the right scnprintf
routine to beautify them from numbers into strings.

Next step is to stop using libtracevent to printf tracepoints, as we'll
have more beautifiers than int provides, modulo perhaps some plugins.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-dcl135relxvf6ljisjg13aqg@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d52dd2b..aa70602 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1574,6 +1574,19 @@ static int trace__read_syscall_info(struct trace *trace, int id)
 	return syscall__set_arg_fmts(sc);
 }
 
+static int perf_evsel__init_tp_arg_scnprintf(struct evsel *evsel)
+{
+	int nr_args = evsel->tp_format->format.nr_fields;
+
+	evsel->priv = calloc(nr_args, sizeof(struct syscall_arg_fmt));
+	if (evsel->priv != NULL) {
+		syscall_arg_fmt__init_array(evsel->priv, evsel->tp_format->format.fields);
+		return 0;
+	}
+
+	return -ENOMEM;
+}
+
 static int intcmp(const void *a, const void *b)
 {
 	const int *one = a, *another = b;
@@ -3936,8 +3949,10 @@ static int evlist__set_syscall_tp_fields(struct evlist *evlist)
 		if (evsel->priv || !evsel->tp_format)
 			continue;
 
-		if (strcmp(evsel->tp_format->system, "syscalls"))
+		if (strcmp(evsel->tp_format->system, "syscalls")) {
+			perf_evsel__init_tp_arg_scnprintf(evsel);
 			continue;
+		}
 
 		if (perf_evsel__init_syscall_tp(evsel))
 			return -1;
