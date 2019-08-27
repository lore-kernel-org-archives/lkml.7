Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9022CC3A5A4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48A092173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566869905;
	bh=I7ubcdmLXwxkDg/lL/+K7pzEiMBpYJPmkHTiPqmZOKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sShn6j7j4G0SYNAcNQIjVw2qnlKxvdwlS3qfgDivKMWGVxjCxWxIItSLPSNoOm+PE
	 g63unM8ImL9VImenkDNYWGKtd9PkZJZN8LIFRQBtyWzWB9shs2QuoXyM104xtqjMdI
	 XQL0sSKIKQdt6S5vwqCuq/K+iDS5JEa/P/S2lR0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbfH0BiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 21:38:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:51492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728702AbfH0BiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 21:38:20 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 417742080C;
        Tue, 27 Aug 2019 01:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566869899;
        bh=I7ubcdmLXwxkDg/lL/+K7pzEiMBpYJPmkHTiPqmZOKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nJyMG0KNPAhGNg9lUgcUCSLuwHCyFGT5AfN1LX/7V4gu2Cq1sIEpIU6ys0ke1vFzh
         ztiyxGTHot/uiuRI690JJWeTCfhxpClQJz30icq1RCs58YeyYL+1ksPRC0xkW32efT
         yAbk5JnN8rvOKQ12A01h4f9M1hvoU/7CZOvwqunk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH 32/33] perf tool: Rename perf_tool::bpf_event to bpf
Date:   Mon, 26 Aug 2019 22:36:33 -0300
Message-Id: <20190827013634.3173-33-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190827013634.3173-1-acme@kernel.org>
References: <20190827013634.3173-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

No need for that _event suffix, do just like all the other meta event
handlers and suppress that suffix.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Link: https://lkml.kernel.org/n/tip-03spzxtqafbabbbmnm7y4xfx@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c |  4 ++--
 tools/perf/util/bpf-event.c | 11 +++++------
 tools/perf/util/bpf-event.h | 10 +++++-----
 tools/perf/util/event.c     | 14 +++++++-------
 tools/perf/util/event.h     | 10 +++++-----
 tools/perf/util/machine.c   |  2 +-
 tools/perf/util/session.c   |  6 +++---
 tools/perf/util/tool.h      |  2 +-
 8 files changed, 29 insertions(+), 30 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 6f389b33fbe5..51e7e6d0eee6 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2492,8 +2492,8 @@ static int __cmd_script(struct perf_script *script)
 		script->tool.finished_round = process_finished_round_event;
 	}
 	if (script->show_bpf_events) {
-		script->tool.ksymbol   = process_bpf_events;
-		script->tool.bpf_event = process_bpf_events;
+		script->tool.ksymbol = process_bpf_events;
+		script->tool.bpf     = process_bpf_events;
 	}
 
 	if (perf_script__setup_per_event_dump(script)) {
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 28fa2b1ce66e..2d6d500c9af7 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -64,12 +64,11 @@ static int machine__process_bpf_event_load(struct machine *machine,
 	return 0;
 }
 
-int machine__process_bpf_event(struct machine *machine __maybe_unused,
-			       union perf_event *event,
-			       struct perf_sample *sample __maybe_unused)
+int machine__process_bpf(struct machine *machine, union perf_event *event,
+			 struct perf_sample *sample)
 {
 	if (dump_trace)
-		perf_event__fprintf_bpf_event(event, stdout);
+		perf_event__fprintf_bpf(event, stdout);
 
 	switch (event->bpf.type) {
 	case PERF_BPF_EVENT_PROG_LOAD:
@@ -83,7 +82,7 @@ int machine__process_bpf_event(struct machine *machine __maybe_unused,
 		 */
 		break;
 	default:
-		pr_debug("unexpected bpf_event type of %d\n", event->bpf.type);
+		pr_debug("unexpected bpf event type of %d\n", event->bpf.type);
 		break;
 	}
 	return 0;
@@ -410,7 +409,7 @@ static int bpf_event__sb_cb(union perf_event *event, void *data)
 		 */
 		break;
 	default:
-		pr_debug("unexpected bpf_event type of %d\n", event->bpf.type);
+		pr_debug("unexpected bpf event type of %d\n", event->bpf.type);
 		break;
 	}
 
diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
index 26ab9239f986..417b78835ea0 100644
--- a/tools/perf/util/bpf-event.h
+++ b/tools/perf/util/bpf-event.h
@@ -30,8 +30,8 @@ struct btf_node {
 };
 
 #ifdef HAVE_LIBBPF_SUPPORT
-int machine__process_bpf_event(struct machine *machine, union perf_event *event,
-			       struct perf_sample *sample);
+int machine__process_bpf(struct machine *machine, union perf_event *event,
+			 struct perf_sample *sample);
 
 int perf_event__synthesize_bpf_events(struct perf_session *session,
 				      perf_event__handler_t process,
@@ -43,9 +43,9 @@ void bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
 				    struct perf_env *env,
 				    FILE *fp);
 #else
-static inline int machine__process_bpf_event(struct machine *machine __maybe_unused,
-					     union perf_event *event __maybe_unused,
-					     struct perf_sample *sample __maybe_unused)
+static inline int machine__process_bpf(struct machine *machine __maybe_unused,
+				       union perf_event *event __maybe_unused,
+				       struct perf_sample *sample __maybe_unused)
 {
 	return 0;
 }
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 17304df44fc2..33616ea62a47 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1343,12 +1343,12 @@ int perf_event__process_ksymbol(struct perf_tool *tool __maybe_unused,
 	return machine__process_ksymbol(machine, event, sample);
 }
 
-int perf_event__process_bpf_event(struct perf_tool *tool __maybe_unused,
-				  union perf_event *event,
-				  struct perf_sample *sample __maybe_unused,
-				  struct machine *machine)
+int perf_event__process_bpf(struct perf_tool *tool __maybe_unused,
+			    union perf_event *event,
+			    struct perf_sample *sample,
+			    struct machine *machine)
 {
-	return machine__process_bpf_event(machine, event, sample);
+	return machine__process_bpf(machine, event, sample);
 }
 
 size_t perf_event__fprintf_mmap(union perf_event *event, FILE *fp)
@@ -1491,7 +1491,7 @@ size_t perf_event__fprintf_ksymbol(union perf_event *event, FILE *fp)
 		       event->ksymbol.flags, event->ksymbol.name);
 }
 
