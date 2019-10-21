Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2DCCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9776A21A4A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571665222;
	bh=AhTQ91mjdHGp2FjH8J+Zq1ryVKbKGTJxBlPi4naAO6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2a90E7acqaCQ6j0JIIb2tYUTuxoujMwsp2YmTT4nA+v6DFTICSZP1ugC711AdheJm
	 iC0WFhV6vMs8ij9qFPKz6okCcFdJ24hPy3jrFKu+2qZiZ5eZwnS7pALMR567tgx0yt
	 fj4s6G7fHQmggpYBFm9pYkq1kTgSF8jglk0bXu5I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbfJUNkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:40:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:42082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729452AbfJUNkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:40:19 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6708214AE;
        Mon, 21 Oct 2019 13:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571665218;
        bh=AhTQ91mjdHGp2FjH8J+Zq1ryVKbKGTJxBlPi4naAO6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=upU6tDk/SHTJ0xayc3lgNWl4MkA1mEA7m0M4PwIFo/h2XFc3X6FerVJDUpx9GPBvz
         YDdRsHhpiNuD4MM9CMKhjzEO8iBqGZpqimWJUxsYz6yxNX0VtvdK1+1fasdxwxMLsl
         sJiBftJqocVQzmqTVsSeNDpOXw57hWIyVewZI6Ic=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 30/57] perf trace: Introduce accessors to trace specific evsel->priv
Date:   Mon, 21 Oct 2019 10:38:07 -0300
Message-Id: <20191021133834.25998-31-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191021133834.25998-1-acme@kernel.org>
References: <20191021133834.25998-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
 tools/perf/builtin-trace.c | 43 ++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index cafd18466dfa..e0be1df555a2 100644
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
@@ -364,14 +385,14 @@ static int perf_evsel__init_augmented_syscall_tp(struct evsel *evsel, struct evs
 
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
@@ -416,11 +437,11 @@ static struct evsel *perf_evsel__raw_syscall_newtp(const char *direction, void *
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
-- 
2.21.0

