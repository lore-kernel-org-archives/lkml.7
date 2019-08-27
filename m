Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2841C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C19C12173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbfH0I05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:26:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42868 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730116AbfH0I0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:26:40 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2Wo8-0007yQ-Kl; Tue, 27 Aug 2019 10:26:28 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DD9191C0DDE;
        Tue, 27 Aug 2019 10:26:24 +0200 (CEST)
Date:   Tue, 27 Aug 2019 08:26:24 -0000
From:   tip-bot2 for Arnaldo Carvalho de Melo <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf tools: Rename perf_event::bpf_event to perf_event::bpf
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-505qwpaizq1k0t6pk13v1ibd@git.kernel.org>
References: <tip-505qwpaizq1k0t6pk13v1ibd@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156689438482.24565.8439004528106816385.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     6a1b359821eb8d929c4dd9f53178da84888d79ec
Gitweb:        https://git.kernel.org/tip/6a1b359821eb8d929c4dd9f53178da84888d79ec
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 26 Aug 2019 19:20:35 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 26 Aug 2019 19:39:11 -03:00

perf tools: Rename perf_event::bpf_event to perf_event::bpf

Just like all the other meta events, that extra _event suffix is just
redundant, ditch it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Link: https://lkml.kernel.org/n/tip-505qwpaizq1k0t6pk13v1ibd@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-event.c | 18 ++++++++----------
 tools/perf/util/event.c     |  3 +--
 tools/perf/util/event.h     |  2 +-
 3 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 69795c3..28fa2b1 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -35,7 +35,7 @@ static int machine__process_bpf_event_load(struct machine *machine,
 	struct bpf_prog_info_linear *info_linear;
 	struct bpf_prog_info_node *info_node;
 	struct perf_env *env = machine->env;
-	int id = event->bpf_event.id;
+	int id = event->bpf.id;
 	unsigned int i;
 
 	/* perf-record, no need to handle bpf-event */
@@ -71,7 +71,7 @@ int machine__process_bpf_event(struct machine *machine __maybe_unused,
 	if (dump_trace)
 		perf_event__fprintf_bpf_event(event, stdout);
 
-	switch (event->bpf_event.type) {
+	switch (event->bpf.type) {
 	case PERF_BPF_EVENT_PROG_LOAD:
 		return machine__process_bpf_event_load(machine, event, sample);
 
@@ -83,8 +83,7 @@ int machine__process_bpf_event(struct machine *machine __maybe_unused,
 		 */
 		break;
 	default:
-		pr_debug("unexpected bpf_event type of %d\n",
-			 event->bpf_event.type);
+		pr_debug("unexpected bpf_event type of %d\n", event->bpf.type);
 		break;
 	}
 	return 0;
@@ -162,7 +161,7 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
 					       struct record_opts *opts)
 {
 	struct perf_record_ksymbol *ksymbol_event = &event->ksymbol;
-	struct perf_record_bpf_event *bpf_event = &event->bpf_event;
+	struct perf_record_bpf_event *bpf_event = &event->bpf;
 	struct bpf_prog_info_linear *info_linear;
 	struct perf_tool *tool = session->tool;
 	struct bpf_prog_info_node *info_node;
@@ -302,7 +301,7 @@ int perf_event__synthesize_bpf_events(struct perf_session *session,
 	int err;
 	int fd;
 
-	event = malloc(sizeof(event->bpf_event) + KSYM_NAME_LEN + machine->id_hdr_size);
+	event = malloc(sizeof(event->bpf) + KSYM_NAME_LEN + machine->id_hdr_size);
 	if (!event)
 		return -1;
 	while (true) {
@@ -399,9 +398,9 @@ static int bpf_event__sb_cb(union perf_event *event, void *data)
 	if (event->header.type != PERF_RECORD_BPF_EVENT)
 		return -1;
 
-	switch (event->bpf_event.type) {
+	switch (event->bpf.type) {
 	case PERF_BPF_EVENT_PROG_LOAD:
-		perf_env__add_bpf_info(env, event->bpf_event.id);
+		perf_env__add_bpf_info(env, event->bpf.id);
 
 	case PERF_BPF_EVENT_PROG_UNLOAD:
 		/*
@@ -411,8 +410,7 @@ static int bpf_event__sb_cb(union perf_event *event, void *data)
 		 */
 		break;
 	default:
-		pr_debug("unexpected bpf_event type of %d\n",
-			 event->bpf_event.type);
+		pr_debug("unexpected bpf_event type of %d\n", event->bpf.type);
 		break;
 	}
 
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index bdeaad4..17304df 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1494,8 +1494,7 @@ size_t perf_event__fprintf_ksymbol(union perf_event *event, FILE *fp)
 size_t perf_event__fprintf_bpf_event(union perf_event *event, FILE *fp)
 {
 	return fprintf(fp, " type %u, flags %u, id %u\n",
-		       event->bpf_event.type, event->bpf_event.flags,
-		       event->bpf_event.id);
+		       event->bpf.type, event->bpf.flags, event->bpf.id);
 }
 
 size_t perf_event__fprintf(union perf_event *event, FILE *fp)
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 34190e0..7251e2e 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -560,7 +560,7 @@ union perf_event {
 	struct perf_record_read		read;
 	struct perf_record_throttle	throttle;
 	struct perf_record_sample	sample;
-	struct perf_record_bpf_event	bpf_event;
+	struct perf_record_bpf_event	bpf;
 	struct perf_record_ksymbol	ksymbol;
 	struct attr_event		attr;
 	struct event_update_event	event_update;