-size_t perf_event__fprintf_bpf_event(union perf_event *event, FILE *fp)
+size_t perf_event__fprintf_bpf(union perf_event *event, FILE *fp)
 {
 	return fprintf(fp, " type %u, flags %u, id %u\n",
 		       event->bpf.type, event->bpf.flags, event->bpf.id);
@@ -1536,7 +1536,7 @@ size_t perf_event__fprintf(union perf_event *event, FILE *fp)
 		ret += perf_event__fprintf_ksymbol(event, fp);
 		break;
 	case PERF_RECORD_BPF_EVENT:
-		ret += perf_event__fprintf_bpf_event(event, fp);
+		ret += perf_event__fprintf_bpf(event, fp);
 		break;
 	default:
 		ret += fprintf(fp, "\n");
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 7251e2eee441..429a3fe52d6c 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -683,10 +683,10 @@ int perf_event__process_ksymbol(struct perf_tool *tool,
 				union perf_event *event,
 				struct perf_sample *sample,
 				struct machine *machine);
-int perf_event__process_bpf_event(struct perf_tool *tool,
-				  union perf_event *event,
-				  struct perf_sample *sample,
-				  struct machine *machine);
+int perf_event__process_bpf(struct perf_tool *tool,
+			    union perf_event *event,
+			    struct perf_sample *sample,
+			    struct machine *machine);
 int perf_tool__process_synth_event(struct perf_tool *tool,
 				   union perf_event *event,
 				   struct machine *machine,
@@ -751,7 +751,7 @@ size_t perf_event__fprintf_thread_map(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_cpu_map(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_namespaces(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_ksymbol(union perf_event *event, FILE *fp);
-size_t perf_event__fprintf_bpf_event(union perf_event *event, FILE *fp);
+size_t perf_event__fprintf_bpf(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf(union perf_event *event, FILE *fp);
 
 int kallsyms__get_function_start(const char *kallsyms_filename,
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 86b7fd24b1e1..93483f1764d3 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1922,7 +1922,7 @@ int machine__process_event(struct machine *machine, union perf_event *event,
 	case PERF_RECORD_KSYMBOL:
 		ret = machine__process_ksymbol(machine, event, sample); break;
 	case PERF_RECORD_BPF_EVENT:
-		ret = machine__process_bpf_event(machine, event, sample); break;
+		ret = machine__process_bpf(machine, event, sample); break;
 	default:
 		ret = -1;
 		break;
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 4bfec9db36d6..5786e9c807c5 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -473,8 +473,8 @@ void perf_tool__fill_defaults(struct perf_tool *tool)
 		tool->context_switch = perf_event__process_switch;
 	if (tool->ksymbol == NULL)
 		tool->ksymbol = perf_event__process_ksymbol;
-	if (tool->bpf_event == NULL)
-		tool->bpf_event = perf_event__process_bpf_event;
+	if (tool->bpf == NULL)
+		tool->bpf = perf_event__process_bpf;
 	if (tool->read == NULL)
 		tool->read = process_event_sample_stub;
 	if (tool->throttle == NULL)
@@ -1452,7 +1452,7 @@ static int machines__deliver_event(struct machines *machines,
 	case PERF_RECORD_KSYMBOL:
 		return tool->ksymbol(tool, event, sample, machine);
 	case PERF_RECORD_BPF_EVENT:
-		return tool->bpf_event(tool, event, sample, machine);
+		return tool->bpf(tool, event, sample, machine);
 	default:
 		++evlist->stats.nr_unknown_events;
 		return -1;
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index 7f95dd1d6883..2abbf668b8de 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -56,7 +56,7 @@ struct perf_tool {
 			throttle,
 			unthrottle,
 			ksymbol,
-			bpf_event;
+			bpf;
 
 	event_attr_op	attr;
 	event_attr_op	event_update;
-- 
2.21.0

