Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F753C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9276218D4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbfCVWid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:38:33 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52945 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfCVWic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:38:32 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MMbwaL754821
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:37:58 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MMbub9754813;
        Fri, 22 Mar 2019 15:37:56 -0700
Date:   Fri, 22 Mar 2019 15:37:56 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Song Liu <tipbot@zytor.com>
Message-ID: <tip-e5416950454fa79b7bdc86dac45661b97d887c97@git.kernel.org>
Cc:     jolsa@kernel.org, acme@redhat.com, mingo@kernel.org,
        peterz@infradead.org, sdf@google.com, songliubraving@fb.com,
        namhyung@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        daniel@iogearbox.net, tglx@linutronix.de, ast@kernel.org
Reply-To: ast@kernel.org, hpa@zytor.com, namhyung@kernel.org,
          tglx@linutronix.de, daniel@iogearbox.net, songliubraving@fb.com,
          sdf@google.com, linux-kernel@vger.kernel.org,
          peterz@infradead.org, mingo@kernel.org, acme@redhat.com,
          jolsa@kernel.org
In-Reply-To: <20190312053051.2690567-6-songliubraving@fb.com>
References: <20190312053051.2690567-6-songliubraving@fb.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf bpf: Make synthesize_bpf_events() receive
 perf_session pointer instead of perf_tool
Git-Commit-ID: e5416950454fa79b7bdc86dac45661b97d887c97
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  e5416950454fa79b7bdc86dac45661b97d887c97
Gitweb:     https://git.kernel.org/tip/e5416950454fa79b7bdc86dac45661b97d887c97
Author:     Song Liu <songliubraving@fb.com>
AuthorDate: Mon, 11 Mar 2019 22:30:41 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 19 Mar 2019 16:52:06 -0300

perf bpf: Make synthesize_bpf_events() receive perf_session pointer instead of perf_tool

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
@@ -175,7 +177,7 @@ out:
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
