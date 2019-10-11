Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57892C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29A5021D7C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570824514;
	bh=csp2h+xmgFZqrPRueswUCIuEVUpmQcPKyZyQggPspuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hQDmihji9AVTpTbYK/YJe5pRI8pB5alnB1n6IKRM0VScaAvuD58FbbsfD4Heop3/2
	 GqJrBjmJmkJy2v9tFI4f6HjQL0ToChaHTOdcYtBwWsFkH+D5KHHbBMNDpVwG0uumo7
	 SOiKHk7R4IQ/Xb11lt7fLMAhAFvu46g/JAN0LXuQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbfJKUIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:08:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:44374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729032AbfJKUIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:08:32 -0400
Received: from quaco.ghostprotocols.net (189-94-137-67.3g.claro.net.br [189.94.137.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FFAB21D7D;
        Fri, 11 Oct 2019 20:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570824511;
        bh=csp2h+xmgFZqrPRueswUCIuEVUpmQcPKyZyQggPspuc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TTxjN+MWdUL0oWWkAgC22TCE5C8m1c1ooXvgvgcwwg6uorovdorM7VaN1LEN4eQ3m
         EisOSp0ZeuMhVpVQeqppkD8cUSPQ4vLzXB58to+/AO6KiQQ8mqdv8fevRUNHdK9HNs
         +0S1LuN6cVq+YGaCLuX5oEqYbXSM0wap+hxJ63q8=
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
Subject: [PATCH 23/69] perf trace: Enclose all events argument lists with ()
Date:   Fri, 11 Oct 2019 17:05:13 -0300
Message-Id: <20191011200559.7156-24-acme@kernel.org>
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
index b3fb208cbd30..297aeaa9f69d 100644
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
-- 
2.21.0

