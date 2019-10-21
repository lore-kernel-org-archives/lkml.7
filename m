Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC273CA9EAF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A26742067B
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387699AbfJVAFs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 20:05:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38895 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730823AbfJVAFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 20:05:02 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iMgx6-00042D-Vx; Tue, 22 Oct 2019 01:19:05 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2B67B1C04D4;
        Tue, 22 Oct 2019 01:19:03 +0200 (CEST)
Date:   Mon, 21 Oct 2019 23:19:02 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf trace: Introduce accessors to trace specific
 evsel->priv
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Luis =?utf-8?q?Cl=C3=A1udio_Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-dcoyxfslg7atz821tz9aupjh@git.kernel.org>
References: <tip-dcoyxfslg7atz821tz9aupjh@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157169994266.29376.1303864197510723656.tip-bot2@tip-bot2>
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

Commit-ID:     fecd990720306f93151747771f16bca71bb29c33
Gitweb:        https://git.kernel.org/tip/fecd990720306f93151747771f16bca71bb29c33
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Thu, 17 Oct 2019 08:15:11 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 17 Oct 2019 17:26:35 -03:00

perf trace: Introduce accessors to trace specific evsel->priv

We're using evsel->priv in syscalls:sys_{enter,exit}_SYSCALL and in
raw_syscalls:sys_{enter,exit} to cache the offset of the common fields,
the multiplexor id/syscall_id in the sys_enter case and syscall_id + ret
for sys_exit.

And for the rest of the tracepoints we use it to have a syscall_arg_fmt
array to have scnprintf/strtoul for tracepoint args.

So we better clearly mark them with accessors so that we can move to
having a 'struct evsel_trace' struct for all 'perf trace' specific
evsel->priv usage.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-dcoyxfslg7atz821tz9aupjh@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 43 +++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index cafd184..e0be1df 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -285,6 +285,27 @@ struct syscall_tp {
 	};
 };
 
+/*
+ * Used with raw_syscalls:sys_{enter,exit} and with the
+ * syscalls:sys_{enter,exit}_SYSCALL tracepoints
+ */
+static inline struct syscall_tp *__evsel__syscall_tp(struct evsel *evsel)
+{
+	struct syscall_tp *sc = evsel->priv;
+
+	return sc;
+}
+
+/*
+ * Used with all the other tracepoints.
+ */
+static inline struct syscall_arg_fmt *__evsel__syscall_arg_fmt(struct evsel *evsel)
+{
+	struct syscall_arg_fmt *fmt = evsel->priv;
+
+	return fmt;
+}
+
 static int perf_evsel__init_tp_uint_field(struct evsel *evsel,
 					  struct tp_field *field,
 					  const char *name)
@@ -298,7 +319,7 @@ static int perf_evsel__init_tp_uint_field(struct evsel *evsel,
 }
 
 #define perf_evsel__init_sc_tp_uint_field(evsel, name) \
-	({ struct syscall_tp *sc = evsel->priv;\
+	({ struct syscall_tp *sc = __evsel__syscall_tp(evsel);\
 	   perf_evsel__init_tp_uint_field(evsel, &sc->name, #name); })
 
 static int perf_evsel__init_tp_ptr_field(struct evsel *evsel,
@@ -314,7 +335,7 @@ static int perf_evsel__init_tp_ptr_field(struct evsel *evsel,
 }
 
 #define perf_evsel__init_sc_tp_ptr_field(evsel, name) \
-	({ struct syscall_tp *sc = evsel->priv;\
+	({ struct syscall_tp *sc = __evsel__syscall_tp(evsel);\
 	   perf_evsel__init_tp_ptr_field(evsel, &sc->name, #name); })
 
 static void evsel__delete_priv(struct evsel *evsel)
@@ -364,14 +385,14 @@ out_delete:
 
 static int perf_evsel__init_augmented_syscall_tp_args(struct evsel *evsel)
 {
-	struct syscall_tp *sc = evsel->priv;
+	struct syscall_tp *sc = __evsel__syscall_tp(evsel);
 
 	return __tp_field__init_ptr(&sc->args, sc->id.offset + sizeof(u64));
 }
 
 static int perf_evsel__init_augmented_syscall_tp_ret(struct evsel *evsel)
 {
-	struct syscall_tp *sc = evsel->priv;
+	struct syscall_tp *sc = __evsel__syscall_tp(evsel);
 
 	return __tp_field__init_uint(&sc->ret, sizeof(u64), sc->id.offset + sizeof(u64), evsel->needs_swap);
 }
@@ -416,11 +437,11 @@ out_delete:
 }
 
 #define perf_evsel__sc_tp_uint(evsel, name, sample) \
-	({ struct syscall_tp *fields = evsel->priv; \
+	({ struct syscall_tp *fields = __evsel__syscall_tp(evsel); \
 	   fields->name.integer(&fields->name, sample); })
 
 #define perf_evsel__sc_tp_ptr(evsel, name, sample) \
-	({ struct syscall_tp *fields = evsel->priv; \
+	({ struct syscall_tp *fields = __evsel__syscall_tp(evsel); \
 	   fields->name.pointer(&fields->name, sample); })
 
 size_t strarray__scnprintf_suffix(struct strarray *sa, char *bf, size_t size, const char *intfmt, bool show_suffix, int val)
@@ -2518,7 +2539,7 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
 	char bf[2048];
 	size_t size = sizeof(bf);
 	struct tep_format_field *field = evsel->tp_format->format.fields;
-	struct syscall_arg_fmt *arg = evsel->priv;
+	struct syscall_arg_fmt *arg = __evsel__syscall_arg_fmt(evsel);
 	size_t printed = 0;
 	unsigned long val;
 	u8 bit = 1;
@@ -3557,7 +3578,7 @@ static int ordered_events__deliver_event(struct ordered_events *oe,
 static struct syscall_arg_fmt *perf_evsel__syscall_arg_fmt(struct evsel *evsel, char *arg)
 {
 	struct tep_format_field *field;
-	struct syscall_arg_fmt *fmt = evsel->priv;
+	struct syscall_arg_fmt *fmt = __evsel__syscall_arg_fmt(evsel);
 
 	if (evsel->tp_format == NULL || fmt == NULL)
 		return NULL;
@@ -4315,12 +4336,12 @@ static int evlist__set_syscall_tp_fields(struct evlist *evlist)
 			return -1;
 
 		if (!strncmp(evsel->tp_format->name, "sys_enter_", 10)) {
-			struct syscall_tp *sc = evsel->priv;
+			struct syscall_tp *sc = __evsel__syscall_tp(evsel);
 
 			if (__tp_field__init_ptr(&sc->args, sc->id.offset + sizeof(u64)))
 				return -1;
 		} else if (!strncmp(evsel->tp_format->name, "sys_exit_", 9)) {
-			struct syscall_tp *sc = evsel->priv;
+			struct syscall_tp *sc = __evsel__syscall_tp(evsel);
 
 			if (__tp_field__init_uint(&sc->ret, sizeof(u64), sc->id.offset + sizeof(u64), evsel->needs_swap))
 				return -1;
@@ -4856,7 +4877,7 @@ int cmd_trace(int argc, const char **argv)
 init_augmented_syscall_tp:
 				if (perf_evsel__init_augmented_syscall_tp(evsel, evsel))
 					goto out;
-				sc = evsel->priv;
+				sc = __evsel__syscall_tp(evsel);
 				/*
 				 * For now with BPF raw_augmented we hook into
 				 * raw_syscalls:sys_enter and there we get all
