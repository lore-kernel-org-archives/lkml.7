Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2F5CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3813E2166E
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571665228;
	bh=MgFhCNBcWt9mxbFfRHwAVC+7C4likEYyyKtp4ddhjMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YvL7/NOWYBhqmcsYbwae/XbYtuv4lrtuZJLSne914iZpzKXBX4g0WDhtDFMPsS/PE
	 +KxqPtWXgh7iNLPH6oudzT5roRr7yWRPhfYjctiypaUDWiN01wgVju7a5nWfSaHsC8
	 PB1KSyOjrFNP1iC3XruJX+GV2T6qMNaWBZQpL+FQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbfJUNk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:40:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:42208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728083AbfJUNkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:40:25 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 291F521928;
        Mon, 21 Oct 2019 13:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571665224;
        bh=MgFhCNBcWt9mxbFfRHwAVC+7C4likEYyyKtp4ddhjMM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fJBPT2MoKrj4biPyxAPM5LDzshOgYcuAf+mKEMKoxNsDp4/q0gV3Y2FiTLQgvXRMQ
         KopktksYVeViiEENYOmsxmgXNSTJNqJEFott6TFVwS9H85SIGpvtgvmxjRg/gHE1l1
         7VQmrDb7hSuCmbcjRP/0QHaXSRs1dxfeClW5NLYk=
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
Subject: [PATCH 32/57] perf trace: Introduce 'struct evsel__trace' for evsel->priv needs
Date:   Mon, 21 Oct 2019 10:38:09 -0300
Message-Id: <20191021133834.25998-33-acme@kernel.org>
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
 tools/perf/builtin-trace.c | 54 +++++++++++++++++++++++++++++++++-----
 1 file changed, 48 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 1d2ed2823202..5792278065f6 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -285,21 +285,47 @@ struct syscall_tp {
 	};
 };
 
+/*
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
 /*
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
-- 
2.21.0

