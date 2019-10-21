Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CFACA9EAF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93ABF2067B
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387710AbfJVAFw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 20:05:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38895 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730730AbfJVAEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 20:04:54 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iMgx5-00041d-U4; Tue, 22 Oct 2019 01:19:04 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 70FC71C047B;
        Tue, 22 Oct 2019 01:19:02 +0200 (CEST)
Date:   Mon, 21 Oct 2019 23:19:02 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf trace: Hide evsel->access further, simplify code
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Luis =?utf-8?q?Cl=C3=A1udio_Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-fre21jbyoqxmmquxcho7oa0x@git.kernel.org>
References: <tip-fre21jbyoqxmmquxcho7oa0x@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157169994207.29376.5939626278799230380.tip-bot2@tip-bot2>
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

Commit-ID:     8b913df50f56a26b9e336becdd0af9d5ce3831cd
Gitweb:        https://git.kernel.org/tip/8b913df50f56a26b9e336becdd0af9d5ce3831cd
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Thu, 17 Oct 2019 10:39:46 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 17 Oct 2019 17:26:35 -03:00

perf trace: Hide evsel->access further, simplify code

Next step will be to have a 'struct evsel_trace' to allow for handling
the syscalls tracepoints via the strace-like code while reusing parts of
that code with the other tracepoints, where we don't have things like
the 'syscall_nr' or 'ret' ((raw_)?syscalls:sys_{enter,exit}(_SYSCALL)?)
args that we want to cache offsets and have been using evsel->priv for
that, while for the other tracepoints we'll have just an array of
'struct syscall_arg_fmt' (i.e. ->scnprint() for number->string and
->strtoul() string->number conversions and other state those functions
need).

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-fre21jbyoqxmmquxcho7oa0x@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 57 ++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 26 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index e0be1df..1d2ed28 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -296,6 +296,15 @@ static inline struct syscall_tp *__evsel__syscall_tp(struct evsel *evsel)
 	return sc;
 }
 
+static struct syscall_tp *evsel__syscall_tp(struct evsel *evsel)
+{
+	if (evsel->priv == NULL) {
+		evsel->priv = zalloc(sizeof(struct syscall_tp));
+	}
+
+	return __evsel__syscall_tp(evsel);
+}
+
 /*
  * Used with all the other tracepoints.
  */
@@ -306,6 +315,15 @@ static inline struct syscall_arg_fmt *__evsel__syscall_arg_fmt(struct evsel *evs
 	return fmt;
 }
 
+static struct syscall_arg_fmt *evsel__syscall_arg_fmt(struct evsel *evsel)
+{
+	if (evsel->priv == NULL) {
+		evsel->priv = calloc(evsel->tp_format->format.nr_fields, sizeof(struct syscall_arg_fmt));
+	}
+
+	return __evsel__syscall_arg_fmt(evsel);
+}
+
 static int perf_evsel__init_tp_uint_field(struct evsel *evsel,
 					  struct tp_field *field,
 					  const char *name)
@@ -346,41 +364,34 @@ static void evsel__delete_priv(struct evsel *evsel)
 
 static int perf_evsel__init_syscall_tp(struct evsel *evsel)
 {
-	struct syscall_tp *sc = evsel->priv = malloc(sizeof(struct syscall_tp));
+	struct syscall_tp *sc = evsel__syscall_tp(evsel);
 
-	if (evsel->priv != NULL) {
+	if (sc != NULL) {
 		if (perf_evsel__init_tp_uint_field(evsel, &sc->id, "__syscall_nr") &&
 		    perf_evsel__init_tp_uint_field(evsel, &sc->id, "nr"))
-			goto out_delete;
+			return -ENOENT;
 		return 0;
 	}
 
 	return -ENOMEM;
-out_delete:
-	zfree(&evsel->priv);
-	return -ENOENT;
 }
 
 static int perf_evsel__init_augmented_syscall_tp(struct evsel *evsel, struct evsel *tp)
 {
-	struct syscall_tp *sc = evsel->priv = malloc(sizeof(struct syscall_tp));
+	struct syscall_tp *sc = evsel__syscall_tp(evsel);
 
-	if (evsel->priv != NULL) {
+	if (sc != NULL) {
 		struct tep_format_field *syscall_id = perf_evsel__field(tp, "id");
 		if (syscall_id == NULL)
 			syscall_id = perf_evsel__field(tp, "__syscall_nr");
-		if (syscall_id == NULL)
-			goto out_delete;
-		if (__tp_field__init_uint(&sc->id, syscall_id->size, syscall_id->offset, evsel->needs_swap))
-			goto out_delete;
+		if (syscall_id == NULL ||
+		    __tp_field__init_uint(&sc->id, syscall_id->size, syscall_id->offset, evsel->needs_swap))
+			return -EINVAL;
 
 		return 0;
 	}
 
 	return -ENOMEM;
-out_delete:
-	zfree(&evsel->priv);
-	return -EINVAL;
 }
 
 static int perf_evsel__init_augmented_syscall_tp_args(struct evsel *evsel)
@@ -399,20 +410,15 @@ static int perf_evsel__init_augmented_syscall_tp_ret(struct evsel *evsel)
 
 static int perf_evsel__init_raw_syscall_tp(struct evsel *evsel, void *handler)
 {
-	evsel->priv = malloc(sizeof(struct syscall_tp));
-	if (evsel->priv != NULL) {
+	if (evsel__syscall_tp(evsel) != NULL) {
 		if (perf_evsel__init_sc_tp_uint_field(evsel, id))
-			goto out_delete;
+			return -ENOENT;
 
 		evsel->handler = handler;
 		return 0;
 	}
 
 	return -ENOMEM;
-
-out_delete:
-	zfree(&evsel->priv);
-	return -ENOENT;
 }
 
 static struct evsel *perf_evsel__raw_syscall_newtp(const char *direction, void *handler)
@@ -1690,11 +1696,10 @@ static int trace__read_syscall_info(struct trace *trace, int id)
 
 static int perf_evsel__init_tp_arg_scnprintf(struct evsel *evsel)
 {
-	int nr_args = evsel->tp_format->format.nr_fields;
+	struct syscall_arg_fmt *fmt = evsel__syscall_arg_fmt(evsel);
 
-	evsel->priv = calloc(nr_args, sizeof(struct syscall_arg_fmt));
-	if (evsel->priv != NULL) {
-		syscall_arg_fmt__init_array(evsel->priv, evsel->tp_format->format.fields);
+	if (fmt != NULL) {
+		syscall_arg_fmt__init_array(fmt, evsel->tp_format->format.fields);
 		return 0;
 	}
 
