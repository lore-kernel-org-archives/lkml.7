Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B254CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20629222D0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571665225;
	bh=sMScS+dWkav3crTEB3WcxpUjEzN6p1rATMIKU/rbgLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I6OOP5wu2j+ckReJMhxb+UUjhuoOekYDsZVfXb17H8ytyN86YpGr0fW3yJoULNeRW
	 nphR7mAXzyCAt8T4//A6nUCqr3P/JgEn8Xs7Ad6R8MzCcBAoejs6yc8DIcyHsC5hyB
	 NNP0nxJl+H4LKL2yE/m5uLT8QmsL8iU9jS9H1ts4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbfJUNkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:40:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:42140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729473AbfJUNkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:40:22 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BF642173B;
        Mon, 21 Oct 2019 13:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571665221;
        bh=sMScS+dWkav3crTEB3WcxpUjEzN6p1rATMIKU/rbgLU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pONl5bjRlnNc+3cGvF9UTBTeWtj6Lgu9hqBPfyO2WhGcRGk0rKUaX6ch7Cjs6iNgW
         EBm1QbPPry/fYLHdACXZwurE5dgk5Mrm7O+/VpbCVML5VemHEpJiv76CXJFTW4IcyS
         Qrcj//KLEqg5uugZt+WlG6LJQQzgwR8Xh7Wg/iNg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 31/57] perf trace: Hide evsel->access further, simplify code
Date:   Mon, 21 Oct 2019 10:38:08 -0300
Message-Id: <20191021133834.25998-32-acme@kernel.org>
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
 tools/perf/builtin-trace.c | 57 +++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 26 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index e0be1df555a2..1d2ed2823202 100644
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
 
-- 
2.21.0

