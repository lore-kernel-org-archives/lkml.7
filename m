Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A62C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEEB7214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570824492;
	bh=cfmMiJ6AVth5JTIKomh80orpNsq+B/rzgUUAlOdReiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gwp3e4Gh9ZmfmMWp7U1V+NTuW/gOycwrkbWWpd4wX9SHFW69yuOkyuRsJgkzj0dIH
	 nlOEd33RNuaEcTAvnucsEFAla3qFFrRKTN8UpcAveUDofyhYuj1OAYOz1CCPZYINoA
	 drEx5n9naYHoD+1tDeDQl7gad2qsJS4J1eTyAgiM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbfJKUIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:08:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729032AbfJKUIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:08:11 -0400
Received: from quaco.ghostprotocols.net (189-94-137-67.3g.claro.net.br [189.94.137.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5684A21835;
        Fri, 11 Oct 2019 20:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570824490;
        bh=cfmMiJ6AVth5JTIKomh80orpNsq+B/rzgUUAlOdReiE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ofm6qOJvGtKZYy2/NxuU9veUNefueq+MMoBM0cxLOj+EV1CXt7nfrw4IVHvccY7Ea
         vw9Av8Q+edpZR+o5YPbebtk9qmB1rWJc5FKF108aEkQw3lQ/xJ8g5308vn+NqPAt7C
         nCvV8SG5fMAp8dCG4itfl2+VajuX67/43lueRp6M=
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
Subject: [PATCH 19/69] perf trace: Allocate an array of beautifiers for tracepoint args
Date:   Fri, 11 Oct 2019 17:05:09 -0300
Message-Id: <20191011200559.7156-20-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011200559.7156-1-acme@kernel.org>
References: <20191011200559.7156-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
index d52dd2bad980..aa70602c2808 100644
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
-- 
2.21.0

