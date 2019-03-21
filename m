Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4638C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D9D721925
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553194475;
	bh=AXUOBMgvz2SP8Qfg5yE7nw30gM2u5ssH/Ulh2VBwgQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f3CmBuxvFyQPxiI9tDt4qhtTwEw1IVTJZXaE1pzkzlHzd3K6zrx8tBxTw2xrxrqgX
	 XLloLGfc3ryuPrC254YDmRO1ru1ACZMBs/bCRjBUG6QyhtjzkHfHLWIp6cY2PCiXSJ
	 Jv1jwFHSLGyRs8/75TZNQZMyUpUeebCeLdtsKSd0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbfCUSye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:54:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728915AbfCUSyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:54:33 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97BCF205F4;
        Thu, 21 Mar 2019 18:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553194472;
        bh=AXUOBMgvz2SP8Qfg5yE7nw30gM2u5ssH/Ulh2VBwgQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OYHkV1DxoV2Ocqtqf6v3WpDJOFR2zPurKBqll56RSbF8b5y3FtjtkPsLBSVIavyVf
         8T02Chnh5sSQAAfA+hetXHz5bK56Bx1uuAgHaqtmsMbkee/yYrGodNnQIWSouhSVLm
         6teCkYDEDPWf6Ag+W45u6PQaByc3JBipJQ17AbxI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Stanislav Fomichev <sdf@google.com>, kernel-team@fb.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 30/44] perf bpf: Make synthesize_bpf_events() receive perf_session pointer instead of perf_tool
Date:   Thu, 21 Mar 2019 15:51:28 -0300
Message-Id: <20190321185142.11441-31-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190321185142.11441-1-acme@kernel.org>
References: <20190321185142.11441-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Song Liu <songliubraving@fb.com>

This patch changes the arguments of perf_event__synthesize_bpf_events()
to include perf_session* instead of perf_tool*. perf_session will be
used in the next patch.

Signed-off-by: Song Liu <songliubraving@fb.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: kernel-team@fb.com
Link: http://lkml.kernel.org/r/20190312053051.2690567-6-songliubraving@fb.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 2 +-
 tools/perf/builtin-top.c    | 2 +-
 tools/perf/util/bpf-event.c | 8 +++++---
 tools/perf/util/bpf-event.h | 4 ++--
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index f29874192d3e..e79faccd7842 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1114,7 +1114,7 @@ static int record__synthesize(struct record *rec, bool tail)
 		return err;
 	}
 
-	err = perf_event__synthesize_bpf_events(tool, process_synthesized_event,
+	err = perf_event__synthesize_bpf_events(session, process_synthesized_event,
 						machine, opts);
 	if (err < 0)
 		pr_warning("Couldn't synthesize bpf events.\n");
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 2508a7a552fa..77e6190211d2 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1208,7 +1208,7 @@ static int __cmd_top(struct perf_top *top)
 
 	init_process_thread(top);
 
-	ret = perf_event__synthesize_bpf_events(&top->tool, perf_event__process,
+	ret = perf_event__synthesize_bpf_events(top->session, perf_event__process,
 						&top->session->machines.host,
 						&top->record_opts);
 	if (ret < 0)
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index e0cbe7f87170..5237e8f11997 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -10,6 +10,7 @@
 #include "debug.h"
 #include "symbol.h"
 #include "machine.h"
+#include "session.h"
 
 #define ptr_to_u64(ptr)    ((__u64)(unsigned long)(ptr))
 
@@ -42,7 +43,7 @@ int machine__process_bpf_event(struct machine *machine __maybe_unused,
  *   -1 for failures;
  *   -2 for lack of kernel support.
  */
-static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
+static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
 					       perf_event__handler_t process,
 					       struct machine *machine,
 					       int fd,
@@ -52,6 +53,7 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
 	struct ksymbol_event *ksymbol_event = &event->ksymbol_event;
 	struct bpf_event *bpf_event = &event->bpf_event;
 	struct bpf_prog_info_linear *info_linear;
+	struct perf_tool *tool = session->tool;
 	struct bpf_prog_info *info;
 	struct btf *btf = NULL;
 	bool has_btf = false;
@@ -175,7 +177,7 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
 	return err ? -1 : 0;
 }
 
-int perf_event__synthesize_bpf_events(struct perf_tool *tool,
+int perf_event__synthesize_bpf_events(struct perf_session *session,
 				      perf_event__handler_t process,
 				      struct machine *machine,
 				      struct record_opts *opts)
@@ -209,7 +211,7 @@ int perf_event__synthesize_bpf_events(struct perf_tool *tool,
 			continue;
 		}
 
-		err = perf_event__synthesize_one_bpf_prog(tool, process,
+		err = perf_event__synthesize_one_bpf_prog(session, process,
 							  machine, fd,
 							  event, opts);
 		close(fd);
diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
index 7890067e1a37..6698683612a7 100644
--- a/tools/perf/util/bpf-event.h
+++ b/tools/perf/util/bpf-event.h
@@ -15,7 +15,7 @@ struct record_opts;
 int machine__process_bpf_event(struct machine *machine, union perf_event *event,
 			       struct perf_sample *sample);
 
-int perf_event__synthesize_bpf_events(struct perf_tool *tool,
+int perf_event__synthesize_bpf_events(struct perf_session *session,
 				      perf_event__handler_t process,
 				      struct machine *machine,
 				      struct record_opts *opts);
@@ -27,7 +27,7 @@ static inline int machine__process_bpf_event(struct machine *machine __maybe_unu
 	return 0;
 }
 
-static inline int perf_event__synthesize_bpf_events(struct perf_tool *tool __maybe_unused,
+static inline int perf_event__synthesize_bpf_events(struct perf_session *session __maybe_unused,
 						    perf_event__handler_t process __maybe_unused,
 						    struct machine *machine __maybe_unused,
 						    struct record_opts *opts __maybe_unused)
-- 
2.20.1

