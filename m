Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B68CA9EB7
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6542C214B2
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730775AbfJVAEq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 20:04:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38895 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730466AbfJVAEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 20:04:43 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iMgx4-00040e-EA; Tue, 22 Oct 2019 01:19:02 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CA3041C03AB;
        Tue, 22 Oct 2019 01:19:01 +0200 (CEST)
Date:   Mon, 21 Oct 2019 23:19:01 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf trace: Introduce 'struct evsel__trace' for
 evsel->priv needs
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Luis =?utf-8?q?Cl=C3=A1udio_Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-hx8ukasuws5sz6rsar73cocv@git.kernel.org>
References: <tip-hx8ukasuws5sz6rsar73cocv@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157169994141.29376.161893503478087645.tip-bot2@tip-bot2>
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

Commit-ID:     2b00bb627f62ed1c6180f49f7883789bc5e1b33f
Gitweb:        https://git.kernel.org/tip/2b00bb627f62ed1c6180f49f7883789bc5e1b33f
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Thu, 17 Oct 2019 16:37:18 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 17 Oct 2019 17:27:43 -03:00

perf trace: Introduce 'struct evsel__trace' for evsel->priv needs

For syscalls we need to cache the 'syscall_id' and 'ret' field offsets
but as well have a pointer to the syscall_fmt_arg array for the fields,
so that we can expand strings in filter expressions, so introduce
a 'struct evsel_trace' to have in evsel->priv that allows for that.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-hx8ukasuws5sz6rsar73cocv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 54 ++++++++++++++++++++++++++++++++-----
 1 file changed, 48 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 1d2ed28..5792278 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -286,20 +286,46 @@ struct syscall_tp {
 };
 
 /*
+ * The evsel->priv as used by 'perf trace'
+ * sc:	for raw_syscalls:sys_{enter,exit} and syscalls:sys_{enter,exit}_SYSCALLNAME
+ * fmt: for all the other tracepoints
+ */
+struct evsel_trace {
+	struct syscall_tp	sc;
+	struct syscall_arg_fmt  *fmt;
+};
+
+static struct evsel_trace *evsel_trace__new(void)
+{
+	return zalloc(sizeof(struct evsel_trace));
+}
+
+static void evsel_trace__delete(struct evsel_trace *et)
+{
+	if (et == NULL)
+		return;
+
+	zfree(&et->fmt);
+	free(et);
+}
+
+/*
  * Used with raw_syscalls:sys_{enter,exit} and with the
  * syscalls:sys_{enter,exit}_SYSCALL tracepoints
  */
 static inline struct syscall_tp *__evsel__syscall_tp(struct evsel *evsel)
 {
-	struct syscall_tp *sc = evsel->priv;
+	struct evsel_trace *et = evsel->priv;
 
-	return sc;
+	return &et->sc;
 }
 
 static struct syscall_tp *evsel__syscall_tp(struct evsel *evsel)
 {
 	if (evsel->priv == NULL) {
-		evsel->priv = zalloc(sizeof(struct syscall_tp));
+		evsel->priv = evsel_trace__new();
+		if (evsel->priv == NULL)
+			return NULL;
 	}
 
 	return __evsel__syscall_tp(evsel);
@@ -310,18 +336,34 @@ static struct syscall_tp *evsel__syscall_tp(struct evsel *evsel)
  */
 static inline struct syscall_arg_fmt *__evsel__syscall_arg_fmt(struct evsel *evsel)
 {
-	struct syscall_arg_fmt *fmt = evsel->priv;
+	struct evsel_trace *et = evsel->priv;
 
-	return fmt;
+	return et->fmt;
 }
 
 static struct syscall_arg_fmt *evsel__syscall_arg_fmt(struct evsel *evsel)
 {
+	struct evsel_trace *et = evsel->priv;
+
 	if (evsel->priv == NULL) {
-		evsel->priv = calloc(evsel->tp_format->format.nr_fields, sizeof(struct syscall_arg_fmt));
+		et = evsel->priv = evsel_trace__new();
+
+		if (et == NULL)
+			return NULL;
+	}
+
+	if (et->fmt == NULL) {
+		et->fmt = calloc(evsel->tp_format->format.nr_fields, sizeof(struct syscall_arg_fmt));
+		if (et->fmt == NULL)
+			goto out_delete;
 	}
 
 	return __evsel__syscall_arg_fmt(evsel);
+
+out_delete:
+	evsel_trace__delete(evsel->priv);
+	evsel->priv = NULL;
+	return NULL;
 }
 
 static int perf_evsel__init_tp_uint_field(struct evsel *evsel,
